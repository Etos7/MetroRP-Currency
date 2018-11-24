ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "MetroRP currency"
ENT.Author = "FPtje + Etos7"
ENT.Spawnable = false
ENT.IsSpawnedMoney = true

function ENT:SetupDataTables()
    self:NetworkVar("Int",0,"amount")
end