DROP DATABASE vgms;

CREATE DATABASE vgms;

USE vgms;

-- ADMININSTRATIVE TABLES ---------------------------------------------
-- ADMININSTRATIVE TABLES ---------------------------------------------
-- ADMININSTRATIVE TABLES ---------------------------------------------

CREATE TABLE userRoles (
userRoleID           INT PRIMARY KEY                NOT NULL,
userRoleTitle        VARCHAR(256)                   NOT NULL
)
;

INSERT INTO userRoles VALUES (1,'root')
;

CREATE TABLE users (
userID           INT PRIMARY KEY                NOT NULL,
userNameFirst    VARCHAR(64)                    NOT NULL,
userNameLast     VARCHAR(64)                    NOT NULL,
userRoleID       INT                            NOT NULL,
dateCreated      DATETIME                       NOT NULL,
userCreated      INT                            NOT NULL,
dateUpdated      DATETIME                       NOT NULL,
userUpdated      INT                            NOT NULL,
FOREIGN KEY (userRoleID) REFERENCES userRoles(userRoleID)
)
;

INSERT INTO users VALUES (1,'Root','User', 1, getDate(), 1, getDate(), 1)
;

ALTER TABLE users 
ADD FOREIGN KEY (userCreated) REFERENCES users(userID);

ALTER TABLE users 
ADD FOREIGN KEY (userUpdated) REFERENCES users(userID)
;

-- CONTROLLED VOCABULARY TABLES ---------------------------------------
-- CONTROLLED VOCABULARY TABLES ---------------------------------------
-- CONTROLLED VOCABULARY TABLES ---------------------------------------

CREATE TABLE progressions (
progressionID    INT PRIMARY KEY                NOT NULL,
progressionTitle VARCHAR(256)                   NOT NULL,
progressionSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE gameplayGenres (
gameplayGenreID    INT PRIMARY KEY                    NOT NULL,
gameplayGenreTitle VARCHAR(256)                       NOT NULL,
gameplayGenreBT    INT                                    NULL,
gameplayGenreSN    VARCHAR(1024)                          NULL,
gameplayGenreUSE   INT                                    NULL
)
;

CREATE TABLE gameTitleTypes (
gameTitleTypeID    INT PRIMARY KEY                    NOT NULL,
gameTitleTypeTitle VARCHAR(256)                       NOT NULL,
gameTitleTypeSN    VARCHAR(1024)                          NULL
)
;
CREATE TABLE additionalContentTypes (
additionalContentTypeID    INT PRIMARY KEY                NOT NULL,
additionalContentTypeTitle VARCHAR(256)                   NOT NULL,
additionalContentTypeSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE dimensions (
dimensionID    INT PRIMARY KEY                NOT NULL,
dimensionTitle VARCHAR(256)                   NOT NULL,
dimensionSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE pointsOfView (
pointOfViewID    INT PRIMARY KEY                NOT NULL,
pointOfViewTitle VARCHAR(256)                   NOT NULL,
pointOfViewSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE networkedFeatures (
networkedFeatureID    INT PRIMARY KEY                NOT NULL,
networkedFeatureTitle VARCHAR(256)                   NOT NULL,
nnetworkedFeatureSN   VARCHAR(1024)                      NULL
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'moods')
CREATE TABLE moods (
moodID      INT PRIMARY KEY                NOT NULL,
moodTitle   VARCHAR(256)                   NOT NULL,
moodSN      VARCHAR(1024)                      NULL,
moodUSE     INT                                NULL
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tropes')
CREATE TABLE tropes  (
tropeID     INT PRIMARY KEY                NOT NULL,
tropeTitle  VARCHAR(256)                   NOT NULL,
tropeBT     INT                                NULL,
tropeSN     VARCHAR(1024)                      NULL,
tropeUSE    INT                                NULL,
tropeActive BIT                            NOT NULL,
FOREIGN KEY (tropeBT) REFERENCES tropes(tropeID)  
)
;

CREATE TABLE themes (
themeID    INT PRIMARY KEY                    NOT NULL,
themeTitle VARCHAR(256)                       NOT NULL,
themeBT    INT                                    NULL,
themeSN    VARCHAR(1024)                          NULL,
themeUSE   INT                                    NULL,
FOREIGN KEY (themeBT) REFERENCES themes(themeID)  
);

CREATE TABLE worlds (
worldID    INT PRIMARY KEY                NOT NULL,
worldTitle VARCHAR(256)                   NOT NULL,
worldSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE agentRoles (
agentRoleID    INT PRIMARY KEY                NOT NULL,
agentRoleTitle VARCHAR(256)                   NOT NULL,
agentRoleSN    VARCHAR(1024)                      NULL
)
;

CREATE TABLE narrativeGenres (
narrativeGenreID     INT PRIMARY KEY                NOT NULL,
narrativeGenreTitle  VARCHAR(256)                   NOT NULL,
narrativeGenreBT     INT                                NULL,
narrativeGenreSN     VARCHAR(1024)                      NULL,
narrativeGenreUSE    INT                                NULL
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'pacingsBattleSystems')
CREATE TABLE pacingsBattleSystems (
pacingsBattleSystemID    INT PRIMARY KEY                NOT NULL,
pacingsBattleSystemTitle VARCHAR(256)                   NOT NULL,
pacingsBattleSystemSN    VARCHAR(1014)                      NULL
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'pacingsInGameClocks')
CREATE TABLE pacingsInGameClocks (
pacingsInGameClockID    INT PRIMARY KEY                NOT NULL,
pacingsInGameClockTitle VARCHAR(64)                    NOT NULL,
pacingsInGameClockSN    VARCHAR(1024)                      NULL
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'characterTropes')
CREATE TABLE characterTropes (
characterTropeID    INT PRIMARY KEY                NOT NULL,
characterTropeTitle VARCHAR(256)                   NOT NULL,
characterTropeSN    VARCHAR(1024)                      NULL,
characterTropeUSE   INT                                NULL
)
;
CREATE TABLE places (
placeID    INT PRIMARY KEY                NOT NULL,
placeTitle VARCHAR(256)                   NOT NULL,
placeBT    INT                                NULL,
placeSN    VARCHAR(1024)                      NULL,
placeUSE   INT                                NULL
);

CREATE TABLE times (
timeID    INT PRIMARY KEY                NOT NULL,
timeTitle VARCHAR(256)                   NOT NULL,
timeBT    INT                                NULL,
timeSN    VARCHAR(1024)                      NULL,
timeUSE   INT                                NULL,
FOREIGN KEY (timeBT) REFERENCES times(timeID)
);

CREATE TABLE ratingAgencies (
ratingAgencyID    INT PRIMARY KEY                NOT NULL,
ratingAgencyTitle VARCHAR(256)                   NOT NULL,
note              VARCHAR(1024)                      NULL
)
;

CREATE TABLE ratings (
ratingID       INT PRIMARY KEY                NOT NULL,
ratingAgencyID INT                            NOT NULL,
ratingType     VARCHAR(256)                   NOT NULL,
rating         VARCHAR(256)                   NOT NULL,
FOREIGN KEY (ratingAgencyID) REFERENCES ratingAgencies(ratingAgencyID)
)
;

CREATE TABLE ratingDescriptors (
ratingDescriptorID    INT PRIMARY KEY                NOT NULL,
ratingDescriptorTitle VARCHAR(256)                   NOT NULL
)
;

CREATE TABLE languages(
languageID    INT PRIMARY KEY                NOT NULL,
languageTitle VARCHAR(256)                   NOT NULL
)
;

CREATE TABLE appeals (
appealID	INT PRIMARY KEY                NOT NULL,
appealTitle VARCHAR(256)                   NOT NULL,
appealsSN   VARCHAR(1024)                      NULL
)
;

-- SCHEMA ENTITIES ----------------------------------------------------
-- SCHEMA ENTITIES ----------------------------------------------------
-- SCHEMA ENTITIES ----------------------------------------------------

CREATE TABLE games (
gameID                  INT PRIMARY KEY                   NOT NULL,
gameTitleTranscribed    VARCHAR(256)                       NOT NULL,
summary                 NTEXT                               NULL,
progression             INT                                    NULL,
note                    NTEXT                               NULL,
dateCreated             DATETIME                           NOT NULL,
userCreated             INT                                NOT NULL,
dateUpdated             DATETIME                           NOT NULL,
userUpdated             INT                                NOT NULL,
pacingTimeManipulation  BIT                                    NULL,
FOREIGN KEY (progression) REFERENCES progressions(progressionID),
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)
)    
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'gameTitles')
CREATE TABLE gameTitles (
gameTitleID     INT PRIMARY KEY                NOT NULL,
gameID          INT                            NOT NULL,
gameTitleTypeID INT                            NOT NULL,
gameTitle       VARCHAR(256)                   NOT NULL,
sic             BIT                                NULL,
dateCreated     DATETIME                       NOT NULL,
userCreated     INT                            NOT NULL,
dateUpdated     DATETIME                       NOT NULL,
userUpdated     INT                            NOT NULL,
FOREIGN KEY (gameID)          REFERENCES games(gameID),
FOREIGN KEY (gameTitleTypeID) REFERENCES gameTitleTypes(gameTitleTypeID),
FOREIGN KEY (userCreated)     REFERENCES users(userID),
FOREIGN KEY (userUpdated)     REFERENCES users(userID),
UNIQUE      (gameTitle, gameID, gameTitleTypeID)
)
;

CREATE TABLE additionalContent (
additionalContentID    INT PRIMARY KEY                NOT NULL,
additionalContentTitle VARCHAR(256)                   NOT NULL,
verisonRequirement     VARCHAR(256)                       NULL,
note                   TEXT                               NULL,
dateCreated            DATETIME                       NOT NULL,
userCreated            INT                            NOT NULL,
dateUpdated            DATETIME                       NOT NULL,
userUpdated            INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)
)
;

CREATE TABLE collections (
collectionID      INT PRIMARY KEY                NOT NULL,
collectionTitle   VARCHAR(256)                   NOT NULL,
note              TEXT                               NULL,
dateCreated       DATETIME                       NOT NULL,
userCreated       INT                            NOT NULL,
dateUpdated       DATETIME                       NOT NULL,
userUpdated       INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)
)
;

CREATE TABLE editions (
editionID                   INT PRIMARY KEY                NOT NULL,
editionTitle                VARCHAR(256)                   NOT NULL,
gameID                      INT                            NOT NULL,
platformID                  INT                            NOT NULL,
systemRequirementsMin       TEXT                               NULL,
systemRequirementsRec       TEXT                               NULL,
specialHardwareReq          TEXT                               NULL,
specialHardwareRec          TEXT                               NULL,
networkedFeatures           TEXT                               NULL,
connectivityMethodID        INT                                NULL,
connectivityNetworkType     TEXT                               NULL,
connectivityBandwidth       TEXT                               NULL,
numberOfUsers               TEXT                               NULL,
typeOfEndingEnds            BIT                                NULL,
typeOfEndingMultiple        BIT                                NULL,
typeOfEndingPostgameContent BIT                                NULL,
dimensionID                 INT                                NULL,
pointOfViewID               INT                                NULL,
note                        NTEXT                           NULL,
relatedEditionID            INT                                NULL,
dateCreated                 DATETIME                       NOT NULL,
userCreated                 INT                            NOT NULL,
dateUpdated                 DATETIME                       NOT NULL,
userUpdated                 INT                            NOT NULL,
FOREIGN KEY (gameID)        REFERENCES games(gameID),
FOREIGN KEY (dimensionID)   REFERENCES dimensions(dimensionID),
FOREIGN KEY (pointOfViewID) REFERENCES pointsOfView(pointOfViewID),
FOREIGN KEY (userCreated)   REFERENCES users(userID),
FOREIGN KEY (userUpdated)   REFERENCES users(userID)
)    
;

CREATE TABLE localReleases(
localReleaseID                     INT PRIMARY KEY                NOT NULL,
editionID                          INT                            NOT NULL,
localReleaseTitle                  VARCHAR(256)                   NOT NULL,
localReleaseLanguage               CHAR(2)                        NOT NULL,
customizationOptionDifficultyLevel VARCHAR(1024)                  NOT NULL,
customizationOptionCharacter       INT			    			  NOT NULL,
mainEstCompTime                    TIME			   			      NOT NULL,
compEstCompTime                    TIME			                  NOT NULL,
versionHistory                     VARCHAR(256)		    	      NOT NULL,
note                               TEXT                               NULL,
dateCreated                        DATETIME                       NOT NULL,
userCreated                        INT                            NOT NULL,
dateUpdated                        DATETIME                       NOT NULL,
userUpdated                        INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (editionID) REFERENCES editions(editionID)
)
;

CREATE TABLE agents (  -- These are companies or organizations tied to the game.
agentID     INT PRIMARY KEY                NOT NULL,
agentTitle  VARCHAR(256)                   NOT NULL,
note        NTEXT                           NULL,
dateCreated DATETIME                       NOT NULL,
userCreated INT                            NOT NULL,
dateUpdated DATETIME                       NOT NULL,
userUpdated INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)
)
;

CREATE TABLE digitalPackages (
digitalPackageID  INT PRIMARY KEY                NOT NULL,
localReleaseID    INT                            NOT NULL,
titleType         VARCHAR(256)                   NOT NULL,
fileSize          VARCHAR(256)                       NULL,
retailReleaseDate DATETIME                           NULL,
drm               TINYINT                            NULL,
price             DECIMAL(13,2)                      NULL,
currency          CHAR(2)                            NULL,
note              NTEXT                           NULL,
dateCreated       DATETIME                       NOT NULL,
userCreated       INT                            NOT NULL,
dateUpdated       DATETIME                       NOT NULL,
userUpdated       INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY(localReleaseID) REFERENCES localReleases(localReleaseID)
)
;

CREATE TABLE trailers(
trailerID           INT PRIMARY KEY                NOT NULL,
trailerTitle        VARCHAR(256)                   NOT NULL,
url                 VARCHAR(256)                   NOT NULL,
note                TEXT            	               NULL,
dateCreated         DATETIME                       NOT NULL,
userCreated         INT                            NOT NULL,
dateUpdated         DATETIME                       NOT NULL,
userUpdated         INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)
) 
;

CREATE TABLE screenshots(
screenshotID         INT PRIMARY KEY                NOT NULL,
localReleaseID       INT                            NOT NULL,
url                  VARCHAR(256)                   NOT NULL,
creator              VARCHAR(256)                       NULL,
company              VARCHAR(256)                       NULL,
dateObtained         DATETIME                       NOT NULL,
artSource            VARCHAR(256)                   NOT NULL,
dateCreated          DATETIME                       NOT NULL,
userCreated          INT                            NOT NULL,
dateUpdated          DATETIME                       NOT NULL,
userUpdated          INT                            NOT NULL,
FOREIGN KEY (userCreated)    REFERENCES users(userID),
FOREIGN KEY (userUpdated)    REFERENCES users(userID),
FOREIGN KEY (localReleaseID) REFERENCES localReleases(localReleaseID)
)
;

CREATE TABLE representativeArtDigital(
representativeArtDigitalID INT PRIMARY KEY                NOT NULL,
digitalPackageID           INT                            NOT NULL,
url                        VARCHAR(256)                   NOT NULL,
creator                    VARCHAR(256)                       NULL,
company                    VARCHAR(256)                       NULL,
dateObtained               DATETIME                       NOT NULL,
note                       NTEXT                           NULL,
artSource                  VARCHAR(256)                   NOT NULL,
dateCreated                DATETIME                       NOT NULL,
userCreated                INT                            NOT NULL,
dateUpdated                DATETIME                       NOT NULL,
userUpdated                INT                            NOT NULL,
FOREIGN KEY (userCreated)     REFERENCES users(userID),
FOREIGN KEY (userUpdated)     REFERENCES users(userID),
FOREIGN KEY(digitalPackageID) REFERENCES digitalPackages(digitalPackageID)
)
;

CREATE TABLE series (
seriesID    INT PRIMARY KEY                NOT NULL,
seriesTitle VARCHAR(256)                   NOT NULL, 
note        NTEXT                           NULL, 
dateCreated DATETIME                       NOT NULL,
userCreated INT                            NOT NULL,
dateUpdated DATETIME                       NOT NULL,
userUpdated INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID) 
)
;

CREATE TABLE relations(
relationID    INT PRIMARY KEY                NOT NULL,
relationTitle VARCHAR(256)                   NOT NULL,
relationType  VARCHAR(256)                   NOT NULL,
dateCreated   DATETIME                       NOT NULL,
userCreated   INT                            NOT NULL,
dateUpdated   DATETIME                       NOT NULL,
userUpdated   INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID) 
)
;

CREATE TABLE franchises(
franchiseID    INT PRIMARY KEY                NOT NULL,
franchiseTitle VARCHAR(256)                   NOT NULL, 
note           NTEXT                           NULL ,
dateCreated    DATETIME                       NOT NULL,
userCreated    INT                            NOT NULL,
dateUpdated    DATETIME                       NOT NULL,
userUpdated    INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID)  
)
;

CREATE TABLE physicalPackages (
physicalPackageID   INT PRIMARY KEY                NOT NULL,
localReleaseID      INT                            NOT NULL,
additionalContentID INT                            NOT NULL,
pakageFormat        VARCHAR(256)                   NOT NULL,
regionCode          VARCHAR(256)                   NOT NULL,
retailReleaseDate   DATE                           NOT NULL,
packaging           VARCHAR(256)                       NULL,
drm                 TINYINT                            NULL,
price               VARCHAR(256)                       NULL,
note                VARCHAR(256)                       NULL,
dateCreated         DATETIME                       NOT NULL,
userCreated         INT                            NOT NULL,
dateUpdated         DATETIME                       NOT NULL,
userUpdated         INT                            NOT NULL,
FOREIGN KEY (userCreated)         REFERENCES users(userID),
FOREIGN KEY (userUpdated)         REFERENCES users(userID),
FOREIGN KEY (localReleaseID)      REFERENCES localReleases(localReleaseID),
FOREIGN KEY (additionalContentID) REFERENCES additionalContent(additionalContentID)
)
;

CREATE TABLE representativeArtPhysical (
representativeArtPhysicalID  INT PRIMARY KEY                NOT NULL,
physicalPackageID            INT                            NOT NULL,
url                          VARCHAR(256)                   NOT NULL,
creator                      VARCHAR(256)                       NULL,
company                      VARCHAR(256)                       NULL,
dateObtained                 DATETIME                       NOT NULL,
artSource                    VARCHAR(256)                   NOT NULL,
dateCreated                  DATETIME                       NOT NULL,
userCreated                  INT                            NOT NULL,
dateUpdated                  DATETIME                       NOT NULL,
userUpdated                  INT                            NOT NULL,
FOREIGN KEY (userCreated)      REFERENCES users(userID),
FOREIGN KEY (userUpdated)      REFERENCES users(userID),
FOREIGN KEY(physicalPackageID) REFERENCES physicalPackages(physicalPackageID)
)
;

CREATE TABLE gameplayVideos(
gameplayVideoID    INT PRIMARY KEY                NOT NULL,
gameplayVideoTitle VARCHAR(256)                   NOT NULL,
localReleaseID	   INT                            NOT NULL,
spoiler            BIT                            NOT NULL,
url       	       VARCHAR(256)                   NOT NULL,
note       	       TEXT                               NULL,
dateCreated        DATETIME                       NOT NULL,
userCreated        INT                            NOT NULL,
dateUpdated        DATETIME                       NOT NULL,
userUpdated        INT                            NOT NULL,
FOREIGN KEY (localReleaseID) REFERENCES localReleases(localReleaseID),
FOREIGN KEY (userCreated)    REFERENCES users(userID),
FOREIGN KEY (userUpdated)    REFERENCES users(userID)
)
;

-- CROSSTABLES -----------------------------------------------------
-- CROSSTABLES -----------------------------------------------------
-- CROSSTABLES -----------------------------------------------------

CREATE TABLE game_x_gameplayGenre (
game_x_gameplayGenreID INT PRIMARY KEY                NOT NULL,
gameID                 INT                            NOT NULL,
gameplayGenreID        INT                            NOT NULL,
dateCreated            DATETIME                       NOT NULL,
userCreated            INT                            NOT NULL,
dateUpdated            DATETIME                       NOT NULL,
userUpdated            INT                            NOT NULL,
FOREIGN KEY (gameID)          REFERENCES games(gameID),
FOREIGN KEY (gameplayGenreID) REFERENCES gameplayGenres(gameplayGenreID),
FOREIGN KEY (userCreated)     REFERENCES users(userID),
FOREIGN KEY (userUpdated)     REFERENCES users(userID),
UNIQUE (gameID, gameplayGenreID)    
)
;

CREATE TABLE additionalContent_x_collection (
additionalContent_x_collectionID INT PRIMARY KEY                NOT NULL,
additionalContentID              INT                            NOT NULL,
collectionID                     INT                            NOT NULL,
dateCreated                      DATETIME                       NOT NULL,
userCreated                      INT                            NOT NULL,
dateUpdated                      DATETIME                       NOT NULL,
userUpdated                      INT                            NOT NULL,
FOREIGN KEY (additionalContentID) REFERENCES additionalContent(additionalContentID),
FOREIGN KEY (collectionID)        REFERENCES collections(collectionID),
FOREIGN KEY (userCreated)         REFERENCES users(userID),
FOREIGN KEY (userUpdated)         REFERENCES users(userID)
)
;

CREATE TABLE appeal_x_game (
appeal_x_gameD INT PRIMARY KEY                NOT NULL,
appealID       INT                            NOT NULL,
gameID         INT                            NOT NULL,
dateCreated    DATETIME                       NOT NULL,
userCreated    INT                            NOT NULL,
dateUpdated    DATETIME                       NOT NULL,
userUpdated    INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (appealID)    REFERENCES appeals(appealID),
FOREIGN KEY (gameID)      REFERENCES games(gameID),
UNIQUE (appealID, gameID)
)
;

CREATE TABLE physicalPackage_x_additionalContent (
physicalPackage_x_additionalContentID INT PRIMARY KEY                NOT NULL,
additionalContentID                   INT                            NOT NULL,
physicalPackageID                     INT                            NOT NULL,
dateCreated                           DATETIME                       NOT NULL,
userCreated                           INT                            NOT NULL,
dateUpdated                           DATETIME                       NOT NULL,
userUpdated                           INT                            NOT NULL,
FOREIGN KEY (userCreated)         REFERENCES users(userID),
FOREIGN KEY (userUpdated)         REFERENCES users(userID),
FOREIGN KEY (additionalContentID) REFERENCES additionalContent(additionalContentID),
FOREIGN KEY (physicalPackageID)   REFERENCES physicalPackages(physicalPackageID),
UNIQUE (additionalContentID, physicalPackageID)
)
;

CREATE TABLE additionalContent_x_additionalContentType (
additionalContent_x_additionalContentTypeID INT PRIMARY KEY                NOT NULL,
additionalContentID                         INT                            NOT NULL,
additionalContentTypeID                     INT                            NOT NULL,
dateCreated                                 DATETIME                       NOT NULL,
userCreated                                 INT                            NOT NULL,
dateUpdated                                 DATETIME                       NOT NULL,
userUpdated                                 INT                            NOT NULL,
FOREIGN KEY (userCreated)             REFERENCES users(userID),
FOREIGN KEY (userUpdated)             REFERENCES users(userID),
FOREIGN KEY (additionalContentID)     REFERENCES additionalContent(additionalContentID),
FOREIGN KEY (additionalContentTypeID) REFERENCES additionalContentTypes(additionalContentTypeID),
UNIQUE (additionalContentID, additionalContentTypeID)
)
;

CREATE TABLE physicalPackage_x_colection (
physicalPackage_x_colection INT PRIMARY KEY                NOT NULL,
physicalPackageID           INT                            NOT NULL,
collectionID                INT                            NOT NULL,
dateCreated                 DATETIME                       NOT NULL,
userCreated                 INT                            NOT NULL,
dateUpdated                 DATETIME                       NOT NULL,
userUpdated                 INT                            NOT NULL,
FOREIGN KEY (userCreated)       REFERENCES users(userID),
FOREIGN KEY (userUpdated)       REFERENCES users(userID),
FOREIGN KEY (physicalPackageID) REFERENCES physicalPackages(physicalPackageID),
FOREIGN KEY (collectionID)      REFERENCES collections(collectionID),
UNIQUE (collectionID, physicalPackageID)
)
;

CREATE TABLE franchise_x_relation (
franchise_x_relationID INT PRIMARY KEY                NOT NULL,
franchiseID            INT                            NOT NULL,
relationID             INT                            NOT NULL,
dateCreated            DATETIME                       NOT NULL,
userCreated            INT                            NOT NULL,
dateUpdated            DATETIME                       NOT NULL,
userUpdated            INT                            NOT NULL,
FOREIGN KEY (userCreated)  REFERENCES users(userID),
FOREIGN KEY (userUpdated)  REFERENCES users(userID), 
FOREIGN KEY (franchiseID)  REFERENCES franchises(franchiseID),
FOREIGN KEY (relationID)   REFERENCES relations(relationID),
UNIQUE      (franchiseID, relationID)
)
;

CREATE TABLE series_x_relation (
series_x_relationID INT PRIMARY KEY                NOT NULL,
seriesID            INT                            NOT NULL,
relationID          INT                            NOT NULL,
dateCreated         DATETIME                       NOT NULL,
userCreated         INT                            NOT NULL,
dateUpdated         DATETIME                       NOT NULL,
userUpdated         INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (seriesID)    REFERENCES series(seriesID),
FOREIGN KEY (relationID)  REFERENCES relations(relationID), 
UNIQUE      (seriesID, relationID)
)
;

CREATE TABLE game_x_relation (
game_x_relationID INT PRIMARY KEY                NOT NULL,
gameID            INT                            NOT NULL,
relationID        INT                            NOT NULL,
dateCreated       DATETIME                       NOT NULL,
userCreated       INT                            NOT NULL,
dateUpdated       DATETIME                       NOT NULL,
userUpdated       INT                            NOT NULL,
FOREIGN KEY (gameID)      REFERENCES games(gameID),
FOREIGN KEY (relationID)  REFERENCES relations(relationID), 
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
UNIQUE      (gameID, relationID)
)
;  

CREATE TABLE game_x_series (
game_x_seriesID INT PRIMARY KEY                NOT NULL,
gameID          INT                            NOT NULL, 
seriesID        INT                            NOT NULL,
dateCreated     DATETIME                       NOT NULL,
userCreated     INT                            NOT NULL,
dateUpdated     DATETIME                       NOT NULL,
userUpdated     INT                            NOT NULL,
FOREIGN KEY (userCreated)     REFERENCES users(userID),
FOREIGN KEY (userUpdated)     REFERENCES users(userID),
FOREIGN KEY (seriesID) REFERENCES series(seriesID),
FOREIGN KEY (gameID) REFERENCES games(gameID), 
UNIQUE      (seriesID, gameID) 
)
; 

CREATE TABLE game_x_franchise(
game_x_franchiseID INT PRIMARY KEY                NOT NULL,
franchiseID        INT                            NOT NULL, 
gameID             INT                            NOT NULL, 
dateCreated        DATETIME                       NOT NULL,
userCreated        INT                            NOT NULL,
dateUpdated        DATETIME                       NOT NULL,
userUpdated        INT                            NOT NULL,
FOREIGN KEY (gameID)       REFERENCES games(gameID),
FOREIGN KEY (userCreated)  REFERENCES users(userID),
FOREIGN KEY (userUpdated)  REFERENCES users(userID),
FOREIGN KEY (franchiseID)  REFERENCES franchises(franchiseID), 
UNIQUE      (franchiseID, gameID)
)
;

CREATE TABLE edition_x_networkedFeature (
edition_x_networkedFeatureID INT PRIMARY KEY                NOT NULL,
editionID                    INT                            NOT NULL,
networkedFeatureID           INT                            NOT NULL, 
dateCreated                  DATETIME                       NOT NULL,
userCreated                  INT                            NOT NULL,
dateUpdated                  DATETIME                       NOT NULL,
userUpdated                  INT                            NOT NULL,
FOREIGN KEY (editionID)          REFERENCES editions(editionID),
FOREIGN KEY (networkedFeatureID) REFERENCES networkedFeatures(networkedFeatureID),
FOREIGN KEY (userCreated)        REFERENCES users(userID),
FOREIGN KEY (userUpdated)        REFERENCES users(userID),
UNIQUE (editionID, networkedFeatureID)
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'game_x_trope')
CREATE TABLE game_x_trope (
game_x_narrtiveTropeID INT PRIMARY KEY                NOT NULL,
gameID                 INT                            NOT NULL,
tropeID                INT                            NOT NULL, 
dateCreated            DATETIME                       NOT NULL,
userCreated            INT                            NOT NULL,
dateUpdated            DATETIME                       NOT NULL,
userUpdated            INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (tropeID)     REFERENCES tropes (tropeID),
FOREIGN KEY (gameID)      REFERENCES games (gameID),
UNIQUE (gameID, tropeID)
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'game_x_mood')
CREATE TABLE game_x_mood (
game_x_moodID INT PRIMARY KEY                NOT NULL,
gameID        INT                            NOT NULL,
moodID        INT                            NOT NULL,
dateCreated   DATETIME                       NOT NULL,
userCreated   INT                            NOT NULL,
dateUpdated   DATETIME                       NOT NULL,
userUpdated   INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (gameID)      REFERENCES games(gameID),
FOREIGN KEY (moodID)      REFERENCES moods(moodID),
UNIQUE (gameID, moodID)
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'game_x_characterTrope')
CREATE TABLE game_x_characterTrope (
game_x_characterTrope INT PRIMARY KEY                NOT NULL,
characterTropeID      INT                            NOT NULL,
gameID                INT                            NOT NULL,
dateCreated           DATETIME                       NOT NULL,
userCreated           INT                            NOT NULL,
dateUpdated           DATETIME                       NOT NULL,
userUpdated           INT                            NOT NULL,
FOREIGN KEY (userCreated)      REFERENCES users(userID),
FOREIGN KEY (userUpdated)      REFERENCES users(userID),    
FOREIGN KEY (characterTropeID) REFERENCES characterTropes(characterTropeID),
FOREIGN KEY (gameID)           REFERENCES games(gameID),
UNIQUE      (characterTropeID, gameID)
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'game_x_pacingsBattleSystem')
CREATE TABLE game_x_pacingsBattleSystem (
game_x_pacingsBattleSystemID INT PRIMARY KEY                NOT NULL,
gameID                       INT                            NOT NULL,
pacingsBattleSystemID        INT                            NOT NULL,
dateCreated                  DATETIME                       NOT NULL,
userCreated                  INT                            NOT NULL,
dateUpdated                  DATETIME                       NOT NULL,
userUpdated                  INT                            NOT NULL,
FOREIGN KEY (userCreated)           REFERENCES users(userID),
FOREIGN KEY (userUpdated)           REFERENCES users(userID),  
FOREIGN KEY (gameID)                REFERENCES games(gameID),
FOREIGN KEY (pacingsBattleSystemID) REFERENCES pacingsBattleSystems(pacingsBattleSystemID),
UNIQUE      (gameID, pacingsBattleSystemID)
)
;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'game_x_pacingsInGameClock')
CREATE TABLE game_x_pacingsInGameClock (
game_x_pacingsInGameClockID INT PRIMARY KEY                NOT NULL,
gameID                      INT                            NOT NULL,
pacingsInGameClockID        INT                            NOT NULL,
dateCreated                 DATETIME                       NOT NULL,
userCreated                 INT                            NOT NULL,
dateUpdated                 DATETIME                       NOT NULL,
userUpdated                 INT                            NOT NULL,
FOREIGN KEY (userCreated)          REFERENCES users(userID),
FOREIGN KEY (userUpdated)          REFERENCES users(userID),  
FOREIGN KEY (gameID)               REFERENCES games (gameID),
FOREIGN KEY (pacingsInGameClockID) REFERENCES pacingsInGameClocks(pacingsInGameClockID) ,
UNIQUE      (gameID, pacingsInGameClockID)   
)
;

CREATE TABLE additionalContent_x_agent (
additionalContent_x_agentID INT PRIMARY KEY                NOT NULL,
additionalContentID         INT                            NOT NULL,
agentID                     INT                            NOT NULL,
dateCreated                 DATETIME                       NOT NULL,
userCreated                 INT                            NOT NULL,
dateUpdated                 DATETIME                       NOT NULL,
userUpdated                 INT                            NOT NULL,
FOREIGN KEY (userCreated)         REFERENCES users(userID),
FOREIGN KEY (userUpdated)         REFERENCES users(userID),  
FOREIGN KEY (agentID)             REFERENCES agents(agentID),
FOREIGN KEY (additionalContentID) REFERENCES additionalContent(additionalContentID),
UNIQUE      (additionalContentID, agentID)
)
;

CREATE TABLE digitalPackage_x_collection(
digitalPackage_x_collectionID INT PRIMARY KEY                NOT NULL,
digitalPackageID              INT                            NOT NULL,
collectionID                  INT                            NOT NULL,
dateCreated                   DATETIME                       NOT NULL,
userCreated                   INT                            NOT NULL,
dateUpdated                   DATETIME                       NOT NULL,
userUpdated                   INT                            NOT NULL,
FOREIGN KEY (userCreated)      REFERENCES users(userID),
FOREIGN KEY (userUpdated)      REFERENCES users(userID),  
FOREIGN KEY (digitalPackageID) REFERENCES digitalPackages(digitalPackageID),
FOREIGN KEY (collectionID)     REFERENCES collections(collectionID),
UNIQUE      (digitalPackageID, collectionID)
)
;

CREATE TABLE digitalPackage_x_additionalContent(
digitalPackage_x_additionalContentID INT PRIMARY KEY                NOT NULL,
additionalContentID                  INT                            NOT NULL,
digitalPackageID                     INT                            NOT NULL,
dateCreated                          DATETIME                       NOT NULL,
userCreated                          INT                            NOT NULL,
dateUpdated                          DATETIME                       NOT NULL,
userUpdated                          INT                            NOT NULL,
FOREIGN KEY (userCreated)         REFERENCES users(userID),
FOREIGN KEY (userUpdated)         REFERENCES users(userID),  
FOREIGN KEY (additionalContentID) REFERENCES additionalContent(additionalContentID),
FOREIGN KEY (digitalPackageID)    REFERENCES digitalPackages(digitalPackageID),
UNIQUE      (additionalContentID, digitalPackageID)
)
;

CREATE TABLE digitalPackage_x_agent (
digitalPackage_x_agentID INT PRIMARY KEY                NOT NULL,
digitalPackageID         INT                            NOT NULL,
agentID                  INT                            NOT NULL,
agentRoleID              INT                            NOT NULL,
dateCreated              DATETIME                       NOT NULL,
userCreated              INT                            NOT NULL,
dateUpdated              DATETIME                       NOT NULL,
userUpdated              INT                            NOT NULL,
FOREIGN KEY (userCreated)      REFERENCES users(userID),
FOREIGN KEY (userUpdated)      REFERENCES users(userID),  
FOREIGN KEY (agentID)          REFERENCES agents(agentID),
FOREIGN KEY (digitalPackageID) REFERENCES digitalPackages(digitalPackageID),
UNIQUE      (digitalPackageID, agentID, agentRoleID)
)
;

CREATE TABLE physicalPackage_x_agent (
physicalPackage_x_agentID INT PRIMARY KEY                NOT NULL,
physicalPackageID         INT                             NOT NULL,
agentID                   INT                             NOT NULL,
agentRoleID               INT                             NOT NULL,
dateCreated               DATETIME                        NOT NULL,
userCreated               INT                             NOT NULL,
dateUpdated               DATETIME                        NOT NULL,
userUpdated               INT                             NOT NULL,
FOREIGN KEY (userCreated)       REFERENCES users(userID),
FOREIGN KEY (userUpdated)       REFERENCES users(userID),
FOREIGN KEY (physicalPackageID) REFERENCES physicalPackages(physicalPackageID),
FOREIGN KEY (agentID)           REFERENCES agents(agentID),
UNIQUE      (physicalPackageID, agentID, agentRoleID)
)
;

CREATE TABLE game_x_narrativeGenre (
game_x_narrativeGenreID INT PRIMARY KEY                NOT NULL,
gameID                  INT                            NOT NULL,
narrativeGenreID        INT                            NOT NULL,
dateCreated             DATETIME                       NOT NULL,
userCreated             INT                            NOT NULL,
dateUpdated             DATETIME                       NOT NULL,
userUpdated             INT                            NOT NULL,
FOREIGN KEY (gameID)           REFERENCES games(gameID),
FOREIGN KEY (narrativeGenreID) REFERENCES narrativeGenres(narrativeGenreID),
FOREIGN KEY (userCreated)      REFERENCES users(userID),
FOREIGN KEY (userUpdated)      REFERENCES users(userID),
UNIQUE      (narrativeGenreID, gameID)
)
;

CREATE TABLE game_x_theme (
game_x_themeID INT PRIMARY KEY                NOT NULL,
gameID         INT                            NOT NULL,
themeID        INT                            NOT NULL,
dateCreated    DATETIME                       NOT NULL,
userCreated    INT                            NOT NULL,
dateUpdated    DATETIME                       NOT NULL,
userUpdated    INT                            NOT NULL,
FOREIGN KEY (gameID)      REFERENCES games(gameID),
FOREIGN KEY (themeID)     REFERENCES themes(themeID),
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
UNIQUE      (gameID, themeID)
)
;

CREATE TABLE game_x_world (
game_x_worldID INT PRIMARY KEY                NOT NULL,  
gameID         INT                            NOT NULL,
worldID        INT                            NOT NULL,
dateCreated    DATETIME                       NOT NULL,
userCreated    INT                            NOT NULL,
dateUpdated    DATETIME                       NOT NULL,
userUpdated    INT                            NOT NULL,
FOREIGN KEY (gameID)      REFERENCES games(gameID),
FOREIGN KEY (worldID)     REFERENCES worlds(worldID),
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
UNIQUE      (gameID, worldID)
)
;

CREATE TABLE game_x_places (
game_x_placesID INT PRIMARY KEY                NOT NULL,  
gameID          INT                            NOT NULL,
placeID         INT                            NOT NULL,
dateCreated     DATETIME                       NOT NULL,
userCreated     INT                            NOT NULL,
dateUpdated     DATETIME                       NOT NULL,
userUpdated     INT                            NOT NULL,
FOREIGN KEY (gameID)      REFERENCES games(gameID),
FOREIGN KEY (placeID)     REFERENCES places(placeID),
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
UNIQUE      (gameID, placeID)    
)
;

CREATE TABLE game_x_time (
game_x_timeID INT PRIMARY KEY                NOT NULL,  
gameID        INT                            NOT NULL,
timeID        INT                            NOT NULL,
dateCreated   DATETIME                       NOT NULL,
userCreated   INT                            NOT NULL,
dateUpdated   DATETIME                       NOT NULL,
userUpdated   INT                            NOT NULL,
FOREIGN KEY (gameID)      REFERENCES games(GameID),
FOREIGN KEY (timeID)      REFERENCES times(timeID),
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
UNIQUE      (gameID, timeID)    
)
;

CREATE TABLE localRelease_x_rating (
localRelease_x_ratingID INT PRIMARY KEY                NOT NULL,
localReleaseID          INT                            NOT NULL,
ratingID                INT                            NOT NULL,
dateCreated             DATETIME                       NOT NULL,
userCreated             INT                            NOT NULL,
dateUpdated             DATETIME                       NOT NULL,
userUpdated             INT                            NOT NULL,
FOREIGN KEY (userCreated)    REFERENCES users(userID),
FOREIGN KEY (userUpdated)    REFERENCES users(userID),
FOREIGN KEY (localReleaseID) REFERENCES localReleases(localReleaseID),
FOREIGN KEY (ratingID)       REFERENCES ratings(ratingID),
UNIQUE (localReleaseID, ratingID)
)
;

CREATE TABLE localRelease_x_ratingDescriptor (
localRelease_x_ratingDescriptorID INT PRIMARY KEY                NOT NULL,
localReleaseID                    INT                            NOT NULL,
ratingDescriptorID                INT                            NOT NULL,
dateCreated                       DATETIME                       NOT NULL,
userCreated                       INT                            NOT NULL,
dateUpdated                       DATETIME                       NOT NULL,
userUpdated                       INT                            NOT NULL,
FOREIGN KEY (userCreated)        REFERENCES users(userID),
FOREIGN KEY (userUpdated)        REFERENCES users(userID),
FOREIGN KEY (localReleaseID)     REFERENCES localReleases(localReleaseID),
FOREIGN KEY (ratingDescriptorID) REFERENCES ratingDescriptors(ratingDescriptorID),
UNIQUE      (localReleaseID, ratingDescriptorID)    
)
;

CREATE TABLE localRelease_x_language(
localRelease_x_languageID INT PRIMARY KEY                NOT NULL,
languageID    	          INT 			               NOT NULL,
localReleaseID            INT			                   NOT NULL,
dateCreated               DATETIME                       NOT NULL,
userCreated               INT                            NOT NULL,
dateUpdated               DATETIME                       NOT NULL,
userUpdated               INT                            NOT NULL,
FOREIGN KEY (userCreated)    REFERENCES users(userID),
FOREIGN KEY (userUpdated)    REFERENCES users(userID),
FOREIGN KEY (languageID)     REFERENCES languages(languageID),    	   
FOREIGN KEY (localReleaseID) REFERENCES localReleases(localReleaseID)    	   
)
;

CREATE TABLE agent_x_agentRole(
agent_x_agentRoleID INT PRIMARY KEY                NOT NULL,
agentID    	        INT 			               NOT NULL,
agentRoleID         INT			                   NOT NULL,
dateCreated         DATETIME                       NOT NULL,
userCreated         INT                            NOT NULL,
dateUpdated         DATETIME                       NOT NULL,
userUpdated         INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (agentID)     REFERENCES agents(agentID),    	   
FOREIGN KEY (agentRoleID) REFERENCES agentRoles(agentRoleID)    	   
)
;

CREATE TABLE edition_x_trailer(
edition_x_trailerID INT PRIMARY KEY                NOT NULL,
editionID           INT 			               NOT NULL,
trailerID           INT			                   NOT NULL,
dateCreated         DATETIME                       NOT NULL,
userCreated         INT                            NOT NULL,
dateUpdated         DATETIME                       NOT NULL,
userUpdated         INT                            NOT NULL,
FOREIGN KEY (userCreated) REFERENCES users(userID),
FOREIGN KEY (userUpdated) REFERENCES users(userID),
FOREIGN KEY (editionID)   REFERENCES editions(editionID),    	   
FOREIGN KEY (trailerID)   REFERENCES trailers(trailerID)    	   
)
;

-- INSERT CVs ---------------------------------------------------------
-- INSERT CVs ---------------------------------------------------------
-- INSERT CVs ---------------------------------------------------------

INSERT INTO appeals VALUES (1,  'Accomplishment', NULL); 
INSERT INTO appeals VALUES (2,  'Challenge',      NULL); 
INSERT INTO appeals VALUES (3,  'Competition',    NULL); 
INSERT INTO appeals VALUES (4,  'Fellowship',     NULL); 
INSERT INTO appeals VALUES (5,  'Discovery',      NULL); 
INSERT INTO appeals VALUES (6,  'Fantasy',        NULL); 
INSERT INTO appeals VALUES (7,  'Expression',     NULL); 
INSERT INTO appeals VALUES (8,  'Sensation',      NULL); 
INSERT INTO appeals VALUES (9,  'Emotion',        NULL); 
INSERT INTO appeals VALUES (10, 'Submission',     NULL); 

INSERT INTO gameTitleTypes VALUES (1, 'Transcribed', NULL); 
INSERT INTO gameTitleTypes VALUES (2, 'Alternative', NULL);
INSERT INTO gameTitleTypes VALUES (3, 'Abbreviated', NULL);
INSERT INTO gameTitleTypes VALUES (4, 'Colloquial',  NULL);

INSERT INTO pacingsBattleSystems VALUES (1,'Turn-based', NULL);
INSERT INTO pacingsBattleSystems VALUES (2,'Realtime',   NULL);
INSERT INTO pacingsBattleSystems VALUES (3,'Other',      NULL);

INSERT INTO pacingsInGameClocks  VALUES (1,'Calender-based',       NULL);
INSERT INTO pacingsInGameClocks  VALUES (2,'Multiple Game Clocks', NULL);
INSERT INTO pacingsInGameClocks  VALUES (3,'Timed Action',         NULL);
INSERT INTO pacingsInGameClocks  VALUES (4,'Other',                NULL);

INSERT INTO progressions VALUES (1, 'Linear',     NULL);
INSERT INTO progressions VALUES (2, 'Branching',  NULL);
INSERT INTO progressions VALUES (3, 'Open World', NULL);
INSERT INTO progressions VALUES (4, 'Other',      NULL);

INSERT INTO gameplayGenres VALUES (1, 'Action', NULL, 
	'Games that revolve around a fast-paced experience. These games often emphasize reaction-based challenges in terms of how the player interacts with the game world.', 
	NULL);
INSERT INTO gameplayGenres VALUES (2, 'Puzzle', NULL, 
	'These games emphasize the solving of puzzles and/or the organization of pieces. Representative games are Lumines and Portal.', 
	NULL);
INSERT INTO gameplayGenres VALUES (3, 'Role-Playing', NULL, 
	'These games are related to table-top role playing games and involve a heavy focus on statistical advancement (such as “leveling up”) of a character or group of characters in combination with the exploration of a game world.', 
	NULL);
INSERT INTO gameplayGenres VALUES (4, 'Simulation', NULL, 
	'Games that are designed to simulate actions or situations from either an existing or a fictional reality.', 
	NULL);
INSERT INTO gameplayGenres VALUES (5, 'Shooter', NULL, 
	'These games revolve around a shooting mechanic where players target and shoot objects or enemies in order to progress through the game.', 
	NULL);
INSERT INTO gameplayGenres VALUES (6, 'Strategy', NULL, 
	'Games that revolve around strategic or tactical planning. These games often involve building, resource management and exploration components.', 
	NULL);
INSERT INTO gameplayGenres VALUES (7, 'Traditional', NULL, 
	'These are based on games with mechanics that exist in the real world and can be played in a physical setting.', 
	NULL);

INSERT INTO gameplayGenres VALUES (100, 'Action-Adventure', 1, 
	'Games which focus more on a sense of adventure than fast paced conflict, often with a focus on solving riddles or overcoming challenges to progress. Representative games are Myst and The Amazon Trail.',
	NULL);
INSERT INTO gameplayGenres VALUES (101, 'Arcade', 1, 
	'Games that either were released in a classic arcade setting, or have their artistic roots in that aesthetic. These games often have simple graphics and gameplay with a focus on attaining a high score of points. Representative games are Pac-Man and Space Invaders.',
	NULL);
INSERT INTO gameplayGenres VALUES (102, 'Block Breaking', 1, 
	'Games where the primary mechanic for advancement and scoring is the breaking of blocks, often with a ball controlled by a paddle. Representative games are Brickles and 3-D Brickaway.',
	NULL);
INSERT INTO gameplayGenres VALUES (103, 'Brawler', 1, 
	'These games have a focus on physical hand to hand combat, sometimes allowing players to use parts of the environment as weapons. Characters often must engage with multiple enemies at one time to fight their way through levels. Representative games are Double Dragon and The Bouncer.',
	NULL);
INSERT INTO gameplayGenres VALUES (104, 'Dancing', 109, 
	'These games revolve around the player interacting with the game by moving, or dancing, on an external peripheral. Representative game is Dance Dance Revolution.',
	NULL);
INSERT INTO gameplayGenres VALUES (105, 'Fighting', 1, 
	'These games involve the player controlling a character or team of characters at a time and engaging in physical combat with another character(s). They employ rounds with the winner of a majority of rounds deciding the winner of the match. They often feature a variety of characters representing unique and diverse fighting and visual styles. Representative games are Street Fighter 2 and King of Fighters.',
	NULL);
INSERT INTO gameplayGenres VALUES (106, 'Hack and Slash', 1, 
	'Hack and slash games focus on fast paced gameplay involving melee weapons. Often the player character(s) will have to fight multiple enemies at the same time to advance across levels. Representative games are Gauntlet Legends and Golden Axe.',
	NULL);
INSERT INTO gameplayGenres VALUES (107, 'Mascot Fighter', 105, 
	'These games feature mascot characters, often from game or media franchises, that engage in combat in the manner of a fighting game. Often there are more than two characters fighting at one time in a free-for-all type environment. Representative games are Super Smash Brothers and Playstation Allstars Battle Royale.',
	NULL);
INSERT INTO gameplayGenres VALUES (108, 'Multiplayer Online Battle Arena', 1, 
	'These games focus on a third person perspective with players controlling a single character in an online or networked environment. They often feature two or more teams competing against each other to achieve goals or domination. Representative games are League of Legends and Defense of Ancients.',
	NULL);
INSERT INTO gameplayGenres VALUES (109, 'Music', 1, 
	'These games revolve around music, beats and or rhythm as a core part of their experience. Some feature the control of simulated instruments such as guitars and drums.',
	NULL);
INSERT INTO gameplayGenres VALUES (110, 'Party', 1, 
	'These games are a collection of smaller games, or ''mini games'', often meant to be played with a group of players in a casual competitive context. Representative games are Mario Party and Wii Party.',
	NULL);
INSERT INTO gameplayGenres VALUES (111, 'Platform', 1, 
	'These games have a focus on jumping or otherwise moving between different platforms and successfully navigating terrain and obstacles. They often emphasize hand eye coordination. Representative games are Super Mario Bros. 3 and Sonic the Hedgehog.',
	NULL);
INSERT INTO gameplayGenres VALUES (112, 'Rhythym', 109, 
	'These games involve the player inputting commands or completing actions while synchronizing to a rhythm. Representative games are Space Channel 5 and Donkey Conga.',
	NULL);
INSERT INTO gameplayGenres VALUES (113, 'Stealth', 1, 
	'These games have an emphasis on stealth and avoiding detection. Representative games are Metal Gear Solid and Tenchu: Stealth Assassins.',
	NULL);
INSERT INTO gameplayGenres VALUES (114, 'Survival', 1, 
	'These games have a focus on surviving difficult situations, often with an emphasis on the management of limited resources (such as health and ammunition) as well as overwhelming opposition. Representative games are Left 4 Dead and Dead Island.',
	NULL);
INSERT INTO gameplayGenres VALUES (115, 'Vehicle Combat', 1, 
	'These games focus on combat between vehicles as one of their key mechanics. Representative games are Twisted Metal and Burnout.',
	NULL);
INSERT INTO gameplayGenres VALUES (116, 'Adventure', NULL, NULL, 100);
INSERT INTO gameplayGenres VALUES (117, 'Beat ''Em Up', NULL, NULL, 103);
INSERT INTO gameplayGenres VALUES (118, 'Car Combat', NULL, NULL, 115);
INSERT INTO gameplayGenres VALUES (119, 'Minigame Collection', NULL, NULL, 110);
INSERT INTO gameplayGenres VALUES (120, 'MOBA', NULL, NULL, 108);
INSERT INTO gameplayGenres VALUES (121, 'Platformer', NULL, NULL, 111);

INSERT INTO gameplayGenres VALUES (300, 'Japanese RPG', 3, 
	'These games are RPGs (often designed in Japan) that place a heavy focus on visual style and story elements. Themes frequently involve romance and dramatic personal histories. Characters often show an anime influence in their design. Representative games are Final Fantasy 7 and Dragon Quest.',
	NULL);
INSERT INTO gameplayGenres VALUES (301, 'Massively Multiplayer Online RPG', 3, 
	'These are RPGs played with a massive number of players in an online or networked environment. Representative games are World of Warcraft and Star Wars: Knights of the Old Republic.',
	NULL);
INSERT INTO gameplayGenres VALUES (302, 'Rogue-Like', 3, 
	'These are RPGs where the player explores a series of usually randomly generated environments. They often place a large focus on the discovery of items and treasure, and the permanence death of characters. Representative games are Angband and Diablo.',
	NULL);
INSERT INTO gameplayGenres VALUES (303, 'Western RPG', 3, 
	'These are RPGs that place a focus on character customization and development. They often employ realistic visual styles and have vast open worlds. Representative games are Skyrim and Baldur''s Gate.',
	NULL);
INSERT INTO gameplayGenres VALUES (304, 'JRPG', NULL, NULL, 300);
INSERT INTO gameplayGenres VALUES (305, 'MMORPG', NULL, NULL, 301);
INSERT INTO gameplayGenres VALUES (306, 'Rogue RPG', NULL, NULL, 302);

INSERT INTO gameplayGenres VALUES (400, 'Breeding', 4, 
	'These games emphasize the breeding and development or raising of animals or other entities. Representative games are Spore and Monster Rancher.',
	NULL);
INSERT INTO gameplayGenres VALUES (401, 'Construction & Management Simulation', 4, 
	'These games revolve around the creation of structures, cities or other built objects. They often emphasize resource management. Representative games are Sim City 2000 and Dwarf Fortress.',
	NULL);
INSERT INTO gameplayGenres VALUES (402, 'Flight Simulator', 4, 
	'These games are designed to simulate flight, usually of aircraft. Some strive for high amounts of realism, while others are more action oriented. Representative games are Microsoft Flight Simulator and Ace Combat.',
	NULL);
INSERT INTO gameplayGenres VALUES (403, 'God Game', 4, 
	'These games allow the player to interact with a world in the position of an all-powerful entity. Representative games are Black and White and Viva Piñata.',
	NULL);
INSERT INTO gameplayGenres VALUES (404, 'Interactive Movie', 4, 
	'These games involve little action on the part of the player and are more of a series of movies that the player controls through decisions. Representative game is Night Trap.',
	NULL);
INSERT INTO gameplayGenres VALUES (405, 'Programming Game', 4, 
	'These games revolve around some sort of programming, often computer code, as their core mechanic. Representative game is CodeCombat.',
	NULL);
INSERT INTO gameplayGenres VALUES (406, 'Sandbox', 4, 
	'These games involve open environments where the player is encouraged to explore, act and create freely. Often these games can be played in a variety of ways depending on the mood of the player. Representative games are Minecraft and Grand Theft Auto.',
	NULL);
INSERT INTO gameplayGenres VALUES (407, 'Social Simulator', 4, 
	'These games revolve around the simulation of social life, situations and interaction. Representative game is The Sims.',
	NULL);
INSERT INTO gameplayGenres VALUES (408, 'Sports', 4, 
	'For sports games assign both the term sports as well as the name of the sport being represented. Use information associated with the item being described (e.g. the packaging) to provide the sport name and spelling when possible. If there is no related information available use the most common spelling of that sport for the region that the record is being created for (for example American English spellings for records being created for use in the United States).',
	NULL);
INSERT INTO gameplayGenres VALUES (409, 'Virtual Life', 4, 
	'These games involve the creation of an in game avatar that the player controls in a virtual world living a simulated life. They often are played online and involve the interaction between player avatars. An example game is Second Life.',
	NULL);
INSERT INTO gameplayGenres VALUES (410, 'Aviation Simulator', NULL, NULL, 402);
INSERT INTO gameplayGenres VALUES (411, 'City Building', NULL, NULL, 401);
INSERT INTO gameplayGenres VALUES (412, 'Life Simulation Game', NULL, NULL, 407);
INSERT INTO gameplayGenres VALUES (413, 'Open World (Sandbox)', NULL, NULL, 406);
INSERT INTO gameplayGenres VALUES (414, 'Racing', NULL, NULL, 408);
INSERT INTO gameplayGenres VALUES (415, 'Tycoon', NULL, NULL, 401);

INSERT INTO gameplayGenres VALUES (500, 'First Person Shooter', 5, 
	'These games have a focus on the mechanic of shooting and are played from a first person perspective. Representative games are Halo: Combat Evolved and Doom.',
	NULL);
INSERT INTO gameplayGenres VALUES (501, 'Light Gun Shooter', 5, 
	'These games are played using an external gun controller that is aimed at the playing screen to shoot objects or enemies.',
	NULL);
INSERT INTO gameplayGenres VALUES (502, 'Massively Multiplayer FPS', 500, 
	'These games revolve around a shooting mechanic from the first person perspective and are played in an online or networked environment that can have a massive amount of players at one time. Representative games are PlanetSide and Firefall.',
	NULL);
INSERT INTO gameplayGenres VALUES (503, 'Rail Shooter', 5, 
	'Rail shooters are games that revolve around a shooting mechanic where players do not control their movement through a level but rather are propelled along on a set course or ''rail.'' Representative games are The Lost World: Jurassic Park and Star Fox 64.',
	NULL);
INSERT INTO gameplayGenres VALUES (504, 'Tactical Shooter', 5, 
	'Games which revolve around a shooting mechanic and are focused on simulating a tactical or military environment. Representative games are Rainbow Six and Call of Duty: Modern Warfare.',
	NULL);
INSERT INTO gameplayGenres VALUES (505, 'Combat', NULL, NULL, 504);
INSERT INTO gameplayGenres VALUES (506, 'FPS', NULL, NULL, 500);
INSERT INTO gameplayGenres VALUES (507, 'FPS', NULL, NULL, 500);
INSERT INTO gameplayGenres VALUES (508, 'Shoot ''em Up', NULL, NULL, 5);

INSERT INTO gameplayGenres VALUES (600, '4X', 6, 
	'4X stands for ''explore, expand, exploit and exterminate.'' They revolve around the creation of an empire through diplomacy and conquest. Representative games are Master of Orion and Civilization.',
	NULL);
INSERT INTO gameplayGenres VALUES (601, 'Military Simulator', 6, 
	'These games are strategy games that focus on simulating realistic militaries or historical military events. Representative games are Combat Mission and Close Combat.',
	NULL);
INSERT INTO gameplayGenres VALUES (602, 'Real Time Strategy', 6, 
	'These games are strategy games that unfold in real-time (as opposed to utilizing a turn mechanic). Example games are Star Craft and Command and Conquer.',
	NULL);
INSERT INTO gameplayGenres VALUES (603, 'Tactics', 6, 
	'These games focus on small scale conflicts and often involve the player positioning and controlling a predetermined amount of units. Representative games are Final Fantasy Tactics and Steel Panthers.',
	NULL);
INSERT INTO gameplayGenres VALUES (604, 'Tower Defense', 6, 
	'These games focus on the defense of a location against an onslaught of enemies. Often the player must place and control a limited amount of units and weapons. Representative game is Plants vs. Zombies.',
	NULL);
INSERT INTO gameplayGenres VALUES (605, 'Turn-Based Strategy', 6, 
	'Turn based strategy games utilize alternating turns as the central mechanic (as opposed to controlling the game in real-time). Representative games are Heroes of Might and Magic and Rome: Total War.',
	NULL);
INSERT INTO gameplayGenres VALUES (606, 'Wargame', NULL, NULL, 601);
    
INSERT INTO gameplayGenres VALUES (700, 'Board Game', 7, 
	'These games have their origin or creative roots in table-top board games. They often are adaptations of existing board games. Representative games are Settlers of Catan and Chessmaster.',
	NULL);
INSERT INTO gameplayGenres VALUES (701, 'Card Game', 7, 
	'These games have their origin or creative roots in table-top card games. They often are adaptations of existing card games. Representative games are Magic the Gathering and Full House Poker.',
	NULL);
INSERT INTO gameplayGenres VALUES (702, 'Exercise', 7, 
	'These games involve a player interacting with the game with movement using an external peripheral for the purpose of physical exercise. Representative game is Wii Fit.',
	NULL);
INSERT INTO gameplayGenres VALUES (703, 'Gambling', 7, 
	'These games have their origins and are often adaptations of traditional gambling and casino games. Representative games are Caesar''s Palace and Golden Nugget 64.',
	NULL);
INSERT INTO gameplayGenres VALUES (704, 'Game show', 7, 
	'These games are modelled after (and often are adaptations of) television game shows. Representative games are Jeopardy! The Video Game and Wheel of Fortune.',
	NULL);
INSERT INTO gameplayGenres VALUES (705, 'Maze', 7, 
	'These games revolve around the navigation of a maze. Representative game is Labyrinth.',
	NULL);
INSERT INTO gameplayGenres VALUES (706, 'Pinball', 7, 
	'These games are simulations of Pinball machines. Representative games are Full Tilt Pinball and Mario Pinball Land.',
	NULL);
INSERT INTO gameplayGenres VALUES (707, 'Trivia Game', 7, 
	'These games involve the answering of questions, often based on obscure knowledge. Representative games are The Guy Game and Scene It? Box Office Smash.',
	NULL);
INSERT INTO gameplayGenres VALUES (708, 'Quiz Game', NULL, NULL, 707);


INSERT INTO times VALUES (1,  'Prehistoric',  NULL, 'Features early technologies; stone tools and fire. Employs a mix of prehistoric creatures, dinosaurs, and cavemen.', NULL);
INSERT INTO times VALUES (2,  'Ancient',      NULL, 'Seen as the dawn of civilization with technologies containing Swords and Sandals. This time period is also known to be heavily steeped in mythology and god-lore. ', NULL);
INSERT INTO times VALUES (3,  'Byzantine',    NULL, 'The Byzantine time period encompasses the Crusades, and is characterized by strong Roman and Greek influences.1', NULL);
INSERT INTO times VALUES (4,  'Cold war',     NULL, 'The time period following the end of World War II (circa 1947-1991), in which tensions between the United States and the Soviet Union were high. It is characterized by a clash of political ideals between democracy and communism.', NULL);
INSERT INTO times VALUES (6,  'Medieval',     NULL, 'Castles are in abundance; the government style tends to focus on feudalism and in many cases there is a hereditary monarchy in place.', NULL);
INSERT INTO times VALUES (7,  'Reformation',  NULL, 'The time period marked by ¡°religious, political, intellectual, and cultural upheaval¡± that split apart Catholic Europe during the 16th century. High profile individuals of this time include Martin Luther, John Calvin, and Henry VIII.2', NULL);
INSERT INTO times VALUES (8,  'Renaissance',  NULL, 'Time period when gunpowder is first introduced; cultures are more focused on philosophy and the arts.', NULL);
INSERT INTO times VALUES (9,  'Imperial',     NULL, 'Pre World War I period of colonization, discovery, industrialization, and travel.', NULL);
INSERT INTO times VALUES (10, 'Modern',       NULL, 'A time of war and rebuilding of super powers; World War II to the contemporary period. Technologies include cars, planes, and electronics.', NULL);
INSERT INTO times VALUES (11, 'Contemporary', NULL, 'The part of history still in living memory. ', NULL);
INSERT INTO times VALUES (12, 'Futuristic',   NULL, 'Focuses on interstellar exploration/colonization, interaction with alien species, and future empire building all while still having some relationship with Earth.', NULL);
INSERT INTO times VALUES (13, 'Western',      NULL, 'The time period characterized by cowboys, outlaws, and saloons.', NULL);
INSERT INTO times VALUES (14, 'Unspecified',  NULL, 'Not stated clearly or exactly.', NULL);
INSERT INTO times VALUES (15, 'Year (YYYY)',  NULL, 'In the style of the Gregorian calendar only if the specific year is present within the game. Also only used if Our World or Alternate World are selected.', NULL);
INSERT INTO times VALUES (5,  'Dark ages',    NULL, NULL, 6);

INSERT INTO places VALUES (1, 'Natural Environment', NULL, 'All living and non-living things that are naturally on Earth.',NULL);
INSERT INTO places VALUES (2, 'Beach',               NULL, 'Landform along the coast of an ocean, sea, lake, or river that consists of loose particles like sand or rock.',NULL);
INSERT INTO places VALUES (3, 'Caves',               NULL, 'Hollow place in the ground, especially a large underground space that humans can enter.',NULL);
INSERT INTO places VALUES (4, 'Forest',              NULL, 'Area of land covered with trees or other woody vegetation.',NULL);
INSERT INTO places VALUES (5, 'Island',              NULL, 'A body of land surrounded entirely by the ocean. It is often tropical in climate, but varying environments may exist closer to its center. ',NULL);
INSERT INTO places VALUES (6, 'Jungle',              NULL, 'Area of land covered with dense vegetation. ',NULL);

INSERT INTO worlds VALUES (1, 'Our world',       'Game worlds created to represent reality');
INSERT INTO worlds VALUES (2, 'Alternate world', 'A fictional world with design based in reality');
INSERT INTO worlds VALUES (3, 'Imagined world',  'A self-consostent world setting with element that differ from reality');



-- Natural Environment Children

INSERT INTO places VALUES( 100, 'Beach',           122,  'Landform along the coast of an ocean, sea, lake, or river that consists of loose particles like sand or rock.', NULL);
INSERT INTO places VALUES( 101, 'Caves',           122,  'Hollow place in the ground, especially a large underground space that humans can enter.', NULL);
INSERT INTO places VALUES( 102, 'Forest',          122,  'Area of land covered with trees or other woody vegetation.', NULL);
INSERT INTO places VALUES( 103, 'Island',          NULL, 'A body of land surrounded entirely by the ocean. It is often tropical in climate, but varying environments may exist closer to its center.', NULL);
INSERT INTO places VALUES( 104, 'Jungle',          122,  'Area of land covered with dense vegetation.', NULL);
INSERT INTO places VALUES( 109, 'Outer Space',     1,    'Void that exists between celestial bodies.', NULL);
INSERT INTO places VALUES( 110, 'Plains',          122,  'Flat region of land.', NULL);
INSERT INTO places VALUES( 114, 'Sky',             1,    'Everything that lies above the surface of earth, including the atmosphere, including outer space.', NULL);
-- FYI BT Natural Environment was not in the CV for this one, but it's a child, so I assumed it should still be BT = 1.'An area located beneath the ground/surface level where the majority of human activity typically occurs.
INSERT INTO places VALUES( 118, 'Underground',     1,    'An area located beneath the ground/surface level where the majority of human activity typically occurs. It is often characterized as an area where there is no sunlight.', NULL);
-- Same comment as for BT underground.
INSERT INTO places VALUES( 119, 'Underwater',      1,    'An area located beneath the water’s surface level, in which marine and aquatic life thrive.', NULL);
-- Same comment as for BT underground.
INSERT INTO places VALUES( 120, 'Volcano',         1,    'A mountain with a crater or vent that allows contents from the earth’s core (like lava) to surface.', NULL);
INSERT INTO places VALUES( 121, 'Water',           122,  'Transparent fluid which forms the world''s streams, lakes, oceans and rain, and is the major constituent of the fluids of living things.', NULL);
INSERT INTO places VALUES( 122, 'Wilderness',      1,    'Natural environment on Earth that has not been significantly modified by humans.', NULL);
INSERT INTO places VALUES( 105, 'Lake',            NULL, NULL, 121);
INSERT INTO places VALUES( 106, 'Mars',            NULL, NULL, 109);
INSERT INTO places VALUES( 107, 'Natural Reserve', NULL, NULL, 122);
INSERT INTO places VALUES( 108, 'Ocean',           NULL, NULL, 121);
INSERT INTO places VALUES( 111, 'Prarie',          NULL, NULL, 110);
INSERT INTO places VALUES( 112, 'River',           NULL, NULL, 121);
INSERT INTO places VALUES( 113, 'Sea',             NULL, NULL, 121);
INSERT INTO places VALUES( 115, 'Space',           NULL, NULL, 109);
INSERT INTO places VALUES( 116, 'Swamp',           NULL, NULL, 122);
INSERT INTO places VALUES( 117, 'Tundra',          NULL, NULL, 122);

-- Built Environment Children

INSERT INTO places VALUES( 200, 'Aircraft',       NULL, NULL, 243);
INSERT INTO places VALUES( 201, 'Amusement Park', NULL, NULL, 227);
INSERT INTO places VALUES( 202, 'Aquarium',       NULL, NULL, 227);
INSERT INTO places VALUES( 203, 'Apartment',      NULL, NULL, 215);
INSERT INTO places VALUES( 204, 'Arcade',         NULL, NULL, 227);
INSERT INTO places VALUES( 205, 'Arena',          2,    'An enclosed area, often circular or oval-shaped for sporting events or other purposes.', NULL);
INSERT INTO places VALUES( 206, 'Asylum',         NULL, NULL, 216);
-- FYI BT Built Environment was not in the CV for this one, but it's a child, so I assumed it should still be BT = 2.
INSERT INTO places VALUES( 207, 'Castle',         2,   'A monumentally large building, often constructed with stone, that houses and protects royalty (kings and queens).', NULL);
INSERT INTO places VALUES( 208, 'Church',         NULL, NULL, 228);
INSERT INTO places VALUES( 209, 'Circus',         NULL, NULL, 227);
INSERT INTO places VALUES( 210, 'City',           NULL, NULL, 242);
INSERT INTO places VALUES( 211, 'Coliseum',       NULL, NULL, 205);
INSERT INTO places VALUES( 212, 'Cyberspace',     2 ,   'Environment in which communication over computer networks occurs.', NULL);
INSERT INTO places VALUES( 213, 'Farm',           2,    'Area of land that is devoted primarily to agricultural processes.', NULL);
INSERT INTO places VALUES( 214, 'Fortress',       NULL, NULL, 222);
INSERT INTO places VALUES( 215, 'Home',           2 ,   'Place used as a permanent or semi-permanent residence for an individual, family, household, etc.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 216, 'Hospital',       2,    'An institution dedicated to administering healthcare services.', NULL);
INSERT INTO places VALUES( 217, 'House',          NULL, NULL, 215);
INSERT INTO places VALUES( 218, 'Jails',          NULL, NULL, 226);
INSERT INTO places VALUES( 219, 'Laboratory',     NULL, NULL, 233);
INSERT INTO places VALUES( 220, 'Labs',           NULL, NULL, 233);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 221, 'Maze', 2, 'A confusing intricate network of passages.', NULL);
INSERT INTO places VALUES( 222, 'Miliary Base', 2, 'Facility owned and operated by the military that shelters military equipment and personnel, and facilitates training and operations.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 223, 'Mine', 2, 'A pit or tunnel from which minerals (such as coal, gold, diamonds, etc.) are taken.', NULL);
INSERT INTO places VALUES( 224, 'Park', NULL, NULL, 227);
INSERT INTO places VALUES( 225, 'Playground', NULL, NULL, 227);
INSERT INTO places VALUES( 226, 'Prison', 2, 'Facility in which inmates are confined and denied a variety of freedoms under the authority of state as a form of punishment.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 227, 'Recreational Site', 2, 'A place for recreational activities.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 228, 'Religious Site', 2, 'A place of worship, usually for religions.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 229, 'Restaurant', 2, 'An establishment in which you may buy food that is cooked and prepared at that location. Patrons typically sit down and eat there, or get their food to go.', NULL);
INSERT INTO places VALUES( 230, 'Ruins', 2, 'Remains of human-made architecture: structures that were once complete, as time went by, have fallen into a state of partial or complete disrepair.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 231, 'Rural Area', 2, 'Geographic area that is located outside of the cities and towns.', NULL);
INSERT INTO places VALUES( 232, 'School', 2, 'Institution designed to teach students led by teachers.' , NULL);
INSERT INTO places VALUES( 233, 'Scientific Laboratory', 2, 'Facility that provides controlled conditions for scientific or technological research, experiments, measurements, etc.', NULL);
INSERT INTO places VALUES( 234, 'Ship', NULL, NULL, 243);
INSERT INTO places VALUES( 235, 'Spaceship', NULL, NULL, 243);
INSERT INTO places VALUES( 236, 'Stadium', NULL, NULL, 205);
INSERT INTO places VALUES( 237, 'Submarine', NULL, NULL, 243);
INSERT INTO places VALUES( 238, 'Suburban', 2, 'Geographic area that exists as part of a city or urban area or as a separate residential community within commuting distance of a city.', NULL);
INSERT INTO places VALUES( 239, 'Subway', NULL, NULL, 241);
INSERT INTO places VALUES( 240, 'Town', 242, NULL, 242);
INSERT INTO places VALUES( 241, 'Train', NULL, NULL, 243);
INSERT INTO places VALUES( 242, 'Urban', 2, 'Geographic area that is characterized by a high population density and vast human-built features.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 243, 'Vehicles', 2, NULL, NULL);
INSERT INTO places VALUES( 244, 'Village', NULL, NULL, 231);
INSERT INTO places VALUES( 245, 'Zoo', NULL, NULL, 227);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 246, 'Unspecified', 2, 'Not stated clearly or exactly.', NULL);
-- Same comment as for the 'Castle' BT term.
INSERT INTO places VALUES( 247, 'Specific Location', 2,  'Used to denote specific locations in game. Provide Continent, state or province, city or town.', NULL);

INSERT INTO narrativeGenres VALUES (1,  'Action',                   NULL, 'The narrative is focused on characters fighting, racing, and engaging in intense physical activities. Often minimizes plot and character development in favor of faster paced activities on screen. (e.g. Mortal Combat X)', NULL);
INSERT INTO narrativeGenres VALUES (2,  'Fantast',                  NULL, 'The story of these games is set in a world that contains magical elements such as sorcery, and mythological creatures, such as dragons. There are several sub-genres of Fantasy.', NULL);
INSERT INTO narrativeGenres VALUES (3,  'Folklore',                 2,    'These stories are based on traditional cultural stories, indigenous tales, and local legends.', NULL);
INSERT INTO narrativeGenres VALUES (4,  'Dark Fantasy',             2,    'These stories are set in a Fantasy world, but also prominently feature elements of the Horror genre, dark, gritty, and gothic themes and elements. (e.g. Dragon Age: Origins)', NULL);
INSERT INTO narrativeGenres VALUES (5,  'Epic Fantasy',             NULL, NULL,7);
INSERT INTO narrativeGenres VALUES (6,  'Fairy Tale',               2,    'The narrative has a basis in traditional folklore and folkloric elements. Generally contains mythological beings such as fairies and other mythical creatures, talking animals, invented creatures, and magic. Often intended for children. (e.g. Spyro¡¯s Adventure)', NULL);
INSERT INTO narrativeGenres VALUES (7,  'High Fantasy',             2,    'The plot of these games features larger than life struggles against colossal foes, set within a fantasy world. There is little to no moral ambiguity in the actions of the characters and plot, good and evil characters and actions are clear, and the story centers on virtuous heroes that set out to deal with the major antagonist. (e.g. Final Fantasy IV)', NULL);
INSERT INTO narrativeGenres VALUES (8,  'Low Fantasy',              2,    'The fantasy world in which the story takes place features little to no magic use, and relies on other fantastical elements to drive the narrative forward.  Fantastical elements in these stories tend to be few and far between.', NULL);
INSERT INTO narrativeGenres VALUES (9,  'Historical',               NULL, 'The story of the game takes place in the past, and the narrative emphasizes representing concepts present in specific historical times and places. ', NULL);
INSERT INTO narrativeGenres VALUES (10, 'Documentary',              NULL, 'A retelling of events from historical or factual perspectives. ', NULL);
INSERT INTO narrativeGenres VALUES (11, 'Horror',                   NULL, 'Horror games present a story that makes use of frightening, spooky, and supernatural phenomena as elements central to the plot. (e.g. Silent Hill)', NULL);
INSERT INTO narrativeGenres VALUES (12, 'Military',                 NULL, 'The narrative takes place within the context of armed conflict, and emphasizes plot elements that occur within the context of operations by armed forces. (e.g. Call of Duty)', NULL);
INSERT INTO narrativeGenres VALUES (13, 'Mystery ',                 NULL, 'The plot and narrative primarily center on solving a mystery or puzzle based on exploration, clue seeking, interrogation, and other investigation techniques. (E.g. Professor Layton and the Curious Village)', NULL);
INSERT INTO narrativeGenres VALUES (14, 'Crime',                    13,   'A sub-genre of mystery where the story centers on solving crimes.', NULL);
INSERT INTO narrativeGenres VALUES (15, 'Romance',                  NULL, 'The game story is primarily unfolds romantic and intimate relationships, dating, partner seeking, and related interactions. The narrative is preoccupied with devices that develop romantic relationships and themes.', NULL);
INSERT INTO narrativeGenres VALUES (16, 'Science Fiction ',         NULL, 'The story takes place in a world of science and conjecture, typically featuring advanced technology and futuristic elements. The story uses these plot elements to drive the plot forward and develop the speculative world, using devices such as advanced biotechnology and physics, space travel, and aliens. (e.g. Mass Effect)', NULL);
INSERT INTO narrativeGenres VALUES (17, 'Cyberpunk',                16,   'The major themes and plot devices of these stories utilize futuristic developments in computers, internet, data transfer, robotics, and human-computer interaction. (e.g. Shadowrun)', NULL);
INSERT INTO narrativeGenres VALUES (18, 'Military Science Fiction', 16,   'The world and major plot elements of these games fall within a science fiction setting, while the major emphasis and narrative centers on armed conflict in this world. (e.g. Starcraft II)', NULL);
INSERT INTO narrativeGenres VALUES (19, 'Steampunk',                16,   'The major themes and plot devices of these stories utilize engineering concepts and aesthetics present in the Victorian and Edwardian historical periods. The technology in Steampunk worlds is an advanced form of technology extant during these time periods, sometimes featuring complex mechanical objects, steam powered robots, and inventive contraptions. (e.g. Machinarium)', NULL);
INSERT INTO narrativeGenres VALUES (20, 'Speculative Fiction',      NULL, NULL,16);
INSERT INTO narrativeGenres VALUES (21, 'Time Travel',              16,   'The story takes place within multiple time periods, and time travel or time manipulation is a major plot device. (e.g. Braid)', NULL);
INSERT INTO narrativeGenres VALUES (22, 'Western',                  NULL, 'Games set in the Western United Sates in the post-Civil War era with cowboys, horses, and law enforcement. (e.g. Red Dead Redemption)', NULL);

INSERT INTO themes VALUES ( 2, 'Abduction',     NULL, 'The state or experience of one''s life being threatened after forcefully being taken away against one''s will', NULL);
INSERT INTO themes VALUES ( 3, 'Adult',         NULL, 'Dealing in or with explicitly sexual material', NULL);
INSERT INTO themes VALUES ( 4, 'Alienation',    NULL, 'The state or experience of being isolated from a group or an activity to which one should belong or in which one should be involved', NULL);
INSERT INTO themes VALUES ( 5, 'Alter-egos',    NULL, 'A second self, which is believed to be distinct from a persons normal or original personality. Often used as a disguise.', NULL);
INSERT INTO themes VALUES ( 6, 'Anti-war',      NULL, 'The mentality used to describe activists who are against war and all the trauma and destruction it brings', NULL);
INSERT INTO themes VALUES ( 7, 'Apocalypse',    NULL, 'The end of the world, in which humanity or inhabitants of some world is in total disarray over the destruction of their home', NULL);
INSERT INTO themes VALUES ( 9, 'Betrayal',      NULL, 'The breaking or violation of a presumptive contract, trust, or confidence that produces moral and psychological conflict within a relationship amongst individuals, between organizations or between individuals and organizations.', NULL);
INSERT INTO themes VALUES (10, 'Biography',     NULL, 'The story of one''s life, as told through the eyes of someone else', NULL);
INSERT INTO themes VALUES ( 1, 'Abandonment',   NULL, NULL,  4);
INSERT INTO themes VALUES ( 8, 'Autobiography', NULL, NULL, 10);


INSERT INTO themes VALUES ( 100, 'Abduction',     NULL, 'The state or experience of one''s life being threatened after forcefully being taken away against one''s will', NULL);
INSERT INTO themes VALUES ( 101, 'Adult',         NULL, 'Dealing in or with explicitly sexual material. Adult. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/adult', NULL);
INSERT INTO themes VALUES ( 102, 'Alienation',    NULL, 'The state or experience of being isolated from a group or an activity to which one should belong or in which one should be involved', NULL);
INSERT INTO themes VALUES ( 103, 'Alter-egos',    NULL, 'A second self, which is believed to be distinct from a persons normal or original personality. Often used as a disguise.', NULL);
INSERT INTO themes VALUES ( 104, 'Anti-war',      NULL, 'The mentality used to describe activists who are against war and all the trauma and destruction it brings', NULL);
INSERT INTO themes VALUES ( 105, 'Apocalypse',    NULL, 'The end of the world, in which humanity or inhabitants of some world is in total disarray over the destruction of their home', NULL);
INSERT INTO themes VALUES ( 106, 'Betrayal',      NULL, 'The breaking or violation of a presumptive contract, trust, or confidence that produces moral and psychological conflict within a relationship amongst individuals, between organizations or between individuals and organizations.', NULL);
INSERT INTO themes VALUES ( 107, 'Biography',     NULL, 'The story of one''s life, as told through the eyes of someone else', NULL);
INSERT INTO themes VALUES ( 108, 'Capitalism',    NULL, 'An economic and political system in which a country''s trade and industry are controlled by private owners for profit, rather than by the state.', NULL);
INSERT INTO themes VALUES ( 109, 'Christianity',  NULL, 'The branch of religion that worships Jesus Christ and his teachings', NULL);
INSERT INTO themes VALUES ( 110, 'Civilization',  NULL, 'The process by which a society or place reaches various stages of social development and organization beyond hunter-gatherer society.', NULL);
INSERT INTO themes VALUES ( 111, 'Companionship', NULL, 'A feeling of fellowship or friendship.', NULL);
INSERT INTO themes VALUES ( 112, 'Competition',   NULL, 'The act or process of trying to get or win something (such as a prize or a higher level of success) that someone else is also trying to get or win : the act or process of competing.', NULL);
INSERT INTO themes VALUES ( 113, 'Conquest',      NULL, 'The act of gaining control of (a problem or difficulty) through great effort.', NULL);
INSERT INTO themes VALUES ( 114, 'Conservation',  NULL, 'The act of maintaining and bettering the world by caring for the environment; this includes reducing waste, reusing or recycling materials, and looking out for animal habitats', NULL);
INSERT INTO themes VALUES ( 115, 'Conspiracy',    NULL, 'Of or relating to the belief that an event was orchestrated by a powerful group of people in secret', NULL);
INSERT INTO themes VALUES ( 116, 'Corruption',    NULL, 'Impairment of integrity, virtue, or moral principle, especially of those in power.', NULL);
INSERT INTO themes VALUES ( 117, 'Crime', 		   NULL, 'Actions that are deemed injurious to the public welfare or to the interests of the state and that are legally prohibited.', NULL);
INSERT INTO themes VALUES ( 118, 'Death', 		   NULL, 'Of or relating to the loss of a life, and the ability of those around them to cope with never seeing them again', NULL);
INSERT INTO themes VALUES ( 119, 'Destruction',   NULL, 'The widespread damage of a particular place or thing', NULL);
INSERT INTO themes VALUES ( 120, 'Diplomacy',     NULL, 'Of or relating to peaceful negotiations with other parties', NULL);
INSERT INTO themes VALUES ( 121, 'Dystopia',      NULL, 'A society in which social or technological trends have culminated in a greatly diminished quality of life or degradation of values.', NULL);
INSERT INTO themes VALUES ( 122, 'Economy',       NULL, 'The process or system by which goods and services are produced, sold, and bought in a country or region. Economy. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/economy', NULL);
INSERT INTO themes VALUES ( 123, 'Education',     NULL, 'The formal field that dictates how obtaining institutionalized knowledge is passed down from generation to generation', NULL);
INSERT INTO themes VALUES ( 124, 'Espionage',     NULL, 'Of or relating to acts of spying, often between different countries', NULL);
INSERT INTO themes VALUES ( 125, 'Evolution',     NULL, 'The process by which living things have adapted to changes in their surroundings over time, often by altering their genetic makeup', NULL);
INSERT INTO themes VALUES ( 126, 'Faith',         NULL, 'Something that is believed with strong conviction, despite an absence of evidence.', NULL);
INSERT INTO themes VALUES ( 127, 'Family',        NULL, 'A group of individuals (parents, siblings, etc.) who are related to each other, often (but not necessarily) by blood; these individuals have strong feelings of compassionate love and care for one another', NULL);
INSERT INTO themes VALUES ( 128, 'Fate',          NULL, 'The development of events beyond a person''s control, regarded as determined by a supernatural power.', NULL);
INSERT INTO themes VALUES ( 129, 'Freedom',       NULL, 'The power or right to act, speak, or think as one wants without hindrance or restraint.', NULL);
INSERT INTO themes VALUES ( 130, 'Growth',        NULL, 'The attainment of prominence, respectability, recognition, or maturity; usually a young person''s transition from childhood to adulthood.', NULL);
INSERT INTO themes VALUES ( 131, 'Heist',         NULL, 'An organized crime where criminals have a sophisticated plan to steal valuable items e.g., money, jewelry, or famous works of art', NULL);
INSERT INTO themes VALUES ( 132, 'Holiday',       NULL, 'The celebration of an event that is common between a large group of people, e.g., Christmas, Thanksgiving, etc.', NULL);
INSERT INTO themes VALUES ( 133, 'Honor',         NULL, 'Respect that is given to someone who is admired: good reputation : good quality or character as judged by other people: high moral standards of behavior.', NULL);
INSERT INTO themes VALUES ( 134, 'Identity',      NULL, 'The distinguishing characteristics or personality of an individual.', NULL);
INSERT INTO themes VALUES ( 135, 'Illuminati',    NULL, 'The secret organization/society dedicated to the opposition of religious influences over the public, as well as the abuse of state power', NULL);
INSERT INTO themes VALUES ( 136, 'Justice',       NULL, 'The quality of being just, impartial, or fair; :  the principle or ideal of just dealing or right action.', NULL);
INSERT INTO themes VALUES ( 137, 'Knowledge',     NULL, 'Facts information and skills acquired from a person through experience.', NULL);
INSERT INTO themes VALUES ( 138, 'LGBT',          NULL, 'An initialism that stands for lesbian, gay, bisexual, and transgender.', NULL);
INSERT INTO themes VALUES ( 139, 'Love',          NULL, 'A feeling of strong or constant affection for a person.', NULL);
INSERT INTO themes VALUES ( 140, 'Murder',        NULL, 'The crime in which one individual kills another in a premeditated manner', NULL);
INSERT INTO themes VALUES ( 141, 'Mystery',       NULL, 'Something not understood or beyond understanding.', NULL);
INSERT INTO themes VALUES ( 142, 'Occult',        NULL, 'Of or relating to the belief in the supernatural', 152);
INSERT INTO themes VALUES ( 143, 'Pandemic',      NULL, 'The occurrence of a disease spreading rapidly between individuals across geographic and national boundaries', NULL);
INSERT INTO themes VALUES ( 144, 'Paranormal',    NULL, 'Not understandable in terms of known scientific laws and phenomena. Paranormal. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/paranormal', 152);
INSERT INTO themes VALUES ( 145, 'Politics',      NULL, 'Activities that relate to influencing the actions and policies of a government or getting and keeping power in a government; a person''s political thoughts and opinions.', NULL);
INSERT INTO themes VALUES ( 146, 'Power',         NULL, 'The ability or right to control people or things; political control of a country or area; : a person or organization that has a lot of control and influence over other people or organizations.', NULL);
INSERT INTO themes VALUES ( 147, 'Prophecy',      NULL, 'A supernatural prediction about the future.', NULL);
INSERT INTO themes VALUES ( 148, 'Redemption',    NULL, 'The act of atoning for sin or wrongdoing (especially appeasing a deity).', NULL);
INSERT INTO themes VALUES ( 149, 'Revenge',       NULL, 'The action of inflicting hurt or harm on someone for an injury or wrong suffered at their hands.', NULL);
INSERT INTO themes VALUES ( 150, 'Sacrifice',     NULL, 'The selfless act in which one person gives up something of value to them for the sake of another', NULL);
INSERT INTO themes VALUES ( 151, 'Slavery',       NULL, 'The concept in which one person is legally owned by another and forced to do their bidding without any form of reimbursement. Slave. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/slave', NULL);
INSERT INTO themes VALUES ( 152, 'Supernatural',  NULL,  NULL, NULL);
INSERT INTO themes VALUES ( 153, 'Survival',      NULL, 'The state or fact of continuing to live or exist, typically in spite of an accident, ordeal, or difficult circumstances.', NULL);
INSERT INTO themes VALUES ( 154, 'Time Travel',   NULL, 'The concept in which one may move through different points in time—past or future—and experience what life is like at that moment', NULL);
INSERT INTO themes VALUES ( 155, 'Violence',      NULL, 'Behavior involving physical force intended to hurt, damage, or kill someone or something.', NULL);
INSERT INTO themes VALUES ( 156, 'War',           NULL, 'A state of armed conflict between different nations or states or different groups within a nation or state.', NULL);
INSERT INTO themes VALUES ( 157, 'Wealth',        NULL, 'An abundance of valuable possessions or money.', NULL);
INSERT INTO themes VALUES ( 158, 'Work',          NULL, 'Activity involving mental or physical effort done in order to achieve a purpose, result, or most often monetary gain', NULL);

INSERT INTO themes VALUES ( 159, 'Abandonment',   NULL, NULL, 102);
INSERT INTO themes VALUES ( 160, 'Autobiography', NULL, NULL, 107);
INSERT INTO themes VALUES ( 161, 'Bisexuality',   NULL, NULL, 138);
INSERT INTO themes VALUES ( 162, 'Coming-of-age', NULL, NULL, 130);
INSERT INTO themes VALUES ( 163, 'Creation',      NULL, NULL, 110);
INSERT INTO themes VALUES ( 164, 'Duty',          NULL, NULL, 133);
INSERT INTO themes VALUES ( 165, 'Financial Gain',NULL, NULL, 157);
INSERT INTO themes VALUES ( 166, 'Friendship',    NULL, NULL, 111);
INSERT INTO themes VALUES ( 167, 'Gay',           NULL, NULL, 138);
INSERT INTO themes VALUES ( 168, 'Greed',         NULL, NULL, 116);
INSERT INTO themes VALUES ( 169, 'Injustice',     NULL, NULL, 136);
INSERT INTO themes VALUES ( 170, 'Isolation',     NULL, NULL, 102);
INSERT INTO themes VALUES ( 171, 'Lesbian',       NULL, NULL, 138);
INSERT INTO themes VALUES ( 172, 'Loyalty',       NULL, NULL, 111);
INSERT INTO themes VALUES ( 173, 'Maturity',      NULL, NULL, 130);
INSERT INTO themes VALUES ( 174, 'Patriotism',    NULL, NULL, 133);
INSERT INTO themes VALUES ( 175, 'Pride',         NULL, NULL, 146);
INSERT INTO themes VALUES ( 176, 'Religion',      NULL, NULL, 126);
INSERT INTO themes VALUES ( 177, 'Reputation',    NULL, NULL, 133);
INSERT INTO themes VALUES ( 178, 'Romance',       NULL, NULL, 139);
INSERT INTO themes VALUES ( 179, 'Savagery',      NULL, NULL, 110);
INSERT INTO themes VALUES ( 180, 'Siblings',      NULL, NULL, 127);
INSERT INTO themes VALUES ( 181, 'Truth',         NULL, NULL, 133);

INSERT INTO themes VALUES ( 200, 'Animals',       NULL, 'Different species on earth that humans must coexist with.', NULL);
INSERT INTO themes VALUES ( 201, 'Pets',          200,  'Animals that have been domesticated and can be kept in one’s home, often for companionship', NULL);
INSERT INTO themes VALUES ( 202, 'Dogs',          201,  'A (typically) four-legged animal that barks, and has the title of “man’s best friend”', NULL);
INSERT INTO themes VALUES ( 203, 'Cats',          201,  'A (typically) four-legged animal that meows and purrs; they are usually small in size, low maintenance, and of the same family as lions, tigers, etc.', NULL);
INSERT INTO themes VALUES ( 204, 'Birds',         NULL, 'A flying animal that often chirps, building nests in trees as their homes', NULL);
INSERT INTO themes VALUES ( 205, 'Farm Animals',  200,  'Animals that have been domesticated for the use of farming; humans may also seek companionship from these animals, but they often do not live in the same shelter a humans', NULL);
INSERT INTO themes VALUES ( 206, 'Horses',        205,  'A large, four-legged animal that neighs and whinnies; before cars, humans often rode atop this animal with a saddle or hitched them up to a wagon', NULL);
INSERT INTO themes VALUES ( 207, 'Dinosaurs',     NULL, 'The large variety of reptiles that lived upon this earth millions of years ago e.g., triceratops, tyrannosaurus rex', NULL);
INSERT INTO themes VALUES ( 208, 'Dragons',       NULL, 'The mythical winged beast, often reptilian in appearance, that can fly and breathe fire', NULL);
INSERT INTO themes VALUES ( 209, 'Aquatic Life',  NULL, 'Of or relating to any beings that predominantly live and operate underwater', NULL);
INSERT INTO themes VALUES ( 210, 'Bugs',          NULL, 'Small insects that creep or crawl, and are often found residing in or around plants', NULL);
INSERT INTO themes VALUES ( 211, 'Plants',        NULL, 'Something that grows out from soil, often starting as a seed and maturing into a different living thing like a flower', NULL);
INSERT INTO themes VALUES ( 212, 'Trains',        NULL, 'A mode of transportation that involves the use of railroads and railcars', NULL);
INSERT INTO themes VALUES ( 213, 'Cars/Trucks',   NULL, 'A (usually) four-wheeled vehicle that operates on gasoline', NULL);
INSERT INTO themes VALUES ( 214, 'Motorcycles',   NULL, 'A (usually) two-wheeled vehicle that operates on gasoline; those who ride motorcycles must wear helmets', NULL);
INSERT INTO themes VALUES ( 215, 'Bicycles',      NULL, 'A two-wheeled vehicle that operates solely on manpower, in which its riders must pedal their way to their destination', NULL);
INSERT INTO themes VALUES ( 216, 'Boats/Ships',   NULL, 'A vehicle that is used to travel on water', NULL);
INSERT INTO themes VALUES ( 217, 'Submaries',     NULL, 'A vehicle that is used to travel underwater', NULL);
INSERT INTO themes VALUES ( 218, 'Drug',          NULL, 'An illegal and often harmful substance that people take for pleasure. Drug. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/drug', NULL);
INSERT INTO themes VALUES ( 219, 'Magicians',     NULL, 'Individuals who practice magic or illusions', NULL);
INSERT INTO themes VALUES ( 220, 'Royalty',       NULL, 'Those who belong or marry into a royal bloodline, such as kings, queens, princes, princesses, etc.', NULL);
INSERT INTO themes VALUES ( 221, 'Knights',       NULL, 'Individuals who swear their allegiance to and protect royalty', NULL);
INSERT INTO themes VALUES ( 222, 'Babies',        NULL, 'The smallest, youngest form of human beings possible; they require the utmost care and supervision', NULL);
INSERT INTO themes VALUES ( 223, 'Children',      NULL, 'Young human beings that are older than babies, and have an abundance of energy to run and play all day', NULL);
INSERT INTO themes VALUES ( 224, 'Puppets',       NULL, 'A doll that is moved by putting your hand inside it or by pulling strings or wires that are attached to it. Puppets. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/puppets', NULL);
INSERT INTO themes VALUES ( 225, 'Aliens',        NULL, 'Extraterrestrial beings that live on other planets throughout the solar system', NULL);
INSERT INTO themes VALUES ( 226, 'Robots',        NULL, 'Mechanized beings that were created by humans', NULL);
INSERT INTO themes VALUES ( 227, 'Computers and network', NULL, 'Of or relating to computers and the networks in which they operate', NULL);
INSERT INTO themes VALUES ( 228, 'Weapons',       NULL, 'Items whose chief purpose is to inflict harm on others', NULL);
INSERT INTO themes VALUES ( 229, 'Warriors',      NULL, 'Individuals who fight or engage in combat', NULL);
INSERT INTO themes VALUES ( 230, 'Assassins',     229,  'Individuals who are skilled in the elimination of other people', NULL);
INSERT INTO themes VALUES ( 231, 'Pirates',       229,  'Those who sail the Seven Seas, often for the purpose of seeking treasure or capturing other ships', NULL);
INSERT INTO themes VALUES ( 232, 'Samurai',       229,  'Noble Japanese warriors that fight in the name of honor and duty', NULL);
INSERT INTO themes VALUES ( 233, 'Ninja',         229,  'Skilled individuals, often Japanese, that fight and operate on the basis of silence and efficiency', NULL);
INSERT INTO themes VALUES ( 234, 'Gladiators',    229,  'Warriors from Roman times that fought in the Coliseum for sport', NULL);
INSERT INTO themes VALUES ( 235, 'Gangs',         229,  'A group of individuals that band together under leadership and/or similar ideals, often for the purpose of crime', NULL);
INSERT INTO themes VALUES ( 236, 'Yakuza',        235,  'The Japanese form of the mafia/gangs', NULL);
INSERT INTO themes VALUES ( 237, 'Mafia',         235,  'Gangs characterized by Italian individuals and underground crime rings', NULL);
INSERT INTO themes VALUES ( 238, 'Mercenary',     NULL, 'An individual hired to fight; their only allegiance is to those who pay them the most money', NULL);
INSERT INTO themes VALUES ( 239, 'Detective',     NULL, 'An individual who solves crimes', NULL);
INSERT INTO themes VALUES ( 240, 'Superheroes',   NULL, 'Extraordinary individuals with unique power who dedicate their powers to fighting evil and doing good in the world; they often have powers or abilities that normal people do not e.g., super strength, speed, flight, etc.', NULL);
INSERT INTO themes VALUES ( 241, 'Gods',          NULL, '“Perfect” beings, whether religious or mythical, that are worshipped by normal humans for their power over human life and experiences', NULL);
INSERT INTO themes VALUES ( 242, 'Angels',        NULL, 'A spiritual, celestial being that does good in the name of God; they are often benevolent in nature', NULL);
INSERT INTO themes VALUES ( 243, 'Demons',        NULL, 'An evil spirit that often seeks to cause harm, distress, or ruin. Demon. (n.d.) In Merriam-Webster online. Retreived from http://www.merriam-webster.com/dictionary/demon', NULL);
INSERT INTO themes VALUES ( 244, 'Vampires',      NULL, 'An inhuman, supernatural being that often resembles humans; the chief difference is that their chief source of sustenance is blood', NULL);
INSERT INTO themes VALUES ( 245, 'Zombies',       NULL, 'The reanimated corpse of a dead person, often depicted as rotting and wanting nothing more than to eat those that are alive', NULL);
INSERT INTO themes VALUES ( 246, 'Monsters',      NULL, 'An imaginary creature often depicted as scary and fiercely abnormal', NULL);
INSERT INTO themes VALUES ( 247, 'Fairies',       NULL, 'A mythological being, often small in stature, with magical powers', NULL);
INSERT INTO themes VALUES ( 248, 'Ghosts',        NULL, 'The supernatural form of one’s spirit after their passing from the mortal world', NULL);
INSERT INTO themes VALUES ( 249, 'Cowboys and Cowgirls', NULL, 'Individuals who care for cows or horses, often appearing in Western settings', NULL);
INSERT INTO themes VALUES ( 250, 'Space',         NULL, 'Of or relating to the solar system, and the infinite universes beyond/within it', NULL);
INSERT INTO themes VALUES ( 251, 'Tanks',         NULL, 'A weaponized vehicle with a thick shell of armor, often used in wars', NULL);
INSERT INTO themes VALUES ( 252, 'Magic',         NULL, 'Of or relating to mystical practices, involving things like spells and potions', NULL);
INSERT INTO themes VALUES ( 253, 'Military',      NULL, 'A nation’s army and chief defense against other nations', NULL);
INSERT INTO themes VALUES ( 254, 'Airplane',      NULL, 'A winged-vehicle that is used to travel the skies, as opposed to a helicopter', NULL);
INSERT INTO themes VALUES ( 255, 'Rollercoaster', NULL, 'An amusement park ride characterized by quick speeds, abnormal heights, and the adrenaline/thrill it offers to its passengers', NULL);
INSERT INTO themes VALUES ( 256, 'Wild Animals',  NULL, 'Animals that have not been domesticated, and must be approached with caution', NULL);


INSERT INTO themes VALUES ( 257, 'Fish',          NULL, NULL, 209);
INSERT INTO themes VALUES ( 258, 'Mechs',         NULL, NULL, 226);
INSERT INTO themes VALUES ( 259, 'Solidiers',     NULL, 'Those who enlisted to join the military and/or its various branches', 253);
INSERT INTO themes VALUES ( 260, 'Watercraft',    NULL, NULL, 216);
INSERT INTO themes VALUES ( 261, 'Navy',          NULL, NULL, 253);
INSERT INTO themes VALUES ( 262, 'Airforce',      NULL, NULL, 253);
INSERT INTO themes VALUES ( 263, 'Spy',           NULL, NULL, 124);


-- Create insert statements for farming

INSERT INTO themes VALUES( 300, 'Farming',       NULL, 'The act of raising animals or preparing/harvesting crops.', NULL);
INSERT INTO themes VALUES( 301, 'Dating',        NULL, 'The process of geting to know and assessing one''s romantic interest.', NULL);
INSERT INTO themes VALUES( 302, 'Demolition',    NULL, 'The approved deliberate destruction of a building or other structure.', NULL);
INSERT INTO themes VALUES( 303, 'Cooking',       NULL, 'The act of preparing foods for consumption, often involving the use of a stove or oven as a heat source.', NULL);
INSERT INTO themes VALUES( 304, 'City-building', NULL, 'The construction of a city.', NULL);
INSERT INTO themes VALUES( 305, 'Management',    NULL, 'The delegation of work among people, or the ability to prioritize tasks and carry them out to completion.', NULL);
INSERT INTO themes VALUES( 306, 'Travel',        NULL, 'The act of going on a trip or journey away from one’s home, often to a neighboring state or country.', NULL);
INSERT INTO themes VALUES( 307, 'Baking',        NULL, 'The act of creating baked goods like bread for consumption, primarily using an oven.', NULL);
INSERT INTO themes VALUES( 308, 'Design',        NULL, 'The subject matter that belongs to the creation of aesthetically pleasing graphics.', NULL);
INSERT INTO themes VALUES( 309, 'Hacking',       NULL, 'Of or relating to the act of circumventing security measures in computerized systems for personal gain or social activism.', NULL);
INSERT INTO themes VALUES( 310, 'Construction',  NULL, 'The act or process of assembling items into a coherent structure (e.g., house).', NULL);
INSERT INTO themes VALUES( 311, 'Simulation',    NULL, 'A computerized imitation of real-world practices or occurrences.', NULL);
INSERT INTO themes VALUES( 312, 'Flying',        NULL, 'The act of being able to soar throughout the skies, getting from one destination to another.', NULL);
INSERT INTO themes VALUES( 314, 'Combat',        NULL, 'The skilled form of combat centered on the use of swords.', NULL);
INSERT INTO themes VALUES( 313, 'Swordplay',     314,  'The skilled form of combat centered on the use of swords.', NULL);
INSERT INTO themes VALUES( 315, 'Trading',       NULL, 'The act of swapping items with an individual in exchange for different items.', NULL);
INSERT INTO themes VALUES( 316, 'Mining',        NULL, 'The process or business of digging in mines to obtain minerals, metals, jewels, etc.', NULL);
INSERT INTO themes VALUES( 317, 'Crafting',      NULL, 'The process of creating useful items.', NULL);
INSERT INTO themes VALUES( 318, 'Exploration',   NULL, 'Of or relating to the discovery of new places.', NULL);
INSERT INTO themes VALUES( 319, 'Flight',        NULL, NULL, 312);
INSERT INTO themes VALUES( 321, 'Sports',        NULL, 'An organized activity that involves multiple teams or individuals competing against each other to see who’s the best.', NULL);
INSERT INTO themes VALUES( 320, 'Racing',        321,  'A competition centered on who can travel through a set course the quickest.', NULL);
INSERT INTO themes VALUES( 322, 'Baseball',      321,  'A game played on a large field between two teams, involving the use of bats, mitts, and a baseball.', NULL);
INSERT INTO themes VALUES( 323, 'Basketball',    321,  'a game played on a court with two hoops; the main objective of the game is to score the most points by shooting a basketball through the proper hoop.', NULL);
INSERT INTO themes VALUES( 324, 'Bicycling',     321,  'A competition that involves riding one’s bike through a set course the quickest.', NULL);
INSERT INTO themes VALUES( 325, 'Billiards',     321,  'A game that involves the use of a pool table, pool cues, a cue ball, and billiard balls; the object of the game is to sink the billiard balls into the pool table pockets in a predefined manner.', NULL);
INSERT INTO themes VALUES( 326, 'Boxing',        321,  'The sport centered on fighting others in a regulated, organized manner; it is often in a boxing ring, using boxing gloves and appropriate safety gear.', NULL);
INSERT INTO themes VALUES( 327, 'Bowling',       321,  'A game that relies on the use of bowling balls and bowling pins; the object of the game is to gain the highest score possible by knocking down the most pins in the least amount of tries possible.', NULL);
INSERT INTO themes VALUES( 328, 'Football',      321,  'An organized sport played between two teams on a large field, involving the use of a football.', NULL);
INSERT INTO themes VALUES( 329, 'Soccer',        321,  'A game played on a large field involving the use of a soccer ball and trying to score as many goals as possible.', NULL);
INSERT INTO themes VALUES( 330, 'Volleyball',    321,  'A game played with a volleyball on a large court, separated by a high net.', NULL);
INSERT INTO themes VALUES( 331, 'Swimming',      321,  'The competitive sport that involves racing against others in a swimming pool to see who can swim the fastest.', NULL);
INSERT INTO themes VALUES( 332, 'Skiiing',       321,  'A sport that involves the use of ski poles and ski boards to race down a snowy mountainside.', NULL);
INSERT INTO themes VALUES( 333, 'Snowboarding',  321,  'A sport that involves the sue of snowboards to race down a snowy mountainside.', NULL);
INSERT INTO themes VALUES( 334, 'Curling',       321,  'A game in which two teams of four players slide special stones over ice toward a circle.', NULL);
INSERT INTO themes VALUES( 335, 'Golf',          321,  'A game in which individuals hit golf balls towards golf holes; the goal of the game is to do so in as few hits as possible.', NULL);
INSERT INTO themes VALUES( 336, 'Hockey',        321,  'A sport that involves the sue of snowboards to race down a snowy mountainside.', NULL);
INSERT INTO themes VALUES( 337, 'Martial Arts',  321,  'A type of combative art form with roots historically Asian roots.', NULL);
INSERT INTO themes VALUES( 338, 'Tennis',        321,  'A game that takes place on a court separated by a low net, involving the use of tennis balls and tennis rackets.', NULL);
INSERT INTO themes VALUES( 339, 'Wrestling',     321,  'A type of combative sport in which players must pin down others for a set period of time.', NULL);
INSERT INTO themes VALUES( 340, 'Fighting',      321,  'Of or relating to physical altercations with another individual.', NULL);
INSERT INTO themes VALUES( 341, 'Fencing',       321,  'A sport centered on the use of swords and graceful swordplay.', 341);
INSERT INTO themes VALUES( 342, 'Skateboarding', 321,  'a sport or activity centered on the use of skateboards and doing tricks.', NULL);
INSERT INTO themes VALUES( 343, 'Surfing',       321,  'A sport or activity centered on the use of a surfboard, in which individuals ride atop waves.', NULL);
INSERT INTO themes VALUES( 344, 'Dance',         321,  'A sport or activity that involves the graceful movement on one’s body in time to music.', NULL);
INSERT INTO themes VALUES( 345, 'Hunting',       321,  'The activity of killing animals for sport, often in a regulated manner.', NULL);
INSERT INTO themes VALUES( 346, 'Fishing',       321,  'The sport or activity centered on being able to catch fish using a net or fishing pole.', NULL);
INSERT INTO themes VALUES( 347, 'Table tennis',  321,  'Also known as ping pong, table tennis is a game played using a table divided with a low net, paddles, and a ping pong ball.', NULL);
INSERT INTO themes VALUES( 348, 'Cricket',       321,  'A game played with a ball and bat by two sides of usually 11 players each on a large field centering upon two wickets each defended by a batsman.', NULL);
INSERT INTO themes VALUES( 349, 'Pool',          321,  NULL, 325);
INSERT INTO themes VALUES( 350, 'Rugby',         321,  'A game played by two teams in which each team tries to carry or kick a ball over the other team’s goal line.', NULL);
INSERT INTO themes VALUES( 351, 'Sailing',       321,  'The sport of activity of traveling on water in a sailboat.', NULL);
-- This one had a USE FOR in the Construction element, but didn''t appear to have its own entry in the CV...
INSERT INTO themes VALUES( 352, 'Building',      NULL,  NULL, 310);
-- Create insert statements for art

INSERT INTO themes VALUES( 400, 'Art', NULL, 'Of or relating to visually creative works.', NULL);
INSERT INTO themes VALUES( 401, 'Health', NULL, 'Of or relating to the maintenance of one’s body in peak physical condition.', NULL);
INSERT INTO themes VALUES( 402, 'Architecture', NULL, 'Of or relating to the design and construction of buildings.', NULL);
INSERT INTO themes VALUES( 403, 'Music', NULL, 'Of or relating to the creation of creative auditory works.', NULL);
INSERT INTO themes VALUES( 404, 'Fashion and Beauty', NULL, 'Of or relating to the industry centered on clothing and outward appearances.', NULL);
INSERT INTO themes VALUES( 405, 'Business', NULL, 'Of or relating to buying and selling of goods.', NULL);
INSERT INTO themes VALUES( 406, 'Mythology', NULL, 'Of or relating to the study of myths and mythical beings like gods and goddesses.', NULL);
INSERT INTO themes VALUES( 407, 'Science', NULL, 'Of or relating to the study of the natural world.', NULL);
INSERT INTO themes VALUES( 408, 'Agriculture', NULL, 'Of or relating to caring for or harvesting animals and crops.', NULL);
INSERT INTO themes VALUES( 409, 'Astronomy', NULL, NULL, 200 -- Whatever the number for Space is that Sam used
);

INSERT INTO tropes VALUES (1,    'Character Tropes',                  NULL, NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (2,    'Narrative Tropes',                  NULL, NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (10,   'Archetypal Pro/Antagonists',        1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (11,   'Exceptional Beings',                1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (12,   'Leaders',                           1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (13,   'Allies',                            1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (14,   'Philosophies and Cultures',         1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (15,   'Fighting Style',                    1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (16,   'Appearance as Personality',         1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (17,   'Gender',                            1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (18,   'Race',                              1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (19,   'Teams',                             1,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (20,   'Mortality',                         2,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (21,   'Driving Actions',                   2,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (22,   'Call to Adventure',                 2,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (23,   'Team Building',                     2,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (24,   'Climax',                            2,    NULL, NULL, 'FALSE');
INSERT INTO tropes VALUES (25,   'Endings  ',                         2,    NULL, NULL, 'FALSE'); 
INSERT INTO tropes VALUES (1000, 'The Strong Female Lead',           10,   'A strong, independent female character that is central to the story (e.g. Lara Croft from Tomb Raider and Bayonetta from Bayonetta).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1001, 'The Ideal Hero',                   10,   'This male character often appears the same across many different games. For example, in many games there is a white male character with a buzz-cut and a strong jawline (e.g. Master Chief from the Halo Franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1002, 'The Bold Explorer',                10,   'This is a character driven by the quest to discover new lands, ideas, people, and experiences. This is different from The Conquer in that they do not need to possess the new item, location, or idea. The experience is often enough (e.g. the protagonists of Uncharted Waters, specifically Ernst).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1003, 'The Collector',                    10,   'A character whose motivating factor is to collect all of something (e.g. the main antagonist in LittleBigPlanet).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1004, 'The Builder',                      10,   'A character whose motivating factor is to create or construct something, typically physical.  This is often an empire or civilization that might also be for their private use (e.g. some individuals playing Minecraft and the Prince from Katamari Demacy).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1005, 'The Ranger',                       10,   'A person who spends most of their time in the outdoors and who is proficient at hunting, tracking, and wilderness survival (e.g. Anden Goodmanner from A Dance with Rogues).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1006, 'The Average Individual',           10,   'This character has no exceptional abilities (e.g. the protagonist from Persona 3)', NULL, 'TRUE');
INSERT INTO tropes VALUES (1007, 'The Chosen One',                   10,   'This character has been chosen by their people or divine beings to make a difference in the world (e.g. Link from Zelda).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1008, 'The Reluctant Hero',               10,   'A character that does not want to take an active role in the story, but finds they should or must (e.g. Chun Li from the Street Fighter franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1009, 'The Secret Police',                10,   'Police or police-like figures that use questionable or subversive methods to investigate possible crimes against the state or the main authority (e.g. Any government operative in Deus X).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1010, 'The Spy/Spymaster',                10,   'An individual whose job it is to coordinate and gather information. Often an indispensable ally (e.g. Hiram Burrows from Dishonor).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1011, 'The Evil Rich Person',             10,   'Money buys power. And power often corrupts (e.g. The Mario series generally features wealthy, evil royalty).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1012, 'The Big Bad',                      10,   'This character may or may not have powers, but he/she/it is the main antagonist of the story. This is usually the final boss in a game. Defeating The Big Bad will make the hero triumphant (e.g. The Lord of Terror from Diablo).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1013, 'The Sadistic Instructor',          10,   'This character takes pleasure in making their pupil suffer. An example could be a particularly mean drill sergeant (e.g. Principal Hanya from Persona 2).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1014, 'The Dangerous Relative',           10,   'This character is someone related to the main character or a trusted family friend or advisor. They represent a threat to the main character (e.g. Balin from Dragon Age: Origins).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1015, 'The Reluctant Villain',            10,   'This character cannot achieve their goals within legal or moral restrictions, so they reluctantly take matters into their own hands. Conversely, they may also be following laws or moral restrictions to the letter, despite reservations (e.g. Daisy Fitzroy from BioShock Infinite).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1016, 'The Outlaw',                       10,   'A character who operates outside of the law for good or evil (e.g. The main character from Red Dead Redemption).' , NULL, 'TRUE');
INSERT INTO tropes VALUES (1017, 'The Unsettling Child',             10,   'This character is a young child or adolescent that may or may not actually be creepy, but they project a creepy or unusual demeanor. Unlike the Deadly Child, they may not be violent or skilled (e.g. The Little Sisters from BioShock).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1018, 'The Deadly Child',                 10,   'This character is a young child or adolescent that may not seem dangerous at first glance, but they are either formidable fighters or have supernatural powers (e.g. The children who live in Little Lamplight in Fallout 3 and Annie from League of Legends).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1019, 'The Convenient Orphan',            10,   'This character has no parents or guardians to keep them in place when they are first introduced to the player (e.g. Harry Potter from any of the Harry Potter games).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1020, 'The Amnesiac Hero',                10,   'This character has no memory of events that took place immediately before the start of the story (e.g. Dust from Dust: An Elysian Tail, the main character of Amnesia: The Dark Descent).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1100, 'The Cursed Beast',                 11,   'This character was once a human or human-like life form that was changed into an animal or monster that may be misunderstood by other characters (e.g. Kronos from Kronos God of War or any werewolf characters).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1101, 'The Demonic Foe',                  11,   'A character that is from an underworld and represents a greater evil (e.g. Magus of Chrono Trigger).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1102, 'The Antichrist',                   11,   'The character that is the highest member of an evil hierarchy, often from the underworld (e.g. Sephiroth from Final Fantasy VII).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1103, 'The Eldritch Abomination',         11,   'This character is a creature that has never been seen before, like Cthulhu (e.g. The Reapers from the Mass Effect franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1104, 'The Threshold Guardian',           11,   'This character possesses knowledge or has access to something that the main characters need to move forward in the story (e.g. Faralda from The Elder Scrolls V: Skyrim).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1105, 'The Living Statue',                11,   'This is a character or characters that were once inanimate and then activated by another character (e.g. The chess pieces that come to life in Harry Potter and the Sorcerer’s Stone).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1106, 'The Disembodied Voice',            11,   'This character may be a voice heard over an intercom or a supernatural being (e.g. Ness’ father in Earthbound).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1107, 'The Undead',                       11,   'Any undead or otherwise supernaturally animated creature that was once alive (e.g. This can include vampires and zombies).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1201, 'The Runaway Royal',                12,   'A person with noble lineage who skirts responsibility or wants to be free from their responsibilities (e.g. Marle from Chrono Trigger).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1202, 'The Prince(ss) in Disguise',       12,   'A character that may or may not be aware of their royal blood, but is hidden for one reason or another (e.g. Alistair in Dragon Age: Origins and Zelda (as Shiek) from the Legend of Zelda: Ocarina of Time).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1203, 'The Overlord',                     12,   'This character may represent some sort of evil and controls a vast army of minions. They may or may not be the main antagonist (e.g. Dr. Robotnik from Sonic the Hedgehog).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1204, 'The Conqueror',                    12,   'A character whose primary objective is to possess and control lands, people, and resources in order to increase their power (e.g. Walhart from Fire Emblem Awakening).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1205, 'The Commander',                    12,   'A person in charge of a combat unit or armed forces (e.g. Commander Shepard from the Mass Effect franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1300, 'The Animal Sidekick',              13,   'A creature that accompanies the main character throughout the story (e.g. Cedric the Owl from King’s Quest V).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1301, 'The Adorable Minion(s)',           13,   'An individual character or group of small creatures that work for a particular individual and their ultimate goal (e.g. the Tonberry and Moogle from the Final Fantasy franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1302, 'The War Veteran',                  13,   'A character that has experienced combat and that experience of combat is formative to their personality (e.g. Cole Phelps from L.A. Noire).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1303, 'The Sacrificial Lamb',             13,   'A character that is due to be sacrificed to a greater cause either by divine prophecy or as collateral damage (e.g. Zero from Mega Man X).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1304, 'The Mooks',                        13,   'A commonly encountered and dispensable enemy employed by the antagonist character operating individually or in a larger group (e.g. the Storm Troopers from the Star Wars franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1305, 'The Hostages',                     13,   'Characters who are held captive by the antagonist in order to leverage the protagonist into doing the bidding of the antagonist.  They generally require rescue. (e.g. Promo Girl from the Resident Evil 3: Nemesis during Operation: Mad Jackal).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1306, 'The Funny Helper',                 13,   'A character that is not immediately perceived as useful and relied on by a storyteller for comic relief. However, their guidance or assistance for a quest makes them indispensable (e.g. Navi from Legend of Zelda: Ocarina of Time).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1307, 'The Determinator',                 13,   'A character that will not give up on their personal agenda. No matter what. Their past or their family often motivates them (e.g. Mario from the Mario franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1308, 'The Vessel/Conduit',               13,   'An individual chosen by divine intervention for some higher purpose. This purpose may include acting as a “fifth element” (a physical embodiment of a concept) or host (e.g. Dorman in Shadow of the Colossus).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1309, 'The Underworld God',               13,   'A character who rules the underworld (e.g. The Seven Great Evils in the Diablo series).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1310, 'The Sprite',                       13,   'A small icon or creature that assists a character throughout their story and may offer special skills to a player such as enhancing an attack (e.g. Navi from Legend of Zelda: Ocarina of Time and Pix from League of Legends).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1311, 'The Morality Pet',                 13,   'A character that mediates another characters morality (e.g. Raphael’s daughter Amy from Soul Calibur).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1312, 'The Designated Victim',            13,   'A character who is perpetually in danger due to their innocence or naiveté and they are usually saved by the protagonist (e.g. Princess Peach from the Mario franchise', NULL, 'TRUE');
INSERT INTO tropes VALUES (1313, 'The Good All Along Character',     13,   'A character who is believed to be evil at the beginning of the story, though investigation or new information is actually revealed to be an ally or “good guy” (e.g. No example provide for this due to possible spoilers. Proceed with caution when assigning this trope).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1400, 'The Barbarian(s)',                 14,   'A group of people outside of the main society that usually live without technology and operate on a tribal system of governance (e.g. Centaurs in World of Warcraft).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1401, 'The Assimilator(s)',               14,   'An individual or group of characters that holds a philosophical belief that everyone must be similar or the same (e.g. The Geth from Mass Effect or the Borg the Star Trek franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1402, 'The Fundamentalist(s)',            14,   'An individual or group of characters driven solely by the strength of their beliefs in politics or religion to the point of which they try to convert anyone to their point of view (e.g. The Qunari from Dragon Age).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1403, 'The Heretic(s)',                   14,   'An individual or group of characters that go against the ideological flow of a larger group with possible risks to their well being (e.g. Nero from Devil May Cry 4).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1404, 'The Isolationist(s)',              14,   'An individual or small group of characters that believe they must stay separate from a larger population (e.g. The Mages’ Collective from Dragon Age and the Gerudo tribe from Legend of Zelda: Ocarina of Time).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1405, 'The Revolutionary(ies)',           14,   'A group or individual whose primary goal is to change the status quo (e.g. The Alliance from the Star Wars franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1406, 'The Pirate(s)',                    14,   'An individual or group of characters that steal large quantities of goods (government or private property), usually on some sort of large transport vessel (e.g. The pirates from The Pirates of the Caribbean franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1407, 'The Otherworldly Visitor(s)',      14,   'An individual or group of characters that come from a different world or time (e.g. The Four Masks from Shadow Hearts).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1408, 'The Horde',                        14,   'Typically an army or gathering that has strength in numbers and are enemy or other to the main protagonists (e.g. Orcs from The Lord of the Rings franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1500, 'The Brawler',                      15,   'A character that is quick to fight and often has a short temper (e.g. Liquid Snake from Metal Gear Solid).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1501, 'The Magic User',                   15,   'A wizard, witch, or other character that has supernatural powers  (e.g. Vivi from Final Fantasy VII).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1502, 'The Girly Fighter',                15,   'A character that uses methods that are based in gendered stereotypes (i.e. fighting with a skillet). This character may also have extreme flexibility or unlikely acrobatics and may have physically revealing fighting styles that male characters would not employ in order for the storyteller or game designer to show off the female body (e.g. Momoko from The King of Fighters, commonly seen in arcade style fighting games such as Soul Caliber, Street Fighter, Mortal Combat, etc.).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1503, 'The Tank',                         15,   'A character that is the target of assault and sustains the most damage during battle. Often they are used strategically to draw attention away from weaker characters so they can pursue their own directives  (e.g. The Heavy from Team Fortress 2).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1504, 'The Rogue',                        15,   'A character that employees stealth, dirty fighting, and agile techniques  to inflict the most damage on enemies while avoiding taking damage themselves  (e.g. The main characters in Assassin’s Creed).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1600, 'Aloof, Dark Haired Girl',          16,   'Hair color as and indication of personality (e.g. Ada Wong from Resident Evil).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1601, 'The Gentle Giant',                 16,   'This character may seem formidable based on its appearance, but it is actually an ally (e.g. Claude from Shining Force 2).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1602, 'White Hair, Black Heart',          16,   'Hair color as an indication of personality (e.g. Sephiroth from Final Fantasy VII).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1603, 'Blondes are Dumb/Vain/Villains',   16,   'Hair color as an indication of personality (e.g. King Cailan from Dragon Age: Origins).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1604, 'Fat Bastard',                      16,   'A jerk of large girth. RT: The Evil Rich Person (e.g. Wario from the Mario franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1700, 'The Patriarch',                    17,   'A male head of a family or tribe (e.g. Sun Jian in the Dynasty Warriors series).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1701, 'The Matriarch',                    17,   'A female head of a family or tribe (e.g. Benezia from Mass Effect).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1702, 'The Girl in the Boys Club',        17,   'The female character in the story or game that embodies typically masculine traits (e.g. Seong Mian from Sole Calibur).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1703, 'The Cute Bruiser ',                17,   'A cute, diminutive character that packs a powerful punch or has a prickly personality (e.g. Kirby from the Kirby franchise and Shantotto from Final Fantasy XIV).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1704, 'The Femme Fatale',                 17,   'A female character that is deadly and often has a tragic backstory  (e.g. Maggie Chow in Deus X).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1705, 'The Affirmative Action Girl',      17,   'The single female character in the story or game of all male characters (e.g. Of the four playable characters in Borderlands, only one is female).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1706, 'The Manic Pixie Dream Girl',       17,   'A female character whose sole reason of existence is to enliven the life of (a usually male) character (e.g. Catherine from the game of the same name).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1707, 'The Ms. Male Character',           17,   'A female version of character that was originally male  (e.g. Ms. Pac Man and Toadette from Mario franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1708, 'The Woman as Decor',               17,   'When female characters are depicted in games only as objects to be rescued, sexually pursued, or protected and otherwise serves no function in the narrative  (e.g. Any sex worker or groupie in Saint’s Row or women in the Grand Theft Auto franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1800, 'The Token Black Person',           18,   'When there is one black person in a cast of otherwise white characters. (e.g. Nick Meyer from Snake’s Revenge) ', NULL, 'TRUE');
INSERT INTO tropes VALUES (1801, 'The Asian Tech Genius',            18,   'When the Asian character is really good with STEM subjects to the exclusion of other skills, particularly social skills (e.g. Jung Park from Rainbow Six).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1802, 'The Native Shaman',                18,   'When an indigenous character has a connection or powers relating to the Earth or animals and this is usually an inherited trait from a tribe or their ancestry (e.g. Nightwolf from the Mortal Kombat franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1803, 'The Minority Alien Stand-In',      18,   'When a character is of alien origins is meant to represent an analog to real-world ethnicities or races and these real-world ethnicities or races do not appear in the universe otherwise (e.g. The Syreen from Star Control 2 and several races from the Mass Effect franchise).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1804, 'The Exotic Black Woman',           18,   'A form of “blacksplotation” that simultaneously sexualized and defeminizes a black female character (e.g. Vivienne from Dragon Age).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1900, 'The Badass and Child Duo',         19,   'Typically a larger individual who is paired with a young child with the “badass” providing protection and support for the child (e.g. Corvo Attano and Emily Kaldwin from Dishonor).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1901, 'The Odd Couple',                   19,   'When two characters compliment each other in terms of physical appearance or personalities. Often one is more serious than the other (e.g. Fia and Lian in Riviera: The Promised Land).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1902, 'The Bickering Henchmen',           19,   'Two to three individuals aligned with the antagonists that cannot seem to agree on anything. (e.g. The brothers in Myst).', NULL, 'TRUE');
INSERT INTO tropes VALUES (1903, 'The Fantastic Four',               19,   'A team of four individuals who all compliment each other in appearance, skills, and/or fighting styles. (e.g. The Black, White, Red, and Yellow birds from Angry Birds).', NULL, 'TRUE');
INSERT INTO tropes VALUES (2000, 'Face/Heel Turn',                   20,   'When a character changes their alliance unexpectedly and sticks with their choice.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2001, 'Friends, Not Food',                20,   'When a character struggles with the desire to connect with others despite them being a food source for them.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2002, 'End Justify the Means',            20,   'When a character takes action that negatively impacts others to achieve a perceived “greater good.”', NULL, 'TRUE');
INSERT INTO tropes VALUES (2003, 'Too Good for this World',          20,   'A character so pure and perfect that they cannot live in this world and thus they get killed, often driving the main character to greater feats of heroics on their behalf.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2004, 'Sadistic Choice',                  20,   'When a character or group of characters is presented with a lose-lose choice from their foe (i.e. chose between two loved ones).', NULL, 'TRUE');
INSERT INTO tropes VALUES (2100, 'Placate the Thing',                21,   'When a character needs or soothe a creature that would normally intend harm in order to get past them.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2101, 'Assemble the Thing',               21,   'When a character or group of characters needs to create something in order to move forward with the story.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2102, 'Escape the Labyrinth',             21,   'When a character or characters must find their way through a maze or maze-like setting.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2103, 'Slay the Dragon',                  21,   'When a character or group of characters needs to defeat a beast based on a request from the public or an individual or a serendipitous encounter.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2104, 'Find the Thing',                   21,   'When a character or team needs to locate a particular item, creature, or individual in order to move forward with the story.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2105, 'Perpetually Saving Private Ryan',  21,   'This trope occurs when a character or a group of characters continually rescues one particular character.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2200, 'Bad Guy Done Us Wrong',            22,   'Sometimes unrelated characters band together because they were each wronged in a similar or different way by the same character.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2201, 'Destiny Reveal',                   22,   'When a character learns something important about their future or receives a calling from a higher power.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2202, 'Another Dimension',                22,   'When a character or group of characters is pulled into another dimension and needs to find a way home.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2203, 'Resistance is Futile',             22,   'A large entity seems like an insurmountable foe, but a small group of resistance fighters come together to attempt to defeat them.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2300, 'With Our Powers Combined',         23,   'When two characters enhance their powers by joining their efforts or physical items to create a larger item. Sometimes this can also mean a bond of a spiritual sort.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2301, 'The Enemy of my Enemy...',         23,   'When two characters or teams from opposing sides join forces to defeat a common foe.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2302, 'Former Friends, Now Foes',         23,   'When two or more characters were once allies, but events in the past have pushed them apart to the point at which they are now enemies.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2400, 'Darkest Before the Dawn',          24,   'At the climax of the story, everything seems hopeless. ', NULL, 'TRUE');
INSERT INTO tropes VALUES (2401, 'Hail Mary',                        24,   'At the climax of the story, this is the last-ditch effort made by the protagonists or teammates to overcome their trials. It often accompanies a “this is so crazy it just might work” type of plan.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2402, 'Heroic Sacrifice',                 24,   'At the climax of the story, one of the main characters sacrifices themselves to save others.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2403, 'Almost Dead Killshot',             24,   'At the climax of the story, one of the characters that the players thought wasdead (or nearly dead) delivers a mortal wound to their opponent, often saving another individual in the process.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2404, 'Pointless Revenge',                24,   'At the climax, once revenge has been achieved for a character for whom it was the driving force, new information comes to light that renders the revenge unethical or unnecessary even though it has already happened.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2500, 'I Choose to Stay',                 25,   'At the end of the story, one of the characters chooses to stay in the new setting instead of going home with their teammates (if they have any).', NULL, 'TRUE');
INSERT INTO tropes VALUES (2501, 'But Now I Must Go',                25,   'At the end of the story, one of the main protagonists leaves the group after their ordeal is over.', NULL, 'TRUE');
INSERT INTO tropes VALUES (2502, 'Ambiguous',                        25,   'At the end of the game players are unsure of the ending- it could go multiple ways.', NULL, 'TRUE');
INSERT INTO tropes VALUES (1021, 'The Hunter',                       10,   NULL, 1005, 'FALSE');
INSERT INTO tropes VALUES (1022, 'The Ordinary High School Student', 10,   NULL, 1006, 'FALSE');
INSERT INTO tropes VALUES (1409, 'The Swarm',                        14,   NULL, 1408, 'FALSE');
INSERT INTO tropes VALUES (1505,' The Assassin',                     15,   NULL, 1504, 'FALSE');
INSERT INTO tropes VALUES (1709,' The Burly Bruiser',                15,   NULL, 1503, 'FALSE');

INSERT INTO moods VALUES (1,  'Adventurous',   'Games that engage the player through exploration, risk-taking, and overcoming obstacles.', NULL);
INSERT INTO moods VALUES (2,  'Aggressive',    'Games in which the focus is on forceful, combative actions.', NULL);
INSERT INTO moods VALUES (9,  'Competitive',   'Games in which the focus is on competition between other players, either real or artificial.', NULL);
INSERT INTO moods VALUES (10, 'Comradery',     'Games in which positive social bonding occurs, either with other players or in-game characters.', NULL);
INSERT INTO moods VALUES (12, 'Cute',          'Games with a charming, childish, and/or delightful quality.', NULL);
INSERT INTO moods VALUES (14, 'Dark',          'Games with a grim atmosphere that focus on dismal, gloomy, and/or depressing circumstances.', NULL);
INSERT INTO moods VALUES (21, 'Horror',        'Games that frighten players by playing on primal fears, inducing feelings of horror and terror.', NULL);
INSERT INTO moods VALUES (22, 'Humorous',      'Games that possess a funny, amusing quality.', NULL);
INSERT INTO moods VALUES (23, 'Imaginative',   'Games where the primary focus is creative expression of the player, through world building, character-building, and/or creative problem-solving.', NULL);
INSERT INTO moods VALUES (24, 'Immersive',     'Games that mentally transport or transfix the player to the world or realm presented in the game.', NULL);
INSERT INTO moods VALUES (25, 'Intense',       'Games with an extreme, high-energy tone, meant to inspire strong emotions in the player (stress, determination, a sense of urgency, etc.).', NULL);
INSERT INTO moods VALUES (26, 'Light-hearted', 'Games that possess a cheerful, carefree quality.', NULL);
INSERT INTO moods VALUES (30, 'Mysterious',    'Games that invoke curiosity and/or suspense through the investigation of the unknown (a crime, a secret, a strange occurrence, etc.).', NULL);
INSERT INTO moods VALUES (34, 'Peaceful',      'Games that invoke a sense of calm.', NULL);
INSERT INTO moods VALUES (36, 'Romantic',      'Games where a substantial focus is on romantic relationships and the pursuit of love.', NULL);
INSERT INTO moods VALUES (37, 'Sad',           'Games that have a melancholy tone.', NULL);
INSERT INTO moods VALUES (38, 'Sarcastic',     'Games that have a sharp, satirical, caustic tone.', NULL);
INSERT INTO moods VALUES (41, 'Sensual',       'Games that invoke physical or sexual pleasure.', NULL);
INSERT INTO moods VALUES (44, 'Solitary',      'Games in which the player feels isolated or alone.', NULL);
INSERT INTO moods VALUES (50, 'Quirky',        'Games with an unusual or peculiar quality.', NULL);
INSERT INTO moods VALUES (3,  'Apocalyptic',   NULL, 14);
INSERT INTO moods VALUES (4,  'Bleak',         NULL, 14);
INSERT INTO moods VALUES (5,  'Bright',        NULL, 26);
INSERT INTO moods VALUES (6,  'Calm',          NULL, 34);
INSERT INTO moods VALUES (7,  'Carefree',      NULL, 26);
INSERT INTO moods VALUES (8,  'Cheerful',      NULL, 26);
INSERT INTO moods VALUES (11, 'Creative',      NULL, 23);
INSERT INTO moods VALUES (13, 'Cynical',       NULL, 14);
INSERT INTO moods VALUES (15, 'Disturbing',    NULL, 21);
INSERT INTO moods VALUES (16, 'Eerie',         NULL, 21);
INSERT INTO moods VALUES (17, 'Erotic',        NULL, 41);
INSERT INTO moods VALUES (18, 'Funny',         NULL, 22);
INSERT INTO moods VALUES (19, 'Gloomy',        NULL, 14);
INSERT INTO moods VALUES (20, 'Gritty',        NULL, 14);
INSERT INTO moods VALUES (27, 'Macabre',       NULL, 21);
INSERT INTO moods VALUES (28, 'Meditative',    NULL, 34);
INSERT INTO moods VALUES (29, 'Mellow',        NULL, 34);
INSERT INTO moods VALUES (31, 'Offbeat',       NULL, 50);
INSERT INTO moods VALUES (32, 'Optimistic',    NULL, 26);
INSERT INTO moods VALUES (33, 'Paranoid',      NULL, 21);
INSERT INTO moods VALUES (35, 'Relaxed',       NULL, 34);
INSERT INTO moods VALUES (39, 'Satirical',     NULL, 38);
INSERT INTO moods VALUES (40, 'Scary',         NULL, 21);
INSERT INTO moods VALUES (42, 'Sexy',          NULL, 41);
INSERT INTO moods VALUES (43, 'Silly',         NULL, 22);
INSERT INTO moods VALUES (45, 'Somber',        NULL, 14);
INSERT INTO moods VALUES (46, 'Suspenseful',   NULL, 30);
INSERT INTO moods VALUES (47, 'Sweet',         NULL, 12);
INSERT INTO moods VALUES (48, 'Unsettling',    NULL, 21);
INSERT INTO moods VALUES (49, 'Whimsical',     NULL, 50);

-- STORED PROCEDURES ---------------------------------------------------------
-- STORED PROCEDURES ---------------------------------------------------------
-- STORED PROCEDURES ---------------------------------------------------------


DROP PROCEDURE IF EXISTS procInsertGame;
GO
CREATE PROCEDURE procInsertGame 
	@inGameTitleTranscribed    VARCHAR(256),
	@inSummary                 NTEXT,
	@inProgression             INT,
	@inNote                    NTEXT,
	@inUserCreated             INT,
	@inUserUpdated             INT,
	@inPacingTimeManipulation  BIT,
    @out01                     INT OUT
AS
	DECLARE @rightnow DATETIME;
    SET @rightnow = getDate();
    
	INSERT INTO games (
		gameTitleTranscribed,
		summary,
		progression,
		note,
        dateCreated,
		userCreated, 
        dateUpdated,
        userUpdated, 
        pacingTimeManipulation
	) 
    VALUES (
		@inGameTitleTranscribed,
		@inSummary,
		@inProgression,
		@inNote,
        @rightnow,
		@inUserCreated,
        @rightnow,
		@inUserUpdated,
		@inPacingTimeManipulation
	)
;
    
    SELECT @out01 = SCOPE_IDENTITY();
GO