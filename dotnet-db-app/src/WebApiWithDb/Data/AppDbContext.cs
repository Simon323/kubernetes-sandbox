using Microsoft.EntityFrameworkCore;
using WebApiWithDb.Entity;

namespace WebApiWithDb.Data;

public class AppDbContext : DbContext
{
	public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

	public DbSet<Product> Products { get; set; }
}
