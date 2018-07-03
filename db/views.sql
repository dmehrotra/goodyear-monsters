CREATE VIEW data AS
	select * from cevent 
		INNER join vehicle on (cevent."ST_CASE" = vehicle."ST_CASE") 
		INNER join accident on (vehicle."ST_CASE" = accident."ST_CASE")
		INNER join factor on (accident."ST_CASE" = factor."ST_CASE");