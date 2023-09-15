using TodoList.Api.Common.Entities;

namespace TodoList.Api.Common.Interfaces;

public interface IUserService
{
    public Task<User> GetLoggedInUser();
}
