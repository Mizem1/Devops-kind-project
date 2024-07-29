FROM node:22

WORKDIR /usr/src/app

# Definir variables de entorno
ENV PORT=3000
ENV DATABASE_PATH=database/db.sqlite

# Copia los archivos package.json y package-lock.json
COPY package*.json ./

# Instala las herramientas necesarias y las dependencias de la aplicación
RUN apt-get update && \
    apt-get install -y --no-install-recommends make gcc g++ python3 && \
    npm install && \
    npm rebuild bcrypt --build-from-source && \
    apt-get purge -y make gcc g++ python3 && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Copia el resto del código de la aplicación
COPY . .

# Crear el directorio de la base de datos y establecer permisos
RUN mkdir -p database && \
    touch database/db.sqlite && \
    chmod 777 database/db.sqlite

# Construye la aplicación
RUN npm run build

# Exponer el puerto en el que la aplicación estará escuchando
EXPOSE 3000

# Definir el comando de inicio de la aplicación
CMD ["npm", "run", "start:prod"]
