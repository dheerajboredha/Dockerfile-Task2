FROM node:lts AS build
ARG TASK=dev
ADD sample-react /dhee
WORKDIR /dhee
RUN npm install && \
    npm run build


FROM nginx
ENV workspace=dev
COPY --from=build /dhee/build /usr/share/nginx/html
RUN useradd -m dheeraj
EXPOSE 80
ENTRYPOINT ["nginx" ] 
CMD ["-g", "daemon off;"]
