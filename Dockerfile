# Static go build taken from: https://gist.github.com/PurpleBooth/ec81bad0a7b56ac767e0da09840f835a
FROM golang:1.12 AS build
WORKDIR /build
RUN wget https://github.com/errata-ai/vale/archive/v1.7.1.tar.gz \
 && tar xf *.tar.gz \
 && cd vale-* \
 && go build -ldflags "-linkmode external -extldflags -static" -a main.go \
 && mv ./main /build/vale

FROM scratch
WORKDIR /repo
COPY --from=build /build/vale /vale
ENTRYPOINT ["/vale"]
CMD ["--help"]
