FROM pytorch/pytorch:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential ffmpeg parallel aria2 && apt-get clean

COPY ./requirements.txt /workspace/requirements.txt

RUN pip install -r requirements.txt && pip install webrtcvad-wheels

COPY . /workspace

VOLUME [ "/datasets", "/workspace/data/ckpt/synthesizer/saved_models", "/workspace/data/ckpt/ppg_extractor", "/workspace/data/ckpt/ppg2mel" ]

ENV DATASET_MIRROR=default FORCE_RETRAIN=false TRAIN_DATASETS=aidatatang_200zh\ magicdata\ aishell3\ data_aishell TRAIN_SKIP_EXISTING=true

EXPOSE 8080

ENTRYPOINT [ "/workspace/docker-entrypoint.sh" ]
