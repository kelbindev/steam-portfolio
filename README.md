# Steam Portfolio - Blazor Project

A Blazor Server application that displays a Steam-inspired portfolio page with data from PostgreSQL database.

## Quick Start

### Local Development
See [LOCAL_DEVELOPMENT.md](LOCAL_DEVELOPMENT.md) for detailed setup instructions.

1. Configure connection string in `appsettings.json` to point to your PostgreSQL server
2. Run from Visual Studio (F5) or `dotnet run`

### Production Deployment
The application deploys to Azure VM via GitHub Actions. See [DOCKER.md](DOCKER.md) for Docker details.

## Project Structure

This is a Blazor Server application that displays a Steam-inspired portfolio page with data loaded from a PostgreSQL database.

### Database (`Database/`)

Database schema and seed data:

- **schema.sql** - Database schema with tables for profile, skills, experience, projects, and contact
- **seed.sql** - Sample data to populate the database
- **init-db.sh** - Initialization script (used in Docker)
- **README.md** - Database documentation

### Data Files (`wwwroot/data/`) - DEPRECATED

?? **Note**: JSON files are being migrated to PostgreSQL. These files may be removed in future versions.

- **profile.json** - Profile information (name, title, summary, level, stats, avatar)
- **skills.json** - Skills organized by categories (Backend, Frontend, Database, etc.)
- **experience.json** - Work experience history
- **projects.json** - Featured projects with descriptions and technologies
- **contact.json** - Education, contact links, and location

### Models (`Models/`)

C# classes that define the structure of the data:

- `ProfileData.cs` - Profile and stats model
- `SkillsData.cs` - Skills categories and items
- `ExperienceData.cs` - Work experience entries
- `ProjectsData.cs` - Project information
- `ContactData.cs` - Education, links, and location

### Services (`Services/`)

- **DatabaseService.cs** - Service that loads data from PostgreSQL using Dapper
- **PortfolioDataService.cs** - Legacy service for JSON data (deprecated)

### Components

- **Home.razor** - Main portfolio page component with Interactive Server render mode
- Uses `@inject` to get the DatabaseService
- Loads all data asynchronously from PostgreSQL on initialization
- Displays loading spinner while fetching data

## How to Update Content

All content is stored in PostgreSQL. You can update it by:

1. **Directly modifying the database** - Connect to PostgreSQL and run UPDATE queries
2. **Editing seed data** - Update `Database/seed.sql` and re-run it
3. **Building an admin panel** - (Future enhancement)

### Database Schema

The database has the following main tables:
- `profile` - Profile information (name, title, summary, level, avatar)
- `stats` - Profile statistics
- `skill_categories` & `skills` - Skills organized by categories
- `experiences` & `experience_responsibilities` - Work experience
- `projects` & `project_technologies` - Portfolio projects
- `education`, `contact_links`, `location_info` - Contact information

See `Database/README.md` for detailed schema documentation.

## Running the Project

### Local Development

1. Ensure your PostgreSQL server is running and accessible
2. Update `appsettings.json` with your database connection string
3. Run the application:

```bash
dotnet run
```

Then navigate to `https://localhost:7054` or `http://localhost:5112`

See [LOCAL_DEVELOPMENT.md](LOCAL_DEVELOPMENT.md) for detailed instructions.

### Docker (Production)

See [DOCKER.md](DOCKER.md) for Docker deployment instructions.

## Configuration

### Connection String

**Local Development** (`appsettings.json`):
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=<your-db-server>;Port=5432;Database=steam_portfolio;Username=postgres;Password=your_password"
  }
}
```

**Production** (Azure VM):
Connection string is injected via environment variable from GitHub Secrets during deployment.

### GitHub Secrets (for CI/CD)

Required secrets:
- `AZURE_SSH_KEY` - SSH private key for VM access
- `AZURE_HOST` - VM hostname or IP address
- `AZURE_USER` - SSH username
- `GH_PAT` - GitHub Personal Access Token
- `CONNECTION_STRING` - PostgreSQL connection string

## Features

- **Blazor Server** with Interactive rendering
- **PostgreSQL database** - Robust data storage with relational structure
- **Async data loading** - All data loads efficiently with Dapper
- **Steam-themed design** - Modern, responsive UI
- **Type-safe** - C# models ensure data integrity
- **Docker ready** - Containerized for easy deployment
- **CI/CD** - Automated deployment via GitHub Actions
