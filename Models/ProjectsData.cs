namespace steam_portfolio.Models;

public class ProjectsData
{
    public List<Project> Projects { get; set; } = new();
}

public class Project
{
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Url { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public List<string> Technologies { get; set; } = new();
}
