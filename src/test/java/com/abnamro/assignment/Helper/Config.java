package com.abnamro.assignment.Helper;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Config {

    private static final Properties properties = new Properties();

    static{
        try{
            String inputFilePath = System.getProperty("user.dir") + "/src/test/java/com/abnamro/assignment/Resources/config.properties";
            System.out.print(inputFilePath);
            InputStream input = new FileInputStream(inputFilePath);
            properties.load(input);
        }
        catch (IOException exception){
            exception.printStackTrace();
        }
    }

    public static String getPropertyValue(String propertyName){
        return properties.getProperty(propertyName);
    }
    
}
