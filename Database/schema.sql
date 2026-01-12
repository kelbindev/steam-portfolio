-- Create Database
CREATE DATABASE steam_portfolio;

-- Connect to the database
\c steam_portfolio;

-- Create Tables

-- 1. Profile Table
CREATE TABLE profile (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    summary TEXT NOT NULL,
    level INTEGER NOT NULL,
    avatar_url VARCHAR(500),
    avatar_frame_url VARCHAR(500),
    resume_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Stats Table
CREATE TABLE stats (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profile(id) ON DELETE CASCADE,
    value VARCHAR(50) NOT NULL,
    label VARCHAR(100) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 3. Skill Categories Table
CREATE TABLE skill_categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 4. Skills Table
CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES skill_categories(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 5. Experience Table
CREATE TABLE experiences (
    id SERIAL PRIMARY KEY,
    position VARCHAR(200) NOT NULL,
    company VARCHAR(200) NOT NULL,
    location VARCHAR(200) NOT NULL,
    duration VARCHAR(100) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 6. Experience Responsibilities Table
CREATE TABLE experience_responsibilities (
    id SERIAL PRIMARY KEY,
    experience_id INTEGER REFERENCES experiences(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 7. Projects Table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    url VARCHAR(500),
    github_url VARCHAR(500),
    image_url VARCHAR(500),
    display_order INTEGER DEFAULT 0
);

-- 8. Project Technologies Table
CREATE TABLE project_technologies (
    id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(id) ON DELETE CASCADE,
    technology VARCHAR(100) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 9. Education Table
CREATE TABLE education (
    id SERIAL PRIMARY KEY,
    degree VARCHAR(200) NOT NULL,
    school VARCHAR(200) NOT NULL,
    location VARCHAR(200) NOT NULL
);

-- 10. Contact Links Table
CREATE TABLE contact_links (
    id SERIAL PRIMARY KEY,
    icon VARCHAR(100) NOT NULL,
    text VARCHAR(200) NOT NULL,
    url VARCHAR(500) NOT NULL,
    display_order INTEGER DEFAULT 0
);

-- 11. Location Table
CREATE TABLE location_info (
    id SERIAL PRIMARY KEY,
    location VARCHAR(200) NOT NULL
);

-- Create Indexes for better query performance
CREATE INDEX idx_stats_profile_id ON stats(profile_id);
CREATE INDEX idx_skills_category_id ON skills(category_id);
CREATE INDEX idx_experience_responsibilities_experience_id ON experience_responsibilities(experience_id);
CREATE INDEX idx_project_technologies_project_id ON project_technologies(project_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for profile table
CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON profile
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
