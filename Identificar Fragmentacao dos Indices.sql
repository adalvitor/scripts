SELECT
    OBJECT_NAME(B.object_id) AS TableName,
    B.name AS IndexName,
    A.index_type_desc AS IndexType,
    A.avg_fragmentation_in_percent
FROM
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED')	A
    INNER JOIN sys.indexes							B	WITH(NOLOCK) ON B.object_id = A.object_id AND B.index_id = A.index_id
WHERE
    A.avg_fragmentation_in_percent > 30
    AND OBJECT_NAME(B.object_id) NOT LIKE '[_]%'
    AND A.index_type_desc != 'HEAP'
ORDER BY
    A.avg_fragmentation_in_percent DESC