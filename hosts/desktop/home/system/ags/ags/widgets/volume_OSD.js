const audio = await Service.import('audio')
let volume = audio.speaker.volume
let isMuted = audio.speaker.is_muted

let timeoutId
export function open() {
  if (timeoutId) {
    clearTimeout(timeoutId)
  }

  App.openWindow('volume_OSD')

  timeoutId = setTimeout(() => {
    App.closeWindow('volume_OSD')
  }, 2000)
}

export default function VolumeOSD() {
  return Widget.Window({
    name: 'volume_OSD',
    class_name: 'volume_OSD',
    monitor: 0,
    visible: false,
    anchor: ['bottom'],
    layer: 'overlay',
    margins: [0, 0, 70, 0],
    child: Widget.Box({
      class_name: 'volume-box',
      spacing: 10,
      children: [
        Widget.Label({
          class_name: 'volume-label',
          hpack: 'start',
          label: Utils.merge([audio.speaker.bind('volume'), audio.speaker.bind('is_muted')], (volume, isMuted) => ({ volume, isMuted })).as(
            ({ volume, isMuted }) => `${isMuted ? 'X' : volume === 0 ? '' : volume < 0.49 ? '' : ''} ${Math.round(volume * 100)}`
          ),
          xalign: 0,
        }),
        Widget.Slider({
          class_name: 'volume-slider',
          draw_value: false,
          hexpand: true,
          value: audio.speaker.bind('volume'),
          on_change: ({ value }) => {
            audio.speaker.volume = value
            open()
          },
        }),
      ],
    }),
  })
}
