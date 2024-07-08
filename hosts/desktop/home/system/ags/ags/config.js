import Bar from './widgets/bar/bar.js'
import { applauncher } from './applauncher.js'

App.config({
  windows: [applauncher, Bar()],
})
