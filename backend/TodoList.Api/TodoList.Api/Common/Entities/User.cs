namespace TodoList.Api.Common.Entities;

public class User : BaseEntity
{
    public string UserName { get; set; }
    public List<TodoListTask> Todos { get; set; }
}
