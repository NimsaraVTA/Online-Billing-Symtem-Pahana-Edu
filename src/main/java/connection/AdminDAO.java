package connection;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class AdminDAO {
    private final MongoCollection<Document> adminCollection;

    public AdminDAO() {
        MongoDatabase db = MongoDBConnection.getDatabase();
        adminCollection = db.getCollection("admin");
    }

    public boolean validateAdmin(String username, String password) {
        Document query = new Document("name", username)
                .append("password", password);
        Document admin = adminCollection.find(query).first();
        return admin != null; 
    }
}
