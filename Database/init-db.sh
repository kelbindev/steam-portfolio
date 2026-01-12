#!/bin/bash

# Database initialization script for Steam Portfolio

echo "========================================="
echo "Steam Portfolio - Database Setup"
echo "========================================="
echo ""

# Database configuration
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-steam_portfolio}
DB_USER=${DB_USER:-postgres}

echo "Configuration:"
echo "  Host: $DB_HOST"
echo "  Port: $DB_PORT"
echo "  Database: $DB_NAME"
echo "  User: $DB_USER"
echo ""

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "? Error: PostgreSQL (psql) is not installed or not in PATH"
    echo "Please install PostgreSQL first"
    exit 1
fi

echo "? PostgreSQL found"
echo ""

# Check if database exists
echo "Checking if database exists..."
DB_EXISTS=$(PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)

if [ $DB_EXISTS -eq 0 ]; then
    echo "?? Creating database '$DB_NAME'..."
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE $DB_NAME;"
    
    if [ $? -eq 0 ]; then
        echo "? Database created successfully"
    else
        echo "? Failed to create database"
        exit 1
    fi
else
    echo "? Database '$DB_NAME' already exists"
    
    read -p "Do you want to drop and recreate it? (y/N): " confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        echo "???  Dropping database..."
        PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "DROP DATABASE $DB_NAME;"
        echo "?? Creating database..."
        PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -c "CREATE DATABASE $DB_NAME;"
        echo "? Database recreated"
    fi
fi

echo ""
echo "?? Running schema.sql..."
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f Database/schema.sql

if [ $? -eq 0 ]; then
    echo "? Schema created successfully"
else
    echo "? Failed to create schema"
    exit 1
fi

echo ""
echo "?? Running seed.sql..."
PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f Database/seed.sql

if [ $? -eq 0 ]; then
    echo "? Seed data inserted successfully"
else
    echo "? Failed to insert seed data"
    exit 1
fi

echo ""
echo "========================================="
echo "? Database setup complete!"
echo "========================================="
echo ""
echo "Connection string:"
echo "Host=$DB_HOST;Port=$DB_PORT;Database=$DB_NAME;Username=$DB_USER;Password=YOUR_PASSWORD"
echo ""
echo "You can now run the application with:"
echo "  dotnet run"
echo ""
