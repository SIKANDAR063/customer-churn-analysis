// 1. Standardize customer_id field (handle inconsistent naming)
db.user_activity_logs.updateMany(
  { customerId: { $exists: true } },
  [
    { $set: { customer_id: "$customerId" } },
    { $unset: "customerId" }
  ]
);

db.user_activity_logs.updateMany(
  { customerID: { $exists: true } },
  [
    { $set: { customer_id: "$customerID" } },
    { $unset: "customerID" }
  ]
);

// 2. Convert customer_id to consistent type (string)
db.user_activity_logs.updateMany(
  {},
  [
    { $set: { customer_id: { $toString: "$customer_id" } } }
  ]
);

// 3. Remove duplicate records (based on same customer_id + timestamp)
db.user_activity_logs.aggregate([
  {
    $group: {
      _id: {
        customer_id: "$customer_id",
        timestamp: "$timestamp"
      },
      ids: { $addToSet: "$_id" },
      count: { $sum: 1 }
    }
  },
  { $match: { count: { $gt: 1 } } }
]).forEach(doc => {
  doc.ids.shift(); // keep one
  db.user_activity_logs.deleteMany({ _id: { $in: doc.ids } });
});

// 4. Handle missing values (optional default)
db.user_activity_logs.updateMany(
  { customer_id: null },
  { $set: { customer_id: "unknown" } }
);

// 5. Fix inconsistent timestamp formats (convert to ISODate if needed)
db.user_activity_logs.updateMany(
  { timestamp: { $type: "string" } },
  [
    { $set: { timestamp: { $toDate: "$timestamp" } } }
  ]
);

print("MongoDB data cleaning completed successfully.");