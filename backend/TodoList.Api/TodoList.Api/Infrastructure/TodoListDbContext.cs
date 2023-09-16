using Microsoft.EntityFrameworkCore;
using TodoList.Api.Common.Entities;

namespace TodoList.Api.Infrastructure;

public class TodoListDbContext : DbContext
{
    public DbSet<TodoListTask> Todos { get; set; }

    public TodoListDbContext(DbContextOptions<TodoListDbContext> options)
        : base(options)
    {
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlite("Filename=TodoList.db");
        base.OnConfiguring(optionsBuilder);
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.Entity<TodoListTask>().HasKey(e => e.Id);
        base.OnModelCreating(builder);
    }
}
