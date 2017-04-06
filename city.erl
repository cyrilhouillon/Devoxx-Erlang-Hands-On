-module(city).

%% API
-export([new/1, name_of/1, infects/2, infection_level/2, findInfectionLevelFor/2]).
-include_lib("eunit/include/eunit.hrl").

new(CityName) -> {ok, {CityName, []}}.

name_of( {CityName, _} ) -> CityName.

infects({CityName, InfectionLevels}, Disease) -> {CityName, infects0(InfectionLevels, Disease, [])}.

infects0([], Disease, Acc) -> Acc ++ [{Disease, 1}];
infects0([ {Disease, Level} | Tail ], Disease, Acc) -> Acc ++ [{Disease, Level+1} | Tail ];
infects0([ Head | Tail ], Disease, Acc) -> infects0(Tail, Disease, [Head | Acc]).

infection_level({_, InfectionLevels}, Disease) ->
	{Disease, InfectionLevel} = findInfectionLevelFor(InfectionLevels, Disease),
	InfectionLevel.

findInfectionLevelFor([], Disease) -> {Disease, 0};
findInfectionLevelFor([{Disease, InfectionLevel} | _], Disease) -> {Disease, InfectionLevel};
findInfectionLevelFor([_ | Tail], Disease) -> findInfectionLevelFor(Tail, Disease).

