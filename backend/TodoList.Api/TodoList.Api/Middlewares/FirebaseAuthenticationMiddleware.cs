using System.Net;
using FirebaseAdmin.Auth;

public class FirebaseAuthenticationMiddleware
{
    private readonly RequestDelegate _next;

    public FirebaseAuthenticationMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var firebaseToken = context.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");

        if (string.IsNullOrEmpty(firebaseToken))
        {
            context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            await context.Response.WriteAsync("Unauthorized");
            return;
        }

        try
        {
            var decodedToken = await FirebaseAuth.DefaultInstance.VerifyIdTokenAsync(firebaseToken);
            var uid = decodedToken.Uid;
            // Store the UID or other claims as needed for further processing in your application.
            context.Items["UserId"] = uid; // for instance
        }
        catch (FirebaseAuthException)
        {
            context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            await context.Response.WriteAsync("Unauthorized");
            return;
        }

        // Call the next delegate/middleware in the pipeline
        await _next(context);
    }
}
