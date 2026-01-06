-- NFL Simulation Database Schema

-- Users table for authentication and save games
CREATE TABLE IF NOT EXISTS nfl_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Save games (franchises)
CREATE TABLE IF NOT EXISTS nfl_saves (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES nfl_users(id) ON DELETE CASCADE,
    save_name VARCHAR(100) NOT NULL,
    current_week INTEGER DEFAULT 1,
    current_season INTEGER NOT NULL,
    team_id INTEGER, -- User's controlled team
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, save_name)
);

-- Teams table
CREATE TABLE IF NOT EXISTS nfl_teams (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES nfl_saves(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    abbreviation VARCHAR(3) NOT NULL,
    conference VARCHAR(3) NOT NULL, -- AFC or NFC
    division VARCHAR(10) NOT NULL, -- North, South, East, West
    logo_url VARCHAR(255),
    stadium VARCHAR(100),
    wins INTEGER DEFAULT 0,
    losses INTEGER DEFAULT 0,
    ties INTEGER DEFAULT 0,
    points_for INTEGER DEFAULT 0,
    points_against INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Players table
CREATE TABLE IF NOT EXISTS nfl_players (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES nfl_saves(id) ON DELETE CASCADE,
    team_id INTEGER REFERENCES nfl_teams(id) ON DELETE SET NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(10) NOT NULL, -- QB, RB, WR, TE, OL, DL, LB, CB, S, K, P
    jersey_number INTEGER,
    age INTEGER NOT NULL,
    height INTEGER, -- inches
    weight INTEGER, -- pounds
    college VARCHAR(100),
    draft_year INTEGER,
    draft_round INTEGER,
    draft_pick INTEGER,
    years_pro INTEGER DEFAULT 0,
    contract_years INTEGER DEFAULT 0,
    contract_salary INTEGER DEFAULT 0,
    is_rookie BOOLEAN DEFAULT false,
    is_injured BOOLEAN DEFAULT false,
    injury_weeks INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Player attributes (skills and ratings)
CREATE TABLE IF NOT EXISTS nfl_player_attributes (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES nfl_players(id) ON DELETE CASCADE,
    
    -- Overall ratings
    overall_rating INTEGER DEFAULT 50, -- 0-99
    potential INTEGER DEFAULT 50, -- 0-99
    
    -- QB attributes
    throwing_power INTEGER DEFAULT 50,
    throwing_accuracy_short INTEGER DEFAULT 50,
    throwing_accuracy_medium INTEGER DEFAULT 50,
    throwing_accuracy_deep INTEGER DEFAULT 50,
    play_action INTEGER DEFAULT 50,
    throw_on_run INTEGER DEFAULT 50,
    
    -- RB/WR/TE attributes
    speed INTEGER DEFAULT 50,
    acceleration INTEGER DEFAULT 50,
    agility INTEGER DEFAULT 50,
    carrying INTEGER DEFAULT 50,
    catching INTEGER DEFAULT 50,
    catch_in_traffic INTEGER DEFAULT 50,
    route_running INTEGER DEFAULT 50,
    release INTEGER DEFAULT 50,
    
    -- Blocking attributes
    pass_block INTEGER DEFAULT 50,
    run_block INTEGER DEFAULT 50,
    lead_block INTEGER DEFAULT 50,
    impact_blocking INTEGER DEFAULT 50,
    
    -- Defensive attributes
    tackle INTEGER DEFAULT 50,
    hit_power INTEGER DEFAULT 50,
    block_shedding INTEGER DEFAULT 50,
    pursuit INTEGER DEFAULT 50,
    play_recognition INTEGER DEFAULT 50,
    man_coverage INTEGER DEFAULT 50,
    zone_coverage INTEGER DEFAULT 50,
    press INTEGER DEFAULT 50,
    
    -- Physical attributes
    strength INTEGER DEFAULT 50,
    jumping INTEGER DEFAULT 50,
    stamina INTEGER DEFAULT 50,
    injury_resistance INTEGER DEFAULT 50,
    
    -- Mental attributes
    awareness INTEGER DEFAULT 50,
    football_iq INTEGER DEFAULT 50,
    toughness INTEGER DEFAULT 50,
    
    -- Special teams
    kick_power INTEGER DEFAULT 50,
    kick_accuracy INTEGER DEFAULT 50,
    punt_power INTEGER DEFAULT 50,
    punt_accuracy INTEGER DEFAULT 50,
    
    UNIQUE(player_id)
);

-- Season statistics
CREATE TABLE IF NOT EXISTS nfl_player_season_stats (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES nfl_players(id) ON DELETE CASCADE,
    season INTEGER NOT NULL,
    
    -- Games played
    games_played INTEGER DEFAULT 0,
    games_started INTEGER DEFAULT 0,
    
    -- Passing stats
    pass_attempts INTEGER DEFAULT 0,
    pass_completions INTEGER DEFAULT 0,
    pass_yards INTEGER DEFAULT 0,
    pass_touchdowns INTEGER DEFAULT 0,
    interceptions INTEGER DEFAULT 0,
    sacks_taken INTEGER DEFAULT 0,
    
    -- Rushing stats
    rush_attempts INTEGER DEFAULT 0,
    rush_yards INTEGER DEFAULT 0,
    rush_touchdowns INTEGER DEFAULT 0,
    fumbles INTEGER DEFAULT 0,
    
    -- Receiving stats
    receptions INTEGER DEFAULT 0,
    receiving_yards INTEGER DEFAULT 0,
    receiving_touchdowns INTEGER DEFAULT 0,
    targets INTEGER DEFAULT 0,
    drops INTEGER DEFAULT 0,
    
    -- Defensive stats
    tackles_total INTEGER DEFAULT 0,
    tackles_for_loss INTEGER DEFAULT 0,
    sacks DECIMAL(4,1) DEFAULT 0,
    forced_fumbles INTEGER DEFAULT 0,
    fumbles_recovered INTEGER DEFAULT 0,
    interceptions_defense INTEGER DEFAULT 0,
    pass_deflections INTEGER DEFAULT 0,
    defensive_touchdowns INTEGER DEFAULT 0,
    
    -- Special teams stats
    field_goals_made INTEGER DEFAULT 0,
    field_goals_attempted INTEGER DEFAULT 0,
    extra_points_made INTEGER DEFAULT 0,
    extra_points_attempted INTEGER DEFAULT 0,
    punts INTEGER DEFAULT 0,
    punt_yards INTEGER DEFAULT 0,
    kickoff_returns INTEGER DEFAULT 0,
    kickoff_return_yards INTEGER DEFAULT 0,
    punt_returns INTEGER DEFAULT 0,
    punt_return_yards INTEGER DEFAULT 0,
    
    UNIQUE(player_id, season)
);

-- Game schedule
CREATE TABLE IF NOT EXISTS nfl_games (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES nfl_saves(id) ON DELETE CASCADE,
    season INTEGER NOT NULL,
    week INTEGER NOT NULL,
    home_team_id INTEGER REFERENCES nfl_teams(id) ON DELETE CASCADE,
    away_team_id INTEGER REFERENCES nfl_teams(id) ON DELETE CASCADE,
    home_score INTEGER DEFAULT 0,
    away_score INTEGER DEFAULT 0,
    is_played BOOLEAN DEFAULT false,
    is_playoff BOOLEAN DEFAULT false,
    game_type VARCHAR(20), -- regular, wildcard, divisional, conference, superbowl
    played_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Game statistics (individual player performance in a game)
CREATE TABLE IF NOT EXISTS nfl_game_stats (
    id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES nfl_games(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES nfl_players(id) ON DELETE CASCADE,
    
    -- Same stat categories as season stats but for individual games
    pass_attempts INTEGER DEFAULT 0,
    pass_completions INTEGER DEFAULT 0,
    pass_yards INTEGER DEFAULT 0,
    pass_touchdowns INTEGER DEFAULT 0,
    interceptions INTEGER DEFAULT 0,
    rush_attempts INTEGER DEFAULT 0,
    rush_yards INTEGER DEFAULT 0,
    rush_touchdowns INTEGER DEFAULT 0,
    receptions INTEGER DEFAULT 0,
    receiving_yards INTEGER DEFAULT 0,
    receiving_touchdowns INTEGER DEFAULT 0,
    tackles_total INTEGER DEFAULT 0,
    sacks DECIMAL(4,1) DEFAULT 0,
    
    UNIQUE(game_id, player_id)
);

-- Draft class (for future draft prospects)
CREATE TABLE IF NOT EXISTS nfl_draft_prospects (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES nfl_saves(id) ON DELETE CASCADE,
    draft_year INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(10) NOT NULL,
    college VARCHAR(100),
    age INTEGER,
    overall_rating INTEGER DEFAULT 50,
    potential INTEGER DEFAULT 50,
    is_drafted BOOLEAN DEFAULT false,
    drafted_by_team_id INTEGER REFERENCES nfl_teams(id) ON DELETE SET NULL,
    draft_round INTEGER,
    draft_pick INTEGER
);

-- Team depth chart
CREATE TABLE IF NOT EXISTS nfl_depth_chart (
    id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES nfl_teams(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES nfl_players(id) ON DELETE CASCADE,
    position VARCHAR(10) NOT NULL,
    depth_order INTEGER NOT NULL, -- 1 = starter, 2 = backup, etc.
    UNIQUE(team_id, position, depth_order)
);

-- Coaching staff
CREATE TABLE IF NOT EXISTS nfl_coaches (
    id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES nfl_teams(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL, -- Head Coach, OC, DC, etc.
    age INTEGER,
    years_experience INTEGER DEFAULT 0,
    offense_rating INTEGER DEFAULT 50,
    defense_rating INTEGER DEFAULT 50,
    player_development INTEGER DEFAULT 50,
    game_planning INTEGER DEFAULT 50
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_nfl_players_team_id ON nfl_players(team_id);
CREATE INDEX IF NOT EXISTS idx_nfl_players_position ON nfl_players(position);
CREATE INDEX IF NOT EXISTS idx_nfl_games_season_week ON nfl_games(season, week);
CREATE INDEX IF NOT EXISTS idx_nfl_player_season_stats_player ON nfl_player_season_stats(player_id, season);
CREATE INDEX IF NOT EXISTS idx_nfl_teams_save_id ON nfl_teams(save_id);
