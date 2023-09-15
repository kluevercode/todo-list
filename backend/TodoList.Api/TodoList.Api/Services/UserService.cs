using TodoList.Api.Common.Entities;
using TodoList.Api.Common.Interfaces;

namespace TodoList.Api.Services;

public class UserService : IUserService
{
    private readonly IGenericRepository<User> _repository;

    public UserService(IGenericRepository<User> repository)
    {
        _repository = repository;
    }

    public async Task<User> GetLoggedInUser()
    {
        var user = await _repository.GetByIdAsync(1);
        return user;
    }
}
