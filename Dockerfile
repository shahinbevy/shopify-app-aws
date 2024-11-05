FROM node:18-alpine

EXPOSE 3000

WORKDIR /app

ENV NODE_ENV=production SHOPIFY_API_KEY=363fdb0803ffd14f77e988d71ea3dac6 SHOPIFY_API_SECRET=d8fbfe84129c0b73298a5e42e5c65c5a SHOPIFY_APP_URL=http://65.0.31.27:3000/ SCOPES=read_products,write_products

COPY package.json package-lock.json* ./

RUN npm ci --omit=dev && npm cache clean --force
# Remove CLI packages since we don't need them in production by default.
# Remove this line if you want to run CLI commands in your container.
RUN npm remove @shopify/cli

COPY . .

RUN npm run build

CMD ["npm", "run", "docker-start"]
