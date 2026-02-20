Config = {}

Config.HarvestTime = 5000

Config.Zones = {
    aluminium = {
        label = "Récolte Aluminium",
        item = "aluminium_brut",
        prop = "prop_rub_carwreck_13",
        coords = vec3(2380.8137, 3045.2063, 48.1526),
        radius = 25.0,
        spawnAmount = 10,
        respawnTime = 200, -- secondes
        blip = {
            enabled = true,
            sprite = 318,
            color = 47,
            scale = 0.4
        }
    },

    acier = {
        label = "Récolte Acier",
        item = "acier_brut",
        prop = "prop_ind_mech_03a",
        coords = vec3(471.2049, -2644.8386, 5.7110),
        radius = 20.0,
        spawnAmount = 10,
        respawnTime = 200,
        blip = {
            enabled = true,
            sprite = 318,
            color = 5,
            scale = 0.4
        }
    },

    polymere = {
        label = "Récolte Polymère",
        item = "polymere_brut",
        prop = "v_res_smallplasticbox",
        coords = vec3(1399.5060, -2059.9451, 51.9983),
        radius = 15.0,
        spawnAmount = 10,
        respawnTime = 200,
        blip = {
            enabled = true,
            sprite = 318,
            color = 3,
            scale = 0.4
        }
    }
}
