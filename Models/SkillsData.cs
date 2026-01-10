namespace steam_portfolio.Models;

public class SkillsData
{
    public List<SkillCategory> Categories { get; set; } = new();
}

public class SkillCategory
{
    public string Title { get; set; } = string.Empty;
    public List<string> Skills { get; set; } = new();
}
