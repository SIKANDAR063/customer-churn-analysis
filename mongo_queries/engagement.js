// Activity per customer
db.user_activity_logs.aggregate([
  {
    $group: {
      _id: "$customer_id",
      total_activity: { $sum: 1 }
    }
  },
  { $sort: { total_activity: 1 } }
]);

// Event type usage
db.user_activity_logs.aggregate([
  {
    $group: {
      _id: "$event_type",
      count: { $sum: 1 }
    }
  }
]);