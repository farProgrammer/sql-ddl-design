-- Create schemas

-- Create tables
DROP DATABASE IF EXISTS soccer_league_db;

CREATE DATABASE soccer_league_db;

\c soccer_league_db

CREATE TABLE IF NOT EXISTS teams
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL UNIQUE,
    player_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS goals
(
    id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS games
(
    id SERIAL PRIMARY KEY,
    team1_id INTEGER NOT NULL,
    team2_id INTEGER NOT NULL,
    score_team1 INTEGER NOT NULL,
    score_team2 INTEGER NOT NULL,
    date DATE NOT NULL,
    ref_id INTEGER NOT NULL,
    season_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS players
(
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(25) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    team_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS referees
(
    id SERIAL PRIMARY KEY,
    last_name VARCHAR(25) NOT NULL,
    first_name VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS season
(
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS results
(
    id SERIAL PRIMARY KEY,
    team_id INTEGER NOT NULL,
    ranking INTEGER
);


-- Create FKs
ALTER TABLE goals
    ADD    FOREIGN KEY (player_id)
    REFERENCES players(id)
    ON DELETE SET NULL
;
    
ALTER TABLE goals
    ADD    FOREIGN KEY (game_id)
    REFERENCES games(id)
;
    
ALTER TABLE players
    ADD    FOREIGN KEY (team_id)
    REFERENCES teams(id)
;
    
ALTER TABLE games
    ADD    FOREIGN KEY (team1_id)
    REFERENCES teams(id)
;
    
ALTER TABLE games
    ADD    FOREIGN KEY (team2_id)
    REFERENCES teams(id)
;
    
ALTER TABLE games
    ADD    FOREIGN KEY (ref_id)
    REFERENCES referees(id)
;
    
ALTER TABLE games
    ADD    FOREIGN KEY (season_id)
    REFERENCES season(id)
;
    
ALTER TABLE results
    ADD    FOREIGN KEY (team_id)
    REFERENCES teams(id)
;
    

-- Create Indexes

