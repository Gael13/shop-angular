app = angular.module("Shop-angular", ["ngResource"])

app.factory "Entry", ["$resource", ($resource) ->
  $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@PhoneCtrl = ["$scope", "Entry", ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}
  
  $scope.randomPhone = ->
    pool = []
    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) if !entry.phone 
    if pool.length > 0
      entry = pool[Math.floor(Math.random()*pool.length)]
      entry.phone = true
      entry.$update()
      $scope.lastPhone = entry  
]      