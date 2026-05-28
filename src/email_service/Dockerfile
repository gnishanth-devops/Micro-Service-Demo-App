# syntax=docker/dockerfile:1

ARG BUILDPLATFORM=linux/amd64

FROM --platform=$BUILDPLATFORM python:3.14.4-alpine@sha256:dd4d2bd5b53d9b25a51da13addf2be586beebd5387e289e798e4083d94ca837a AS base

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

FROM base AS builder

WORKDIR /build

RUN apk add --no-cache \
    g++ \
    linux-headers

COPY requirements.txt .
RUN pip install \
    --no-cache-dir \
    --prefix=/install \
    -r requirements.txt

########################################################
# Runtime
########################################################

FROM base

WORKDIR /email_server

ENV ENABLE_PROFILER=1
RUN apk add --no-cache \
    libstdc++ \
    netcat-openbsd

COPY --from=builder /install /usr/local
COPY . .
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser
EXPOSE 8080
ENTRYPOINT ["python", "email_server.py"]
