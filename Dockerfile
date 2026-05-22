# phase de build Angular
FROM node:24-slim AS builder

WORKDIR /usr/app

# copie des dépendances
COPY package*.json ./

# installation propre des dépendances
RUN npm ci

# copie du projet
COPY . ./

# build Angular
RUN npm run build

# image finale nginx
FROM nginx:1.27-alpine

# exposition du port nginx
EXPOSE 80

# copie du build Angular
COPY --from=builder /usr/app/dist/angularmaterial/ /usr/share/nginx/html
