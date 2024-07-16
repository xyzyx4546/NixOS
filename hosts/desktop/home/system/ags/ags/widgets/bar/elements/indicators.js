const mpris = await Service.import('mpris')
const network = await Service.import('network')
const audio = await Service.import('audio')
const notifications = await Service.import('notifications')

const notification_center_revealed = Variable(false)

let intervalId
function openNotificationCenter() {
  if (notification_center_revealed.value) {
    notification_center_revealed.setValue(false)
    App.closeWindow('notification_center')
    if (intervalId) clearInterval(intervalId)
    return
  }

  notification_center_revealed.setValue(true)
  App.openWindow('notification_center')

  Utils.timeout(100, () => {
    intervalId = setInterval(() => {
      const position = JSON.parse(Utils.exec('hyprctl -j layers'))['DP-3']['levels']['2'].find((layer) => layer.namespace === 'notification_center')

      const cursor_pos = JSON.parse(Utils.exec('hyprctl -j cursorpos'))
      if (cursor_pos.y > position.y + position.h || cursor_pos.x < position.x) {
        notification_center_revealed.setValue(false)
        App.closeWindow('notification_center')
        clearInterval(intervalId)
      }
    }, 100)
  })
}

function element(icon, tooltip, visible) {
  return Widget.Revealer({
    transition: 'slide_left',
    reveal_child: visible,
    child: Widget.Label({
      class_name: notification_center_revealed.bind().as((s) => `sysmenu-element ${s === true ? 'revealed' : ''}`),
      tooltip_text: tooltip,
      label: icon,
    }),
  })
}

export default function Indicators() {
  return Widget.Button({
    class_name: notification_center_revealed.bind().as((s) => `sysmenu ${s === true ? 'revealed' : ''}`),
    on_clicked: () => openNotificationCenter(),
    child: Widget.Box({
      children: [
        element(
          Utils.watch(mpris.players[0]?.play_back_status === 'Playing' ? '' : '', mpris, () =>
            mpris.players[0]?.play_back_status === 'Playing' ? '' : ''
          ),
          'Music Player',
          mpris.bind('players').as((p) => p.length > 0)
        ),
        element(
          network.bind('connectivity').as((n) => (n !== 'none' ? '' : '')),
          '',
          true
        ),
        element(
          Utils.merge([audio.speaker.bind('volume'), audio.speaker.bind('is_muted')], (volume, isMuted) => ({ volume, isMuted })).as(
            ({ volume, isMuted }) => (isMuted ? 'X' : volume === 0 ? '' : volume < 0.49 ? '' : '')
          ),
          audio.speaker.bind('volume').as((v) => `Volume: ${Math.round(v * 100)}%`),
          true
        ),
        element(
          '',
          notifications.bind('notifications').as((n) => n.length.toString()),
          notifications.bind('notifications').as((n) => n.length > 0)
        ),
      ],
    }),
  })
}
