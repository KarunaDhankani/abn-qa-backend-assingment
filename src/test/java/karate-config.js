function fn()
{
    var config = {
        baseURL : 'https://gitlab.com/api/v4',
        access_token : karate.env
    }

    karate.configure('connectTimeout', 50000);
    karate.configure('readTimeout', 50000);

    return config;
}