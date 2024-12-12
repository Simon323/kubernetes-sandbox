using Microsoft.EntityFrameworkCore;
using WebApiWithDb.Data;
using WebApiWithDb.Entity;
using WebApiWithDb.Messages;

namespace WebApiWithDb.Endpoints;

public static class ProductEndpoints
{
	public static RouteGroupBuilder MapProductEndpoints(this WebApplication app)
	{
		var group = app.MapGroup("/products");

		group.MapGet("", async (AppDbContext db) =>
		{
			return await db.Products.ToListAsync();
		})
			.WithOpenApi()
			.WithName("GetProducts")
			.Produces<List<Product>>(StatusCodes.Status200OK);

		group.MapGet("/{id}", async (AppDbContext db, int id) =>
		{
			return await db.Products.FindAsync(id);
		})
			.WithOpenApi()
			.WithName("GetProductById")
			.Produces<Product>(StatusCodes.Status200OK)
			.Produces(StatusCodes.Status404NotFound);

		group.MapPost("", async (AppDbContext db, ProductArgs args) =>
		{
			Product product = args;
			db.Products.Add(product);
			await db.SaveChangesAsync();
			return Results.Created($"/products/{product.Id}", product);
		})
			.WithOpenApi()
			.WithName("AddProduct")
			.Produces<Product>(StatusCodes.Status201Created)
			.Produces(StatusCodes.Status400BadRequest);

		group.MapPut("/{id}", async (AppDbContext db, int id, ProductArgs product) =>
		{
			db.Entry(product).State = EntityState.Modified;
			await db.SaveChangesAsync();
			return Results.NoContent();
		})
			.WithOpenApi()
			.WithName("UpdateProduct")
			.Accepts<Product>("The product to update")
			.Produces(StatusCodes.Status204NoContent)
			.Produces(StatusCodes.Status400BadRequest)
			.Produces(StatusCodes.Status404NotFound);

		return group;
	}

}
