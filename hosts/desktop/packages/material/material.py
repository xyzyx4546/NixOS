import os
import shutil
import argparse
from jinja2 import Template
from material_color_utilities_python import *
from PIL import Image

HOME_DIR = os.getenv("HOME")
SCRIPTS_DIR = f"{HOME_DIR}/.config/eww/scripts/material"
CONFIG_FILE = f"{SCRIPTS_DIR}/colors/current.json"
TEMPLATES = f"{SCRIPTS_DIR}/templates"
COLORS = f"{SCRIPTS_DIR}/colors"
WALLPAPER_PATH = f"{SCRIPTS_DIR}/colors/wall.png"

# ================================COLORS=================================================

def get_colors(colorscheme):
  colors = {
    "primary": hexFromArgb(colorscheme.get_primary()),
    "onPrimary": hexFromArgb(colorscheme.get_onPrimary()),
    "primaryContainer": hexFromArgb(colorscheme.get_primaryContainer()),
    "onPrimaryContainer": hexFromArgb(colorscheme.get_onPrimaryContainer()),
    "secondary": hexFromArgb(colorscheme.get_secondary()),
    "onSecondary": hexFromArgb(colorscheme.get_onSecondary()),
    "secondaryContainer": hexFromArgb(colorscheme.get_secondaryContainer()),
    "onSecondaryContainer": hexFromArgb(colorscheme.get_onSecondaryContainer()),
    "tertiary": hexFromArgb(colorscheme.get_tertiary()),
    "onTertiary": hexFromArgb(colorscheme.get_onTertiary()),
    "tertiaryContainer": hexFromArgb(colorscheme.get_tertiaryContainer()),
    "onTertiaryContainer": hexFromArgb(colorscheme.get_onTertiaryContainer()),
    "error": hexFromArgb(colorscheme.get_error()),
    "onError": hexFromArgb(colorscheme.get_onError()),
    "errorContainer": hexFromArgb(colorscheme.get_errorContainer()),
    "onErrorContainer": hexFromArgb(colorscheme.get_onErrorContainer()),
    "background": hexFromArgb(colorscheme.get_background()),
    "onBackground": hexFromArgb(colorscheme.get_onBackground()),
    "surface": hexFromArgb(colorscheme.get_surface()),
    "onSurface": hexFromArgb(colorscheme.get_onSurface()),
    "surfaceVariant": hexFromArgb(colorscheme.get_surfaceVariant()),
    "onSurfaceVariant": hexFromArgb(colorscheme.get_onSurfaceVariant()),
    "outline": hexFromArgb(colorscheme.get_outline()),
    "shadow": hexFromArgb(colorscheme.get_shadow()),
    "inverseSurface": hexFromArgb(colorscheme.get_inverseSurface()),
    "inverseOnSurface": hexFromArgb(colorscheme.get_inverseOnSurface()),
    "inversePrimary": hexFromArgb(colorscheme.get_inversePrimary())
  }
  return colors

def get_colors_from_img(image):
  img = Image.open(image)
  basewidth = 64
  wpercent = (basewidth/float(img.size[0]))
  hsize = int((float(img.size[1])*float(wpercent)))
  img = img.resize((basewidth,hsize),Image.Resampling.LANCZOS)
  theme = themeFromImage(img)
  colorscheme = theme.get('schemes').get('dark')

  colors = get_colors(colorscheme)
  return colors

# ================================GENERAL OPERATIONS=================================================

def render_templates(colors_list):
  for template in os.listdir(TEMPLATES):
    print(f"Rendering {template}")
    with open(f"{TEMPLATES}/{template}", "r") as file:
      template_rendered = Template(file.read()).render(colors_list)
    with open(f"{COLORS}/{template}", "w") as output_file:
      output_file.write(template_rendered)

def setup(img):
  try:
    shutil.copyfile(img, WALLPAPER_PATH)
  except shutil.SameFileError:
    pass
  os.system("pkill -SIGUSR1 kitty")
  os.system("gradience-cli apply -p ~/.config/eww/scripts/material/colors/colors-gradience.json --gtk both")
  os.system(f"swww img {WALLPAPER_PATH} --transition-fps 75 --transition-type wipe --transition-duration 2")

def main(colors, image):
  render_templates(colors)
  setup(image)

# ================================CLI=================================================

if __name__ == "__main__":
  parser = argparse.ArgumentParser(description="Generate material colors on fly")

  parser.add_argument("IMAGE", type=str, help="Generate color scheme based on an image file.")

  args = parser.parse_args()

  colors = get_colors_from_img(args.IMAGE)
  main(colors, args.IMAGE)