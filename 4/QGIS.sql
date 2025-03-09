use QTEST1
go

CREATE TABLE geojson_data (
    id INT IDENTITY(1,1) PRIMARY KEY,
    osm_id VARCHAR(50),
    code INT,
    fclass VARCHAR(50),
    name VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT
);

select * from geojson_data;
SELECT COUNT(*) FROM geojson_data;

--6 point

--7

ALTER TABLE geojson_data
ADD geom GEOMETRY;

UPDATE geojson_data
SET geom = GEOMETRY::Point(longitude, latitude, 4326)
WHERE geom IS NULL;

--8 geojson_data
--9
SELECT osm_id, geom.STAsText() AS WKT
FROM geojson_data;
--10
SELECT a.osm_id, b.osm_id
FROM geojson_data a, geojson_data b
WHERE a.geom.STIntersects(b.geom) = 1;

SELECT osm_id, geom.STPointN(1).ToString() AS Vertex
FROM geojson_data;

SELECT osm_id, geom.STArea() AS Area
FROM geojson_data
WHERE geom.STGeometryType() = 'Polygon';

--11
INSERT INTO geojson_data (osm_id, geom) VALUES (NEWID(), GEOMETRY::Point(-64.8974708, -62.8715021, 4326));

INSERT INTO geojson_data (osm_id, geom) VALUES (NEWID(), GEOMETRY::STGeomFromText('LINESTRING(-64.8974708 -62.8715021, -62.95 -60.55)', 4326));

INSERT INTO geojson_data (osm_id, geom) VALUES (NEWID(), GEOMETRY::STGeomFromText('POLYGON((-64.8974708 -62.8715021, -62.95 -60.55, -60.55 -62.95, -64.8974708 -62.8715021))', 4326));

--12
SELECT a.osm_id, b.osm_id
FROM geojson_data a, geojson_data b
WHERE a.geom.STIntersects(b.geom) = 1;

--13
CREATE SPATIAL INDEX SIndx_Geom ON geojson_data(geom)
USING GEOMETRY_GRID
WITH (
    BOUNDING_BOX = (-180, -90, 180, 90)
);

--14
CREATE PROCEDURE FindSpatialObject (@latitude FLOAT, @longitude FLOAT)
AS
BEGIN
    DECLARE @point GEOMETRY;
    SET @point = GEOMETRY::Point(@longitude, @latitude, 4326);

    SELECT osm_id, name, geom.STAsText() AS WKT
    FROM geojson_data
    WHERE geom.STContains(@point) = 1;
END;

EXEC FindSpatialObject @latitude = -62.8715021, @longitude = -64.8974708;


