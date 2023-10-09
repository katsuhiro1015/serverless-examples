FROM --platform=linux/x86_64 public.ecr.aws/lambda/nodejs:18 as builder

WORKDIR /app
COPY package.json tsconfig.json tsconfig.paths.json ./
COPY src/ ./src/
RUN npm install -g yarn && \
    yarn install && \
    npm run build

FROM --platform=linux/x86_64 public.ecr.aws/lambda/nodejs:18

WORKDIR /var/task
COPY --from=builder /app/dist/ .
COPY --from=builder /app/node_modules/ ./node_modules/

CMD ["index.hello"]
