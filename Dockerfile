# stage 1: builder

FROM golang:1.23

WORKDIR /app

COPY go.mod
COPY main.go
COPY /templates/.

RUN CGO_ENABLED=0 go build -o my-docker-app .

# stage 2: runtime final image

FROM scratch

WORKDIR /app

COPY --from=builder /app/my-docker-app
COPY --from=builder /app/templates/.

EXPOSE 5000

CMD ["./my-docker-app"]