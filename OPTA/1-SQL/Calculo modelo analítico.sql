INSERT INTO dbo.FAC_JUGADOREVENTO (
    playerId,
    playerName,
    teamName,
    partidos_jugados,
    total_minutos_jugados,
    porcentaje_medio_posesion,
    total_short_pass,
    ShortPass_per90,
    ShortPass_per_possession,
    total_key_passes,
    KeyPasses_per90,
    KeyPasses_per_possession,
    total_progress_passes,
    ProgressPasses_per90,
    ProgressPasses_per_possession,
    total_touches_rival,
    TouchesRivalArea_per90,
    TouchesRivalArea_per_possession,
    avg_xG,
    total_touches_own,
    TouchesOwnArea_per90,
    TouchesOwnArea_per_possession,
    avg_xT,
    total_dribble_success,
    DribbleSuccess_per90,
    DribbleSuccess_per_possession,
    total_dribble_fail,
    DribbleFail_per90,
    DribbleFail_per_possession,
    total_def_action_success,
    DefActionSuccess_per90,
    DefActionSuccess_per_possession,
    total_def_action_fail,
    DefActionFail_per90,
    DefActionFail_per_possession,
    total_entries_success,
    EntriesSuccess_per90,
    EntriesSuccess_per_possession,
    total_aerial_success,
    AerialSuccess_per90,
    AerialSuccess_per_possession,
    total_aerial_fail,
    AerialFail_per90,
    AerialFail_per_possession,
    total_duels_success,
    DuelsSuccess_per90,
    DuelsSuccess_per_possession,
    total_duels_fail,
    DuelsFail_per90,
    DuelsFail_per_possession,
    total_clearance,
    Clearance_per90,
    Clearance_per_possession,
    total_def_to_trans,
    DefensiveToTransition_per90,
    DefensiveToTransition_per_possession,
    total_high_turnover,
    HighTurnover_per90,
    HighTurnover_per_possession,
    total_high_turnover_shot,
    HighTurnoverShot_per90,
    HighTurnoverShot_per_possession
)
SELECT  
    E.playerId,
    J.playerName,
    J.teamName, 
    COUNT(DISTINCT matchId) AS partidos_jugados,
    J.total_minutos_jugados,
    J.porcentaje_medio_posesion,

    -- ShortPass
    SUM(CAST(E.ShortPass AS FLOAT)) AS total_short_pass,
    ROUND(SUM(CAST(E.ShortPass AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS ShortPass_per90,
    ROUND(SUM(CAST(E.ShortPass AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS ShortPass_per_possession,

    -- KeyPasses
    SUM(CAST(E.value_KeyPass AS FLOAT)) AS total_key_passes,
    ROUND(SUM(CAST(E.value_KeyPass AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS KeyPasses_per90,
    ROUND(SUM(CAST(E.value_KeyPass AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS KeyPasses_per_possession,

    -- ProgressPasses
    SUM(CAST(E.ProgressPasses AS FLOAT)) AS total_progress_passes,
    ROUND(SUM(CAST(E.ProgressPasses AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS ProgressPasses_per90,
    ROUND(SUM(CAST(E.ProgressPasses AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS ProgressPasses_per_possession,

    -- TouchesRivalArea
     SUM(CAST(E.TouchesRivalArea AS FLOAT)) AS total_touches_rival,
    ROUND(SUM(CAST(E.TouchesRivalArea AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS TouchesRivalArea_per90,
    ROUND(SUM(CAST(E.TouchesRivalArea AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS TouchesRivalArea_per_possession,

    -- xG
    AVG(CAST(E.xG AS FLOAT)) AS avg_xG,

    -- TouchesOwnArea
    SUM(CAST(E.TouchesOwnArea AS FLOAT)) AS total_touches_own,
    ROUND(SUM(CAST(E.TouchesOwnArea AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS TouchesOwnArea_per90,
    ROUND(SUM(CAST(E.TouchesOwnArea AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS TouchesOwnArea_per_possession,

    -- xT_value
    AVG(CAST(E.xT_value AS FLOAT)) AS avg_xT,

    -- Dribble_Successful
    SUM(CAST(E.Dribble_Successful AS FLOAT)) AS total_dribble_success,
    ROUND(SUM(CAST(E.Dribble_Successful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DribbleSuccess_per90,
    ROUND(SUM(CAST(E.Dribble_Successful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DribbleSuccess_per_possession,

    -- Dribble_Unsuccessful
    SUM(CAST(E.Dribble_Unsuccessful AS FLOAT)) AS total_dribble_fail, 
    ROUND(SUM(CAST(E.Dribble_Unsuccessful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DribbleFail_per90,
    ROUND(SUM(CAST(E.Dribble_Unsuccessful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DribbleFail_per_possession,

    -- DefensiveAction_Successful
    SUM(CAST(E.DefensiveAction_Successful AS FLOAT)) AS total_def_action_success,
    ROUND(SUM(CAST(E.DefensiveAction_Successful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DefActionSuccess_per90,
    ROUND(SUM(CAST(E.DefensiveAction_Successful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DefActionSuccess_per_possession,

    -- DefensiveAction_Unsuccessful
    SUM(CAST(E.DefensiveAction_Unsuccessful AS FLOAT)) AS total_def_action_fail,
    ROUND(SUM(CAST(E.DefensiveAction_Unsuccessful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DefActionFail_per90,
    ROUND(SUM(CAST(E.DefensiveAction_Unsuccessful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DefActionFail_per_possession,

    -- Entries_Successful
    SUM(CAST(E.Entries_Successful AS FLOAT)) AS total_entries_success,
    (ROUND(SUM(CAST(E.Entries_Successful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2))/ 100 AS EntriesSuccess_per90,
    (ROUND(SUM(CAST(E.Entries_Successful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2))/ 100 AS EntriesSuccess_per_possession,

    -- Aerial_Successful
    SUM(CAST(E.Aerial_Successful AS FLOAT)) AS total_aerial_success,
    ROUND(SUM(CAST(E.Aerial_Successful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS AerialSuccess_per90,
    ROUND(SUM(CAST(E.Aerial_Successful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS AerialSuccess_per_possession,

    -- Aerial_Unsuccessful
    SUM(CAST(E.Aerial_Unsuccessful AS FLOAT)) AS total_aerial_fail,
    ROUND(SUM(CAST(E.Aerial_Unsuccessful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS AerialFail_per90,
    ROUND(SUM(CAST(E.Aerial_Unsuccessful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS AerialFail_per_possession,

    -- Duels_Successful
    SUM(CAST(E.Duels_Successful AS FLOAT)) AS total_duels_success,
    ROUND(SUM(CAST(E.Duels_Successful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DuelsSuccess_per90,
    ROUND(SUM(CAST(E.Duels_Successful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DuelsSuccess_per_possession,

    -- Duels_Unsuccessful
    SUM(CAST(E.Duels_Unsuccessful AS FLOAT)) AS total_duels_fail,
    ROUND(SUM(CAST(E.Duels_Unsuccessful AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DuelsFail_per90,
    ROUND(SUM(CAST(E.Duels_Unsuccessful AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DuelsFail_per_possession,

    -- Clearance
    SUM(CAST(E.Clearance AS FLOAT)) AS total_clearance,
    ROUND(SUM(CAST(E.Clearance AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS Clearance_per90,
    ROUND(SUM(CAST(E.Clearance AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS Clearance_per_possession,

    -- DefensiveToTransition
    SUM(CAST(E.DefensiveToTransition AS FLOAT)) AS total_def_to_trans,
    ROUND(SUM(CAST(E.DefensiveToTransition AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS DefensiveToTransition_per90,
    ROUND(SUM(CAST(E.DefensiveToTransition AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS DefensiveToTransition_per_possession,

    -- HighTurnover
    SUM(CAST(E.HighTurnover AS FLOAT)) AS total_high_turnover,
    ROUND(SUM(CAST(E.HighTurnover AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS HighTurnover_per90,
    ROUND(SUM(CAST(E.HighTurnover AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS HighTurnover_per_possession,

    -- HighTurnoverShot
    SUM(CAST(E.HighTurnoverShot AS FLOAT)) AS total_high_turnover_shot,
    ROUND(SUM(CAST(E.HighTurnoverShot AS FLOAT)) * 90.0 / NULLIF(J.total_minutos_jugados, 0), 2) AS HighTurnoverShot_per90,
    ROUND(SUM(CAST(E.HighTurnoverShot AS FLOAT)) * 100.0 / NULLIF(J.porcentaje_medio_posesion, 0), 2) AS HighTurnoverShot_per_possession

FROM 
    dbo.FAC_EVENT AS E
LEFT JOIN dbo.FAC_JUGADOR AS J ON E.playerId = J.playerId
WHERE 
    E.playerId IS NOT NULL
GROUP BY 
    E.playerId, 
    J.playerName, 
    J.teamName, 
    J.total_minutos_jugados, 
    J.porcentaje_medio_posesion
ORDER BY 
    J.playerName;
