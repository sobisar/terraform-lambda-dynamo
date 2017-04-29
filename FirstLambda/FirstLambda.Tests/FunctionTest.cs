using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Xunit;
using Amazon.Lambda.Core;
using Amazon.Lambda.TestUtilities;

using FirstLambda;

namespace FirstLambda.Tests
{
    public class FunctionTest
    {
        [Fact]
        public void TestToUpperFunction()
        {

            // Invoke the lambda function and confirm the string was upper cased.
            var function = new FunctionHandler();
            var context = new TestLambdaContext();
            var upperCase = function.Handle("hello world", context);

            Assert.Equal("HELLO WORLD", upperCase);
        }
    }
}
