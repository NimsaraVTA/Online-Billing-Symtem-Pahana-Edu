package connection;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class BillDAO {
    private MongoCollection<Document> billingCollection;

    public BillDAO() {
        MongoDatabase database = MongoDBConnection.getDatabase();
        billingCollection = database.getCollection("billing");
    }

    public void insertBill(Document billDoc) {
        billingCollection.insertOne(billDoc);
    }
}
