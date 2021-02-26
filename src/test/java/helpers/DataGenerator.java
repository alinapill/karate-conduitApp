package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {
     // call the method from the JAVA file using STATIC without creating the instance of the class
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    //this method does not have STATIC, so the instance is made in the FEATURE file using a JS function
    public String getRandomUsernameNonStaticMethod() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
}