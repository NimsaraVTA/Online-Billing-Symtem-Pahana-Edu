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

    public boolean addAdmin(String name, String email, String password, String designation, String adminID) {
        // Check if an admin with the same adminID or email already exists
        Document existingAdmin = adminCollection.find(
            new Document("$or", 
                java.util.Arrays.asList(
                    new Document("adminID", adminID)
                )
            )
        ).first();

        if (existingAdmin != null) {
            return false; // Admin already exists
        }

        Document newAdmin = new Document("name", name)
                .append("email", email)
                .append("password", password)
                .append("designation", designation)
                .append("adminID", adminID);

        adminCollection.insertOne(newAdmin);
        return true;
    }
}
