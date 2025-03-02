FROM python:3.9-bookworm

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install git+https://github.com/myshell-ai/MeloTTS.git
RUN python -m unidic download
# Download and extract checkpoints
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://myshell-public-repo-host.s3.amazonaws.com/openvoice/checkpoints_v2_0417.zip && \
    unzip checkpoints_v2_0417.zip && \
    rm checkpoints_v2_0417.zip && \
    apt-get remove -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Install ffmpeg
RUN apt-get update && apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . .
RUN python -m install_nltk

CMD ["python", "v2_script.py"]