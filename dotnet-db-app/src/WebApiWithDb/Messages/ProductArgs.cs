using WebApiWithDb.Entity;

namespace WebApiWithDb.Messages;

public class ProductArgs
{
    public string Name { get; set; } = string.Empty;

	public decimal Price { get; set; }

    public static implicit operator Product(ProductArgs args) => new()
	{
		Name = args.Name,
		Price = args.Price
	};
}
