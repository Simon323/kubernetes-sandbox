using System;
using MyWebApi.Models;

namespace MyWebApi.Endpoints;

public static class WeatherEndpoints
{
  private static readonly string[] Summaries = new[]
  {
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
  };

  public static RouteGroupBuilder MapWeatherEndpoints(this WebApplication app)
  {
    var group = app.MapGroup("/");

    group.MapGet("/weatherforecast", () =>
    {
      var forecast = Enumerable.Range(1, 5).Select(index =>
          new WeatherForecast
          (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            Summaries[Random.Shared.Next(Summaries.Length)]
          ))
          .ToArray();
      return forecast;
    });

    return group;
  }
}
