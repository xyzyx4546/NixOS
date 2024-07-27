import argparse
import subprocess
import json
from material_color_utilities_python import *

def get_workspaces(monitor):
  result = subprocess.run(['hyprctl', '-j', 'workspaces'], capture_output=True, text=True)
  workspaces = json.loads(result.stdout)

  if monitor is not None:
      workspaces = [w for w in workspaces if w['monitorID'] == monitor]
  
  return workspaces

def get_new_workspace():
  workspaces = get_workspaces(0)
  last_workspace = workspaces[-1]
  return last_workspace['id'] + 1


if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("OPTION")
  OPTION = parser.parse_args().OPTION

  if OPTION == "focus_new":
    subprocess.run(['hyprctl', 'dispatch', 'workspace', str(get_new_workspace())])
  
  elif OPTION == "move_to_new":
    subprocess.run(['hyprctl', 'dispatch', 'movetoworkspace', str(get_new_workspace())])

  elif OPTION == "browser":
    subprocess.run(['hyprctl', 'dispatch', 'workspace', '98'])