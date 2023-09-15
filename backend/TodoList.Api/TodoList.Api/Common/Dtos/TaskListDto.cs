namespace TodoList.Api.Common.Dtos;

public record TaskListDto(int Id, string Title, string Description, int Priority, bool IsDone);
