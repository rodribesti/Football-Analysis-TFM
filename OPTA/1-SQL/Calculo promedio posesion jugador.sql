;WITH eventos_con_posesion AS (
    SELECT 
        matchId,
        teamId,
        segundos,
        COALESCE(
            LEAD(segundos) OVER (PARTITION BY matchId ORDER BY segundos) - segundos,
            0
        ) AS tiempo_posesion
    FROM FAC_EVENT
),
posesion_total_equipo AS (
    SELECT 
        matchId,
        teamId,
        SUM(tiempo_posesion) AS total_posesion_equipo
    FROM eventos_con_posesion
    GROUP BY matchId, teamId
),
posesion_total_partido AS (
    SELECT 
        matchId,
        SUM(total_posesion_equipo) AS total_posesion_partido
    FROM posesion_total_equipo
    GROUP BY matchId
),
porcentaje_equipo AS (
    SELECT 
        e.matchId,
        e.teamId,
        e.total_posesion_equipo,
        p.total_posesion_partido,
        ROUND(100.0 * e.total_posesion_equipo / NULLIF(p.total_posesion_partido, 0), 2) AS porcentaje_posesion_equipo
    FROM posesion_total_equipo e
    JOIN posesion_total_partido p ON e.matchId = p.matchId
),
jugadores_partido AS (
    SELECT DISTINCT
        matchId,
        teamId,
        playerId
    FROM FAC_EVENT
    WHERE playerId IS NOT NULL
),
posesion_por_partido AS (
    SELECT 
        j.matchId,
        j.teamId,
        j.playerId,
        p.porcentaje_posesion_equipo
    FROM jugadores_partido j
    JOIN porcentaje_equipo p 
      ON j.matchId = p.matchId AND j.teamId = p.teamId
),
promedio_por_jugador AS (
    SELECT 
        playerId,
        ROUND(AVG(porcentaje_posesion_equipo), 2) AS porcentaje_medio_posesion
    FROM posesion_por_partido
    GROUP BY playerId
)
UPDATE f
SET porcentaje_medio_posesion = p.porcentaje_medio_posesion
FROM FAC_JUGADOR f
JOIN promedio_por_jugador p ON f.playerId = p.playerId;



