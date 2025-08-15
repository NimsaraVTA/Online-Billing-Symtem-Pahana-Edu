package connection;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    private final MongoCollection<Document> itemCollection;

    public ItemDAO() {
        MongoDatabase db = MongoDBConnection.getDatabase();
        itemCollection = db.getCollection("item");
    }

    public boolean addItem(int itemId, String itemName, int price, int stock, String description) {
        Document existing = itemCollection.find(new Document("item_id", itemId)).first();
        if (existing != null) return false;

        Document newItem = new Document("item_id", itemId)
                .append("item_name", itemName)
                .append("price", price)
                .append("stock", stock)
                .append("description", description);

        itemCollection.insertOne(newItem);
        return true;
    }

    public Document getItemById(int itemId) {
        return itemCollection.find(new Document("item_id", itemId)).first();
    }

    public boolean updateItem(int itemId, String itemName, int price, int stock, String description) {
        Document existing = getItemById(itemId);
        if (existing == null) return false;

        Document updates = new Document("item_name", itemName)
                .append("price", price)
                .append("stock", stock)
                .append("description", description);

        itemCollection.updateOne(new Document("item_id", itemId), new Document("$set", updates));
        return true;
    }

    public boolean deleteItem(int itemId) {
        Document existing = getItemById(itemId);
        if (existing == null) return false;

        itemCollection.deleteOne(new Document("item_id", itemId));
        return true;
    }

    public List<Document> getAllItems() {
        return itemCollection.find().into(new ArrayList<>());
    }
}
