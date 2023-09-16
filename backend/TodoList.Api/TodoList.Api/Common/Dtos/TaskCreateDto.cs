namespace TodoList.Api.Common.Dtos;

public record TaskCreateDto(string Title, string Description, int Priority, bool IsDone);
