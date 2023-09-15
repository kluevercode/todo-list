namespace TodoList.Api.Common.Dtos;

public record TaskUpdateDto(int Id, string Title, string Description, int Priority);
