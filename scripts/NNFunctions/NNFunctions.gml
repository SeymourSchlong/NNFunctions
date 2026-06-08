#macro forgery global.forgery_9
#macro agi asset_get_index

// vanilla game stuff
#macro scr_Text					asset_get_index("scr_Text")
#macro scr_PopPeg				asset_get_index("scr_PopPeg")
#macro scr_AddNumber			asset_get_index("scr_AddNumber")
#macro scr_ForceTrigger			asset_get_index("scr_ForceTrigger")
#macro scr_Part_SunExplode		asset_get_index("scr_Part_SunExplode")
#macro scr_PartAmt				asset_get_index("scr_PartAmt")
#macro scr_BounceAndCol			asset_get_index("scr_BounceAndCol")
#macro scr_FlyingNumber			asset_get_index("scr_FlyingNumber")
#macro scr_GameEv				asset_get_index("scr_GameEv")
#macro scr_HalvePeg				asset_get_index("scr_HalvePeg")
#macro scr_DoublePeg			asset_get_index("scr_DoublePeg")
#macro scr_DoubleDoublePeg		asset_get_index("scr_DoubleDoublePeg")
#macro scr_FX_ItemExplosion		asset_get_index("scr_FX_ItemExplosion")
#macro scr_MutateItem			asset_get_index("scr_MutateItem")
#macro scr_FX_MultiplyScore		asset_get_index("scr_FX_MultiplyScore")
#macro scr_SummonEntity			asset_get_index("scr_SummonEntity")
#macro scr_LocalEqualFont		asset_get_index("scr_LocalEqualFont")
#macro scr_OutlineText			asset_get_index("scr_OutlineText")
#macro scr_UpdateSeed			asset_get_index("scr_UpdateSeed")
#macro scr_FoodEffect			asset_get_index("scr_FoodEffect")
#macro scr_UpgrFoodEffect		asset_get_index("scr_UpgrFoodEffect")


#macro obj_ItemMGMT				asset_get_index("obj_ItemMGMT")
#macro obj_PerkMGMT				asset_get_index("obj_PerkMGMT")
#macro obj_LvlMGMT				asset_get_index("obj_LvlMGMT")
#macro obj_ParPeg				asset_get_index("obj_ParPeg")
#macro obj_ParNubby				asset_get_index("obj_ParNubby")
#macro obj_GridCell				asset_get_index("obj_GridCell")
#macro obj_AnyPeg				asset_get_index("obj_AnyPeg")
#macro obj_SV4Manager			asset_get_index("obj_SV4Manager")
#macro obj_ItemParent			asset_get_index("obj_ItemParent")
#macro obj_ParPerk				asset_get_index("obj_ParPerk")
#macro obj_PerkSelMove			asset_get_index("obj_PerkSelMove")
#macro obj_CafeMouth			asset_get_index("obj_CafeMouth")
#macro obj_CafeDialogue			asset_get_index("obj_CafeDialogue")
#macro obj_UnqItemMove			asset_get_index("obj_UnqItemMove")
#macro obj_EventMGMT			asset_get_index("obj_EventMGMT")
#macro obj_ChallengesMGMT		asset_get_index("obj_ChallengesMGMT")
#macro obj_GhostCoin			asset_get_index("obj_GhostCoin")

#macro au_FoodEffect			asset_get_index("au_FoodEffect")

/// @function		get_random_peg([amount], [unique]);
/// @param {Real}	amount	The number of pegs to get
/// @param {Bool}	unique	Whether or not the same peg can be rolled multiple times
/// @description	Returns any number of requested pegs as an array
function get_random_peg(amount = 1, unique = true) {
	var _ValidPegs = ds_list_create();
	ds_list_clear(_ValidPegs);

	for (var _i = 0; _i < instance_number(obj_ParPeg); _i++) {
		var _Tar = instance_find(obj_ParPeg, _i);
		
		if (instance_exists(_Tar) and _Tar != -1)
		{
			if (_Tar.PegDead == false)
			{
				ds_list_add(_ValidPegs, _Tar);
			}
		}
	}
	ds_list_shuffle(_ValidPegs);

	var _peg_list = [];

	if (ds_list_size(_ValidPegs) > 0)
	{
		if (unique) {
			var amount_of_pegs = min(amount, ds_list_size(_ValidPegs));
			
			for (var _i = 0; _i < amount_of_pegs; _i++) {
				array_push(_peg_list, ds_list_find_value(_ValidPegs, _i));
			}
		} else {
			repeat(amount) {
				array_push(_peg_list, ds_list_find_value(_ValidPegs, 0));
				ds_list_shuffle(_ValidPegs);
			}
		}
	}

	ds_list_destroy(_ValidPegs);

	return _peg_list;
}

/// @function		get_highest_peg([amount]);
/// @param {Real}	amount	The number of pegs to get
/// @description	Returns the requested amount of highest # pegs
function get_highest_peg(amount = 1) {
    var _ValidPegs = ds_list_create();
    ds_list_clear(_ValidPegs);

    for (var _i = 0; _i < instance_number(obj_ParPeg); _i++) {
        var _Tar = instance_find(obj_ParPeg, _i);
        
        if (instance_exists(_Tar) and _Tar != -1) {
            if (_Tar.PegDead == false) {
				var _position_to_insert = 0
				while (_position_to_insert < ds_list_size(_ValidPegs)) {
					if (_Tar.PegNum >= ds_list_find_value(_ValidPegs, _position_to_insert).PegNum) {
						break;
					}

					_position_to_insert += 1;
				}
				ds_list_insert(_ValidPegs, _position_to_insert, _Tar);
            }
        }
    }

    var _peg_list = [];

    if (ds_list_size(_ValidPegs) > 0) {
        var amount_of_pegs = min(amount, ds_list_size(_ValidPegs));

        for (var _i = 0; _i < amount_of_pegs; _i++) {
            array_push(_peg_list, ds_list_find_value(_ValidPegs, _i))
        }
    }

    ds_list_destroy(_ValidPegs);

    return _peg_list;
}


/// @function		get_lowest_peg([amount]);
/// @param {Real}	amount	The number of pegs to get
/// @description	Returns the requested amount of lowest # pegs, sorted
function get_lowest_peg(amount = 1) {
    var _ValidPegs = ds_list_create();
    ds_list_clear(_ValidPegs);

    for (var _i = 0; _i < instance_number(obj_ParPeg); _i++) {
        var _Tar = instance_find(obj_ParPeg, _i);
        
        if (instance_exists(_Tar) and _Tar != -1) {
            if (_Tar.PegDead == false) {
				var _position_to_insert = 0
				while (_position_to_insert < ds_list_size(_ValidPegs)) {
					if (_Tar.PegNum <= ds_list_find_value(_ValidPegs, _position_to_insert).PegNum) {
						break;
					}

					_position_to_insert += 1;
				}
				ds_list_insert(_ValidPegs, _position_to_insert, _Tar);
            }
        }
    }

    var _peg_list = [];

    if (ds_list_size(_ValidPegs) > 0) {
        var amount_of_pegs = min(amount, ds_list_size(_ValidPegs));

        for (var _i = 0; _i < amount_of_pegs; _i++) {
            array_push(_peg_list, ds_list_find_value(_ValidPegs, _i))
        }
    }

    ds_list_destroy(_ValidPegs);

    return _peg_list;
}

/// @function		get_item_id(object);
/// @param {Real}	object	The instance of the item
/// @description	Returns the ID of a given item object
function get_item_id(object) {
    for (var _i = 0; _i < array_length(obj_ItemMGMT.ItemObj); _i++)
    {
        if (obj_ItemMGMT.ItemObj[_i] == object.object_index)
        {
            return _i;
        }
    }
	
	return -1;
}

/// @function		get_perk_id(object);
/// @param {Real}	object	The instance of the perk
/// @description	Returns the ID of a given perk object
function get_perk_id(object) {
    for (var _i = 0; _i < array_length(obj_PerkMGMT.PerkObj); _i++)
    {
        if (obj_PerkMGMT.PerkObj[_i] == object)
        {
            return _i;
        }
    }
	
	return -1;
}

/// @function		random_chance(random_num, rate);
/// @param {Real}	random_num	A random number, preferably generated by `random(100)`
/// @param {Real}	rate		The given rate of that chance happening
/// @description	Evaluates the result of a random number given against its odds
function random_chance(random_num, rate) {
	return random_num < rate;
}

/// @function		give_perk(perk_id, [instant], [at_x], [at_y]);
/// @param {Real}	perk_id	The ID of the desired perk
/// @param {Bool}	instant	Whether or not the perk should appear in the list instantly
/// @param {Real}	at_x	The x coord to spawn it at (defaults to center)
/// @param {Real}	at_y	The y coord to spawn it at (defaults to center)
/// @description	Gives the player a given perk
function give_perk(perk_id, instant = false, at_x = 950, at_y = 540) {
    //var new_perk = instance_create_layer(at_x, at_y, "UnderCursor", obj_PerkSelMove);
    //new_perk.HeldPerk = arg0;
    //var perk_stacked = 0;
    //var duped_id = -1;
    
    //if (instance_exists(obj_ParPerk))
    //{
    //    for (var i = 0; i < ds_list_size(obj_PerkMGMT.PerkInst); i += 1)
    //    {
    //        if (ds_list_find_value(obj_PerkMGMT.PerkInst, i).MyPerkID == new_perk.HeldPerk)
    //        {
    //            perk_stacked = true;
    //            duped_id = ds_list_find_value(obj_PerkMGMT.PerkInst, i);
    //            break;
    //        }
    //    }
    //}
    
    //if (perk_stacked == false)
    //{
    //    if (ds_list_size(obj_PerkMGMT.PerkDispList) < 8)
    //    {
    //        new_perk.TarX = obj_PerkMGMT.PerkX + (59 * ds_list_size(obj_PerkMGMT.PerkDispList));
    //        new_perk.TarY = obj_PerkMGMT.PerkY;
    //        new_perk.CountAsDispUp = true;
    //    }
    //    else
    //    {
    //        var _TtlSize = ds_list_size(obj_PerkMGMT.PerkDispList) + 1;
    //        var _Spacing = round((obj_PerkMGMT.PerkEndSpace - obj_PerkMGMT.PerkX) / _TtlSize);
    //        new_perk.TarY = obj_PerkMGMT.PerkY;
    //        var _TarX = obj_PerkMGMT.PerkX + (_Spacing * _TtlSize);
    //        new_perk.TarX = _TarX;
    //        new_perk.CountAsDispUp = true;
    //    }
    //}
    //else
    //{
    //    new_perk.TarX = duped_id.x;
    //    new_perk.TarY = duped_id.y;
    //    new_perk.CountAsDispUp = false;
    //}
    
    //new_perk.sprite_index = object_get_sprite(obj_PerkMGMT.PerkObj[perk_id]);
    //new_perk.image_alpha = 1;
}

function give_suspicious_key(instant = false, at_x = 950, at_y = 540) {
	
}

function give_coins(amount, at_x = 940 + irandom_range(-64, 64), at_y = 563 + irandom_range(-64, 64)) {
	repeat (amount) {
        var _NewGC = instance_create_depth(at_x, at_y, obj_ItemMGMT.depth - 1, obj_GhostCoin);
        _NewGC.GCSpd = irandom_range(30, 40);
    }
}


function forgery_get_item_id(modname, name) {
    var index = forgery.registries_exchange(
		global.registry,
		global.index_registry,
		forgery.resources.item,
		modname+":"+name
	);
    return index;
}

function forgery_get_item_object(modname, name) {
    var index = forgery_get_item_id(modname, name);
    return obj_ItemMGMT.ItemObj[index];
}

function forgery_get_perk_id(modname, name) {
    var index = forgery.registries_exchange(
		global.registry,
		global.index_registry,
		forgery.resources.perk,
		modname+":"+name
	);
    return index;
}

function forgery_get_perk_object(modname, name) {
    var index = forgery_get_perk_id(modname, name);
    return obj_PerkMGMT.PerkObj[index];
}

function forgery_get_supervisor_id(modname, name) {
    var index = forgery.registries_exchange(
		global.registry,
		global.index_registry,
		forgery.resources.supervisor,
		modname+":"+name
	);
    return index;
}

function forgery_get_challenge_id(modname, name) {
    var index = forgery.registries_exchange(
		global.registry,
		global.index_registry,
		forgery.resources.challenge,
		modname+":"+name
	);
    return index;
}

/// @function		is_supervisor(modname, name);
/// @param {String}	modname The string ID of the mod
/// @param {String}	name	The string ID of the supervisor
/// @description	Returns if the current supervisor is the requested one
function is_supervisor(modname, name) {
	return forgery_get_supervisor_id(modname, name) == obj_LvlMGMT.SVID;
}

/// @function		is_challenge(modname, name);
/// @param {String}	modname The string ID of the mod
/// @param {String}	name	The string ID of the challenge
/// @description	Returns if the current challenge is the requested one
function is_challenge(modname, name) {
	return forgery_get_challenge_id(modname, name) == obj_LvlMGMT.ChallengeMode;
}