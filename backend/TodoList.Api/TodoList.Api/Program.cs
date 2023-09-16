using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using TodoList.Api.Common.Entities;
using TodoList.Api.Common.Interfaces;
using TodoList.Api.Infrastructure;
using TodoList.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
FirebaseApp.Create(new AppOptions
{
    Credential = GoogleCredential.FromFile("todo-list-soner-firebase-adminsdk-rosge-d6be1079ed.json"),
});

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<TodoListDbContext>();
builder.Services.AddScoped<IGenericRepository<TodoListTask>, GenericRepository<TodoListTask>>();
builder.Services.AddScoped<TaskService>();

var app = builder.Build();

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
app.UseMiddleware<FirebaseAuthenticationMiddleware>();
app.UseAuthorization();

app.MapControllers();

app.Run();
