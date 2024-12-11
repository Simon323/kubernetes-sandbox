# Use .NET SDK for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files
# COPY *.csproj ./

# Copy the rest of the application files
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Use .NET runtime to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Set environment variable to ensure the app listens on port 80
ENV ASPNETCORE_URLS=http://+:80

# Expose port 80
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "MyWebApi.dll"]
