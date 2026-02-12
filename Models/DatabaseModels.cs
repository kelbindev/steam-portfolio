namespace Models;

public class SkillCategoryDb
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
}

public class SkillDb
{
    public int CategoryId { get; set; }
    public string Name { get; set; } = string.Empty;
}

public class ExperienceDb
{
    public int Id { get; set; }
    public string Position { get; set; } = string.Empty;
    public string Company { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public string Duration { get; set; } = string.Empty;
}

public class ResponsibilityDb
{
    public int ExperienceId { get; set; }
    public string Description { get; set; } = string.Empty;
}

public class ProjectDb
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string? Url { get; set; }
    public string? GitHubUrl { get; set; }
    public string? ImageUrl { get; set; }
}

public class TechnologyDb
{
    public int ProjectId { get; set; }
    public string Technology { get; set; } = string.Empty;
}
