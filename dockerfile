FROM node:16.20 AS build

#/usr/src로 이동
WORKDIR /app

# package 복사
COPY /my-app/package*.json /my-app/yarn.lock ./
RUN yarn install
#파일전체복사
COPY /my-app/ .

RUN yarn build
RUN ls -l 
RUN echo 'hi3'


FROM node:16.20  AS runner
WORKDIR /app

COPY --from=build /app/ ./

RUN ls -l
RUN echo 'hi2'

# 운영환경 Install
RUN yarn install --production 


EXPOSE 7878
CMD ["yarn", "start"]