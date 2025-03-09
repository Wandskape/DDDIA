import geojson
import pymssql
import sqlalchemy
from sqlalchemy import create_engine, Table, Column, Integer, String, Float, MetaData

with open('brown.geojson', encoding='utf-8') as f:
    data = geojson.load(f)

engine = create_engine('mssql+pymssql://sa:MicrosoftPass1234%40@localhost:1433/QTEST1')

metadata = MetaData()

geojson_data = Table('geojson_data', metadata,
                     Column('id', Integer, primary_key=True),
                     Column('osm_id', String(50)),
                     Column('code', Integer),
                     Column('fclass', String(50)),
                     Column('name', String(100)),
                     Column('latitude', Float),
                     Column('longitude', Float))

metadata.create_all(engine)

with engine.connect() as conn:
    trans = conn.begin()
    try:
        for feature in data['features']:
            properties = feature['properties']
            coordinates = feature['geometry']['coordinates']
            conn.execute(geojson_data.insert().values(
                osm_id=properties['osm_id'],
                code=properties['code'],
                fclass=properties['fclass'],
                name=properties['name'],
                latitude=coordinates[1],
                longitude=coordinates[0]
            ))
        trans.commit()
        print("Данные успешно загружены в MSSQL!")
    except Exception as e:
        trans.rollback()
        print(f"Ошибка при вставке данных: {e}")
