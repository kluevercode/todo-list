using TodoList.Api.Common.Entities;
using TodoList.Api.Common.Interfaces;
using TodoList.Api.Infrastructure;
using TodoList.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddCors(options =>
    {
        options.AddPolicy(name: "AllowAnyOrigin",
                          builder =>
                          {
                              builder.AllowAnyOrigin()
                                     .AllowAnyMethod()
                                     .AllowAnyHeader();
                          });
    });
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<TodoListDbContext>();
builder.Services.AddScoped<IGenericRepository<TodoListTask>, GenericRepository<TodoListTask>>();
builder.Services.AddScoped<IGenericRepository<User>, GenericRepository<User>>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<TaskService>();

var app = builder.Build();

app.UseCors("AllowAnyOrigin");

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<TodoListDbContext>();
    dbContext.Database.EnsureCreated();
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
