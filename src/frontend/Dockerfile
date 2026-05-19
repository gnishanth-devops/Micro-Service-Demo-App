ARG BUILDPLATFORM=linux/amd64

#Use a base image compatible with the machine that is building the Docker image
FROM --platform=$BUILDPLATFORM golang:1.26.2-alpine AS builder

ARG TARGETOS=linux
ARG TARGETARCH=amd64

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 \
go build -ldflags="-s -w" \
-o /go/bin/frontend .

FROM gcr.io/distroless/static

WORKDIR /src

COPY --from=builder /go/bin/frontend /src/server
COPY ./templates ./templates
COPY ./static ./static

#ENV GOTRACEBACK=single

EXPOSE 8080

ENTRYPOINT ["/src/server"]
