--verificar se as estatisticas estao desatualizadas
exec sp_updatestats

--todas as estastisticas serao recomputadas
update statistics Administracao.Chapa with FULLSCAN

--indices que estao faltando no database
SELECT avg_total_user_cost, avg_user_impact,  user_seeks, user_scans,
	   ID.equality_columns, ID.inequality_columns, ID.included_columns, ID.statement
FROM sys.dm_db_missing_index_group_stats GS
LEFT OUTER JOIN sys.dm_db_missing_index_groups IG On
					(IG.index_group_handle = GS.group_handle)
LEFT OUTER JOIN sys.dm_db_missing_index_details ID On
					(ID.index_handle = IG.index_handle)
ORDER BY avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)
DESC

--criar o indice include
CREATE INDEX IX_Include_ID
ON [Administracao].[NotDestaque] (equality_columns)
INCLUDE (included_columns);

CREATE INDEX IX_IC_ContatoForma_IdPessoa
ON [Pessoa].[Pessoa_ContatoForma] ([IdContatoForma])
INCLUDE ([IdPessoa]);

CREATE INDEX IX_IC_ContatoTipoGrupo_Excluido_IdPEssoa_IdContatoTipoGrupo
ON [Pessoa].[Pessoa_ContatoTipoGrupo] ([Excluido])
INCLUDE ([IdPessoa], [IdContatoTipoGrupo]);