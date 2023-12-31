
using WebApi.Models;
using WebApi.Repository;

namespace WebApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddAuthorization();
            builder.Services.AddScoped<PersonaRepository>(); // Agrega esto a tu m�todo Main
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();
           

            app.MapPost("/Persona", (Persona persona, PersonaRepository repo) =>  // Aqu� est� el cambio
            {
                repo.Insertar(persona);
                return Results.Ok("Persona insertada con �xito!");
            })
            .WithName("Insertar")
            .WithOpenApi();

            app.Run();
        }
    }
}