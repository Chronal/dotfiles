#! /usr/bin/env python
from pathlib import Path

import os
import logging

HOME_DIR = Path(os.environ["HOME"])
DOTFILE_DIR = Path(__file__).parent


LOGGER_FORMAT = "%(filename)s - %(levelname)s: %(message)s"
logger = logging.getLogger(__name__)
logging.basicConfig(format=LOGGER_FORMAT, filename="install.log", level=logging.DEBUG)


config_key = "XDG_CONFIG_HOME"
if config_key in os.environ:
    CONFIG_DIR = Path(os.environ[config_key])
    logger.info(f"XDG_CONFIG_HOME is defined: {CONFIG_DIR}")
else:
    CONFIG_DIR = HOME_DIR / ".config"

logger.info(f"Ensuring {CONFIG_DIR} exists")
CONFIG_DIR.mkdir(parents=True, exist_ok=True)

logger.info(f"Using DOTFILE_DIR: {DOTFILE_DIR}")
logger.info(f"Using CONFIG_DIR: {CONFIG_DIR}")

for item in DOTFILE_DIR.iterdir():
    name = item.name
    if not item.is_dir() or name.startswith("."):
        continue

    link_path = CONFIG_DIR / name

    if link_path.is_symlink():
        linked = link_path.readlink()
        logger.warning(f"Skipping symlink {link_path} -> {linked}")
        continue

    link_path.symlink_to(item, target_is_directory=True)
    logger.info(f"{link_path} is now a symlink to {item}")
