# Usar una imagen base de Python 3.6 con soporte extendido para desarrollo
FROM python:3.6-buster

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar gcc y herramientas de compilación necesarias
RUN apt-get update && apt-get install -y gcc g++ make build-essential \
    libjpeg-dev libpng-dev libtiff-dev

# Actualiza pip a la última versión compatible con Python 3.6
RUN pip install --upgrade pip

# Copia los requisitos
COPY requirements.txt .

# Instala las dependencias especificadas en requirements.txt, exceptuando gluonncv
RUN pip install --no-cache-dir -r requirements.txt

# Instala gluonncv directamente desde GitHub
RUN pip install git+https://github.com/dmlc/gluon-cv.git

# Copia todos los archivos de la aplicación al contenedor
COPY . .

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
