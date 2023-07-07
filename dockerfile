FROM registry.access.redhat.com/ubi8/dotnet-60:6.0-32.20230511125009 as builder
WORKDIR /opt/app-root/src
COPY --chown=1001 . .
RUN dotnet new webapi -minimal -o dotnet-hello -f net6.0

FROM registry.access.redhat.com/ubi8/dotnet-60:6.0-32.20230511125009
EXPOSE 5000
COPY --from=builder /opt/app-root/src/bin /opt/app-root/src/bin
WORKDIR /opt/app-root/src/bin/Release/net6.0/publish
CMD ["dotnet", "run", "--urls", "http://localhost:5000"]
