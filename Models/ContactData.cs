namespace Models;

public class ContactData
{
    public Education Education { get; set; } = new();
    public List<ContactLink> Links { get; set; } = new();
    public string Location { get; set; } = string.Empty;
}

public class Education
{
    public string Degree { get; set; } = string.Empty;
    public string School { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
}

public class ContactLink
{
    public string Icon { get; set; } = string.Empty;
    public string Text { get; set; } = string.Empty;
    public string Url { get; set; } = string.Empty;
}
