# LLM Inference Engine
This repository contains the source code and the config files for LLM Inference Engine which is based on llama.cpp and built to be run on AMD Strix Halo Hardware with Vulkan backend.

## Components
- **Base Container Image**: I am planning to run the inference engine inside of a container, so the base container is built with all the necessary dependencies such as AMD drivers and Vulkan SDK.
- **LLM Inference Engine**: The main application that utilizes llama.cpp to perform inference. (in progress)
- **Monitoring Service**: Some sort of metrics collection tool to send data to LangFuse or Grafana. (in progress)

## Build Image

### Manual Build
```bash
docker build -f base.dockerfile -t llm-inference-base .
```

### Automated Build and Push to GitHub Container Registry

The base Docker image is automatically built and pushed to GitHub Container Registry (GHCR) when you create a tag on the main branch.

#### Creating a Release Tag
```bash
# Create and push a tag (with v prefix)
git tag v1.0.0
git push origin v1.0.0

# OR create a tag without v prefix
git tag 1.0.0
git push origin 1.0.0
```

This will trigger the GitHub Actions workflow that:
1. Builds the base Docker image
2. Pushes it to `ghcr.io/avikantsrivastava/llm-inference-engine/base` with the tag name (e.g., `v1.0.0` or `1.0.0`)
3. Also tags it as `latest` if on the default branch

#### Manual Workflow Trigger
You can also manually trigger the workflow from the GitHub Actions tab:
1. Go to Actions → "Build and Push Base Docker Image"
2. Click "Run workflow"
3. Optionally specify a custom tag name (defaults to `latest`)

#### Pull the Image
```bash
# Pull the latest image
docker pull ghcr.io/avikantsrivastava/llm-inference-engine/base:latest

# Pull a specific version (with v prefix)
docker pull ghcr.io/avikantsrivastava/llm-inference-engine/base:v1.0.0

# Pull a specific version (without v prefix)
docker pull ghcr.io/avikantsrivastava/llm-inference-engine/base:1.0.0
```

**Note**: The image is published as a public package and can be pulled without authentication.