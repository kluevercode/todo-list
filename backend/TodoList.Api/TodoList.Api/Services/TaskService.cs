using System.Linq.Expressions;
using TodoList.Api.Common.Dtos;
using TodoList.Api.Common.Entities;
using TodoList.Api.Common.Enums;
using TodoList.Api.Common.Interfaces;

namespace TodoList.Api.Services
{
    public class TaskService
    {
        private readonly IGenericRepository<TodoListTask> _repository;

        public TaskService(IGenericRepository<TodoListTask> repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<TaskListDto>> GetTasks(string user)
        {
            var tasks = await _repository.GetFilteredAsync(new Expression<Func<TodoListTask, bool>>[] { (TodoListTask t) => t.User == user }, null, null);
            return tasks.Select(t => new TaskListDto(t.Id, t.Title, t.Description, (int)t.Priority, t.IsDone));
        }

        public async Task<long> CreateTask(TaskCreateDto taskCreateDto, string user)
        {
            if (string.IsNullOrEmpty(taskCreateDto.Title))
            {
                throw new BadHttpRequestException("The title is mandatory.");
            }
            if (string.IsNullOrEmpty(taskCreateDto.Description))
            {
                throw new BadHttpRequestException("The description is mandatory.");
            }
            if (!Enumerable.Range(1, 3).Contains(taskCreateDto.Priority))
            {
                throw new BadHttpRequestException("The priority has to be a number between 1 and 3");
            }

            var task = new TodoListTask
            {
                Title = taskCreateDto.Title,
                Description = taskCreateDto.Description,
                Priority = (TaskPriority)taskCreateDto.Priority,
                User = user,
                IsDone = taskCreateDto.IsDone
            };

            await _repository.InsertAsync(task);
            await _repository.SaveChangesAsync();
            return task.Id;
        }

        public async Task UpdateTask(TaskUpdateDto taskUpdateDto)
        {
            if (string.IsNullOrEmpty(taskUpdateDto.Title))
                throw new BadHttpRequestException("The title is mandatory.");
            if (string.IsNullOrEmpty(taskUpdateDto.Description))
                throw new BadHttpRequestException("The description is mandatory.");
            if (!Enumerable.Range(1, 3).Contains(taskUpdateDto.Priority))
                throw new BadHttpRequestException("The priority has to be a number between 1 and 3");

            TodoListTask? taskToUpdate = await _repository.GetByIdAsync(taskUpdateDto.Id);
            if (taskToUpdate == null)
                throw new BadHttpRequestException("No task found for this id.");

            taskToUpdate.Title = taskUpdateDto.Title;
            taskToUpdate.Description = taskUpdateDto.Description;
            taskToUpdate.Priority = (TaskPriority)taskUpdateDto.Priority;
            taskToUpdate.IsDone = taskUpdateDto.IsDone;

            _repository.Update(taskToUpdate);
            await _repository.SaveChangesAsync();
        }

        public async Task DeleteTask(int id)
        {
            TodoListTask? taskToUpdate = await _repository.GetByIdAsync(id);
            if (taskToUpdate == null)
                throw new BadHttpRequestException("No task found for this id.");

            _repository.Delete(taskToUpdate);
            await _repository.SaveChangesAsync();
        }
    }
}
