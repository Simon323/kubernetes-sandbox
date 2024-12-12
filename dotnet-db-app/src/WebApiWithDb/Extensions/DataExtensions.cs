using Microsoft.EntityFrameworkCore;
using WebApiWithDb.Data;

namespace WebApiWithDb.Extensions;

public static class DataExtensions
{
	public static async Task MigrateDbAsync(this WebApplication app)
	{
		using var scope = app.Services.CreateScope();
		var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
		var pendingMigrations = await dbContext.Database.GetPendingMigrationsAsync();
		if (pendingMigrations.Any())
		{
			Console.WriteLine("Applying migrations:");
			foreach (var migration in pendingMigrations)
				Console.WriteLine($" - {migration}");

			Console.WriteLine("Ensuring database and applying migrations...");
			await dbContext.Database.MigrateAsync();
			Console.WriteLine("Database is ready.");
		}
		else
		{
			Console.WriteLine("No migrations to execute.");
		}
	}
}
