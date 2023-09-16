using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Mvc;
using TodoList.Api.Common.Dtos;
using TodoList.Api.Services;

namespace TodoList.Api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TaskController : ControllerBase
    {
        private readonly ILogger<TaskController> _logger;
        private readonly TaskService _taskService;

        public TaskController(ILogger<TaskController> logger, TaskService taskService)
        {
            _logger = logger;
            _taskService = taskService;
        }

        [HttpGet]
        public async Task<IEnumerable<TaskListDto>> Get()
        {
            return await _taskService.GetTasks((string)HttpContext.Items["UserId"]);
        }

        [HttpPost]
        public async Task<long> Post(TaskCreateDto taskCreateDto)
        {
            return await _taskService.CreateTask(taskCreateDto, (string)HttpContext.Items["UserId"]);
        }

        [HttpPut]
        public async Task Put(TaskUpdateDto taskUpdateDto)
        {
            await _taskService.UpdateTask(taskUpdateDto);
        }

        [HttpDelete]
        public async Task Delete(int id)
        {
            await _taskService.DeleteTask(id);
        }
    }
}