import Bar from './widgets/bar/bar.js'
import Applauncher from './widgets/launcher/applauncher.js'
import VolumeOSD from './widgets/volume_OSD.js'
import NotificationPopups from './widgets/notifications/popups.js'
import NotificationCenter from './widgets/notifications/center.js'

import applyCss from './applyCss.js'
applyCss()

App.config({
  icons: './icons',
  windows: [Bar(), Applauncher(), VolumeOSD(), NotificationPopups(), NotificationCenter()],
})
