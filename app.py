#!/usr/bin/env python3
import logging
import argparse
from logging.handlers import TimedRotatingFileHandler

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

handler = TimedRotatingFileHandler(
    "app.log", when="midnight", interval=1, backupCount=5
)
handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s - %(message)s"))
logging.getLogger().addHandler(handler)

import os

os.environ["PYTORCH_CUDA_ALLOC_CONF"] = "max_split_size_mb:64"


from fastapi import FastAPI, Request

app = FastAPI()


# from gradio_demo.app import main as ui_creator

from gradio_demo.app_multicontrolnet import main as multicontrolnet_ui_creator

import gradio as gr

# ui = ui_creator()
# ui.title = "InstantID"

multicontrolnet_ui = multicontrolnet_ui_creator()
multicontrolnet_ui.title = "InstantID"
print("fuck ...")

# gr.mount_gradio_app(app, ui, path="/app")
gr.mount_gradio_app(app, multicontrolnet_ui, path="/app")


def run(arg_str=""):
    print("fuck3 %s" % arg_str)

    arr = []
    if type(arg_str) == str:
        arr = arg_str.split()

    # args = program.parse_args(arr)
    # pre_start(args)
    return app


if __name__ == "__main__":
    print("__main__ executed ... ")
