namespace steam_portfolio.Models;

public class ExperienceData
{
    public List<Experience> Experiences { get; set; } = new();
}

public class Experience
{
    public string Position { get; set; } = string.Empty;
    public string Company { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public string Duration { get; set; } = string.Empty;
    public List<string> Responsibilities { get; set; } = new();
}
