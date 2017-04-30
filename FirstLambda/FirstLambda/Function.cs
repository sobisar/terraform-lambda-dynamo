using Amazon.Lambda.Core;
using Amazon.Lambda.APIGatewayEvents;
using Newtonsoft.Json;

namespace FirstLambda
{
    public class FunctionHandler
    {
        [LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]
        public APIGatewayProxyResponse Handle(APIGatewayProxyRequest request)
        {
            var something = JsonConvert.DeserializeObject<Something>(request.Body);

            var somethingWithRequest = new SomethingWithAllRequest { Something = something, Request = request };

            return new APIGatewayProxyResponse
            {
                Body = JsonConvert.SerializeObject(somethingWithRequest),
                StatusCode = 200,
            };
        }
    }

    public class Something
    {
        public int NumberOfStuff { get; set; }
        public string AreaOfStuff { get; set; }
        
        public string AdditionOfTheTwo { get { return NumberOfStuff + AreaOfStuff; } }
    }

    public class SomethingWithAllRequest
    {
        public Something Something { get; set; }
        public APIGatewayProxyRequest Request { get; set; }
    }
}
