-- MMA Simulation (OFA) Database Schema

-- Users table for authentication and save games
CREATE TABLE IF NOT EXISTS mma_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Save games (promotions)
CREATE TABLE IF NOT EXISTS mma_saves (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES mma_users(id) ON DELETE CASCADE,
    promotion_name VARCHAR(100) NOT NULL,
    current_week INTEGER DEFAULT 1,
    current_year INTEGER NOT NULL,
    budget INTEGER DEFAULT 1000000, -- Starting budget
    reputation INTEGER DEFAULT 50, -- Promotion reputation 0-100
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, promotion_name)
);

-- Weight classes
CREATE TABLE IF NOT EXISTS mma_weight_classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    weight_limit INTEGER NOT NULL, -- in pounds
    weight_order INTEGER NOT NULL, -- for sorting (1 = lightest)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default weight classes
INSERT INTO mma_weight_classes (name, weight_limit, weight_order) VALUES
    ('Flyweight', 125, 1),
    ('Bantamweight', 135, 2),
    ('Featherweight', 145, 3),
    ('Lightweight', 155, 4),
    ('Welterweight', 170, 5),
    ('Middleweight', 185, 6),
    ('Light Heavyweight', 205, 7),
    ('Heavyweight', 265, 8)
ON CONFLICT (name) DO NOTHING;

-- Fighting styles
CREATE TABLE IF NOT EXISTS mma_fighting_styles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default fighting styles
INSERT INTO mma_fighting_styles (name, description) VALUES
    ('Striker', 'Focuses on striking and stand-up fighting'),
    ('Grappler', 'Specializes in takedowns and ground control'),
    ('Wrestler', 'Strong wrestling base with takedown defense'),
    ('Jiu-Jitsu', 'Expert in submissions and ground game'),
    ('Muay Thai', 'Elite striking with clinch work'),
    ('Boxing', 'Pure boxing with head movement'),
    ('Kickboxing', 'Balanced striking with kicks'),
    ('Brawler', 'Aggressive all-out fighting style'),
    ('Balanced', 'Well-rounded in all areas')
ON CONFLICT (name) DO NOTHING;

-- Fighters table
CREATE TABLE IF NOT EXISTS mma_fighters (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES mma_saves(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    nickname VARCHAR(50),
    age INTEGER NOT NULL,
    weight_class_id INTEGER REFERENCES mma_weight_classes(id),
    fighting_style_id INTEGER REFERENCES mma_fighting_styles(id),
    nationality VARCHAR(50),
    height INTEGER, -- inches
    weight INTEGER, -- pounds
    reach INTEGER, -- inches
    
    -- Record
    wins INTEGER DEFAULT 0,
    losses INTEGER DEFAULT 0,
    draws INTEGER DEFAULT 0,
    no_contests INTEGER DEFAULT 0,
    
    -- Win breakdown
    wins_ko INTEGER DEFAULT 0,
    wins_submission INTEGER DEFAULT 0,
    wins_decision INTEGER DEFAULT 0,
    
    -- Status
    is_champion BOOLEAN DEFAULT false,
    ranking INTEGER, -- 1-15 or NULL if unranked
    is_injured BOOLEAN DEFAULT false,
    injury_weeks INTEGER DEFAULT 0,
    contract_fights INTEGER DEFAULT 0,
    contract_pay INTEGER DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fighter attributes (22 trainable attributes from OFA)
CREATE TABLE IF NOT EXISTS mma_fighter_attributes (
    id SERIAL PRIMARY KEY,
    fighter_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    
    -- Overall ratings
    overall_rating INTEGER DEFAULT 50, -- 0-100
    potential INTEGER DEFAULT 50, -- 0-100
    
    -- Striking attributes
    punching_power INTEGER DEFAULT 50,
    punching_speed INTEGER DEFAULT 50,
    punching_accuracy INTEGER DEFAULT 50,
    kicking_power INTEGER DEFAULT 50,
    kicking_speed INTEGER DEFAULT 50,
    kicking_accuracy INTEGER DEFAULT 50,
    head_movement INTEGER DEFAULT 50,
    footwork INTEGER DEFAULT 50,
    
    -- Grappling attributes
    takedown_offense INTEGER DEFAULT 50,
    takedown_defense INTEGER DEFAULT 50,
    ground_control INTEGER DEFAULT 50,
    ground_strike INTEGER DEFAULT 50,
    submission_offense INTEGER DEFAULT 50,
    submission_defense INTEGER DEFAULT 50,
    clinch_offense INTEGER DEFAULT 50,
    clinch_defense INTEGER DEFAULT 50,
    
    -- Physical attributes
    stamina INTEGER DEFAULT 50,
    cardio INTEGER DEFAULT 50,
    chin INTEGER DEFAULT 50, -- Ability to take damage
    recovery INTEGER DEFAULT 50,
    
    -- Mental attributes
    fight_iq INTEGER DEFAULT 50,
    composure INTEGER DEFAULT 50,
    
    UNIQUE(fighter_id)
);

-- Championships
CREATE TABLE IF NOT EXISTS mma_championships (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES mma_saves(id) ON DELETE CASCADE,
    weight_class_id INTEGER REFERENCES mma_weight_classes(id),
    champion_id INTEGER REFERENCES mma_fighters(id) ON DELETE SET NULL,
    title_defenses INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(save_id, weight_class_id)
);

-- Events (fight cards)
CREATE TABLE IF NOT EXISTS mma_events (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES mma_saves(id) ON DELETE CASCADE,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    venue VARCHAR(100),
    city VARCHAR(100),
    is_completed BOOLEAN DEFAULT false,
    total_revenue INTEGER DEFAULT 0,
    total_cost INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fights
CREATE TABLE IF NOT EXISTS mma_fights (
    id SERIAL PRIMARY KEY,
    event_id INTEGER REFERENCES mma_events(id) ON DELETE CASCADE,
    fighter1_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    fighter2_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    weight_class_id INTEGER REFERENCES mma_weight_classes(id),
    
    -- Fight details
    is_title_fight BOOLEAN DEFAULT false,
    is_main_event BOOLEAN DEFAULT false,
    scheduled_rounds INTEGER DEFAULT 3, -- 3 or 5
    fight_order INTEGER, -- Position on card
    
    -- Results (NULL if not fought yet)
    winner_id INTEGER REFERENCES mma_fighters(id) ON DELETE SET NULL,
    method VARCHAR(20), -- KO, TKO, Submission, Decision, Draw, NC
    round_ended INTEGER,
    time_ended VARCHAR(10), -- MM:SS format
    
    -- Detailed result info
    is_knockout BOOLEAN DEFAULT false,
    is_submission BOOLEAN DEFAULT false,
    is_decision BOOLEAN DEFAULT false,
    submission_type VARCHAR(50), -- RNC, Armbar, Triangle, etc.
    
    -- Fight stats
    fighter1_strikes_landed INTEGER DEFAULT 0,
    fighter2_strikes_landed INTEGER DEFAULT 0,
    fighter1_strikes_attempted INTEGER DEFAULT 0,
    fighter2_strikes_attempted INTEGER DEFAULT 0,
    fighter1_takedowns INTEGER DEFAULT 0,
    fighter2_takedowns INTEGER DEFAULT 0,
    fighter1_control_time INTEGER DEFAULT 0, -- seconds
    fighter2_control_time INTEGER DEFAULT 0,
    
    -- Judges scores (if decision)
    judge1_score_f1 INTEGER,
    judge1_score_f2 INTEGER,
    judge2_score_f1 INTEGER,
    judge2_score_f2 INTEGER,
    judge3_score_f1 INTEGER,
    judge3_score_f2 INTEGER,
    
    is_simulated BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fight play-by-play (round-by-round details)
CREATE TABLE IF NOT EXISTS mma_fight_rounds (
    id SERIAL PRIMARY KEY,
    fight_id INTEGER REFERENCES mma_fights(id) ON DELETE CASCADE,
    round_number INTEGER NOT NULL,
    
    -- Round stats
    fighter1_strikes INTEGER DEFAULT 0,
    fighter2_strikes INTEGER DEFAULT 0,
    fighter1_damage_dealt INTEGER DEFAULT 0,
    fighter2_damage_dealt INTEGER DEFAULT 0,
    fighter1_takedowns INTEGER DEFAULT 0,
    fighter2_takedowns INTEGER DEFAULT 0,
    
    -- Round events
    knockdown_by_fighter1 BOOLEAN DEFAULT false,
    knockdown_by_fighter2 BOOLEAN DEFAULT false,
    submission_attempt_f1 INTEGER DEFAULT 0,
    submission_attempt_f2 INTEGER DEFAULT 0,
    
    -- Judge scores for this round
    judge1_winner INTEGER, -- fighter ID
    judge2_winner INTEGER,
    judge3_winner INTEGER,
    
    round_summary TEXT,
    
    UNIQUE(fight_id, round_number)
);

-- Rankings
CREATE TABLE IF NOT EXISTS mma_rankings (
    id SERIAL PRIMARY KEY,
    save_id INTEGER REFERENCES mma_saves(id) ON DELETE CASCADE,
    weight_class_id INTEGER REFERENCES mma_weight_classes(id),
    fighter_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    rank INTEGER NOT NULL, -- 1-15
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(save_id, weight_class_id, rank)
);

-- Training camps (fighter improvement over time)
CREATE TABLE IF NOT EXISTS mma_training_camps (
    id SERIAL PRIMARY KEY,
    fighter_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    training_focus VARCHAR(50) NOT NULL, -- striking, grappling, conditioning, etc.
    weeks_trained INTEGER DEFAULT 0,
    improvement_points INTEGER DEFAULT 0,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

-- Fighter career statistics
CREATE TABLE IF NOT EXISTS mma_fighter_career_stats (
    id SERIAL PRIMARY KEY,
    fighter_id INTEGER REFERENCES mma_fighters(id) ON DELETE CASCADE,
    
    -- Aggregate stats across all fights
    total_fights INTEGER DEFAULT 0,
    total_rounds_fought INTEGER DEFAULT 0,
    total_strikes_landed INTEGER DEFAULT 0,
    total_strikes_attempted INTEGER DEFAULT 0,
    total_takedowns INTEGER DEFAULT 0,
    total_knockdowns INTEGER DEFAULT 0,
    total_submissions_attempted INTEGER DEFAULT 0,
    
    -- Performance metrics
    striking_accuracy DECIMAL(5,2) DEFAULT 0,
    takedown_accuracy DECIMAL(5,2) DEFAULT 0,
    average_fight_time DECIMAL(5,2) DEFAULT 0, -- minutes
    
    -- Title fight record
    title_fights INTEGER DEFAULT 0,
    title_fight_wins INTEGER DEFAULT 0,
    
    UNIQUE(fighter_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_mma_fighters_weight_class ON mma_fighters(weight_class_id);
CREATE INDEX IF NOT EXISTS idx_mma_fighters_style ON mma_fighters(fighting_style_id);
CREATE INDEX IF NOT EXISTS idx_mma_fights_event ON mma_fights(event_id);
CREATE INDEX IF NOT EXISTS idx_mma_rankings_weight_class ON mma_rankings(weight_class_id);
CREATE INDEX IF NOT EXISTS idx_mma_events_date ON mma_events(event_date);
CREATE INDEX IF NOT EXISTS idx_mma_fighters_save_id ON mma_fighters(save_id);
