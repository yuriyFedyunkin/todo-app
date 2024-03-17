FROM golang:1.22.1-alpine

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum /todo-app/
COPY . /todo-app/

WORKDIR /todo-app

# install psql
RUN apk --update add postgresql-client

# make docker-entrypoint.sh executable
RUN chmod +x docker-entrypoint.sh

RUN go mod download && go mod verify
RUN go build -o todo-app ./cmd/main.go

CMD ["./todo-app"]