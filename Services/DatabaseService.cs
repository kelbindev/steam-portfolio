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
        
        const string query = @"
            SELECT 
                sc.id AS CategoryId,
                sc.title AS CategoryTitle,
                s.name AS SkillName
            FROM skill_categories sc
            LEFT JOIN skills s ON sc.id = s.category_id
            ORDER BY sc.display_order, s.display_order";

        var results = await connection.QueryAsync<(int CategoryId, string CategoryTitle, string? SkillName)>(query);
        
        var skillsData = new SkillsData();
        var groupedResults = results.GroupBy(r => new { r.CategoryId, r.CategoryTitle });

        foreach (var group in groupedResults)
        {
            skillsData.Categories.Add(new SkillCategory
            {
                Title = group.Key.CategoryTitle,
                Skills = group.Where(r => r.SkillName != null).Select(r => r.SkillName!).ToList()
            });
        }

        return skillsData;
    }

    public async Task<ExperienceData> GetExperienceDataAsync()
    {
        using var connection = CreateConnection();
        
        const string query = @"
            SELECT 
                e.id AS ExperienceId,
                e.position AS Position,
                e.company AS Company,
                e.location AS Location,
                e.duration AS Duration,
                er.description AS Responsibility
            FROM experiences e
            LEFT JOIN experience_responsibilities er ON e.id = er.experience_id
            ORDER BY e.display_order, er.display_order";

        var results = await connection.QueryAsync<(int ExperienceId, string Position, string Company, string Location, string Duration, string? Responsibility)>(query);
        
        var experienceData = new ExperienceData();
        var groupedResults = results.GroupBy(r => new { r.ExperienceId, r.Position, r.Company, r.Location, r.Duration });

        foreach (var group in groupedResults)
        {
            experienceData.Experiences.Add(new Experience
            {
                Position = group.Key.Position,
                Company = group.Key.Company,
                Location = group.Key.Location,
                Duration = group.Key.Duration,
                Responsibilities = group.Where(r => r.Responsibility != null).Select(r => r.Responsibility!).ToList()
            });
        }

        return experienceData;
    }

    public async Task<ProjectsData> GetProjectsDataAsync()
    {
        using var connection = CreateConnection();
        
        const string query = @"
            SELECT 
                p.id AS ProjectId,
                p.title AS Title,
                p.description AS Description,
                p.url AS Url,
                p.github_url AS GitHubUrl,
                p.image_url AS ImageUrl,
                pt.technology AS Technology
            FROM projects p
            LEFT JOIN project_technologies pt ON p.id = pt.project_id
            ORDER BY p.display_order, pt.display_order";

        var results = await connection.QueryAsync<(int ProjectId, string Title, string Description, string? Url, string? GitHubUrl, string? ImageUrl, string? Technology)>(query);
        
        var projectsData = new ProjectsData();
        var groupedResults = results.GroupBy(r => new { r.ProjectId, r.Title, r.Description, r.Url, r.GitHubUrl, r.ImageUrl });

        foreach (var group in groupedResults)
        {
            projectsData.Projects.Add(new Project
            {
                Title = group.Key.Title,
                Description = group.Key.Description,
                Url = group.Key.Url ?? string.Empty,
                GitHubUrl = group.Key.GitHubUrl ?? string.Empty,
                ImageUrl = group.Key.ImageUrl ?? string.Empty,
                Technologies = group.Where(r => r.Technology != null).Select(r => r.Technology!).ToList()
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
