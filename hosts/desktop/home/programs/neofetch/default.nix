{ pkgs, ... }: {
  home.packages = with pkgs; [ neofetch ];

  xdg.configFile."neofetch/config.conf".text = ''
    print_info() {
        info title
        info underline
        info "OS" distro
        info "Packages" packages
        info "Shell" shell
        info "DE" de
        info "Terminal" term
        info "Memory" memory
    }

    title_fqdn="off"
    kernel_shorthand="on"
    distro_shorthand="on"
    os_arch="off"
    uptime_shorthand="on"
    memory_percent="off"
    memory_unit="mib"
    package_managers="off"
    shell_path="off"
    shell_version="off"
    speed_type="bios_limit"
    speed_shorthand="off"
    cpu_brand="on"
    cpu_speed="on"
    cpu_cores="logical"
    cpu_temp="off"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="off"
    gtk_shorthand="off"
    gtk2="on"
    gtk3="on"
    public_ip_host="http://ident.me"
    public_ip_timeout=2
    de_version="on"
    disk_show=('/')
    disk_subtitle="mount"
    disk_percent="on"
    music_player="auto"
    song_format="%artist% - %album% - %title%"
    song_shorthand="off"
    mpc_args=()
    colors=(distro)
    bold="on"
    underline_enabled="off"
    underline_char="/"
    separator=":"
    block_range=(0 15)
    color_blocks="off"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    cpu_display="off"
    memory_display="off"
    battery_display="off"
    disk_display="off"
    image_backend="ascii"
    image_source="auto"
    # ascii_distro=(distro)
    ascii_colors=(distro)
    ascii_bold="on"
    image_loop="off"
    thumbnail_dir="~/.cache/thumbnails/neofetch"
    crop_mode="normal"
    crop_offset="center"
    image_size="auto"
    gap=3
    yoffset=0
  '';
}
