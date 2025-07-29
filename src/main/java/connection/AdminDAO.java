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
        Document existingAdmin = adminCollection.find(
            new Document("adminID", adminID)
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

    public Document getAdminById(String adminID) {
        return adminCollection.find(new Document("adminID", adminID)).first();
    }
    
    public boolean updateAdmin(String adminID, String name, String email, String password, String designation) {
    Document existing = adminCollection.find(new Document("adminID", adminID)).first();
    if (existing == null) {
        return false;
    }

    Document updatedFields = new Document()
        .append("name", name)
        .append("email", email)
        .append("password", password)
        .append("designation", designation);

    Document updateQuery = new Document("$set", updatedFields);

    adminCollection.updateOne(new Document("adminID", adminID), updateQuery);
    return true;
    }
    
    public boolean deleteAdmin(String adminID) {
    Document existing = adminCollection.find(new Document("adminID", adminID)).first();
    if (existing == null) {
        return false;
    }

    adminCollection.deleteOne(new Document("adminID", adminID));
    return true;
    }

}
