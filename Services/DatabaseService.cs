using Npgsql;
using Dapper;
using steam_portfolio.Models;

namespace steam_portfolio.Services;

public class DatabaseService
{
    private readonly string _connectionString;

    public DatabaseService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection") 
            ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
    }

    private NpgsqlConnection CreateConnection()
    {
        return new NpgsqlConnection(_connectionString);
    }

    public async Task<ProfileData?> GetProfileDataAsync()
    {
        using var connection = CreateConnection();
        
        const string profileQuery = @"
            SELECT id, name, title, summary, level, avatar_url AS AvatarUrl, 
                   avatar_frame_url AS AvatarFrameUrl, resume_url AS ResumeUrl
            FROM profile
            LIMIT 1";

        const string statsQuery = @"
            SELECT value, label
            FROM stats
            WHERE profile_id = @ProfileId
            ORDER BY display_order";

        var profile = await connection.QueryFirstOrDefaultAsync<ProfileData>(profileQuery);
        
        if (profile != null)
        {
            var stats = await connection.QueryAsync<StatItem>(statsQuery, new { ProfileId = 1 });
            profile.Stats = stats.ToList();
        }

        return profile;
    }

    public async Task<SkillsData> GetSkillsDataAsync()
    {
        using var connection = CreateConnection();
        
        const string categoriesQuery = @"
            SELECT id, title
            FROM skill_categories
            ORDER BY display_order";

        const string skillsQuery = @"
            SELECT category_id AS CategoryId, name
            FROM skills
            ORDER BY display_order";

        var categories = await connection.QueryAsync<SkillCategoryDb>(categoriesQuery);
        var allSkills = await connection.QueryAsync<SkillDb>(skillsQuery);
        
        var skillsByCategory = allSkills
            .GroupBy(s => s.CategoryId)
            .ToDictionary(g => g.Key, g => g.Select(s => s.Name).ToList());

        var skillsData = new SkillsData();

        foreach (var category in categories)
        {
            skillsData.Categories.Add(new SkillCategory
            {
                Title = category.Title,
                Skills = skillsByCategory.GetValueOrDefault(category.Id) ?? new List<string>()
            });
        }

        return skillsData;
    }

    public async Task<ExperienceData> GetExperienceDataAsync()
    {
        using var connection = CreateConnection();
        
        const string experiencesQuery = @"
            SELECT id, position, company, location, duration
            FROM experiences
            ORDER BY display_order";

        const string responsibilitiesQuery = @"
            SELECT experience_id AS ExperienceId, description
            FROM experience_responsibilities
            ORDER BY display_order";

        var experiences = await connection.QueryAsync<ExperienceDb>(experiencesQuery);
        var allResponsibilities = await connection.QueryAsync<ResponsibilityDb>(responsibilitiesQuery);
        
        var responsibilitiesByExperience = allResponsibilities
            .GroupBy(r => r.ExperienceId)
            .ToDictionary(g => g.Key, g => g.Select(r => r.Description).ToList());

        var experienceData = new ExperienceData();

        foreach (var exp in experiences)
        {
            experienceData.Experiences.Add(new Experience
            {
                Position = exp.Position,
                Company = exp.Company,
                Location = exp.Location,
                Duration = exp.Duration,
                Responsibilities = responsibilitiesByExperience.GetValueOrDefault(exp.Id) ?? new List<string>()
            });
        }

        return experienceData;
    }

    public async Task<ProjectsData> GetProjectsDataAsync()
    {
        using var connection = CreateConnection();
        
        const string projectsQuery = @"
            SELECT id, title, description, url, github_url AS GitHubUrl, image_url AS ImageUrl
            FROM projects
            ORDER BY display_order";

        const string technologiesQuery = @"
            SELECT project_id AS ProjectId, technology
            FROM project_technologies
            ORDER BY display_order";

        var projects = await connection.QueryAsync<ProjectDb>(projectsQuery);
        var allTechnologies = await connection.QueryAsync<TechnologyDb>(technologiesQuery);
        
        var technologiesByProject = allTechnologies
            .GroupBy(t => t.ProjectId)
            .ToDictionary(g => g.Key, g => g.Select(t => t.Technology).ToList());

        var projectsData = new ProjectsData();

        foreach (var proj in projects)
        {
            projectsData.Projects.Add(new Project
            {
                Title = proj.Title,
                Description = proj.Description,
                Url = proj.Url ?? string.Empty,
                GitHubUrl = proj.GitHubUrl ?? string.Empty,
                ImageUrl = proj.ImageUrl ?? string.Empty,
                Technologies = technologiesByProject.GetValueOrDefault(proj.Id) ?? new List<string>()
            });
        }

        return projectsData;
    }

    public async Task<ContactData> GetContactDataAsync()
    {
        using var connection = CreateConnection();
        
        const string educationQuery = @"
            SELECT degree, school, location
            FROM education
            LIMIT 1";

        const string linksQuery = @"
            SELECT icon, text, url
            FROM contact_links
            ORDER BY display_order";

        const string locationQuery = @"
            SELECT location
            FROM location_info
            LIMIT 1";

        var education = await connection.QueryFirstOrDefaultAsync<Education>(educationQuery);
        var links = await connection.QueryAsync<ContactLink>(linksQuery);
        var location = await connection.QueryFirstOrDefaultAsync<string>(locationQuery);

        return new ContactData
        {
            Education = education ?? new Education(),
            Links = links.ToList(),
            Location = location ?? string.Empty
        };
    }
}
