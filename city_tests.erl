-module(city_tests).

%% API
-export([]).
-include_lib("eunit/include/eunit.hrl").

new_city_should_return_ok_test() -> 
	{ok, _} = city:new(london).

name_of_should_return_the_name_of_the_city_test() -> 
	{ok, City} = city:new(london),
	?assertEqual(london, city:name_of(City)).

infection_level_should_be_at_0_for_new_city_test() ->
	{ok, City} = city:new(london),
	?assertEqual(0, city:infection_level(City, green)).



findInfectionLevelFor_disease_when_no_diseases_should_return_0_test() ->
	?assertEqual({green, 0}, city:findInfectionLevelFor([], green)).

findInfectionLevelFor_disease_should_return_0_when_disease_absent_test() ->
	?assertEqual({green, 0}, city:findInfectionLevelFor([{blue, 3}], green)).

findInfectionLevelFor_disease_should_return_right_infection_level_test() ->
	?assertEqual({green, 3}, city:findInfectionLevelFor([{green, 3}], green)),
	?assertEqual({green, 3}, city:findInfectionLevelFor([{blue, 1}, {green, 3}, {red, 5}], green)).


infects_should_increment_infection_level_when_infection_level_is_0_test() ->
	{london, [{green, 1}]} = city:infects({london, []}, green).

infects_should_increment_infection_level_when_infection_level_is_0_and_other_disease_test() ->
	{london, Levels} = city:infects({london, [{blue, 2}]}, green),
	?assertEqual(true, contains(Levels, {blue, 2})),
	?assertEqual(true, contains(Levels, {green, 1})).

infects_should_increment_infection_level_test() ->
	{london, Levels} = city:infects({london, [{green, 2}]}, green),
	?assertEqual(true, contains(Levels, {green, 3})).


contains([], _) -> false;
contains([Element | _], Element) -> true;
contains([ _ | Tail], Element) -> contains(Tail, Element).

