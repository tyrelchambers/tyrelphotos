FROM node:lts AS build
WORKDIR /app
COPY . .
ARG FONTAWESOME_NPM_AUTH_TOKEN
RUN FONTAWESOME_NPM_AUTH_TOKEN=${FONTAWESOME_NPM_AUTH_TOKEN} npm i
RUN npm run build

FROM httpd:2.4 AS runtime
COPY --from=build /app/dist /usr/local/apache2/htdocs/
EXPOSE 80