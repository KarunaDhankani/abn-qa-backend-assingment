function fn()
{
    var config = {
        baseURL : 'https://gitlab.com/api/v4',
        access_token : karate.env,
        invalid_access_token : 'invalidToken11223344'
    }

    karate.configure('connectTimeout', 50000);
    karate.configure('readTimeout', 50000);

    return config;
}