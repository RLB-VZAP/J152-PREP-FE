/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.vzap.helpdeskprofe.restclients;

import com.vzap.helpdeskprofe.model.user.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.Response;
import tools.jackson.databind.ObjectMapper;


/**
 *
 * @author rossb
 */
@ApplicationScoped
public class AuthRestClient {
    private final String API_URL = "http://localhost:8080/J152-PREP-BE/api";
    ObjectMapper mapper = new ObjectMapper();
    public User register(User user){
        Client client = ClientBuilder.newClient();
        WebTarget target = client.target(API_URL + "/auth/register");
        
        Response response = target.request().post(Entity.json(user));
        
        switch(response.getStatusInfo().toEnum()){
            case OK : {
                User created = mapper.readValue(response.readEntity(String.class), User.class);
                return created;
            }
            case FOUND, BAD_REQUEST : {
                throw new IllegalArgumentException(response.readEntity(String.class));
            }
            case EXPECTATION_FAILED : {
                throw new RuntimeException();
            }
            default : {
                throw new IllegalArgumentException("Something went wrong, please try again later");
            }
        }
        
    }
}
