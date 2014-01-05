require 'rest_client'

p RestClient.get 'http://api.egison.org/version'

p RestClient.post 'http://api.egison.org/eval', {program: "(test (match-all {1 2 3} (list integer) [<cons $x $xs> [x xs]]))"}

