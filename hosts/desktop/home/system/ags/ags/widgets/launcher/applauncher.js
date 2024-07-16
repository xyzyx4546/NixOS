const { query } = await Service.import('applications')
let applications = query('').map(AppItem)

const entry = Widget.Entry({
  class_name: 'applauncher-entry',
  on_accept: () => {
    const results = applications.filter((item) => item.visible)
    if (results[0]) {
      App.toggleWindow('applauncher')
      results[0].attribute.app.launch()
    }
  },
  on_change: ({ text }) =>
    applications.forEach((item) => {
      item.visible = item.attribute.app.match(text ?? '')
    }),
})

const app_items = Widget.Box({
  vertical: true,
  spacing: 5,
  children: applications,
})
function AppItem(app) {
  return Widget.Button({
    class_name: 'app',
    on_clicked: () => {
      App.closeWindow('applauncher')
      app.launch()
    },
    attribute: { app },
    child: Widget.Box({
      spacing: 5,
      children: [
        Widget.Icon({
          icon: app.icon_name || '',
          size: 30,
        }),
        Widget.Label({
          class_name: 'title',
          label: app.name,
          xalign: 0,
          vpack: 'center',
          truncate: 'end',
        }),
      ],
    }),
  })
}

export default function Applauncher() {
  return Widget.Window({
    name: 'applauncher',
    monitor: 0,
    class_name: 'applauncher',
    setup: (self) =>
      self.keybind('Escape', () => {
        App.closeWindow('applauncher')
      }),
    visible: false,
    keymode: 'exclusive',
    child: Widget.Box({
      vertical: true,
      children: [
        entry,
        Widget.Scrollable({
          class_name: 'applist',
          vscroll: 'external',
          hscroll: 'never',
          child: app_items,
        }),
      ],
      setup: (self) =>
        self.hook(App, (_, windowName, visible) => {
          if (windowName !== 'applauncher') return

          if (visible) {
            applications = query('').map(AppItem)
            app_items.children = applications
            entry.text = ''
            entry.grab_focus()
          }
        }),
    }),
  })
}
