// Ejercicio 1
// b
db.albums.aggregate([
  {
    $group: {
      _id: "$Year",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  }
])
// c
db.albums.updateMany({}, [
  {
    $set: {
      score: {
        $subtract: [501, "$Number"]
      }
    }
  }
])
// d
db.albums.aggregate([
  {
    $group: {
      _id: "$Artist",
      score: { $sum: "$score" }
    }
  },
  {
    $sort: { score: -1 }
  }
])