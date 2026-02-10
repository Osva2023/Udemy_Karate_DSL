package conduitApp.helpers;

import java.util.List;

import com.github.javafaker.Faker;
import java.util.Random;
import java.util.Arrays;

import net.minidev.json.JSONObject;

public class DataGenerator {
    
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public static JSONObject getRandomArticleValues(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }
    public static String getRandomTag() {
        List<String> tags = Arrays.asList(
            "Test",
            "Git",
            "YouTube",
            "Blog",
            "Slack",
            "Bondar Academy",
            "Zoom",
            "GitHub",
            "Value-Focused",
            "Start for Free"
        );
        Random random = new Random();
        return tags.get(random.nextInt(tags.size()));
    }

}