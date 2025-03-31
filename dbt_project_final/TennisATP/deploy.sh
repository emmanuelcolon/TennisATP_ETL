#!/bin/bash

# Ejecutar modelos en staging
dbt run --target blue
if [ $? -ne 0 ]; then
    echo "Error en dbt run. Abortando..."
    exit 1
fi

# Ejecutar tests de calidad
dbt test --target blue
if [ $? -ne 0 ]; then
    echo "Fallo en los tests. Abortando publicación..."
    exit 1
fi

# Publicar a producción
dbt run-operation publish --target green
if [ $? -ne 0 ]; then
    echo "Error al publicar en producción."
    exit 1
fi

echo "Proceso completado exitosamente."