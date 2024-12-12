# Use the .NET SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy and restore project dependencies
#COPY *.csproj ./
#RUN dotnet restore

# Copy the entire project and build the release
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Use the .NET runtime for the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Set environment variables for runtime
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "WebApiWithDb.dll"]
