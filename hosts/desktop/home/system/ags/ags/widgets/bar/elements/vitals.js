const cpu = Variable(0, {
  poll: [
    1000,
    'top -b -n 1',
    (out) =>
      Number.parseInt(
        out
          .split('\n')
          .find((line) => line.includes('Cpu(s)'))
          ?.split(/\s+/)[1]
          .replace(',', '.') ?? '0'
      ) / 100,
  ],
})
const ram = Variable([0, 0], {
  poll: [
    1000,
    'free -b',
    (out) =>
      out
        .split('\n')
        .find((line) => line.includes('Mem:'))
        ?.split(/\s+/)
        .splice(1, 2)
        .map((elem) => parseInt(elem)) ?? [0, 0],
  ],
})
const disk = Variable([0, 0], {
  poll: [
    1000,
    'df -B 1',
    (out) =>
      out
        .split('\n')
        .find((line) => line.includes('/dev/disk/by-label/ROOT'))
        ?.split(/\s+/)
        .splice(1, 2)
        .map((elem) => parseInt(elem)) ?? [0, 0],
  ],
})

function element(value, tooltip, emoji) {
  return Widget.CircularProgress({
    rounded: true,
    class_name: 'vitals-element',
    value: value,
    tooltip_text: tooltip,
    start_at: 0.75,
    child: Widget.Label({ label: emoji, css: 'font-size: 12px' }),
  })
}

export default function Vitals() {
  return Widget.Box({
    class_name: 'panel-element',
    spacing: 5,
    children: [
      element(
        cpu.bind(),
        cpu.bind().as((c) => `${Math.round(c * 100)}%`),
        ''
      ),
      element(
        ram.bind().as((r) => r[1] / r[0]),
        ram.bind().as((r) => `${Math.round(r[1] / 10 ** 9)} / ${Math.round(r[0] / 10 ** 9)} GB`),
        ''
      ),
      element(
        disk.bind().as((d) => d[1] / d[0]),
        disk.bind().as((d) => `${Math.round(d[1] / 10 ** 9)} / ${Math.round(d[0] / 10 ** 9)} GB`),
        ''
      ),
    ],
  })
}
