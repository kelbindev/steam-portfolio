-- Seed Data for Steam Portfolio Database

-- 1. Insert Profile
INSERT INTO profile (name, title, summary, level, avatar_url, avatar_frame_url, resume_url)
VALUES (
    'KELBIN',
    'Fullstack Developer',
    'Fullstack Developer with 10+ years of experience building and modernizing enterprise systems. Strong expertise in .NET ecosystems paired with Vue.js and JavaScript for frontend development. Proven ability to deliver measurable improvements from drastically optimizing SQL query performance to implementing SSO frameworks with OpenIdDict(Oauth2/OpenID). Skilled in cloud development (Google Cloud and Azure) and establishing CI/CD pipelines that improve deployment reliability. Combines hands-on technical depth with the ability to translate business requirements into scalable, secure solutions.',
    100,
    'images/profile.jpg',
    'images/profile-frame.png',
    'docs/resume.pdf'
);

-- 2. Insert Stats
INSERT INTO stats (profile_id, value, label, display_order)
VALUES 
    (1, '10+', 'Years Experience', 1);

-- 3. Insert Skill Categories and Skills
-- Backend
INSERT INTO skill_categories (title, display_order) VALUES ('Backend', 1);
INSERT INTO skills (category_id, name, display_order) VALUES
    (1, '.NET 8', 1),
    (1, '.NET Core', 2),
    (1, 'C#', 3),
    (1, 'VB.NET', 4),
    (1, 'JavaScript', 5),
    (1, 'SQL', 6),
    (1, 'Dapper', 7),
    (1, 'EF Core', 8),
    (1, 'REST API', 9),
    (1, 'SOAP API', 10),
    (1, 'Hangfire', 11);

-- Frontend
INSERT INTO skill_categories (title, display_order) VALUES ('Frontend', 2);
INSERT INTO skills (category_id, name, display_order) VALUES
    (2, 'Vue.js', 1),
    (2, 'Blazor', 2),
    (2, 'ASP.NET MVC', 3),
    (2, 'Razor Pages', 4),
    (2, 'WinForms', 5),
    (2, 'PWA', 6),
    (2, 'Xamarin Forms', 7),
    (2, 'Flutter', 8);

-- Database
INSERT INTO skill_categories (title, display_order) VALUES ('Database', 3);
INSERT INTO skills (category_id, name, display_order) VALUES
    (3, 'MS SQL Server', 1),
    (3, 'PostgreSQL', 2),
    (3, 'Performance Tuning', 3),
    (3, 'Indexing', 4),
    (3, 'T-SQL', 5);

-- Cloud & DevOps
INSERT INTO skill_categories (title, display_order) VALUES ('Cloud & DevOps', 4);
INSERT INTO skills (category_id, name, display_order) VALUES
    (4, 'Google Cloud', 1),
    (4, 'Azure', 2),
    (4, 'AWS', 3),
    (4, 'CI/CD', 4),
    (4, 'Docker', 5),
    (4, 'Bitbucket', 6),
    (4, 'Bamboo', 7),
    (4, 'Git', 8),
    (4, 'GitHub Actions', 9);

-- Security & Identity
INSERT INTO skill_categories (title, display_order) VALUES ('Security & Identity', 5);
INSERT INTO skills (category_id, name, display_order) VALUES
    (5, 'OAuth2', 1),
    (5, 'OpenID', 2),
    (5, 'SSO', 3),
    (5, 'OpenIdDict', 4),
    (5, 'JWT', 5),
    (5, '2FA', 6),
    (5, 'TOTP', 7);

-- 4. Insert Work Experience
-- SHIMANO
INSERT INTO experiences (position, company, location, duration, display_order)
VALUES ('Fullstack Developer', 'SHIMANO', 'Singapore', 'Oct 2022 - Present', 1);

INSERT INTO experience_responsibilities (experience_id, description, display_order) VALUES
    (1, 'Develop and optimize MES and Logistics systems utilizing a hybrid stack of .NET 8/Core, legacy .NET Framework, and Vue.js, building scalable and performant systems', 1),
    (1, 'Developed a centralized Single Sign-On (SSO) framework using OpenIddict (OAuth2 and OpenID), integrated with 2FA and TOTP for enhanced multi-factor authentication, reducing support overhead for login related issues by 30%', 2),
    (1, 'Achieved a 99.9% uptime for critical manufacturing processes by migrating legacy workflows to Google Cloud (GCP), leveraging Cloud Run Functions and Application Integration', 3),
    (1, 'Revamped the SDLC by implementing a Feature Branching strategy and CI/CD pipelines, reducing code conflicts by 80% and enhancing deployment reliability across SEA and China', 4),
    (1, 'Refactored Reporting T-SQL queries, achieving a 99% execution speed improvement (hours to seconds) by analyzing execution plan and applying proper indexing', 5),
    (1, 'Developed automated data integration solutions synchronizing SharePoint and Caspio platforms data to SQL Server using .NET 8 and RESTful APIs, enabling audit trail capabilities', 6);

-- ANACLE
INSERT INTO experiences (position, company, location, duration, display_order)
VALUES ('Full Stack Developer', 'ANACLE', 'Singapore', 'Dec 2021 - Oct 2022', 2);

INSERT INTO experience_responsibilities (experience_id, description, display_order) VALUES
    (2, 'Managed and modernized the ANACLE Simplicity system, supporting the Enterprise Asset Management (EAM) module across ASP.NET Web Forms, Web API, and Xamarin Forms', 1),
    (2, 'Transitioned infrastructure to H-Cloud environment, ensuring seamless data exchange and application functionality across restricted internet and intranet zones', 2),
    (2, 'Integrated 2FA and Google Maps services within high-security environments by managing whitelist requests and implementing local library referencing for blocked JavaScript assets', 3);

-- Business Connectivity
INSERT INTO experiences (position, company, location, duration, display_order)
VALUES ('Full Stack Developer', 'Business Connectivity', 'Singapore', 'Dec 2019 - Dec 2021', 3);

INSERT INTO experience_responsibilities (experience_id, description, display_order) VALUES
    (3, 'Engineered enterprise-scale web applications using ASP.NET Core, C#, and JavaScript, delivering high-performance backend logic and responsive UI components', 1),
    (3, 'Migrated legacy systems to AWS EC2, optimizing instance configurations to improve scalability and maintain a 99.9% system uptime', 2),
    (3, 'Developed a geolocation verification module in Flutter using Google Maps API, achieving 99% location accuracy and eliminating fraudulent field check-ins', 3),
    (3, 'Automated delivery scheduling by integrating Google Workspace APIs with the ERP system, triggering real-time Google Calendar updates upon invoice finalization', 4);

-- Celindo Pratama
INSERT INTO experiences (position, company, location, duration, display_order)
VALUES ('Software Engineer', 'Celindo Pratama', 'Batam, Indonesia', 'Aug 2014 - Dec 2019', 4);

INSERT INTO experience_responsibilities (experience_id, description, display_order) VALUES
    (4, 'Modernized application architecture by leading the transition from ASP.NET Web Forms to ASP.NET MVC, improving maintainability and alignment with industry standards', 1),
    (4, 'Designed and implemented manufacturing systems tailored to client business needs using C# WinForms and ASP.NET Web Forms', 2),
    (4, 'Engaged directly with customers to translate complex business requirements into functional software specifications and system designs', 3);

-- 5. Insert Projects
INSERT INTO projects (title, description, url, github_url, image_url, display_order)
VALUES (
    'URL Shortener',
    'Simple URL shortener with Minimal API, PostgreSQL hosted on Azure Web App with automated deployment via GitHub Actions',
    'https://kelbin-url-shortener-cue0bccgdze6ccfy.southeastasia-01.azurewebsites.net/',
    'https://github.com/kelbindev/url-shortener',
    'https://via.placeholder.com/200x150/1b2838/66c0f4?text=URL+Shortener',
    1
);

INSERT INTO project_technologies (project_id, technology, display_order) VALUES
    (1, 'C#', 1),
    (1, 'Minimal API', 2),
    (1, 'PostgreSQL', 3),
    (1, 'Azure', 4),
    (1, 'Azure Key Vault', 5),
    (1, 'Azure Web Apps', 6),
    (1, 'Github Actions', 7);

INSERT INTO projects (title, description, url, github_url, image_url, display_order)
VALUES (
    'Blazor Games',
    'Blazor web app containing mini-games with automated deployment through GitHub Actions',
    'https://kelbindev.github.io/',
    'https://github.com/kelbindev/blazor-games',
    'https://via.placeholder.com/200x150/1b2838/66c0f4?text=Blazor+Games',
    2
);

INSERT INTO project_technologies (project_id, technology, display_order) VALUES
    (2, 'C#', 1),
    (2, 'Blazor', 2),
    (2, 'Azure Static Web App', 3),
    (2, 'Github Actions', 4);

-- 6. Insert Education
INSERT INTO education (degree, school, location)
VALUES ('Bachelor of Information Technology', 'University of Putera Batam', 'Batam, Indonesia');

-- 7. Insert Contact Links
INSERT INTO contact_links (icon, text, url, display_order) VALUES
    ('bi-linkedin', 'LinkedIn', 'https://linkedin.com/in/kelbin-kelbin', 1),
    ('bi-github', 'GitHub', 'https://github.com/kelbindev', 2),
    ('bi-envelope-fill', 'kelbinlin95@gmail.com', 'mailto:kelbinlin95@gmail.com', 3),
    ('bi-telephone-fill', '+65 8548 3315', 'tel:+6585483315', 4),
    ('bi-steam', 'ribbit', 'https://steamcommunity.com/id/kbkbkb95/', 5);

-- 8. Insert Location
INSERT INTO location_info (location)
VALUES ('Singapore');
