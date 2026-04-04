namespace IdentityService.Repositories
{
    public class ResultRepository<T>
    {
        public bool Success { get; set; }
        public string message { get; set; }
        public T Data { get; set; }
        public static ResultRepository<T> Ok(T data, string message = null)
            => new ResultRepository<T> { Success = true, Data = data, message = message };
        public static ResultRepository<T> Fail(string message)
            => new ResultRepository<T> { Success = false, message = message };
    }
}
