# Docker Deployment Guide

## Quick Start

### Option 1: Docker Run
```bash
docker build -t steam-portfolio .
docker run -d -p 5000:8080 --name steam-portfolio steam-portfolio
```

### Option 2: Docker Compose (Recommended)
```bash
docker-compose up -d
```

Access at: `http://localhost:5000`

## Development Workflow

### Build
```bash
docker build -t steam-portfolio .
```

### Run
```bash
docker run -d -p 5000:8080 --name steam-portfolio steam-portfolio
```

### View Logs
```bash
docker logs steam-portfolio -f
```

### Stop & Remove
```bash
docker stop steam-portfolio
docker rm steam-portfolio
```

### Rebuild and Restart
```bash
docker stop steam-portfolio
docker rm steam-portfolio
docker build -t steam-portfolio .
docker run -d -p 5000:8080 --name steam-portfolio steam-portfolio
```

## Docker Compose Commands

### Start
```bash
docker-compose up -d
```

### Stop
```bash
docker-compose down
```

### Rebuild
```bash
docker-compose up -d --build
```

### View Logs
```bash
docker-compose logs -f
```

### Restart
```bash
docker-compose restart
```

## Environment Variables

You can customize the application by setting environment variables:

```bash
docker run -d \
  -p 5000:8080 \
  -e ASPNETCORE_ENVIRONMENT=Production \
  -e ASPNETCORE_URLS=http://+:8080 \
  --name steam-portfolio \
  steam-portfolio
```

## Production Deployment

### Azure Container Registry (ACR)

1. **Create ACR**
```bash
az acr create --resource-group your-rg --name yourregistry --sku Basic
```

2. **Login to ACR**
```bash
az acr login --name yourregistry
```

3. **Tag and Push**
```bash
docker tag steam-portfolio yourregistry.azurecr.io/steam-portfolio:latest
docker push yourregistry.azurecr.io/steam-portfolio:latest
```

### Azure Container Instances (ACI)

```bash
az container create \
  --resource-group your-rg \
  --name steam-portfolio \
  --image yourregistry.azurecr.io/steam-portfolio:latest \
  --dns-name-label steam-portfolio-app \
  --ports 8080 \
  --cpu 1 \
  --memory 1.5 \
  --registry-login-server yourregistry.azurecr.io \
  --registry-username yourregistry \
  --registry-password $(az acr credential show --name yourregistry --query "passwords[0].value" -o tsv)
```

### Azure App Service (Web App for Containers)

```bash
# Create App Service Plan
az appservice plan create \
  --name steam-portfolio-plan \
  --resource-group your-rg \
  --sku B1 \
  --is-linux

# Create Web App
az webapp create \
  --resource-group your-rg \
  --plan steam-portfolio-plan \
  --name steam-portfolio-app \
  --deployment-container-image-name yourregistry.azurecr.io/steam-portfolio:latest

# Configure registry credentials
az webapp config container set \
  --name steam-portfolio-app \
  --resource-group your-rg \
  --docker-custom-image-name yourregistry.azurecr.io/steam-portfolio:latest \
  --docker-registry-server-url https://yourregistry.azurecr.io \
  --docker-registry-server-user yourregistry \
  --docker-registry-server-password $(az acr credential show --name yourregistry --query "passwords[0].value" -o tsv)
```

## Troubleshooting

### Container won't start
```bash
# Check logs
docker logs steam-portfolio

# Check container status
docker ps -a

# Inspect container
docker inspect steam-portfolio
```

### Port already in use
```bash
# Use a different port
docker run -d -p 5001:8080 --name steam-portfolio steam-portfolio
```

### Image build fails
```bash
# Clean build cache
docker builder prune

# Rebuild without cache
docker build --no-cache -t steam-portfolio .
```

### Update static files (images, JSON)
If you update wwwroot files, you need to rebuild the image:
```bash
docker-compose down
docker-compose up -d --build
```

## Performance Tips

1. **Multi-stage build** - Already implemented in Dockerfile
2. **Layer caching** - Dependencies are restored in a separate layer
3. **Minimal runtime image** - Uses `aspnet:8.0` instead of `sdk:8.0`
4. **.dockerignore** - Excludes unnecessary files from build context

## Health Check

Add to docker-compose.yml:
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8080"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 40s
```
