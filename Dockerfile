FROM golang:alpine as builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fullcycle .

FROM scratch
COPY --from=builder /app/fullcycle .
CMD ["./fullcycle"]
