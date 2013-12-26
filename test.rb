require 'rest_client'

p RestClient.get 'http://www.egison.org/api/version'

p RestClient.post 'http://www.egison.org/api/eval', {program: "(test (match-all {1 2 3} (list integer) [<cons $x $xs> [x xs]]))"}

