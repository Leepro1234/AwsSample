FROM node:16.20 AS build

#/usr/src로 이동
WORKDIR /app

# package 복사
COPY /my-app/package*.json /my-app/yarn.lock ./
RUN yarn install
#파일전체복사
COPY /my-app .
RUN yarn build

FROM node:16.20  AS runner
WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/yarn.lock ./
COPY --from=build /app/public ./public
COPY --from=build  /app/.next/standalone ./
COPY --from=build  /app/.next/static ./.next/static

# 운영환경 Install
RUN yarn install --production 

EXPOSE 7878
CMD ["yarn", "start"]