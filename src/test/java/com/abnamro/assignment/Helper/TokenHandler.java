package com.abnamro.assignment.Helper;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse.BodyHandlers;
import com.abnamro.assignment.Model.AuthenticationRequestModel;
import com.abnamro.assignment.Model.AuthenticationResponseModel;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class TokenHandler {
    public static String GetOAuthTokenBasedOnCredentials(){

        try {
                    //Create Request
         URI uri = new URI(Config.getPropertyValue("authUrl"));

         AuthenticationRequestModel authenticationRequestModel = new AuthenticationRequestModel();
         authenticationRequestModel.setPassword(Config.getPropertyValue("password"));
         authenticationRequestModel.setUsername(Config.getPropertyValue("username"));
         authenticationRequestModel.setGrant_type(Config.getPropertyValue("grant_type"));

         ObjectMapper mapper = new ObjectMapper();
         String jsonRequest = mapper.writeValueAsString(authenticationRequestModel);
         System.out.print(jsonRequest);


        //Prepare Client and send Http post request
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder(uri).POST(BodyPublishers.ofString(jsonRequest)).header("Content-type", "application/json").build();
        HttpResponse<String> response = httpClient.send(httpRequest, BodyHandlers.ofString());

        AuthenticationResponseModel authenticationResponseModel= mapper.readValue(response.body(), AuthenticationResponseModel.class);
         return authenticationResponseModel.getAccess_token();

        } catch (URISyntaxException exception) {
            exception.printStackTrace();
            throw new TokenHandlerException();
        }
        catch(JsonProcessingException exception){
            exception.printStackTrace();
            throw new TokenHandlerException();
        }
        catch(IOException exception){
            exception.printStackTrace();
            throw new TokenHandlerException();
        }
        catch(InterruptedException exception){
            exception.printStackTrace();
            throw new TokenHandlerException();
        }
    }
}

class TokenHandlerException extends Error {

}