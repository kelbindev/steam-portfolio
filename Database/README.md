# Database Setup Guide

## PostgreSQL Migration

This project uses PostgreSQL with Dapper for data access (raw SQL queries, no EF Core).

## Prerequisites

- PostgreSQL 12 or higher
- pgAdmin (optional, for GUI management)

## Quick Start

### Option 1: Docker Compose (Recommended)

The easiest way is to use Docker Compose which includes PostgreSQL:

```bash
# Start both database and application
docker-compose up -d

# The database will be automatically initialized with schema and seed data
```

### Option 2: Local PostgreSQL Installation

#### 1. Install PostgreSQL

**Windows:**
```bash
# Download from https://www.postgresql.org/download/windows/
# Or use chocolatey
choco install postgresql
```

**macOS:**
```bash
brew install postgresql@16
brew services start postgresql@16
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
```

#### 2. Create Database and Run Scripts

```bash
# Login to PostgreSQL
psql -U postgres

# Create database (from psql prompt)
CREATE DATABASE steam_portfolio;

# Exit psql
\q

# Run schema script
psql -U postgres -d steam_portfolio -f Database/schema.sql

# Run seed script
psql -U postgres -d steam_portfolio -f Database/seed.sql
```

#### 3. Update Connection String

Edit `appsettings.Development.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Port=5432;Database=steam_portfolio;Username=postgres;Password=YOUR_PASSWORD"
  }
}
```

#### 4. Run Application

```bash
dotnet run
```

## Database Schema

### Tables

1. **profile** - User profile information
2. **stats** - Profile statistics (years experience, etc.)
3. **skill_categories** - Skill category groups
4. **skills** - Individual skills
5. **experiences** - Work experience entries
6. **experience_responsibilities** - Job responsibilities
7. **projects** - Featured projects
8. **project_technologies** - Technologies used in projects
9. **education** - Education information
10. **contact_links** - Social/contact links
11. **location_info** - Current location

## Manual Data Management

### View All Projects
```sql
SELECT p.title, p.url, array_agg(pt.technology) as technologies
FROM projects p
LEFT JOIN project_technologies pt ON p.id = pt.project_id
GROUP BY p.id, p.title, p.url;
```

### Add New Skill
```sql
-- Get category ID
SELECT id, title FROM skill_categories;

-- Insert skill
INSERT INTO skills (category_id, name, display_order)
VALUES (1, 'New Technology', 99);
```

### Add New Project
```sql
-- Insert project
INSERT INTO projects (title, description, url, github_url, image_url, display_order)
VALUES ('Project Title', 'Description', 'https://url.com', 'https://github.com/user/repo', 'image.jpg', 99)
RETURNING id;

-- Add technologies (use the returned id)
INSERT INTO project_technologies (project_id, technology, display_order) VALUES
    (3, 'Tech1', 1),
    (3, 'Tech2', 2);
```

### Update Profile
```sql
UPDATE profile
SET name = 'Your Name',
    title = 'Your Title',
    summary = 'Your summary...'
WHERE id = 1;
```

### Add Work Experience
```sql
-- Insert experience
INSERT INTO experiences (position, company, location, duration, display_order)
VALUES ('Position', 'Company', 'Location', 'Jan 2020 - Present', 1)
RETURNING id;

-- Add responsibilities
INSERT INTO experience_responsibilities (experience_id, description, display_order) VALUES
    (5, 'Responsibility 1', 1),
    (5, 'Responsibility 2', 2);
```

## Connection String Formats

### Local Development
```
Host=localhost;Port=5432;Database=steam_portfolio;Username=postgres;Password=your_password
```

### Docker
```
Host=postgres;Port=5432;Database=steam_portfolio;Username=postgres;Password=your_password
```

### Azure Database for PostgreSQL
```
Host=your-server.postgres.database.azure.com;Port=5432;Database=steam_portfolio;Username=your_username@your-server;Password=your_password;SSL Mode=Require
```

### Connection String with SSL
```
Host=localhost;Port=5432;Database=steam_portfolio;Username=postgres;Password=your_password;SSL Mode=Require;Trust Server Certificate=true
```

## Troubleshooting

### Connection Refused
```bash
# Check if PostgreSQL is running
sudo systemctl status postgresql  # Linux
brew services list                 # macOS
# Check Windows Services           # Windows

# Check if port 5432 is open
netstat -an | grep 5432
```

### Authentication Failed
```bash
# Reset PostgreSQL password
sudo -u postgres psql
ALTER USER postgres PASSWORD 'new_password';
```

### Permission Denied
```bash
# Grant permissions
GRANT ALL PRIVILEGES ON DATABASE steam_portfolio TO postgres;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
```

## Backup and Restore

### Backup Database
```bash
pg_dump -U postgres -d steam_portfolio -f backup.sql
```

### Restore Database
```bash
psql -U postgres -d steam_portfolio -f backup.sql
```

### Backup with Docker
```bash
docker exec steam-portfolio-db pg_dump -U postgres steam_portfolio > backup.sql
```

### Restore with Docker
```bash
docker exec -i steam-portfolio-db psql -U postgres steam_portfolio < backup.sql
```

## Performance Tips

1. **Indexes are already created** in schema.sql for foreign keys
2. **Connection pooling** is handled by Npgsql automatically
3. **Use prepared statements** - Dapper does this automatically
4. **Monitor slow queries**:
```sql
-- Enable query logging
ALTER SYSTEM SET log_min_duration_statement = 1000;  -- Log queries > 1 second
SELECT pg_reload_conf();
```

## Security Best Practices

1. **Never commit passwords** - Use environment variables
2. **Use strong passwords** for production
3. **Enable SSL** for production databases
4. **Restrict database access** by IP
5. **Regular backups** - Set up automated backups

## Environment Variables

For production, use environment variables instead of appsettings.json:

```bash
# Linux/macOS
export ConnectionStrings__DefaultConnection="Host=...;Database=...;Username=...;Password=..."

# Windows PowerShell
$env:ConnectionStrings__DefaultConnection="Host=...;Database=...;Username=...;Password=..."

# Docker
docker run -e ConnectionStrings__DefaultConnection="..." steam-portfolio
```
