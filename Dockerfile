FROM microsoft/dotnet:2.1-sdk AS build-env
COPY app /app
WORKDIR /app
RUN dotnet tool install -g web

# Build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app app
COPY --from=build-env /root/.dotnet/tools tools
ENV ASPNETCORE_URLS http://*:5000
ENTRYPOINT ["/app/tools/web", "app/app.settings"]
