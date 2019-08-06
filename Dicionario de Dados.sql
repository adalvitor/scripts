select * from sys.tables where name = 'ACBCADLEG'

select * from sys.schemas
select * from sys.types

select * from sys.columns where object_id = 1730157259 

--select * from sys.foreign_key_columns where parent_object_id = 1730157259
--select * from sys.foreign_keys where parent_object_id = 1730157259

--select object_name(parent_object_id),* from sys.key_constraints where parent_object_id = 1730157259 

select * from Sys.extended_properties where major_id = 1730157259

SELECT 
s.name+'.'+t.name as Tabela,
c.name as Coluna,
ep.value as Descricao,
ty.name as TipoDados,
c.max_length as Qtde,
CASE c.is_nullable
	WHEN 0 THEN 'NOT NULL'
	ELSE 'NULL'
	END AS ColunaNULL,
pk.name as PrimaryKey,
fk.name as ForeignKey

FROM sys.tables t
INNER JOIN sys.schemas s				ON t.schema_id = s.schema_id
INNER JOIN sys.columns c				ON t.object_id = c.object_id
INNER JOIN sys.types ty					ON c.user_type_id = ty.user_type_id
LEFT JOIN sys.key_constraints pk		ON pk.parent_object_id = c.object_id AND c.column_id = pk.unique_index_id
LEFT JOIN sys.foreign_key_columns fkc	ON fkc.parent_object_id = c.object_id AND fkc.parent_column_id = c.column_id	
LEFT JOIN sys.foreign_keys fk			ON fk.object_id = fkc.constraint_object_id AND fk.key_index_id = fkc.constraint_column_id
LEFT JOIN Sys.extended_properties ep	ON ep.major_id = c.object_id AND ep.minor_id = c.column_id
WHERE t.object_id = 1730157259 