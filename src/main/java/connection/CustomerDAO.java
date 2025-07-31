package connection;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;

public class CustomerDAO {
    private final MongoCollection<Document> customerCollection;

    public CustomerDAO() {
        MongoDatabase db = MongoDBConnection.getDatabase();
        customerCollection = db.getCollection("customer");
    }

    public boolean addCustomer(int cusAccNo, String cName, String cAddress, String cTele, int cUnits) {
        Document existingCustomer = customerCollection.find(
            new Document("CusAccNo", cusAccNo)
        ).first();

        if (existingCustomer != null) {
            return false; // Customer already exists
        }

        Document newCustomer = new Document("CusAccNo", cusAccNo)
                .append("cName", cName)
                .append("cAddress", cAddress)
                .append("cTele", cTele)
                .append("cUnits", cUnits);

        customerCollection.insertOne(newCustomer);
        return true;
    }

    public Document getCustomerByAccNo(int cusAccNo) {
        return customerCollection.find(new Document("CusAccNo", cusAccNo)).first();
    }

    public boolean updateCustomer(int cusAccNo, String cName, String cAddress, String cTele, int cUnits) {
        Document existing = customerCollection.find(new Document("CusAccNo", cusAccNo)).first();
        if (existing == null) {
            return false;
        }

        Document updatedFields = new Document()
            .append("cName", cName)
            .append("cAddress", cAddress)
            .append("cTele", cTele)
            .append("cUnits", cUnits);

        Document updateQuery = new Document("$set", updatedFields);

        customerCollection.updateOne(new Document("CusAccNo", cusAccNo), updateQuery);
        return true;
    }

    public boolean deleteCustomer(int cusAccNo) {
        Document existing = customerCollection.find(new Document("CusAccNo", cusAccNo)).first();
        if (existing == null) {
            return false;
        }

        customerCollection.deleteOne(new Document("CusAccNo", cusAccNo));
        return true;
    }

    public List<Document> getAllCustomers() {
        return customerCollection.find().into(new ArrayList<>());
    }
}
