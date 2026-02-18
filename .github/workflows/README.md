# GitHub Actions Workflows

## Docker Image Publishing Workflow

### Overview
The `docker-publish.yml` workflow automates the building and publishing of the base Docker image to GitHub Container Registry (GHCR).

### Triggers

#### 1. Tag Push (Primary Method)
When you create and push a tag starting with `v` (e.g., `v1.0.0`):
```bash
git tag v1.0.0
git push origin v1.0.0
```

This will:
- Build the Docker image from `base.dockerfile`
- Push it to `ghcr.io/avikantsrivastava/llm-inference-engine/base:v1.0.0`
- Also tag it as `latest` if on the default branch

#### 2. Manual Workflow Dispatch
You can manually trigger the workflow from GitHub:
1. Navigate to the "Actions" tab in the repository
2. Select "Build and Push Base Docker Image"
3. Click "Run workflow"
4. Optionally specify a custom tag name (defaults to `latest`)

### Workflow Details

**Permissions Required:**
- `contents: read` - To checkout the repository
- `packages: write` - To push to GitHub Container Registry

**Steps:**
1. **Checkout**: Retrieves the repository code
2. **Docker Buildx Setup**: Enables advanced Docker build features
3. **GHCR Login**: Authenticates using the `GITHUB_TOKEN`
4. **Metadata Extraction**: Generates appropriate tags and labels
5. **Build and Push**: Builds the image and pushes to GHCR with caching

**Caching:**
The workflow uses GitHub Actions cache to speed up subsequent builds by caching Docker layers.

### Image Tags

The workflow automatically generates the following tags:

- **Tag Push**: `v*` → Image tagged with the same version (e.g., `v1.0.0`)
- **Default Branch**: Also tagged as `latest`
- **Manual Trigger**: Uses the tag specified in the input (default: `latest`)

### Using the Published Images

```bash
# Pull the latest version
docker pull ghcr.io/avikantsrivastava/llm-inference-engine/base:latest

# Pull a specific version
docker pull ghcr.io/avikantsrivastava/llm-inference-engine/base:v1.0.0

# Run the container
docker run -it ghcr.io/avikantsrivastava/llm-inference-engine/base:latest
```

### Making the Package Public

After the first successful push:
1. Go to the repository's main page
2. Click on "Packages" in the right sidebar
3. Click on the package name
4. Click "Package settings"
5. Scroll down to "Danger Zone"
6. Click "Change visibility" and set to "Public"

This allows anyone to pull the image without authentication.

### Troubleshooting

**Issue: Workflow fails with "permission denied"**
- Ensure the repository has "Read and write permissions" enabled for workflows
- Go to Settings → Actions → General → Workflow permissions
- Select "Read and write permissions"

**Issue: Package is not visible**
- The package is initially private after first push
- Follow the steps above to make it public

**Issue: Build fails**
- Check the Actions tab for detailed logs
- Ensure `base.dockerfile` is in the repository root
- Verify Docker build context is correct
