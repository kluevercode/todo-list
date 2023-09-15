using TodoList.Api.Common.Enums;

namespace TodoList.Api.Common.Entities;

//Name choice is due to naming conflicts with framework class Task
public class TodoListTask : BaseEntity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public TaskPriority Priority { get; set; }
    public User User { get; set; }
    public bool IsDone { get; set; }
}
