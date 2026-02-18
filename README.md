# LLM Inference Engine
This repository contains the source code and the config files for LLM Inference Engine which is based on llama.cpp and built to be run on AMD Strix Halo Hardware with Vulkan backend.

## Components
- **Base Container Image**: I am planning to run the inference engine inside of a container, so the base container is built with all the necessary dependencies such as AMD drivers and Vulkan SDK.
- **LLM Inference Engine**: The main application that utilizes llama.cpp to perform inference. (in progress)
- **Monitoring Service**: Some sort of metrics collection tool to send data to LangFuse or Grafana. (in progress)

## Build Image
```bash
docker build -f base.dockerfile -t llm-inference-base .
```