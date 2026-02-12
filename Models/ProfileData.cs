namespace Models;

public class ProfileData
{
    public string Name { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Summary { get; set; } = string.Empty;
    public int Level { get; set; }
    public List<StatItem> Stats { get; set; } = new();
    public string AvatarUrl { get; set; } = string.Empty;
    public string AvatarFrameUrl { get; set; } = string.Empty;
    public string ResumeUrl { get; set; } = string.Empty;
}

public class StatItem
{
    public string Value { get; set; } = string.Empty;
    public string Label { get; set; } = string.Empty;
}
