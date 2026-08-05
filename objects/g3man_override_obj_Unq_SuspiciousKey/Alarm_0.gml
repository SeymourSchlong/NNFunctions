if (UnqSpawnFx == true)
{
    audio_play_sound(agi("au_FireworkExplode"), 1, 0, 1, 0, 1.4);
    agi("scr_Part_NewLife")(scr_PartAmt(20));
}