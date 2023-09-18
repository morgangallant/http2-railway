FROM golang:bullseye AS build
WORKDIR /mg
ADD . .
RUN go build -o http2 .

FROM golang:bullseye
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /mg/http2 /usr/bin/program
ENTRYPOINT ["/usr/bin/program"]