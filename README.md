# Steam Portfolio - Blazor Project

## Project Structure

This is a Blazor Server application that displays a Steam-inspired portfolio page with data loaded from JSON files.

### Data Files (`wwwroot/data/`)

All portfolio content is stored in JSON files that can be easily edited:

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

- **PortfolioDataService.cs** - Service that loads JSON data using HttpClient

### Components

- **Home.razor** - Main portfolio page component with Interactive Server render mode
- Uses `@inject` to get the PortfolioDataService
- Loads all data asynchronously on initialization
- Displays loading spinner while fetching data

## How to Update Content

### 1. Update Profile Information
Edit `wwwroot/data/profile.json`:
```json
{
  "name": "Your Name",
  "title": "Your Title",
  "summary": "Your summary...",
  "level": 100,
  "stats": [...],
  "avatarUrl": "your-image-url",
  "avatarFrameUrl": "frame-url"
}
```

### 2. Add/Remove Skills
Edit `wwwroot/data/skills.json`:
```json
{
  "categories": [
    {
      "title": "Category Name",
      "skills": ["Skill1", "Skill2", "Skill3"]
    }
  ]
}
```

### 3. Update Work Experience
Edit `wwwroot/data/experience.json`:
```json
{
  "experiences": [
    {
      "position": "Job Title",
      "company": "Company Name",
      "location": "Location",
      "duration": "Start - End",
      "responsibilities": [
        "Responsibility 1",
        "Responsibility 2"
      ]
    }
  ]
}
```

### 4. Add Projects
Edit `wwwroot/data/projects.json`:
```json
{
  "projects": [
    {
      "title": "Project Name",
      "description": "Description",
      "url": "project-url",
      "imageUrl": "image-url",
      "technologies": ["Tech1", "Tech2"]
    }
  ]
}
```

### 5. Update Contact Info
Edit `wwwroot/data/contact.json`:
```json
{
  "education": {
    "degree": "Degree Name",
    "school": "School Name",
    "location": "Location"
  },
  "links": [
    {
      "icon": "??",
      "text": "LinkedIn",
      "url": "your-linkedin-url"
    }
  ],
  "location": "Your Location"
}
```

## Features

- **Blazor Server** with Interactive rendering
- **JSON-based content** - Easy to update without code changes
- **Async data loading** - All data loads in parallel for performance
- **Steam-themed design** - Modern, responsive UI
- **Type-safe** - C# models ensure data integrity
- **Separation of concerns** - Data, business logic, and presentation are separated

## Running the Project

```bash
dotnet run
```

Then navigate to `https://localhost:7054` or `http://localhost:5112`
