using System;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;

namespace MyWebApi.Endpoints;

public static class TokenEndpoints
{
  public static RouteGroupBuilder MapTokenEndpoints(this WebApplication app)
  {
    var group = app.MapGroup("/");

    group.MapGet("/token", (IConfiguration _configuration) =>
    {
      // Get secret key
      var secretKey = _configuration.GetValue<string>("JwtSettings:SecretKey");
      var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));

      // Create token
      var claims = new[]
      {
            new Claim(JwtRegisteredClaimNames.Sub, "user_id"),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

      var tokenDescriptor = new SecurityTokenDescriptor
      {
        Subject = new ClaimsIdentity(claims),
        Expires = DateTime.UtcNow.AddHours(1),
        SigningCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
      };

      var tokenHandler = new JwtSecurityTokenHandler();
      var token = tokenHandler.CreateToken(tokenDescriptor);

      return Results.Ok(new { Token = tokenHandler.WriteToken(token) });
    });

    group.MapGet("/env", (IConfiguration _configuration) =>
    {
      // Get secret key
      var appsettingsKey = _configuration.GetValue<string>("JwtSettings:SecretKey");
      var envKey = Environment.GetEnvironmentVariable("EnvKey") ?? "EnvKey not found";

      return Results.Ok(new { AppsettingsKey = appsettingsKey, EnvKey = envKey });
    });

    return group;
  }
}
