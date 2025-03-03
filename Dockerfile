FROM mhart/alpine-node:14 as builder

WORKDIR /tmp
COPY . .

RUN npx prettier --check . '!**/*.min.{css,js}'
RUN yarn && yarn build

###
# production image
FROM nginx:stable-alpine
COPY --from=builder /tmp/build /usr/share/nginx/html
