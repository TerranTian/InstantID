FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
COPY requirements.txt /root/requirements.txt

WORKDIR /app
RUN apt-get update && apt-get install python3 pip ffmpeg curl unzip -y
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -v --use-pep517 -r /root/requirements.txt

# RUN pip install -v --use-pep517 -r /root/requirements.txt
RUN cd /usr/local/lib/python3.10/dist-packages/torch/lib && ln -s libnvrtc-672ee683.so.11.2 libnvrtc.so

CMD uvicorn 'app:run' --port 8888 --reload --host 0.0.0.0


# docker build -t terran/instantid -f Dockerfile .