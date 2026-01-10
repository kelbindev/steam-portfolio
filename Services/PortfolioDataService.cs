using System.Net.Http.Json;
using steam_portfolio.Models;

namespace steam_portfolio.Services;

public class PortfolioDataService
{
    private readonly HttpClient _httpClient;

    public PortfolioDataService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<ProfileData?> GetProfileDataAsync()
    {
        return await _httpClient.GetFromJsonAsync<ProfileData>("data/profile.json");
    }

    public async Task<SkillsData?> GetSkillsDataAsync()
    {
        return await _httpClient.GetFromJsonAsync<SkillsData>("data/skills.json");
    }

    public async Task<ExperienceData?> GetExperienceDataAsync()
    {
        return await _httpClient.GetFromJsonAsync<ExperienceData>("data/experience.json");
    }

    public async Task<ProjectsData?> GetProjectsDataAsync()
    {
        return await _httpClient.GetFromJsonAsync<ProjectsData>("data/projects.json");
    }

    public async Task<ContactData?> GetContactDataAsync()
    {
        return await _httpClient.GetFromJsonAsync<ContactData>("data/contact.json");
    }
}
