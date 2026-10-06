-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.AttackPlayer.AttackPlayer
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.AttackPlayer.AttackPlayer
-- Decompile time: 2.21 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local SkillCTRL = require(ReplicatedStorage.EnemySystem.SkillCTRL)
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)

function v1.start(a1) -- Line: 10 -- upvalues: Helper (val), CFrameUtils (val), SkillCTRL (val)
    local Blackboard = a1.Blackboard
    local SkillTab = a1.SkillTab
    local Cache = a1.Cache
    local Model = a1.Model
    local LocalPlayer = a1.LocalPlayer
    Cache.UseSkillID = Blackboard.UseSkillID
    local v1 = SkillTab[Cache.UseSkillID]
    v1.LastTick = os.clock()
    v1 = Helper.GetSkillActionTime(Cache.UseSkillID)
    Cache.CanExitTick = os.clock() + v1 + 0.5
    Model:PivotTo((CFrameUtils.FaceToCF(Model:GetPivot(), (LocalPlayer.Character:GetPivot()))))
    SkillCTRL.AnySkill(Model, Cache.UseSkillID, {AnimObj = a1.AnimObj, TargetPlayer = LocalPlayer})
end

function v1.finish(a1, a2) -- Line: 44
    local Blackboard = a1.Blackboard
end

function v1.run(a1) -- Line: 54
    local Blackboard = a1.Blackboard
    local Cache = a1.Cache
    if Cache.CanExitTick then
        local CanExitTick = Cache.CanExitTick
        if os.clock() < CanExitTick then
            return 3
        end
    end
    return 1
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.FindPlayer.FindPlayer
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.FindPlayer.FindPlayer
-- Decompile time: 0.57 ms

local v1 = {}
game:GetService("Players")

function v1.start(a1) -- Line: 6
    local Blackboard = a1.Blackboard
end

function v1.finish(a1, a2) -- Line: 9
    local Blackboard = a1.Blackboard
end

function v1.run(a1) -- Line: 12
    local Blackboard = a1.Blackboard
    return 1
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.InCD.InCD
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.InCD.InCD
-- Decompile time: 2.79 ms

return {
    start = function(a1) -- Line: 13
        local Blackboard = a1.Blackboard
    end,
    finish = function(a1, a2) -- Line: 23
        local Blackboard = a1.Blackboard
    end,
    run = function(a1) -- Line: 33
        local LastTick, v1, v2
        local Blackboard = a1.Blackboard
        local v3 = false
        local v4 = nil
        local v5 = 0
        local v6 = nil
        local v7 = nil
        for i, j in a1.SkillTab, v6, v7 do
            v1 = j.CD or 0
            LastTick = j.LastTick
            v2 = j.MinDistance or 6
            if not LastTick or not (os.clock() - LastTick < v1) then
                j.InCD = false
                v3 = true
                if v5 < v2 then
                    v4 = i
                    v5 = v2
                end
            else
                j.InCD = true
            end
        end
        if not v3 then
            return 1
        end
        Blackboard.UseSkillID = v4
        Blackboard.UseMinDistance = v5
        return 2
    end,
}
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.MoveToOriPosi.MoveToOriPosi
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.MoveToOriPosi.MoveToOriPosi
-- Decompile time: 1.37 ms

return {
    start = function(a1) -- Line: 17
        a1.Blackboard.StartRunTick = os.clock()
    end,
    finish = function(a1, a2) -- Line: 21
        a1.Blackboard.StartRunTick = nil
    end,
    run = function(a1) -- Line: 25
        local Blackboard = a1.Blackboard
        local RootPart = a1.RootPart
        local OriCF = a1.OriCF
        local Humanoid = a1.Humanoid
        if not Humanoid then
            return 2
        end
        Humanoid:MoveTo(OriCF.Position)
        if Blackboard.StartRunTick + 5 < os.clock() then
            return 2
        end
        if 5 < (RootPart.Position - OriCF.Position).Magnitude then
            return 1
        end
        return 2
    end,
}
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.MoveToPlayer.MoveToPlayer
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.MoveToPlayer.MoveToPlayer
-- Decompile time: 1.95 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)

function v1.start(a1) -- Line: 8
    local Blackboard = a1.Blackboard
end

function v1.finish(a1, a2) -- Line: 11
    local Blackboard = a1.Blackboard
end

function v1.run(a1) -- Line: 14 -- upvalues: CFrameUtils (val)
    local Blackboard = a1.Blackboard
    local Character = a1.LocalPlayer.Character
    if not Character then
        return 2
    end
    local Humanoid = a1.Humanoid
    if not Humanoid then
        return 2
    end
    local RootPart = a1.RootPart
    local Pivot = Character:GetPivot()
    local CFrame = RootPart.CFrame
    local Magnitude = (Pivot.Position - CFrame.Position).Magnitude
    local UseMinDistance = Blackboard.UseMinDistance
    if UseMinDistance and Magnitude < UseMinDistance then
        return 1
    end
    Humanoid:MoveTo((CFrameUtils.GetSurroundCF(CFrame, Pivot, 5)).Position)
    return 2
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.StayInOriPosi.StayInOriPosi
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.StayInOriPosi.StayInOriPosi
-- Decompile time: 0.64 ms

return {
    start = function(a1) -- Line: 5
        local Blackboard = a1.Blackboard
    end,
    finish = function(a1, a2) -- Line: 8
        local Blackboard = a1.Blackboard
    end,
    run = function(a1) -- Line: 11
        local Blackboard = a1.Blackboard
        if (a1.RootPart.Position - a1.OriCF.Position).Magnitude < 3 then
            return 1
        end
        return 2
    end,
}
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.Surround.Surround
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.Surround.Surround
-- Decompile time: 1.35 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)

function v1.start(a1) -- Line: 7
    local Blackboard = a1.Blackboard
end

function v1.finish(a1, a2) -- Line: 10
    local Blackboard = a1.Blackboard
end

function v1.run(a1) -- Line: 13 -- upvalues: CFrameUtils (val)
    local Blackboard = a1.Blackboard
    local Character = a1.LocalPlayer.Character
    local Humanoid = a1.Humanoid
    local RootPart = a1.RootPart
    local Pivot = Character:GetPivot()
    local CFrame = RootPart.CFrame
    local Magnitude = (Pivot.Position - CFrame.Position).Magnitude
    Humanoid:MoveTo((CFrameUtils.GetSurroundCF(CFrame, Pivot, 8)).Position)
    return 1
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").BTree.Mob_1.Nodes.ToOriPosi.ToOriPosi
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.BTree.Mob_1.Nodes.ToOriPosi.ToOriPosi
-- Decompile time: 1.19 ms

return {
    start = function(a1) -- Line: 13
        local Blackboard = a1.Blackboard
        a1.Model:PivotTo(a1.OriCF)
    end,
    finish = function(a1, a2) -- Line: 25
        local Blackboard = a1.Blackboard
    end,
    run = function(a1) -- Line: 35
        local Blackboard = a1.Blackboard
        return 1
    end,
}
-- Script Path: game:GetService("ReplicatedStorage").CTRL.EnemyCTRL
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.CTRL.EnemyCTRL
-- Decompile time: 16.08 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Stage.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Dungeon.Helper)
local UUIDUtils = require(ReplicatedStorage.Utils.UUIDUtils)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local HitVFXUtils = require(ReplicatedStorage.Utils.HitVFXUtils)
local TopGUI = require(ReplicatedStorage.GuiUtils.TopGUI)
local AnimatorObj = require(ReplicatedStorage.Object.AnimatorObj)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
local BehaviorTree_Creater = require(ReplicatedStorage.Tool.BehaviorTree_Creater)
local u68 = CommunicationUtils.TryGetRemoteEvent("Attack", "KillEnemyRE")
local EnemyFolder = workspace:WaitForChild("EnemyFolder")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u77 = {}

local function _CreateEnemyModel(a1, a2, a3) -- Line: 67 -- upvalues: ReplicatedStorage (val), EnemyFolder (val)
    local v1 = (ReplicatedStorage.Assets.Enemy:FindFirstChild(a1) or ReplicatedStorage.Assets.Enemy:FindFirstChild("Enemy_1")):Clone()
    v1.Parent = EnemyFolder
    v1.Name = a2
    v1.PrimaryPart:AddTag("Enemy")
    local Humanoid = v1:FindFirstChild("Humanoid")
    if Humanoid then
        Humanoid.StateChanged:Connect(function(a1, a2) -- Line: 78 -- upvalues: Humanoid (val)
            if a2 == Enum.HumanoidStateType.FallingDown then
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end)
    end
    v1:PivotTo(a3)
    v1:SetAttribute("OriWalkSpeed", v1.Humanoid.WalkSpeed)
    return v1
end

local function _AttachSkillTab(a1, a2) -- Line: 90 -- upvalues: Helper (val)
    local v1, v2
    a1.SkillTab = {}
    for i, j in (Helper.GetEnemySkillList(a2)) do
        v1 = Helper.GetSkillCD(j)
        v2 = Helper.GetSkillMinDistance(j) or 6
        a1.SkillTab[j] = {CD = v1, MinDistance = v2}
    end
end

local function _AttachAnimObj(a1, a2, a3) -- Line: 105 -- upvalues: AnimatorObj (val), ReplicatedStorage (val)
    a1.AnimObj = AnimatorObj.new(
        ReplicatedStorage.Assets.Animation.Enemy_Action:WaitForChild(a2),
        (a3:WaitForChild("Humanoid")):WaitForChild("Animator")
    )
end

local function _AttachNormalHPBar(a1, a2) -- Line: 112
    -- upvalues: ReplicatedStorage (val), HPCTRL (val), AbbreviateNumber (val), TweenService (val)
    local v1 = ReplicatedStorage.Assets.UI.Billboard:WaitForChild("EnemyHPUI"):Clone()
    v1.Parent = a1.PrimaryPart
    local ing = (v1:WaitForChild("BillboardGui")):WaitForChild("ing")
    local Name = ing:WaitForChild("Name")
    Name:WaitForChild("TextLabel").Text = a2
    HPCTRL.ListenHPChanged(a1, function(a1, a2) -- Line: 117 -- upvalues: ing (val), AbbreviateNumber (upval), TweenService (upval)
        local v1 = math.clamp(a1 / a2, 0, 1)
        if ing and ing.Parent then
            local TextLabel = (ing:WaitForChild("Info")):WaitForChild("TextLabel")
            TextLabel.Text = ("%*/%*"):format(AbbreviateNumber((math.round((math.max(a1, 0))))), (AbbreviateNumber((math.round(a2)))))
            TweenService:Create((ing:WaitForChild("Info")):WaitForChild("Bar"), TweenInfo.new(0.2), {Size = UDim2.fromScale(v1, 0.8)}):Play()
            task.wait(0.15)
            if ing and ing.Parent then
                TweenService:Create(
                    (ing:WaitForChild("Info")):WaitForChild("RedBar"),
                    TweenInfo.new(0.2),
                    {Size = UDim2.fromScale(v1, 0.8)}
                ):Play()
            end
            return
        end
    end)
end

local function _AttachPercentHPBar(a1, a2) -- Line: 138
    -- upvalues: ReplicatedStorage (val), HPCTRL (val), AbbreviateNumber (val), TweenService (val)
    local v1 = ReplicatedStorage.Assets.UI.Billboard:WaitForChild("EnemyHPUI"):Clone()
    v1.Parent = a1.PrimaryPart
    local ing = (v1:WaitForChild("BillboardGui")):WaitForChild("ing")
    local Name = ing:WaitForChild("Name")
    Name:WaitForChild("TextLabel").Text = a2
    HPCTRL.ListenHPChanged(a1, function(a1, a2) -- Line: 143 -- upvalues: ing (val), AbbreviateNumber (upval), TweenService (upval)
        local v1 = math.clamp(a1 / a2, 0, 1)
        if ing and ing.Parent then
            local TextLabel = (ing:WaitForChild("Info")):WaitForChild("TextLabel")
            TextLabel.Text = ("%*%%/100%%"):format((AbbreviateNumber((math.round((math.max(v1, 0)) * 100)))))
            TweenService:Create((ing:WaitForChild("Info")):WaitForChild("Bar"), TweenInfo.new(0.2), {Size = UDim2.fromScale(v1, 0.8)}):Play()
            task.wait(0.15)
            if ing and ing.Parent then
                TweenService:Create(
                    (ing:WaitForChild("Info")):WaitForChild("RedBar"),
                    TweenInfo.new(0.2),
                    {Size = UDim2.fromScale(v1, 0.8)}
                ):Play()
            end
            return
        end
    end)
end

local function _AttachBossHPBar(a1, a2, a3, a4) -- Line: 164 -- upvalues: TopGUI (val), HPCTRL (val)
    TopGUI.OpenBossHP(a1, a2)
    TopGUI.UpdateBossHP(a4, a4)
    HPCTRL.ListenHPChanged(a3, function(a1, a2) -- Line: 167 -- upvalues: TopGUI (upval)
        TopGUI.UpdateBossHP(a1, a2)
    end)
end

function u0._CreateBaseEnemy(a1) -- Line: 192
    -- upvalues: UUIDUtils (val), Helper (val), _CreateEnemyModel (val), BehaviorTree_Creater (val), LocalPlayer (val)
    -- upvalues: AnimatorObj (val), ReplicatedStorage (val), _AttachSkillTab (val), HPCTRL (val), TopGUI (val)
    -- upvalues: _AttachNormalHPBar (val), _AttachPercentHPBar (val), u77 (val)
    local EnemyIDAttr = a1.EnemyIDAttr or a1.ModelID
    local OriCF = a1.OriCF
    local UUID = a1.UUID or UUIDUtils.generateAbsoluteID()
    local HP = a1.HP
    local ATK = a1.ATK
    local v1 = a1.IsBoss or false
    local StageID = a1.StageID
    local v2 = Helper.GetDisName(EnemyIDAttr) or ""
    local v3 = _CreateEnemyModel(a1.ModelID, UUID, OriCF)
    v3:SetAttribute("EnemyID", EnemyIDAttr)
    if a1.WithBossFields then
        v3:SetAttribute("IsBoss", v1)
    end
    if a1.WithATKAttribute then
        v3:SetAttribute("ATKType", "Enemy")
        v3:SetAttribute("ATK", ATK)
    end
    local v4 = {}
    local v5 = {}
    v4.BTRunner = BehaviorTree_Creater:Create(a1.BTree)
    v4.BTObj = v5
    v5.Cache = {}
    v5.Model = v3
    v5.HP = HP
    if ATK ~= nil then
        v5.ATK = ATK
    end
    v5.Blackboard = {}
    v5.ID = EnemyIDAttr
    v5.RootPart = v3:WaitForChild("HumanoidRootPart")
    v5.Humanoid = v3:WaitForChild("Humanoid")
    v5.OriCF = OriCF
    if StageID ~= nil then
        v5.StageID = StageID
    end
    if a1.WithLocalPlayer then
        v5.LocalPlayer = LocalPlayer
    end
    if a1.WithBossFields then
        v5.IsBoss = v1
    end
    if a1.WithAnimation then
        v5.AnimObj = AnimatorObj.new(
            ReplicatedStorage.Assets.Animation.Enemy_Action:WaitForChild(EnemyIDAttr),
            (v3:WaitForChild("Humanoid")):WaitForChild("Animator")
        )
    end
    if a1.WithSkills then
        _AttachSkillTab(v5, EnemyIDAttr)
    end
    HPCTRL.RegistEnemyHP(v3, HP)
    local v6 = a1.HPBarMode or "none"
    if v6 == "boss" then
        TopGUI.OpenBossHP(v2, StageID)
        TopGUI.UpdateBossHP(HP, HP)
        HPCTRL.ListenHPChanged(v3, function(a1, a2) -- Line: 167 -- upvalues: TopGUI (upval)
            TopGUI.UpdateBossHP(a1, a2)
        end)
    elseif v6 == "normal" then
        _AttachNormalHPBar(v3, v2)
    elseif v6 == "percent" then
        _AttachPercentHPBar(v3, v2)
    end
    u77[UUID] = v4
    return UUID, v4, v3
end

function u0.HurtEnemy(a1, a2, a3) -- Line: 268 -- upvalues: u77 (val), HitVFXUtils (val), HPCTRL (val)
    local v1 = u77[a1]
    if not v1 or v1.Dead then
        return
    end
    local Model = v1.BTObj.Model
    if Model and Model.Parent then
        if not a3 then
            a3 = {}
        end
        if not a3.Damage then
            a3.Damage = a2
        end
        HitVFXUtils.GetHurtVFX("Enemy", Model, a3)
        return (HPCTRL.DamageOnce(Model, a2))
    end
end

function u0.DeadEnemyData(a1, a2) -- Line: 287
    -- upvalues: u77 (val), HitVFXUtils (val), TopGUI (val), u68 (val), u0 (val)
    if not a1 then
        return
    end
    local v1 = u77[a1]
    if not v1 then
        return
    end
    if v1.Dead then
        return false
    end
    if not a2 then
        a2 = {}
    end
    v1.Dead = true
    local Model = v1.BTObj.Model
    local Pivot = Model:GetPivot()
    Model:SetAttribute("Dead", true)
    if not a2.NotDeadVFX then
        task.spawn(HitVFXUtils.DeadVFX, "Enemy", Model)
    end
    if v1.BTObj.IsBoss then
        TopGUI.CloseBossHP()
    end
    u68:FireServer(a1)
    task.delay(3, u0.DestroyEnemyData, a1)
    return Pivot
end

function u0.DestroyEnemyData(a1) -- Line: 318 -- upvalues: u77 (val), TopGUI (val)
    if not a1 then
        return
    end
    local v1 = u77[a1]
    if not v1 then
        return
    end
    if v1.BTObj.AnimObj then
        v1.BTObj.AnimObj:Destroy()
    end
    if v1.BTObj.Model and v1.BTObj.Model.Parent then
        v1.BTObj.Model:Destroy()
    end
    if v1.BTObj.IsBoss then
        TopGUI.CloseBossHP()
    end
    u77[a1] = nil
end

function u0.IsDead(a1) -- Line: 336 -- upvalues: u77 (val)
    if u77[a1] and not u77[a1].Dead then
        return false
    end
    return true
end

function u0.CreateOneEnemy(a1) -- Line: 347
    -- upvalues: Helper_3 (val), Helper_2 (val), u0 (val), ReplicatedStorage (val)
    local v1, v2
    local EnemyID = a1.EnemyID
    local IsBoss = a1.IsBoss
    local StageID = a1.StageID
    if StageID == -1 then
        local Round = a1.Round
        if not IsBoss then
            v2 = Helper_3.GetRoundMobHP(Round)
            v1 = Helper_3.GetRoundMobATK(Round)
        else
            v2 = Helper_3.GetRoundBossHP(Round)
            v1 = Helper_3.GetRoundBossATK(Round)
        end
    elseif not IsBoss then
        v2 = Helper_2.GetStageMobHP(StageID)
        v1 = Helper_2.GetStageMobATK(StageID)
    else
        v2 = Helper_2.GetStageBossHP(StageID)
        v1 = Helper_2.GetStageBossATK(StageID)
    end
    return u0._CreateBaseEnemy({
        WithSkills = true,
        WithAnimation = true,
        WithLocalPlayer = true,
        WithATKAttribute = true,
        WithBossFields = true,
        ModelID = EnemyID,
        EnemyIDAttr = EnemyID,
        OriCF = a1.OriCF,
        HP = v2,
        ATK = v1,
        IsBoss = IsBoss,
        StageID = StageID,
        BTree = ReplicatedStorage.BTree.Mob_1,
        HPBarMode = if not IsBoss then "normal" else "boss",
    })
end

function u0.CreateOneEnemyShowSkill(a1) -- Line: 391 -- upvalues: u0 (val), ReplicatedStorage (val)
    local EnemyID = a1.EnemyID
    return u0._CreateBaseEnemy({
        HP = 1,
        ATK = 0,
        WithSkills = true,
        WithAnimation = true,
        WithATKAttribute = true,
        HPBarMode = "none",
        ModelID = EnemyID,
        EnemyIDAttr = EnemyID,
        OriCF = a1.OriCF,
        BTree = ReplicatedStorage.BTree.Mob_ShowSkill,
    })
end

function u0.CreateOneSuperLoot(a1) -- Line: 408 -- upvalues: u0 (val), ReplicatedStorage (val)
    return u0._CreateBaseEnemy({
        ModelID = "Super_1",
        EnemyIDAttr = "Super_1",
        WithLocalPlayer = true,
        HPBarMode = "percent",
        OriCF = a1.OriCF,
        UUID = a1.UUID,
        HP = a1.HP,
        StageID = a1.StageID,
        BTree = ReplicatedStorage.BTree.SuperLoot,
    })
end

RunUtils:RegistPreRender(nil, nil, function() -- Line: 428 -- upvalues: u77 (val)
    for i, j in u77 do
        if not j.Dead and j.BTObj.Model and j.BTObj.Model.Parent then
            j.BTRunner:Run(j.BTObj)
        end
    end
end)
return u0
-- Script Path: game:GetService("ReplicatedStorage").CTRL.HPCTRL
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.CTRL.HPCTRL
-- Decompile time: 4.84 ms

local u0 = {}

function u0.RegistPlayerHP(a1, a2, a3) -- Line: 5
    if not a3 then
        a3 = a2
    end
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        HPValue = Instance.new("NumberValue", a1)
        HPValue.Name = "HPValue"
        HPValue.Value = a3
    end
    HPValue:SetAttribute("MaxHP", a2)
end

function u0.RegistEnemyHP(a1, a2, a3) -- Line: 18
    if not a3 then
        a3 = a2
    end
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        HPValue = Instance.new("NumberValue", a1)
        HPValue.Name = "HPValue"
        HPValue.Value = a3
    end
    HPValue:SetAttribute("MaxHP", a2)
end

function u0.ListenHPChanged(a1, a2) -- Line: 31
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        warn("这玩意没有注册血量")
        return nil
    end

    local function Changed() -- Line: 38 -- upvalues: HPValue (val), a2 (val)
        local Value = HPValue.Value
        local Attribute = HPValue:GetAttribute("MaxHP")
        if Value and Attribute then
            a2(Value, Attribute)
            return
        end
    end

    HPValue.Changed:Connect(Changed)
    ;(HPValue:GetAttributeChangedSignal("MaxHP")):Connect(Changed)
    local Value = HPValue.Value
    local Attribute = HPValue:GetAttribute("MaxHP")
    if Value then
        if not Attribute then
            return
        end
        a2(Value, Attribute)
    end
end

function u0.SetCurrentHP(a1, a2) -- Line: 52 -- upvalues: u0 (val)
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        warn("这玩意没有注册血量")
        return nil
    end
    HPValue.Value = math.clamp(a2, 0, (u0.GetMaxHP(a1)))
end

function u0.GetCurrentHP(a1) -- Line: 61
    local HPValue = a1:FindFirstChild("HPValue")
    if HPValue then
        return HPValue.Value
    end
    warn("这玩意没有注册血量")
    return nil
end

function u0.SetMaxHP(a1, a2) -- Line: 70
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        warn("这玩意没有注册血量")
        return nil
    end
    HPValue:SetAttribute("MaxHP", a2)
end

function u0.GetMaxHP(a1) -- Line: 78
    local HPValue = a1:FindFirstChild("HPValue")
    if HPValue then
        return HPValue:GetAttribute("MaxHP")
    end
    warn("这玩意没有注册血量")
    return nil
end

function u0.DamageOnce(a1, a2) -- Line: 88 -- upvalues: u0 (val)
    local v1
    if not a2 then
        return
    end
    if tonumber(a2) == nil then
        a2 = 1
    end
    _, v1 = u0.UpdateHPValue(a1, (u0.GetCurrentHP(a1)) - a2)
    return v1
end

function u0.UpdateMaxHP(a1, a2) -- Line: 102 -- upvalues: u0 (val)
    local v1 = u0.GetMaxHP(a1)
    local v2 = u0.GetCurrentHP(a1) + (a2 - v1)
    u0.SetMaxHP(a1, a2)
    u0.SetCurrentHP(a1, (math.clamp(v2, 1, a2)))
end

function u0.UpdateHPValue(a1, a2) -- Line: 113 -- types: a1: userdata
    local HPValue = a1:FindFirstChild("HPValue")
    if not HPValue then
        warn("这玩意没有注册血量")
        return nil
    end
    local v1 = a2 - HPValue.Value
    HPValue.Value = a2
    return v1, HPValue.Value <= 0
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").CTRL.TrainCTRL
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.CTRL.TrainCTRL
-- Decompile time: 10.82 ms

local u0 = {}
local LocalPlayer = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
game:GetService("RunService")
game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Utils.SoundPlayer)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.VFXSuit)
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)
local CalculateUtils = require(ReplicatedStorage.Utils.CalculateUtils)
local EncodingUtils = require(ReplicatedStorage.Utils.EncodingUtils)
local UIVFXUtils = require(ReplicatedStorage.GuiUtils.UIVFXUtils)
require(ReplicatedStorage.Object.CoolDown)
require(ReplicatedStorage.Object.AnimatorObj)
require(ReplicatedStorage.Config.TrainArea.Helper)
local u81 = CommunicationUtils.TryGetRemoteEvent("Train", "TrainOnceRE")
local u85 = CommunicationUtils.TryGetRemoteEvent("Train", "IntoAutoTrainRE")
local u89 = CommunicationUtils.TryGetRemoteEvent("Train", "ExitAutoTrainRE")
local u93 = CommunicationUtils.TryGetBindableEvent("Attack", "ATKOnceBE")
local u97 = CommunicationUtils.TryGetRemoteFunction("Train", "InvokTrainDataListRF")
local u99 = Trove.new()
local u101 = Trove.new()
local u102 = false
local u103 = false

function u0.StartTrain() -- Line: 42
    -- upvalues: u102 (ref), u99 (val), UserInputService (val), u0 (val), LocalPlayer (val)
    u102 = true
    u99:Add((UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 44 -- upvalues: u0 (upval)
        if a2 then
            return
        end
        if a1.UserInputType == Enum.UserInputType.MouseButton1
            or a1.UserInputType == Enum.UserInputType.Touch
            or a1.KeyCode == Enum.KeyCode.ButtonR2 then
            u0.TrainOnce()
        end
    end)))
    ;(LocalPlayer:GetAttributeChangedSignal("AutoTrainAreaID")):Connect(function() -- Line: 55 -- upvalues: LocalPlayer (upval), u0 (upval)
        if not LocalPlayer:GetAttribute("AutoTrainAreaID") then
            u0.ExitAutoTrain()
            return
        end
        u0.StartAutoTrain()
    end)
end

function u0.EndTrain() -- Line: 65 -- upvalues: u102 (ref), u99 (val), u0 (val)
    u102 = false
    u99:Clean()
    u0.ExitAutoTrain()
end

local u106 = {}

function PopTrainData() -- Line: 72 -- upvalues: u106 (val), u97 (val), EncodingUtils (val)
    if #u106 <= 50 then
        for i, j in (EncodingUtils.DecodeTable((u97:InvokeServer()))) do
            table.insert(u106, j)
        end
    end
    local v1 = u106[1]
    table.remove(u106, 1)
    return v1
end

PopTrainData()

function u0.TrainOnce() -- Line: 86 -- upvalues: LocalPlayer (val), CalculateUtils (val), UIVFXUtils (val), u81 (val)
    local v1
    local v2 = UDim2.fromScale(0.5 + math.random() * 0.6 - 0.3, 0.5 + math.random() * 0.6 - 0.35)
    local Attribute = LocalPlayer:GetAttribute("LastTrainTick")
    if Attribute and tick() - Attribute <= 0.15 then
        return
    end
    LocalPlayer:SetAttribute("LastTrainTick", (tick()))
    local v3 = PopTrainData()
    local UUID = v3.UUID
    local CritValue = v3.CritValue
    local v4 = CalculateUtils.CCTrainOncePower(LocalPlayer)
    if CritValue < CalculateUtils.CCCrit(LocalPlayer) then
        v4 = v4 * 1.5
    end
    UIVFXUtils.ClickTrainOnce(v2, v4, 1, v1)
    u81:FireServer(UUID)
end

function u0.StartAutoTrain() -- Line: 116
    -- upvalues: u103 (ref), LocalPlayer (val), u102 (ref), u0 (val), u85 (val), u101 (val), RunUtils (val), u93 (val)
    -- upvalues: CFrameUtils (val), Lighting (val)
    if u103 then
        return
    end
    local Attribute = LocalPlayer:GetAttribute("AutoTrainAreaID")
    local v1 = ((workspace:WaitForChild("CanAttackFolder")):WaitForChild("TrainArea")):FindFirstChild("Train_" .. Attribute)
    if not v1 then
        return
    end
    u103 = true
    if not u102 then
        u0.StartTrain()
    end
    u85:FireServer(Attribute)
    u101:Clean()
    u101:Add((RunUtils:RegistPreRender(nil, 0.2, function() -- Line: 136 -- upvalues: u103 (upval), u0 (upval), u93 (upval)
        if not u103 then
            return
        end
        u0.TrainOnce()
        u93:Fire()
    end)))
    local DUMMY = v1:FindFirstChild("DUMMY", true)
    if DUMMY then
        local Pivot = DUMMY:GetPivot()
        u101:Add((RunUtils:RegistPreRender(nil, nil, function() -- Line: 147 -- upvalues: u103 (upval), LocalPlayer (upval), CFrameUtils (upval), Pivot (val)
            if not u103 then
                return
            end
            local Character = LocalPlayer.Character
            if not Character then
                return
            end
            Character:PivotTo((CFrameUtils.FaceToCF(Character:GetPivot(), Pivot)))
        end)))
    end
    if not v1:FindFirstChild("ShowHightLight") then
        local v2 = Instance.new("Highlight", v1)
        v2.Name = "ShowHightLight"
        v2.FillTransparency = 1
        v2.OutlineTransparency = 0
        v2.DepthMode = Enum.HighlightDepthMode.Occluded
    end
    local ShowHightLight = v1:FindFirstChild("ShowHightLight")
    ShowHightLight.Enabled = true
    local TrainDOF = Lighting:WaitForChild("TrainDOF")
    TrainDOF.Enabled = true
end

function u0.ExitAutoTrain() -- Line: 167
    -- upvalues: u103 (ref), u101 (val), LocalPlayer (val), u89 (val), Lighting (val)
    local ShowHightLight
    if not u103 then
        return
    end
    u103 = false
    u101:Clean()
    u89:FireServer((LocalPlayer:GetAttribute("AutoTrainAreaID")))
    for i, j in (workspace:WaitForChild("CanAttackFolder")):WaitForChild("TrainArea"):GetChildren() do
        if j:FindFirstChild("ShowHightLight") then
            ShowHightLight = j:FindFirstChild("ShowHightLight")
            ShowHightLight.Enabled = false
        end
    end
    local TrainDOF = Lighting:WaitForChild("TrainDOF")
    TrainDOF.Enabled = false
end

function u0.GetIsTraining() -- Line: 185 -- upvalues: u102 (ref)
    return u102
end

function u0.GetIsAutoing() -- Line: 188 -- upvalues: u103 (ref)
    return u103
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Armor.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Armor.Config
-- Decompile time: 5.76 ms

return {
    LHat_1 = {
        TLevel = "T1",
        Price = 8,
        Rarity = "Common",
        AttributeType = "Power",
        AttriNum = 0.1,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 1.2,
    },
    LHat_2 = {
        TLevel = "T1",
        Price = 14,
        Rarity = "UnCommon",
        AttributeType = "Power",
        AttriNum = 0.15,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 2.6,
    },
    LHat_3 = {
        TLevel = "T1",
        Price = 21,
        Rarity = "UnCommon",
        AttributeType = "Power",
        AttriNum = 0.2,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 5,
    },
    LHat_4 = {
        TLevel = "T1",
        Price = 80,
        Rarity = "Rare",
        AttributeType = "Power",
        AttriNum = 0.2,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 8,
    },
    LHat_5 = {
        TLevel = "T2",
        Price = 120,
        Rarity = "Rare",
        AttributeType = "Power",
        AttriNum = 0.3,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 11,
    },
    LHat_6 = {
        TLevel = "T2",
        Price = 160,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.3,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 15,
    },
    LHat_7 = {
        TLevel = "T2",
        Price = 600,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.35,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 20,
    },
    LHat_8 = {
        TLevel = "T2",
        Price = 900,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.4,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 25,
    },
    LHat_9 = {
        TLevel = "T3",
        Price = 1350,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.4,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 31,
    },
    LHat_10 = {
        TLevel = "T3",
        Price = 5500,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.45,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 36,
    },
    LHat_11 = {
        TLevel = "T3",
        Price = 8200,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.5,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 42,
    },
    LHat_12 = {
        TLevel = "T3",
        Price = 10000,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.55,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 50,
    },
    LHat_13 = {
        TLevel = "T4",
        Price = 14000,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.6,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 58,
    },
    LHat_14 = {
        TLevel = "T4",
        Price = 56000,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.7,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 67,
    },
    LHat_15 = {
        TLevel = "T4",
        Price = 98000,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.75,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 77,
    },
    LHat_16 = {
        TLevel = "T4",
        Price = 140000,
        Rarity = "Eternal",
        AttributeType = "Power",
        AttriNum = 0.85,
        BigType = "Hat",
        Type = "Light",
        DesignPower = 88,
    },
    LArmor_1 = {
        TLevel = "T1",
        Price = 8,
        Rarity = "Common",
        AttributeType = "Defence",
        AttriNum = 0.05,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 1.2,
    },
    LArmor_2 = {
        TLevel = "T1",
        Price = 14,
        Rarity = "UnCommon",
        AttributeType = "Defence",
        AttriNum = 0.055,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 2.6,
    },
    LArmor_3 = {
        TLevel = "T1",
        Price = 21,
        Rarity = "UnCommon",
        AttributeType = "Defence",
        AttriNum = 0.06,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 5,
    },
    LArmor_4 = {
        TLevel = "T1",
        Price = 80,
        Rarity = "Rare",
        AttributeType = "Defence",
        AttriNum = 0.1,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 8,
    },
    LArmor_5 = {
        TLevel = "T2",
        Price = 120,
        Rarity = "Rare",
        AttributeType = "Defence",
        AttriNum = 0.14,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 11,
    },
    LArmor_6 = {
        TLevel = "T2",
        Price = 160,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.2,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 15,
    },
    LArmor_7 = {
        TLevel = "T2",
        Price = 600,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.25,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 20,
    },
    LArmor_8 = {
        TLevel = "T2",
        Price = 900,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.3,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 25,
    },
    LArmor_9 = {
        TLevel = "T3",
        Price = 1350,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.36,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 31,
    },
    LArmor_10 = {
        TLevel = "T3",
        Price = 5500,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.41,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 36,
    },
    LArmor_11 = {
        TLevel = "T3",
        Price = 8200,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.45,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 42,
    },
    LArmor_12 = {
        TLevel = "T3",
        Price = 10000,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.5,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 50,
    },
    LArmor_13 = {
        TLevel = "T4",
        Price = 14000,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.55,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 58,
    },
    LArmor_14 = {
        TLevel = "T4",
        Price = 56000,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.59,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 67,
    },
    LArmor_15 = {
        TLevel = "T4",
        Price = 98000,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.62,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 77,
    },
    LArmor_16 = {
        TLevel = "T4",
        Price = 140000,
        Rarity = "Eternal",
        AttributeType = "Defence",
        AttriNum = 0.65,
        BigType = "Armor",
        Type = "Light",
        DesignPower = 88,
    },
    HHat_1 = {
        TLevel = "T1",
        Price = 10,
        Rarity = "UnCommon",
        AttributeType = "Power",
        AttriNum = 0.12,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 1.2,
    },
    HHat_2 = {
        TLevel = "T1",
        Price = 17,
        Rarity = "UnCommon",
        AttributeType = "Power",
        AttriNum = 0.18,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 2.6,
    },
    HHat_3 = {
        TLevel = "T1",
        Price = 25,
        Rarity = "Rare",
        AttributeType = "Power",
        AttriNum = 0.24,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 5,
    },
    HHat_4 = {
        TLevel = "T2",
        Price = 95,
        Rarity = "Rare",
        AttributeType = "Power",
        AttriNum = 0.24,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 8,
    },
    HHat_5 = {
        TLevel = "T2",
        Price = 142,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.36,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 11,
    },
    HHat_6 = {
        TLevel = "T2",
        Price = 189,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.36,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 15,
    },
    HHat_7 = {
        TLevel = "T3",
        Price = 708,
        Rarity = "Epic",
        AttributeType = "Power",
        AttriNum = 0.42,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 20,
    },
    HHat_8 = {
        TLevel = "T3",
        Price = 1062,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.48,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 25,
    },
    HHat_9 = {
        TLevel = "T3",
        Price = 1593,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.48,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 31,
    },
    HHat_10 = {
        TLevel = "T4",
        Price = 6490,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.54,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 36,
    },
    HHat_11 = {
        TLevel = "T4",
        Price = 9676,
        Rarity = "Legendary",
        AttributeType = "Power",
        AttriNum = 0.59,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 42,
    },
    HHat_12 = {
        TLevel = "T4",
        Price = 11800,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.65,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 50,
    },
    HHat_13 = {
        TLevel = "T4",
        Price = 16520,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.71,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 58,
    },
    HHat_14 = {
        TLevel = "T4",
        Price = 66080,
        Rarity = "Mythic",
        AttributeType = "Power",
        AttriNum = 0.83,
        BigType = "Hat",
        Type = "Heave",
        DesignPower = 67,
    },
    HArmor_1 = {
        TLevel = "T1",
        Price = 10,
        Rarity = "UnCommon",
        AttributeType = "Defence",
        AttriNum = 0.06,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 1.2,
    },
    HArmor_2 = {
        TLevel = "T1",
        Price = 17,
        Rarity = "UnCommon",
        AttributeType = "Defence",
        AttriNum = 0.07,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 2.6,
    },
    HArmor_3 = {
        TLevel = "T1",
        Price = 25,
        Rarity = "Rare",
        AttributeType = "Defence",
        AttriNum = 0.08,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 5,
    },
    HArmor_4 = {
        TLevel = "T2",
        Price = 95,
        Rarity = "Rare",
        AttributeType = "Defence",
        AttriNum = 0.12,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 8,
    },
    HArmor_5 = {
        TLevel = "T2",
        Price = 142,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.17,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 11,
    },
    HArmor_6 = {
        TLevel = "T2",
        Price = 189,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.24,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 15,
    },
    HArmor_7 = {
        TLevel = "T3",
        Price = 708,
        Rarity = "Epic",
        AttributeType = "Defence",
        AttriNum = 0.3,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 20,
    },
    HArmor_8 = {
        TLevel = "T3",
        Price = 1062,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.36,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 25,
    },
    HArmor_9 = {
        TLevel = "T3",
        Price = 1593,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.43,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 31,
    },
    HArmor_10 = {
        TLevel = "T3",
        Price = 6490,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.49,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 36,
    },
    HArmor_11 = {
        TLevel = "T4",
        Price = 9676,
        Rarity = "Legendary",
        AttributeType = "Defence",
        AttriNum = 0.54,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 42,
    },
    HArmor_12 = {
        TLevel = "T4",
        Price = 11800,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.59,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 50,
    },
    HArmor_13 = {
        TLevel = "T4",
        Price = 16520,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.65,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 58,
    },
    HArmor_14 = {
        TLevel = "T4",
        Price = 66080,
        Rarity = "Mythic",
        AttributeType = "Defence",
        AttriNum = 0.7,
        BigType = "Armor",
        Type = "Heave",
        DesignPower = 67,
    },
    HHat_1001 = {
        BestPercent = true,
        MaxAttrNum = 0.83,
        Rarity = "Exclusive",
        AttributeType = "Power",
        AttriNum = 1.4,
        BigType = "Hat",
        Type = "Heave",
    },
    HArmor_1001 = {
        BestPercent = true,
        MaxAttrNum = 0.83,
        Rarity = "Exclusive",
        AttributeType = "Defence",
        AttriNum = 1.4,
        BigType = "Armor",
        Type = "Heave",
    },
    HHat_1002 = {
        BestPercent = true,
        MaxAttrNum = 1.3,
        Rarity = "Exclusive",
        AttributeType = "Power",
        AttriNum = 2.1,
        BigType = "Hat",
        Type = "Heave",
    },
    HArmor_1002 = {
        BestPercent = true,
        MaxAttrNum = 1.3,
        Rarity = "Exclusive",
        AttributeType = "Defence",
        AttriNum = 2.1,
        BigType = "Armor",
        Type = "Heave",
    },
    LHat_1101 = {
        BestPercent = true,
        MaxAttrNum = 1.45,
        Rarity = "Exclusive",
        AttributeType = "Power",
        AttriNum = 1.2,
        BigType = "Hat",
        Type = "Light",
    },
    LArmor_1101 = {
        BestPercent = true,
        MaxAttrNum = 1.45,
        Rarity = "Exclusive",
        AttributeType = "Defence",
        AttriNum = 1.2,
        BigType = "Armor",
        Type = "Light",
    },
    HHat_1101 = {
        BestPercent = true,
        Rarity = "Exclusive",
        AttributeType = "Power",
        AttriNum = 1.85,
        BigType = "Hat",
        Type = "Heave",
    },
    HArmor_1101 = {
        BestPercent = true,
        Rarity = "Exclusive",
        AttributeType = "Defence",
        AttriNum = 1.85,
        BigType = "Armor",
        Type = "Heave",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Armor.ForgePercent
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Armor.ForgePercent
-- Decompile time: 1.26 ms

return {
    [4] = {Hat_Light = 1, Armor_Light = 0, Hat_Heave = 0, Armor_Heave = 0},
    [5] = {Hat_Light = 0.85, Armor_Light = 0.15, Hat_Heave = 0, Armor_Heave = 0},
    [6] = {Hat_Light = 0.7, Armor_Light = 0.3, Hat_Heave = 0, Armor_Heave = 0},
    [7] = {Hat_Light = 0.6, Armor_Light = 0.4, Hat_Heave = 0, Armor_Heave = 0},
    [8] = {Hat_Light = 0.45, Armor_Light = 0.5, Hat_Heave = 0.05, Armor_Heave = 0},
    [9] = {Hat_Light = 0.3, Armor_Light = 0.6, Hat_Heave = 0.1, Armor_Heave = 0},
    [10] = {Hat_Light = 0.15, Armor_Light = 0.7, Hat_Heave = 0.15, Armor_Heave = 0},
    [11] = {Hat_Light = 0, Armor_Light = 0.8, Hat_Heave = 0.2, Armor_Heave = 0},
    [12] = {Hat_Light = 0, Armor_Light = 0.65, Hat_Heave = 0.35, Armor_Heave = 0},
    [13] = {Hat_Light = 0, Armor_Light = 0.45, Hat_Heave = 0.55, Armor_Heave = 0},
    [14] = {Hat_Light = 0, Armor_Light = 0.3, Hat_Heave = 0.65, Armor_Heave = 0.05},
    [15] = {Hat_Light = 0, Armor_Light = 0.1, Hat_Heave = 0.75, Armor_Heave = 0.15},
    [16] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.8, Armor_Heave = 0.2},
    [17] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.7, Armor_Heave = 0.3},
    [18] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.6, Armor_Heave = 0.4},
    [19] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.45, Armor_Heave = 0.55},
    [20] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.3, Armor_Heave = 0.7},
    [21] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.15, Armor_Heave = 0.85},
    [22] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0.05, Armor_Heave = 0.95},
    [23] = {Hat_Light = 0, Armor_Light = 0, Hat_Heave = 0, Armor_Heave = 1},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Armor.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Armor.Helper
-- Decompile time: 6.41 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)
local ForgePercent = require(script.Parent.ForgePercent)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils_2 = require(ReplicatedStorage.Utils.TableUtils)
local u30 = #ForgePercent - TableUtils_2.getTableLegth(ForgePercent) + 1
local u31 = #ForgePercent

function u0.GetConfig() -- Line: 14 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 18 -- upvalues: Show (val)
    return Show
end

function u0.CheckID(a1) -- Line: 22 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

function u0.GetSmallType(a1) -- Line: 29 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Type
    end
end

function u0.GetBigType(a1) -- Line: 34 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].BigType
    end
end

function u0.GetLayout(a1) -- Line: 40 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return (math.round(Config[a1].Price))
    end
end

function u0.GetDisName(a1) -- Line: 46 -- upvalues: Show (val) -- types: a1: string
    if Show[a1] then
        return Show[a1].DisplayName
    end
end

function u0.GetImage(a1) -- Line: 51 -- upvalues: Show (val) -- types: a1: string
    if Show[a1] then
        return Show[a1].Image
    end
end

function u0.GetRarity(a1) -- Line: 56 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return Config[a1].Rarity
    end
end

function u0.GetSellPrice(a1) -- Line: 61 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Price
    end
    return 0
end

function u0.GetTLevel(a1) -- Line: 68 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return Config[a1].TLevel
    end
end

function u0.GetDesignPower(a1) -- Line: 74 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].DesignPower
    end
end

function u0.GetForgePercent() -- Line: 81 -- upvalues: ForgePercent (val)
    return ForgePercent
end

function u0.GetAttributeType(a1) -- Line: 85 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].AttributeType
    end
end

function u0.GetMainAffix(a1) -- Line: 90 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].AttriNum
    end
end

function u0.GetMaxAttrNum(a1) -- Line: 96 -- upvalues: Config (val)
    return Config[a1].MaxAttrNum
end

function u0.GetForgePercentByNumber(a1) -- Line: 100 -- upvalues: u30 (val), u31 (val), ForgePercent (val)
    if a1 < u30 then
        return nil
    end
    if u31 < a1 then
        a1 = u31
    end
    return ForgePercent[a1]
end

local u49 = {}
for i, j in ForgePercent[u30] do
    table.insert(u49, i)
end

function u0.GetForgeTypes() -- Line: 115 -- upvalues: u49 (val)
    return u49
end

function u0.GetForgeArmorsByTLevel(a1, a2, a3) -- Line: 120 -- upvalues: u0 (val) -- types: a1: string, a2: number
    local v1 = a1:split("_")[1]
    local v2 = a1:split("_")[2]
    if not a3 then
        a3 = {}
    end
    local v3 = u0.GetForgeArmorsByForgeType(a1)
    local v4 = {}
    local v5 = a2
    while #v4 == 0 do
        if v5 <= 0 then
            break
        end
        for i, j in v3 do
            if (u0.GetTLevel(j)) == ("T%*"):format(v5) then
                table.insert(v4, j)
            end
        end
        v5 = v5 - 1
    end
    for k, n in v4 do
        if not table.find(a3, n) then
            table.insert(a3, n)
        end
    end
    return a3
end

function u0.GetForgeArmorsByForgeType(a1) -- Line: 149 -- upvalues: Config (val)
    local v1 = a1:split("_")[1]
    local v2 = a1:split("_")[2]
    local v3 = {}
    for i, j in Config do
        if j.BigType == v1 and j.Type == v2 and j.TLevel then
            table.insert(v3, i)
        end
    end
    return v3
end

function u0.CheckIsBestPercent(a1) -- Line: 160 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].BestPercent
    end
    return false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Armor.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Armor.Show
-- Decompile time: 3.00 ms

return {
    Hat = {DisplayName = "Helmet"},
    Armor = {DisplayName = "Armor"},
    Hat_Light = {DisplayName = "Light Helmet"},
    Hat_Heave = {DisplayName = "Heavy Helmet"},
    Armor_Light = {DisplayName = "Light Armor"},
    Armor_Heave = {DisplayName = "Heavy Armor"},
    LHat_1 = {Image = "rbxassetid://83266682783742", DisplayName = "Spartan Helm"},
    LHat_2 = {Image = "rbxassetid://134216034666018", DisplayName = "Black Iron Helmet"},
    LHat_3 = {Image = "rbxassetid://100454533797224", DisplayName = "Gladiator Helmet"},
    LHat_4 = {Image = "rbxassetid://89108992127645", DisplayName = "Bronze Helm"},
    LHat_5 = {Image = "rbxassetid://92995606887849", DisplayName = "Iron Cap"},
    LHat_6 = {Image = "rbxassetid://127217010453725", DisplayName = "Gold Helm"},
    LHat_7 = {Image = "rbxassetid://89264298125891", DisplayName = "Golden Ronin Helm"},
    LHat_8 = {Image = "rbxassetid://80425552528288", DisplayName = "Samurai"},
    LHat_9 = {Image = "rbxassetid://85138869382769", DisplayName = "Shadow Shogun Helm"},
    LHat_10 = {Image = "rbxassetid://117491970711638", DisplayName = "Silver Knight Helmet"},
    LHat_11 = {Image = "rbxassetid://118764898683862", DisplayName = "Warden Helm"},
    LHat_12 = {Image = "rbxassetid://88743720280479", DisplayName = "Auric Valkyrie"},
    LHat_13 = {Image = "rbxassetid://123379085384918", DisplayName = "Nether Fiend"},
    LHat_14 = {Image = "rbxassetid://119166627270362", DisplayName = "Grove Warden"},
    LHat_15 = {Image = "rbxassetid://105914762213604", DisplayName = "Voidstar Greathelm"},
    LHat_16 = {Image = "rbxassetid://89443246344094", DisplayName = "Gilded Titan Horns"},
    LArmor_1 = {Image = "rbxassetid://92142489111263", DisplayName = "Arena Rig"},
    LArmor_2 = {Image = "rbxassetid://127719657411082", DisplayName = "Black War Armor"},
    LArmor_3 = {Image = "rbxassetid://85701371370582", DisplayName = "Gladiator Armor"},
    LArmor_4 = {Image = "rbxassetid://136525942244858", DisplayName = "Templar Vest"},
    LArmor_5 = {Image = "rbxassetid://102103912862909", DisplayName = "Footsoldier"},
    LArmor_6 = {Image = "rbxassetid://140287803083976", DisplayName = "Runic Mail"},
    LArmor_7 = {Image = "rbxassetid://115882344882049", DisplayName = "Golden Ronin Armor"},
    LArmor_8 = {Image = "rbxassetid://74691049560340", DisplayName = "Crimson Do"},
    LArmor_9 = {Image = "rbxassetid://107064983353523", DisplayName = "Shadow Shogun Armor"},
    LArmor_10 = {Image = "rbxassetid://92505089143562", DisplayName = "Silver Knight Armor"},
    LArmor_11 = {Image = "rbxassetid://80525947652259", DisplayName = "Warden Armor"},
    LArmor_12 = {Image = "rbxassetid://96940412165473", DisplayName = "Celestial Platemail"},
    LArmor_13 = {Image = "rbxassetid://86012476775298", DisplayName = "Magma Carapace"},
    LArmor_14 = {Image = "rbxassetid://137716996719556", DisplayName = "Verdant Bark"},
    LArmor_15 = {Image = "rbxassetid://137695353955217", DisplayName = "Cosmic Rift Plate"},
    LArmor_16 = {Image = "rbxassetid://93029174578802", DisplayName = "Warlord’s Golden Cuirass"},
    HHat_1 = {Image = "rbxassetid://91441463909022", DisplayName = "Spike Helm"},
    HHat_2 = {Image = "rbxassetid://87887100900146", DisplayName = "Ponytail Helmet"},
    HHat_3 = {Image = "rbxassetid://87802515903137", DisplayName = "Lion Helmet"},
    HHat_4 = {Image = "rbxassetid://121471758814599", DisplayName = "Gilded Crown"},
    HHat_5 = {Image = "rbxassetid://104843503483072", DisplayName = "Demon Horn"},
    HHat_6 = {Image = "rbxassetid://128873808678752", DisplayName = "Royal Crest"},
    HHat_7 = {Image = "rbxassetid://95528458238108", DisplayName = "Void Horn"},
    HHat_8 = {Image = "rbxassetid://132988235900561", DisplayName = "Cyber-Unit Helm"},
    HHat_9 = {Image = "rbxassetid://91717891728610", DisplayName = "Rift Lord Visage"},
    HHat_10 = {Image = "rbxassetid://114155220239866", DisplayName = "Radiance Helm"},
    HHat_11 = {Image = "rbxassetid://136515182147036", DisplayName = "Sunwing Helm"},
    HHat_12 = {Image = "rbxassetid://108681147286187", DisplayName = "Infernal Helm"},
    HHat_13 = {Image = "rbxassetid://126180889559298", DisplayName = "Primeval Cobalt"},
    HHat_14 = {Image = "rbxassetid://137454383158599", DisplayName = "Hex-Weave Phantom"},
    HArmor_1 = {Image = "rbxassetid://91327005429856", DisplayName = "Iron Ward"},
    HArmor_2 = {Image = "rbxassetid://73210781179750", DisplayName = "Cross Iron Armor"},
    HArmor_3 = {Image = "rbxassetid://91403123942805", DisplayName = "Lion Iron Armor"},
    HArmor_4 = {Image = "rbxassetid://123278459627124", DisplayName = "Shadow Plate"},
    HArmor_5 = {Image = "rbxassetid://138646480162548", DisplayName = "Abyssal"},
    HArmor_6 = {Image = "rbxassetid://92994481226829", DisplayName = "Azure Armor"},
    HArmor_7 = {Image = "rbxassetid://73340315303821", DisplayName = "Dark Core"},
    HArmor_8 = {Image = "rbxassetid://94225151108097", DisplayName = "Apex Plating"},
    HArmor_9 = {Image = "rbxassetid://79935668647241", DisplayName = "Overlord Carapace"},
    HArmor_10 = {Image = "rbxassetid://102570874949867", DisplayName = "Glory Plate"},
    HArmor_11 = {Image = "rbxassetid://132311443929145", DisplayName = "Solar Plate"},
    HArmor_12 = {Image = "rbxassetid://79641136216481", DisplayName = "Cinder Plate"},
    HArmor_13 = {Image = "rbxassetid://77449139566382", DisplayName = "Galactic Void-Walker"},
    HArmor_14 = {Image = "rbxassetid://72173886156545", DisplayName = "Defiled Runeblade"},
    HHat_1001 = {Image = "rbxassetid://72214832847967", DisplayName = "Cursed Void"},
    HArmor_1001 = {Image = "rbxassetid://84480991849926", DisplayName = "Void Overlord"},
    HHat_1002 = {Image = "rbxassetid://77577134274226", DisplayName = "Astral Sovereign Crown"},
    HArmor_1002 = {Image = "rbxassetid://121397142667789", DisplayName = "Astral Devourer Plate"},
    LHat_1101 = {Image = "rbxassetid://75469485365339", DisplayName = "Spectre"},
    LArmor_1101 = {Image = "rbxassetid://137271160766267", DisplayName = "Cataclysm"},
    HHat_1101 = {Image = "rbxassetid://102556982113270", DisplayName = "War's Horn"},
    HArmor_1101 = {Image = "rbxassetid://136316140881848", DisplayName = "Apocalypse"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Buff.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Buff.Config
-- Decompile time: 0.32 ms

return {
    Coin_1 = {Boost = 1, BoostType = "Coin"},
    Train_1 = {Boost = 1, BoostType = "Train"},
    Luck_1 = {Boost = 1, BoostType = "Luck"},
    Damage_1 = {Boost = 1, BoostType = "Damage"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Buff.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Buff.Helper
-- Decompile time: 1.91 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)

function u0.GetConfig() -- Line: 6 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 10 -- upvalues: Show (val)
    return Show
end

function u0.CheckID(a1) -- Line: 14 -- upvalues: Config (val), Show (val)
    return Config[a1] and Show[a1]
end

function u0.GetPrice(a1) -- Line: 18 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Price
    end
    return nil
end

function u0.GetRarity(a1) -- Line: 24 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Rarity
    end
    return nil
end

function u0.GetImage(a1) -- Line: 31 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].Image
    end
    return nil
end

function u0.GetDisName(a1) -- Line: 37 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].DisplayName
    end
    return nil
end

function u0.GetDesc(a1) -- Line: 43 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].Description
    end
    return nil
end

function u0.GetBoost(a1) -- Line: 50 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Boost
    end
    return nil
end

function u0.GetBoostType(a1) -- Line: 57 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].BoostType
    end
    return nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Buff.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Buff.Show
-- Decompile time: 0.42 ms

return {
    Coin_1 = {DisplayName = "Coin Boost", Image = "rbxassetid://121177986783156", Description = "+100% Coin"},
    Train_1 = {DisplayName = "Train Boost", Image = "rbxassetid://72674892359014", Description = "+100% Train"},
    Luck_1 = {DisplayName = "Luck Boost", Image = "rbxassetid://111240558888066", Description = "+100% Luck"},
    Damage_1 = {DisplayName = "Damage Boost", Image = "rbxassetid://83222372705220", Description = "+100% Damage"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Class.Boost
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Class.Boost
-- Decompile time: 1.31 ms

return {
    Class_1 = {{}, {Train = 0.04}, {Train = 0.07}},
    Class_2 = {{WalkSpeed = 0.08}, {WalkSpeed = 0.1, Train = 0.04}, {WalkSpeed = 0.12, Train = 0.08}},
    Class_3 = {{Crit = 0.03}, {Crit = 0.05, Damage = 0.04}, {Crit = 0.07, Damage = 0.07}},
    Class_4 = {{Defence = 0.09, Luck = 0.1}, {Defence = 0.13, Luck = 0.15}, {Defence = 0.18, Luck = 0.2}},
    Class_5 = {{SkillCD = 0.06, Damage = 0.06}, {SkillCD = 0.1, Damage = 0.09}, {SkillCD = 0.14, Damage = 0.14}},
    Class_6 = {
        {Train = 0.08, SkillDamage = 0.1, Crit = 0.05},
        {Train = 0.14, SkillDamage = 0.15, Crit = 0.08},
        {Train = 0.19, SkillDamage = 0.2, Crit = 0.12},
    },
    Class_7 = {
        {WalkSpeed = 0.12, SkillCD = 0.1, Luck = 0.12},
        {WalkSpeed = 0.18, SkillCD = 0.1, Luck = 0.15},
        {WalkSpeed = 0.22, SkillCD = 0.18, Luck = 0.2},
    },
    Class_8 = {
        {
            WalkSpeed = 0.2,
            Train = 0.15,
            SkillDamage = 0.18,
            Crit = 0.15,
            Luck = 0.2,
            SkillCD = 0.15,
        },
        {
            WalkSpeed = 0.3,
            Train = 0.22,
            SkillDamage = 0.28,
            Crit = 0.25,
            Luck = 0.3,
            SkillCD = 0.2,
        },
        {
            WalkSpeed = 0.4,
            Train = 0.26,
            SkillDamage = 0.32,
            Crit = 0.29,
            Luck = 0.4,
            SkillCD = 0.28,
        },
    },
    Class_9 = {
        {
            WalkSpeed = 0.25,
            Train = 0.2,
            SkillDamage = 0.2,
            Crit = 0.18,
            Defence = 0.23,
            SkillCD = 0.18,
        },
        {
            WalkSpeed = 0.35,
            Train = 0.27,
            SkillDamage = 0.3,
            Crit = 0.28,
            Defence = 0.33,
            SkillCD = 0.22,
        },
        {
            WalkSpeed = 0.45,
            Train = 0.31,
            SkillDamage = 0.34,
            Crit = 0.33,
            Defence = 0.4,
            SkillCD = 0.28,
        },
    },
}
 -- Script Path: game:GetService("ReplicatedStorage").Config.Class.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Class.Config
-- Decompile time: 0.58 ms

return {
    Class_1 = {Weight = 266, Rarity = "Common", Layout = 1},
    Class_2 = {Weight = 253, Rarity = "UnCommon", Layout = 2},
    Class_3 = {Weight = 242, Rarity = "UnCommon", Layout = 3},
    Class_4 = {Weight = 125, Rarity = "Rare", Layout = 4},
    Class_5 = {Weight = 55, Rarity = "Epic", Layout = 5},
    Class_6 = {Weight = 23, Rarity = "Legendary", Layout = 6},
    Class_7 = {Weight = 15, Rarity = "Legendary", Layout = 7},
    Class_8 = {Weight = 4, Rarity = "Mythic", Layout = 8},
    Class_9 = {Weight = 2, Rarity = "Mythic", Layout = 9},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Class.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Class.Helper
-- Decompile time: 3.30 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)
local Boost = require(script.Parent.Boost)

function u0.GetConfig() -- Line: 7 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 11 -- upvalues: Show (val)
    return Show
end

function u0.GetTotalWeight() -- Line: 15 -- upvalues: Config (val)
    local v1 = 0
    for i, j in Config do
        v1 = v1 + j.Weight
    end
    return v1
end

function u0.GetWeightTable() -- Line: 23 -- upvalues: Config (val)
    local v1 = {}
    for i, j in Config do
        v1[i] = j.Weight
    end
    return v1
end

function u0.GetWeight(a1) -- Line: 31 -- upvalues: Config (val)
    if not Config[a1] then
        return nil
    end
    return Config[a1].Weight
end

function u0.GetClassChance(a1) -- Line: 38 -- upvalues: u0 (val)
    local v1 = u0.GetWeight(a1)
    if not v1 then
        return nil
    end
    return v1 / u0.GetTotalWeight()
end

function u0.GetClassBoosts(a1, a2) -- Line: 47 -- upvalues: Boost (val)
    return Boost[a1][a2]
end

function u0.CheckID(a1) -- Line: 51 -- upvalues: Config (val), Show (val)
    return Config[a1] and Show[a1]
end

function u0.GetRarity(a1) -- Line: 54 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Rarity
    end
    return nil
end

function u0.GetBoostShowText(a1) -- Line: 61
    if a1 == "Train" then
        return "Train Boost +"
    end
    if a1 == "SkillCD" then
        return "Skill CD -"
    end
    if a1 == "Defence" then
        return "Defence +"
    end
    if a1 == "SkillDamage" then
        return "Skill Damage +"
    end
    if a1 == "WalkSpeed" then
        return "Move Speed +"
    end
    if a1 == "Luck" then
        return "Luck +"
    end
    if a1 == "Crit" then
        return "Crit Rate +"
    end
    if a1 == "Damage" then
        return "Damage +"
    end
end

function u0.GetDescription(a1) -- Line: 87 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].Description
    end
    return nil
end

function u0.GetDisName(a1) -- Line: 93 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].DisplayName
    end
    return nil
end

function u0.GetLayout(a1) -- Line: 99 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Layout
    end
    return nil
end

function u0.GetFaces(a1) -- Line: 106 -- upvalues: u0 (val), Show (val)
    if not u0.CheckID(a1) then
        return {"rbxassetid://112567831276622"}
    end
    return Show[a1].Faces or {"rbxassetid://112567831276622"}
end

function u0.GetBodyColor(a1) -- Line: 113 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].BodyColor
    end
    return nil
end

function u0.GetUnlockText(a1) -- Line: 120
    if a1 == "1" then
        return ""
    end
    if a1 == "2" then
        return "Rebirth 4+"
    end
    if a1 == "3" then
        return "Sign Day 7+"
    end
    if a1 == "4" then
        return "Extra Slot 1"
    end
    if a1 == "5" then
        return "Extra Slot 2"
    end
    if a1 == "6" then
        return "Extra Slot 3"
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Class.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Class.Show
-- Decompile time: 0.72 ms

return {
    Class_1 = {DisplayName = "Human", Description = "The human hero, the origin of every legend."},
    Class_2 = {
        DisplayName = "Goblin",
        Description = "An ordinary goblin who loves warm campfires and shiny treasure.",
        BodyColor = Color3.fromRGB(72, 100, 57),
    },
    Class_3 = {DisplayName = "Skeleton", Description = "Freshly unearthed; handle with care."},
    Class_4 = {
        DisplayName = "Yeti",
        Description = "The legendary yeti, roaming through howling blizzards.",
        BodyColor = Color3.fromRGB(130, 147, 180),
    },
    Class_5 = {
        DisplayName = "Vampire",
        Description = "An immortal creature of the night, sustaining its power through blood.",
    },
    Class_6 = {
        DisplayName = "Dragonkin",
        Description = "An ancient and proud descendant of the elder age, with primal power coursing through its bloodline.",
    },
    Class_7 = {
        DisplayName = "Void‑Elf",
        Description = "An elven offshoot steeped in the Void, who unexpectedly came to command the magic of shadow and void.",
    },
    Class_8 = {
        DisplayName = "Demon",
        Description = "A being born from the abyss of chaos, beguiling hearts and sowing discord.",
    },
    Class_9 = {
        DisplayName = "Angel",
        Description = "A radiant creation from the highest realm, bearing the duty of order and protection.",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Debuff.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Debuff.Config
-- Decompile time: 1.22 ms

local v1, v2, v3
local v4 = {Hellfire_1 = {}}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        v1 = require(j)
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            for m, i5 in n do
                v4[k][m] = i5
            end
        end
    end
end
return v4
-- Script Path: game:GetService("ReplicatedStorage").Config.Debuff.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Debuff.Helper
-- Decompile time: 0.65 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.CheckID(a1) -- Line: 5 -- upvalues: Config (val)
    return Config[a1]
end

function v1.GetConfig(a1) -- Line: 9 -- upvalues: Config (val)
    return Config[a1]
end

function v1.GetDebuffConfig(a1) -- Line: 13 -- upvalues: Config (val)
    return Config[a1]
end

function v1.GetDebuffConfigByTypeLevel(a1, a2) -- Line: 17 -- upvalues: Config (val)
    return Config[("%*_%*"):format(a1, a2)]
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.Config
-- Decompile time: 4.24 ms

local v1, v2, v3, v4
local v5 = {
    {Enemy_1 = {Number = 4}},
    {Enemy_1 = {Number = 5}},
    {Enemy_2 = {Number = 3}},
    {Enemy_2 = {Number = 3}},
    {Boss_1 = {Number = 1, IsBoss = true}, Enemy_3 = {Number = 4}},
    {Enemy_3 = {Number = 4}},
    {Enemy_4 = {Number = 4}},
    {Enemy_4 = {Number = 4}},
    {Enemy_5 = {Number = 4}},
    {Boss_1 = {Number = 1, IsBoss = true}, Enemy_5 = {Number = 4}},
    {Enemy_8 = {Number = 5}},
    {Enemy_8 = {Number = 5}},
    {Enemy_6 = {Number = 4}},
    {Enemy_6 = {Number = 4}},
    {Boss_2 = {Number = 1, IsBoss = true}, Enemy_6 = {Number = 4}},
    {Enemy_7 = {Number = 5}},
    {Enemy_7 = {Number = 5}},
    {Enemy_9 = {Number = 4}},
    {Enemy_9 = {Number = 4}},
    {Boss_3 = {Number = 1, IsBoss = true}, Enemy_10 = {Number = 4}},
    {Enemy_10 = {Number = 5}},
    {Enemy_11 = {Number = 5}},
    {Enemy_11 = {Number = 4}},
    {Enemy_12 = {Number = 4}},
    {Boss_4 = {Number = 1, IsBoss = true}, Enemy_12 = {Number = 4}},
    {Enemy_13 = {Number = 5}},
    {Enemy_13 = {Number = 5}},
    {Enemy_14 = {Number = 5}},
    {Enemy_14 = {Number = 5}},
    {Boss_5 = {Number = 1, IsBoss = true}, Enemy_15 = {Number = 5}},
    {Enemy_15 = {Number = 5}},
    {Enemy_15 = {Number = 5}},
    {Enemy_16 = {Number = 5}},
    {Enemy_16 = {Number = 5}},
    {Boss_5 = {Number = 1, IsBoss = true}, Enemy_17 = {Number = 5}},
    {Enemy_17 = {Number = 5}},
    {Enemy_17 = {Number = 5}},
    {Enemy_18 = {Number = 5}},
    {Enemy_18 = {Number = 5}},
    {Boss_6 = {Number = 1, IsBoss = true}, Enemy_18 = {Number = 5}},
    {Enemy_1 = {Number = 2}, Enemy_3 = {Number = 3}},
    {Enemy_2 = {Number = 5}},
    {Enemy_1 = {Number = 1}, Enemy_2 = {Number = 2}, Enemy_3 = {Number = 2}},
    {Enemy_3 = {Number = 5}},
    {Boss_1 = {Number = 1, IsBoss = true}, Enemy_3 = {Number = 5}},
    {Enemy_4 = {Number = 5}},
    {Enemy_5 = {Number = 5}},
    {Enemy_8 = {Number = 5}},
    {Enemy_4 = {Number = 1}, Enemy_5 = {Number = 2}, Enemy_8 = {Number = 2}},
    {Boss_2 = {Number = 1, IsBoss = true}, Enemy_8 = {Number = 5}},
}
local v6 = nil
local v7 = nil
for i, j in v5, v6, v7 do
    if not j.EnemyTab then
        v1 = {}
        for k, n in j do
            v1[k] = n
        end
        v5[i] = {EnemyTab = v1}
    end
end
for m, i5 in script:GetChildren() do
    if i5:IsA("ModuleScript") then
        v2 = require(i5)
        v3 = nil
        v4 = nil
        for i6, i7 in v2, v3, v4 do
            for i8, i9 in i7 do
                v5[i6][i8] = i9
            end
        end
    end
end
return v5
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.Config.EnemyHP
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.Config.EnemyHP
-- Decompile time: 1.40 ms

return {
    {MobHP = 113000},
    {MobHP = 500000},
    {MobHP = 4000000},
    {MobHP = 20000000},
    {MobHP = 100000000, BossHP = 250000000},
    {MobHP = 500000000},
    {MobHP = 2000000000},
    {MobHP = 15000000000},
    {MobHP = 40000000000},
    {MobHP = 320000000000, BossHP = 120000000000},
    {MobHP = 3000000000000},
    {MobHP = 15000000000000},
    {MobHP = 85000000000000},
    {MobHP = 450000000000000},
    {MobHP = 1.6e+15, BossHP = 9e+15},
    {MobHP = 1e+16},
    {MobHP = 8.4e+16},
    {MobHP = 3.75e+17},
    {MobHP = 6.25e+17},
    {MobHP = 1.12e+18, BossHP = 1e+19},
    {MobHP = 4.16e+18},
    {MobHP = 2.02e+19},
    {MobHP = 7.62e+18},
    {MobHP = 1.03e+19},
    {MobHP = 1.25e+19, BossHP = 6e+19},
    {MobHP = 3e+19},
    {MobHP = 7.58e+19},
    {MobHP = 2.25e+20},
    {MobHP = 6.6e+20},
    {MobHP = 1.5e+21, BossHP = 1.5e+22},
    {MobHP = 6e+21},
    {MobHP = 1.75e+22},
    {MobHP = 5.22e+22},
    {MobHP = 1.96e+23},
    {MobHP = 5e+23, BossHP = 2.35e+24},
    {MobHP = 1.6e+24},
    {MobHP = 5.2e+24},
    {MobHP = 1.64e+25},
    {MobHP = 4.8e+25},
    {MobHP = 1.99e+26, BossHP = 1e+27},
    {MobHP = 5.5e+26},
    {MobHP = 1.27e+27},
    {MobHP = 3.8e+27},
    {MobHP = 1.11e+28},
    {MobHP = 4.33e+28, BossHP = 1.72e+29},
    {MobHP = 1.09e+29},
    {MobHP = 3.2e+29},
    {MobHP = 1e+30},
    {MobHP = 3.6e+30},
    {MobHP = 1.25e+31, BossHP = 7.75e+31},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.Config.ForceLootTab
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.Config.ForceLootTab
-- Decompile time: 0.62 ms

return {
    [5] = {ForceTab = {Loot_16 = 1}},
    [10] = {ForceTab = {Loot_16 = 1}},
    [15] = {ForceTab = {Loot_17 = 1}},
    [20] = {ForceTab = {Loot_17 = 1}},
    [25] = {ForceTab = {Loot_18 = 1}},
    [30] = {ForceTab = {Loot_18 = 1}},
    [35] = {ForceTab = {Loot_18 = 1}},
    [40] = {ForceTab = {Loot_18 = 1}},
    [45] = {ForceTab = {Loot_18 = 1}},
    [50] = {ForceTab = {Loot_18 = 1}},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.Config.LootTab
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.Config.LootTab
-- Decompile time: 1.92 ms

return {
    {LootTab = "Loot_1,Loot_2,Loot_3", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_2,Loot_3,Loot_4", Chance = "9400,500,50", LootNumber = 4},
    {LootTab = "Loot_2,Loot_3,Loot_4", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_3,Loot_4,Loot_5", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_3,Loot_4,Loot_5", Chance = "9400,500,100", LootNumber = 6},
    {LootTab = "Loot_4,Loot_5,Loot_6", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_4,Loot_5,Loot_6", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 6},
    {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 4},
    {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_10,Loot_11", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_10,Loot_11", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_11,Loot_12", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_11,Loot_12", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_12,Loot_13", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_12,Loot_13", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_13,Loot_14", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_13,Loot_14", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_14,Loot_15", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_14,Loot_15", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_14,Loot_15", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_15,Loot_19", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_15,Loot_19", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_15,Loot_19", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_15,Loot_19", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_19,Loot_20", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_19,Loot_20", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_19,Loot_20", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_20,Loot_21", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_20,Loot_21", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_20,Loot_21", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_20,Loot_21", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_20,Loot_21", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_21,Loot_22", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_21,Loot_22", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_21,Loot_22", Chance = "9900,100", LootNumber = 6},
    {LootTab = "Loot_21,Loot_22", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_22,Loot_23", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_22,Loot_23", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_22,Loot_23", Chance = "9900,100", LootNumber = 4},
    {LootTab = "Loot_22,Loot_23", Chance = "9900,100", LootNumber = 6},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.Helper
-- Decompile time: 6.58 ms

local v1 = {}
local Config = require(script.Parent.Config)
local LootConfig = require(script.Parent.LootConfig)

local function SplitStrTab(a1) -- Line: 7
    local v1 = {}
    for i, j in (a1:split(",")) do
        if not tonumber(j) then
            table.insert(v1, j)
        else
            table.insert(v1, (tonumber(j)))
        end
    end
    return v1
end

function v1.GetConfig() -- Line: 21 -- upvalues: Config (val)
    return Config
end

function v1.GetLootConfig() -- Line: 25 -- upvalues: LootConfig (val)
    return LootConfig
end

function v1.GetLootIDWeightTab(a1) -- Line: 31 -- upvalues: SplitStrTab (val), Config (val)
    local v1 = SplitStrTab(Config[a1].LootTab)
    local v2 = SplitStrTab(Config[a1].Chance)
    local v3 = {}
    for i, j in v1 do
        if v2[i] then
            v3[j] = v2[i]
        end
    end
    return v3
end

function v1.GetLootIDNumber(a1) -- Line: 45 -- upvalues: Config (val)
    return Config[a1].LootNumber
end

function v1.GetForceTab(a1) -- Line: 50 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].ForceTab
    end
end

function v1.GetLootRewardWeightTab(a1) -- Line: 57 -- upvalues: SplitStrTab (val), LootConfig (val)
    local v1 = SplitStrTab(LootConfig[a1].RewardTab)
    local v2 = SplitStrTab(LootConfig[a1].Chance)
    local v3 = {}
    for i, j in v1 do
        if v2[i] then
            v3[j] = v2[i]
        end
    end
    return v3
end

function v1.GetLootRewardNumber(a1, a2) -- Line: 70 -- upvalues: SplitStrTab (val), LootConfig (val)
    local v1 = SplitStrTab(LootConfig[a1].RewardTab)
    local v2 = SplitStrTab(LootConfig[a1].NumberCount)
    local v3 = nil
    for i, j in v1 do
        if a2 == j then
            v3 = i
            break
        end
    end
    if v3 then
        return v2[v3] or 1
    end
    warn("???")
    return nil
end

function v1.GetRoundMobHP(a1) -- Line: 89 -- upvalues: Config (val)
    return Config[a1].MobHP
end

function v1.GetRoundBossHP(a1) -- Line: 92 -- upvalues: Config (val)
    return Config[a1].BossHP
end

function v1.GetRoundMobATK(a1) -- Line: 95
    return 7
end

function v1.GetRoundBossATK(a1) -- Line: 98
    return 20
end

function v1.GetRoundEnemyTab(a1) -- Line: 102 -- upvalues: Config (val)
    return Config[a1].EnemyTab
end

function v1.GetLootEnhantStoneChance(a1) -- Line: 106 -- upvalues: LootConfig (val)
    if LootConfig[a1] then
        return LootConfig[a1].EnhantStoneChance
    end
end

function v1.GetLootEnhantStoneRange(a1) -- Line: 111 -- upvalues: LootConfig (val)
    if not LootConfig[a1] then
        return
    end
    local EnhantStoneRange = LootConfig[a1].EnhantStoneRange
    if not EnhantStoneRange then
        return
    end
    local v1 = EnhantStoneRange:split(",")
    return (tonumber(v1[1])), (tonumber(v1[2]))
end

function v1.GetLootEnhantStone2Chance(a1) -- Line: 125 -- upvalues: LootConfig (val)
    if LootConfig[a1] then
        return LootConfig[a1].EnhantStone_2Chance
    end
end

function v1.GetLootEnhantStone2Range(a1) -- Line: 130 -- upvalues: LootConfig (val)
    if not LootConfig[a1] then
        return
    end
    local EnhantStone_2Range = LootConfig[a1].EnhantStone_2Range
    if not EnhantStone_2Range then
        return
    end
    local v1 = EnhantStone_2Range:split(",")
    return (tonumber(v1[1])), (tonumber(v1[2]))
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Dungeon.LootConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Dungeon.LootConfig
-- Decompile time: 1.44 ms

return {
    Loot_1 = {
        RewardTab = "Coin,Ore_18,Ore_19,Ore_20,Ore_21,Thunder_1,Poison_1,Ice_1,Fire_1",
        NumberCount = "200,1,1,1,1,1,1,1,1",
        Chance = "4500,190,190,190,190,80,80,80,80",
        EnhantStoneChance = 0.03,
        EnhantStoneRange = "5,15",
    },
    Loot_2 = {
        RewardTab = "Coin,Ore_18,Ore_19,Ore_20,Ore_21,Thunder_1,Poison_1,Ice_1,Fire_1",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4600,170,210,210,170,120,120,120,120",
        EnhantStoneChance = 0.03,
        EnhantStoneRange = "5,15",
    },
    Loot_3 = {
        RewardTab = "Coin,Ore_18,Ore_19,Ore_20,Ore_21,Thunder_1,Poison_1,Ice_1,Fire_1",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4600,100,190,220,230,160,160,160,160",
        EnhantStoneChance = 0.03,
        EnhantStoneRange = "5,15",
    },
    Loot_4 = {
        RewardTab = "Coin,Ore_20,Ore_22,Ore_24,Ore_25,Thunder_1,Poison_1,Ice_1,Fire_1",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4000,200,200,220,200,200,200,200,200",
        EnhantStoneChance = 0.04,
        EnhantStoneRange = "5,15",
    },
    Loot_5 = {
        RewardTab = "Coin,Ore_25,Ore_26,Ore_27,Ore_28,Thunder_1,Poison_1,Ice_1,Fire_1",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4000,170,200,220,230,230,230,230,230",
        EnhantStoneChance = 0.04,
        EnhantStoneRange = "5,15",
    },
    Loot_6 = {
        RewardTab = "Coin,Ore_25,Ore_26,Ore_27,Ore_28,Thunder_2,Poison_2,Ice_2,Fire_2",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4500,190,190,190,190,80,80,80,80",
        EnhantStoneChance = 0.05,
        EnhantStoneRange = "5,15",
    },
    Loot_7 = {
        RewardTab = "Coin,Ore_26,Ore_27,Ore_28,Ore_29,Thunder_2,Poison_2,Ice_2,Fire_2",
        NumberCount = "500,1,1,1,1,1,1,1,1",
        Chance = "4600,170,210,210,170,120,120,120,120",
        EnhantStoneChance = 0.05,
        EnhantStoneRange = "5,15",
    },
    Loot_8 = {
        RewardTab = "Coin,Ore_27,Ore_28,Ore_29,Ore_30,Thunder_2,Poison_2,Ice_2,Fire_2",
        NumberCount = "600,1,1,1,1,1,1,1,1",
        Chance = "4600,100,190,220,230,160,160,160,160",
        EnhantStoneChance = 0.06,
        EnhantStoneRange = "5,15",
    },
    Loot_9 = {
        RewardTab = "Coin,Ore_28,Ore_29,Ore_30,Ore_31,Thunder_2,Poison_2,Ice_2,Fire_2",
        NumberCount = "700,1,1,1,1,1,1,1,1",
        Chance = "4000,200,200,220,200,200,200,200,200",
        EnhantStoneChance = 0.06,
        EnhantStoneRange = "15,25",
    },
    Loot_10 = {
        RewardTab = "Coin,Ore_28,Ore_29,Ore_30,Ore_31,Thunder_2,Poison_2,Ice_2,Fire_2",
        NumberCount = "700,1,1,1,1,1,1,1,1",
        Chance = "4000,170,200,220,230,230,230,230,230",
        EnhantStoneChance = 0.08,
        EnhantStoneRange = "15,25",
    },
    Loot_11 = {
        RewardTab = "Coin,Ore_31,Ore_32,Ore_33,Ore_34,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "400,1,1,1,1,1,1,1,1",
        Chance = "4500,190,190,190,190,80,80,80,80",
        EnhantStoneChance = 0.08,
        EnhantStoneRange = "15,25",
    },
    Loot_12 = {
        RewardTab = "Coin,Ore_33,Ore_34,Ore_35,Ore_36,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "500,1,1,1,1,1,1,1,1",
        Chance = "4600,170,210,210,170,120,120,120,120",
        EnhantStoneChance = 0.1,
        EnhantStoneRange = "25,50",
    },
    Loot_13 = {
        RewardTab = "Coin,Ore_35,Ore_36,Ore_37,Ore_38,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "600,1,1,1,1,1,1,1,1",
        Chance = "4600,100,190,220,230,160,160,160,160",
        EnhantStoneChance = 0.1,
        EnhantStoneRange = "25,50",
    },
    Loot_14 = {
        RewardTab = "Coin,Ore_38,Ore_39,Ore_33,Ore_40,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "700,1,1,1,1,1,1,1,1",
        Chance = "4000,200,200,220,200,200,200,200,200",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
    },
    Loot_15 = {
        RewardTab = "Coin,Ore_41,Ore_42,Ore_43,Ore_44,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "700,1,1,1,1,1,1,1,1",
        Chance = "4000,170,200,220,230,230,230,230,230",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.04,
        EnhantStone_2Range = "5,10",
    },
    Loot_19 = {
        RewardTab = "Coin,Ore_42,Ore_43,Ore_44,Ore_45,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "700,1,1,1,1,1,1,1,1",
        Chance = "4500,190,190,190,190,80,80,80,80",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.05,
        EnhantStone_2Range = "5,10",
    },
    Loot_20 = {
        RewardTab = "Coin,Ore_44,Ore_45,Ore_46,Ore_47,Thunder_3,Poison_3,Ice_3,Fire_3",
        NumberCount = "900,1,1,1,1,1,1,1,1",
        Chance = "4600,170,210,210,170,120,120,120,120",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.05,
        EnhantStone_2Range = "5,10",
    },
    Loot_21 = {
        RewardTab = "Coin,Ore_45,Ore_46,Ore_47,Ore_48,Thunder_3,Poison_3,Ice_3,Fire_3,SeasonCoin",
        NumberCount = "1000,1,1,1,1,1,1,1,1,100",
        Chance = "4600,100,190,220,230,160,160,160,160,40",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.06,
        EnhantStone_2Range = "15,25",
    },
    Loot_22 = {
        RewardTab = "Coin,Ore_45,Ore_46,Ore_47,Ore_48,Thunder_3,Poison_3,Ice_3,Fire_3,SeasonCoin",
        NumberCount = "1400,1,1,1,1,1,1,1,1,200",
        Chance = "4000,200,200,220,200,200,200,200,200,70",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.06,
        EnhantStone_2Range = "15,25",
    },
    Loot_23 = {
        RewardTab = "Coin,Ore_45,Ore_46,Ore_47,Ore_48,Thunder_3,Poison_3,Ice_3,Fire_3,SeasonCoin",
        NumberCount = "2000,1,1,1,1,1,1,1,1,200",
        Chance = "4000,170,200,220,230,230,230,230,230,100",
        EnhantStoneChance = 0.12,
        EnhantStoneRange = "50,75",
        EnhantStone_2Chance = 0.06,
        EnhantStone_2Range = "15,25",
    },
    Loot_16 = {RewardTab = "Thunder_1,Poison_1,Ice_1,Fire_1", NumberCount = "1,1,1,1", Chance = "100,100,100,100"},
    Loot_17 = {RewardTab = "Thunder_2,Poison_2,Ice_2,Fire_2", NumberCount = "1,1,1,1", Chance = "100,100,100,100"},
    Loot_18 = {RewardTab = "Thunder_3,Poison_3,Ice_3,Fire_3", NumberCount = "1,1,1,1", Chance = "100,100,100,100"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.EnchStoneConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.EnchStoneConfig
-- Decompile time: 1.45 ms

local v1, v2, v3
local v4 = {
    Thunder_1 = {Price = 100, BuffPercent = 0.03, Rarity = "UnCommon"},
    Thunder_2 = {Price = 1200, BuffPercent = 0.04, Rarity = "Rare"},
    Thunder_3 = {Price = 4500, BuffPercent = 0.05, Rarity = "Epic"},
    Poison_1 = {Price = 100, BuffPercent = 0.03, Rarity = "UnCommon"},
    Poison_2 = {Price = 1200, BuffPercent = 0.04, Rarity = "Rare"},
    Poison_3 = {Price = 4500, BuffPercent = 0.05, Rarity = "Epic"},
    Ice_1 = {Price = 100, BuffPercent = 0.03, Rarity = "UnCommon"},
    Ice_2 = {Price = 1200, BuffPercent = 0.04, Rarity = "Rare"},
    Ice_3 = {Price = 4500, BuffPercent = 0.05, Rarity = "Epic"},
    Fire_1 = {Price = 100, BuffPercent = 0.03, Rarity = "UnCommon"},
    Fire_2 = {Price = 1200, BuffPercent = 0.04, Rarity = "Rare"},
    Fire_3 = {Price = 4500, BuffPercent = 0.05, Rarity = "Epic"},
}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        v1 = require(j)
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            for m, i5 in n do
                v4[k][m] = i5
            end
        end
    end
end
return v4
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.EnchStoneConfig.Fire
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.EnchStoneConfig.Fire
-- Decompile time: 0.41 ms

return {
    Fire_1 = {
        BuffValue = 0.002,
        BuffTime = 2.2,
        DamageInterval = 0.2,
        BoomPercent = 0.06,
        BoomValue = 0.025,
    },
    Fire_2 = {
        BuffValue = 0.004,
        BuffTime = 2.4,
        DamageInterval = 0.2,
        BoomPercent = 0.07,
        BoomValue = 0.03,
    },
    Fire_3 = {
        BuffValue = 0.005,
        BuffTime = 2.4,
        DamageInterval = 0.2,
        BoomPercent = 0.07,
        BoomValue = 0.035,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.EnchStoneConfig.Ice
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.EnchStoneConfig.Ice
-- Decompile time: 0.40 ms

return {
    Ice_1 = {
        BuffValue = 0.2,
        BuffTime = 2.5,
        IcePercent = 0.06,
        IceTime = 3,
        IceValue = 0.03,
    },
    Ice_2 = {
        BuffValue = 0.25,
        BuffTime = 2.5,
        IcePercent = 0.08,
        IceTime = 3,
        IceValue = 0.05,
    },
    Ice_3 = {
        BuffValue = 0.3,
        BuffTime = 2.5,
        IcePercent = 0.1,
        IceTime = 3,
        IceValue = 0.07,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.EnchStoneConfig.Poison
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.EnchStoneConfig.Poison
-- Decompile time: 0.31 ms

return {
    Poison_1 = {BuffValue = 0.003, BuffTime = 2.2, DamageInterval = 0.2},
    Poison_2 = {BuffValue = 0.005, BuffTime = 2.8, DamageInterval = 0.2},
    Poison_3 = {BuffValue = 0.008, BuffTime = 3, DamageInterval = 0.2},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.EnchStoneConfig.Thunder
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.EnchStoneConfig.Thunder
-- Decompile time: 0.31 ms

return {Thunder_1 = {BuffValue = 0.05}, Thunder_2 = {BuffValue = 0.07}, Thunder_3 = {BuffValue = 0.1}}
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.Helper
-- Decompile time: 2.04 ms

local v1 = {}
local EnchStoneConfig = require(script.Parent.EnchStoneConfig)
local Show = require(script.Parent.Show)

function v1.CheckID(a1) -- Line: 7 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig[a1]
end

function v1.GetEnchStoneConfig() -- Line: 11 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig
end

function v1.GetStoneConfig(a1) -- Line: 15 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig[a1]
end

function v1.GetEnchancePrice(a1) -- Line: 19 -- upvalues: EnchStoneConfig (val)
    local Rarity = EnchStoneConfig[a1].Rarity
    if Rarity == "UnCommon" then
        return 200
    end
    if Rarity == "Rare" then
        return 1500
    end
    if Rarity == "Epic" then
        return 5000
    end
    return nil
end

function v1.GetPrice(a1) -- Line: 31 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig[a1].Price
end

function v1.GetSellPrice(a1) -- Line: 35 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig[a1].Price
end

function v1.GetImage(a1) -- Line: 39 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Image
    end
end

function v1.GetDisName(a1) -- Line: 44 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].DisplayName
    end
end

function v1.GetDescription(a1) -- Line: 49 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Description
    end
end

function v1.GetRarity(a1) -- Line: 55 -- upvalues: EnchStoneConfig (val)
    return EnchStoneConfig[a1].Rarity
end

function v1.GetEnchStoneListByLevel(a1) -- Line: 59 -- upvalues: EnchStoneConfig (val)
    local v1 = {}
    if type(a1) == "number" then
        a1 = tostring(a1)
    end
    for k, v in pairs(EnchStoneConfig) do
        if k:split("_")[2] == a1 then
            table.insert(v1, k)
        end
    end
    return v1
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.EnchStone.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.EnchStone.Show
-- Decompile time: 0.82 ms

return {
    Fire_1 = {
        Image = "rbxassetid://71992338625605",
        DisplayName = "Flame Rune Ⅰ",
        Description = "<font color=\"rgb(0,255,0)\">3%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.2%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">2.2s</font>. Applying Flame: <font color=\"rgb(0,255,0)\">6%</font> chance to explode, dealing <font color=\"rgb(0,255,0)\">2.5%</font> damage.",
    },
    Fire_2 = {
        Image = "rbxassetid://123824645054942",
        DisplayName = "Flame Rune Ⅱ",
        Description = "<font color=\"rgb(0,255,0)\">4%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.4%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">2.4s</font>. Applying Flame: <font color=\"rgb(0,255,0)\">7%</font> chance to explode, dealing <font color=\"rgb(0,255,0)\">3%</font> damage.",
    },
    Fire_3 = {
        Image = "rbxassetid://99878082050217",
        DisplayName = "Flame Rune Ⅲ",
        Description = "<font color=\"rgb(0,255,0)\">5%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.4%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">2.4s</font>. Applying Flame: <font color=\"rgb(0,255,0)\">7%</font> chance to explode, dealing <font color=\"rgb(0,255,0)\">3.5%</font> damage.",
    },
    Ice_1 = {
        Image = "rbxassetid://102398130227938",
        DisplayName = "Frost Rune Ⅰ",
        Description = "<font color=\"rgb(0,255,0)\">3%</font> chance on hit: slow enemy by <font color=\"rgb(0,255,0)\">20%</font> for <font color=\"rgb(0,255,0)\">2.5s</font>. If slowed, <font color=\"rgb(0,255,0)\">6%</font> chance to freeze for <font color=\"rgb(0,255,0)\">3s</font>; on end, explodes, dealing <font color=\"rgb(0,255,0)\">3%</font> of current ATK.",
    },
    Ice_2 = {
        Image = "rbxassetid://77607396440827",
        DisplayName = "Frost Rune Ⅱ",
        Description = "<font color=\"rgb(0,255,0)\">4%</font> chance on hit: slow enemy by <font color=\"rgb(0,255,0)\">25%</font> for <font color=\"rgb(0,255,0)\">2.5s</font>. If slowed, <font color=\"rgb(0,255,0)\">8%</font> chance to freeze for <font color=\"rgb(0,255,0)\">3s</font>; on end, explodes, dealing <font color=\"rgb(0,255,0)\">5%</font> of current ATK.",
    },
    Ice_3 = {
        Image = "rbxassetid://113105867181470",
        DisplayName = "Frost Rune Ⅲ",
        Description = "<font color=\"rgb(0,255,0)\">5%</font> chance on hit: slow enemy by <font color=\"rgb(0,255,0)\">30%</font> for <font color=\"rgb(0,255,0)\">2.5s</font>. If slowed, <font color=\"rgb(0,255,0)\">10%</font> chance to freeze for <font color=\"rgb(0,255,0)\">3s</font>; on end, explodes, dealing <font color=\"rgb(0,255,0)\">7%</font> of current ATK.",
    },
    Poison_1 = {
        Image = "rbxassetid://125961210922631",
        DisplayName = "Poison Rune Ⅰ",
        Description = "<font color=\"rgb(0,255,0)\">3%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.3%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">2.2s</font>.",
    },
    Poison_2 = {
        Image = "rbxassetid://73788520744680",
        DisplayName = "Poison Rune Ⅱ",
        Description = "<font color=\"rgb(0,255,0)\">4%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.5%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">2.8s</font>.",
    },
    Poison_3 = {
        Image = "rbxassetid://102294306583849",
        DisplayName = "Poison Rune Ⅲ",
        Description = "<font color=\"rgb(0,255,0)\">5%</font> chance on hit: deals <font color=\"rgb(0,255,0)\">0.8%</font> ATK every <font color=\"rgb(0,255,0)\">0.2s</font> for <font color=\"rgb(0,255,0)\">3s</font>.",
    },
    Thunder_1 = {
        Image = "rbxassetid://109943673065609",
        DisplayName = "Thunder Rune Ⅰ",
        Description = "<font color=\"rgb(0,255,0)\">3%</font> chance on hit: strike enemy with lightning, dealing <font color=\"rgb(0,255,0)\">5%</font> of current ATK.",
    },
    Thunder_2 = {
        Image = "rbxassetid://120577898201281",
        DisplayName = "Thunder Rune Ⅱ",
        Description = "<font color=\"rgb(0,255,0)\">4%</font> chance on hit: strike enemy with lightning, dealing <font color=\"rgb(0,255,0)\">7%</font> of current ATK.",
    },
    Thunder_3 = {
        Image = "rbxassetid://115322852137209",
        DisplayName = "Thunder Rune Ⅲ",
        Description = "<font color=\"rgb(0,255,0)\">5%</font> chance on hit: strike enemy with lightning, dealing <font color=\"rgb(0,255,0)\">10%</font> of current ATK.",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Enemy.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enemy.Config
-- Decompile time: 1.37 ms

return {
    Enemy_1 = {SkillList = {"Enemy_1_ATK"}},
    Enemy_2 = {SkillList = {"Enemy_2_ATK"}},
    Enemy_3 = {SkillList = {"Enemy_3_ATK"}},
    Boss_1 = {SkillList = {"Boss_1_ATK", "Boss_1_S1"}},
    Enemy_4 = {SkillList = {"Enemy_4_ATK"}},
    Enemy_5 = {SkillList = {"Enemy_4_ATK"}},
    Enemy_8 = {SkillList = {"Enemy_2_ATK"}},
    Boss_2 = {SkillList = {"Boss_2_ATK", "Boss_2_S1"}},
    Enemy_6 = {SkillList = {"Enemy_2_ATK"}},
    Enemy_7 = {SkillList = {"Enemy_3_ATK"}},
    Enemy_9 = {SkillList = {"Enemy_9_ATK"}},
    Boss_3 = {SkillList = {"Boss_3_ATK", "Boss_3_S1"}},
    Enemy_10 = {SkillList = {"Enemy_1_ATK"}},
    Enemy_11 = {SkillList = {"Enemy_3_ATK"}},
    Enemy_12 = {SkillList = {"Enemy_12_ATK"}},
    Boss_4 = {SkillList = {"Boss_4_ATK", "Boss_4_S1"}},
    Enemy_13 = {SkillList = {"Enemy_4_ATK"}},
    Enemy_14 = {SkillList = {"Enemy_1_ATK"}},
    Enemy_15 = {SkillList = {"Enemy_12_ATK"}},
    Boss_5 = {SkillList = {"Boss_5_ATK", "Boss_5_S1"}},
    Enemy_16 = {SkillList = {"Enemy_4_ATK"}},
    Enemy_17 = {SkillList = {"Enemy_1_ATK"}},
    Enemy_18 = {SkillList = {"Enemy_12_ATK"}},
    Boss_6 = {SkillList = {"Boss_6_ATK", "Boss_6_S1"}},
    WorldBoss_1 = {SkillList = {"WorldBoss_1_S1", "WorldBoss_1_S2", "WorldBoss_1_S3", "WorldBoss_1_S4"}},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Enemy.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enemy.Helper
-- Decompile time: 1.46 ms

local v1 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)
local SkillConfig = require(script.Parent.SkillConfig)

function v1.GetConfig() -- Line: 7 -- upvalues: Config (val)
    return Config
end

function v1.GetEnemySkillList(a1) -- Line: 11 -- upvalues: Config (val)
    return Config[a1].SkillList
end

function v1.GetSkillConfigByID(a1) -- Line: 15 -- upvalues: SkillConfig (val)
    return SkillConfig[a1]
end

function v1.GetSkillCD(a1) -- Line: 19 -- upvalues: SkillConfig (val)
    return SkillConfig[a1].CD or 0
end

function v1.GetSkillPhases(a1) -- Line: 23 -- upvalues: SkillConfig (val)
    return SkillConfig[a1].Phase
end

function v1.GetSkillActionTime(a1) -- Line: 27 -- upvalues: SkillConfig (val)
    return SkillConfig[a1].ActionTime
end

function v1.GetSkillMinDistance(a1) -- Line: 31 -- upvalues: SkillConfig (val)
    return SkillConfig[a1].MinDistance
end

function v1.GetImage(a1) -- Line: 35 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Image
    end
    return nil
end

function v1.GetDisName(a1) -- Line: 41 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].DisplayName
    end
    return nil
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Enemy.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enemy.Show
-- Decompile time: 0.88 ms

return {
    Enemy_1 = {DisplayName = "Goblin"},
    Enemy_2 = {DisplayName = "Captain Goblin"},
    Enemy_3 = {DisplayName = "Fire Goblin"},
    Enemy_4 = {DisplayName = "Desert Zombie"},
    Enemy_5 = {DisplayName = "Jackal Zombie"},
    Enemy_8 = {DisplayName = "Pharaoh Zombie"},
    Enemy_6 = {DisplayName = "Skeleton Soldier"},
    Enemy_7 = {DisplayName = "Hook Skeleton"},
    Enemy_9 = {DisplayName = "Anchor Skeleton"},
    Enemy_10 = {DisplayName = "Grolt"},
    Enemy_11 = {DisplayName = "Korgul"},
    Enemy_12 = {DisplayName = "Vyrath"},
    Enemy_13 = {DisplayName = "Yeti"},
    Enemy_14 = {DisplayName = "Snow Demon"},
    Enemy_15 = {DisplayName = "Snow Wisp"},
    Enemy_16 = {DisplayName = "Tophat Ghost"},
    Enemy_17 = {DisplayName = "Werewolf"},
    Enemy_18 = {DisplayName = "Grim Reaper"},
    Boss_1 = {DisplayName = "Armored Goblin"},
    Boss_2 = {DisplayName = "Desert Reaper"},
    Boss_3 = {DisplayName = "Skeleton Captain"},
    Boss_4 = {DisplayName = "Molok"},
    Boss_5 = {DisplayName = "Snow Golem King"},
    Boss_6 = {DisplayName = "Count Dracula"},
    Super_1 = {DisplayName = "Golden Goblin"},
    WorldBoss_1 = {DisplayName = "Hellfire · Wrath of Apocalypse · War"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Enemy.SkillConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enemy.SkillConfig
-- Decompile time: 5.09 ms

return {
    Enemy_1_ATK = {
        ActionTime = 1,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.4,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Enemy_2_ATK = {
        ActionTime = 0.8,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.3,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Enemy_3_ATK = {
        ActionTime = 0.8,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.3,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Enemy_4_ATK = {
        ActionTime = 0.9,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.5,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Enemy_9_ATK = {
        ActionTime = 0.75,
        CD = 2.5,
        Phase = {
            {
                DelayTime = 0.4,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Enemy_12_ATK = {
        ActionTime = 0.75,
        CD = 2.5,
        Phase = {
            {
                DelayTime = 0.38,
                DamageConfig = {
                    Offset = Vector3.new(4, 0, 0),
                    Size = Vector3.new(8, 60, 8),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_1_ATK = {
        ActionTime = 0.8,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.5,
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(10, 60, 11),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_1_S1 = {
        ActionTime = 2.2,
        MinDistance = 8,
        CD = 6,
        Phase = {
            {DelayTime = 0, WalkSpeed = 0, IsWarning = true, WarnType = "Circle"},
            {
                DelayTime = 0.7,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(26, 26, 26),
                    Damage = 1.5,
                    RingTime = 1.5,
                    DamageInterval = 0.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    Boss_2_ATK = {
        ActionTime = 0.8,
        CD = 2,
        Phase = {
            {
                DelayTime = 0.5,
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(15, 60, 12),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_2_S1 = {
        ActionTime = 1,
        CD = 7,
        MinDistance = 10,
        Phase = {
            {
                DelayTime = 0.7,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(30, 30, 30),
                    Damage = 1.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    Boss_3_ATK = {
        ActionTime = 1.3333333333333333,
        CD = 4,
        Phase = {
            {
                DelayTime = 0.5,
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(10, 60, 12),
                    Damage = 0.7,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 1,
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(10, 60, 12),
                    Damage = 0.7,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_3_S1 = {
        ActionTime = 2.1,
        CD = 8,
        MinDistance = 200,
        Phase = {
            {
                DelayTime = 1.4166666666666667,
                Number = 3,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(15, 15, 15),
                    Damage = 0.5,
                    Shape = Enum.PartType.Ball,
                },
            },
            {
                DelayTime = 1.6666666666666667,
                Number = 3,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(15, 15, 15),
                    Damage = 0.5,
                    Shape = Enum.PartType.Ball,
                },
            },
            {
                DelayTime = 1.9166666666666667,
                Number = 3,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(15, 15, 15),
                    Damage = 0.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    Boss_4_ATK = {
        ActionTime = 0.6666666666666666,
        CD = 4,
        Phase = {
            {
                DelayTime = 0.25,
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(10, 60, 13),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_4_S1 = {
        ActionTime = 1.5,
        CD = 8,
        MinDistance = 9,
        Phase = {
            {
                DelayTime = 0.9166666666666666,
                DamageConfig = {
                    Offset = Vector3.new(9, 0, 0),
                    Size = Vector3.new(18, 18, 18),
                    Damage = 1.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    Boss_5_ATK = {
        ActionTime = 1,
        CD = 3,
        Phase = {
            {
                DelayTime = 0.6,
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(10, 60, 13),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_5_S1 = {
        ActionTime = 2,
        CD = 10,
        MinDistance = 50,
        Phase = {
            {
                DelayTime = 1.4,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(12, 12, 12),
                    Damage = 0.5,
                    FlightSpeed = 100,
                    Shape = Enum.PartType.Ball,
                },
            },
            {
                DelayTime = 1.6,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(12, 12, 12),
                    Damage = 0.5,
                    FlightSpeed = 100,
                    Shape = Enum.PartType.Ball,
                },
            },
            {
                DelayTime = 1.8,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(12, 12, 12),
                    Damage = 0.5,
                    FlightSpeed = 100,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    Boss_6_ATK = {
        ActionTime = 0.8,
        CD = 3,
        Phase = {
            {
                DelayTime = 0.4166666666666667,
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(10, 60, 13),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    Boss_6_S1 = {
        ActionTime = 2.5,
        CD = 10,
        MinDistance = 50,
        Phase = {
            {DelayTime = 1.6666666666666667},
            {
                DelayTime = 1.8333333333333333,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(25, 25, 25),
                    Damage = 1.5,
                    FlightSpeed = 50,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    WorldBoss_1_S1 = {
        ActionTime = 1.5,
        CD = 3.5,
        MinDistance = 20,
        Phase = {
            {
                DelayTime = 1.1666666666666667,
                DamageConfig = {
                    Offset = Vector3.new(14, 0, 0),
                    Size = Vector3.new(32, 60, 32),
                    Damage = 0.125,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    WorldBoss_1_S2 = {
        ActionTime = 2,
        CD = 8,
        MinDistance = 30,
        Phase = {
            {
                DelayTime = 1.1666666666666667,
                DamageConfig = {
                    Offset = Vector3.new(0, -5, 0),
                    Size = Vector3.new(70, 70, 70),
                    Damage = 0.16666666666666666,
                    DebuffType = "Hellfire",
                    DebuffLevel = 1,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    WorldBoss_1_S3 = {
        ActionTime = 10,
        CD = 50,
        MinDistance = 60,
        Phase = {
            {
                DelayTime = 1.5,
                DamageConfig = {
                    Offset = Vector3.new(0, -2.299999952316284, 0),
                    Size = Vector3.new(30, 30, 30),
                    Damage = 0.05555555555555555,
                    FlightSpeed = 250,
                    FlightTime = 2.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    WorldBoss_1_S4 = {
        ActionTime = 2,
        CD = 30,
        MinDistance = 100,
        Phase = {
            {
                DelayTime = 1.5,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(50, 50, 50),
                    Damage = 0.2,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Enhant.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enhant.Config
-- Decompile time: 1.10 ms

return {
    [0] = {
        Boost = 0,
        NeedCoin = 0,
        EnhantStone_1 = 0,
        EnhantStone_2 = 0,
        Percent = 1,
    },
    {
        Boost = 0.05,
        NeedCoin = 200,
        EnhantStone_1 = 5,
        EnhantStone_2 = 0,
        Percent = 1,
    },
    {
        Boost = 0.1,
        NeedCoin = 1000,
        EnhantStone_1 = 10,
        EnhantStone_2 = 0,
        Percent = 1,
    },
    {
        Boost = 0.15,
        NeedCoin = 3000,
        EnhantStone_1 = 20,
        EnhantStone_2 = 0,
        Percent = 0.85,
    },
    {
        Boost = 0.2,
        NeedCoin = 7000,
        EnhantStone_1 = 40,
        EnhantStone_2 = 0,
        Percent = 0.75,
    },
    {
        Boost = 0.25,
        NeedCoin = 15000,
        EnhantStone_1 = 60,
        EnhantStone_2 = 0,
        Percent = 0.65,
    },
    {
        Boost = 0.4,
        NeedCoin = 32000,
        EnhantStone_1 = 100,
        EnhantStone_2 = 0,
        Percent = 0.4,
    },
    {
        Boost = 0.55,
        NeedCoin = 55000,
        EnhantStone_1 = 200,
        EnhantStone_2 = 0,
        Percent = 0.33,
    },
    {
        Boost = 0.7,
        NeedCoin = 70000,
        EnhantStone_1 = 400,
        EnhantStone_2 = 0,
        Percent = 0.25,
    },
    {
        Boost = 0.85,
        NeedCoin = 96000,
        EnhantStone_1 = 500,
        EnhantStone_2 = 0,
        Percent = 0.25,
    },
    {
        Boost = 1,
        NeedCoin = 130000,
        EnhantStone_1 = 1000,
        EnhantStone_2 = 0,
        Percent = 0.2,
    },
    {
        Boost = 1.15,
        NeedCoin = 260000,
        EnhantStone_1 = 1500,
        EnhantStone_2 = 0,
        Percent = 0.15,
    },
    {
        Boost = 1.3,
        NeedCoin = 350000,
        EnhantStone_1 = 2000,
        EnhantStone_2 = 5,
        Percent = 0.1,
    },
    {
        Boost = 1.5,
        NeedCoin = 700000,
        EnhantStone_1 = 3000,
        EnhantStone_2 = 15,
        Percent = 0.08,
    },
    {
        Boost = 1.7,
        NeedCoin = 900000,
        EnhantStone_1 = 4000,
        EnhantStone_2 = 25,
        Percent = 0.05,
    },
    {
        Boost = 1.9,
        NeedCoin = 1100000,
        EnhantStone_1 = 6000,
        EnhantStone_2 = 50,
        Percent = 0.05,
    },
    {
        Boost = 2.1,
        NeedCoin = 1800000,
        EnhantStone_1 = 7500,
        EnhantStone_2 = 75,
        Percent = 0.04,
    },
    {
        Boost = 2.3,
        NeedCoin = 2500000,
        EnhantStone_1 = 9000,
        EnhantStone_2 = 150,
        Percent = 0.03,
    },
    {
        Boost = 2.6,
        NeedCoin = 3700000,
        EnhantStone_1 = 10000,
        EnhantStone_2 = 250,
        Percent = 0.02,
    },
    {
        Boost = 2.9,
        NeedCoin = 4500000,
        EnhantStone_1 = 12000,
        EnhantStone_2 = 400,
        Percent = 0.01,
    },
    {
        Boost = 3.2,
        NeedCoin = 6000000,
        EnhantStone_1 = 15000,
        EnhantStone_2 = 600,
        Percent = 0.01,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Enhant.EventHelper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enhant.EventHelper
-- Decompile time: 1.35 ms

local u0 = {}
local Reward = require(script.Reward)
local Quest = require(script.Quest)

function u0.GetRewardConfig() -- Line: 7 -- upvalues: Reward (val)
    return Reward
end

function u0.GetQuestConfig() -- Line: 10 -- upvalues: Quest (val)
    return Quest
end

function u0.GetRewardConfigByIndex(a1) -- Line: 14 -- upvalues: Reward (val)
    if Reward[a1] then
        return Reward[a1]
    end
end

function u0.GetQuestConfigByIndex(a1) -- Line: 19 -- upvalues: Quest (val)
    if Quest[a1] then
        return Quest[a1]
    end
end

function u0.GetNeedType(a1) -- Line: 25 -- upvalues: Quest (val)
    if Quest[a1] then
        return Quest[a1].NeedType
    end
end

function u0.GetNeedNumber(a1) -- Line: 30 -- upvalues: Quest (val)
    if Quest[a1] then
        return Quest[a1].NeedNumber
    end
end

function u0.GetDescriptionByID(a1) -- Line: 36 -- upvalues: u0 (val)
    return u0.GetDescriptionByNeedType((u0.GetQuestConfigByIndex(a1)).NeedType)
end

function u0.GetDescriptionByNeedType(a1) -- Line: 42
    if a1 == "Enhant" then
        return "Enhanced"
    end
    if a1 == "Forge_Weapon" then
        return "Forge Weapon"
    end
    if a1 == "Forge_Armor" then
        return "Forge Armor"
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Enhant.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Enhant.Helper
-- Decompile time: 1.40 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Config)
local u18 = require(ReplicatedStorage.Utils.TableUtils).getTableLegth(Config) - 1

function v1.GetFailLevel() -- Line: 12
    return 6
end

function v1.GetConfig() -- Line: 17 -- upvalues: Config (val)
    return Config
end

function v1.IsMax(a1) -- Line: 21 -- upvalues: u18 (val)
    return a1 and u18 <= a1
end

function v1.GetNeedCoin(a1) -- Line: 25 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].NeedCoin
    end
    return nil
end

function v1.GetBoost(a1) -- Line: 32 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Boost
    end
    return 0
end

function v1.GetNeedEnhantStone_1(a1) -- Line: 39 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].EnhantStone_1
    end
    return nil
end

function v1.GetNeedEnhantStone_2(a1) -- Line: 45 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].EnhantStone_2
    end
    return nil
end

function v1.GetPercent(a1) -- Line: 51 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Percent
    end
    return nil
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Index.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Index.Config
-- Decompile time: 1.88 ms

return {
    [0] = {
        NeedExp = 0,
        Boost = 0,
        BoostType = 0,
        HeadText = "",
        Text = 0,
        Title = 1,
    },
    {
        NeedExp = 50,
        Boost = 1,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+1 Ore Pack",
    },
    {
        NeedExp = 75,
        Boost = 0.05,
        BoostType = "Train",
        HeadText = "Power",
        Text = "+5% Power Train",
        Title = 2,
    },
    {
        NeedExp = 100,
        Boost = 1,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+1 Ore Pack",
    },
    {
        NeedExp = 125,
        Boost = 0.05,
        BoostType = "Train",
        HeadText = "Power",
        Text = "+5% Power Train",
        Title = 3,
    },
    {
        NeedExp = 150,
        Boost = 0.05,
        BoostType = "Coin",
        HeadText = "Coin",
        Text = "+5% Coin Get",
    },
    {
        NeedExp = 175,
        Boost = 1,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+1 Ore Pack",
        Title = 4,
    },
    {
        NeedExp = 200,
        Boost = 0.05,
        BoostType = "WalkSpeed",
        HeadText = "Speed",
        Text = "+5% Walk Speed",
    },
    {
        NeedExp = 225,
        Boost = 0.05,
        BoostType = "Coin",
        HeadText = "Coin",
        Text = "+5% Coin Get",
        Title = 5,
    },
    {
        NeedExp = 250,
        Boost = 1,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+2 Ore Pack",
    },
    {
        NeedExp = 300,
        Boost = 1,
        BoostType = "LuckPotion",
        HeadText = "Potion",
        Text = "+1 Luck Potion",
        Title = 6,
    },
    {
        NeedExp = 325,
        Boost = 0.05,
        BoostType = "WalkSpeed",
        HeadText = "Speed",
        Text = "+5% Walk Speed",
    },
    {
        NeedExp = 350,
        Boost = 2,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+2 Ore Pack",
    },
    {
        NeedExp = 375,
        Boost = 0.05,
        BoostType = "Train",
        HeadText = "Power",
        Text = "+5% Power Train",
        Title = 7,
    },
    {
        NeedExp = 400,
        Boost = 1,
        BoostType = "CoinPotion",
        HeadText = "Coin",
        Text = "+1 Coin Potion",
    },
    {
        NeedExp = 425,
        Boost = 0.05,
        BoostType = "WalkSpeed",
        HeadText = "Speed",
        Text = "+5% Walk Speed",
    },
    {
        NeedExp = 450,
        Boost = 2,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+2 Ore Pack",
        Title = 8,
    },
    {
        NeedExp = 475,
        Boost = 0.02,
        BoostType = "Crit",
        HeadText = "Crit",
        Text = "+ 2% Critical Rate",
    },
    {
        NeedExp = 500,
        Boost = 0.02,
        BoostType = "SkillDamage",
        HeadText = "Damage",
        Text = "+2% Skill Damage",
    },
    {
        NeedExp = 525,
        Boost = 0.03,
        BoostType = "SkillCD",
        HeadText = "CD",
        Text = "-3% Skill CD",
        Title = 9,
    },
    {
        NeedExp = 550,
        Boost = 0.05,
        BoostType = "Train",
        HeadText = "Power",
        Text = "+5% Power Train",
    },
    {
        NeedExp = 575,
        Boost = 0.02,
        BoostType = "Crit",
        HeadText = "Crit",
        Text = "+ 2% Critical Rate",
    },
    {
        NeedExp = 600,
        Boost = 0.02,
        BoostType = "SkillDamage",
        HeadText = "Damage",
        Text = "+2% Skill Damage",
        Title = 10,
    },
    {
        NeedExp = 625,
        Boost = 0.03,
        BoostType = "SkillCD",
        HeadText = "CD",
        Text = "-3% Skill CD",
    },
    {
        NeedExp = 650,
        Boost = 2,
        BoostType = "OrePack",
        HeadText = "Bag",
        Text = "+2 Ore Pack",
    },
    {
        NeedExp = 675,
        Boost = 0.05,
        BoostType = "WalkSpeed",
        HeadText = "Speed",
        Text = "+5% Walk Speed",
        Title = 11,
    },
    {
        NeedExp = 700,
        Boost = 0.05,
        BoostType = "Luck",
        HeadText = "Luck",
        Text = "+5% Luck",
    },
    {
        NeedExp = 725,
        Boost = 0.05,
        BoostType = "Defence",
        HeadText = "Defence",
        Text = "+5% Defend",
    },
    {
        NeedExp = 750,
        Boost = 0.03,
        BoostType = "SkillDamage",
        HeadText = "Damage",
        Text = "+3% Skill Damage",
        Title = 12,
    },
    {
        NeedExp = 775,
        Boost = 0.05,
        BoostType = "Defence",
        HeadText = "Defence",
        Text = "+5% Defend",
    },
    {
        NeedExp = 800,
        Boost = 0.03,
        BoostType = "SkillCD",
        HeadText = "CD",
        Text = "-3% Skill CD",
    },
    {
        NeedExp = 825,
        Boost = 0.02,
        BoostType = "Crit",
        HeadText = "Crit",
        Text = "+ 2% Critical Rate",
        Title = 13,
    },
    {
        NeedExp = 850,
        Boost = 0.05,
        BoostType = "WalkSpeed",
        HeadText = "Speed",
        Text = "+5% Walk Speed",
    },
    {
        NeedExp = 875,
        Boost = 0.05,
        BoostType = "Coin",
        HeadText = "Coin",
        Text = "+5% Coin Get",
    },
    {
        NeedExp = 900,
        Boost = 0.03,
        BoostType = "SkillDamage",
        HeadText = "Damage",
        Text = "+3% Skill Damage",
        Title = 14,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Index.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Index.Helper
-- Decompile time: 2.08 ms

local u0 = {}
local Config = require(script.Parent.Config)
local RarityExp = require(script.Parent.RarityExp)
local TitleConfig = require(script.Parent.TitleConfig)

function u0.GetConfig() -- Line: 7 -- upvalues: Config (val)
    return Config
end

function u0.GetIndexID(a1, a2) -- Line: 12
    return (("%*-%*"):format(a1, a2))
end

function u0.Check(a1) -- Line: 17 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

function u0.GetNeedExp(a1) -- Line: 21 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].NeedExp
end

function u0.GetBoost(a1) -- Line: 27 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].Boost
end

function u0.GetBoostType(a1) -- Line: 33 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].BoostType
end

function u0.GetText(a1) -- Line: 39 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].Text
end

function u0.GetHeadText(a1) -- Line: 46 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].HeadText
end

function u0.GetID(a1) -- Line: 53 -- upvalues: u0 (val), Config (val)
    if not u0.Check(a1) then
        return nil
    end
    return Config[a1].ID
end

function u0.GetRarityExp(a1) -- Line: 60 -- upvalues: RarityExp (val)
    return RarityExp[a1]
end

function u0.GetMaxTitleLevel(a1) -- Line: 64 -- upvalues: Config (val)
    for i = a1, 0, -1 do
        if Config[i] and Config[i].Title and 0 < Config[i].Title then
            return Config[i].Title
        end
    end
    return 0
end

function u0.GetTitleText(a1) -- Line: 73 -- upvalues: TitleConfig (val)
    return TitleConfig[a1]
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Index.RarityExp
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Index.RarityExp
-- Decompile time: 0.20 ms

return {
    Common = 10,
    UnCommon = 15,
    Rare = 20,
    Epic = 25,
    Legendary = 50,
    Mythic = 60,
    Eternal = 80,
    Secret = 110,
    Ancient = 130,
    Infinite = 200,
    Exclusive = 1000,
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Index.TitleConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Index.TitleConfig
-- Decompile time: 0.34 ms

return {
    "Noob",
    "Recruit",
    "Swordsman",
    "Hero",
    "Grandmaster",
    "Blademaster",
    "Demon‑Blade",
    "Blade Sect",
    "Weaponsmith",
    "Paladin",
    "Swordheart",
    "Apocalypse",
    "Wraithsword",
    "Sword Sovereign",
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Level.Config
-- Took 0.1s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Level.Config
-- Decompile time: 104.75 ms

return {
    [0] = {NeedExp = 0},
    {NeedExp = 45},
    {NeedExp = 49},
    {NeedExp = 54},
    {NeedExp = 59},
    {NeedExp = 64},
    {NeedExp = 70},
    {NeedExp = 77},
    {NeedExp = 84},
    {NeedExp = 93},
    {NeedExp = 102},
    {NeedExp = 112},
    {NeedExp = 122},
    {NeedExp = 134},
    {NeedExp = 146},
    {NeedExp = 160},
    {NeedExp = 176},
    {NeedExp = 192},
    {NeedExp = 211},
    {NeedExp = 230},
    {NeedExp = 252},
    {NeedExp = 276},
    {NeedExp = 303},
    {NeedExp = 331},
    {NeedExp = 363},
    {NeedExp = 397},
    {NeedExp = 435},
    {NeedExp = 476},
    {NeedExp = 522},
    {NeedExp = 571},
    {NeedExp = 625},
    {NeedExp = 685},
    {NeedExp = 750},
    {NeedExp = 821},
    {NeedExp = 899},
    {NeedExp = 985},
    {NeedExp = 1080},
    {NeedExp = 1180},
    {NeedExp = 1290},
    {NeedExp = 1420},
    {NeedExp = 1550},
    {NeedExp = 1700},
    {NeedExp = 1860},
    {NeedExp = 2040},
    {NeedExp = 2230},
    {NeedExp = 2440},
    {NeedExp = 2670},
    {NeedExp = 2930},
    {NeedExp = 3200},
    {NeedExp = 3510},
    {NeedExp = 3840},
    {NeedExp = 4210},
    {NeedExp = 4610},
    {NeedExp = 5040},
    {NeedExp = 5520},
    {NeedExp = 6050},
    {NeedExp = 6620},
    {NeedExp = 7250},
    {NeedExp = 7940},
    {NeedExp = 8690},
    {NeedExp = 9520},
    {NeedExp = 10400},
    {NeedExp = 11400},
    {NeedExp = 12500},
    {NeedExp = 13700},
    {NeedExp = 15000},
    {NeedExp = 16400},
    {NeedExp = 18000},
    {NeedExp = 19700},
    {NeedExp = 21500},
    {NeedExp = 23600},
    {NeedExp = 25800},
    {NeedExp = 28300},
    {NeedExp = 31000},
    {NeedExp = 33900},
    {NeedExp = 37100},
    {NeedExp = 40700},
    {NeedExp = 44500},
    {NeedExp = 48800},
    {NeedExp = 53400},
    {NeedExp = 58500},
    {NeedExp = 64000},
    {NeedExp = 70100},
    {NeedExp = 76800},
    {NeedExp = 84100},
    {NeedExp = 92000},
    {NeedExp = 101000},
    {NeedExp = 110000},
    {NeedExp = 121000},
    {NeedExp = 132000},
    {NeedExp = 145000},
    {NeedExp = 159000},
    {NeedExp = 174000},
    {NeedExp = 190000},
    {NeedExp = 208000},
    {NeedExp = 228000},
    {NeedExp = 250000},
    {NeedExp = 274000},
    {NeedExp = 299000},
    {NeedExp = 328000},
    {NeedExp = 359000},
    {NeedExp = 393000},
    {NeedExp = 431000},
    {NeedExp = 471000},
    {NeedExp = 516000},
    {NeedExp = 565000},
    {NeedExp = 619000},
    {NeedExp = 678000},
    {NeedExp = 742000},
    {NeedExp = 813000},
    {NeedExp = 890000},
    {NeedExp = 974000},
    {NeedExp = 1070000},
    {NeedExp = 1170000},
    {NeedExp = 1280000},
    {NeedExp = 1400000},
    {NeedExp = 1530000},
    {NeedExp = 1680000},
    {NeedExp = 1840000},
    {NeedExp = 2010000},
    {NeedExp = 2210000},
    {NeedExp = 2410000},
    {NeedExp = 2640000},
    {NeedExp = 2900000},
    {NeedExp = 3170000},
    {NeedExp = 3470000},
    {NeedExp = 3800000},
    {NeedExp = 4160000},
    {NeedExp = 4560000},
    {NeedExp = 4990000},
    {NeedExp = 5470000},
    {NeedExp = 5980000},
    {NeedExp = 6550000},
    {NeedExp = 7180000},
    {NeedExp = 7860000},
    {NeedExp = 8600000},
    {NeedExp = 9420000},
    {NeedExp = 10300000},
    {NeedExp = 11300000},
    {NeedExp = 12400000},
    {NeedExp = 13500000},
    {NeedExp = 14800000},
    {NeedExp = 16200000},
    {NeedExp = 17800000},
    {NeedExp = 19500000},
    {NeedExp = 21300000},
    {NeedExp = 23300000},
    {NeedExp = 25600000},
    {NeedExp = 28000000},
    {NeedExp = 30700000},
    {NeedExp = 33600000},
    {NeedExp = 36800000},
    {NeedExp = 40200000},
    {NeedExp = 44100000},
    {NeedExp = 48300000},
    {NeedExp = 52800000},
    {NeedExp = 57900000},
    {NeedExp = 63400000},
    {NeedExp = 69400000},
    {NeedExp = 76000000},
    {NeedExp = 83200000},
    {NeedExp = 91100000},
    {NeedExp = 99700000},
    {NeedExp = 109000000},
    {NeedExp = 120000000},
    {NeedExp = 131000000},
    {NeedExp = 143000000},
    {NeedExp = 157000000},
    {NeedExp = 172000000},
    {NeedExp = 188000000},
    {NeedExp = 206000000},
    {NeedExp = 226000000},
    {NeedExp = 247000000},
    {NeedExp = 271000000},
    {NeedExp = 296000000},
    {NeedExp = 325000000},
    {NeedExp = 355000000},
    {NeedExp = 389000000},
    {NeedExp = 426000000},
    {NeedExp = 467000000},
    {NeedExp = 511000000},
    {NeedExp = 559000000},
    {NeedExp = 613000000},
    {NeedExp = 671000000},
    {NeedExp = 735000000},
    {NeedExp = 804000000},
    {NeedExp = 881000000},
    {NeedExp = 964000000},
    {NeedExp = 1060000000},
    {NeedExp = 1160000000},
    {NeedExp = 1270000000},
    {NeedExp = 1390000000},
    {NeedExp = 1520000000},
    {NeedExp = 1660000000},
    {NeedExp = 1820000000},
    {NeedExp = 1990000000},
    {NeedExp = 2180000000},
    {NeedExp = 2390000000},
    {NeedExp = 2620000000},
    {NeedExp = 2870000000},
    {NeedExp = 3140000000},
    {NeedExp = 3440000000},
    {NeedExp = 3760000000},
    {NeedExp = 4120000000},
    {NeedExp = 4510000000},
    {NeedExp = 4940000000},
    {NeedExp = 5410000000},
    {NeedExp = 5920000000},
    {NeedExp = 6490000000},
    {NeedExp = 7100000000},
    {NeedExp = 7780000000},
    {NeedExp = 8510000000},
    {NeedExp = 9320000000},
    {NeedExp = 10200000000},
    {NeedExp = 11200000000},
    {NeedExp = 12200000000},
    {NeedExp = 13400000000},
    {NeedExp = 14700000000},
    {NeedExp = 16100000000},
    {NeedExp = 17600000000},
    {NeedExp = 19300000000},
    {NeedExp = 21100000000},
    {NeedExp = 23100000000},
    {NeedExp = 25300000000},
    {NeedExp = 27700000000},
    {NeedExp = 30300000000},
    {NeedExp = 33200000000},
    {NeedExp = 36400000000},
    {NeedExp = 39800000000},
    {NeedExp = 43600000000},
    {NeedExp = 47800000000},
    {NeedExp = 52300000000},
    {NeedExp = 57300000000},
    {NeedExp = 62700000000},
    {NeedExp = 68700000000},
    {NeedExp = 75200000000},
    {NeedExp = 82300000000},
    {NeedExp = 90100000000},
    {NeedExp = 98700000000},
    {NeedExp = 108000000000},
    {NeedExp = 118000000000},
    {NeedExp = 130000000000},
    {NeedExp = 142000000000},
    {NeedExp = 155000000000},
    {NeedExp = 170000000000},
    {NeedExp = 186000000000},
    {NeedExp = 204000000000},
    {NeedExp = 223000000000},
    {NeedExp = 245000000000},
    {NeedExp = 268000000000},
    {NeedExp = 293000000000},
    {NeedExp = 321000000000},
    {NeedExp = 352000000000},
    {NeedExp = 385000000000},
    {NeedExp = 422000000000},
    {NeedExp = 462000000000},
    {NeedExp = 506000000000},
    {NeedExp = 554000000000},
    {NeedExp = 606000000000},
    {NeedExp = 664000000000},
    {NeedExp = 727000000000},
    {NeedExp = 796000000000},
    {NeedExp = 872000000000},
    {NeedExp = 954000000000},
    {NeedExp = 1050000000000},
    {NeedExp = 1140000000000},
    {NeedExp = 1250000000000},
    {NeedExp = 1370000000000},
    {NeedExp = 1500000000000},
    {NeedExp = 1650000000000},
    {NeedExp = 1800000000000},
    {NeedExp = 1970000000000},
    {NeedExp = 2160000000000},
    {NeedExp = 2370000000000},
    {NeedExp = 2590000000000},
    {NeedExp = 2840000000000},
    {NeedExp = 3110000000000},
    {NeedExp = 3400000000000},
    {NeedExp = 3720000000000},
    {NeedExp = 4080000000000},
    {NeedExp = 4460000000000},
    {NeedExp = 4890000000000},
    {NeedExp = 5350000000000},
    {NeedExp = 5860000000000},
    {NeedExp = 6420000000000},
    {NeedExp = 7030000000000},
    {NeedExp = 7700000000000},
    {NeedExp = 8430000000000},
    {NeedExp = 9230000000000},
    {NeedExp = 10100000000000},
    {NeedExp = 11100000000000},
    {NeedExp = 12100000000000},
    {NeedExp = 13300000000000},
    {NeedExp = 14500000000000},
    {NeedExp = 15900000000000},
    {NeedExp = 17400000000000},
    {NeedExp = 19100000000000},
    {NeedExp = 20900000000000},
    {NeedExp = 22900000000000},
    {NeedExp = 25000000000000},
    {NeedExp = 27400000000000},
    {NeedExp = 30000000000000},
    {NeedExp = 32900000000000},
    {NeedExp = 36000000000000},
    {NeedExp = 39400000000000},
    {NeedExp = 43200000000000},
    {NeedExp = 47300000000000},
    {NeedExp = 51800000000000},
    {NeedExp = 56700000000000},
    {NeedExp = 62100000000000},
    {NeedExp = 67900000000000},
    {NeedExp = 74400000000000},
    {NeedExp = 81500000000000},
    {NeedExp = 89200000000000},
    {NeedExp = 97700000000000},
    {NeedExp = 107000000000000},
    {NeedExp = 117000000000000},
    {NeedExp = 128000000000000},
    {NeedExp = 140000000000000},
    {NeedExp = 154000000000000},
    {NeedExp = 168000000000000},
    {NeedExp = 184000000000000},
    {NeedExp = 202000000000000},
    {NeedExp = 221000000000000},
    {NeedExp = 242000000000000},
    {NeedExp = 265000000000000},
    {NeedExp = 290000000000000},
    {NeedExp = 318000000000000},
    {NeedExp = 348000000000000},
    {NeedExp = 381000000000000},
    {NeedExp = 417000000000000},
    {NeedExp = 457000000000000},
    {NeedExp = 500000000000000},
    {NeedExp = 548000000000000},
    {NeedExp = 600000000000000},
    {NeedExp = 657000000000000},
    {NeedExp = 719000000000000},
    {NeedExp = 788000000000000},
    {NeedExp = 863000000000000},
    {NeedExp = 944000000000000},
    {NeedExp = 1.03e+15},
    {NeedExp = 1.13e+15},
    {NeedExp = 1.24e+15},
    {NeedExp = 1.36e+15},
    {NeedExp = 1.49e+15},
    {NeedExp = 1.63e+15},
    {NeedExp = 1.78e+15},
    {NeedExp = 1.95e+15},
    {NeedExp = 2.14e+15},
    {NeedExp = 2.34e+15},
    {NeedExp = 2.56e+15},
    {NeedExp = 2.81e+15},
    {NeedExp = 3.07e+15},
    {NeedExp = 3.36e+15},
    {NeedExp = 3.68e+15},
    {NeedExp = 4.03e+15},
    {NeedExp = 4.42e+15},
    {NeedExp = 4.84e+15},
    {NeedExp = 5.3e+15},
    {NeedExp = 5.8e+15},
    {NeedExp = 6.35e+15},
    {NeedExp = 6.95e+15},
    {NeedExp = 7.62e+15},
    {NeedExp = 8.34e+15},
    {NeedExp = 9.13e+15},
    {NeedExp = 1e+16},
    {NeedExp = 1.09e+16},
    {NeedExp = 1.2e+16},
    {NeedExp = 1.31e+16},
    {NeedExp = 1.44e+16},
    {NeedExp = 1.57e+16},
    {NeedExp = 1.72e+16},
    {NeedExp = 1.89e+16},
    {NeedExp = 2.07e+16},
    {NeedExp = 2.26e+16},
    {NeedExp = 2.48e+16},
    {NeedExp = 2.71e+16},
    {NeedExp = 2.97e+16},
    {NeedExp = 3.25e+16},
    {NeedExp = 3.56e+16},
    {NeedExp = 3.9e+16},
    {NeedExp = 4.27e+16},
    {NeedExp = 4.68e+16},
    {NeedExp = 5.12e+16},
    {NeedExp = 5.61e+16},
    {NeedExp = 6.14e+16},
    {NeedExp = 6.72e+16},
    {NeedExp = 7.36e+16},
    {NeedExp = 8.06e+16},
    {NeedExp = 8.83e+16},
    {NeedExp = 9.67e+16},
    {NeedExp = 1.06e+17},
    {NeedExp = 1.16e+17},
    {NeedExp = 1.27e+17},
    {NeedExp = 1.39e+17},
    {NeedExp = 1.52e+17},
    {NeedExp = 1.67e+17},
    {NeedExp = 1.82e+17},
    {NeedExp = 2e+17},
    {NeedExp = 2.19e+17},
    {NeedExp = 2.4e+17},
    {NeedExp = 2.62e+17},
    {NeedExp = 2.87e+17},
    {NeedExp = 3.15e+17},
    {NeedExp = 3.44e+17},
    {NeedExp = 3.77e+17},
    {NeedExp = 4.13e+17},
    {NeedExp = 4.52e+17},
    {NeedExp = 4.95e+17},
    {NeedExp = 5.42e+17},
    {NeedExp = 5.94e+17},
    {NeedExp = 6.5e+17},
    {NeedExp = 7.12e+17},
    {NeedExp = 7.8e+17},
    {NeedExp = 8.54e+17},
    {NeedExp = 9.35e+17},
    {NeedExp = 1.02e+18},
    {NeedExp = 1.12e+18},
    {NeedExp = 1.23e+18},
    {NeedExp = 1.34e+18},
    {NeedExp = 1.47e+18},
    {NeedExp = 1.61e+18},
    {NeedExp = 1.76e+18},
    {NeedExp = 1.93e+18},
    {NeedExp = 2.12e+18},
    {NeedExp = 2.32e+18},
    {NeedExp = 2.54e+18},
    {NeedExp = 2.78e+18},
    {NeedExp = 3.04e+18},
    {NeedExp = 3.33e+18},
    {NeedExp = 3.65e+18},
    {NeedExp = 3.99e+18},
    {NeedExp = 4.37e+18},
    {NeedExp = 4.79e+18},
    {NeedExp = 5.24e+18},
    {NeedExp = 5.74e+18},
    {NeedExp = 6.29e+18},
    {NeedExp = 6.88e+18},
    {NeedExp = 7.54e+18},
    {NeedExp = 8.25e+18},
    {NeedExp = 9.04e+18},
    {NeedExp = 9.9e+18},
    {NeedExp = 1.08e+19},
    {NeedExp = 1.19e+19},
    {NeedExp = 1.3e+19},
    {NeedExp = 1.42e+19},
    {NeedExp = 1.56e+19},
    {NeedExp = 1.71e+19},
    {NeedExp = 1.87e+19},
    {NeedExp = 2.05e+19},
    {NeedExp = 2.24e+19},
    {NeedExp = 2.45e+19},
    {NeedExp = 2.69e+19},
    {NeedExp = 2.94e+19},
    {NeedExp = 3.22e+19},
    {NeedExp = 3.53e+19},
    {NeedExp = 3.86e+19},
    {NeedExp = 4.23e+19},
    {NeedExp = 4.63e+19},
    {NeedExp = 5.07e+19},
    {NeedExp = 5.55e+19},
    {NeedExp = 6.08e+19},
    {NeedExp = 6.65e+19},
    {NeedExp = 7.29e+19},
    {NeedExp = 7.98e+19},
    {NeedExp = 8.74e+19},
    {NeedExp = 9.57e+19},
    {NeedExp = 1.05e+20},
    {NeedExp = 1.15e+20},
    {NeedExp = 1.26e+20},
    {NeedExp = 1.38e+20},
    {NeedExp = 1.51e+20},
    {NeedExp = 1.65e+20},
    {NeedExp = 1.81e+20},
    {NeedExp = 1.98e+20},
    {NeedExp = 2.17e+20},
    {NeedExp = 2.37e+20},
    {NeedExp = 2.6e+20},
    {NeedExp = 2.84e+20},
    {NeedExp = 3.11e+20},
    {NeedExp = 3.41e+20},
    {NeedExp = 3.73e+20},
    {NeedExp = 4.09e+20},
    {NeedExp = 4.48e+20},
    {NeedExp = 4.9e+20},
    {NeedExp = 5.37e+20},
    {NeedExp = 5.88e+20},
    {NeedExp = 6.43e+20},
    {NeedExp = 7.05e+20},
    {NeedExp = 7.71e+20},
    {NeedExp = 8.45e+20},
    {NeedExp = 9.25e+20},
    {NeedExp = 1.01e+21},
    {NeedExp = 1.11e+21},
    {NeedExp = 1.21e+21},
    {NeedExp = 1.33e+21},
    {NeedExp = 1.46e+21},
    {NeedExp = 1.59e+21},
    {NeedExp = 1.75e+21},
    {NeedExp = 1.91e+21},
    {NeedExp = 2.09e+21},
    {NeedExp = 2.29e+21},
    {NeedExp = 2.51e+21},
    {NeedExp = 2.75e+21},
    {NeedExp = 3.01e+21},
    {NeedExp = 3.3e+21},
    {NeedExp = 3.61e+21},
    {NeedExp = 3.95e+21},
    {NeedExp = 4.33e+21},
    {NeedExp = 4.74e+21},
    {NeedExp = 5.19e+21},
    {NeedExp = 5.68e+21},
    {NeedExp = 6.22e+21},
    {NeedExp = 6.81e+21},
    {NeedExp = 7.46e+21},
    {NeedExp = 8.17e+21},
    {NeedExp = 8.94e+21},
    {NeedExp = 9.79e+21},
    {NeedExp = 1.07e+22},
    {NeedExp = 1.17e+22},
    {NeedExp = 1.29e+22},
    {NeedExp = 1.41e+22},
    {NeedExp = 1.54e+22},
    {NeedExp = 1.69e+22},
    {NeedExp = 1.85e+22},
    {NeedExp = 2.02e+22},
    {NeedExp = 2.22e+22},
    {NeedExp = 2.43e+22},
    {NeedExp = 2.66e+22},
    {NeedExp = 2.91e+22},
    {NeedExp = 3.19e+22},
    {NeedExp = 3.49e+22},
    {NeedExp = 3.82e+22},
    {NeedExp = 4.18e+22},
    {NeedExp = 4.58e+22},
    {NeedExp = 5.02e+22},
    {NeedExp = 5.49e+22},
    {NeedExp = 6.01e+22},
    {NeedExp = 6.59e+22},
    {NeedExp = 7.21e+22},
    {NeedExp = 7.9e+22},
    {NeedExp = 8.65e+22},
    {NeedExp = 9.47e+22},
    {NeedExp = 1.04e+23},
    {NeedExp = 1.14e+23},
    {NeedExp = 1.24e+23},
    {NeedExp = 1.36e+23},
    {NeedExp = 1.49e+23},
    {NeedExp = 1.63e+23},
    {NeedExp = 1.79e+23},
    {NeedExp = 1.96e+23},
    {NeedExp = 2.14e+23},
    {NeedExp = 2.35e+23},
    {NeedExp = 2.57e+23},
    {NeedExp = 2.81e+23},
    {NeedExp = 3.08e+23},
    {NeedExp = 3.37e+23},
    {NeedExp = 3.69e+23},
    {NeedExp = 4.04e+23},
    {NeedExp = 4.43e+23},
    {NeedExp = 4.85e+23},
    {NeedExp = 5.31e+23},
    {NeedExp = 5.81e+23},
    {NeedExp = 6.37e+23},
    {NeedExp = 6.97e+23},
    {NeedExp = 7.63e+23},
    {NeedExp = 8.36e+23},
    {NeedExp = 9.15e+23},
    {NeedExp = 1e+24},
    {NeedExp = 1.1e+24},
    {NeedExp = 1.2e+24},
    {NeedExp = 1.32e+24},
    {NeedExp = 1.44e+24},
    {NeedExp = 1.58e+24},
    {NeedExp = 1.73e+24},
    {NeedExp = 1.89e+24},
    {NeedExp = 2.07e+24},
    {NeedExp = 2.27e+24},
    {NeedExp = 2.48e+24},
    {NeedExp = 2.72e+24},
    {NeedExp = 2.98e+24},
    {NeedExp = 3.26e+24},
    {NeedExp = 3.57e+24},
    {NeedExp = 3.91e+24},
    {NeedExp = 4.28e+24},
    {NeedExp = 4.69e+24},
    {NeedExp = 5.13e+24},
    {NeedExp = 5.62e+24},
    {NeedExp = 6.16e+24},
    {NeedExp = 6.74e+24},
    {NeedExp = 7.38e+24},
    {NeedExp = 8.08e+24},
    {NeedExp = 8.85e+24},
    {NeedExp = 9.69e+24},
    {NeedExp = 1.06e+25},
    {NeedExp = 1.16e+25},
    {NeedExp = 1.27e+25},
    {NeedExp = 1.39e+25},
    {NeedExp = 1.53e+25},
    {NeedExp = 1.67e+25},
    {NeedExp = 1.83e+25},
    {NeedExp = 2e+25},
    {NeedExp = 2.19e+25},
    {NeedExp = 2.4e+25},
    {NeedExp = 2.63e+25},
    {NeedExp = 2.88e+25},
    {NeedExp = 3.15e+25},
    {NeedExp = 3.45e+25},
    {NeedExp = 3.78e+25},
    {NeedExp = 4.14e+25},
    {NeedExp = 4.53e+25},
    {NeedExp = 4.96e+25},
    {NeedExp = 5.44e+25},
    {NeedExp = 5.95e+25},
    {NeedExp = 6.52e+25},
    {NeedExp = 7.14e+25},
    {NeedExp = 7.81e+25},
    {NeedExp = 8.56e+25},
    {NeedExp = 9.37e+25},
    {NeedExp = 1.03e+26},
    {NeedExp = 1.12e+26},
    {NeedExp = 1.23e+26},
    {NeedExp = 1.35e+26},
    {NeedExp = 1.48e+26},
    {NeedExp = 1.62e+26},
    {NeedExp = 1.77e+26},
    {NeedExp = 1.94e+26},
    {NeedExp = 2.12e+26},
    {NeedExp = 2.32e+26},
    {NeedExp = 2.54e+26},
    {NeedExp = 2.78e+26},
    {NeedExp = 3.05e+26},
    {NeedExp = 3.34e+26},
    {NeedExp = 3.66e+26},
    {NeedExp = 4e+26},
    {NeedExp = 4.38e+26},
    {NeedExp = 4.8e+26},
    {NeedExp = 5.26e+26},
    {NeedExp = 5.75e+26},
    {NeedExp = 6.3e+26},
    {NeedExp = 6.9e+26},
    {NeedExp = 7.56e+26},
    {NeedExp = 8.27e+26},
    {NeedExp = 9.06e+26},
    {NeedExp = 9.92e+26},
    {NeedExp = 1.09e+27},
    {NeedExp = 1.19e+27},
    {NeedExp = 1.3e+27},
    {NeedExp = 1.43e+27},
    {NeedExp = 1.56e+27},
    {NeedExp = 1.71e+27},
    {NeedExp = 1.87e+27},
    {NeedExp = 2.05e+27},
    {NeedExp = 2.25e+27},
    {NeedExp = 2.46e+27},
    {NeedExp = 2.69e+27},
    {NeedExp = 2.95e+27},
    {NeedExp = 3.23e+27},
    {NeedExp = 3.53e+27},
    {NeedExp = 3.87e+27},
    {NeedExp = 4.24e+27},
    {NeedExp = 4.64e+27},
    {NeedExp = 5.08e+27},
    {NeedExp = 5.56e+27},
    {NeedExp = 6.09e+27},
    {NeedExp = 6.67e+27},
    {NeedExp = 7.3e+27},
    {NeedExp = 8e+27},
    {NeedExp = 8.76e+27},
    {NeedExp = 9.59e+27},
    {NeedExp = 1.05e+28},
    {NeedExp = 1.15e+28},
    {NeedExp = 1.26e+28},
    {NeedExp = 1.38e+28},
    {NeedExp = 1.51e+28},
    {NeedExp = 1.65e+28},
    {NeedExp = 1.81e+28},
    {NeedExp = 1.98e+28},
    {NeedExp = 2.17e+28},
    {NeedExp = 2.38e+28},
    {NeedExp = 2.6e+28},
    {NeedExp = 2.85e+28},
    {NeedExp = 3.12e+28},
    {NeedExp = 3.42e+28},
    {NeedExp = 3.74e+28},
    {NeedExp = 4.1e+28},
    {NeedExp = 4.49e+28},
    {NeedExp = 4.91e+28},
    {NeedExp = 5.38e+28},
    {NeedExp = 5.89e+28},
    {NeedExp = 6.45e+28},
    {NeedExp = 7.06e+28},
    {NeedExp = 7.73e+28},
    {NeedExp = 8.47e+28},
    {NeedExp = 9.27e+28},
    {NeedExp = 1.02e+29},
    {NeedExp = 1.11e+29},
    {NeedExp = 1.22e+29},
    {NeedExp = 1.33e+29},
    {NeedExp = 1.46e+29},
    {NeedExp = 1.6e+29},
    {NeedExp = 1.75e+29},
    {NeedExp = 1.92e+29},
    {NeedExp = 2.1e+29},
    {NeedExp = 2.3e+29},
    {NeedExp = 2.52e+29},
    {NeedExp = 2.76e+29},
    {NeedExp = 3.02e+29},
    {NeedExp = 3.3e+29},
    {NeedExp = 3.62e+29},
    {NeedExp = 3.96e+29},
    {NeedExp = 4.34e+29},
    {NeedExp = 4.75e+29},
    {NeedExp = 5.2e+29},
    {NeedExp = 5.69e+29},
    {NeedExp = 6.24e+29},
    {NeedExp = 6.83e+29},
    {NeedExp = 7.48e+29},
    {NeedExp = 8.19e+29},
    {NeedExp = 8.96e+29},
    {NeedExp = 9.82e+29},
    {NeedExp = 1.07e+30},
    {NeedExp = 1.18e+30},
    {NeedExp = 1.29e+30},
    {NeedExp = 1.41e+30},
    {NeedExp = 1.55e+30},
    {NeedExp = 1.69e+30},
    {NeedExp = 1.85e+30},
    {NeedExp = 2.03e+30},
    {NeedExp = 2.22e+30},
    {NeedExp = 2.43e+30},
    {NeedExp = 2.66e+30},
    {NeedExp = 2.92e+30},
    {NeedExp = 3.19e+30},
    {NeedExp = 3.5e+30},
    {NeedExp = 3.83e+30},
    {NeedExp = 4.19e+30},
    {NeedExp = 4.59e+30},
    {NeedExp = 5.03e+30},
    {NeedExp = 5.51e+30},
    {NeedExp = 6.03e+30},
    {NeedExp = 6.6e+30},
    {NeedExp = 7.23e+30},
    {NeedExp = 7.92e+30},
    {NeedExp = 8.67e+30},
    {NeedExp = 9.49e+30},
    {NeedExp = 1.04e+31},
    {NeedExp = 1.14e+31},
    {NeedExp = 1.25e+31},
    {NeedExp = 1.36e+31},
    {NeedExp = 1.49e+31},
    {NeedExp = 1.64e+31},
    {NeedExp = 1.79e+31},
    {NeedExp = 1.96e+31},
    {NeedExp = 2.15e+31},
    {NeedExp = 2.35e+31},
    {NeedExp = 2.58e+31},
    {NeedExp = 2.82e+31},
    {NeedExp = 3.09e+31},
    {NeedExp = 3.38e+31},
    {NeedExp = 3.7e+31},
    {NeedExp = 4.05e+31},
    {NeedExp = 4.44e+31},
    {NeedExp = 4.86e+31},
    {NeedExp = 5.32e+31},
    {NeedExp = 5.83e+31},
    {NeedExp = 6.38e+31},
    {NeedExp = 6.99e+31},
    {NeedExp = 7.65e+31},
    {NeedExp = 8.38e+31},
    {NeedExp = 9.18e+31},
    {NeedExp = 1e+32},
    {NeedExp = 1.1e+32},
    {NeedExp = 1.2e+32},
    {NeedExp = 1.32e+32},
    {NeedExp = 1.44e+32},
    {NeedExp = 1.58e+32},
    {NeedExp = 1.73e+32},
    {NeedExp = 1.9e+32},
    {NeedExp = 2.08e+32},
    {NeedExp = 2.27e+32},
    {NeedExp = 2.49e+32},
    {NeedExp = 2.73e+32},
    {NeedExp = 2.99e+32},
    {NeedExp = 3.27e+32},
    {NeedExp = 3.58e+32},
    {NeedExp = 3.92e+32},
    {NeedExp = 4.29e+32},
    {NeedExp = 4.7e+32},
    {NeedExp = 5.15e+32},
    {NeedExp = 5.64e+32},
    {NeedExp = 6.17e+32},
    {NeedExp = 6.76e+32},
    {NeedExp = 7.4e+32},
    {NeedExp = 8.1e+32},
    {NeedExp = 8.87e+32},
    {NeedExp = 9.71e+32},
    {NeedExp = 1.06e+33},
    {NeedExp = 1.16e+33},
    {NeedExp = 1.28e+33},
    {NeedExp = 1.4e+33},
    {NeedExp = 1.53e+33},
    {NeedExp = 1.67e+33},
    {NeedExp = 1.83e+33},
    {NeedExp = 2.01e+33},
    {NeedExp = 2.2e+33},
    {NeedExp = 2.41e+33},
    {NeedExp = 2.64e+33},
    {NeedExp = 2.89e+33},
    {NeedExp = 3.16e+33},
    {NeedExp = 3.46e+33},
    {NeedExp = 3.79e+33},
    {NeedExp = 4.15e+33},
    {NeedExp = 4.54e+33},
    {NeedExp = 4.98e+33},
    {NeedExp = 5.45e+33},
    {NeedExp = 5.97e+33},
    {NeedExp = 6.53e+33},
    {NeedExp = 7.15e+33},
    {NeedExp = 7.83e+33},
    {NeedExp = 8.58e+33},
    {NeedExp = 9.39e+33},
    {NeedExp = 1.03e+34},
    {NeedExp = 1.13e+34},
    {NeedExp = 1.23e+34},
    {NeedExp = 1.35e+34},
    {NeedExp = 1.48e+34},
    {NeedExp = 1.62e+34},
    {NeedExp = 1.77e+34},
    {NeedExp = 1.94e+34},
    {NeedExp = 2.13e+34},
    {NeedExp = 2.33e+34},
    {NeedExp = 2.55e+34},
    {NeedExp = 2.79e+34},
    {NeedExp = 3.06e+34},
    {NeedExp = 3.35e+34},
    {NeedExp = 3.66e+34},
    {NeedExp = 4.01e+34},
    {NeedExp = 4.39e+34},
    {NeedExp = 4.81e+34},
    {NeedExp = 5.27e+34},
    {NeedExp = 5.77e+34},
    {NeedExp = 6.32e+34},
    {NeedExp = 6.92e+34},
    {NeedExp = 7.57e+34},
    {NeedExp = 8.29e+34},
    {NeedExp = 9.08e+34},
    {NeedExp = 9.94e+34},
    {NeedExp = 1.09e+35},
    {NeedExp = 1.19e+35},
    {NeedExp = 1.31e+35},
    {NeedExp = 1.43e+35},
    {NeedExp = 1.57e+35},
    {NeedExp = 1.71e+35},
    {NeedExp = 1.88e+35},
    {NeedExp = 2.06e+35},
    {NeedExp = 2.25e+35},
    {NeedExp = 2.46e+35},
    {NeedExp = 2.7e+35},
    {NeedExp = 2.95e+35},
    {NeedExp = 3.24e+35},
    {NeedExp = 3.54e+35},
    {NeedExp = 3.88e+35},
    {NeedExp = 4.25e+35},
    {NeedExp = 4.65e+35},
    {NeedExp = 5.09e+35},
    {NeedExp = 5.58e+35},
    {NeedExp = 6.11e+35},
    {NeedExp = 6.69e+35},
    {NeedExp = 7.32e+35},
    {NeedExp = 8.02e+35},
    {NeedExp = 8.78e+35},
    {NeedExp = 9.61e+35},
    {NeedExp = 1.05e+36},
    {NeedExp = 1.15e+36},
    {NeedExp = 1.26e+36},
    {NeedExp = 1.38e+36},
    {NeedExp = 1.51e+36},
    {NeedExp = 1.66e+36},
    {NeedExp = 1.81e+36},
    {NeedExp = 1.99e+36},
    {NeedExp = 2.18e+36},
    {NeedExp = 2.38e+36},
    {NeedExp = 2.61e+36},
    {NeedExp = 2.86e+36},
    {NeedExp = 3.13e+36},
    {NeedExp = 3.43e+36},
    {NeedExp = 3.75e+36},
    {NeedExp = 4.11e+36},
    {NeedExp = 4.5e+36},
    {NeedExp = 4.92e+36},
    {NeedExp = 5.39e+36},
    {NeedExp = 5.9e+36},
    {NeedExp = 6.47e+36},
    {NeedExp = 7.08e+36},
    {NeedExp = 7.75e+36},
    {NeedExp = 8.49e+36},
    {NeedExp = 9.3e+36},
    {NeedExp = 1.02e+37},
    {NeedExp = 1.11e+37},
    {NeedExp = 1.22e+37},
    {NeedExp = 1.34e+37},
    {NeedExp = 1.46e+37},
    {NeedExp = 1.6e+37},
    {NeedExp = 1.75e+37},
    {NeedExp = 1.92e+37},
    {NeedExp = 2.1e+37},
    {NeedExp = 2.3e+37},
    {NeedExp = 2.52e+37},
    {NeedExp = 2.76e+37},
    {NeedExp = 3.02e+37},
    {NeedExp = 3.31e+37},
    {NeedExp = 3.63e+37},
    {NeedExp = 3.97e+37},
    {NeedExp = 4.35e+37},
    {NeedExp = 4.76e+37},
    {NeedExp = 5.21e+37},
    {NeedExp = 5.71e+37},
    {NeedExp = 6.25e+37},
    {NeedExp = 6.85e+37},
    {NeedExp = 7.5e+37},
    {NeedExp = 8.21e+37},
    {NeedExp = 8.99e+37},
    {NeedExp = 9.84e+37},
    {NeedExp = 1.08e+38},
    {NeedExp = 1.18e+38},
    {NeedExp = 1.29e+38},
    {NeedExp = 1.41e+38},
    {NeedExp = 1.55e+38},
    {NeedExp = 1.7e+38},
    {NeedExp = 1.86e+38},
    {NeedExp = 2.03e+38},
    {NeedExp = 2.23e+38},
    {NeedExp = 2.44e+38},
    {NeedExp = 2.67e+38},
    {NeedExp = 2.92e+38},
    {NeedExp = 3.2e+38},
    {NeedExp = 3.51e+38},
    {NeedExp = 3.84e+38},
    {NeedExp = 4.2e+38},
    {NeedExp = 4.6e+38},
    {NeedExp = 5.04e+38},
    {NeedExp = 5.52e+38},
    {NeedExp = 6.04e+38},
    {NeedExp = 6.62e+38},
    {NeedExp = 7.25e+38},
    {NeedExp = 7.94e+38},
    {NeedExp = 8.69e+38},
    {NeedExp = 9.51e+38},
    {NeedExp = 1.04e+39},
    {NeedExp = 1.14e+39},
    {NeedExp = 1.25e+39},
    {NeedExp = 1.37e+39},
    {NeedExp = 1.5e+39},
    {NeedExp = 1.64e+39},
    {NeedExp = 1.8e+39},
    {NeedExp = 1.97e+39},
    {NeedExp = 2.15e+39},
    {NeedExp = 2.36e+39},
    {NeedExp = 2.58e+39},
    {NeedExp = 2.83e+39},
    {NeedExp = 3.1e+39},
    {NeedExp = 3.39e+39},
    {NeedExp = 3.71e+39},
    {NeedExp = 4.06e+39},
    {NeedExp = 4.45e+39},
    {NeedExp = 4.87e+39},
    {NeedExp = 5.34e+39},
    {NeedExp = 5.84e+39},
    {NeedExp = 6.4e+39},
    {NeedExp = 7.01e+39},
    {NeedExp = 7.67e+39},
    {NeedExp = 8.4e+39},
    {NeedExp = 9.2e+39},
    {NeedExp = 1.01e+40},
    {NeedExp = 1.1e+40},
    {NeedExp = 1.21e+40},
    {NeedExp = 1.32e+40},
    {NeedExp = 1.45e+40},
    {NeedExp = 1.59e+40},
    {NeedExp = 1.74e+40},
    {NeedExp = 1.9e+40},
    {NeedExp = 2.08e+40},
    {NeedExp = 2.28e+40},
    {NeedExp = 2.5e+40},
    {NeedExp = 2.73e+40},
    {NeedExp = 2.99e+40},
    {NeedExp = 3.28e+40},
    {NeedExp = 3.59e+40},
    {NeedExp = 3.93e+40},
    {NeedExp = 4.3e+40},
    {NeedExp = 4.71e+40},
    {NeedExp = 5.16e+40},
    {NeedExp = 5.65e+40},
    {NeedExp = 6.19e+40},
    {NeedExp = 6.77e+40},
    {NeedExp = 7.42e+40},
    {NeedExp = 8.12e+40},
    {NeedExp = 8.89e+40},
    {NeedExp = 9.74e+40},
    {NeedExp = 1.07e+41},
    {NeedExp = 1.17e+41},
    {NeedExp = 1.28e+41},
    {NeedExp = 1.4e+41},
    {NeedExp = 1.53e+41},
    {NeedExp = 1.68e+41},
    {NeedExp = 1.84e+41},
    {NeedExp = 2.01e+41},
    {NeedExp = 2.2e+41},
    {NeedExp = 2.41e+41},
    {NeedExp = 2.64e+41},
    {NeedExp = 2.89e+41},
    {NeedExp = 3.17e+41},
    {NeedExp = 3.47e+41},
    {NeedExp = 3.8e+41},
    {NeedExp = 4.16e+41},
    {NeedExp = 4.56e+41},
    {NeedExp = 4.99e+41},
    {NeedExp = 5.46e+41},
    {NeedExp = 5.98e+41},
    {NeedExp = 6.55e+41},
    {NeedExp = 7.17e+41},
    {NeedExp = 7.85e+41},
    {NeedExp = 8.6e+41},
    {NeedExp = 9.42e+41},
    {NeedExp = 1.03e+42},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Level.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Level.Helper
-- Decompile time: 1.55 ms

local u0 = {}
local Config = require(script.Parent.Config)
local u15 = require(game.ReplicatedStorage.Utils.TableUtils).getTableLegth(Config) - 1

function u0.GetConfig() -- Line: 8 -- upvalues: Config (val)
    return Config
end

function u0.CheckIsMax(a1) -- Line: 12 -- upvalues: u15 (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if u15 <= a1 then
        return true
    end
    return false
end

function u0.GetNeedExp(a1) -- Line: 22 -- upvalues: Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if Config[a1] then
        return Config[a1].NeedExp
    end
    return (1 / 0)
end

function u0.GetLevelPercent(a1, a2) -- Line: 32 -- upvalues: u0 (val)
    if u0.CheckIsMax(a1) then
        return 1
    end
    return (math.clamp(a2 / (u0.GetNeedExp(a1 + 1)), 0, 1))
end

function u0.GetTotalPower(a1) -- Line: 42 -- upvalues: Config (val)
    local v1 = 0
    for i = 0, a1 do
        if Config[i] then
            v1 = v1 + Config[i].NeedExp
        end
    end
    return v1
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Limited.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Limited.Helper
-- Decompile time: 0.41 ms

local v1 = {}
local u1 = {GearSet_2 = 500}

function v1.GetConfig() -- Line: 7 -- upvalues: u1 (val)
    return u1
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Material.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Material.Config
-- Decompile time: 0.30 ms

return {
    Dungeon_Ticket = {Rarity = "Mythic"},
    EnhantStone_1 = {Rarity = "Legendary"},
    EnhantStone_2 = {Rarity = "Mythic"},
    EnhantProtect = {Rarity = "Infinite"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Material.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Material.Helper
-- Decompile time: 1.66 ms

local v1 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)

function v1.GetConfig() -- Line: 7 -- upvalues: Config (val)
    return Config
end

function v1.GetShow() -- Line: 10 -- upvalues: Show (val)
    return Show
end

function v1.CheckID(a1) -- Line: 13 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

function v1.GetLayout(a1) -- Line: 20 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return (math.round(Config[a1].Price))
    end
end

function v1.GetProperty(a1, a2) -- Line: 27 -- upvalues: Config (val) -- types: a1: string, a2: string
    local v1 = Config[a1]
    if v1 == nil then
        return nil
    end
    return v1[a2]
end

function v1.GetSellPrice(a1) -- Line: 35 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Price
    end
    return nil
end

function v1.GetDisName(a1) -- Line: 42 -- upvalues: Show (val) -- types: a1: string
    return Show[a1].DisplayName
end

function v1.GetImage(a1) -- Line: 45 -- upvalues: Show (val) -- types: a1: string
    return Show[a1].Image
end

function v1.GetDescription(a1) -- Line: 48 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Description
    end
    return nil
end

function v1.GetRarity(a1) -- Line: 54 -- upvalues: Config (val) -- types: a1: string
    return Config[a1].Rarity
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Material.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Material.Show
-- Decompile time: 0.40 ms

return {
    Dungeon_Ticket = {
        DisplayName = "Tower Ticket",
        Image = "rbxassetid://134346021912001",
        Description = "Consume one ticket to start a run of the Frostbound Tower.",
    },
    EnhantStone_1 = {
        DisplayName = "Ember Stone",
        Image = "rbxassetid://93499783424371",
        Description = "Material used for equipment enhancement.",
    },
    EnhantStone_2 = {
        DisplayName = "Prismatic Stone",
        Image = "rbxassetid://82349102842491",
        Description = "A rare enhancement material.",
    },
    EnhantProtect = {
        DisplayName = "Protection Scroll",
        Image = "rbxassetid://96105811123337",
        Description = "It prevents your equipment level from dropping when enhancement fails.",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Material.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Material.Show
-- Decompile time: 0.40 ms

return {
    Dungeon_Ticket = {
        DisplayName = "Tower Ticket",
        Image = "rbxassetid://134346021912001",
        Description = "Consume one ticket to start a run of the Frostbound Tower.",
    },
    EnhantStone_1 = {
        DisplayName = "Ember Stone",
        Image = "rbxassetid://93499783424371",
        Description = "Material used for equipment enhancement.",
    },
    EnhantStone_2 = {
        DisplayName = "Prismatic Stone",
        Image = "rbxassetid://82349102842491",
        Description = "A rare enhancement material.",
    },
    EnhantProtect = {
        DisplayName = "Protection Scroll",
        Image = "rbxassetid://96105811123337",
        Description = "It prevents your equipment level from dropping when enhancement fails.",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Online.Reward
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Online.Reward
-- Decompile time: 0.81 ms

return {
    ["1"] = {Time = 60, Type = "TimePower", ID = "power", Number = 10},
    ["2"] = {Time = 180, Type = "Eco", ID = "coin", Number = 200},
    ["3"] = {Time = 300, Type = "Material", ID = "Dungeon_Ticket", Number = 1},
    ["4"] = {Time = 480, Type = "TimePower", ID = "power", Number = 30},
    ["5"] = {Time = 600, Type = "Material", ID = "Dungeon_Ticket", Number = 1},
    ["6"] = {Time = 900, Type = "Eco", ID = "coin", Number = 1500},
    ["7"] = {Time = 1200, Type = "Buff", ID = "Luck_1", Number = 300},
    ["8"] = {Time = 1800, Type = "TimePower", ID = "power", Number = 90},
    ["9"] = {Time = 2700, Type = "Eco", ID = "coin", Number = 5000},
    ["10"] = {Time = 3600, Type = "GameSetting", ID = "ClassRoll", Number = 1},
    ["11"] = {Time = 5400, Type = "Buff", ID = "Train_1", Number = 300},
    ["12"] = {Time = 7200, Type = "Material", ID = "Dungeon_Ticket", Number = 2},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Online.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Online.Helper
-- Decompile time: 0.86 ms

local v1 = {
    GetBoostByTime = function(a1) -- Line: 3
        return math.floor(a1 / 60) * 0.01
    end,
}
local u2 = {
    ["1"] = 60,
    ["2"] = 180,
    ["3"] = 300,
    ["4"] = 480,
    ["5"] = 600,
    ["6"] = 900,
    ["7"] = 1200,
    ["8"] = 1500,
    ["9"] = 1800,
    ["10"] = 2400,
    ["11"] = 3000,
    ["12"] = 5400,
}

function v1.GetOnlineTimeConfig() -- Line: 23 -- upvalues: u2 (val)
    return u2
end

function v1.GetOnlineRewardConfig() -- Line: 27
    return require(script.Parent.Reward)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Ore.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Ore.Helper
-- Decompile time: 2.35 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.TableUtils)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)

function u0.GetConfig() -- Line: 9 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 13 -- upvalues: Show (val)
    return Show
end

function u0.CheckID(a1) -- Line: 17 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

function u0.GetDisName(a1) -- Line: 24 -- upvalues: Show (val) -- types: a1: string
    if Show[a1] then
        return Show[a1].DisplayName
    end
end

function u0.GetImage(a1) -- Line: 29 -- upvalues: Show (val) -- types: a1: string
    if Show[a1] then
        return Show[a1].Image
    end
end

function u0.GetLayout(a1) -- Line: 34 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return Config[a1].Layout
    end
end

function u0.GetQuality(a1) -- Line: 40 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Quality
    end
end

function u0.GetRarityNumber(a1) -- Line: 46 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Rarity
    end
end

function u0.GetRarity(a1) -- Line: 53 -- upvalues: Config (val), Helper (val)
    if Config[a1] then
        return Helper.GetTextRarity(Config[a1].Rarity)
    end
end

function u0.GetPower(a1) -- Line: 61 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Power
    end
end

function u0.GetPrice(a1) -- Line: 67 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Price
    end
end

function u0.GetSellPrice(a1) -- Line: 73 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Price
    end
end

function u0.GetOreByRarity(a1) -- Line: 79 -- upvalues: Config (val), u0 (val)
    local v1 = {}
    for i, j in Config do
        if u0.GetRarity(i) == a1 then
            v1[i] = 1
        end
    end
    return v1
end

return u0
 -- Script Path: game:GetService("ReplicatedStorage").Config.Ore.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Ore.Show
-- Decompile time: 1.84 ms

return {
    Ore_1 = {Image = "rbxassetid://70687243281478", DisplayName = "Stone"},
    Ore_2 = {Image = "rbxassetid://91375278381139", DisplayName = "Copper"},
    Ore_3 = {Image = "rbxassetid://102089858703012", DisplayName = "Jade"},
    Ore_4 = {Image = "rbxassetid://84705650200696", DisplayName = "Silver"},
    Ore_5 = {Image = "rbxassetid://89199456178179", DisplayName = "Quartz"},
    Ore_6 = {Image = "rbxassetid://72914643920266", DisplayName = "Ruby"},
    Ore_7 = {Image = "rbxassetid://92057497427085", DisplayName = "Amethyst"},
    Ore_8 = {Image = "rbxassetid://78693794575625", DisplayName = "Nova Ore"},
    Ore_9 = {Image = "rbxassetid://128525886812079", DisplayName = "Fire Crystal"},
    Ore_10 = {Image = "rbxassetid://128814450760552", DisplayName = "Sapphire"},
    Ore_11 = {Image = "rbxassetid://104106227551716", DisplayName = "Obsidian"},
    Ore_12 = {Image = "rbxassetid://128362215278727", DisplayName = "Gold"},
    Ore_13 = {Image = "rbxassetid://81646703366149", DisplayName = "Mystic Crystal"},
    Ore_14 = {Image = "rbxassetid://106127917467118", DisplayName = "Topaz"},
    Ore_15 = {Image = "rbxassetid://71804714983129", DisplayName = "Sunfire Ore"},
    Ore_16 = {Image = "rbxassetid://123923324248432", DisplayName = "Crimson"},
    Ore_17 = {Image = "rbxassetid://101718600287573", DisplayName = "Emerald"},
    Ore_18 = {Image = "rbxassetid://80398223433664", DisplayName = "Diamond"},
    Ore_19 = {Image = "rbxassetid://118353166942823", DisplayName = "Frostbite"},
    Ore_20 = {Image = "rbxassetid://123873540543956", DisplayName = "Arcane"},
    Ore_21 = {Image = "rbxassetid://109488450401672", DisplayName = "Bone Ore"},
    Ore_22 = {Image = "rbxassetid://83811382026252", DisplayName = "Amber"},
    Ore_23 = {Image = "rbxassetid://112342001561640", DisplayName = "Plasma Core"},
    Ore_24 = {Image = "rbxassetid://94059116673432", DisplayName = "Void Shard"},
    Ore_25 = {Image = "rbxassetid://97466811006975", DisplayName = "Demon Eye"},
    Ore_26 = {Image = "rbxassetid://102822246913881", DisplayName = "Magma Cluster"},
    Ore_27 = {Image = "rbxassetid://97201310943411", DisplayName = "Abyssal Blue"},
    Ore_28 = {Image = "rbxassetid://110628674088477", DisplayName = "Acid Crystal"},
    Ore_29 = {Image = "rbxassetid://138208836467406", DisplayName = "Toxic Shard"},
    Ore_30 = {Image = "rbxassetid://112819809831796", DisplayName = "Solar Flare"},
    Ore_31 = {Image = "rbxassetid://78209096226722", DisplayName = "Omni"},
    Ore_32 = {Image = "rbxassetid://78910135326255", DisplayName = "Dark Matter"},
    Ore_33 = {Image = "rbxassetid://103112937407162", DisplayName = "Void Core"},
    Ore_34 = {Image = "rbxassetid://111361665218435", DisplayName = "Cryo-Stasis"},
    Ore_35 = {Image = "rbxassetid://101071946075818", DisplayName = "Ignis Totem"},
    Ore_36 = {Image = "rbxassetid://101473532100073", DisplayName = "Sunstone"},
    Ore_37 = {Image = "rbxassetid://136090896095326", DisplayName = "Toxic"},
    Ore_38 = {Image = "rbxassetid://90478806092769", DisplayName = "Glitch"},
    Ore_39 = {Image = "rbxassetid://90133402428587", DisplayName = "Prism"},
    Ore_40 = {Image = "rbxassetid://132967674721978", DisplayName = "Colanite"},
    Ore_41 = {Image = "rbxassetid://125852043363398", DisplayName = "Yeti-Claw"},
    Ore_42 = {Image = "rbxassetid://79976346778817", DisplayName = "Glac-Box"},
    Ore_43 = {Image = "rbxassetid://87347618877154", DisplayName = "Toxium"},
    Ore_44 = {Image = "rbxassetid://129349828199123", DisplayName = "Rust-Sludge"},
    Ore_45 = {Image = "rbxassetid://73188314390650", DisplayName = "Magmacore"},
    Ore_46 = {Image = "rbxassetid://92035147916058", DisplayName = "Bussin-Ice"},
    Ore_47 = {Image = "rbxassetid://81883127651490", DisplayName = "Panic-Core"},
    Ore_48 = {Image = "rbxassetid://131010946799338", DisplayName = "The Apex"},
}
 -- Script Path: game:GetService("ReplicatedStorage").Config.Ore.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Ore.Config
-- Decompile time: 2.94 ms

return {
    Ore_1 = {
        Layout = 1,
        Rarity = 1,
        Quality = 1,
        Power = 1.2,
        Price = 8,
    },
    Ore_2 = {
        Layout = 2,
        Rarity = 1,
        Quality = 2,
        Power = 1.5,
        Price = 14,
    },
    Ore_3 = {
        Layout = 3,
        Rarity = 1,
        Quality = 2,
        Power = 2,
        Price = 21,
    },
    Ore_4 = {
        Layout = 4,
        Rarity = 2,
        Quality = 4,
        Power = 2.6,
        Price = 35,
    },
    Ore_5 = {
        Layout = 5,
        Rarity = 2,
        Quality = 4,
        Power = 3.4,
        Price = 40,
    },
    Ore_6 = {
        Layout = 6,
        Rarity = 2,
        Quality = 4,
        Power = 4,
        Price = 55,
    },
    Ore_7 = {
        Layout = 7,
        Rarity = 3,
        Quality = 4,
        Power = 5,
        Price = 60,
    },
    Ore_8 = {
        Layout = 8,
        Rarity = 3,
        Quality = 4,
        Power = 6,
        Price = 82,
    },
    Ore_9 = {
        Layout = 9,
        Rarity = 3,
        Quality = 4,
        Power = 7,
        Price = 125,
    },
    Ore_10 = {
        Layout = 10,
        Rarity = 4,
        Quality = 3.8,
        Power = 8,
        Price = 150,
    },
    Ore_11 = {
        Layout = 11,
        Rarity = 4,
        Quality = 3.8,
        Power = 10,
        Price = 175,
    },
    Ore_12 = {
        Layout = 12,
        Rarity = 4,
        Quality = 3.8,
        Power = 12,
        Price = 200,
    },
    Ore_13 = {
        Layout = 13,
        Rarity = 4,
        Quality = 4,
        Power = 11,
        Price = 225,
    },
    Ore_14 = {
        Layout = 14,
        Rarity = 5,
        Quality = 4,
        Power = 12,
        Price = 777,
    },
    Ore_15 = {
        Layout = 15,
        Rarity = 5,
        Quality = 4,
        Power = 13,
        Price = 932,
    },
    Ore_16 = {
        Layout = 16,
        Rarity = 5,
        Quality = 4,
        Power = 19,
        Price = 1120,
    },
    Ore_17 = {
        Layout = 17,
        Rarity = 5,
        Quality = 4,
        Power = 20,
        Price = 1340,
    },
    Ore_18 = {
        Layout = 18,
        Rarity = 5,
        Quality = 5,
        Power = 23,
        Price = 1610,
    },
    Ore_19 = {
        Layout = 19,
        Rarity = 5,
        Quality = 5,
        Power = 25,
        Price = 1930,
    },
    Ore_20 = {
        Layout = 20,
        Rarity = 6,
        Quality = 5,
        Power = 27,
        Price = 2320,
    },
    Ore_21 = {
        Layout = 21,
        Rarity = 6,
        Quality = 5,
        Power = 30,
        Price = 2780,
    },
    Ore_22 = {
        Layout = 22,
        Rarity = 6,
        Quality = 6,
        Power = 31,
        Price = 3531,
    },
    Ore_23 = {
        Layout = 23,
        Rarity = 6,
        Quality = 7,
        Power = 35,
        Price = 4823,
    },
    Ore_24 = {
        Layout = 24,
        Rarity = 6,
        Quality = 8,
        Power = 38,
        Price = 5524,
    },
    Ore_25 = {
        Layout = 25,
        Rarity = 6,
        Quality = 8,
        Power = 42,
        Price = 6120,
    },
    Ore_26 = {
        Layout = 26,
        Rarity = 7,
        Quality = 5,
        Power = 45,
        Price = 6950,
    },
    Ore_27 = {
        Layout = 27,
        Rarity = 7,
        Quality = 6,
        Power = 48,
        Price = 7230,
    },
    Ore_28 = {
        Layout = 28,
        Rarity = 7,
        Quality = 6,
        Power = 52,
        Price = 7990,
    },
    Ore_29 = {
        Layout = 29,
        Rarity = 7,
        Quality = 6,
        Power = 57,
        Price = 8250,
    },
    Ore_30 = {
        Layout = 30,
        Rarity = 7,
        Quality = 6,
        Power = 63,
        Price = 9100,
    },
    Ore_31 = {
        Layout = 31,
        Rarity = 7,
        Quality = 6,
        Power = 60,
        Price = 11200,
    },
    Ore_32 = {
        Layout = 32,
        Rarity = 8,
        Quality = 6,
        Power = 60,
        Price = 12528,
    },
    Ore_33 = {
        Layout = 33,
        Rarity = 8,
        Quality = 4,
        Power = 60,
        Price = 13420,
    },
    Ore_34 = {
        Layout = 34,
        Rarity = 8,
        Quality = 4,
        Power = 65,
        Price = 14555,
    },
    Ore_35 = {
        Layout = 35,
        Rarity = 8,
        Quality = 5,
        Power = 68,
        Price = 16230,
    },
    Ore_36 = {
        Layout = 36,
        Rarity = 8,
        Quality = 5,
        Power = 70,
        Price = 18800,
    },
    Ore_37 = {
        Layout = 37,
        Rarity = 8,
        Quality = 6,
        Power = 73,
        Price = 21000,
    },
    Ore_38 = {
        Layout = 38,
        Rarity = 8,
        Quality = 6,
        Power = 76,
        Price = 23250,
    },
    Ore_39 = {
        Layout = 39,
        Rarity = 8,
        Quality = 6,
        Power = 75,
        Price = 25539,
    },
    Ore_40 = {
        Layout = 40,
        Rarity = 9,
        Quality = 6,
        Power = 78,
        Price = 27980,
    },
    Ore_41 = {
        Layout = 41,
        Rarity = 9,
        Quality = 6,
        Power = 80,
        Price = 30000,
    },
    Ore_42 = {
        Layout = 42,
        Rarity = 9,
        Quality = 6,
        Power = 85,
        Price = 32420,
    },
    Ore_43 = {
        Layout = 43,
        Rarity = 9,
        Quality = 6,
        Power = 93,
        Price = 36732,
    },
    Ore_44 = {
        Layout = 44,
        Rarity = 9,
        Quality = 6,
        Power = 99,
        Price = 42000,
    },
    Ore_45 = {
        Layout = 45,
        Rarity = 9,
        Quality = 6,
        Power = 102,
        Price = 47000,
    },
    Ore_46 = {
        Layout = 46,
        Rarity = 9,
        Quality = 6,
        Power = 114,
        Price = 53200,
    },
    Ore_47 = {
        Layout = 47,
        Rarity = 9,
        Quality = 7,
        Power = 128,
        Price = 60000,
    },
    Ore_48 = {
        Layout = 48,
        Rarity = 10,
        Quality = 7,
        Power = 140,
        Price = 80000,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.Config
-- Decompile time: 7.33 ms

return {
    G_ATK_1 = {
        ActionTime = 0.38,
        Phase = {
            {
                DelayTime = 0.2,
                CameraShake = "Shake_2",
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(23, 23, 23),
                    Damage = 1,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_ATK_2 = {
        ActionTime = 0.42,
        Phase = {
            {
                DelayTime = 0.2,
                CameraShake = "Shake_2",
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(23, 23, 23),
                    Damage = 1,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_ATK_3 = {
        ActionTime = 0.6,
        Phase = {
            {
                DelayTime = 0.3,
                CameraShake = "Shake_2",
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(12, 60, 16),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_ATK_1 = {
        ActionTime = 0.4,
        Phase = {
            {
                DelayTime = 0.15,
                CameraShake = "Shake_1",
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(11, 60, 12),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_ATK_2 = {
        ActionTime = 0.4,
        Phase = {
            {
                DelayTime = 0.15,
                CameraShake = "Shake_1",
                DamageConfig = {
                    Offset = Vector3.new(5, 0, 0),
                    Size = Vector3.new(9, 60, 14),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_ATK_3 = {
        ActionTime = 0.4,
        Phase = {
            {
                DelayTime = 0.25,
                CameraShake = "Shake_1",
                DamageConfig = {
                    Offset = Vector3.new(7, 0, 0),
                    Size = Vector3.new(9, 60, 15),
                    Damage = 1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    G_Skill_1 = {
        ActionTime = 0.7,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.3,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(10, 0, 0),
                    Size = Vector3.new(25, 60, 25),
                    Damage = 2.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_2 = {
        ActionTime = 0.5,
        CD = 6.5,
        Phase = {
            {
                DelayTime = 0.4,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(34, 60, 34),
                    Damage = 3,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_3 = {
        ActionTime = 1,
        CD = 7,
        Phase = {
            {DelayTime = 0.2},
            {DelayTime = 0.6},
            {
                DelayTime = 0.8,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(30, 60, 30),
                    Damage = 2,
                    Shape = Enum.PartType.Ball,
                },
            },
            {
                DelayTime = 1,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(30, 60, 30),
                    Damage = 2.5,
                    RingTime = 1.2,
                    DamageInterval = 0.4,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_4 = {
        ActionTime = 0.8333333333333334,
        CD = 7.5,
        Phase = {
            {
                DelayTime = 0.5833333333333334,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(10, 0, 0),
                    Size = Vector3.new(15, 60, 20),
                    Damage = 2.5,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.6833333333333333,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(20, 60, 20),
                    Damage = 3.6,
                    RingTime = 2,
                    DamageInterval = 0.3,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_5 = {
        ActionTime = 1.6666666666666667,
        CD = 8,
        Phase = {
            {
                DelayTime = 0.4,
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(8, 0, 0),
                    Size = Vector3.new(15, 60, 16),
                    Damage = 1.5,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.8,
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(8, 0, 0),
                    Size = Vector3.new(15, 60, 16),
                    Damage = 1.5,
                    Shape = Enum.PartType.Block,
                },
            },
            {DelayTime = 1.3},
            {
                DelayTime = 1.65,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(9, 0, 0),
                    Size = Vector3.new(25, 60, 20),
                    Damage = 3,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    G_Skill_6 = {
        ActionTime = 1.4166666666666667,
        CD = 8.5,
        Phase = {
            {DelayTime = 0},
            {
                DelayTime = 0.6,
                DamageConfig = {
                    Offset = Vector3.new(7, 0, 0),
                    Size = Vector3.new(15, 60, 15),
                    Damage = 3,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 1.25,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(24, 24, 24),
                    Damage = 2,
                    Number = 3,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_7 = {
        ActionTime = 1,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.5,
                CameraShake = "G_Skill_7",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(12, 40, 6),
                    Damage = 4.55,
                    FlightSpeed = 50,
                    FlightTime = 0.5,
                    DamageInterval = 0.1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    G_Skill_8 = {
        ActionTime = 0.6,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.5,
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(12, 0, 0),
                    Size = Vector3.new(14, 60, 25),
                    Damage = 6.2,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    G_Skill_9 = {
        ActionTime = 0.9,
        CD = 8,
        Phase = {
            {
                DelayTime = 0.4,
                Velocity = "G_Skill_9",
                DamageConfig = {
                    Offset = Vector3.new(9, 0, 0),
                    Size = Vector3.new(15, 60, 18),
                    Damage = 3,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.8,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(2, 2, 0),
                    Size = Vector3.new(30, 30, 30),
                    Damage = 6.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_10 = {
        ActionTime = 0.8333333333333334,
        CD = 7,
        Phase = {
            {
                DelayTime = 0.6666666666666666,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(2, 0, 0),
                    Size = Vector3.new(25, 60, 25),
                    Damage = 7,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_1 = {
        ActionTime = 0.7,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.45,
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(12, 0, 0),
                    Size = Vector3.new(12, 60, 25),
                    Damage = 2,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_2 = {
        ActionTime = 1,
        CD = 6.5,
        Phase = {
            {
                DelayTime = 0.6,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(15, 60, 12),
                    Damage = 1.5,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.95,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(6, 0, 0),
                    Size = Vector3.new(12, 60, 12),
                    Damage = 1.5,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_3 = {
        ActionTime = 0.5,
        CD = 5.5,
        Phase = {
            {
                DelayTime = 0.35,
                Velocity = "K_Skill_3",
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(15, 0, 0),
                    Size = Vector3.new(15, 60, 30),
                    Damage = 3.2,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_4 = {
        ActionTime = 0.8,
        CD = 5,
        Phase = {
            {
                DelayTime = 0.6,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(8, 0, 0),
                    Size = Vector3.new(18, 60, 18),
                    Damage = 3.5,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_5 = {
        ActionTime = 0.75,
        CD = 7,
        Phase = {
            {
                DelayTime = 0.5,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(20, 0, 0),
                    Size = Vector3.new(15, 60, 45),
                    Damage = 4.5,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_6 = {
        ActionTime = 0.7,
        CD = 7,
        Phase = {
            {
                DelayTime = 0.5,
                CameraShake = "K_Skill_6",
                Velocity = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(12, 0, 0),
                    Size = Vector3.new(12, 60, 25),
                    Damage = 2.5,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.6,
                DamageConfig = {
                    Offset = Vector3.new(10, 1, 0),
                    Size = Vector3.new(25, 25, 25),
                    Damage = 2.5,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    K_Skill_7 = {
        ActionTime = 2.4,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.4,
                DamageConfig = {
                    Offset = Vector3.new(10, 0, 0),
                    Size = Vector3.new(18, 60, 20),
                    Damage = 3.65,
                    RingTime = 2,
                    DamageInterval = 0.2,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_8 = {
        ActionTime = 2.5,
        CD = 7,
        Phase = {
            {
                DelayTime = 0.4,
                DamageConfig = {
                    Offset = Vector3.new(12, 0, 0),
                    Size = Vector3.new(40, 40, 40),
                    Damage = 4.7,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    K_Skill_9 = {
        ActionTime = 2.5,
        CD = 8,
        Phase = {
            {
                DelayTime = 0.5,
                DamageConfig = {
                    Offset = Vector3.new(8, 0, 0),
                    Size = Vector3.new(15, 60, 20),
                    Damage = 2,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.75,
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(25, 25, 25),
                    Damage = 4,
                    RingTime = 1.6666666666666667,
                    DamageInterval = 0.2,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    K_Skill_10 = {
        ActionTime = 0.7,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.5,
                CameraShake = "K_Skill_4",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(10, 40, 15),
                    Damage = 4.5,
                    RingTime = 0.5,
                    DamageInterval = 0.1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_11 = {
        ActionTime = 0.6,
        CD = 6,
        Phase = {
            {
                DelayTime = 0.3,
                CameraShake = "G_Skill_7",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(12, 40, 6),
                    Damage = 3.6,
                    FlightSpeed = 50,
                    FlightTime = 0.5,
                    DamageInterval = 0.1,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
    K_Skill_1001 = {
        ActionTime = 0.7,
        CD = 7,
        Phase = {
            {
                DelayTime = 0.4,
                CameraShake = "K_Skill_6",
                DamageConfig = {
                    Offset = Vector3.new(12, 0, 0),
                    Size = Vector3.new(15, 60, 26),
                    Damage = 4,
                    Shape = Enum.PartType.Block,
                },
            },
            {
                DelayTime = 0.41,
                DamageConfig = {
                    Offset = Vector3.new(30, 0, 0),
                    Size = Vector3.new(20, 20, 20),
                    Damage = 3,
                    Shape = Enum.PartType.Ball,
                },
            },
        },
    },
    G_Skill_1001 = {
        ActionTime = 1.0833333333333333,
        CD = 8,
        Phase = {
            {DelayTime = 0.2, Velocity = "G_Skill_1001"},
            {
                DelayTime = 0.7,
                CameraShake = "G_Skill_1",
                DamageConfig = {
                    Offset = Vector3.new(0, 0, 0),
                    Size = Vector3.new(80, 60, 80),
                    Damage = 11,
                    RingTime = 5,
                    DamageInterval = 0.5,
                    Shape = Enum.PartType.Block,
                },
            },
        },
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.Helper
-- Decompile time: 3.22 ms

local u0 = {}
local Show = require(script.Parent.Show)
local Config = require(script.Parent.Config)
local SkillLoot = require(script.Parent.SkillLoot)
local SkillLevelShow = require(script.Parent.SkillLevelShow)

function u0.GetPlrConfig() -- Line: 9 -- upvalues: Config (val)
    return Config
end

function u0.GetPlrSkillData(a1) -- Line: 13 -- upvalues: Config (val)
    return Config[a1] or nil
end

function u0.GetSkillCD(a1) -- Line: 17 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].CD
    end
end

function u0.GetSkillActionTime(a1) -- Line: 23 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].ActionTime
    end
end

function u0.GetSkillPhases(a1) -- Line: 29 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Phase
    end
end

function u0.GetWeaponSkillLoots(a1, a2) -- Line: 35 -- upvalues: SkillLoot (val)
    return SkillLoot[a1][a2] or nil
end

function u0.GetImage(a1) -- Line: 39 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Image
    end
    return nil
end

function u0.GetDisName(a1) -- Line: 45 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].DisplayName
    end
    return nil
end

function u0.GetDescription(a1) -- Line: 51 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Description
    end
    return nil
end

function u0.GetSkillLevel(a1) -- Line: 58 -- upvalues: Show (val)
    if Show[a1] then
        return Show[a1].Level
    end
    return nil
end

function u0.GetSkillLevelImage(a1) -- Line: 65 -- upvalues: SkillLevelShow (val)
    if SkillLevelShow[a1] then
        return SkillLevelShow[a1].Image
    end
    return nil
end

function u0.GetSkillLevelLayout(a1) -- Line: 72 -- upvalues: SkillLevelShow (val)
    if SkillLevelShow[a1] then
        return SkillLevelShow[a1].Layout
    end
    return nil
end

function u0.GetSkillIDList(a1, a2, a3) -- Line: 80 -- upvalues: Show (val), u0 (val)
    local UnLoot, v1
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5, v6, v7 = a1, a2, a3
    for i, j in Show, v3, v4 do
        if not v5 or i:sub(1, 1) == v5:sub(1, 1) then
            v1 = u0.GetSkillLevel(i)
            UnLoot = j.UnLoot
            if not v6 or v1 == v6 then
                if v7 or not UnLoot then
                    table.insert(v2, i)
                end
            end
        end
    end
    return v2
end

function u0.CheckIsRingSkill(a1) -- Line: 101 -- upvalues: Config (val)
    local DamageConfig
    for i, j in Config[a1].Phase do
        DamageConfig = j.DamageConfig
        if DamageConfig and DamageConfig.RingTime then
            return true
        end
    end
    return false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.Show
-- Decompile time: 1.25 ms

return {
    K_Skill_1 = {
        Level = "D",
        Image = "rbxassetid://87157702169874",
        DisplayName = "Light Slash",
        Description = "Slash forward, dealing <font color=\"rgb(0,255,0)\">200%</font> damage.",
    },
    K_Skill_2 = {
        Level = "C",
        Image = "rbxassetid://126824430478600",
        DisplayName = "Fury Slash",
        Description = "Slash forward twice, dealing <font color=\"rgb(0,255,0)\">300%</font> damage in total.",
    },
    K_Skill_3 = {
        Level = "B",
        Image = "rbxassetid://109631481533818",
        DisplayName = "Radiant Thrust",
        Description = "Dash forward, dealing <font color=\"rgb(0,255,0)\">320%</font> damage.",
    },
    K_Skill_4 = {
        Level = "A",
        Image = "rbxassetid://113325978057497",
        DisplayName = "Shadow Claw Rift",
        Description = "Summon ghostly hands to rend forward, dealing <font color=\"rgb(0,255,0)\">350%</font> damage.",
    },
    K_Skill_5 = {
        Level = "S",
        Image = "rbxassetid://134086583521329",
        DisplayName = "Psionic Cross Slash",
        Description = "Swing a cross slash forward, dealing <font color=\"rgb(0,255,0)\">450%</font> damage.",
    },
    K_Skill_6 = {
        Level = "SS",
        Image = "rbxassetid://97728353434808",
        DisplayName = "Blazing Pierce",
        Description = "Charge, then thrust forward and unleash a wide slash, dealing <font color=\"rgb(0,255,0)\">300%</font> damage in total.",
    },
    K_Skill_7 = {
        Level = "A",
        Image = "rbxassetid://129919884492623",
        DisplayName = "Lume Thrust",
        Description = "Deal consecutive slashes forward, <font color=\"rgb(0,255,0)\">365%</font> damage in total.",
    },
    K_Skill_8 = {
        Level = "S",
        Image = "rbxassetid://108118777940894",
        DisplayName = "Omega Rush",
        Description = "Deal <font color=\"rgb(0,255,0)\">470%</font> damage to every enemy in range ahead.",
    },
    K_Skill_9 = {
        Level = "SS",
        Image = "rbxassetid://107929202509046",
        DisplayName = "Endless Gale",
        Description = "Slash forward, spawning a whirlwind that lifts enemies, dealing <font color=\"rgb(0,255,0)\">600%</font> damage in total.",
    },
    K_Skill_10 = {
        Level = "S",
        Image = "rbxassetid://77208353723888",
        DisplayName = "Wavebreak Slash",
        Description = "Slash a wave blade forward, dealing <font color=\"rgb(0,255,0)\">450%</font> damage in total.",
    },
    K_Skill_11 = {
        Level = "B",
        Image = "rbxassetid://98617907227334",
        DisplayName = "Ice Slash",
        Description = "Slash a wave blade forward, dealing <font color=\"rgb(0,255,0)\">360%</font> damage in total.",
    },
    K_Skill_1001 = {
        UnLoot = true,
        Level = "SS",
        Image = "rbxassetid://111257096374414",
        DisplayName = "Wavebreak Slash",
        Description = "Slash forward, explode at end, dealing <font color=\"#00FF00\">700%</font> total damage.",
    },
    G_Skill_1 = {
        Level = "D",
        Image = "rbxassetid://127919243671945",
        DisplayName = "Inferno Shatter",
        Description = "Slam forward, dealing <font color=\"rgb(0,255,0)\">250%</font> damage.",
    },
    G_Skill_2 = {
        Level = "C",
        Image = "rbxassetid://124257775084535",
        DisplayName = "Whirl Strike",
        Description = "Charge, then unleash a wide slash, dealing <font color=\"rgb(0,255,0)\">300%</font> damage.",
    },
    G_Skill_3 = {
        Level = "B",
        Image = "rbxassetid://137637425025897",
        DisplayName = "Mountain Rift",
        Description = "Leap‑slam forward, spawning a blood array, dealing <font color=\"rgb(0,255,0)\">450%</font> damage to enemies in total.",
    },
    G_Skill_4 = {
        Level = "A",
        Image = "rbxassetid://102749496955471",
        DisplayName = "Flame Vortex",
        Description = "Slash a light blade forward that persists, dealing <font color=\"rgb(0,255,0)\">610%</font> damage in total.",
    },
    G_Skill_5 = {
        Level = "S",
        Image = "rbxassetid://114986720227570",
        DisplayName = "Rage Frenzy Slash",
        Description = "Release a two‑strike slash, then slam the ground, dealing <font color=\"rgb(0,255,0)\">600%</font> damage in total.",
    },
    G_Skill_6 = {
        Level = "SS",
        Image = "rbxassetid://73469493180059",
        DisplayName = "Abyss Cleave",
        Description = "Leap‑slash enemies, then slam, cracking the ground, dealing <font color=\"rgb(0,255,0)\">900%</font> damage in total.",
    },
    G_Skill_7 = {
        Level = "B",
        Image = "rbxassetid://138241103984347",
        DisplayName = "Fire Slash",
        Description = "Slash a flaming sword wave forward, dealing <font color=\"rgb(0,255,0)\">455%</font> damage.",
    },
    G_Skill_8 = {
        Level = "A",
        Image = "rbxassetid://123351742504628",
        DisplayName = "Lightbreak Slash",
        Description = "Deal a fierce slash forward, <font color=\"rgb(0,255,0)\">620%</font> damage.",
    },
    G_Skill_9 = {
        Level = "SS",
        Image = "rbxassetid://112847400272912",
        DisplayName = "Golden Collapse",
        Description = "Dash forward, damaging enemies along the path and exploding at the end, dealing <font color=\"rgb(0,255,0)\">950%</font> damage in total.",
    },
    G_Skill_10 = {
        Level = "S",
        Image = "rbxassetid://133093086316128",
        DisplayName = "Peerless Sword Formation",
        Description = "Stab the sword into the ground, summoning a sword rain, dealing <font color=\"rgb(0,255,0)\">700%</font> damage to enemies.",
    },
    G_Skill_1001 = {
        UnLoot = true,
        Level = "SS",
        Image = "rbxassetid://108633822186258",
        DisplayName = "Astral Burst Domain",
        Description = "Dash forward and create a Astral Burst Domain, continuously dealing damage to enemies within the domain. Deals <font color=\"#00FF00\">1100%</font> damage.",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.SkillLevelShow
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.SkillLevelShow
-- Decompile time: 0.40 ms

return {
    D = {Image = "rbxassetid://77812052913346", Layout = 1},
    C = {Image = "rbxassetid://70789480241120", Layout = 2},
    B = {Image = "rbxassetid://111392182622476", Layout = 3},
    A = {Image = "rbxassetid://80579361507453", Layout = 4},
    S = {Image = "rbxassetid://117388227780639", Layout = 5},
    SS = {Image = "rbxassetid://98930467287018", Layout = 6},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.SkillLoot.Great
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.SkillLoot.Great
-- Decompile time: 0.44 ms

return {
    Loot_1 = {
        D = 100,
        C = 20,
        B = 10,
        A = 5,
        S = 0,
        SS = 0,
    },
    Loot_2 = {
        D = 50,
        C = 80,
        B = 20,
        A = 10,
        S = 1,
        SS = 0,
    },
    Loot_3 = {
        D = 20,
        C = 50,
        B = 50,
        A = 60,
        S = 20,
        SS = 10,
    },
    Loot_4 = {
        D = 5,
        C = 15,
        B = 25,
        A = 35,
        S = 70,
        SS = 40,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.PlrSkill.SkillLoot.Katana
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.PlrSkill.SkillLoot.Katana
-- Decompile time: 0.46 ms

return {
    Loot_1 = {
        D = 100,
        C = 20,
        B = 10,
        A = 5,
        S = 0,
        SS = 0,
    },
    Loot_2 = {
        D = 50,
        C = 80,
        B = 20,
        A = 10,
        S = 1,
        SS = 0,
    },
    Loot_3 = {
        D = 20,
        C = 50,
        B = 50,
        A = 60,
        S = 20,
        SS = 10,
    },
    Loot_4 = {
        D = 5,
        C = 15,
        B = 25,
        A = 35,
        S = 70,
        SS = 40,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Potion.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Potion.Config
-- Decompile time: 0.39 ms

return {
    CoinPotion = {BuffID = "Coin_1", Time = 300},
    TrainPotion = {BuffID = "Train_1", Time = 300},
    LuckPotion = {BuffID = "Luck_1", Time = 300},
    DamagePotion = {BuffID = "Damage_1", Time = 300},
    HPPotion = {BuffID = "HP_1", Time = 300},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Potion.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Potion.Helper
-- Decompile time: 1.45 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)

function u0.GetConfig() -- Line: 6 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 10 -- upvalues: Show (val)
    return Show
end

function u0.CheckID(a1) -- Line: 14 -- upvalues: Config (val), Show (val)
    return Config[a1] and Show[a1]
end

function u0.GetPrice(a1) -- Line: 18 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Price
    end
    return nil
end

function u0.GetRarity(a1) -- Line: 24 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Rarity
    end
    return nil
end

function u0.GetImage(a1) -- Line: 31 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].Image
    end
    return nil
end

function u0.GetDisName(a1) -- Line: 37 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].DisplayName
    end
    return nil
end

function u0.GetBuffID(a1) -- Line: 44 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].BuffID
    end
    return nil
end

function u0.GetTime(a1) -- Line: 50 -- upvalues: u0 (val), Config (val)
    if u0.CheckID(a1) then
        return Config[a1].Time
    end
    return nil
end

function u0.GetDesc(a1) -- Line: 57 -- upvalues: u0 (val), Show (val)
    if u0.CheckID(a1) then
        return Show[a1].Description
    end
    return nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Potion.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Potion.Show
-- Decompile time: 0.38 ms

return {
    CoinPotion = {
        DisplayName = "Coin Potion",
        Image = "rbxassetid://121177986783156",
        Description = "+100% Coin For 5 Minutes",
    },
    TrainPotion = {
        DisplayName = "Power Potion",
        Image = "rbxassetid://72674892359014",
        Description = "+100% Power For 5 Minutes",
    },
    LuckPotion = {
        DisplayName = "Luck Potion",
        Image = "rbxassetid://111240558888066",
        Description = "+100% Luck For 5 Minutes",
    },
    DamagePotion = {
        DisplayName = "Damage Potion",
        Image = "rbxassetid://83222372705220",
        Description = "+100% Damage For 5 Minutes",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Rarity.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Rarity.Helper
-- Decompile time: 2.25 ms

local u0 = {}
local u1 = {
    Common = 1,
    UnCommon = 2,
    Rare = 3,
    Epic = 4,
    Legendary = 5,
    Mythic = 6,
    Eternal = 7,
    Secret = 8,
    Ancient = 9,
    Infinite = 10,
    Exclusive = 11,
}

function u0.GetRarityLevel(a1) -- Line: 17 -- upvalues: u1 (val)
    return u1[a1] or 0
end

function u0.GetRarityByLevel(a1) -- Line: 21 -- upvalues: u1 (val)
    for i, j in u1 do
        if j == a1 then
            return i
        end
    end
end

function u0.GetTextRarity(a1) -- Line: 29 -- upvalues: u0 (val)
    if type(a1) == "number" or tonumber(a1) then
        return u0.GetRarityByLevel(a1)
    end
    return a1
end

local Assets = game:GetService("ReplicatedStorage").Assets
local UIGradient = Assets.Rarity:WaitForChild("UIGradient")

function u0.IsHaveUIQiu(a1) -- Line: 44
    return a1:FindFirstChild("UIQIU")
end

function u0.SetUIQiu(a1, a2) -- Line: 48 -- upvalues: u0 (val), UIGradient (val) -- types: a1: userdata
    if a1 and a2 then
        local v1 = UIGradient:FindFirstChild((u0.GetTextRarity(a2)))
        if v1 then
            while a1:FindFirstChildOfClass("UIGradient") do
                a1:FindFirstChildOfClass("UIGradient"):Destroy()
                task.wait()
            end
            v1 = v1:Clone()
            v1.Parent = a1
            v1.Name = "UIQIU"
        end
        return v1
    end
end

function u0.DestroyUIQIU(a1) -- Line: 66 -- types: a1: userdata
    if a1:FindFirstChild("UIQIU") then
        a1:FindFirstChild("UIQIU"):Destroy()
    end
end

function u0.SetUIQiuByGrade(a1, a2) -- Line: 72 -- upvalues: Assets (val) -- types: a1: userdata
    if a1 and a2 then
        local v1 = Assets.UI.UIGradient:FindFirstChild(a2)
        if v1 then
            while a1:FindFirstChildOfClass("UIGradient") do
                a1:FindFirstChildOfClass("UIGradient"):Destroy()
                task.wait()
            end
            v1 = v1:Clone()
            v1.Parent = a1
            v1.Name = "UIQIU"
        end
        return v1
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Rebirth.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Rebirth.Config
-- Decompile time: 3.60 ms

return {
    [0] = {ExpBasic = 1, CoinBasic = 1, NeedLevel = 0, Dungeon_Ticket = 0},
    {ExpBasic = 1.5, CoinBasic = 1.2, NeedLevel = 25, Dungeon_Ticket = 1},
    {ExpBasic = 2, CoinBasic = 1.4, NeedLevel = 50, Dungeon_Ticket = 0},
    {ExpBasic = 2.5, CoinBasic = 1.6, NeedLevel = 75, Dungeon_Ticket = 1},
    {ExpBasic = 3, CoinBasic = 1.8, NeedLevel = 100, Dungeon_Ticket = 0},
    {ExpBasic = 3.5, CoinBasic = 2, NeedLevel = 125, Dungeon_Ticket = 0},
    {ExpBasic = 4, CoinBasic = 2.2, NeedLevel = 150, Dungeon_Ticket = 1},
    {ExpBasic = 4.5, CoinBasic = 2.4, NeedLevel = 175, Dungeon_Ticket = 0},
    {ExpBasic = 5, CoinBasic = 2.6, NeedLevel = 200, Dungeon_Ticket = 0},
    {ExpBasic = 5.5, CoinBasic = 2.8, NeedLevel = 225, Dungeon_Ticket = 1},
    {ExpBasic = 6, CoinBasic = 3, NeedLevel = 250, Dungeon_Ticket = 2},
    {ExpBasic = 6.5, CoinBasic = 3.2, NeedLevel = 275, Dungeon_Ticket = 0},
    {ExpBasic = 7, CoinBasic = 3.4, NeedLevel = 290, Dungeon_Ticket = 2},
    {ExpBasic = 7.5, CoinBasic = 3.6, NeedLevel = 305, Dungeon_Ticket = 0},
    {ExpBasic = 8, CoinBasic = 3.8, NeedLevel = 320, Dungeon_Ticket = 2},
    {ExpBasic = 8.5, CoinBasic = 4, NeedLevel = 335, Dungeon_Ticket = 0},
    {ExpBasic = 9, CoinBasic = 4.2, NeedLevel = 350, Dungeon_Ticket = 2},
    {ExpBasic = 9.5, CoinBasic = 4.4, NeedLevel = 365, Dungeon_Ticket = 2},
    {ExpBasic = 10, CoinBasic = 4.6, NeedLevel = 380, Dungeon_Ticket = 0},
    {ExpBasic = 10.5, CoinBasic = 4.8, NeedLevel = 395, Dungeon_Ticket = 2},
    {ExpBasic = 11, CoinBasic = 5, NeedLevel = 410, Dungeon_Ticket = 3},
    {ExpBasic = 11.5, CoinBasic = 5.2, NeedLevel = 425, Dungeon_Ticket = 3},
    {ExpBasic = 12, CoinBasic = 5.4, NeedLevel = 440, Dungeon_Ticket = 0},
    {ExpBasic = 12.5, CoinBasic = 5.6, NeedLevel = 455, Dungeon_Ticket = 3},
    {ExpBasic = 13, CoinBasic = 5.8, NeedLevel = 470, Dungeon_Ticket = 3},
    {ExpBasic = 13.5, CoinBasic = 6, NeedLevel = 485, Dungeon_Ticket = 3},
    {ExpBasic = 14, CoinBasic = 6.2, NeedLevel = 500, Dungeon_Ticket = 3},
    {ExpBasic = 14.5, CoinBasic = 6.4, NeedLevel = 515, Dungeon_Ticket = 3},
    {ExpBasic = 15, CoinBasic = 6.6, NeedLevel = 530, Dungeon_Ticket = 3},
    {ExpBasic = 15.5, CoinBasic = 6.8, NeedLevel = 545, Dungeon_Ticket = 3},
    {ExpBasic = 16, CoinBasic = 7, NeedLevel = 560, Dungeon_Ticket = 3},
    {ExpBasic = 16.5, CoinBasic = 7.2, NeedLevel = 575, Dungeon_Ticket = 3},
    {ExpBasic = 17, CoinBasic = 7.4, NeedLevel = 590, Dungeon_Ticket = 3},
    {ExpBasic = 17.5, CoinBasic = 7.6, NeedLevel = 605, Dungeon_Ticket = 3},
    {ExpBasic = 18, CoinBasic = 7.8, NeedLevel = 620, Dungeon_Ticket = 3},
    {ExpBasic = 18.5, CoinBasic = 8, NeedLevel = 635, Dungeon_Ticket = 3},
    {ExpBasic = 19, CoinBasic = 8.2, NeedLevel = 650, Dungeon_Ticket = 3},
    {ExpBasic = 19.5, CoinBasic = 8.4, NeedLevel = 665, Dungeon_Ticket = 3},
    {ExpBasic = 20, CoinBasic = 8.6, NeedLevel = 680, Dungeon_Ticket = 3},
    {ExpBasic = 20.5, CoinBasic = 8.8, NeedLevel = 695, Dungeon_Ticket = 3},
    {ExpBasic = 21, CoinBasic = 9, NeedLevel = 710, Dungeon_Ticket = 3},
    {ExpBasic = 21.5, CoinBasic = 9.2, NeedLevel = 725, Dungeon_Ticket = 3},
    {ExpBasic = 22, CoinBasic = 9.4, NeedLevel = 740, Dungeon_Ticket = 3},
    {ExpBasic = 22.5, CoinBasic = 9.6, NeedLevel = 755, Dungeon_Ticket = 3},
    {ExpBasic = 23, CoinBasic = 9.8, NeedLevel = 770, Dungeon_Ticket = 3},
    {ExpBasic = 23.5, CoinBasic = 10, NeedLevel = 785, Dungeon_Ticket = 3},
    {ExpBasic = 24, CoinBasic = 10.2, NeedLevel = 800, Dungeon_Ticket = 3},
    {ExpBasic = 24.5, CoinBasic = 10.4, NeedLevel = 815, Dungeon_Ticket = 3},
    {ExpBasic = 25, CoinBasic = 10.6, NeedLevel = 830, Dungeon_Ticket = 3},
    {ExpBasic = 25.5, CoinBasic = 10.8, NeedLevel = 845, Dungeon_Ticket = 3},
    {ExpBasic = 26, CoinBasic = 11, NeedLevel = 860, Dungeon_Ticket = 3},
    {ExpBasic = 26.5, CoinBasic = 11.2, NeedLevel = 875, Dungeon_Ticket = 3},
    {ExpBasic = 27, CoinBasic = 11.4, NeedLevel = 890, Dungeon_Ticket = 3},
    {ExpBasic = 27.5, CoinBasic = 11.6, NeedLevel = 905, Dungeon_Ticket = 3},
    {ExpBasic = 28, CoinBasic = 11.8, NeedLevel = 920, Dungeon_Ticket = 3},
    {ExpBasic = 28.5, CoinBasic = 12, NeedLevel = 935, Dungeon_Ticket = 3},
    {ExpBasic = 29, CoinBasic = 12.2, NeedLevel = 950, Dungeon_Ticket = 3},
    {ExpBasic = 29.5, CoinBasic = 12.4, NeedLevel = 965, Dungeon_Ticket = 3},
    {ExpBasic = 30, CoinBasic = 12.6, NeedLevel = 980, Dungeon_Ticket = 3},
    {ExpBasic = 30.5, CoinBasic = 12.8, NeedLevel = 995, Dungeon_Ticket = 3},
    {ExpBasic = 31, CoinBasic = 13, NeedLevel = 1010, Dungeon_Ticket = 3},
    {ExpBasic = 31.5, CoinBasic = 13.2, NeedLevel = 1025, Dungeon_Ticket = 3},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Rebirth.Config_Old
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Rebirth.Config_Old
-- Decompile time: 2.18 ms

return {
    [0] = {ExpBasic = 1, CoinBasic = 1, NeedLevel = 0, Dungeon_Ticket = 0},
    {ExpBasic = 1.5, CoinBasic = 1.2, NeedLevel = 25, Dungeon_Ticket = 1},
    {ExpBasic = 2, CoinBasic = 1.4, NeedLevel = 50, Dungeon_Ticket = 0},
    {ExpBasic = 2.5, CoinBasic = 1.6, NeedLevel = 75, Dungeon_Ticket = 1},
    {ExpBasic = 3, CoinBasic = 1.8, NeedLevel = 100, Dungeon_Ticket = 0},
    {ExpBasic = 3.5, CoinBasic = 2, NeedLevel = 125, Dungeon_Ticket = 0},
    {ExpBasic = 4, CoinBasic = 2.2, NeedLevel = 150, Dungeon_Ticket = 1},
    {ExpBasic = 4.5, CoinBasic = 2.4, NeedLevel = 175, Dungeon_Ticket = 0},
    {ExpBasic = 5, CoinBasic = 2.6, NeedLevel = 200, Dungeon_Ticket = 0},
    {ExpBasic = 5.5, CoinBasic = 2.8, NeedLevel = 225, Dungeon_Ticket = 1},
    {ExpBasic = 6, CoinBasic = 3, NeedLevel = 250, Dungeon_Ticket = 2},
    {ExpBasic = 6.5, CoinBasic = 3.2, NeedLevel = 275, Dungeon_Ticket = 0},
    {ExpBasic = 7, CoinBasic = 3.4, NeedLevel = 300, Dungeon_Ticket = 2},
    {ExpBasic = 7.5, CoinBasic = 3.6, NeedLevel = 325, Dungeon_Ticket = 0},
    {ExpBasic = 8, CoinBasic = 3.8, NeedLevel = 350, Dungeon_Ticket = 2},
    {ExpBasic = 8.5, CoinBasic = 4, NeedLevel = 375, Dungeon_Ticket = 0},
    {ExpBasic = 9, CoinBasic = 4.2, NeedLevel = 400, Dungeon_Ticket = 2},
    {ExpBasic = 9.5, CoinBasic = 4.4, NeedLevel = 425, Dungeon_Ticket = 2},
    {ExpBasic = 10, CoinBasic = 4.6, NeedLevel = 450, Dungeon_Ticket = 0},
    {ExpBasic = 10.5, CoinBasic = 4.8, NeedLevel = 475, Dungeon_Ticket = 2},
    {ExpBasic = 11, CoinBasic = 5, NeedLevel = 500, Dungeon_Ticket = 3},
    {ExpBasic = 11.5, CoinBasic = 5.2, NeedLevel = 525, Dungeon_Ticket = 3},
    {ExpBasic = 12, CoinBasic = 5.4, NeedLevel = 550, Dungeon_Ticket = 0},
    {ExpBasic = 12.5, CoinBasic = 5.6, NeedLevel = 575, Dungeon_Ticket = 3},
    {ExpBasic = 13, CoinBasic = 5.8, NeedLevel = 600, Dungeon_Ticket = 3},
    {ExpBasic = 13.5, CoinBasic = 6, NeedLevel = 625, Dungeon_Ticket = 3},
    {ExpBasic = 14, CoinBasic = 6.2, NeedLevel = 650, Dungeon_Ticket = 3},
    {ExpBasic = 14.5, CoinBasic = 6.4, NeedLevel = 675, Dungeon_Ticket = 3},
    {ExpBasic = 15, CoinBasic = 6.6, NeedLevel = 700, Dungeon_Ticket = 3},
    {ExpBasic = 15.5, CoinBasic = 6.8, NeedLevel = 725, Dungeon_Ticket = 3},
    {ExpBasic = 16, CoinBasic = 7, NeedLevel = 750, Dungeon_Ticket = 3},
    {ExpBasic = 16.5, CoinBasic = 7.2, NeedLevel = 775, Dungeon_Ticket = 3},
    {ExpBasic = 17, CoinBasic = 7.4, NeedLevel = 800, Dungeon_Ticket = 3},
    {ExpBasic = 17.5, CoinBasic = 7.6, NeedLevel = 825, Dungeon_Ticket = 3},
    {ExpBasic = 18, CoinBasic = 7.8, NeedLevel = 850, Dungeon_Ticket = 3},
    {ExpBasic = 18.5, CoinBasic = 8, NeedLevel = 875, Dungeon_Ticket = 3},
    {ExpBasic = 19, CoinBasic = 8.2, NeedLevel = 900, Dungeon_Ticket = 3},
    {ExpBasic = 19.5, CoinBasic = 8.4, NeedLevel = 925, Dungeon_Ticket = 3},
    {ExpBasic = 20, CoinBasic = 8.6, NeedLevel = 950, Dungeon_Ticket = 3},
    {ExpBasic = 20.5, CoinBasic = 8.8, NeedLevel = 975, Dungeon_Ticket = 3},
    {ExpBasic = 21, CoinBasic = 9, NeedLevel = 1000, Dungeon_Ticket = 3},
    {ExpBasic = 21.5, CoinBasic = 9.2, NeedLevel = 1025, Dungeon_Ticket = 3},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Rebirth.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Rebirth.Helper
-- Decompile time: 1.71 ms

local v1 = {}
local Config = require(script.Parent.Config)
local u15 = require(game.ReplicatedStorage.Utils.TableUtils).getTableLegth(Config) - 1

function v1.GetConfig() -- Line: 8 -- upvalues: Config (val)
    return Config
end

function v1.GetExpBasic(a1) -- Line: 12 -- upvalues: Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if Config[a1] then
        return Config[a1].ExpBasic
    end
    return 1
end

function v1.GetCoinBasic(a1) -- Line: 21 -- upvalues: Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if Config[a1] then
        return Config[a1].CoinBasic
    end
    return 1
end

function v1.CheckIsMax(a1) -- Line: 31 -- upvalues: u15 (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if a1 == u15 then
        return true
    end
    if a1 < u15 then
        return false
    end
    warn("不是哥们，你怎么能重生超过上限呢？？？" .. a1)
    return false
end

function v1.GetNeedLevel(a1) -- Line: 45 -- upvalues: Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if Config[a1] then
        return Config[a1].NeedLevel
    end
    return nil
end

function v1.GetDungeonTicket(a1) -- Line: 55 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Dungeon_Ticket
    end
end

function v1.GetSkipID(a1) -- Line: 61 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].SkipID
    end
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.GoodsConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.GoodsConfig
-- Decompile time: 0.74 ms

return {
    ["1"] = {
        Type = "Hat",
        ID = "HHat_1101",
        Number = 1,
        NeedSeasonCoin = 6000,
        Store = 1,
    },
    ["2"] = {
        Type = "Weapon",
        ID = "K_1101",
        Number = 1,
        NeedSeasonCoin = 4000,
        Store = 1,
    },
    ["3"] = {
        Type = "Hat",
        ID = "LHat_1101",
        Number = 1,
        NeedSeasonCoin = 3000,
        Store = 1,
    },
    ["4"] = {
        Type = "Material",
        ID = "EnhantProtect",
        Number = 1,
        NeedSeasonCoin = 1500,
        Store = 1,
    },
    ["5"] = {
        Type = "GameSetting",
        ID = "ClassRoll",
        Number = 1,
        NeedSeasonCoin = 1000,
        Store = 5,
    },
    ["6"] = {
        Type = "Material",
        ID = "EnhantStone_2",
        Number = 5,
        NeedSeasonCoin = 800,
        Store = 5,
    },
    ["7"] = {
        Type = "GameSetting",
        ID = "SeasonTicket",
        Number = 1,
        NeedSeasonCoin = 800,
        Store = 5,
    },
    ["8"] = {
        Type = "Material",
        ID = "EnhantStone_1",
        Number = 20,
        NeedSeasonCoin = 500,
        Store = 10,
    },
    ["9"] = {
        Type = "Potion",
        ID = "TrainPotion",
        Number = 1,
        NeedSeasonCoin = 300,
        Store = 2,
    },
    ["10"] = {
        Type = "Potion",
        ID = "DamagePotion",
        Number = 1,
        NeedSeasonCoin = 300,
        Store = 2,
    },
    ["11"] = {
        Type = "Eco",
        ID = "coin",
        Number = 2000,
        NeedSeasonCoin = 200,
        Store = 1000,
    },
    ["12"] = {
        Type = "Material",
        ID = "Dungeon_Ticket",
        Number = 1,
        NeedSeasonCoin = 500,
        Store = 3,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.Helper
-- Decompile time: 4.56 ms

local v1 = {}
local LuckConfig = require(script.Parent.LuckConfig)
local QuestConfig = require(script.Parent.QuestConfig)
local RewardConfig = require(script.Parent.RewardConfig)
local GoodsConfig = require(script.Parent.GoodsConfig)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.TableUtils)

function v1.GetLuckConfig() -- Line: 14 -- upvalues: LuckConfig (val)
    return LuckConfig
end

function v1.GetRewardConfig() -- Line: 17 -- upvalues: RewardConfig (val)
    return RewardConfig
end

function v1.GetQuestConfig() -- Line: 20 -- upvalues: QuestConfig (val)
    return QuestConfig
end

function v1.GetGoodsConfig() -- Line: 23 -- upvalues: GoodsConfig (val)
    return GoodsConfig
end

function v1.GetQuestRecordType(a1, a2) -- Line: 27 -- upvalues: QuestConfig (val)
    if QuestConfig[a1] and QuestConfig[a1][a2] then
        return QuestConfig[a1][a2].Record
    end
end

function v1.GetQuestNeedNumber(a1, a2) -- Line: 32 -- upvalues: QuestConfig (val)
    if QuestConfig[a1] and QuestConfig[a1][a2] then
        return QuestConfig[a1][a2].NeedNumber
    end
end

function v1.GetQuestExp(a1, a2) -- Line: 38 -- upvalues: QuestConfig (val)
    if QuestConfig[a1] and QuestConfig[a1][a2] then
        return QuestConfig[a1][a2].Exp
    end
end

function v1.GetLevelExp() -- Line: 45
    return 800
end

function v1.GetQuestWeightTab(a1) -- Line: 50 -- upvalues: QuestConfig (val)
    if not QuestConfig[a1] then
        return nil
    end
    local v1 = {}
    for i, j in QuestConfig[a1] do
        if not j.Force then
            v1[i] = j.Weight
        end
    end
    return v1
end

function v1.GetQuestDesc(a1) -- Line: 65
    if a1 == "WorldBoss" then
        return "Defeat World Boss"
    end
    if a1 == "Online" then
        return "Online"
    end
    if a1 == "Kill" then
        return "Defeat Enemy"
    end
    if a1 == "Dungeon" then
        return "Play Frostbound Tower"
    end
    if a1 == "Forge_Weapon" then
        return "Forge Weapon"
    end
    if a1 == "Forge_Armor" then
        return "Forge Armor"
    end
    if a1 == "Forge" then
        return "Forge Equipment"
    end
    if a1 == "Sell" then
        return "Sell"
    end
    if a1 == "Enhant" then
        return "Enhance Equipment"
    end
    if a1 == "Enchant" then
        return "Enchant Equipment"
    end
end

function v1.GetForceQuestList(a1) -- Line: 90 -- upvalues: QuestConfig (val)
    if not QuestConfig[a1] then
        return nil
    end
    local v1 = {}
    for i, j in QuestConfig[a1] do
        if j.Force then
            table.insert(v1, i)
        end
    end
    return v1
end

function v1.GetSeasonReward(a1, a2) -- Line: 103 -- upvalues: RewardConfig (val)
    if not RewardConfig[a2] then
        return nil
    end
    local v1 = RewardConfig[a2][a1]
    if not v1 then
        return nil
    end
    return v1
end

function v1.GetLuckWeightTable() -- Line: 114 -- upvalues: LuckConfig (val)
    local v1 = {}
    for i, j in LuckConfig do
        v1[i] = j.Weight
    end
    return v1
end

function v1.GetLuckReward(a1) -- Line: 122 -- upvalues: LuckConfig (val)
    if LuckConfig[a1] then
        return LuckConfig[a1]
    end
    return nil
end

function v1.GetGoodsStore(a1) -- Line: 129 -- upvalues: GoodsConfig (val)
    if GoodsConfig[a1] then
        return GoodsConfig[a1].Store or 0
    end
    return nil
end

function v1.GetGoodsNeedSeasonCoin(a1) -- Line: 135 -- upvalues: GoodsConfig (val)
    if GoodsConfig[a1] then
        return GoodsConfig[a1].NeedSeasonCoin or 0
    end
    return nil
end

function v1.GetGoods(a1) -- Line: 141 -- upvalues: GoodsConfig (val)
    if GoodsConfig[a1] then
        return GoodsConfig[a1]
    end
    return nil
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.QuestConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.QuestConfig
-- Decompile time: 0.87 ms

local v1
local v2 = {}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        v1 = require(j)
        v2[j.Name] = {}
        for k, n in v1 do
            v2[j.Name][k] = n
        end
    end
end
return v2
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.QuestConfig.Daily
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.QuestConfig.Daily
-- Decompile time: 0.81 ms

return {
    ["1"] = {
        Record = "WorldBoss",
        NeedNumber = 1,
        Exp = 400,
        Weight = 1,
        Force = true,
    },
    ["2"] = {Record = "Online", NeedNumber = 1500, Exp = 150, Weight = 1},
    ["3"] = {Record = "Kill", NeedNumber = 150, Exp = 150, Weight = 1},
    ["4"] = {Record = "Dungeon", NeedNumber = 4, Exp = 150, Weight = 1},
    ["5"] = {Record = "Forge_Weapon", NeedNumber = 25, Exp = 150, Weight = 1},
    ["6"] = {Record = "Forge_Armor", NeedNumber = 15, Exp = 150, Weight = 1},
    ["7"] = {Record = "Sell", NeedNumber = 15, Exp = 150, Weight = 1},
    ["8"] = {Record = "Enhant", NeedNumber = 5, Exp = 150, Weight = 1},
    ["9"] = {Record = "Enchant", NeedNumber = 5, Exp = 150, Weight = 1},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.RewardConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.RewardConfig
-- Decompile time: 1.29 ms

local v1
local v2 = {}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        v1 = require(j)
        v2[j.Name] = {}
        for k, n in v1 do
            v2[j.Name][k] = n
        end
    end
end
return v2
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.RewardConfig.Free
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.RewardConfig.Free
-- Decompile time: 0.79 ms

return {
    ["1"] = {Type = "Eco", ID = "coin", Number = 200},
    ["2"] = {Type = "Material", ID = "EnhantStone_1", Number = 75},
    ["3"] = {Type = "GameSetting", ID = "ClassRoll", Number = 1},
    ["4"] = {Type = "Eco", ID = "coin", Number = 5000},
    ["5"] = {Type = "Material", ID = "EnhantProtect", Number = 1},
    ["6"] = {Type = "GameSetting", ID = "SeasonTicket", Number = 2},
    ["7"] = {Type = "GameSetting", ID = "SeasonCoin", Number = 200},
    ["8"] = {Type = "Material", ID = "EnhantStone_1", Number = 100},
    ["9"] = {Type = "GameSetting", ID = "SeasonCoin", Number = 300},
    ["10"] = {Type = "GameSetting", ID = "ClassRoll", Number = 1},
    ["11"] = {Type = "Material", ID = "EnhantProtect", Number = 1},
    ["12"] = {Type = "GameSetting", ID = "SeasonTicket", Number = 2},
    ["13"] = {Type = "GameSetting", ID = "ClassRoll", Number = 1},
    ["14"] = {Type = "Material", ID = "EnhantStone_1", Number = 200},
    ["15"] = {Type = "Armor", ID = "LArmor_1101", Number = 1},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Season.RewardConfig.VIP
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Season.RewardConfig.VIP
-- Decompile time: 0.74 ms

return {
    ["1"] = {Type = "GameSetting", ID = "SeasonTicket", Number = 4},
    ["2"] = {Type = "Material", ID = "EnhantStone_2", Number = 45},
    ["3"] = {Type = "GameSetting", ID = "ClassRoll", Number = 3},
    ["4"] = {Type = "Eco", ID = "coin", Number = 20000},
    ["5"] = {Type = "Material", ID = "EnhantProtect", Number = 3},
    ["6"] = {Type = "GameSetting", ID = "SeasonTicket", Number = 4},
    ["7"] = {Type = "GameSetting", ID = "SeasonCoin", Number = 500},
    ["8"] = {Type = "Material", ID = "EnhantStone_1", Number = 300},
    ["9"] = {Type = "GameSetting", ID = "SeasonCoin", Number = 700},
    ["10"] = {Type = "GameSetting", ID = "ClassRoll", Number = 3},
    ["11"] = {Type = "Material", ID = "EnhantProtect", Number = 3},
    ["12"] = {Type = "GameSetting", ID = "SeasonTicket", Number = 4},
    ["13"] = {Type = "GameSetting", ID = "ClassRoll", Number = 3},
    ["14"] = {Type = "Material", ID = "EnhantStone_2", Number = 80},
    ["15"] = {Type = "Armor", ID = "HArmor_1101", Number = 1},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Sign.SignReward
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Sign.SignReward
-- Decompile time: 0.41 ms

return {
    {
        Blbl = 1,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 300,
    },
    {
        Blbl = 2,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 1,
    },
    {
        Blbl = 3,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 5000,
    },
    {
        Blbl = 4,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 20,
    },
    {
        Blbl = 5,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 200000,
    },
    {
        Blbl = 6,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 100,
    },
    {
        Blbl = 7,
        Time = 0,
        Type = "Eco",
        ID = "coin",
        Number = 1,
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Stage.HPConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Stage.HPConfig
-- Decompile time: 1.05 ms

return {
    Stage_1 = {MobHP = 32, BossHP = 1000},
    Stage_2 = {MobHP = 998},
    Stage_3 = {MobHP = 10000, BossHP = 30000},
    Stage_4 = {MobHP = 113050},
    Stage_5 = {MobHP = 1200000},
    Stage_6 = {MobHP = 12500000},
    Stage_7 = {MobHP = 125000000, BossHP = 500000000},
    Stage_8 = {MobHP = 938000000},
    Stage_9 = {MobHP = 12500000000},
    Stage_10 = {MobHP = 56300000000},
    Stage_11 = {MobHP = 540000000000},
    Stage_12 = {MobHP = 2700000000000, BossHP = 13500000000000},
    Stage_13 = {MobHP = 21900000000000},
    Stage_14 = {MobHP = 106000000000000},
    Stage_15 = {MobHP = 2e+15},
    Stage_16 = {MobHP = 1.02e+16},
    Stage_17 = {MobHP = 8.4e+16, BossHP = 4.2e+17},
    Stage_18 = {MobHP = 3.75e+17},
    Stage_19 = {MobHP = 6.25e+17},
    Stage_20 = {MobHP = 1.12e+18},
    Stage_21 = {MobHP = 2.16e+18},
    Stage_22 = {MobHP = 3.24e+18, BossHP = 1.62e+19},
    Stage_23 = {MobHP = 4.32e+19},
    Stage_24 = {MobHP = 1.6025e+20},
    Stage_25 = {MobHP = 8.225e+20},
    Stage_26 = {MobHP = 1.745e+21},
    Stage_27 = {MobHP = 3.0628e+21, BossHP = 9.01e+21},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Stage.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Stage.Helper
-- Decompile time: 6.04 ms

local u73 = {}
local StageEnemyConfig = require(script.Parent.StageEnemyConfig)
local Loots = require(script.Parent.Loots)
local OreLoots = require(script.Parent.OreLoots)
local HPConfig = require(script.Parent.HPConfig)
local RecommendConfig = require(script.Parent.RecommendConfig)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local v1 = nil
local v2 = nil
for i, j in StageEnemyConfig, v1, v2 do
    if j then
        for k, n in j do
            if n then
                if not n.IsBoss then
                    n.ATK = 7
                else
                    n.ATK = 20
                end
            end
        end
    end
end

function u73.GetStageEnemyConfig() -- Line: 29 -- upvalues: StageEnemyConfig (val)
    return StageEnemyConfig
end

function u73.GetEnemyConfig(a1) -- Line: 33 -- upvalues: StageEnemyConfig (val)
    return StageEnemyConfig[a1]
end

function u73.GetOreWeightTab(a1, a2) -- Line: 38 -- upvalues: u73 (val), OreLoots (val)
    local v1
    if not a2 then
        a2 = 1
    end
    local v2 = u73.GetRandRootID(a1, a2)
    local v3 = OreLoots[v2].OreTab:split(",")
    local v4 = OreLoots[v2].Chance:split(",")
    local v5 = {}
    for i, j in v3 do
        if v4[i] then
            v1 = v4[i]
            v5[j] = (tonumber(v1))
        end
    end
    local v6 = OreLoots[v2].EnhantStoneChance or 0
    local v7 = math.random() <= v6
    local v8 = nil
    if v7 then
        local v9 = OreLoots[v2].EnhantStoneRange:split(",")
        v8 = math.random(tonumber(v9[1]), (tonumber(v9[2])))
    end
    return v5, v8
end

function u73.GetRandRootID(a1, a2) -- Line: 65 -- upvalues: Loots (val), TableUtils (val)
    local v1, v2
    if not a2 then
        a2 = 1
    end
    local v3 = Loots[a1].LootTab:split(",")
    local v4 = Loots[a1].Chance:split(",")
    local v5 = {}
    for i, j in v3 do
        if v4[i] then
            if not ((tonumber(v4[i])) <= 1000) then
                v1 = v4[i]
                v5[j] = (tonumber(v1))
            else
                v2 = v4[i]
                v5[j] = tonumber(v2) * a2 * 1.3
            end
        end
    end
    return TableUtils.RandomWeightResult(v5) or "Loot_1"
end

function u73.GetOreNumber(a1) -- Line: 84 -- upvalues: Loots (val)
    return Loots[a1].LootNumber
end

function u73.GetStageEnemyHP(a1, a2) -- Line: 88 -- upvalues: StageEnemyConfig (val), HPConfig (val)
    local v1 = StageEnemyConfig[a1][a2]
    if not v1 then
        return
    end
    if v1.HP then
        return v1.HP
    end
    if v1.IsBoss then
        return HPConfig[a1].BossHP
    end
    return HPConfig[a1].MobHP / #StageEnemyConfig[a1]
end

function u73.GetStageMobHP(a1) -- Line: 105 -- upvalues: HPConfig (val), StageEnemyConfig (val)
    return HPConfig[a1].MobHP / #StageEnemyConfig[a1]
end

function u73.GetStageBossHP(a1) -- Line: 109 -- upvalues: HPConfig (val)
    return HPConfig[a1].BossHP
end

function u73.GetStageMobATK(a1) -- Line: 113
    return 7
end

function u73.GetStageBossATK(a1) -- Line: 116
    return 20
end

function u73.GetRecommend(a1) -- Line: 120 -- upvalues: RecommendConfig (val)
    return RecommendConfig[a1].Recommend
end

return u73
-- Script Path: game:GetService("ReplicatedStorage").Config.Stage.Loots
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Stage.Loots
-- Decompile time: 1.07 ms

return {
    Stage_1 = {LootTab = "Loot_1,Loot_2,Loot_3", Chance = "9400,500,100", LootNumber = 6},
    Stage_2 = {LootTab = "Loot_2,Loot_3,Loot_4", Chance = "9400,500,50", LootNumber = 6},
    Stage_3 = {LootTab = "Loot_2,Loot_3,Loot_4", Chance = "9400,500,100", LootNumber = 9},
    Stage_4 = {LootTab = "Loot_3,Loot_4,Loot_5", Chance = "9400,500,100", LootNumber = 6},
    Stage_5 = {LootTab = "Loot_3,Loot_4,Loot_5", Chance = "9400,500,100", LootNumber = 6},
    Stage_6 = {LootTab = "Loot_4,Loot_5,Loot_6", Chance = "9400,500,100", LootNumber = 6},
    Stage_7 = {LootTab = "Loot_4,Loot_5,Loot_6", Chance = "9400,500,100", LootNumber = 9},
    Stage_8 = {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 6},
    Stage_9 = {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 6},
    Stage_10 = {LootTab = "Loot_5,Loot_6,Loot_7", Chance = "9400,500,100", LootNumber = 6},
    Stage_11 = {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 6},
    Stage_12 = {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 9},
    Stage_13 = {LootTab = "Loot_6,Loot_7,Loot_8", Chance = "9400,500,100", LootNumber = 6},
    Stage_14 = {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 6},
    Stage_15 = {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 6},
    Stage_16 = {LootTab = "Loot_7,Loot_8", Chance = "9900,100", LootNumber = 6},
    Stage_17 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 9},
    Stage_18 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 6},
    Stage_19 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 6},
    Stage_20 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 6},
    Stage_21 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 6},
    Stage_22 = {LootTab = "Loot_8,Loot_9", Chance = "9900,100", LootNumber = 9},
    Stage_23 = {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 6},
    Stage_24 = {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 6},
    Stage_25 = {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 6},
    Stage_26 = {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 6},
    Stage_27 = {LootTab = "Loot_9,Loot_10", Chance = "9900,100", LootNumber = 9},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Stage.OreLoots
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Stage.OreLoots
-- Decompile time: 1.16 ms

return {
    Loot_1 = {OreTab = "Ore_1,Ore_2,Ore_3", Chance = "1,1,1", EnhantStoneChance = 0.01, EnhantStoneRange = "1,5"},
    Loot_2 = {OreTab = "Ore_4,Ore_5,Ore_6", Chance = "1,1,1", EnhantStoneChance = 0.01, EnhantStoneRange = "1,5"},
    Loot_3 = {OreTab = "Ore_7,Ore_8,Ore_9", Chance = "1,1,1", EnhantStoneChance = 0.01, EnhantStoneRange = "1,5"},
    Loot_4 = {
        OreTab = "Ore_10,Ore_11,Ore_12,Ore_13",
        Chance = "1,1,1,1",
        EnhantStoneChance = 0.02,
        EnhantStoneRange = "5,10",
    },
    Loot_5 = {
        OreTab = "Ore_14,Ore_15,Ore_16,Ore_17,Ore_18,Ore_19",
        Chance = "1,1,1,1,1,1",
        EnhantStoneChance = 0.02,
        EnhantStoneRange = "5,10",
    },
    Loot_6 = {
        OreTab = "Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25",
        Chance = "1,1,1,1,1,1",
        EnhantStoneChance = 0.02,
        EnhantStoneRange = "5,10",
    },
    Loot_7 = {
        OreTab = "Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31",
        Chance = "1,1,1,1,1,1",
        EnhantStoneChance = 0.02,
        EnhantStoneRange = "5,10",
    },
    Loot_8 = {
        OreTab = "Ore_32,Ore_33,Ore_34,Ore_35,Ore_36,Ore_37,Ore_38,Ore_39",
        Chance = "1,1,1,1,1,1,1,1",
        EnhantStoneChance = 0.03,
        EnhantStoneRange = "5,10",
    },
    Loot_9 = {
        OreTab = "Ore_40,Ore_41,Ore_42,Ore_43,Ore_44,Ore_45,Ore_46,Ore_47",
        Chance = "1,1,1,1,1,1,1,1",
        EnhantStoneChance = 0.03,
        EnhantStoneRange = "5,10",
    },
    Loot_10 = {OreTab = "Ore_48", Chance = "1", EnhantStoneChance = 0.03, EnhantStoneRange = "5,10"},
    Loot_11 = {
        OreTab = "Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32,Ore_33,Ore_34,Ore_35,Ore_36,Ore_37,Ore_38,Ore_39",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
    Loot_12 = {
        OreTab = "Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32,Ore_33,Ore_34,Ore_35,Ore_36,Ore_37,Ore_38,Ore_39",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
    Loot_13 = {
        OreTab = "Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_14 = {
        OreTab = "Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_15 = {
        OreTab = "Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_16 = {
        OreTab = "Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
    Loot_17 = {
        OreTab = "Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
    Loot_18 = {
        OreTab = "Ore_14,Ore_15,Ore_16,Ore_17,Ore_18,Ore_19,Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_19 = {
        OreTab = "Ore_14,Ore_15,Ore_16,Ore_17,Ore_18,Ore_19,Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_20 = {
        OreTab = "Ore_14,Ore_15,Ore_16,Ore_17,Ore_18,Ore_19,Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,16.6,16.6,16.6,16.6,16.6,16.6",
    },
    Loot_21 = {
        OreTab = "Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32,Ore_33,Ore_34,Ore_35,Ore_36,Ore_37,Ore_38,Ore_39",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
    Loot_22 = {
        OreTab = "Ore_20,Ore_21,Ore_22,Ore_23,Ore_24,Ore_25,Ore_26,Ore_27,Ore_28,Ore_29,Ore_30,Ore_31,Ore_32,Ore_33,Ore_34,Ore_35,Ore_36,Ore_37,Ore_38,Ore_39",
        Chance = "1566.6,1566.6,1566.6,1566.6,1566.6,1566.6,83.3,83.3,83.3,83.3,83.3,83.3,12.5,12.5,12.5,12.5,12.5,12.5,12.5",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Stage.StageEnemyConfig
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Stage.StageEnemyConfig
-- Decompile time: 4.73 ms

return {
    Stage_1 = {{EnemyID = "Enemy_1", PointID = "1", ATK = 7}, {EnemyID = "Enemy_1", PointID = "2", ATK = 7}},
    Stage_2 = {
        {EnemyID = "Enemy_2", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_2", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_2", PointID = "3", ATK = 7},
    },
    Stage_3 = {
        {EnemyID = "Boss_1", PointID = "1", IsBoss = true, ATK = 20},
        {EnemyID = "Enemy_3", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_3", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_3", PointID = "4", ATK = 7},
    },
    Stage_4 = {
        {EnemyID = "Enemy_4", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_4", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_4", PointID = "3", ATK = 7},
    },
    Stage_5 = {
        {EnemyID = "Enemy_4", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_4", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_5", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_5", PointID = "4", ATK = 7},
    },
    Stage_6 = {
        {EnemyID = "Enemy_5", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_5", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_5", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_5", PointID = "4", ATK = 7},
    },
    Stage_7 = {
        {EnemyID = "Boss_2", PointID = "1", IsBoss = true, ATK = 20},
        {EnemyID = "Enemy_8", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_8", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_8", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_8", PointID = "5", ATK = 7},
    },
    Stage_8 = {
        {EnemyID = "Enemy_6", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_6", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_6", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_6", PointID = "4", ATK = 7},
    },
    Stage_9 = {
        {EnemyID = "Enemy_6", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_6", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "4", ATK = 7},
    },
    Stage_10 = {
        {EnemyID = "Enemy_7", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "5", ATK = 7},
    },
    Stage_11 = {
        {EnemyID = "Enemy_7", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_7", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "5", ATK = 7},
    },
    Stage_12 = {
        {EnemyID = "Boss_3", IsBoss = true, PointID = "1", ATK = 20},
        {EnemyID = "Enemy_9", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "5", ATK = 7},
        {EnemyID = "Enemy_9", PointID = "6", ATK = 7},
    },
    Stage_13 = {
        {EnemyID = "Enemy_10", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_10", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_10", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_10", PointID = "4", ATK = 7},
    },
    Stage_14 = {
        {EnemyID = "Enemy_10", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_10", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "4", ATK = 7},
    },
    Stage_15 = {
        {EnemyID = "Enemy_11", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "4", ATK = 7},
    },
    Stage_16 = {
        {EnemyID = "Enemy_11", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_11", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "5", ATK = 7},
    },
    Stage_17 = {
        {EnemyID = "Boss_4", IsBoss = true, PointID = "1", ATK = 20},
        {EnemyID = "Enemy_12", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "5", ATK = 7},
        {EnemyID = "Enemy_12", PointID = "6", ATK = 7},
    },
    Stage_18 = {
        {EnemyID = "Enemy_13", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_13", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_13", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_13", PointID = "4", ATK = 7},
    },
    Stage_19 = {
        {EnemyID = "Enemy_13", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_13", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "4", ATK = 7},
    },
    Stage_20 = {
        {EnemyID = "Enemy_14", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "4", ATK = 7},
    },
    Stage_21 = {
        {EnemyID = "Enemy_14", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_14", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "5", ATK = 7},
    },
    Stage_22 = {
        {EnemyID = "Boss_5", IsBoss = true, PointID = "1", ATK = 20},
        {EnemyID = "Enemy_15", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "5", ATK = 7},
        {EnemyID = "Enemy_15", PointID = "6", ATK = 7},
    },
    Stage_23 = {
        {EnemyID = "Enemy_16", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_16", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_16", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_16", PointID = "4", ATK = 7},
    },
    Stage_24 = {
        {EnemyID = "Enemy_16", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_16", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "4", ATK = 7},
    },
    Stage_25 = {
        {EnemyID = "Enemy_17", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "4", ATK = 7},
    },
    Stage_26 = {
        {EnemyID = "Enemy_17", PointID = "1", ATK = 7},
        {EnemyID = "Enemy_17", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "5", ATK = 7},
    },
    Stage_27 = {
        {EnemyID = "Boss_6", IsBoss = true, PointID = "1", ATK = 20},
        {EnemyID = "Enemy_18", PointID = "2", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "3", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "4", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "5", ATK = 7},
        {EnemyID = "Enemy_18", PointID = "6", ATK = 7},
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.SuperLoot.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.SuperLoot.Config
-- Decompile time: 0.50 ms

return {
    Legendary = {Time = 720, HP = 6, Stages = {1, 7}},
    Eternal = {Time = 1800, HP = 10, Stages = {8, 14}},
    Secret = {Time = 2700, HP = 15, Stages = {15, 22}},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.SuperLoot.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.SuperLoot.Helper
-- Decompile time: 0.84 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.GetConfig() -- Line: 5 -- upvalues: Config (val)
    return Config
end

function v1.GetTime(a1) -- Line: 9 -- upvalues: Config (val)
    if not Config[a1] then
        return nil
    end
    return Config[a1].Time
end

function v1.GetHP(a1) -- Line: 16 -- upvalues: Config (val)
    if not Config[a1] then
        return nil
    end
    return Config[a1].HP
end

function v1.GetStages(a1) -- Line: 23 -- upvalues: Config (val)
    if not Config[a1] then
        return nil
    end
    return Config[a1].Stages
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.TrainArea.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.TrainArea.Helper
-- Decompile time: 1.82 ms

local u0 = {}
local Config = require(script.Parent.Config)

function u0.GetConfig() -- Line: 5 -- upvalues: Config (val)
    return Config
end

function u0.CheckID(a1) -- Line: 9 -- upvalues: Config (val)
    return Config[a1]
end

function u0.GetBasic(a1) -- Line: 13 -- upvalues: u0 (val), Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if u0.CheckID(a1) then
        return Config[a1].Basic
    end
    return nil
end

function u0.GetNeedRebirth(a1) -- Line: 22 -- upvalues: u0 (val), Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if u0.CheckID(a1) then
        return Config[a1].NeedRebirth
    end
    return nil
end

function u0.GetIsPay(a1) -- Line: 31 -- upvalues: u0 (val), Config (val)
    if type(a1) == "string" then
        a1 = tonumber(a1)
    end
    if u0.CheckID(a1) then
        return Config[a1].IsPay
    end
    return nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.TrainArea.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.TrainArea.Config
-- Decompile time: 0.63 ms

return {
    {Basic = 1.5, NeedRebirth = 0},
    {Basic = 2, NeedRebirth = 2},
    {Basic = 4, NeedRebirth = 5},
    {Basic = 6, NeedRebirth = 9},
    {Basic = 8, NeedRebirth = 12},
    {Basic = 10, NeedRebirth = 15},
    {Basic = 15, NeedRebirth = 18},
    {Basic = 25, NeedRebirth = 21},
    {Basic = 100, NeedRebirth = 0, IsPay = true},
    {Basic = 10, NeedRebirth = 0, IsPay = true},
    {Basic = 20, NeedRebirth = 0, IsPay = true},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.UpdateLog.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.UpdateLog.Helper
-- Decompile time: 1.27 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.GetConfig() -- Line: 5 -- upvalues: Config (val)
    return Config
end

function v1.GetVersion(a1) -- Line: 9 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Version
    end
end

function v1.GetRewardList(a1) -- Line: 15 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].RewardList
    end
end

function v1.GetLogs(a1) -- Line: 20 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Logs
    end
end

function v1.GetLogsHang(a1) -- Line: 26 -- upvalues: Config (val)
    if Config[a1] then
        return #Config[a1].Logs:split("\n")
    end
end

function v1.GetImage(a1) -- Line: 33 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Image
    end
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.UpdateLog.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.UpdateLog.Config
-- Decompile time: 0.92 ms

return {
    {
        Version = "4.1",
        Image = "rbxassetid://88334080833026",
        Logs = "Update Announcement\n\nRace Gameplay Released\n- Draw different races to change your appearance and gain powerful bonuses \n- Demons on the left, angels on the right. Mighty races await you!\n\nNew Paid Set \n- Astral Genesis: The Tri‑Wyrm Set is now live!\n- Exclusive skills, stunning visuals, await your acquisition!\n\nRedeem Code Feature\n- Added redeem code feature at the bottom of the shop interface.\n- Enter redeem codes to claim exclusive rewards!\n\nBug Fixes\n- Fixed a rare issue where players could not exit training state after leaving the training zone.\n- Fixed abnormal playback of the first segment of Omega Rush's visual effects.\n\n",
        RewardList = {},
    },
    {
        Version = "4.2",
        Image = "rbxassetid://88334080833026",
        Logs = "Update Announcement\n\nBug Fixes\n- Fixed bug: Ores dropped by Golden Goblins unobtainable\n- Fixed abnormal purchase records of some items\n- Fixed abnormal data logging on Power Leaderboard\n- Fixed bottom aura effect bug for race characters\n- Fixed an issue with abnormal character visuals in the skill preview area.\n- Fixed stuttering issues with auto click.\n\nBug fixes are ongoing. Please submit Feedback if you encounter any in-game bugs. We will work hard to resolve issues and maintain your gameplay experience.\n\n",
        RewardList = {{Type = "GameSetting", ID = "ClassRoll", Number = 2}},
    },
    {
        Version = "4.3",
        Image = "rbxassetid://88334080833026",
        Logs = "Update Announcement\n\nNew Stages Released\n- Stages 23~27, Shadow Castle are now available.\n- Defeat stronger enemies to rarer ores.\n- Defeat Count Dracula for a small chance to obtain the rarest ore!\n\nBug Fixes\n- Fixed bug where ores rarely failed to drop under high network latency.\n- Fixed incorrect text descriptions.\n\n",
        RewardList = {
            {Type = "Material", ID = "Dungeon_Ticket", Number = 1},
            {Type = "Potion", ID = "TrainPotion", Number = 1},
        },
    },
    {
        Version = "4.4",
        Image = "rbxassetid://84246602492513",
        Logs = "Update Announcement\n\nEnhancement System is Here!!!\n- Enhance your weapons, helmets, and armor.\n- Gain powerful buffs and unlock flashy enhancement effects.\n- Enhancement materials have a chance to drop from stages and the Frostbound Tower.\n- Complete weekly quests to obtain enhancement materials.\n\nNew Armors Available\n- Four new craftable armor sets added.\n- Boasting cooler appearances and stronger stats.\n- Don’t forget the collection rewards!\n\nSoul Pack Released\n- Soul Pack is now available. Wield it to conquer all battles.\n\nBug Fixes\n- Fixed an issue where Golden Goblins spawned abnormally.\n- Fixed a rare bug where the player preview in the backpack would not update when switching equipment.\n- Fixed the bug that allowed Void skills to be cast in the lobby.\n\n",
        RewardList = {
            {Type = "Material", ID = "EnhantStone_1", Number = 15},
            {Type = "GameSetting", ID = "ClassRoll", Number = 2},
        },
    },
    {
        Version = "4.5",
        Image = "rbxassetid://123044041502387",
        Logs = "Update Announcement\n\nWorld Boss Available\n- Hellfire · Wrath of Apocalypse · War descends upon the Ancient Battlefield. His wrath shall destroy everything. \n- As his HP drops, he grows even more ferocious.\n- Gather your allies and defeat the mighty Boss.\n- Defeat the Boss to obtain rare rewards.\n\nSeason 1 Launch \n- Complete quests to earn Season XP and claim Season rewards.\n- Defeat the World Boss for massive XP.\n- Two brand-new Season sets, available for a limited time.\n- More rewards await you!\n\nFrostbound Tower Update \n- Updated to Floor 50, featuring higher floors and stronger enemies.\n- Season Coins and Prismatic Stone are available for you to obtain.\n\nBug Fixes \n- Fixed the bug with limited equipment quantity refresh.\n- Fixed the bug where online power bonus resets with online rewards.\n- Fixed the bug causing power bonus UI to pop up in the Forging interface.\n\n",
        RewardList = {
            {Type = "GameSetting", ID = "SeasonCoin", Number = 500},
            {Type = "GameSetting", ID = "SeasonTicket", Number = 2},
        },
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Upgrade.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Upgrade.Config
-- Decompile time: 0.46 ms

local v1
local v2 = {}
for i, j in script:GetChildren() do
    v1 = require(j)
    v2[j.Name] = v1
end
return v2
-- Script Path: game:GetService("ReplicatedStorage").Config.Upgrade.Config.Luck
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Upgrade.Config.Luck
-- Decompile time: 0.71 ms

return {
    [0] = {Number = 0, Price = 0},
    {Number = 0.02, Price = 2500},
    {Number = 0.04, Price = 8000},
    {Number = 0.06, Price = 15000},
    {Number = 0.1, Price = 48000},
    {Number = 0.14, Price = 200000},
    {Number = 0.18, Price = 880000},
    {Number = 0.23, Price = 2500000},
    {Number = 0.28, Price = 8000000},
    {Number = 0.32, Price = 15000000},
    {Number = 0.37, Price = 75800000},
    {Number = 0.4, Price = 220000000},
    {Number = 0.42, Price = 1550000000},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Upgrade.Config.OrePack
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Upgrade.Config.OrePack
-- Decompile time: 0.52 ms

return {
    [0] = {Number = 4, Price = 0},
    {Number = 5, Price = 200},
    {Number = 6, Price = 1000},
    {Number = 7, Price = 5000},
    {Number = 8, Price = 30000},
    {Number = 9, Price = 150000},
    {Number = 10, Price = 280000},
    {Number = 11, Price = 1250000},
    {Number = 12, Price = 3900000},
    {Number = 13, Price = 5000000},
    {Number = 14, Price = 8832700},
    {Number = 15, Price = 25800000},
    {Number = 16, Price = 60000000},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Upgrade.Config.Train
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Upgrade.Config.Train
-- Decompile time: 0.64 ms

return {
    [0] = {Number = 0, Price = 0},
    {Number = 0.02, Price = 2500},
    {Number = 0.04, Price = 8000},
    {Number = 0.06, Price = 15000},
    {Number = 0.1, Price = 48000},
    {Number = 0.15, Price = 200000},
    {Number = 0.2, Price = 880000},
    {Number = 0.25, Price = 2500000},
    {Number = 0.32, Price = 8000000},
    {Number = 0.4, Price = 15000000},
    {Number = 0.48, Price = 75800000},
    {Number = 0.56, Price = 220000000},
    {Number = 0.65, Price = 1550000000},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Upgrade.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Upgrade.Helper
-- Decompile time: 2.20 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.CheckIsMax(a1, a2) -- Line: 5 -- upvalues: Config (val)
    if not a2 then
        return nil
    end
    if type(a2) == "string" then
        a2 = tonumber(a2)
    end
    if not Config[a1][a2 + 1] then
        return true
    end
    return false
end

function v1.GetNumber(a1, a2) -- Line: 18 -- upvalues: Config (val)
    if Config[a1][a2] then
        return Config[a1][a2].Number
    end
    return nil
end

function v1.GetPrice(a1, a2) -- Line: 24 -- upvalues: Config (val)
    if Config[a1][a2] then
        return Config[a1][a2].Price
    end
    return nil
end

function v1.CheckType(a1) -- Line: 30 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.Weapon.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Weapon.Config
-- Decompile time: 4.53 ms

return {
    K_1 = {
        Train = 1,
        Price = 40,
        SkillLootID = "Loot_1",
        Rarity = "Common",
        DesignPower = 1,
    },
    K_2 = {
        TLevel = "T1",
        Train = 5,
        Price = 60,
        SkillLootID = "Loot_1",
        Rarity = "Common",
        DesignPower = 1.2,
    },
    K_3 = {
        TLevel = "T1",
        Train = 12,
        Price = 80,
        SkillLootID = "Loot_1",
        Rarity = "UnCommon",
        DesignPower = 1.5,
    },
    K_4 = {
        TLevel = "T1",
        Train = 30,
        Price = 100,
        SkillLootID = "Loot_1",
        Rarity = "UnCommon",
        DesignPower = 2,
    },
    K_5 = {
        TLevel = "T2",
        Train = 50,
        Price = 120,
        SkillLootID = "Loot_2",
        Rarity = "UnCommon",
        DesignPower = 2.6,
    },
    K_6 = {
        TLevel = "T2",
        Train = 125,
        Price = 160,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 3.4,
    },
    K_7 = {
        TLevel = "T2",
        Train = 300,
        Price = 600,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 5,
    },
    K_8 = {
        TLevel = "T2",
        Train = 500,
        Price = 900,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 7,
    },
    K_9 = {
        TLevel = "T2",
        Train = 1250,
        Price = 1350,
        SkillLootID = "Loot_2",
        Rarity = "Epic",
        DesignPower = 10,
    },
    K_10 = {
        TLevel = "T3",
        Train = 3100,
        Price = 5500,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 13,
    },
    K_11 = {
        TLevel = "T3",
        Train = 5000,
        Price = 8200,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 16,
    },
    K_12 = {
        TLevel = "T3",
        Train = 12500,
        Price = 10000,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 19,
    },
    K_13 = {
        TLevel = "T3",
        Train = 70000,
        Price = 14000,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 23,
    },
    K_14 = {
        TLevel = "T3",
        Train = 150000,
        Price = 56000,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 28,
    },
    K_15 = {
        TLevel = "T3",
        Train = 300000,
        Price = 98000,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 34,
    },
    K_16 = {
        TLevel = "T3",
        Train = 750000,
        Price = 140000,
        SkillLootID = "Loot_3",
        Rarity = "Mythic",
        DesignPower = 39,
    },
    K_17 = {
        TLevel = "T4",
        Train = 1880000,
        Price = 250000,
        SkillLootID = "Loot_4",
        Rarity = "Mythic",
        DesignPower = 45,
    },
    K_18 = {
        TLevel = "T4",
        Train = 4000000,
        Price = 1000000,
        SkillLootID = "Loot_4",
        Rarity = "Mythic",
        DesignPower = 52,
    },
    K_19 = {
        TLevel = "T4",
        Train = 10000000,
        Price = 1960000,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 60,
    },
    K_20 = {
        TLevel = "T4",
        Train = 25000000,
        Price = 2100000,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 70,
    },
    K_21 = {
        TLevel = "T4",
        Train = 50000000,
        Price = 5000000,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 82,
    },
    K_22 = {
        TLevel = "T4",
        Train = 100000000,
        Price = 7840000,
        SkillLootID = "Loot_4",
        Rarity = "Secret",
        DesignPower = 96,
    },
    K_23 = {
        TLevel = "T4",
        Train = 150000000,
        Price = 10000000,
        SkillLootID = "Loot_4",
        Rarity = "Secret",
        DesignPower = 109,
    },
    K_24 = {
        TLevel = "T4",
        Train = 200000000,
        Price = 12000000,
        SkillLootID = "Loot_4",
        Rarity = "Ancient",
        DesignPower = 123,
    },
    K_25 = {
        TLevel = "T4",
        Train = 400000000,
        Price = 55000000,
        SkillLootID = "Loot_4",
        Rarity = "Ancient",
        DesignPower = 135,
    },
    K_26 = {
        TLevel = "T4",
        Train = 600000000,
        Price = 82500000,
        SkillLootID = "Loot_4",
        Rarity = "Infinite",
        DesignPower = 150,
    },
    G_1 = {
        TLevel = "T1",
        Train = 2,
        Price = 48,
        SkillLootID = "Loot_1",
        Rarity = "Common",
        DesignPower = 1,
    },
    G_2 = {
        TLevel = "T1",
        Train = 6,
        Price = 71,
        SkillLootID = "Loot_1",
        Rarity = "UnCommon",
        DesignPower = 1.2,
    },
    G_3 = {
        TLevel = "T1",
        Train = 15,
        Price = 95,
        SkillLootID = "Loot_1",
        Rarity = "UnCommon",
        DesignPower = 1.5,
    },
    G_4 = {
        TLevel = "T1",
        Train = 36,
        Price = 118,
        SkillLootID = "Loot_1",
        Rarity = "UnCommon",
        DesignPower = 2,
    },
    G_5 = {
        TLevel = "T2",
        Train = 59,
        Price = 142,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 2.6,
    },
    G_6 = {
        TLevel = "T2",
        Train = 148,
        Price = 189,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 3.4,
    },
    G_7 = {
        TLevel = "T2",
        Train = 354,
        Price = 708,
        SkillLootID = "Loot_2",
        Rarity = "Rare",
        DesignPower = 5,
    },
    G_8 = {
        TLevel = "T2",
        Train = 590,
        Price = 1062,
        SkillLootID = "Loot_2",
        Rarity = "Epic",
        DesignPower = 7,
    },
    G_9 = {
        TLevel = "T3",
        Train = 1475,
        Price = 1593,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 10,
    },
    G_10 = {
        TLevel = "T3",
        Train = 3658,
        Price = 6490,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 13,
    },
    G_11 = {
        TLevel = "T3",
        Train = 5900,
        Price = 9676,
        SkillLootID = "Loot_3",
        Rarity = "Epic",
        DesignPower = 16,
    },
    G_12 = {
        TLevel = "T3",
        Train = 14750,
        Price = 11800,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 19,
    },
    G_13 = {
        TLevel = "T3",
        Train = 82600,
        Price = 16520,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 23,
    },
    G_14 = {
        TLevel = "T3",
        Train = 177000,
        Price = 66080,
        SkillLootID = "Loot_3",
        Rarity = "Legendary",
        DesignPower = 28,
    },
    G_15 = {
        TLevel = "T4",
        Train = 354000,
        Price = 115640,
        SkillLootID = "Loot_4",
        Rarity = "Mythic",
        DesignPower = 34,
    },
    G_16 = {
        TLevel = "T4",
        Train = 885000,
        Price = 165200,
        SkillLootID = "Loot_4",
        Rarity = "Mythic",
        DesignPower = 39,
    },
    G_17 = {
        TLevel = "T4",
        Train = 2218400,
        Price = 295000,
        SkillLootID = "Loot_4",
        Rarity = "Mythic",
        DesignPower = 45,
    },
    G_18 = {
        TLevel = "T4",
        Train = 4720000,
        Price = 1180000,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 52,
    },
    G_19 = {
        TLevel = "T4",
        Train = 11800000,
        Price = 2312800,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 60,
    },
    G_20 = {
        TLevel = "T4",
        Train = 29500000,
        Price = 2478000,
        SkillLootID = "Loot_4",
        Rarity = "Eternal",
        DesignPower = 70,
    },
    G_21 = {
        TLevel = "T4",
        Train = 59000000,
        Price = 5900000,
        SkillLootID = "Loot_4",
        Rarity = "Secret",
        DesignPower = 82,
    },
    G_22 = {
        TLevel = "T4",
        Train = 118000000,
        Price = 9251200,
        SkillLootID = "Loot_4",
        Rarity = "Secret",
        DesignPower = 96,
    },
    G_23 = {
        TLevel = "T4",
        Train = 177000000,
        Price = 11800000,
        SkillLootID = "Loot_4",
        Rarity = "Ancient",
        DesignPower = 109,
    },
    G_24 = {
        TLevel = "T4",
        Train = 236000000,
        Price = 14160000,
        SkillLootID = "Loot_4",
        Rarity = "Ancient",
        DesignPower = 123,
    },
    G_25 = {
        TLevel = "T4",
        Train = 472000000,
        Price = 64900000,
        SkillLootID = "Loot_4",
        Rarity = "Infinite",
        DesignPower = 135,
    },
    G_26 = {
        TLevel = "T4",
        Train = 708000000,
        Price = 97350000,
        SkillLootID = "Loot_4",
        Rarity = "Infinite",
        DesignPower = 150,
    },
    K_1001 = {
        BestPercent = true,
        MaxTrain = 165000,
        Train = 1.1,
        SkillLootID = "Loot_3",
        Rarity = "Exclusive",
    },
    G_1001 = {
        BaseWeight = 1,
        UsePower = 2.1,
        Train = 750,
        SkillLootID = "Loot_2",
        Rarity = "Epic",
    },
    K_1002 = {
        BestPercent = true,
        MaxTrain = 247500000,
        Train = 1.65,
        SkillLootID = "Loot_4",
        Rarity = "Exclusive",
    },
    G_1002 = {
        BestPercent = true,
        MaxTrain = 838400000,
        Train = 2.2,
        SkillLootID = "Loot_4",
        Rarity = "Exclusive",
    },
    G_1003 = {Train = 900000, SkillLootID = "Loot_4", Rarity = "Mythic"},
    K_1101 = {
        BestPercent = true,
        MaxTrain = 708400000,
        Train = 1.2,
        SkillLootID = "Loot_3",
        Rarity = "Exclusive",
    },
    G_1101 = {BestPercent = true, Train = 1.95, SkillLootID = "Loot_4", Rarity = "Exclusive"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Weapon.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Weapon.Helper
-- Decompile time: 6.89 ms

local u0 = {}
local Config = require(script.Parent.Config)
local Show = require(script.Parent.Show)
local ForgePercent = require(script.Parent.ForgePercent)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils_2 = require(ReplicatedStorage.Utils.TableUtils)
local u30 = #ForgePercent - TableUtils_2.getTableLegth(ForgePercent) + 1
local u31 = #ForgePercent
for i, j in Config do
    if i:split("_")[1] == "G" then
        j.Type = "Great"
    elseif i:split("_")[1] == "K" then
        j.Type = "Katana"
    elseif i:split("_")[1] == "L" then
        j.Type = "Light"
    end
end

function parseRangeValue(a1) -- Line: 23
    if type(a1) ~= "string" then
        return a1
    end
    local v1, v2 = string.match(a1, "^[%{%[]%s*([%-%d%.]+)%s*,%s*([%-%d%.]+)%s*[%}%]]$")
    if v1 ~= nil and v2 ~= nil then
        return (tonumber(v1)), (tonumber(v2))
    end
    return a1
end

function u0.GetConfig() -- Line: 36 -- upvalues: Config (val)
    return Config
end

function u0.GetShow() -- Line: 39 -- upvalues: Show (val)
    return Show
end

function u0.GetForgePercent() -- Line: 42 -- upvalues: ForgePercent (val)
    return ForgePercent
end

function u0.CheckID(a1) -- Line: 45 -- upvalues: Config (val)
    if Config[a1] then
        return true
    end
    return false
end

function u0.GetLayout(a1) -- Line: 52 -- upvalues: Config (val) -- types: a1: string
    if Config[a1] then
        return (math.round(Config[a1].Price))
    end
end

function u0.GetWeaponData(a1) -- Line: 58 -- upvalues: Config (val) -- types: a1: string
    return Config[a1]
end

function u0.GetProperty(a1, a2) -- Line: 62 -- upvalues: Config (val) -- types: a1: string, a2: string
    local v1 = Config[a1]
    if v1 == nil then
        return nil
    end
    return v1[a2]
end

function u0.GetSmallType(a1) -- Line: 70 -- upvalues: u0 (val) -- types: a1: string
    return u0.GetProperty(a1, "Type")
end

function u0.GetTLevel(a1) -- Line: 73 -- upvalues: u0 (val) -- types: a1: string
    return u0.GetProperty(a1, "TLevel")
end

function u0.GetMainAffix(a1) -- Line: 77 -- upvalues: u0 (val)
    return u0.GetProperty(a1, "Train")
end

function u0.GetSellPrice(a1) -- Line: 81 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].Price
    end
    return nil
end

function u0.GetDisName(a1) -- Line: 88 -- upvalues: Show (val) -- types: a1: string
    return Show[a1].DisplayName
end

function u0.GetImage(a1) -- Line: 91 -- upvalues: Show (val) -- types: a1: string
    return Show[a1].Image
end

function u0.GetRarity(a1) -- Line: 94 -- upvalues: Config (val) -- types: a1: string
    return Config[a1].Rarity
end

function u0.GetMaxTrain(a1) -- Line: 98 -- upvalues: Config (val)
    return Config[a1].MaxTrain
end

function u0.GetWhiteImage(a1) -- Line: 102 -- upvalues: Show (val) -- types: a1: string
    return Show[a1].WhiteImage or ""
end

function u0.GetForgePercentByNumber(a1) -- Line: 106 -- upvalues: u30 (val), u31 (val), ForgePercent (val)
    if a1 < u30 then
        return nil
    end
    if u31 < a1 then
        a1 = u31
    end
    return ForgePercent[a1]
end

function u0.GetForgeWeaponsByTLevel(a1, a2, a3) -- Line: 117 -- upvalues: u0 (val) -- types: a2: number
    if not a3 then
        a3 = {}
    end
    local v1 = u0.GetForgeWeaponsByForgeType(a1)
    local v2 = {}
    local v3, v4 = a2, a1
    while #v2 == 0 do
        if v3 <= 0 then
            warn("怎么回事？？？", v3, v4)
            break
        end
        for i, j in v1 do
            if (u0.GetTLevel(j)) == ("T%*"):format(v3) then
                table.insert(v2, j)
            end
        end
        v3 = v3 - 1
    end
    for k, n in v2 do
        if not table.find(a3, n) then
            table.insert(a3, n)
        end
    end
    return a3
end

function u0.GetForgeWeaponsByForgeType(a1) -- Line: 145 -- upvalues: Config (val)
    local v1 = {}
    for i, j in Config do
        if j.TLevel and j.Type == a1 then
            table.insert(v1, i)
        end
    end
    return v1
end

local u68 = {}
for k, n in ForgePercent[u30] do
    table.insert(u68, k)
end

function u0.GetForgeTypes() -- Line: 160 -- upvalues: u68 (val)
    return u68
end

function u0.GetSkillLootID(a1) -- Line: 165 -- upvalues: Config (val)
    return Config[a1].SkillLootID
end

function u0.CheckIsBestPercent(a1) -- Line: 169 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].BestPercent
    end
    return false
end

function u0.GetDesignPower(a1) -- Line: 176 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1].DesignPower
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").Config.Weapon.ForgePercent
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Weapon.ForgePercent
-- Decompile time: 0.65 ms

return {
    [4] = {Katana = 1, Great = 0},
    [5] = {Katana = 0.85, Great = 0.15},
    [6] = {Katana = 0.7, Great = 0.3},
    [7] = {Katana = 0.6, Great = 0.35},
    [8] = {Katana = 0.5, Great = 0.5},
    [9] = {Katana = 0.45, Great = 0.55},
    [10] = {Katana = 0.35, Great = 0.65},
    [11] = {Katana = 0.3, Great = 0.7},
    [12] = {Katana = 0.15, Great = 0.85},
    [13] = {Katana = 0, Great = 1},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Weapon.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Weapon.Show
-- Decompile time: 2.37 ms

return {
    Great = {DisplayName = "Greatsword"},
    Katana = {DisplayName = "Katana"},
    G_1 = {Image = "rbxassetid://77765296191788", DisplayName = "Ironclad"},
    G_2 = {Image = "rbxassetid://96645782231307", DisplayName = "Solaris"},
    G_3 = {Image = "rbxassetid://92454624968525", DisplayName = "Zephyr"},
    G_4 = {Image = "rbxassetid://128019101516601", DisplayName = "Azure Guard"},
    G_5 = {Image = "rbxassetid://115828887126062", DisplayName = "Aether Reach"},
    G_6 = {Image = "rbxassetid://139665889206931", DisplayName = "Void"},
    G_7 = {Image = "rbxassetid://88248403500618", DisplayName = "Abyssal Fang"},
    G_8 = {Image = "rbxassetid://94791947442761", DisplayName = "Celestial Hilt"},
    G_9 = {Image = "rbxassetid://133729970113996", DisplayName = "Runebound"},
    G_10 = {Image = "rbxassetid://94378462327257", DisplayName = "Void Harbinger"},
    G_11 = {Image = "rbxassetid://89069688769944", DisplayName = "Nightshade"},
    G_12 = {Image = "rbxassetid://123872247623084", DisplayName = "Frostbite"},
    G_13 = {Image = "rbxassetid://120320279310329", DisplayName = "Dreadmaw"},
    G_14 = {Image = "rbxassetid://106092637725026", DisplayName = "Lunar Crescent"},
    G_15 = {Image = "rbxassetid://103791291344877", DisplayName = "Inferno"},
    G_16 = {Image = "rbxassetid://75089410632957", DisplayName = "Iron Bastion"},
    G_17 = {Image = "rbxassetid://96309589875400", DisplayName = "Crimson Supernova"},
    G_18 = {Image = "rbxassetid://100175779426325", DisplayName = "Fel-Corrupt"},
    G_19 = {Image = "rbxassetid://89342386680911", DisplayName = "Glacial Spire"},
    G_20 = {Image = "rbxassetid://102764469555529", DisplayName = "Solar Core"},
    G_21 = {Image = "rbxassetid://80758172701051", DisplayName = "Crimson Calamity"},
    G_22 = {Image = "rbxassetid://97001162844416", DisplayName = "Plague Monarch"},
    G_23 = {Image = "rbxassetid://128311852988063", DisplayName = "Abyssal Doom"},
    G_24 = {Image = "rbxassetid://135860650847600", DisplayName = "Aether Wrath"},
    G_25 = {Image = "rbxassetid://84295277388666", DisplayName = "Frostfang Arbiter"},
    G_26 = {Image = "rbxassetid://79043684069821", DisplayName = "Infernal Overlord"},
    K_1 = {Image = "rbxassetid://113300170759987", DisplayName = "Silent Whisper"},
    K_2 = {Image = "rbxassetid://136986838154540", DisplayName = "Crimson Ember"},
    K_3 = {Image = "rbxassetid://126437299206998", DisplayName = "Verdant Serpent"},
    K_4 = {Image = "rbxassetid://74685758153054", DisplayName = "Jagged Havoc"},
    K_5 = {Image = "rbxassetid://78972526099328", DisplayName = "Azure Apex"},
    K_6 = {Image = "rbxassetid://122249420363678", DisplayName = "Void Rifter"},
    K_7 = {Image = "rbxassetid://87919327718475", DisplayName = "Draco-Ignis"},
    K_8 = {Image = "rbxassetid://105702574089936", DisplayName = "Lunar Crescent"},
    K_9 = {Image = "rbxassetid://107710821659049", DisplayName = "Phantom Violet"},
    K_10 = {Image = "rbxassetid://78947168577249", DisplayName = "Glacial Sunder"},
    K_11 = {Image = "rbxassetid://76876720498900", DisplayName = "Golden Aegis"},
    K_12 = {Image = "rbxassetid://82748840002642", DisplayName = "Chaos Reaver"},
    K_13 = {Image = "rbxassetid://110434917838784", DisplayName = "Royal Verdure"},
    K_14 = {Image = "rbxassetid://118559666525699", DisplayName = "Magma Reaver"},
    K_15 = {Image = "rbxassetid://108034559818637", DisplayName = "Storm Weaver"},
    K_16 = {Image = "rbxassetid://108264273024925", DisplayName = "Demon’s Wrath"},
    K_17 = {Image = "rbxassetid://120510753176723", DisplayName = "Arcane Starfall"},
    K_18 = {Image = "rbxassetid://138898385083876", DisplayName = "Crimson Viper"},
    K_19 = {Image = "rbxassetid://93457367182685", DisplayName = "Blaze Fury"},
    K_20 = {Image = "rbxassetid://138341950604759", DisplayName = "Sunflare Relic"},
    K_21 = {Image = "rbxassetid://97507787571805", DisplayName = "Venomspine"},
    K_22 = {Image = "rbxassetid://91705732966897", DisplayName = "Frostbite Fang"},
    K_23 = {Image = "rbxassetid://114837782081708", DisplayName = "Voidwalker"},
    K_24 = {Image = "rbxassetid://87259536837948", DisplayName = "Amethyst Crescent"},
    K_25 = {Image = "rbxassetid://82896292035437", DisplayName = "Chrome Vanguard"},
    K_26 = {Image = "rbxassetid://116325219446837", DisplayName = "Bone Carver"},
    K_1001 = {Image = "rbxassetid://116872327581631", DisplayName = "Eldritch Thorn"},
    G_1001 = {Image = "rbxassetid://105669876084302", DisplayName = "Nether Bane"},
    K_1002 = {Image = "rbxassetid://91878803581135", DisplayName = "Void Obliterator"},
    G_1002 = {Image = "rbxassetid://104900293046301", DisplayName = "Astral Supernova Edge"},
    G_1003 = {Image = "rbxassetid://85604070407847", DisplayName = "Soul Devourer"},
    K_1101 = {Image = "rbxassetid://121023048071647", DisplayName = "Ruin"},
    G_1101 = {Image = "rbxassetid://77919227806881", DisplayName = "Chaoseater"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Weapon.Show
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Weapon.Show
-- Decompile time: 2.37 ms

return {
    Great = {DisplayName = "Greatsword"},
    Katana = {DisplayName = "Katana"},
    G_1 = {Image = "rbxassetid://77765296191788", DisplayName = "Ironclad"},
    G_2 = {Image = "rbxassetid://96645782231307", DisplayName = "Solaris"},
    G_3 = {Image = "rbxassetid://92454624968525", DisplayName = "Zephyr"},
    G_4 = {Image = "rbxassetid://128019101516601", DisplayName = "Azure Guard"},
    G_5 = {Image = "rbxassetid://115828887126062", DisplayName = "Aether Reach"},
    G_6 = {Image = "rbxassetid://139665889206931", DisplayName = "Void"},
    G_7 = {Image = "rbxassetid://88248403500618", DisplayName = "Abyssal Fang"},
    G_8 = {Image = "rbxassetid://94791947442761", DisplayName = "Celestial Hilt"},
    G_9 = {Image = "rbxassetid://133729970113996", DisplayName = "Runebound"},
    G_10 = {Image = "rbxassetid://94378462327257", DisplayName = "Void Harbinger"},
    G_11 = {Image = "rbxassetid://89069688769944", DisplayName = "Nightshade"},
    G_12 = {Image = "rbxassetid://123872247623084", DisplayName = "Frostbite"},
    G_13 = {Image = "rbxassetid://120320279310329", DisplayName = "Dreadmaw"},
    G_14 = {Image = "rbxassetid://106092637725026", DisplayName = "Lunar Crescent"},
    G_15 = {Image = "rbxassetid://103791291344877", DisplayName = "Inferno"},
    G_16 = {Image = "rbxassetid://75089410632957", DisplayName = "Iron Bastion"},
    G_17 = {Image = "rbxassetid://96309589875400", DisplayName = "Crimson Supernova"},
    G_18 = {Image = "rbxassetid://100175779426325", DisplayName = "Fel-Corrupt"},
    G_19 = {Image = "rbxassetid://89342386680911", DisplayName = "Glacial Spire"},
    G_20 = {Image = "rbxassetid://102764469555529", DisplayName = "Solar Core"},
    G_21 = {Image = "rbxassetid://80758172701051", DisplayName = "Crimson Calamity"},
    G_22 = {Image = "rbxassetid://97001162844416", DisplayName = "Plague Monarch"},
    G_23 = {Image = "rbxassetid://128311852988063", DisplayName = "Abyssal Doom"},
    G_24 = {Image = "rbxassetid://135860650847600", DisplayName = "Aether Wrath"},
    G_25 = {Image = "rbxassetid://84295277388666", DisplayName = "Frostfang Arbiter"},
    G_26 = {Image = "rbxassetid://79043684069821", DisplayName = "Infernal Overlord"},
    K_1 = {Image = "rbxassetid://113300170759987", DisplayName = "Silent Whisper"},
    K_2 = {Image = "rbxassetid://136986838154540", DisplayName = "Crimson Ember"},
    K_3 = {Image = "rbxassetid://126437299206998", DisplayName = "Verdant Serpent"},
    K_4 = {Image = "rbxassetid://74685758153054", DisplayName = "Jagged Havoc"},
    K_5 = {Image = "rbxassetid://78972526099328", DisplayName = "Azure Apex"},
    K_6 = {Image = "rbxassetid://122249420363678", DisplayName = "Void Rifter"},
    K_7 = {Image = "rbxassetid://87919327718475", DisplayName = "Draco-Ignis"},
    K_8 = {Image = "rbxassetid://105702574089936", DisplayName = "Lunar Crescent"},
    K_9 = {Image = "rbxassetid://107710821659049", DisplayName = "Phantom Violet"},
    K_10 = {Image = "rbxassetid://78947168577249", DisplayName = "Glacial Sunder"},
    K_11 = {Image = "rbxassetid://76876720498900", DisplayName = "Golden Aegis"},
    K_12 = {Image = "rbxassetid://82748840002642", DisplayName = "Chaos Reaver"},
    K_13 = {Image = "rbxassetid://110434917838784", DisplayName = "Royal Verdure"},
    K_14 = {Image = "rbxassetid://118559666525699", DisplayName = "Magma Reaver"},
    K_15 = {Image = "rbxassetid://108034559818637", DisplayName = "Storm Weaver"},
    K_16 = {Image = "rbxassetid://108264273024925", DisplayName = "Demon’s Wrath"},
    K_17 = {Image = "rbxassetid://120510753176723", DisplayName = "Arcane Starfall"},
    K_18 = {Image = "rbxassetid://138898385083876", DisplayName = "Crimson Viper"},
    K_19 = {Image = "rbxassetid://93457367182685", DisplayName = "Blaze Fury"},
    K_20 = {Image = "rbxassetid://138341950604759", DisplayName = "Sunflare Relic"},
    K_21 = {Image = "rbxassetid://97507787571805", DisplayName = "Venomspine"},
    K_22 = {Image = "rbxassetid://91705732966897", DisplayName = "Frostbite Fang"},
    K_23 = {Image = "rbxassetid://114837782081708", DisplayName = "Voidwalker"},
    K_24 = {Image = "rbxassetid://87259536837948", DisplayName = "Amethyst Crescent"},
    K_25 = {Image = "rbxassetid://82896292035437", DisplayName = "Chrome Vanguard"},
    K_26 = {Image = "rbxassetid://116325219446837", DisplayName = "Bone Carver"},
    K_1001 = {Image = "rbxassetid://116872327581631", DisplayName = "Eldritch Thorn"},
    G_1001 = {Image = "rbxassetid://105669876084302", DisplayName = "Nether Bane"},
    K_1002 = {Image = "rbxassetid://91878803581135", DisplayName = "Void Obliterator"},
    G_1002 = {Image = "rbxassetid://104900293046301", DisplayName = "Astral Supernova Edge"},
    G_1003 = {Image = "rbxassetid://85604070407847", DisplayName = "Soul Devourer"},
    K_1101 = {Image = "rbxassetid://121023048071647", DisplayName = "Ruin"},
    G_1101 = {Image = "rbxassetid://77919227806881", DisplayName = "Chaoseater"},
}
-- Script Path: game:GetService("ReplicatedStorage").Config.WorldBoss.Config
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.WorldBoss.Config
-- Decompile time: 0.62 ms

return {
    ["1"] = {
        Type = "Material",
        ID = "EnhantProtect",
        Number = 1,
        Weight = 15,
        GValue = 1,
        Rarity = "Legendary",
    },
    ["2"] = {
        Type = "Material",
        ID = "EnhantStone_2",
        Number = 10,
        Weight = 45,
        GValue = 0.8,
        Rarity = "Legendary",
    },
    ["3"] = {
        Type = "GameSetting",
        ID = "SeasonTicket",
        Number = 1,
        Weight = 50,
        GValue = 0.4,
        Rarity = "Epic",
    },
    ["4"] = {
        Type = "Material",
        ID = "EnhantStone_1",
        Number = 120,
        Weight = 90,
        GValue = 0.6,
        Rarity = "Epic",
    },
    ["5"] = {
        Type = "Potion",
        ID = "TrainPotion",
        Number = 1,
        Weight = 150,
        GValue = 0.2,
        Rarity = "Common",
    },
    ["6"] = {
        Type = "Potion",
        ID = "LuckPotion",
        Number = 1,
        Weight = 150,
        GValue = 0.3,
        Rarity = "Common",
    },
    ["7"] = {
        Type = "GameSetting",
        ID = "SeasonCoin",
        Number = 400,
        Weight = 150,
        GValue = 0.1,
        Rarity = "Common",
    },
    ["8"] = {
        Type = "Eco",
        ID = "coin",
        Number = 5000,
        Weight = 350,
        GValue = 0.1,
        Rarity = "Common",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.WorldBoss.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.WorldBoss.Helper
-- Decompile time: 1.29 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.GetRebirthTime() -- Line: 9
    return 1800
end

function v1.GetFirstRebirthTime() -- Line: 12
    return 1200
end

function v1.GetEscapeTime() -- Line: 15
    return 480
end

function v1.GetWeightTab(a1) -- Line: 19 -- upvalues: Config (val)
    local v1 = {}
    for i, j in Config do
        v1[i] = j.Weight * (1 + (a1 - 1) * j.GValue)
    end
    return v1
end

function v1.GetReward(a1) -- Line: 30 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1]
    end
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.WorldBoss.Helper
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.WorldBoss.Helper
-- Decompile time: 1.29 ms

local v1 = {}
local Config = require(script.Parent.Config)

function v1.GetRebirthTime() -- Line: 9
    return 1800
end

function v1.GetFirstRebirthTime() -- Line: 12
    return 1200
end

function v1.GetEscapeTime() -- Line: 15
    return 480
end

function v1.GetWeightTab(a1) -- Line: 19 -- upvalues: Config (val)
    local v1 = {}
    for i, j in Config do
        v1[i] = j.Weight * (1 + (a1 - 1) * j.GValue)
    end
    return v1
end

function v1.GetReward(a1) -- Line: 30 -- upvalues: Config (val)
    if Config[a1] then
        return Config[a1]
    end
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Config.GameSetting
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.GameSetting
-- Decompile time: 0.87 ms

return {
    Icon = {
        coin = "rbxassetid://105478995988344",
        Coin = "rbxassetid://105478995988344",
        ATK = "rbxassetid://84214776605047",
        Damage = "rbxassetid://84214776605047",
        damage = "rbxassetid://84214776605047",
        Power = "rbxassetid://84214776605047",
        power = "rbxassetid://84214776605047",
        Train = "rbxassetid://84214776605047",
        train = "rbxassetid://84214776605047",
        Luck = "rbxassetid://107686769118607",
        luck = "rbxassetid://107686769118607",
        Rebirth = "rbxassetid://81228247285688",
        rebirth = "rbxassetid://81228247285688",
        Robux = "rbxassetid://114623544252601",
        robux = "rbxassetid://114623544252601",
        Online = "rbxassetid://128585831574963",
        Sign = "rbxassetid://96956260245839",
        PotionPack = "rbxassetid://127999527027922",
        ["?"] = "rbxassetid://138759153778664",
        Dui = "rbxassetid://96750228273855",
        LockImage = "rbxassetid://16399760265",
        UnLockImage = "rbxassetid://119622329931980",
        Default_Weapon = "rbxassetid://119416539349628",
        Default_Hat = "rbxassetid://80844849549799",
        Default_Armor = "rbxassetid://79004361715632",
        OrePack = "rbxassetid://79345331997933",
        WalkSpeed = "rbxassetid://88716767229334",
        MoveSpeed = "rbxassetid://88716767229334",
        CoinPotion = "rbxassetid://121177986783156",
        LuckPotion = "rbxassetid://111240558888066",
        Defence = "rbxassetid://136546048254221",
        RainbowDice = "rbxassetid://84392750318899",
        ClassRoll = "rbxassetid://118598506198309",
        SeasonCoin = "rbxassetid://106078344964828",
        SeasonTicket = "rbxassetid://91179321076637",
        SkillDamage = "rbxassetid://84214776605047",
        SkillCD = "rbxassetid://114599091755322",
        Crit = "rbxassetid://133658809064132",
    },
    DisName = {
        ClassRoll = "Race Roll",
        SeasonCoin = "Season Coin",
        SeasonTicket = "Season Ticket",
        Coin = "Coin",
        coin = "Coin",
    },
    Rarity = {
        ClassRoll = "Legendary",
        SeasonCoin = "Common",
        SeasonTicket = "Legendary",
        Coin = "Common",
        coin = "Common",
    },
}
-- Script Path: game:GetService("ReplicatedStorage").Config.Monetization
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Config.Monetization
-- Decompile time: 7.51 ms

local Cost, v1
game:GetService("ServerScriptService")
game:GetService("MarketplaceService")
game:GetService("ReplicatedStorage")
local u15 = {
    DevProducts = {
        SkipOnline = {Id = 3709919556, Cost = 199},
        AutoTrainArea_9 = {Id = 3709907980, Cost = 649},
        AutoTrainArea_10 = {Id = 3713120085, Cost = 99},
        AutoTrainArea_11 = {Id = 3713120101, Cost = 299},
        TrainPotion_1 = {Id = 3710202035, Cost = 9},
        LuckPotion_1 = {Id = 3710202012, Cost = 19},
        DamagePotion_1 = {Id = 3710202057, Cost = 9},
        StarterPack = {Id = 3710313589, Cost = 79},
        SoulPack = {Id = 3714668606, Cost = 899},
        StarterPack_UnDiscount = {Id = 3713091395, Cost = 199},
        PowerPack_1 = {Id = 3710313651, Cost = 19},
        PowerPack_2 = {Id = 3710313670, Cost = 99},
        PowerPack_3 = {Id = 3710313689, Cost = 299},
        PowerPack_4 = {Id = 3710313706, Cost = 799},
        TrainMulti_1 = {Id = 3709889707, Cost = 9},
        SkillCell_2 = {Id = 3712048171, Cost = 149},
        G_1001 = {Id = 3712054646, Cost = 9},
        OfflineRewardx10 = {Id = 3712054602, Cost = 49},
        DungeonRebirth = {Id = 3712227263, Cost = 9},
        RecoverOre = {Id = 3712345888, Cost = 3},
        GearSet_1 = {Id = 3712352612, Cost = 1299},
        GearSet_1_Weapon = {Id = 3712352585, Cost = 699},
        GearSet_1_Hat = {Id = 3712352517, Cost = 399},
        GearSet_1_Armor = {Id = 3712352548, Cost = 599},
        TowerTicketPack_1 = {Id = 3713094959, Cost = 49},
        TowerTicketPack_2 = {Id = 3713094977, Cost = 199},
        TowerTicketPack_3 = {Id = 3713094996, Cost = 1199},
        TowerTicketPack_4 = {Id = 3713095006, Cost = 4999},
        SkipRebirth_1 = {Id = 3713114368, Cost = 9},
        SkipRebirth_2 = {Id = 3713114375, Cost = 29},
        SkipRebirth_3 = {Id = 3713114390, Cost = 49},
        SkipRebirth_4 = {Id = 3713114431, Cost = 79},
        SkipRebirth_5 = {Id = 3713114445, Cost = 99},
        SkipRebirth_6 = {Id = 3713114462, Cost = 129},
        SkipRebirth_7 = {Id = 3713114666, Cost = 199},
        SkipRebirth_8 = {Id = 3713114710, Cost = 249},
        SkipRebirth_9 = {Id = 3713114718, Cost = 299},
        SkipRebirth_10 = {Id = 3713114738, Cost = 369},
        SkipRebirth_11 = {Id = 3713114746, Cost = 449},
        SkipRebirth_12 = {Id = 3713114763, Cost = 549},
        SkipRebirth_13 = {Id = 3713114773, Cost = 599},
        SkipRebirth_14 = {Id = 3713114787, Cost = 629},
        SkipRebirth_15 = {Id = 3713114798, Cost = 679},
        SkipRebirth_16 = {Id = 3713114823, Cost = 749},
        SkipRebirth_17 = {Id = 3713114845, Cost = 799},
        SkipRebirth_18 = {Id = 3713114856, Cost = 849},
        SkipRebirth_19 = {Id = 3713114866, Cost = 899},
        SkipRebirth_20 = {Id = 3713114878, Cost = 929},
        SkipRebirth_21 = {Id = 3713114887, Cost = 979},
        SkipRebirth_22 = {Id = 3713114894, Cost = 999},
        SkipRebirth_23 = {Id = 3713114909, Cost = 1109},
        SkipRebirth_24 = {Id = 3713114928, Cost = 1199},
        SkipRebirth_25 = {Id = 3713114938, Cost = 1229},
        SkipRebirth_26 = {Id = 3713114952, Cost = 1299},
        SkipRebirth_27 = {Id = 3713114961, Cost = 1339},
        SkipRebirth_28 = {Id = 3713114971, Cost = 1399},
        SkipRebirth_29 = {Id = 3713114979, Cost = 1449},
        SkipRebirth_30 = {Id = 3713114994, Cost = 1499},
        SkipRebirth_31 = {Id = 3713115013, Cost = 1559},
        SkipRebirth_32 = {Id = 3713115024, Cost = 1599},
        SkipRebirth_33 = {Id = 3713115032, Cost = 1639},
        SkipRebirth_34 = {Id = 3713115037, Cost = 1699},
        SkipRebirth_35 = {Id = 3713115043, Cost = 1739},
        SkipRebirth_36 = {Id = 3713115054, Cost = 1799},
        SkipRebirth_37 = {Id = 3713115066, Cost = 1829},
        SkipRebirth_38 = {Id = 3713115094, Cost = 1899},
        SkipRebirth_39 = {Id = 3713115108, Cost = 1949},
        SkipRebirth_40 = {Id = 3713115124, Cost = 1999},
        SkipRebirth_41 = {Id = 3713115134, Cost = 2099},
        SkipRebirth_42 = {Id = 3716189573, Cost = 2199},
        SkipRebirth_43 = {Id = 3716189633, Cost = 2299},
        SkipRebirth_44 = {Id = 3716189658, Cost = 2349},
        SkipRebirth_45 = {Id = 3716189697, Cost = 2399},
        SkipRebirth_46 = {Id = 3716189718, Cost = 2449},
        SkipRebirth_47 = {Id = 3716189741, Cost = 2499},
        SkipRebirth_48 = {Id = 3716189763, Cost = 2599},
        SkipRebirth_49 = {Id = 3716189800, Cost = 2649},
        SkipRebirth_50 = {Id = 3716189839, Cost = 2699},
        SkipRebirth_51 = {Id = 3716189888, Cost = 2739},
        SkipRebirth_52 = {Id = 3716189912, Cost = 2799},
        SkipRebirth_53 = {Id = 3716189935, Cost = 2799},
        SkipRebirth_54 = {Id = 3716189955, Cost = 2799},
        SkipRebirth_55 = {Id = 3716189981, Cost = 2799},
        SkipRebirth_56 = {Id = 3716189993, Cost = 2799},
        SkipRebirth_57 = {Id = 3716190016, Cost = 3049},
        SkipRebirth_58 = {Id = 3716190045, Cost = 3129},
        SkipRebirth_59 = {Id = 3716190065, Cost = 3199},
        SkipRebirth_60 = {Id = 3716190097, Cost = 3239},
        SkipRebirth_61 = {Id = 3716190121, Cost = 3299},
        ClassIndex_4 = {Id = 3713362105, Cost = 99},
        ClassIndex_5 = {Id = 3713362119, Cost = 249},
        ClassIndex_6 = {Id = 3713362142, Cost = 499},
        GearSet_2 = {Id = 3713390381, Cost = 8999},
        GearSet_2_Weapon = {Id = 3713390401, Cost = 5999},
        GearSet_2_Hat = {Id = 3713390431, Cost = 3999},
        GearSet_2_Armor = {Id = 3713390459, Cost = 4999},
        ClassRoll_1 = {Id = 3713622468, Cost = 79},
        ClassRoll_2 = {Id = 3713622592, Cost = 249},
        ClassRoll_3 = {Id = 3713622649, Cost = 599},
        EnhantPack_1 = {Id = 3714605859, Cost = 99},
        EnhantPack_2 = {Id = 3714606008, Cost = 499},
        EnhantPack_3 = {Id = 3714606069, Cost = 1299},
        EnhantPack_4 = {Id = 3714606124, Cost = 2999},
        SkipEnhantQuest = {Id = 3714640856, Cost = 199},
        SeasonVIP = {Id = 3715754144, Cost = 399},
        SeasonLevel_1 = {Id = 3715754178, Cost = 129},
        SeasonBossRewardx2 = {Id = 3715754332, Cost = 129},
        RefreshSeasonQuest = {Id = 3715754405, Cost = 199},
        RefreshSeasonShop = {Id = 3715755432, Cost = 49},
        SeasonLuck_1 = {Id = 3715754621, Cost = 69},
        SeasonLuck_3 = {Id = 3715754644, Cost = 189},
        SeasonLuck_10 = {Id = 3715754665, Cost = 499},
    },
    Gamepasses = {
        VIP = {Id = 1962630901, Cost = 349, Image = "rbxassetid://119305259428157", Description = "VIP"},
        SkipForge = {Id = 1962564854, Cost = 29, Image = "rbxassetid://133485887522205", Description = "x200%"},
        MoreOre = {Id = 1963764856, Cost = 399, Image = "rbxassetid://133485887522205", Description = "x200%"},
        CommonLuck = {Id = 1965960643, Cost = 79, Image = "rbxassetid://94361284403565", Description = "x150%"},
        SuperLuck = {Id = 1963566878, Cost = 299, Image = "rbxassetid://133485887522205", Description = "x200%"},
        UltraLuck = {Id = 1982474360, Cost = 999, Image = "rbxassetid://133485887522205", Description = "x500%"},
    },
    Config = {
        PowerPack = {600, 1200, 3600, 9600},
        TrainMulti = {2},
        TowerTicketPack = {10, 50, 400, 2000},
        ClassRoll = {1, 5, 10},
        EnhantEvent = {
            {EnhantStone_1 = 900},
            {EnhantStone_1 = 3500, EnhantStone_2 = 10, EnhantProtect = 3},
            {EnhantStone_1 = 13500, EnhantStone_2 = 80, EnhantProtect = 8},
            {EnhantStone_1 = 30000, EnhantStone_2 = 300, EnhantProtect = 20},
        },
    },
}
for i, j in u15.DevProducts do
    if not j.Cost then
        warn((("%*这个没罗宝价格"):format(i)))
    elseif 50000 <= j.Cost then
        v1 = warn
        Cost = j.Cost
        v1((("%*这个罗宝价格认真的吗？%*"):format(i, Cost)))
    end
end

function u15.GetMonIDById(a1) -- Line: 206 -- upvalues: u15 (val)
    local v1 = nil
    for i, j in u15.DevProducts do
        if j.Id == a1 then
            v1 = i
            break
        end
    end
    if not v1 then
        for k, n in u15.Gamepasses do
            if n.Id == a1 then
                return k
            end
        end
    end
    return v1
end

function u15.GetCost(a1) -- Line: 225 -- upvalues: u15 (val)
    if u15.DevProducts[a1] then
        return u15.DevProducts[a1].Cost
    end
    if u15.Gamepasses[a1] then
        return u15.Gamepasses[a1].Cost
    end
    warn("无效商品名", a1)
end

return u15
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL
-- Decompile time: 2.02 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Utils.CommunicationUtils)
require(ReplicatedStorage.Utils.AllPlayerRemoteUtils)
RunService:IsServer()
local u22 = {}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        u22[j.Name] = (require(j))
    end
end

function v1.AnySkill(a1, a2, a3) -- Line: 21 -- upvalues: u22 (val)
    return (u22[a2].Play(a1, a3))
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_1_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_1_ATK
-- Decompile time: 3.62 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u53 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 22
    -- upvalues: u53 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u53.ActionTime
    local Phase = u53.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 33 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 38 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 46 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_1_S1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_1_S1
-- Decompile time: 6.54 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u64 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u67 = Helper.GetSkillConfigByID(Name)
local u68 = {}

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u0 (val), Trove (val), u68 (val), u67 (val), TimeListFunc (val), Name (val), WarnUtils (val)
    -- upvalues: CharUtils (val), VFXUtils (val), u64 (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    u0.Stop(a1)
    local u10 = Trove.new()
    u68[a1] = u10
    local AnimObj = a2.AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local v1 = TimeListFunc.new()
    u10:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 47 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    v1:AddTickFunc(Phase[1].DelayTime, function() -- Line: 51
        -- upvalues: Phase (val), WarnUtils (upval), a1 (val), CharUtils (upval), VFXUtils (upval), u64 (upval)
        local DamageConfig = Phase[2].DamageConfig
        WarnUtils.CreateCircleWarningVFX(a1, {
            CFrame = a1:GetPivot(),
            Size = DamageConfig.Size,
            Time = Phase[2].DelayTime,
        })
        CharUtils.SetWalkSpeedNum(a1, 0, 10, "Boss_1_S1")
        local v1 = VFXUtils.CreateCharVFX(a1, u64:WaitForChild("Submit_1"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v1)
    end)
    v1:AddTickFunc(Phase[2].DelayTime, function() -- Line: 64
        -- upvalues: AnimObj (val), Phase (val), DamageUtils (upval), a1 (val), Name (upval), u10 (val)
        -- upvalues: VFXUtils (upval), u64 (upval)
        if AnimObj then
            AnimObj:PlayAnim("Boss_1_S1_Ring")
        end
        local DamageConfig = Phase[2].DamageConfig
        u10:Add((DamageUtils.RingDamage_Self(a1, Name, 2, DamageConfig)))
        local v1 = VFXUtils.CreateCharVFX(a1, u64:WaitForChild("Enable_1"), 3, "RootAttachment")
        if v1 then
            VFXUtils.EnablePart(v1)
            u10:Add(v1)
        end
    end)
    v1:AddTickFunc(ActionTime, function() -- Line: 76 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 83 -- upvalues: u68 (val), CharUtils (val) -- types: a1: userdata
    if u68[a1] then
        u68[a1]:Clean()
        u68[a1] = nil
    end
    if a1 and a1.Parent then
        CharUtils.RemoveWalkSpeed(a1, "Boss_1_S1")
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_2_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_2_ATK
-- Decompile time: 3.95 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_2_S1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_2_S1
-- Decompile time: 3.49 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u63 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 24
    -- upvalues: u63 (val), TimeListFunc (val), Name (val), WarnUtils (val), DamageUtils (val), VFXUtils (val)
    -- upvalues: u60 (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u63.ActionTime
    local Phase = u63.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 35 -- upvalues: AnimObj (val), Name (upval), Phase (val), WarnUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        local DamageConfig = Phase[1].DamageConfig
        WarnUtils.CreateCircleWarningVFX(a1, {
            CFrame = a1:GetPivot(),
            Size = DamageConfig.Size,
            Time = Phase[1].DelayTime,
        })
    end)
    u11:AddTickFunc(Phase[1].DelayTime, function() -- Line: 47
        -- upvalues: Phase (val), DamageUtils (upval), a1 (val), Name (upval), VFXUtils (upval), u60 (upval)
        local v1 = Phase[1]
        if v1.DamageConfig then
            local v2, v3 = DamageUtils.AOEDamage_Self(a1, Name, 1, v1.DamageConfig)
        end
        VFXUtils.CreateVFXEmiteOnce(u60:WaitForChild("Submit"), a1:GetPivot(), 2)
    end)
    u11:AddTickFunc(ActionTime, function() -- Line: 61 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_3_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_3_ATK
-- Decompile time: 3.33 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_3_S1
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_3_S1
-- Decompile time: 10.11 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u68 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u71 = Helper.GetSkillConfigByID(Name)
local u72 = {}

function u0.Play(a1, a2) -- Line: 29
    -- upvalues: u0 (val), Trove (val), u72 (val), u71 (val), TimeListFunc (val), Name (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u68 (val), ModelVFXUtils (val), WarnUtils (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    u0.Stop(a1)
    local v1 = Trove.new()
    u72[a1] = v1
    local AnimObj = a2.AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local v2 = TimeListFunc.new()
    v1:Add(v2)
    v2:AddTickFunc(0, function() -- Line: 48 -- upvalues: AnimObj (val), Name (upval), CharUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        CharUtils.SetWalkSpeedNum(a1, 0, 100, "Boss_3_S1")
    end)
    for i, j in Phase do
        v2:AddTickFunc(j.DelayTime, function() -- Line: 55
            -- upvalues: a1 (val), j (val), VFXUtils (upval), u68 (upval), ModelVFXUtils (upval), a2 (ref)
            -- upvalues: WarnUtils (upval), DamageUtils (upval), Name (upval), i (val)
            if a1 and a1.Parent then
                if not a1:FindFirstChild("FootAtta", true) then
                    return
                end
                local DamageConfig = j.DamageConfig
                local WorldCFrame_2 = a1:FindFirstChild("GunFire", true).WorldCFrame
                local v1 = VFXUtils.CreateVFX(u68:WaitForChild("Bullet"), CFrame.new(WorldCFrame_2.Position), 1.5)
                if not v1 then
                    task.wait(1.5)
                else
                    ModelVFXUtils.TWCFrame(
                        v1,
                        TweenInfo.new(1.5, Enum.EasingStyle.Linear),
                        CFrame.new(WorldCFrame_2.Position + Vector3.new(0, 150, 0))
                    )
                    v1:Destroy()
                end
                local Pivot = a2.TargetPlayer.Character:GetPivot()
                local WorldCFrame = a1:FindFirstChild("FootAtta", true).WorldCFrame
                local Number = j.Number
                for i2 = 1, Number do
                    task.spawn(function() -- Line: 80
                        -- upvalues: a1 (upval), Pivot (val), WorldCFrame (val), WarnUtils (upval), DamageConfig (val)
                        -- upvalues: VFXUtils (upval), u68 (upval), ModelVFXUtils (upval), DamageUtils (upval)
                        -- upvalues: Name (upval), i (upval)
                        local v1
                        if not a1.Parent then
                            return
                        end
                        local v2 = nil
                        if not v2 then
                            v1 = math.random(1, 360) * 3.141592653589793 / 180
                            local v3 = math.random(2, 40)
                            v2 = (CFrame.new(Pivot.Position + Pivot.LookVector * math.sin(v1) * v3 + Pivot.RightVector * math.cos(v1) * v3)) * CFrame.Angles(3.141592653589793, 0, 0)
                            v2 = (CFrame.new(v2.Position.X, WorldCFrame.Position.Y, v2.Position.Z)) * v2.Rotation
                        end
                        WarnUtils.CreateCircleWarningVFX(a1, {Time = 1.5, CFrame = v2, Size = DamageConfig.Size})
                        v1 = VFXUtils.CreateVFX(
                            u68:WaitForChild("Bullet"),
                            (CFrame.new(v2.Position + Vector3.new(0, 150, 0))) * CFrame.Angles(3.141592653589793, 0, 0),
                            1.5
                        )
                        ModelVFXUtils.TWCFrame(v1, TweenInfo.new(1.5, Enum.EasingStyle.Linear), v2)
                        VFXUtils.CreateVFXEmiteOnce(u68:WaitForChild("Boom"), v2, 2)
                        DamageUtils.AOEDamage_CFrame(a1, v2, Name, i, DamageConfig)
                    end)
                    task.wait(0.5)
                end
                return
            end
        end)
    end
    v2:AddTickFunc(ActionTime, function() -- Line: 142 -- upvalues: u0 (upval), a1 (val), CharUtils (upval)
        u0.Stop(a1)
        CharUtils.RemoveWalkSpeed(a1, "Boss_3_S1")
    end)
    v2:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 150 -- upvalues: u72 (val), CharUtils (val) -- types: a1: userdata
    if u72[a1] then
        u72[a1]:Clean()
        u72[a1] = nil
    end
    if a1 and a1.Parent then
        CharUtils.RemoveWalkSpeed(a1, "Boss_3_S1")
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_4_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_4_ATK
-- Decompile time: 3.39 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_4_S1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_4_S1
-- Decompile time: 4.44 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u68 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u71 = Helper.GetSkillConfigByID(Name)
local u72 = {}

function u0.Play(a1, a2) -- Line: 31
    -- upvalues: u0 (val), Trove (val), u72 (val), u71 (val), TimeListFunc (val), DamageUtils (val), Name (val)
    -- upvalues: CharUtils (val), WarnUtils (val), VFXUtils (val), u68 (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    u0.Stop(a1)
    local v1 = Trove.new()
    u72[a1] = v1
    local AnimObj = a2.AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local v2 = TimeListFunc.new()
    v1:Add(v2)
    local DamageConfig = Phase[1].DamageConfig
    local CFrame = DamageUtils.TryGetTouchConfig(a1, DamageConfig).CFrame
    v2:AddTickFunc(0, function() -- Line: 53
        -- upvalues: AnimObj (val), Name (upval), CharUtils (upval), a1 (val), WarnUtils (upval), CFrame (val)
        -- upvalues: DamageConfig (val), Phase (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        CharUtils.SetWalkSpeedNum(a1, 0, 100, "Boss_4_S1")
        WarnUtils.CreateCircleWarningVFX(a1, {CFrame = CFrame, Size = DamageConfig.Size, Time = Phase[1].DelayTime})
    end)
    v2:AddTickFunc(Phase[1].DelayTime, function() -- Line: 64
        -- upvalues: Phase (val), a1 (val), DamageUtils (upval), Name (upval), VFXUtils (upval), u68 (upval)
        -- upvalues: CFrame (val)
        local DamageConfig = Phase[1].DamageConfig
        local WorldCFrame = a1:FindFirstChild("FootAtta", true).WorldCFrame
        DamageUtils.AOEDamage_Self(a1, Name, 1, DamageConfig)
        VFXUtils.CreateVFXEmiteOnce(u68:WaitForChild("VFX"), CFrame.new(CFrame.Position), 3, nil, true)
    end)
    v2:AddTickFunc(ActionTime, function() -- Line: 73 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v2:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 80 -- upvalues: u72 (val), CharUtils (val) -- types: a1: userdata
    if u72[a1] then
        u72[a1]:Clean()
        u72[a1] = nil
    end
    if a1 and a1.Parent then
        CharUtils.RemoveWalkSpeed(a1, "Boss_4_S1")
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_5_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_5_ATK
-- Decompile time: 2.83 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_5_S1
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_5_S1
-- Decompile time: 14.23 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u75 = Helper.GetSkillConfigByID(Name)
local u76 = {}

function u0.Play(a1, a2) -- Line: 30
    -- upvalues: u0 (val), Trove (val), u76 (val), u75 (val), TimeListFunc (val), Name (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u72 (val), RunUtils (val), CFrameUtils (val), WarnUtils (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    u0.Stop(a1)
    local u10 = Trove.new()
    u76[a1] = u10
    local AnimObj = a2.AnimObj
    local ActionTime = u75.ActionTime
    local Phase = u75.Phase
    local v1 = TimeListFunc.new()
    u10:Add(v1)
    local DamageConfig = Phase[1].DamageConfig
    local u27 = nil
    v1:AddTickFunc(0, function() -- Line: 53
        -- upvalues: AnimObj (val), Name (upval), CharUtils (upval), a1 (val), u27 (ref), VFXUtils (upval), u72 (upval)
        -- upvalues: u10 (val), RunUtils (upval), a2 (ref), CFrameUtils (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        CharUtils.SetWalkSpeedNum(a1, 0, 100, "Boss_5_S1")
        u27 = VFXUtils.CreateCharVFX(a1, u72:WaitForChild("VFX_1"), 3, "RootAttachment")
        if u27 then
            VFXUtils.EmitByPart(u27)
        end
        u10:Add((RunUtils:RegistHeartbeat(nil, nil, function() -- Line: 63 -- upvalues: a1 (upval), a2 (upval), CFrameUtils (upval)
            if not a1 then
                return
            end
            local TargetPlayer = a2.TargetPlayer
            if not TargetPlayer then
                return
            end
            local Character = TargetPlayer.Character
            if not Character then
                return
            end
            local Pivot = Character:GetPivot()
            local v1 = CFrameUtils.FaceToCF(a1:GetPivot(), Pivot)
            a1:PivotTo(v1)
        end)))
    end)
    for i = 1, 3 do
        v1:AddTickFunc(Phase[i].DelayTime, function() -- Line: 82
            -- upvalues: a1 (val), Phase (val), i (val), a2 (ref), u27 (ref), VFXUtils (upval), u72 (upval)
            -- upvalues: WarnUtils (upval), DamageUtils (upval), Name (upval)
            if not a1.Parent then
                return
            end
            local DamageConfig = Phase[i].DamageConfig
            local Pivot = a1:GetPivot()
            local WorldCFrame = (a1:FindFirstChild("FootAtta", true)).WorldCFrame
            local TargetPlayer = a2.TargetPlayer
            if not TargetPlayer then
                return
            end
            local Character = TargetPlayer.Character
            if not Character then
                return
            end
            local Pivot_2 = Character:GetPivot()
            local u32 = (CFrame.new(Pivot_2.Position.X, WorldCFrame.Position.Y, Pivot_2.Position.Z)) * Pivot_2.Rotation
            local FlightSpeed = DamageConfig.FlightSpeed
            local v1 = (Pivot.Position - u32.Position).Magnitude / FlightSpeed
            if u27 then
                local v2 = CFrame.lookAt((u27:FindFirstChild(i)).CFrame.Position, u32.Position)
                local v3 = VFXUtils.CreateVFX(u72:WaitForChild("Ice_Fly"), v2, v1 + 0.5)
                VFXUtils.FlyVFX(v3, v2, v2.LookVector, FlightSpeed, v1)
            end
            WarnUtils.CreateCircleWarningVFX(a1, {CFrame = u32, Size = DamageConfig.Size, Time = v1})
            task.delay(v1, function() -- Line: 123
                -- upvalues: DamageUtils (upval), a1 (upval), u32 (ref), Name (upval), i (upval), DamageConfig (val)
                -- upvalues: VFXUtils (upval), u72 (upval)
                DamageUtils.AOEDamage_CFrame(a1, u32, Name, i, DamageConfig)
                VFXUtils.CreateVFXEmiteOnce(u72:WaitForChild("Ice_Boom"), u32, 2)
            end)
        end)
    end
    v1:AddTickFunc(ActionTime, function() -- Line: 131 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 138 -- upvalues: u76 (val), CharUtils (val) -- types: a1: userdata
    if u76[a1] then
        u76[a1]:Clean()
        u76[a1] = nil
    end
    if a1 and a1.Parent then
        CharUtils.RemoveWalkSpeed(a1, "Boss_5_S1")
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_6_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_6_ATK
-- Decompile time: 3.43 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Boss_6_S1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Boss_6_S1
-- Decompile time: 9.03 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local CFrameUtils = require(ReplicatedStorage.Utils.CFrameUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u75 = Helper.GetSkillConfigByID(Name)
local u76 = {}

function u0.Play(a1, a2) -- Line: 30
    -- upvalues: u0 (val), Trove (val), u76 (val), u75 (val), TimeListFunc (val), Name (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u72 (val), RunUtils (val), CFrameUtils (val), WarnUtils (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    u0.Stop(a1)
    local u10 = Trove.new()
    u76[a1] = u10
    local AnimObj = a2.AnimObj
    local ActionTime = u75.ActionTime
    local Phase = u75.Phase
    local v1 = TimeListFunc.new()
    u10:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 49
        -- upvalues: AnimObj (val), Name (upval), CharUtils (upval), a1 (val), VFXUtils (upval), u72 (upval), u10 (val)
        -- upvalues: RunUtils (upval), a2 (ref), CFrameUtils (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        CharUtils.SetWalkSpeedNum(a1, 0, 100, "Boss_6_S1")
        local v1 = VFXUtils.CreateCharVFX(a1, u72:WaitForChild("VFX_1"), 2, "FootAtta")
        VFXUtils.EnablePart(v1)
        u10:Add((RunUtils:RegistHeartbeat(nil, nil, function() -- Line: 57 -- upvalues: a1 (upval), a2 (upval), CFrameUtils (upval)
            if not a1 then
                return
            end
            local TargetPlayer = a2.TargetPlayer
            if not TargetPlayer then
                return
            end
            local Character = TargetPlayer.Character
            if not Character then
                return
            end
            local Pivot = Character:GetPivot()
            local v1 = CFrameUtils.FaceToCF(a1:GetPivot(), Pivot)
            a1:PivotTo(v1)
        end)))
    end)
    local u30 = nil
    v1:AddTickFunc(Phase[1].DelayTime, function() -- Line: 75 -- upvalues: u30 (ref), VFXUtils (upval), a1 (val), u72 (upval)
        u30 = VFXUtils.CreateCharVFX(a1, u72:WaitForChild("VFX_2"), 2, "Boss_6_S1")
        VFXUtils.EnablePart(u30)
    end)
    v1:AddTickFunc(Phase[2].DelayTime, function() -- Line: 81
        -- upvalues: a1 (val), Phase (val), a2 (ref), u30 (ref), VFXUtils (upval), WarnUtils (upval)
        -- upvalues: DamageUtils (upval), Name (upval), u72 (upval)
        if not a1.Parent then
            return
        end
        local DamageConfig = Phase[2].DamageConfig
        local Pivot = a1:GetPivot()
        local WorldCFrame = (a1:FindFirstChild("FootAtta", true)).WorldCFrame
        local TargetPlayer = a2.TargetPlayer
        if not TargetPlayer then
            return
        end
        local Character = TargetPlayer.Character
        if not Character then
            return
        end
        local Pivot_2 = Character:GetPivot()
        local u31 = (CFrame.new(Pivot_2.Position.X, WorldCFrame.Position.Y, Pivot_2.Position.Z)) * Pivot_2.Rotation
        local v1 = CFrame.lookAt((u30 and u30:GetPivot() or Pivot).Position, u31.Position)
        local FlightSpeed = DamageConfig.FlightSpeed
        local v2 = (v1.Position - u31.Position).Magnitude / FlightSpeed
        if u30 then
            VFXUtils.UnlockVFX(u30.PrimaryPart)
            VFXUtils.FlyVFX(u30, v1, v1.LookVector, FlightSpeed, v2)
        end
        WarnUtils.CreateCircleWarningVFX(a1, {CFrame = u31, Size = DamageConfig.Size, Time = v2})
        task.delay(v2, function() -- Line: 121
            -- upvalues: DamageUtils (upval), a1 (upval), u31 (ref), Name (upval), DamageConfig (val), VFXUtils (upval)
            -- upvalues: u72 (upval)
            DamageUtils.AOEDamage_CFrame(a1, u31, Name, 2, DamageConfig)
            VFXUtils.CreateVFXEmiteOnce(u72:WaitForChild("VFX_3"), u31, 2)
        end)
    end)
    v1:AddTickFunc(ActionTime, function() -- Line: 129 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 136 -- upvalues: u76 (val), CharUtils (val) -- types: a1: userdata
    if u76[a1] then
        u76[a1]:Clean()
        u76[a1] = nil
    end
    if a1 and a1.Parent then
        CharUtils.RemoveWalkSpeed(a1, "Boss_6_S1")
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_12_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_12_ATK
-- Decompile time: 4.39 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_1_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_1_ATK
-- Decompile time: 3.36 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_2_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_2_ATK
-- Decompile time: 2.88 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_3_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_3_ATK
-- Decompile time: 4.15 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_4_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_4_ATK
-- Decompile time: 4.70 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.Enemy_9_ATK
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.Enemy_9_ATK
-- Decompile time: 3.81 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u58 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 23
    -- upvalues: u58 (val), TimeListFunc (val), Name (val), DamageUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u58.ActionTime
    local Phase = u58.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 34 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u11:AddTickFunc(v.DelayTime, function() -- Line: 39 -- upvalues: v (val), DamageUtils (upval), a1 (val), Name (upval), k (val)
            if v.DamageConfig then
                local v1, v2 = DamageUtils.AOEDamage_Self(a1, Name, k, v.DamageConfig)
            end
        end)
    end
    u11:AddTickFunc(ActionTime, function() -- Line: 47 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.WorldBoss_1_S1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.WorldBoss_1_S1
-- Decompile time: 4.05 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u63 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 24
    -- upvalues: u63 (val), TimeListFunc (val), Name (val), DamageUtils (val), WarnUtils (val), VFXUtils (val)
    -- upvalues: u60 (val), SoundUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u63.ActionTime
    local Phase = u63.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 35
        -- upvalues: AnimObj (val), Name (upval), Phase (val), DamageUtils (upval), a1 (val), WarnUtils (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        local DamageConfig = Phase[1].DamageConfig
        local v1 = DamageUtils.TryGetTouchConfig(a1, DamageConfig)
        WarnUtils.CreateSqrtWarningVFX(a1, {CFrame = v1.CFrame, Size = v1.Size, Time = Phase[1].DelayTime})
    end)
    u11:AddTickFunc(Phase[1].DelayTime, function() -- Line: 51
        -- upvalues: Phase (val), DamageUtils (upval), a1 (val), Name (upval), VFXUtils (upval), u60 (upval)
        -- upvalues: SoundUtils (upval)
        local DamageConfig = Phase[1].DamageConfig
        DamageUtils.AOEDamage_Self(a1, Name, 1, DamageConfig)
        local v1 = VFXUtils.CreateCharVFX(a1, u60:WaitForChild("VFX"), 30, "RootAttachment", true)
        VFXUtils.EmitByPart(v1)
        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S1_1", position = a1:GetPivot().Position})
        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S1", position = a1:GetPivot().Position})
    end)
    u11:AddTickFunc(ActionTime, function() -- Line: 68 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.WorldBoss_1_S2
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.WorldBoss_1_S2
-- Decompile time: 3.98 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local u65 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u68 = Helper.GetSkillConfigByID(Name)

function v1.Play(a1, a2) -- Line: 25
    -- upvalues: u68 (val), TimeListFunc (val), Name (val), DamageUtils (val), WarnUtils (val), VFXUtils (val)
    -- upvalues: u65 (val), CameraUtils (val), SoundUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local AnimObj = a2.AnimObj
    local ActionTime = u68.ActionTime
    local Phase = u68.Phase
    local u11 = TimeListFunc.new()
    u11:AddTickFunc(0, function() -- Line: 36
        -- upvalues: AnimObj (val), Name (upval), Phase (val), DamageUtils (upval), a1 (val), WarnUtils (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        local DamageConfig = Phase[1].DamageConfig
        local v1 = DamageUtils.TryGetTouchConfig(a1, DamageConfig)
        WarnUtils.CreateCircleWarningVFX(a1, {CFrame = v1.CFrame, Size = v1.Size, Time = Phase[1].DelayTime})
    end)
    u11:AddTickFunc(Phase[1].DelayTime, function() -- Line: 52
        -- upvalues: Phase (val), a1 (val), DamageUtils (upval), Name (upval), VFXUtils (upval), u65 (upval)
        -- upvalues: CameraUtils (upval), SoundUtils (upval)
        local DamageConfig = Phase[1].DamageConfig
        local WorldCFrame = a1:FindFirstChild("FootAtta", true).WorldCFrame
        DamageUtils.AOEDamage_Self(a1, Name, 1, DamageConfig)
        VFXUtils.CreateVFXEmiteOnce(u65:WaitForChild("VFX"), WorldCFrame, 3)
        CameraUtils.PosShakeOnce(a1, 7, 10, 10, WorldCFrame)
        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_1", position = a1:GetPivot().Position})
        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_2", position = a1:GetPivot().Position})
        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2", position = a1:GetPivot().Position})
    end)
    u11:AddTickFunc(ActionTime, function() -- Line: 74 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.WorldBoss_1_S4
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.WorldBoss_1_S4
-- Decompile time: 12.18 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local u74 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u77 = Helper.GetSkillConfigByID(Name)

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u0 (val), u77 (val), TimeListFunc (val), Name (val), VFXUtils (val), u74 (val), WarnUtils (val)
    -- upvalues: SoundUtils (val), ModelVFXUtils (val), DamageUtils (val), CameraUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local v1 = a2.BossLevel or 0
    u0.Stop(a1)
    local AnimObj = a2.AnimObj
    local ActionTime = u77.ActionTime
    local Phase = u77.Phase
    local u17 = if v1 == 1 then 3 else if v1 ~= 0 then 6 else 3
    local v2 = TimeListFunc.new()
    v2:AddTickFunc(0, function() -- Line: 51 -- upvalues: AnimObj (val), Name (upval), VFXUtils (upval), a1 (val), u74 (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        local v1 = VFXUtils.CreateCharVFX(a1, u74:WaitForChild("VFX_1"), 4, "RootAttachment", true)
        VFXUtils.EmitByPart(v1)
    end)
    v2:AddTickFunc(Phase[1].DelayTime, function() -- Line: 58
        -- upvalues: a1 (val), VFXUtils (upval), u74 (upval), Phase (val), u17 (ref), WarnUtils (upval)
        -- upvalues: SoundUtils (upval), ModelVFXUtils (upval), DamageUtils (upval), Name (upval), CameraUtils (upval)
        if a1 and a1.Parent then
            local v1, v2, v3, v4
            if not a1:FindFirstChild("FootAtta", true) then
                return
            end
            local v5 = VFXUtils.CreateCharVFX(a1, u74:WaitForChild("VFX_2"), 4, "RootAttachment", true)
            VFXUtils.EmitByPart(v5)
            local DamageConfig = Phase[1].DamageConfig
            a1:GetPivot()
            local WorldCFrame = a1:FindFirstChild("FootAtta", true).WorldCFrame
            local Pivot_2 = ((workspace:WaitForChild("WorldModel")):WaitForChild("WorldBoss")):WaitForChild("Center"):GetPivot()
            local v6 = u17
            for i = 1, v6 do
                v3 = math.random(10, 100)
                v4 = math.random() * 3.141592653589793 * 2
                v1 = Vector3.new(v3 * math.sin(v4), 0, v3 * (math.cos(v4)))
                local u91 = CFrame.new(Vector3.new(Pivot_2.Position.X, WorldCFrame.Position.Y, Pivot_2.Position.Z) + v1)
                WarnUtils.CreateCircleWarningVFX(a1, {Time = 2, CFrame = u91, Size = DamageConfig.Size})
                v2 = u91 * CFrame.new(80, 150, 80)
                local u114 = VFXUtils.CreateVFX(u74:WaitForChild("VFX_3"), v2, 2)
                task.spawn(function() -- Line: 100
                    -- upvalues: SoundUtils (upval), a1 (upval), u91 (val), ModelVFXUtils (upval), u114 (val)
                    -- upvalues: VFXUtils (upval), u74 (upval), DamageUtils (upval), Name (upval), DamageConfig (val)
                    -- upvalues: CameraUtils (upval)
                    SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_4", position = u91.Position})
                    ModelVFXUtils.TWCFrame(u114, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), u91)
                    if a1 and a1.Parent then
                        VFXUtils.CreateVFXEmiteOnce(u74:WaitForChild("VFX_4"), u91, 3)
                        DamageUtils.AOEDamage_CFrame(a1, u91, Name, 1, DamageConfig)
                        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_4_2", position = u91.Position})
                        CameraUtils.PosShakeOnce(a1, 6, 10, 10, u91)
                        return
                    end
                end)
                task.wait(0.7)
            end
            return
        end
    end)
    v2:AddTickFunc(ActionTime, function() -- Line: 125 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v2:StartTimeList()
    return true
end

function u0.Stop(a1, a2) end

return u0
-- Script Path: game:GetService("ReplicatedStorage").EnemySystem.SkillCTRL.WorldBoss_1_S4
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.EnemySystem.SkillCTRL.WorldBoss_1_S4
-- Decompile time: 12.18 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("Debris")
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.Enemy.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local WarnUtils = require(ReplicatedStorage.SkillSystemNew.Utils.WarnUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local u74 = ReplicatedStorage.Assets.SkillVFX_Enemy:FindFirstChild(Name)
local u77 = Helper.GetSkillConfigByID(Name)

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u0 (val), u77 (val), TimeListFunc (val), Name (val), VFXUtils (val), u74 (val), WarnUtils (val)
    -- upvalues: SoundUtils (val), ModelVFXUtils (val), DamageUtils (val), CameraUtils (val)
    if not a1 then
        return
    end
    if not a2 then
        a2 = {}
    end
    local v1 = a2.BossLevel or 0
    u0.Stop(a1)
    local AnimObj = a2.AnimObj
    local ActionTime = u77.ActionTime
    local Phase = u77.Phase
    local u17 = if v1 == 1 then 3 else if v1 ~= 0 then 6 else 3
    local v2 = TimeListFunc.new()
    v2:AddTickFunc(0, function() -- Line: 51 -- upvalues: AnimObj (val), Name (upval), VFXUtils (upval), a1 (val), u74 (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        local v1 = VFXUtils.CreateCharVFX(a1, u74:WaitForChild("VFX_1"), 4, "RootAttachment", true)
        VFXUtils.EmitByPart(v1)
    end)
    v2:AddTickFunc(Phase[1].DelayTime, function() -- Line: 58
        -- upvalues: a1 (val), VFXUtils (upval), u74 (upval), Phase (val), u17 (ref), WarnUtils (upval)
        -- upvalues: SoundUtils (upval), ModelVFXUtils (upval), DamageUtils (upval), Name (upval), CameraUtils (upval)
        if a1 and a1.Parent then
            local v1, v2, v3, v4
            if not a1:FindFirstChild("FootAtta", true) then
                return
            end
            local v5 = VFXUtils.CreateCharVFX(a1, u74:WaitForChild("VFX_2"), 4, "RootAttachment", true)
            VFXUtils.EmitByPart(v5)
            local DamageConfig = Phase[1].DamageConfig
            a1:GetPivot()
            local WorldCFrame = a1:FindFirstChild("FootAtta", true).WorldCFrame
            local Pivot_2 = ((workspace:WaitForChild("WorldModel")):WaitForChild("WorldBoss")):WaitForChild("Center"):GetPivot()
            local v6 = u17
            for i = 1, v6 do
                v3 = math.random(10, 100)
                v4 = math.random() * 3.141592653589793 * 2
                v1 = Vector3.new(v3 * math.sin(v4), 0, v3 * (math.cos(v4)))
                local u91 = CFrame.new(Vector3.new(Pivot_2.Position.X, WorldCFrame.Position.Y, Pivot_2.Position.Z) + v1)
                WarnUtils.CreateCircleWarningVFX(a1, {Time = 2, CFrame = u91, Size = DamageConfig.Size})
                v2 = u91 * CFrame.new(80, 150, 80)
                local u114 = VFXUtils.CreateVFX(u74:WaitForChild("VFX_3"), v2, 2)
                task.spawn(function() -- Line: 100
                    -- upvalues: SoundUtils (upval), a1 (upval), u91 (val), ModelVFXUtils (upval), u114 (val)
                    -- upvalues: VFXUtils (upval), u74 (upval), DamageUtils (upval), Name (upval), DamageConfig (val)
                    -- upvalues: CameraUtils (upval)
                    SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_4", position = u91.Position})
                    ModelVFXUtils.TWCFrame(u114, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), u91)
                    if a1 and a1.Parent then
                        VFXUtils.CreateVFXEmiteOnce(u74:WaitForChild("VFX_4"), u91, 3)
                        DamageUtils.AOEDamage_CFrame(a1, u91, Name, 1, DamageConfig)
                        SoundUtils.PlaySoundInPosition(a1, {soundName = "WB_1_S2_4_2", position = u91.Position})
                        CameraUtils.PosShakeOnce(a1, 6, 10, 10, u91)
                        return
                    end
                end)
                task.wait(0.7)
            end
            return
        end
    end)
    v2:AddTickFunc(ActionTime, function() -- Line: 125 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v2:StartTimeList()
    return true
end

function u0.Stop(a1, a2) end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.AnyInfoGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.AnyInfoGUI
-- Decompile time: 7.46 ms

local u0 = {}
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Helper = require(ReplicatedStorage.Config.Weapon.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Armor.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Enhant.Helper)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local AnyInfo = LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("AnyInfo")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local RichToColor = RichTextUtils.RichToColor

function u0.init() end

function u0.start() end

function u0.LoadFrame(a1, a2) -- Line: 27 -- upvalues: u0 (val) -- types: a1: userdata
    local Type = a2.Type
    local ID = a2.ID
    local u5 = a2.Level or 0
    a1.MouseEnter:Connect(function() -- Line: 32 -- upvalues: Type (val), u0 (upval), ID (val), u5 (val), a2 (val)
        if Type == "Weapon" then
            u0.ShowWeapon(ID, u5)
            return
        end
        if Type == "Hat" then
            u0.ShowHat(ID, u5)
            return
        end
        if Type == "Armor" then
            u0.ShowArmor(ID, u5)
            return
        end
        if a2.Text then
            u0.ShowAnyInfo(a2.Text)
        end
    end)
    a1.MouseLeave:Connect(function() -- Line: 45 -- upvalues: u0 (upval)
        u0.CloseAnyInfo()
    end)
end

function u0.CloseAnyInfo() -- Line: 50 -- upvalues: AnyInfo (val)
    AnyInfo.Visible = false
end

function u0.ShowWeapon(a1, a2) -- Line: 54
    -- upvalues: Helper (val), Helper_3 (val), RichToColor (val), AbbreviateNumber (val), u0 (val)
    local v1
    local v2 = Helper.GetMainAffix(a1)
    local v3 = Helper.CheckIsBestPercent(a1)
    local v4 = Helper_3.GetBoost(a2)
    v2 = v2 * (1 + v4)
    if not v3 then
        v1 = ("Power x%*"):format((RichToColor(AbbreviateNumber(v2), (Color3.fromRGB(0, 255, 0)))))
    else
        v1 = ("" .. RichToColor(("%*%%"):format((math.round(v2 * 100))), Color3.fromRGB(0, 255, 0))) .. " Power as your best weapon."
        local v5 = Helper.GetMaxTrain(a1)
        if not v5 then
            v1 = v1 .. " Not limited!"
        else
            v5 = v5 * (1 + v4)
            v1 = v1 .. (" Max base Power: %*"):format((AbbreviateNumber(v5)))
        end
    end
    u0.ShowAnyInfo(v1)
end

function u0.ShowHat(a1, a2) -- Line: 77 -- upvalues: Helper_2 (val), Helper_3 (val), RichToColor (val), u0 (val)
    local v1
    local v2 = Helper_2.GetMainAffix(a1)
    local v3 = Helper_2.CheckIsBestPercent(a1)
    local v4 = Helper_3.GetBoost(a2)
    v2 = v2 * (1 + v4)
    if not v3 then
        v1 = ("Power +%*"):format((RichToColor(("+%*%%"):format((math.round(v2 * 100))), (Color3.fromRGB(0, 255, 0)))))
    else
        v1 = ("" .. RichToColor(("%*%%"):format((math.round(v2 * 100))), Color3.fromRGB(0, 255, 0))) .. " Power as your best helmet."
        local v5 = Helper_2.GetMaxAttrNum(a1)
        if not v5 then
            v1 = v1 .. " Not limited!"
        else
            v5 = v5 * (1 + v4)
            v1 = v1 .. (" Max base Power: +%*%%"):format((math.round(v5 * 100)))
        end
    end
    u0.ShowAnyInfo(v1)
end

function u0.ShowArmor(a1, a2) -- Line: 100 -- upvalues: Helper_2 (val), Helper_3 (val), RichToColor (val), u0 (val)
    local v1
    local v2 = Helper_2.GetMainAffix(a1)
    local v3 = Helper_2.CheckIsBestPercent(a1)
    local v4 = Helper_3.GetBoost(a2)
    v2 = v2 * (1 + v4)
    if not v3 then
        v1 = ("Defence +%*"):format((RichToColor(("+%*%%"):format((math.round(v2 * 100))), (Color3.fromRGB(0, 255, 0)))))
    else
        v1 = ("" .. RichToColor(("%*%%"):format((math.round(v2 * 100))), Color3.fromRGB(0, 255, 0))) .. " Defence as your best armor."
        local v5 = Helper_2.GetMaxAttrNum(a1)
        if not v5 then
            v1 = v1 .. " Not limited!"
        else
            v5 = v5 * (1 + v4)
            v1 = v1 .. (" Max base Defence: +%*%%"):format((math.round(v5 * 100)))
        end
    end
    u0.ShowAnyInfo(v1)
end

function u0.ShowAnyInfo(a1) -- Line: 124 -- upvalues: AnyInfo (val)
    AnyInfo.Visible = true
    local xinxi = AnyInfo:WaitForChild("xinxi")
    xinxi:WaitForChild("2").Text = a1
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.AutoTrainAreaGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.AutoTrainAreaGUI
-- Decompile time: 3.71 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
LocalPlayer:WaitForChild("PlayerGui")
local Helper = require(ReplicatedStorage.Config.TrainArea.Helper)
local PemData = require(ReplicatedStorage.LocalData.PemData)
local AutoTrainArea = (workspace:WaitForChild("TOUCHED")):WaitForChild("AutoTrainArea")
local rebirth = (LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("rebirth", 999)

function u0.init() end

function u0.start() -- Line: 19 -- upvalues: rebirth (val), u0 (val)
    rebirth.Changed:Connect(function() -- Line: 20 -- upvalues: u0 (upval)
        u0.update()
    end)
    u0.update()
end

function u0.update() -- Line: 25 -- upvalues: AutoTrainArea (val), Helper (val), u0 (val)
    local Frame, Prohibit, Rebirth_4, Robux, UIAtta, v1, v2, v3
    local v4 = true
    for i, j in AutoTrainArea:GetChildren() do
        if j:IsA("Part") then
            UIAtta = j:FindFirstChild("UIAtta")
            if UIAtta then
                Frame = UIAtta:WaitForChild("TrainGui"):WaitForChild("Frame")
                v3 = tonumber(j.Name)
                Helper.GetNeedRebirth(v3)
                v1 = Helper.GetIsPay(v3)
                v2 = CheckCanIntoTrainArea(v3)
                Prohibit = ((Frame:WaitForChild("Rebirth")):WaitForChild("Rebirth")):WaitForChild("Prohibit")
                Prohibit.Enabled = not v2
                Rebirth_4 = (Frame:WaitForChild("Rebirth")):WaitForChild("Rebirth")
                Rebirth_4:WaitForChild("Allow").Enabled = v2
                if Frame:FindFirstChild("Robux") then
                    Robux = Frame:WaitForChild("Robux")
                    Robux.Visible = v1 and not v2
                end
            else
                v4 = false
            end
        end
    end
    if not v4 then
        task.wait(1)
        u0.update()
    end
end

function CheckCanIntoTrainArea(a1) -- Line: 61 -- upvalues: LocalPlayer (val), Helper (val), PemData (val)
    local Value = ((LocalPlayer:WaitForChild("Eco")):WaitForChild("rebirth")).Value
    local v1 = Helper.GetNeedRebirth(a1)
    if Helper.GetIsPay(a1) then
        if PemData.isHavePem("AutoTrainArea_" .. a1) then
            return true
        end
        return false
    end
    if v1 <= Value then
        return true
    end
    return false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.BackpackGUI
-- Took 0.09s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.BackpackGUI
-- Decompile time: 91.48 ms

local u0 = {}
game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("MarketplaceService")
local LocalPlayer = game.Players.LocalPlayer
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
require(ReplicatedStorage.GuiUtils.Message)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.RunUtils)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local BalanceUtils = require(ReplicatedStorage.Utils.BalanceUtils)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Weapon.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Armor.Helper)
local Helper_4 = require(ReplicatedStorage.Config.Ore.Helper)
local Helper_5 = require(ReplicatedStorage.Config.EnchStone.Helper)
local Helper_6 = require(ReplicatedStorage.Config.PlrSkill.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper_7 = require(ReplicatedStorage.Config.Enhant.Helper)
local EquipmentModelUtils = require(ReplicatedStorage.Utils.EquipmentModelUtils)
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local Info = LocalPlayer.PlayerGui:WaitForChild("Info")
local Backpack = Main:WaitForChild("Backpack")
local Main_2 = Backpack:WaitForChild("Main")
local Backpack_2 = ((Hud:WaitForChild("Left")):WaitForChild("Buttons")):WaitForChild("Backpack")
local TextButton = (Backpack:WaitForChild("De")):WaitForChild("TextButton")
local Left = Main_2:WaitForChild("Left")
local Right = Main_2:WaitForChild("Right")
;((Left:WaitForChild("Shang")):WaitForChild("Mingzi")):WaitForChild("TextLabel")
local ViewportFrame = ((Left:WaitForChild("Shang")):WaitForChild("Renwu")):WaitForChild("ViewportFrame")
local Equiped = ((Left:WaitForChild("Shang")):WaitForChild("Renwu")):WaitForChild("Equiped")
local ce = Right:WaitForChild("ce")
local ScrollingFrame = (Right:WaitForChild("Bg")):WaitForChild("ScrollingFrame")
local EquipmentInfo = Backpack:WaitForChild("EquipmentInfo")
local OreInfo = Backpack:WaitForChild("OreInfo")
local MaterialInfo = Backpack:WaitForChild("MaterialInfo")
local AnyInfo = Info:WaitForChild("AnyInfo")
local u231 = {}
local u232 = nil
local u233 = nil
local u234 = nil
local u235 = false
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local RichToColor = RichTextUtils.RichToColor
Vector2.new(Backpack.Position.X.Scale, Backpack.Position.Y.Scale)
Vector2.new(EquipmentInfo.Position.X.Scale, EquipmentInfo.Position.Y.Scale)
Vector2.new(OreInfo.Position.X.Scale, OreInfo.Position.Y.Scale)
local u262 = {"Weapon", "Hat", "Armor", "Ore"}

local function GetConfigType(a1) -- Line: 85
    if a1 ~= "Katana" and a1 ~= "Great" then
        if a1 ~= "Light" and a1 ~= "Heave" then
            if a1 == "Hat" then
                return "Armor"
            end
            return a1
        end
        return "Armor"
    end
    return "Weapon"
end

function u0.init() -- Line: 101 -- upvalues: u234 (ref)
    u234 = Instance.new("Camera", workspace:WaitForChild("CAMERAS"))
    u234.Name = "EquipmentCamera"
    u234.CFrame = CFrame.lookAt(Vector3.new(1, 0.5, -4), (Vector3.new(0.5, 0, 0)))
end

function u0.start() -- Line: 108
    -- upvalues: Backpack_2 (val), u0 (val), TextButton (val), ScrollingFrame (val), EquipmentInfo (val), u232 (ref)
    -- upvalues: BackpackData (val), OreInfo (val), Helper_6 (val), RichToColor (val), ce (val), Equiped (val)
    -- upvalues: LocalPlayer (val), EquipmentModelUtils (val), Left (val), u235 (ref)
    Backpack_2.MouseButton1Down:Connect(function() -- Line: 109 -- upvalues: Backpack_2 (upval), u0 (upval)
        local New = Backpack_2:WaitForChild("New")
        New.Visible = false
        u0.open()
    end)
    TextButton.MouseButton1Down:Connect(function() -- Line: 113 -- upvalues: u0 (upval)
        u0.close()
    end)
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    local Button = ((EquipmentInfo:WaitForChild("xinxi")):WaitForChild("3")):WaitForChild("Button")
    ;(Button:WaitForChild("Equip")).MouseButton1Down:Connect(function() -- Line: 129 -- upvalues: u232 (upval), BackpackData (upval)
        if not u232 then
            return
        end
        local v1 = u232
        local Type = (BackpackData.GetItemData(v1)).Type
        BackpackData.EquipedItem(u232, Type)
    end)
    ;(Button:WaitForChild("Unequip")).MouseButton1Down:Connect(function() -- Line: 134 -- upvalues: u232 (upval), BackpackData (upval)
        if not u232 then
            return
        end
        local v1 = u232
        local Type = (BackpackData.GetItemData(v1)).Type
        BackpackData.UnEquipedItem(Type)
    end)
    ;(((EquipmentInfo:WaitForChild("xinxi")):WaitForChild("3")):WaitForChild("Lock")).MouseButton1Down:Connect(function() -- Line: 143 -- upvalues: BackpackData (upval), u232 (upval)
        BackpackData.SetLock(u232)
    end)
    ;(OreInfo:WaitForChild("Lock")).MouseButton1Down:Connect(function() -- Line: 147 -- upvalues: BackpackData (upval), u232 (upval)
        BackpackData.SetLock(u232)
    end)
    for k, n in (EquipmentInfo:WaitForChild("xinxi")):WaitForChild("2"):GetChildren() do
        if n:IsA("ImageLabel") then
            n.MouseEnter:Connect(function() -- Line: 158 -- upvalues: n (val), Helper_6 (upval), RichToColor (upval), u0 (upval)
                local Attribute = n:GetAttribute("SkillID")
                if Attribute then
                    local v1 = Helper_6.GetDescription(Attribute)
                    local v2 = Helper_6.GetSkillCD(Attribute)
                    local v3 = v1 .. ("CD:%*"):format((RichToColor(("%*s"):format(v2), (Color3.fromRGB(0, 255, 0)))))
                    u0.ShowAnyInfo(v3)
                end
            end)
            n.MouseLeave:Connect(function() -- Line: 167 -- upvalues: u0 (upval)
                u0.HideAnyInfo()
            end)
        end
    end
    for m, i5 in ce:GetChildren() do
        if i5:IsA("TextButton") then
            i5.MouseButton1Down:Connect(function() -- Line: 176 -- upvalues: i5 (val), u0 (upval)
                local New = i5:WaitForChild("New")
                New.Visible = false
                u0.OpenItemScroList(i5.Name)
            end)
        end
    end
    BackpackData.AddCallback(function() -- Line: 182
        -- upvalues: BackpackData (upval), u0 (upval), EquipmentInfo (upval), u232 (upval), OreInfo (upval)
        BackpackData.GetData()
        u0.CreateViewChar()
        u0.UpdateBackpack()
        u0.UpdateEquiped()
        if EquipmentInfo.Visible and u232 then
            u0.OpenEquipmentInfo(u232)
        end
        if OreInfo.Visible and u232 then
            u0.OpenOreInfo(u232)
        end
    end)
    for i6, i7 in Equiped:GetChildren() do
        if i7:IsA("TextButton") then
            local Name = i7.Name
            i7.MouseButton1Down:Connect(function() -- Line: 207 -- upvalues: BackpackData (upval), Name (val), u232 (upval), u0 (upval)
                local v1 = BackpackData.GetEquipUUIDByIndex(Name)
                if v1 then
                    if u232 ~= v1 then
                        u232 = v1
                        u0.OpenEquipmentInfo(v1)
                    else
                        u232 = nil
                        u0.CloseEquipmentInfo(v1)
                    end
                    u0.UpdateItemFramesShow()
                end
            end)
            if i7:FindFirstChild("Eyes") then
                local No = (i7:WaitForChild("Eyes")):WaitForChild("No")
                local Yes = (i7:WaitForChild("Eyes")):WaitForChild("Yes")
                local u197 = nil
                ;(No:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 230
                    -- upvalues: No (val), Yes (val), Name (val), LocalPlayer (upval), u197 (ref)
                    -- upvalues: EquipmentModelUtils (upval), u0 (upval)
                    No.Visible = false
                    Yes.Visible = true
                    workspace:SetAttribute("HideChar" .. Name, nil)
                    local Character = LocalPlayer.Character
                    if u197 then
                        u197:Disconnect()
                    end
                    EquipmentModelUtils.ShowClientArmor(LocalPlayer, Character, Name)
                    u0.CreateViewChar()
                end)
                ;(Yes:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 243
                    -- upvalues: No (val), Yes (val), Name (val), LocalPlayer (upval), u197 (ref)
                    -- upvalues: EquipmentModelUtils (upval), u0 (upval)
                    No.Visible = true
                    Yes.Visible = false
                    workspace:SetAttribute("HideChar" .. Name, true)
                    local Character = LocalPlayer.Character
                    if Character then
                        u197 = Character.ChildAdded:Connect(function(a1) -- Line: 249
                            -- upvalues: Name (upval), EquipmentModelUtils (upval), LocalPlayer (upval), Character (val)
                            -- upvalues: u0 (upval)
                            if a1.Name == Name then
                                EquipmentModelUtils.HideClientArmor(LocalPlayer, Character, Name)
                                u0.CreateViewChar()
                            end
                        end)
                        EquipmentModelUtils.HideClientArmor(LocalPlayer, Character, Name)
                        u0.CreateViewChar()
                    end
                end)
            end
        end
    end
    u0.update()
    u0.OpenItemScroList("Weapon")
    local TextLabel = ((Left:WaitForChild("Shang")):WaitForChild("Mingzi")):WaitForChild("TextLabel")
    TextLabel.Text = LocalPlayer.DisplayName
    u235 = true
    u0.CloseOreInfo()
    u0.CloseEquipmentInfo()
    u0.CloseMaterialInfo()
end

function u0.update() -- Line: 275 -- upvalues: u0 (val)
    u0.UpdateEquiped()
    u0.UpdateBackpack()
end

function u0.UpdateEquiped() -- Line: 280
    -- upvalues: Equiped (val), BackpackData (val), GameSetting (val), Helper (val), AnyHelper (val)
    local ID, ImageLabel, ImageLabel_2, ImageLabel_3, Mingzi, Name, Type, v1, v2, v3, v4, v5, v6, v7
    for i, j in Equiped:GetChildren() do
        if j:IsA("TextButton") then
            Name = j.Name
            v6 = BackpackData.GetEquipUUIDByIndex(Name)
            if v6 then
                v7 = BackpackData.GetItemData(v6)
                ID = v7.ID
                Type = v7.Type
                v2 = Helper.GetTextRarity(AnyHelper.GetRarity(
                    if Type == "Katana" then "Weapon" else if Type ~= "Great" then if Type == "Light" then "Armor" else if Type ~= "Heave" then if Type ~= "Hat" then Type else "Armor" else "Armor" else "Weapon",
                    ID
                ))
                v3 = AnyHelper.GetImage(v1, ID) or ""
                v4 = AnyHelper.GetDisName(v1, ID) or ""
                j:WaitForChild("ImageLabel").Image = v3
                ImageLabel_3 = j:WaitForChild("ImageLabel")
                ImageLabel_3.ImageTransparency = 0
                j:WaitForChild("Mingzi").Text = v4
                for k, n in j:WaitForChild("BG"):GetChildren() do
                    if n:IsA("Frame") then
                        v5 = n.Name == v2
                        n.Visible = v5
                    end
                end
            else
                ImageLabel = j:WaitForChild("ImageLabel")
                ImageLabel.Image = GameSetting.Icon["Default_" .. Name]
                ImageLabel_2 = j:WaitForChild("ImageLabel")
                ImageLabel_2.ImageTransparency = 0.7
                Mingzi = j:WaitForChild("Mingzi")
                Mingzi.Text = "Empty"
                for m, i5 in j:WaitForChild("BG"):GetChildren() do
                    if i5:IsA("Frame") then
                        v3 = i5.Name == "Common"
                        i5.Visible = v3
                    end
                end
            end
        end
    end
end

function u0.UpdateBackpack() -- Line: 329 -- upvalues: BackpackData (val), u231 (val), u0 (val)
    local v1 = BackpackData.GetData()
    for i, j in u231 do
        if not v1.have[i] then
            u0.DeleteItemFrame(i)
        end
    end
    for k, n in u231 do
        if v1.have[k] then
            u0.UpdateItemFrame(k)
        end
    end
    for m, i5 in v1.have do
        if not u231[m] then
            u0.CreateItemFrame(m, i5)
        end
    end
    local v2 = {}
    for i6, i7 in u231 do
        table.insert(v2, {
            Frame = i7.Frame,
            Price = i7.Price,
            Affix = i7.Affix,
            IsEquiped = i7.IsEquiped,
            RarityLevel = i7.RarityLevel,
        })
    end
    table.sort(v2, function(a1, a2) -- Line: 360
        if a1.Affix and a2.Affix then
            return a2.Affix < a1.Affix
        end
        if a1.Price and a2.Price then
            return a2.Price < a1.Price
        end
        if a1.RarityLevel and a2.RarityLevel then
            return a2.RarityLevel < a1.RarityLevel
        end
    end)
    for i8, i9 in v2 do
        if not i9.IsEquiped then
            i9.Frame.LayoutOrder = i8 + 1000
        else
            i9.Frame.LayoutOrder = i8
        end
    end
end

function u0.open() -- Line: 378 -- upvalues: UIController (val), Backpack (val), u0 (val)
    UIController.openScreen(Backpack.Name)
    u0.DestroyViewChar()
    u0.CreateViewChar()
end

function u0.close() -- Line: 384 -- upvalues: UIController (val), Backpack (val), u0 (val)
    UIController.closeScreen(Backpack.Name)
    u0.DestroyViewChar()
    u0.HideAnyInfo()
end

function u0.CreateItemFrame(a1, a2) -- Line: 391
    -- upvalues: BackpackData (val), u0 (val), ScrollingFrame (val), AnyHelper (val), u233 (ref), u232 (ref), u235 (ref)
    -- upvalues: ce (val), Backpack_2 (val), u231 (val)
    local v1, v2, v3
    if not a2 then
        a2 = BackpackData.GetItemData(a1)
    end
    if not a2 then
        return
    end
    v1, _, _, v2 = u0.CreateOneItemFrame(a1, a2)
    v1.Parent = ScrollingFrame
    local Type = a2.Type
    local ID = a2.ID
    local v4 = AnyHelper.GetSellPrice(
        if Type == "Katana" then "Weapon" else if Type ~= "Great" then if Type == "Light" then "Armor" else if Type ~= "Heave" then if Type ~= "Hat" then Type else "Armor" else "Armor" else "Weapon",
        ID
    )
    v1.Visible = Type == u233
    local Button = v1:WaitForChild("Button")
    local zhong = Button:WaitForChild("Frame"):WaitForChild("zhong")
    zhong.Visible = u232 == a1
    if u235 and ce:FindFirstChild(Type) then
        local New = (ce:FindFirstChild(Type)):WaitForChild("New")
        New.Visible = true
        local New_2 = Backpack_2:WaitForChild("New")
        New_2.Visible = true
    end
    Button.MouseButton1Down:Connect(function() -- Line: 420 -- upvalues: u232 (upval), a1 (val), Type (val), u0 (upval)
        if u232 ~= a1 then
            u232 = a1
            if Type == "Ore" then
                u0.OpenOreInfo(a1)
            elseif Type == "Weapon" or Type == "Armor" then
                u0.OpenEquipmentInfo(a1)
            elseif Type ~= "Hat" then
                u0.OpenMaterialInfo(a1)
            else
                u0.OpenEquipmentInfo(a1)
            end
        else
            u232 = nil
            if Type == "Ore" then
                u0.CloseOreInfo(a1)
            elseif Type == "Weapon" or Type == "Armor" then
                u0.CloseEquipmentInfo(a1)
            elseif Type ~= "Hat" then
                u0.CloseMaterialInfo()
            else
                u0.CloseEquipmentInfo(a1)
            end
        end
        u0.UpdateItemFramesShow()
    end)
    u231[a1] = {}
    u231[a1].Frame = v1
    u231[a1].BPType = v3
    u231[a1].Type = Type
    u231[a1].Price = v4
    u231[a1].RarityLevel = v2
    u0.UpdateItemFrame(a1, a2)
end

function u0.CreateOneItemFrame(a1, a2) -- Line: 453
    -- upvalues: BackpackData (val), AnyHelper (val), Helper (val), ScrollingFrame (val), AbbreviateNumber (val)
    -- upvalues: Helper_5 (val), Helper_6 (val), BalanceUtils (val), LocalPlayer (val)
    local v1, v2
    if not a1 then
        return nil
    end
    if not a2 then
        a2 = BackpackData.GetItemData(a1)
    end
    if not a2 then
        return nil
    end
    local Type = a2.Type
    local ID = a2.ID
    local v3 = a2.Level or 0
    local Lock = a2.Lock
    local v4 = AnyHelper.GetSellPrice(
        if Type == "Katana" then "Weapon" else if Type ~= "Great" then if Type == "Light" then "Armor" else if Type ~= "Heave" then if Type ~= "Hat" then Type else "Armor" else "Armor" else "Weapon",
        ID
    )
    local v5 = AnyHelper.GetImage(v2, ID) or ""
    local v6 = AnyHelper.GetDisName(v2, ID) or ""
    local v7 = a2.Rarity and Helper.GetTextRarity(a2.Rarity) or Helper.GetTextRarity(AnyHelper.GetRarity(v2, ID))
    local v8 = Helper.GetRarityLevel(v7)
    if not v7 then
        v7 = "Common"
    end
    local v9 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild(v7):Clone()
    local Button = v9:WaitForChild("Button")
    local Frame = Button:WaitForChild("Frame")
    v9.Visible = true
    v9.Name = a1
    if not v4 then
        local Price_2 = (Frame:WaitForChild("zi")):WaitForChild("Price")
        Price_2.Text = ""
    else
        local Price = (Frame:WaitForChild("zi")):WaitForChild("Price")
        Price.Text = "Price:" .. AbbreviateNumber((math.round(v4)))
    end
    local Lv = (Frame:WaitForChild("zi")):WaitForChild("Lv")
    Lv.Text = ("Enhance +%*"):format(v3)
    local Lv_2 = (Frame:WaitForChild("zi")):WaitForChild("Lv")
    Lv_2.Visible = v3 > 0
    local jineng = (Frame:WaitForChild("Bottom right")):WaitForChild("jineng")
    jineng.Visible = v2 == "Weapon"
    Frame:WaitForChild("ImageLabel").Image = v5
    local zhong = Frame:WaitForChild("zhong")
    zhong.Visible = false
    Button:WaitForChild("LockImage").Visible = Lock
    local EnchanceNum = a2.EnchanceNum
    local EnchanceList = a2.EnchanceList
    local Button_2 = (Frame:WaitForChild("Bottom right")):WaitForChild("Button")
    if not EnchanceNum then
        Button_2.Visible = false
    else
        local Bg_2, Icon, Name, v10, v11, v12
        Button_2.Visible = true
        v1 = a1
        for i, j in Button_2:GetChildren() do
            if j:IsA("TextButton") then
                Name = j.Name
                v10 = tonumber((Name:sub(Name:len(), (Name:len()))))
                v11 = v10 <= EnchanceNum
                j.Visible = v11
                if not EnchanceList[v10] then
                    Icon = ((j:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("Icon")
                    Icon.Image = ""
                else
                    v12 = Helper_5.GetImage(EnchanceList[v10].ID) or ""
                    Bg_2 = (j:WaitForChild("Bg")):WaitForChild("Bg")
                    Bg_2:WaitForChild("Icon").Image = v12
                end
            end
        end
    end
    local v13 = BackpackData.GetData()
    local v14 = nil
    local v15 = nil
    if v2 == "Weapon" then
        local ID_3, Level, v16, v17, v18
        local SkillList = a2.SkillList or {}
        local SkillNumber = a2.SkillNumber
        for k, n in (Frame:WaitForChild("Bottom right")):WaitForChild("jineng"):GetChildren() do
            if n:IsA("Frame") then
                v16 = SkillList[tonumber(n.Name)]
                if v16 then
                    n.Visible = true
                    ID_3 = v16.ID
                    v17 = Helper_6.GetSkillLevelImage((Helper_6.GetSkillLevel(ID_3)))
                    v18 = Helper_6.GetImage(ID_3) or ""
                    n:WaitForChild("ImageLabel").Image = v18
                    Level = n:WaitForChild("Level")
                    Level:WaitForChild("ImageLabel").Image = v17
                else
                    n.Visible = false
                end
            end
        end
        v14 = BalanceUtils.GetWeaponTrainValue(LocalPlayer, a2, v13)
        local ATK = (Frame:WaitForChild("zi")):WaitForChild("ATK")
        ATK.Text = "Power +" .. AbbreviateNumber(v14)
        v15 = BackpackData.IsEquipedUUID(v1)
        Frame:WaitForChild("Equip").Visible = v15
    elseif v2 == "Armor" then
        local v19 = ""
        if Type == "Hat" then
            v19 = v19 .. "Power "
        elseif Type == "Armor" then
            v19 = v19 .. "Def "
        end
        v19 = v19 .. "+"
        v14 = BalanceUtils.GetArmorValue(LocalPlayer, a2, v13)
        v15 = BackpackData.IsEquipedUUID(v1)
        v19 = v19 .. ("%*%%"):format((math.round(v14 * 100)))
        local zi_6 = Frame:WaitForChild("zi")
        zi_6:WaitForChild("ATK").Text = v19
        Frame:WaitForChild("Equip").Visible = v15
    elseif v2 ~= "Ore" then
        local Number_2 = a2.Number
        local ATK_3 = (Frame:WaitForChild("zi")):WaitForChild("ATK")
        ATK_3.Text = ("%*"):format(v6)
        local Quantity_3 = Frame:WaitForChild("Quantity")
        Quantity_3.Visible = true
        local TextLabel_2 = (Frame:WaitForChild("Quantity")):WaitForChild("TextLabel")
        TextLabel_2.Text = ("x%*"):format(Number_2)
    else
        local Number = a2.Number
        local ATK_2 = (Frame:WaitForChild("zi")):WaitForChild("ATK")
        ATK_2.Text = ("%*"):format(v6)
        local Quantity = Frame:WaitForChild("Quantity")
        Quantity.Visible = true
        local TextLabel = (Frame:WaitForChild("Quantity")):WaitForChild("TextLabel")
        TextLabel.Text = ("x%*"):format(Number)
    end
    return v9, v14, v15, v8
end

function u0.DeleteItemFrame(a1) -- Line: 606 -- upvalues: u231 (val)
    u231[a1].Frame:Destroy()
    u231[a1] = nil
end

function u0.UpdateItemFrame(a1, a2) -- Line: 611
    -- upvalues: BackpackData (val), u231 (val), Helper_5 (val), Helper_6 (val), BalanceUtils (val), LocalPlayer (val)
    -- upvalues: AbbreviateNumber (val)
    if not a2 then
        a2 = BackpackData.GetItemData(a1)
    end
    if not a2 then
        return
    end
    local Button = u231[a1].Frame:WaitForChild("Button")
    local Frame = Button:WaitForChild("Frame")
    local ID = a2.ID
    local Type = a2.Type
    local Lock = a2.Lock
    local v1 = false
    local v2 = if Type == "Katana" then "Weapon" else if Type ~= "Great" then if Type == "Light" then "Armor" else if Type ~= "Heave" then if Type ~= "Hat" then Type else "Armor" else "Armor" else "Weapon"
    Button:WaitForChild("LockImage").Visible = Lock
    local EnchanceNum = a2.EnchanceNum
    local EnchanceList = a2.EnchanceList
    local Button_2 = (Frame:WaitForChild("Bottom right")):WaitForChild("Button")
    if EnchanceNum then
        local Bg_2, Icon, Name, v3, v4
        for i, j in Button_2:GetChildren() do
            if j:IsA("TextButton") then
                Name = j.Name
                v3 = tonumber((Name:sub(Name:len(), (Name:len()))))
                if not EnchanceList[v3] then
                    Icon = ((j:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("Icon")
                    Icon.Image = ""
                else
                    v4 = Helper_5.GetImage(EnchanceList[v3].ID) or ""
                    Bg_2 = (j:WaitForChild("Bg")):WaitForChild("Bg")
                    Bg_2:WaitForChild("Icon").Image = v4
                end
            end
        end
    end
    local v5 = nil
    if v2 == "Weapon" then
        local ID_3, Level, v6, v7, v8
        v1 = BackpackData.IsEquipedUUID(a1)
        Frame:WaitForChild("Equip").Visible = v1
        local SkillList = a2.SkillList or {}
        local SkillNumber = a2.SkillNumber
        for k, n in (Frame:WaitForChild("Bottom right")):WaitForChild("jineng"):GetChildren() do
            if n:IsA("Frame") then
                v6 = SkillList[tonumber(n.Name)]
                if v6 then
                    n.Visible = true
                    ID_3 = v6.ID
                    v7 = Helper_6.GetSkillLevelImage((Helper_6.GetSkillLevel(ID_3)))
                    v8 = Helper_6.GetImage(ID_3) or ""
                    n:WaitForChild("ImageLabel").Image = v8
                    Level = n:WaitForChild("Level")
                    Level:WaitForChild("ImageLabel").Image = v7
                else
                    n.Visible = false
                end
            end
        end
        v5 = BalanceUtils.GetWeaponTrainValue(LocalPlayer, a2, (BackpackData.GetData()))
        local ATK = (Frame:WaitForChild("zi")):WaitForChild("ATK")
        ATK.Text = "Power +" .. AbbreviateNumber(v5)
        local v9 = a2.Level or 0
        local Lv = (Frame:WaitForChild("zi")):WaitForChild("Lv")
        Lv.Text = ("Enhance +%*"):format(v9)
        local Lv_2 = (Frame:WaitForChild("zi")):WaitForChild("Lv")
        Lv_2.Visible = v9 > 0
    elseif v2 == "Armor" then
        v1 = BackpackData.IsEquipedUUID(a1)
        Frame:WaitForChild("Equip").Visible = v1
        v5 = BalanceUtils.GetArmorValue(LocalPlayer, a2, (BackpackData.GetData()))
        if Type ~= "Hat" then
            local ATK_3 = (Frame:WaitForChild("zi")):WaitForChild("ATK")
            ATK_3.Text = ("Def +%*%%"):format((AbbreviateNumber((math.round(v5 * 100)))))
        else
            local ATK_2 = (Frame:WaitForChild("zi")):WaitForChild("ATK")
            ATK_2.Text = ("Power +%*%%"):format((AbbreviateNumber((math.round(v5 * 100)))))
        end
        local v10 = a2.Level or 0
        local Lv_3 = (Frame:WaitForChild("zi")):WaitForChild("Lv")
        Lv_3.Text = ("Enhance +%*"):format(v10)
        local Lv_4 = (Frame:WaitForChild("zi")):WaitForChild("Lv")
        Lv_4.Visible = v10 > 0
    elseif v2 ~= "Ore" then
        local Number_2 = a2.Number
        local Equip_2 = Frame:WaitForChild("Equip")
        Equip_2.Visible = false
        local TextLabel_2 = (Frame:WaitForChild("Quantity")):WaitForChild("TextLabel")
        TextLabel_2.Text = ("x%*"):format((AbbreviateNumber(Number_2)))
    else
        local Number = a2.Number
        local Equip = Frame:WaitForChild("Equip")
        Equip.Visible = false
        local TextLabel = (Frame:WaitForChild("Quantity")):WaitForChild("TextLabel")
        TextLabel.Text = ("x%*"):format((AbbreviateNumber(Number)))
    end
    u231[a1].IsEquiped = v1
    u231[a1].Affix = v5
end

function u0.UpdateItemFramesShow() -- Line: 728 -- upvalues: ScrollingFrame (val), u232 (ref)
    local Frame, Name, zhong
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            Frame = (j:WaitForChild("Button")):WaitForChild("Frame")
            Name = j.Name
            zhong = Frame:WaitForChild("zhong")
            zhong.Visible = Name == u232
        end
    end
end

function u0.OpenItemScroList(a1) -- Line: 740 -- upvalues: u233 (ref), ce (val), u231 (val), u262 (val)
    local zhong
    local v1 = a1
    for i, j in ce:GetChildren() do
        if j:IsA("TextButton") then
            zhong = j:WaitForChild("zhong")
            zhong.Visible = j.Name == a1
        end
    end
    local v2 = nil
    local v3 = nil
    for k, n in u231, v2, v3 do
        if v1 ~= "Material" then
            n.Frame.Visible = n.Type == v1
        else
            n.Frame.Visible = not table.find(u262, n.Type)
        end
    end
end

function u0.CreateViewChar() -- Line: 760
    -- upvalues: LocalPlayer (val), ViewportFrame (val), u234 (ref), BackpackData (val), EquipmentModelUtils (val)
    -- upvalues: Helper_2 (val), ReplicatedStorage (val)
    local Character = LocalPlayer.Character
    local ViewportFrame_2 = ViewportFrame:WaitForChild("ViewportFrame")
    ViewportFrame_2.CurrentCamera = u234
    local COPYCHAR = (ViewportFrame_2:WaitForChild("WorldModel")):FindFirstChild("COPYCHAR")
    if not COPYCHAR then
        Character.Archivable = true
        COPYCHAR = Character:Clone()
        Character.Archivable = false
        COPYCHAR.Parent = ViewportFrame_2:WaitForChild("WorldModel")
        COPYCHAR.PrimaryPart.Anchored = true
        COPYCHAR:PivotTo((CFrame.new(0, 0, 2)))
        COPYCHAR:ScaleTo(1)
        COPYCHAR.Name = "COPYCHAR"
    end
    local Weapon = BackpackData.GetItemDataByIndex("Weapon")
    EquipmentModelUtils.CreateWeaponModel(COPYCHAR, Weapon.ID, Weapon)
    if workspace:GetAttribute("HideCharHat") then
        EquipmentModelUtils.DestroyArmorModel(COPYCHAR, "Hat")
    else
        local Hat = BackpackData.GetItemDataByIndex("Hat")
        if Hat then
            EquipmentModelUtils.CreateArmorModel(COPYCHAR, Hat.ID, "Hat", Hat)
        else
            EquipmentModelUtils.DestroyArmorModel(COPYCHAR, "Hat")
        end
    end
    if workspace:GetAttribute("HideCharArmor") then
        EquipmentModelUtils.DestroyArmorModel(COPYCHAR, "Armor")
    else
        local Armor = BackpackData.GetItemDataByIndex("Armor")
        if Armor then
            EquipmentModelUtils.CreateArmorModel(COPYCHAR, Armor.ID, "Armor", Armor)
        else
            EquipmentModelUtils.DestroyArmorModel(COPYCHAR, "Armor")
        end
    end
    local Animator = (COPYCHAR:WaitForChild("Humanoid")):WaitForChild("Animator")
    for i, j in (Animator:GetPlayingAnimationTracks()) do
        j:Stop()
        j:Destroy()
    end
    local v1 = Helper_2.GetSmallType((BackpackData.GetEquipedWeaponID()))
    local v2 = ReplicatedStorage.Assets.Animation.Player_State:WaitForChild((("Idle_%*"):format((v1:sub(1, 1)))))
    local v3 = ReplicatedStorage.Assets.Animation.Player_Action:WaitForChild((("%*_ATK_1"):format((v1:sub(1, 1)))))
    local v4 = Animator:LoadAnimation(v2)
    local v5 = Animator:LoadAnimation(v3)
    v4.Priority = Enum.AnimationPriority.Action
    v5.Priority = Enum.AnimationPriority.Action2
    v4.Looped = true
    v5.Looped = false
    v5:Play()
    v4:Play()
end

function u0.DestroyViewChar() -- Line: 831 -- upvalues: ViewportFrame (val)
    local WorldModel = (ViewportFrame:WaitForChild("ViewportFrame")):WaitForChild("WorldModel")
    if WorldModel:FindFirstChildOfClass("Model") then
        WorldModel:FindFirstChildOfClass("Model"):Destroy()
    end
end

function u0.OpenEquipmentInfo(a1) -- Line: 839
    -- upvalues: BackpackData (val), u0 (val), OreInfo (val), MaterialInfo (val), EquipmentInfo (val), AnyHelper (val)
    -- upvalues: Helper (val), AbbreviateNumber (val), Helper_7 (val), BalanceUtils (val), LocalPlayer (val)
    -- upvalues: Helper_2 (val), RichToColor (val), GameSetting (val), Helper_6 (val), Helper_3 (val), Helper_5 (val)
    if a1 and BackpackData.GetData().have[a1] then
        local v1, v2, v3, v4, v5, v6, v7
        if OreInfo.Visible then
            u0.CloseOreInfo()
        end
        if MaterialInfo.Visible then
            u0.CloseMaterialInfo()
        end
        EquipmentInfo.Visible = true
        local xinxi = EquipmentInfo:WaitForChild("xinxi")
        local tx = (xinxi:WaitForChild("1")):WaitForChild("tx")
        local BG = (xinxi:WaitForChild("1")):WaitForChild("BG")
        local v8 = BackpackData.GetItemData(a1)
        local ID = v8.ID
        local Type = v8.Type
        local v9 = v8.Level or 0
        local v10 = AnyHelper.GetSellPrice(
            if Type == "Katana" then "Weapon" else if Type ~= "Great" then if Type == "Light" then "Armor" else if Type ~= "Heave" then if Type ~= "Hat" then Type else "Armor" else "Armor" else "Weapon",
            ID
        )
        local v11 = AnyHelper.GetImage(v7, ID) or ""
        local v12 = Helper.GetTextRarity(AnyHelper.GetRarity(v7, ID))
        local v13 = AnyHelper.GetDisName(v7, ID) or ""
        local v14 = a1
        for i, j in BG:WaitForChild("BG"):GetChildren() do
            if j:IsA("Frame") then
                v3 = j.Name == v12
                j.Visible = v3
            end
        end
        local Info = BG:WaitForChild("Info")
        Info:WaitForChild("ImageLabel").Image = v11
        local Name = tx:WaitForChild("Name")
        Name:WaitForChild("TextLabel").Text = v13
        local Rarity = tx:WaitForChild("Rarity")
        Rarity:WaitForChild("TextLabel").Text = v12
        local TextLabel = (tx:WaitForChild("Level")):WaitForChild("TextLabel")
        TextLabel.Text = ("Enhance +%*"):format(v9)
        if not v10 then
            v1 = (tx:WaitForChild("Price")):WaitForChild("2")
            v1.Text = "Priceless"
        else
            v1 = (tx:WaitForChild("Price")):WaitForChild("2")
            v1.Text = AbbreviateNumber(v10)
        end
        for k, n in (tx:WaitForChild("Rarity")):WaitForChild("TextLabel"):GetChildren() do
            if n:IsA("UIGradient") then
                v3 = n.Name == v12
                n.Enabled = v3
            end
        end
        Helper_7.GetBoost(v9)
        local v15 = BackpackData.GetData()
        local v16 = ""
        if v7 == "Weapon" then
            local ID_2, Level_2, v17, v18
            v2 = BalanceUtils.GetWeaponTrainValue(LocalPlayer, v8, v15)
            if Helper_2.CheckIsBestPercent(ID) then
                v3 = Helper_2.GetMainAffix(ID)
                v4 = Helper_2.GetMaxTrain(ID)
                v5 = Helper_7.GetBoost(v9) or 0
                v3 = v3 * (1 + v5)
                v3 = math.round(v3 * 100) / 100
                if not v4 then
                    v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. " Power as your best weapon. No limited!"
                else
                    v4 = v4 * (1 + v5)
                    v4 = math.round(v4)
                    v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. (" Power as your best weapon. Max base Power: %*"):format((AbbreviateNumber(v4)))
                end
            end
            v3 = (tx:WaitForChild("Main")):WaitForChild("2")
            v3.Text = ("+%*"):format((AbbreviateNumber(v2)))
            local ImageLabel = (tx:WaitForChild("Main")):WaitForChild("ImageLabel")
            ImageLabel.Image = GameSetting.Icon.power
            v3 = xinxi:WaitForChild("2")
            v3.Visible = true
            local Line1 = EquipmentInfo:WaitForChild("Line1")
            Line1.Visible = true
            local Line2 = EquipmentInfo:WaitForChild("Line2")
            Line2.Visible = true
            for m, i5 in xinxi:WaitForChild("2"):GetChildren() do
                if i5:IsA("ImageLabel") then
                    v17 = v8.SkillList[(tonumber(i5.Name))]
                    i5.Visible = v17
                    if v17 then
                        ID_2 = v17.ID
                        v6 = Helper_6.GetImage(ID_2) or ""
                        v18 = Helper_6.GetSkillLevelImage((Helper_6.GetSkillLevel(ID_2)))
                        i5:WaitForChild("ImageLabel").Image = v6
                        Level_2 = i5:WaitForChild("Level")
                        Level_2:WaitForChild("ImageLabel").Image = v18
                        i5:SetAttribute("SkillID", ID_2)
                    end
                end
            end
        elseif v7 == "Armor" then
            v2 = BalanceUtils.GetArmorValue(LocalPlayer, v8, v15)
            local v19 = (tx:WaitForChild("Main")):WaitForChild("2")
            v19.Text = ("+%*%%"):format((math.round(v2 * 100)))
            if Type ~= "Hat" then
                local ImageLabel_3 = (tx:WaitForChild("Main")):WaitForChild("ImageLabel")
                ImageLabel_3.Image = GameSetting.Icon.Defence or ""
            else
                local ImageLabel_2 = (tx:WaitForChild("Main")):WaitForChild("ImageLabel")
                ImageLabel_2.Image = GameSetting.Icon.power
            end
            v19 = xinxi:WaitForChild("2")
            v19.Visible = false
            local Line1_2 = EquipmentInfo:WaitForChild("Line1")
            Line1_2.Visible = false
            local Line2_2 = EquipmentInfo:WaitForChild("Line2")
            Line2_2.Visible = false
            if Helper_3.CheckIsBestPercent(ID) then
                v3 = Helper_3.GetMainAffix(ID)
                v4 = Helper_3.GetMaxAttrNum(ID)
                v5 = Helper_7.GetBoost(v9) or 0
                v3 = v3 * (1 + v5)
                v3 = math.round(v3 * 100) / 100
                if Type ~= "Hat" then
                    if Type == "Armor" then
                        if not v4 then
                            v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. " Defence as your best armor. No limited!"
                        else
                            v4 = v4 * (1 + v5)
                            v4 = math.round(v4 * 100) / 100
                            v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. (" Defence as your best armor. Max base Defence: +%*%%"):format((AbbreviateNumber((math.round(v4 * 100)))))
                        end
                    end
                elseif not v4 then
                    v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. " Power as your best helmet. No limited!"
                else
                    v4 = v4 * (1 + v5)
                    v4 = math.round(v4 * 100) / 100
                    v16 = (RichToColor(("%*%%"):format((math.round(v3 * 100))), Color3.fromRGB(17, 255, 92))) .. (" Power as your best helmet. Max base Power: +%*%%"):format((AbbreviateNumber((math.round(v4 * 100)))))
                end
            end
        end
        EquipmentInfo:WaitForChild("TextLabel").Text = v16
        local Equip = ((xinxi:WaitForChild("3")):WaitForChild("Button")):WaitForChild("Equip")
        Equip.Visible = not BackpackData.IsEquipedUUID(v14)
        local Unequip = ((xinxi:WaitForChild("3")):WaitForChild("Button")):WaitForChild("Unequip")
        Unequip.Visible = BackpackData.IsEquipedUUID(v14)
        local EnchanceNum = v8.EnchanceNum
        local EnchanceList = v8.EnchanceList
        local Button_3 = (BG:WaitForChild("Info")):WaitForChild("Button")
        if not EnchanceNum then
            Button_3.Visible = false
        else
            local Bg_2, Icon, Name_3, v20, v21
            Button_3.Visible = true
            for i6, i7 in Button_3:GetChildren() do
                if i7:IsA("TextButton") then
                    Name_3 = i7.Name
                    v20 = tonumber((Name_3:sub(Name_3:len(), (Name_3:len()))))
                    v6 = v20 <= EnchanceNum
                    i7.Visible = v6
                    if not EnchanceList[v20] then
                        Icon = ((i7:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("Icon")
                        Icon.Image = ""
                    else
                        v21 = Helper_5.GetImage(EnchanceList[v20].ID) or ""
                        Bg_2 = (i7:WaitForChild("Bg")):WaitForChild("Bg")
                        Bg_2:WaitForChild("Icon").Image = v21
                    end
                end
            end
        end
        v4 = BackpackData.IsLocked(v14)
        local Lock = ((EquipmentInfo:WaitForChild("xinxi")):WaitForChild("3")):WaitForChild("Lock")
        local Frame = Lock:WaitForChild("Frame")
        Frame:WaitForChild("LockImage").Visible = v4
        local UnLockImage = (Lock:WaitForChild("Frame")):WaitForChild("UnLockImage")
        UnLockImage.Visible = not v4
        return
    end
    u0.CloseEquipmentInfo()
end

function u0.CloseEquipmentInfo() -- Line: 1055 -- upvalues: EquipmentInfo (val), u0 (val)
    EquipmentInfo.Visible = false
    u0.HideAnyInfo()
end

function u0.OpenOreInfo(a1) -- Line: 1061
    -- upvalues: BackpackData (val), u0 (val), EquipmentInfo (val), MaterialInfo (val), OreInfo (val), AnyHelper (val)
    -- upvalues: Helper (val), Helper_4 (val), AbbreviateNumber (val)
    if a1 and BackpackData.GetData().have[a1] then
        local v1
        if EquipmentInfo.Visible then
            u0.CloseEquipmentInfo()
        end
        if MaterialInfo.Visible then
            u0.CloseMaterialInfo()
        end
        OreInfo.Visible = true
        local xinxi = OreInfo:WaitForChild("xinxi")
        local v2 = xinxi:WaitForChild("1")
        local v3 = BackpackData.GetItemData(a1)
        local ID = v3.ID
        local Type = v3.Type
        local Number = v3.Number
        local v4 = AnyHelper.GetSellPrice(Type, ID)
        local v5 = AnyHelper.GetImage(Type, ID) or ""
        local v6 = Helper.GetTextRarity(AnyHelper.GetRarity(Type, ID))
        local v7 = AnyHelper.GetDisName(Type, ID)
        v7 = Helper_4.GetPower(ID)
        for i, j in v2:WaitForChild("BG"):GetChildren() do
            if j:IsA("Frame") then
                v1 = j.Name == v6
                j.Visible = v1
            end
        end
        local Info = v2:WaitForChild("Info")
        Info:WaitForChild("Icon").Image = v5
        local TextLabel = (v2:WaitForChild("Info")):WaitForChild("TextLabel")
        TextLabel.Text = ("x%*"):format((AbbreviateNumber(Number)))
        local Power = (xinxi:WaitForChild("2")):WaitForChild("Power")
        Power.Text = ("Multi: %*"):format((math.round(v7 * 10)) / 10)
        if not v4 then
            local Price_2 = (xinxi:WaitForChild("2")):WaitForChild("Price")
            Price_2.Text = "Priceless"
        else
            local Price = (xinxi:WaitForChild("2")):WaitForChild("Price")
            Price.Text = ("Price: %*"):format((AbbreviateNumber((math.round(v4)))))
        end
        local v8 = BackpackData.IsLocked(a1)
        local Lock = OreInfo:WaitForChild("Lock")
        local Frame = Lock:WaitForChild("Frame")
        Frame:WaitForChild("LockImage").Visible = v8
        local UnLockImage = (Lock:WaitForChild("Frame")):WaitForChild("UnLockImage")
        UnLockImage.Visible = not v8
        return
    end
    u0.CloseOreInfo()
end

function u0.CloseOreInfo() -- Line: 1123 -- upvalues: OreInfo (val)
    OreInfo.Visible = false
end

function u0.OpenMaterialInfo(a1) -- Line: 1127
    -- upvalues: BackpackData (val), u0 (val), EquipmentInfo (val), OreInfo (val), MaterialInfo (val), AnyHelper (val)
    -- upvalues: Helper (val), AbbreviateNumber (val)
    if a1 and BackpackData.GetData().have[a1] then
        local v1
        if EquipmentInfo.Visible then
            u0.CloseEquipmentInfo()
        end
        if OreInfo.Visible then
            u0.CloseOreInfo()
        end
        MaterialInfo.Visible = true
        local xinxi = MaterialInfo:WaitForChild("xinxi")
        local v2 = xinxi:WaitForChild("1")
        local v3 = BackpackData.GetItemData(a1)
        local ID = v3.ID
        local Type = v3.Type
        local Number = v3.Number
        local v4 = AnyHelper.GetImage(Type, ID) or ""
        local v5 = Helper.GetTextRarity(AnyHelper.GetRarity(Type, ID))
        local v6 = AnyHelper.GetDisName(Type, ID) or ""
        local v7 = AnyHelper.GetDescription(Type, ID) or ""
        for i, j in v2:WaitForChild("BG"):GetChildren() do
            if j:IsA("Frame") then
                v1 = j.Name == v5
                j.Visible = v1
            end
        end
        local Info = v2:WaitForChild("Info")
        Info:WaitForChild("Icon").Image = v4
        local Number_2 = (v2:WaitForChild("Info")):WaitForChild("Number")
        Number_2.Text = ("x%*"):format((AbbreviateNumber(Number)))
        local Info_3 = v2:WaitForChild("Info")
        Info_3:WaitForChild("Name").Text = v6
        local v8 = xinxi:WaitForChild("2")
        v8:WaitForChild("2").Text = v7
        return
    end
    u0.CloseMaterialInfo()
end

function u0.CloseMaterialInfo() -- Line: 1169 -- upvalues: MaterialInfo (val)
    MaterialInfo.Visible = false
end

function u0.ShowAnyInfo(a1) -- Line: 1173 -- upvalues: AnyInfo (val)
    AnyInfo.Visible = true
    local xinxi = AnyInfo:WaitForChild("xinxi")
    xinxi:WaitForChild("2").Text = a1
end

function u0.HideAnyInfo(a1) -- Line: 1178 -- upvalues: AnyInfo (val)
    AnyInfo.Visible = false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.BuffGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.BuffGUI
-- Decompile time: 7.18 ms

local u0 = {}
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("MarketplaceService")
local SocialService = game:GetService("SocialService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local Boosts = LocalPlayer.PlayerGui:WaitForChild("Hud"):WaitForChild("Boosts")
require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
require(ReplicatedStorage.Utils.AbbNumber)
local TimeFormatUntil = require(ReplicatedStorage.Utils.TimeFormatUntil)
require(ReplicatedStorage.LocalData.PemData)
require(ReplicatedStorage.LocalData.StatsData)
local BuffData = require(ReplicatedStorage.LocalData.BuffData)
local OnlineData = require(ReplicatedStorage.LocalData.OnlineData)
require(ReplicatedStorage.Config.Monetization)
local Helper = require(ReplicatedStorage.Config.Online.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Buff.Helper)
require(ReplicatedStorage.GuiUtils.Message)
local Timer = require(ReplicatedStorage.Packages.Timer)
local BoostTip = (LocalPlayer.PlayerGui:WaitForChild("Info")):WaitForChild("BoostTip")
local Online = Boosts:WaitForChild("Online")
local Friend = Boosts:WaitForChild("Friend")
local u111 = Timer.new(1)

function u0.init() end

function u0.start() -- Line: 44
    -- upvalues: Boosts (val), Online (val), BoostTip (val), OnlineData (val), Helper (val), Friend (val)
    -- upvalues: LocalPlayer (val), SocialService (val), u0 (val), Helper_2 (val), u111 (val), BuffData (val)
    -- upvalues: TimeFormatUntil (val)
    for i, j in Boosts:GetChildren() do end
    Online.Visible = false
    Online.MouseEnter:Connect(function() -- Line: 51 -- upvalues: BoostTip (upval), OnlineData (upval), Helper (upval)
        BoostTip.Visible = true
        local v1 = OnlineData.GetRealOnlineTimes() or 0
        local v2 = Helper.GetBoostByTime(v1)
        BoostTip.Text = ("Online Power Boost +%*%%"):format((math.floor(v2 * 100)))
    end)
    Online.MouseLeave:Connect(function() -- Line: 57 -- upvalues: BoostTip (upval)
        BoostTip.Visible = false
    end)
    Friend.MouseEnter:Connect(function() -- Line: 61 -- upvalues: BoostTip (upval), LocalPlayer (upval)
        BoostTip.Visible = true
        local v1 = LocalPlayer:GetAttribute("FriendNumber") or 0
        BoostTip.Text = ("Friend Power Boost +%*%%"):format((math.floor(v1 * 10)))
    end)
    Friend.MouseLeave:Connect(function() -- Line: 66 -- upvalues: BoostTip (upval)
        BoostTip.Visible = false
    end)
    ;(Friend:WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 69 -- upvalues: SocialService (upval), LocalPlayer (upval)
        SocialService:PromptGameInvite(LocalPlayer)
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("FriendNumber")):Connect(function() -- Line: 72 -- upvalues: u0 (upval)
        u0.updateFriend()
    end)
    for k, n in Boosts:GetChildren() do
        if n.ClassName == "Frame" then
            local Name = n.Name
            if Helper_2.CheckID(Name) then
                n.MouseEnter:Connect(function(a1, a2) -- Line: 83
                    -- upvalues: Helper_2 (upval), Name (val), n (val), BoostTip (upval)
                    local Text = Helper_2.GetDesc(Name)
                    if Text == nil then
                        Text = n:WaitForChild("Time").Text
                    end
                    if Text ~= nil then
                        BoostTip.Visible = true
                        BoostTip.Text = Text
                    end
                end)
                n.MouseLeave:Connect(function(a1, a2) -- Line: 93 -- upvalues: BoostTip (upval) -- types: a1: number, a2: number
                    BoostTip.Visible = false
                end)
            end
        end
    end
    u111.Tick:Connect(function() -- Line: 99
        -- upvalues: Boosts (upval), Helper_2 (upval), BuffData (upval), TimeFormatUntil (upval), OnlineData (upval)
        -- upvalues: Online (upval), Helper (upval)
        local Name, v1
        for i, j in Boosts:GetChildren() do
            if j.ClassName == "Frame" then
                Name = j.Name
                if Helper_2.CheckID(Name) then
                    if BuffData.IsHaveBuff(Name) then
                        v1 = BuffData.GetBuffLastTime(Name)
                        if v1 > 0 then
                            if not (v1 >= 3600) then
                                j.Time.Text = TimeFormatUntil.MMSS(v1)
                            else
                                j.Time.Text = TimeFormatUntil.HHMMSS(v1)
                            end
                            if not j.Visible then
                                j.Visible = true
                            end
                        elseif j.Visible then
                            j.Visible = false
                        end
                    elseif j.Visible then
                        j.Visible = false
                    end
                end
            end
        end
        local v2 = OnlineData.GetRealOnlineTimes()
        if v2 % 60 == 0 then
            if 1 <= v2 / 60 then
                if not Online.Visible then
                    Online.Visible = true
                end
                local v3 = Helper.GetBoostByTime(v2)
                local Time = Online:WaitForChild("Time")
                Time.Text = ("+%*%%"):format((math.round(v3 * 100)))
                return
            end
            if Online.Visible then
                Online.Visible = false
            end
        end
    end)
    u111:StartNow()
    u0.updateFriend()
end

function u0.updateFriend() -- Line: 150 -- upvalues: LocalPlayer (val), Friend (val)
    local Time = Friend:WaitForChild("Time")
    Time.Text = ("+%*%%"):format((LocalPlayer:GetAttribute("FriendNumber") or 0) * 10)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ClassGUI
-- Took 0.03s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ClassGUI
-- Decompile time: 33.07 ms

local u0 = {}
game:GetService("RunService")
game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local ScreenMain = LocalPlayer.PlayerGui:WaitForChild("ScreenMain")
local UIVFX = LocalPlayer.PlayerGui:WaitForChild("UIVFX")
local Info_2 = LocalPlayer.PlayerGui:WaitForChild("Info")
local UIController = require(ReplicatedStorage.Utils.UIController)
local LocalPlayerUtils = require(ReplicatedStorage.Utils.LocalPlayerUtils)
local CameraUtils = require(ReplicatedStorage.Utils.CameraUtils)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local ClassUtils = require(ReplicatedStorage.Utils.ClassUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local Race = Hud:WaitForChild("Race")
local TextButton = (Race:WaitForChild("Frame")):WaitForChild("TextButton")
local Helper_2 = require(ReplicatedStorage.Config.Class.Helper)
local ClassData = require(ReplicatedStorage.LocalData.ClassData)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local MarketUtils = require(ReplicatedStorage.Utils.MarketUtils)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local ClassMap = (workspace:WaitForChild("WorldModel")):WaitForChild("ClassMap")
local Class = ScreenMain:WaitForChild("Class")
local Left = Class:WaitForChild("Left")
local Right = Class:WaitForChild("Right")
local Bottom = Class:WaitForChild("Bottom")
local Top = Class:WaitForChild("Top")
local Info = Class:WaitForChild("Info")
local ScrollingFrame = Left:WaitForChild("ScrollingFrame")
local Slot = (Right:WaitForChild("Info")):WaitForChild("Slot")
local Infos = (Right:WaitForChild("Info")):WaitForChild("Infos")
local Description = (Right:WaitForChild("Info")):WaitForChild("Description")
local Reroll = Bottom:WaitForChild("Reroll")
local ClassRollTips = Info_2:WaitForChild("ClassRollTips")
local u196 = CommunicationUtils.TryGetRemoteEvent("Class", "ShowLuckResultRE")
local CurrentCamera = workspace.CurrentCamera
local u199 = nil
local u200 = false

function u0.init() end

function u0.start() -- Line: 71
    -- upvalues: u0 (val), TextButton (val), Right (val), ClassData (val), u199 (ref), u196 (val), LocalPlayer (val)
    -- upvalues: Race (val), Info (val), u200 (ref), MarketUtils (val)
    local Val, Val_2
    u0.StartLeft()
    u0.StartRight()
    u0.StartBottom()
    u0.StartTop()
    u0.StartRig()
    u0.SelectIndexFrame()
    TextButton.MouseButton1Down:Connect(function() -- Line: 80 -- upvalues: u0 (upval)
        u0.open()
    end)
    ;(Right:WaitForChild("Close")).MouseButton1Down:Connect(function() -- Line: 83 -- upvalues: u0 (upval)
        u0.close()
    end)
    u0.update()
    ClassData.AddCallback(function() -- Line: 88 -- upvalues: u199 (upval), ClassData (upval), u0 (upval)
        u199 = ClassData.GetEquipedIndex()
        u0.update()
        ClassData.GetEquipedClass()
        u0.SelectIndexFrame()
    end)
    u196.OnClientEvent:Connect(function(a1) -- Line: 95 -- upvalues: u0 (upval)
        u0.LuckAnim(a1)
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("IntoFight")):Connect(function() -- Line: 99 -- upvalues: LocalPlayer (upval), Race (upval)
        if LocalPlayer:GetAttribute("IntoFight") then
            Race.Visible = false
            return
        end
        Race.Visible = true
    end)
    for i, j in Info:WaitForChild("xinxi"):GetChildren() do
        if j:IsA("TextButton") then
            local Name = j.Name
            j.MouseButton1Down:Connect(function() -- Line: 114 -- upvalues: u200 (upval), MarketUtils (upval), Name (val)
                if u200 then
                    MarketUtils.OpenGiftUI(Name)
                    return
                end
                MarketUtils.TryBuy(Name)
            end)
            ;((j:WaitForChild("EquipBest")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 122 -- upvalues: u200 (upval), MarketUtils (upval), Name (val)
                if u200 then
                    MarketUtils.OpenGiftUI(Name)
                    return
                end
                MarketUtils.TryBuy(Name)
            end)
            Val = (((j:WaitForChild("EquipBest")):WaitForChild("Button")):WaitForChild("Frame")):WaitForChild("Val")
            Val.Text = MarketUtils.GetCost(Name)
            Val_2 = (j:WaitForChild("PriceHolder")):WaitForChild("Val")
            Val_2.Text = ("x%*"):format((MarketUtils.GetMonConfig("ClassRoll", (tonumber((Name:split("_"))[2])))))
        end
    end
end

local u204 = Trove.new()

function u0.StartLeft() -- Line: 140
    -- upvalues: Helper_2 (val), ScrollingFrame (val), Left (val), u204 (val), LocalPlayer (val), ClassData (val)
    -- upvalues: ClassUtils (val), ReplicatedStorage (val)
    local TextLabel, v1, v2, v3, v4, v5
    local v6 = Helper_2.GetConfig()
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    local v7 = nil
    local v8 = nil
    for k, n in v6, v7, v8 do
        v3 = Helper_2.GetRarity(k) or "Common"
        v4 = Helper_2.GetLayout(k)
        v5 = Helper_2.GetClassChance(k)
        v1 = (ScrollingFrame.Temple:FindFirstChild(v3) or ScrollingFrame.Temple:FindFirstChild("Common")):Clone()
        v1.Parent = ScrollingFrame
        v1.LayoutOrder = v4
        v1.Name = k
        v1.Visible = true
        TextLabel = v1:WaitForChild("bai"):WaitForChild("TextLabel")
        v2 = (math.round(v5 * 1000)) / 10
        TextLabel.Text = ("%*(%*%%)"):format(Helper_2.GetDisName(k) or k .. "记得改", v2)
    end
    local No = (Left:WaitForChild("Eyes")):WaitForChild("No")
    local Yes = (Left:WaitForChild("Eyes")):WaitForChild("Yes")
    ;(No:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 171
        -- upvalues: u204 (upval), LocalPlayer (upval), ClassData (upval), ClassUtils (upval), ReplicatedStorage (upval)
        -- upvalues: No (val), Yes (val)
        u204:Clean()
        local Character = LocalPlayer.Character
        if Character then
            local v1 = ClassData.GetEquipedClass()
            ClassUtils.SetClassColor(Character, v1)
            if ReplicatedStorage:FindFirstChild("ServerClass") then
                local ServerClass = ReplicatedStorage:FindFirstChild("ServerClass")
                ServerClass.Parent = Character
                ServerClass.Name = "CLASS"
            end
        end
        No.Visible = false
        Yes.Visible = true
    end)
    ;(Yes:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 186
        -- upvalues: LocalPlayer (upval), ReplicatedStorage (upval), ClassUtils (upval), u204 (upval), No (val)
        -- upvalues: Yes (val)
        local Character = LocalPlayer.Character
        if Character then
            local function HideClassModel() -- Line: 190
                -- upvalues: Character (val), ReplicatedStorage (upval), ClassUtils (upval)
                if Character:FindFirstChild("CLASS") then
                    local CLASS = Character:FindFirstChild("CLASS")
                    if ReplicatedStorage:FindFirstChild("ServerClass") then
                        ReplicatedStorage:FindFirstChild("ServerClass"):Destroy()
                    end
                    CLASS.Parent = ReplicatedStorage
                    CLASS.Name = "ServerClass"
                    ClassUtils.SetClassColor(Character)
                end
            end

            u204:Add((Character.ChildAdded:Connect(function(a1) -- Line: 202 -- upvalues: HideClassModel (val)
                if a1.Name == "CLASS" then
                    HideClassModel()
                end
            end)))
            HideClassModel()
        end
        No.Visible = true
        Yes.Visible = false
    end)
end

function u0.StartRight() -- Line: 215 -- upvalues: Slot (val), ClassData (val), u199 (ref), u0 (val)
    for i, j in Slot:GetChildren() do
        if j:IsA("TextButton") then
            local Name = j.Name
            j.LayoutOrder = tonumber(Name)
            j.MouseButton1Down:Connect(function() -- Line: 223 -- upvalues: ClassData (upval), Name (val), u199 (upval), u0 (upval)
                if not ClassData.GetClassByIndex(Name) then
                    ClassData.TryUnlockIndex(Name)
                    return
                end
                if u199 == Name then
                    return
                end
                ClassData.ChangeEquipedIndex(Name)
                u199 = Name
                u0.UpdateRight()
            end)
            ;((j:WaitForChild("Locksuoding")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 240 -- upvalues: ClassData (upval), Name (val)
                ClassData.SetLockIndex(Name)
            end)
        end
    end
end

function u0.StartBottom() -- Line: 246
    -- upvalues: Reroll (val), ClassData (val), u199 (ref), Message (val), MarketUtils (val), Helper_2 (val)
    -- upvalues: ClassRollTips (val), Info (val), u200 (ref)
    ((Reroll:WaitForChild("Luck")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 249
        -- upvalues: ClassData (upval), u199 (upval), Message (upval), MarketUtils (upval), Helper_2 (upval)
        -- upvalues: ClassRollTips (upval)
        if ClassData.IsLockedIndex(u199) then
            Message.showMessage("Locked, cannot draw.")
            return
        end
        if ClassData.GetLuckTimes() <= 0 then
            Message.showMessage("You have no remaining draws.")
            MarketUtils.TryBuy("ClassRoll_1")
            return
        end
        local v1 = ClassData.GetClassByIndex(u199)
        local v2 = Helper_2.GetRarity(v1)
        if v2 ~= "Common" and v2 ~= "UnCommon" and v2 ~= "Rare" and v2 ~= "Epic" then
            ClassRollTips.Visible = true
            return
        end
        ClassData.LuckOnce(u199)
    end)
    ;(((Reroll:WaitForChild("x1")):WaitForChild("Buy")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 280 -- upvalues: Info (upval), u200 (upval)
        if not Info.Visible then
            Info.Visible = true
            u200 = false
            return
        end
        Info.Visible = false
        u200 = false
    end)
    local Button_3 = (ClassRollTips:WaitForChild("xinxi")):WaitForChild("Button")
    ;((Button_3:WaitForChild("Yes")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 304 -- upvalues: ClassRollTips (upval), ClassData (upval), u199 (upval)
        if ClassRollTips.Visible then
            ClassData.LuckOnce(u199)
            ClassRollTips.Visible = false
        end
    end)
    ;((Button_3:WaitForChild("No")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 310 -- upvalues: ClassRollTips (upval)
        if ClassRollTips.Visible then
            ClassRollTips.Visible = false
        end
    end)
end

function u0.StartTop() end

function u0.StartRig() -- Line: 320 -- upvalues: LocalPlayer (val), ClassMap (val)
    task.spawn(function() -- Line: 321 -- upvalues: LocalPlayer (upval), ClassMap (upval)
        local Handle
        repeat
            task.wait()
        until LocalPlayer.Character
        local Rig = ClassMap:WaitForChild("Rig")
        local Character = LocalPlayer.Character
        Character.Archivable = true
        local v1 = Character:Clone()
        Character.Archivable = false
        v1.Parent = ClassMap
        v1.Name = "Rig"
        v1:PivotTo((Rig:GetPivot()))
        v1:SetAttribute("OriCF", (Rig:GetPivot()))
        for i, j in v1:GetChildren() do
            if j.Name == "WEAPON" or j.Name == "Hat" or j.Name == "Armor" then
                j:Destroy()
            end
            if j:IsA("Accessory") then
                Handle = j:WaitForChild("Handle")
                Handle.Transparency = 0
            end
            if j.Name == "HumanoidRootPart" and j:FindFirstChild("PlayerHead") then
                j:FindFirstChild("PlayerHead"):Destroy()
            end
        end
        for k, n in v1:GetDescendants() do
            if n:IsA("Sound") or n:IsA("LocalScript") or n:IsA("Script") or n:IsA("ModuleScript") then
                n:Destroy()
            end
        end
        v1.PrimaryPart.RootPriority = 100
        v1.PrimaryPart.Anchored = true
        local v2 = script:WaitForChild("Animate"):Clone()
        v2.Parent = v1
        v2.Enabled = true
        Rig:Destroy()
    end)
end

function u0.update() -- Line: 376 -- upvalues: u0 (val)
    u0.UpdateLeft()
    u0.UpdateRight()
    u0.UpdateBottom()
    u0.UpdateTop()
end

function u0.UpdateLeft() -- Line: 383 -- upvalues: ScrollingFrame (val), ClassData (val)
    local Frame, Frame_2, Frame_3, bai, v1
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            v1 = ClassData.GetClassLevel(j.Name)
            bai = j:WaitForChild("bai")
            if v1 then
                Frame_2 = bai:WaitForChild("Frame")
                Frame_2.Visible = true
                Frame_3 = bai:WaitForChild("Frame")
                Frame_3:WaitForChild("Val").Text = v1
            else
                Frame = bai:WaitForChild("Frame")
                Frame.Visible = false
            end
        end
    end
end

function u0.UpdateRight() -- Line: 404
    -- upvalues: Slot (val), ClassData (val), Helper_2 (val), GameSetting (val), u199 (ref)
    local Frame, Icon, Icon_2, Info, Lock, Locksuoding, Name, Select, TextLabel, TextLabel_2, TextLabel_3, Tx, v1, v2, v3, v4, v5, v6, v7
    for i, j in Slot:GetChildren() do
        if j:IsA("TextButton") then
            Name = j.Name
            v4 = ClassData.IsLockedIndex(Name)
            v5 = ClassData.GetClassByIndex(Name)
            v6 = v5 and ClassData.GetClassLevel(v5)
            v7 = v5 and Helper_2.GetRarity(v5) or "Common"
            v1 = v5 and Helper_2.GetDisName(v5)
            v2 = not v5 and ClassData.CanHaveClass(Name)
            Lock = j:WaitForChild("Lock")
            Lock.Visible = not v5
            j:WaitForChild("Locksuoding").Visible = v5
            j:WaitForChild("New").Visible = v2
            if v2 then
                TextLabel = (j:WaitForChild("Lock")):WaitForChild("TextLabel")
                TextLabel.Text = "Can unlock"
                TextLabel_2 = (j:WaitForChild("Lock")):WaitForChild("TextLabel")
                TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 7)
            elseif j:WaitForChild("Lock").Visible then
                TextLabel_3 = (j:WaitForChild("Lock")):WaitForChild("TextLabel")
                TextLabel_3.Text = Helper_2.GetUnlockText(Name)
            end
            Info = j:WaitForChild("Info")
            Tx = j:WaitForChild("Tx")
            Tx.Visible = v5
            if v5 then
                Locksuoding = j:WaitForChild("Locksuoding")
                Locksuoding:WaitForChild("Select").Enabled = v4
                if not v4 then
                    Icon_2 = (((j:WaitForChild("Locksuoding")):WaitForChild("Lock")):WaitForChild("Suo")):WaitForChild("Icon")
                    Icon_2.Image = GameSetting.Icon.UnLockImage
                else
                    Icon = (((j:WaitForChild("Locksuoding")):WaitForChild("Lock")):WaitForChild("Suo")):WaitForChild("Icon")
                    Icon.Image = GameSetting.Icon.LockImage
                end
                Select = Info:WaitForChild("Select")
                Select.Enabled = u199 == Name
                Frame = Tx:WaitForChild("Frame")
                Frame:WaitForChild("Val").Text = v6
                Tx:WaitForChild("TextLabel").Text = v1
            end
            for k, n in j:WaitForChild("Rarity"):GetChildren() do
                if n:IsA("Frame") then
                    v3 = n.Name == v7
                    n.Visible = v3
                end
            end
        end
    end
end

function u0.UpdateTop() -- Line: 466 -- upvalues: ClassData (val), Helper_2 (val), Top (val), Helper (val)
    local v1 = ClassData.GetEquipedClass()
    local v2 = ClassData.GetClassLevel(v1)
    Helper_2.GetRarity(v1)
    local v3 = Helper_2.GetDisName(v1)
    local quality = (Top:WaitForChild("Tex")):WaitForChild("quality")
    local Frame = quality:WaitForChild("Frame")
    Frame:WaitForChild("Val").Text = v2
    quality:WaitForChild("TextLabel").Text = v3
    Helper.SetUIQiu((quality:WaitForChild("Frame")):WaitForChild("Val"), v1)
    Helper.SetUIQiu(quality:WaitForChild("TextLabel"), v1)
    Helper.SetUIQiu((quality:WaitForChild("Frame")):WaitForChild("Icon"), v1)
end

function u0.UpdateBottom() -- Line: 485 -- upvalues: ClassData (val), Bottom (val), Race (val)
    local v1 = ClassData.GetLuckTimes()
    local LuckTimes = (Bottom:WaitForChild("Txt")):WaitForChild("LuckTimes")
    LuckTimes.Text = ("Race Roll x%*"):format(v1)
    local New = (Race:WaitForChild("Frame")):WaitForChild("New")
    New.Visible = v1 > 0
end

local u215 = false

function u0.open() -- Line: 493
    -- upvalues: u215 (ref), UIController (val), Class (val), Hud (val), Main (val), UIVFX (val), LocalPlayerUtils (val)
    -- upvalues: ClassMap (val), CameraUtils (val), ClassData (val), u0 (val)
    if workspace:GetAttribute("SCREENMAINOPEN") or u215 then
        return
    end
    u215 = true
    UIController.OpenScreenMain(Class.Name)
    Hud.Enabled = false
    Main.Enabled = false
    UIVFX.Enabled = false
    LocalPlayerUtils.DisablePlrAction(true)
    local Pivot = ClassMap:WaitForChild("Rig"):GetPivot()
    CameraUtils.CameraTween(TweenInfo.new(0), CFrame.lookAt(Pivot.Position + Pivot.LookVector * 12, Pivot.Position))
    u0.SetRigClassChar((ClassData.GetEquipedClass()))
    u0.UpdateRight()
end

function u0.close() -- Line: 521
    -- upvalues: u215 (ref), UIController (val), Class (val), Info (val), LocalPlayerUtils (val), Hud (val), Main (val)
    -- upvalues: UIVFX (val), CameraUtils (val)
    if not u215 then
        return
    end
    UIController.CloseScreenMain(Class.Name)
    Info.Visible = false
    u215 = false
    LocalPlayerUtils.EnablePlrAction(true)
    Hud.Enabled = true
    Main.Enabled = true
    UIVFX.Enabled = true
    CameraUtils.BackToPlr(0)
end

function u0.SelectIndexFrame() -- Line: 536
    -- upvalues: u199 (ref), ClassData (val), u0 (val), Helper_2 (val), Infos (val), RichTextUtils (val)
    -- upvalues: Description (val)
    local v1, v2
    u199 = ClassData.GetEquipedIndex()
    u0.UpdateRight()
    local v3 = ClassData.GetClassByIndex(u199)
    local v4 = ClassData.GetClassLevel(v3)
    local v5 = v4 + 1
    u0.SetRigClassChar(v3)
    local v6 = Helper_2.GetDisName(v3)
    local v7 = Helper_2.GetDescription(v3)
    local v8 = Helper_2.GetClassBoosts(v3, v4)
    local Text = (Infos:WaitForChild("Info")):WaitForChild("Text")
    for i, j in ((Text:WaitForChild("1")):WaitForChild("bai")):WaitForChild("Frame"):GetChildren() do
        if j:IsA("ImageLabel") then
            v2 = if not (tonumber(j.Name) <= v4) then 0.69 else 0
            j.ImageTransparency = v2
            j:WaitForChild("UIGradient").Enabled = v1
        end
    end
    local bai_2 = (Text:WaitForChild("1")):WaitForChild("bai")
    bai_2:WaitForChild("TextLabel").Text = v6
    for k, n in Text:WaitForChild("2"):GetChildren() do
        if n:IsA("Frame") then
            n:Destroy()
        end
    end
    if not (v4 < 3) then
        local Up_2, num_2, v9
        for m, i5 in v8 do
            v9 = ((Text:WaitForChild("2")):WaitForChild("Temple")):WaitForChild("temple"):Clone()
            v9.Parent = Text:WaitForChild("2")
            v9.Visible = true
            v1 = Helper_2.GetBoostShowText(m)
            num_2 = v9:WaitForChild("num")
            num_2.Text = ("%*%*%%"):format(v1, (math.round(i5 * 100)))
            Up_2 = v9:WaitForChild("Up")
            Up_2.Visible = false
        end
    else
        local Up, num, v10, v11
        for i6, i7 in (Helper_2.GetClassBoosts(v3, v5)) do
            v1 = ((Text:WaitForChild("2")):WaitForChild("Temple")):WaitForChild("temple"):Clone()
            v1.Parent = Text:WaitForChild("2")
            v1.Visible = true
            v2 = Helper_2.GetBoostShowText(i6)
            v10 = v8[i6] or 0
            v11 = RichTextUtils.RichToColor((" >> %*%%"):format((math.round(i7 * 100))), Color3.fromRGB(0, 255, 0))
            num = v1:WaitForChild("num")
            num.Text = ("%*%*%%%*"):format(v2, math.round(v10 * 100), v11)
            Up = v1:WaitForChild("Up")
            Up.Visible = true
        end
    end
    Description:WaitForChild("TextLabel").Text = v7
end

function u0.SetRigClassChar(a1) -- Line: 606 -- upvalues: ClassUtils (val), ClassMap (val)
    if not a1 then
        a1 = "Class_1"
    end
    ClassUtils.SetClassChar(ClassMap:WaitForChild("Rig"), a1)
end

function u0.LuckAnim(a1) -- Line: 613
    -- upvalues: UIController (val), Class (val), Info (val), ClassMap (val), Helper_2 (val), CurrentCamera (val)
    -- upvalues: Top (val), CameraUtils (val), ClassUtils (val), SoundPlayer (val), VFXUtils (val)
    -- upvalues: ReplicatedStorage (val)
    local Result = a1.Result
    UIController.CloseScreenMain(Class.Name, true)
    Info.Visible = false
    local Rig = ClassMap:WaitForChild("Rig")
    local v1 = {}
    local v2 = {}
    for i, j in (Helper_2.GetConfig()) do
        table.insert(v2, i)
    end
    for k = 1, 16 do
        table.insert(v1, v2[(math.random(1, #v2))])
    end
    table.insert(v1, Result)
    local Pivot = Rig:GetPivot()
    local CFrame_2 = CurrentCamera.CFrame
    local v3 = CFrame.lookAt(Pivot.Position + Pivot.LookVector * 7 + Pivot.UpVector * 1, Pivot.Position)
    Top.Visible = false
    CameraUtils.CameraTween(TweenInfo.new(2.72), v3)
    for n, m in v1 do
        if n ~= #v1 then
            ClassUtils.SetClassChar(Rig, m, {IgnoreVFX = true})
            SoundPlayer.playSound("RollOnce")
            task.wait(0.02 + n * 0.015)
        else
            ClassUtils.SetClassChar(Rig, Result)
            task.wait(0.02 + n * 0.015)
            SoundPlayer.playSound("RerollOnce")
            CameraUtils.CameraTween(TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), CFrame_2)
            VFXUtils.CreateVFXEmiteOnce(ReplicatedStorage.Assets.VFX.ClassLuckVFX, Rig:GetPivot(), 2)
        end
    end
    Top.Visible = true
    UIController.OpenScreenMain(Class.Name)
end

function u0.ShowMainFrame(a1) end

function u0.HideMainFrame(a1) end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ClassGUI.Animate
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ClassGUI.Animate
-- Decompile time: 25.25 ms

local v1
local Parent = script.Parent
local Torso = Parent:WaitForChild("Torso")
local u9 = Torso:WaitForChild("Right Shoulder")
local u13 = Torso:WaitForChild("Left Shoulder")
local u17 = Torso:WaitForChild("Right Hip")
local u21 = Torso:WaitForChild("Left Hip")
Torso:WaitForChild("Neck")
local Humanoid = Parent:WaitForChild("Humanoid")
local u30 = "Standing"
local success, result = pcall(function() -- Line: 15
    return UserSettings():IsUserFeatureEnabled("UserAnimateRemoveEmoteChatHook")
end)

local function getRigScale() -- Line: 23 -- upvalues: Parent (val)
    return Parent:GetScale()
end

local u38 = ""
local u39 = nil
local u40 = nil
local u41 = nil
local u42 = 1
local u43 = {}
local u44 = {
    idle = {
        {id = "http://www.roblox.com/asset/?id=180435571", weight = 9},
        {id = "http://www.roblox.com/asset/?id=180435792", weight = 1},
    },
    walk = {{id = "http://www.roblox.com/asset/?id=180426354", weight = 10}},
    run = {{id = "run.xml", weight = 10}},
    jump = {{id = "http://www.roblox.com/asset/?id=125750702", weight = 10}},
    fall = {{id = "http://www.roblox.com/asset/?id=180436148", weight = 10}},
    climb = {{id = "http://www.roblox.com/asset/?id=180436334", weight = 10}},
    sit = {{id = "http://www.roblox.com/asset/?id=178130996", weight = 10}},
    toolnone = {{id = "http://www.roblox.com/asset/?id=182393478", weight = 10}},
    toolslash = {{id = "http://www.roblox.com/asset/?id=129967390", weight = 10}},
    toollunge = {{id = "http://www.roblox.com/asset/?id=129967478", weight = 10}},
    wave = {{id = "http://www.roblox.com/asset/?id=128777973", weight = 10}},
    point = {{id = "http://www.roblox.com/asset/?id=128853357", weight = 10}},
    dance1 = {
        {id = "http://www.roblox.com/asset/?id=182435998", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491037", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491065", weight = 10},
    },
    dance2 = {
        {id = "http://www.roblox.com/asset/?id=182436842", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491248", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491277", weight = 10},
    },
    dance3 = {
        {id = "http://www.roblox.com/asset/?id=182436935", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491368", weight = 10},
        {id = "http://www.roblox.com/asset/?id=182491423", weight = 10},
    },
    laugh = {{id = "http://www.roblox.com/asset/?id=129423131", weight = 10}},
    cheer = {{id = "http://www.roblox.com/asset/?id=129423030", weight = 10}},
}
local u86 = {"dance1", "dance2", "dance3"}
local u90 = {
    wave = false,
    point = false,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false,
}

function configureAnimationSet(a1, a2) -- Line: 99 -- upvalues: u43 (val)
    if u43[a1] ~= nil then
        for k, v in pairs(u43[a1].connections) do
            v:disconnect()
        end
    end
    u43[a1] = {}
    local v1 = u43[a1]
    v1.count = 0
    v1 = u43[a1]
    v1.totalWeight = 0
    v1 = u43[a1]
    v1.connections = {}
    v1 = script:FindFirstChild(a1)
    if v1 ~= nil then
        local Weight, v2, v3
        table.insert(u43[a1].connections, (v1.ChildAdded:connect(function(a1_2) -- Line: 114 -- upvalues: a1 (val), a2 (val)
            configureAnimationSet(a1, a2)
        end)))
        table.insert(u43[a1].connections, (v1.ChildRemoved:connect(function(a1_2) -- Line: 115 -- upvalues: a1 (val), a2 (val)
            configureAnimationSet(a1, a2)
        end)))
        local v4 = 1
        for k2, i in pairs(v1:GetChildren()) do
            if i:IsA("Animation") then
                table.insert(u43[a1].connections, (i.Changed:connect(function(a1_2) -- Line: 119 -- upvalues: a1 (val), a2 (val)
                    configureAnimationSet(a1, a2)
                end)))
                v3 = u43[a1]
                v3[v4] = {}
                u43[a1][v4].anim = i
                Weight = i:FindFirstChild("Weight")
                if Weight ~= nil then
                    v2 = u43[a1][v4]
                    v2.weight = Weight.Value
                else
                    v2 = u43[a1][v4]
                    v2.weight = 1
                end
                v2 = u43[a1]
                v2.count = u43[a1].count + 1
                v2 = u43[a1]
                v2.totalWeight = u43[a1].totalWeight + u43[a1][v4].weight
                v4 = v4 + 1
            end
        end
    end
    if u43[a1].count <= 0 then
        local v5
        for k3, j in pairs(a2) do
            v5 = u43[a1]
            v5[k3] = {}
            v5 = u43[a1][k3]
            v5.anim = Instance.new("Animation")
            u43[a1][k3].anim.Name = a1
            u43[a1][k3].anim.AnimationId = j.id
            v5 = u43[a1][k3]
            v5.weight = j.weight
            v5 = u43[a1]
            v5.count = u43[a1].count + 1
            v5 = u43[a1]
            v5.totalWeight = u43[a1].totalWeight + j.weight
        end
    end
end

function scriptChildModified(a1) -- Line: 152 -- upvalues: u44 (val)
    local v1 = u44[a1.Name]
    if v1 ~= nil then
        configureAnimationSet(a1.Name, v1)
    end
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local Animator = if not Humanoid then nil else Humanoid:FindFirstChildOfClass("Animator")
if Animator then
    for i, v in ipairs((Animator:GetPlayingAnimationTracks())) do
        v:Stop(0)
        v:Destroy()
    end
end
for k, i2 in pairs(u44) do
    configureAnimationSet(k, i2)
end
local u148 = "None"
local u149 = 0
local u150 = 0

function stopAllAnimations() -- Line: 193 -- upvalues: u38 (ref), u90 (val), u39 (ref), u41 (ref), u40 (ref)
    local v1 = u38
    if u90[v1] ~= nil and u90[v1] == false then
        v1 = "idle"
    end
    u38 = ""
    u39 = nil
    if u41 ~= nil then
        u41:disconnect()
    end
    if u40 ~= nil then
        u40:Stop()
        u40:Destroy()
        u40 = nil
    end
    return v1
end

function setAnimationSpeed(a1) -- Line: 215 -- upvalues: u42 (ref), u40 (ref)
    if a1 ~= u42 then
        u40:AdjustSpeed(a1)
    end
end

function keyFrameReachedFunc(a1) -- Line: 222 -- upvalues: u38 (ref), u90 (val), u42 (ref), Humanoid (val)
    if a1 == "End" then
        local v1 = u38
        if u90[v1] ~= nil and u90[v1] == false then
            v1 = "idle"
        end
        local v2 = u42
        playAnimation(v1, 0, Humanoid)
        setAnimationSpeed(v2)
    end
end

function playAnimation(a1, a2, a3) -- Line: 238
    -- upvalues: u43 (val), u39 (ref), u40 (ref), u42 (ref), u38 (ref), u41 (ref)
    local v1 = math.random(1, u43[a1].totalWeight)
    local v2 = 1
    while u43[a1][v2].weight < v1 do
        v1 = v1 - u43[a1][v2].weight
        v2 = v2 + 1
    end
    local anim = u43[a1][v2].anim
    if anim ~= u39 then
        if u40 ~= nil then
            u40:Stop(a2)
            u40:Destroy()
        end
        u42 = 1
        u40 = a3:LoadAnimation(anim)
        u40.Priority = Enum.AnimationPriority.Core
        u40:Play(a2)
        u38 = a1
        u39 = anim
        if u41 ~= nil then
            u41:disconnect()
        end
        u41 = u40.KeyframeReached:connect(keyFrameReachedFunc)
    end
end

local u163 = ""
local u164 = nil
local u165 = nil
local u166 = nil

function toolKeyFrameReachedFunc(a1) -- Line: 287 -- upvalues: u163 (ref), Humanoid (val)
    if a1 == "End" then
        playToolAnimation(u163, 0, Humanoid)
    end
end

function playToolAnimation(a1, a2, a3, a4) -- Line: 295
    -- upvalues: u43 (val), u165 (ref), u164 (ref), u163 (ref), u166 (ref)
    local v1 = math.random(1, u43[a1].totalWeight)
    local v2 = 1
    while u43[a1][v2].weight < v1 do
        v1 = v1 - u43[a1][v2].weight
        v2 = v2 + 1
    end
    local anim = u43[a1][v2].anim
    if u165 ~= anim then
        local v3
        if u164 == nil then
            v3 = a2
        else
            u164:Stop()
            u164:Destroy()
            v3 = 0
        end
        u164 = a3:LoadAnimation(anim)
        if a4 then
            u164.Priority = a4
        end
        u164:Play(v3)
        u163 = a1
        u165 = anim
        u166 = u164.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end

function stopToolAnimations() -- Line: 330 -- upvalues: u163 (ref), u166 (ref), u165 (ref), u164 (ref)
    local v1 = u163
    if u166 ~= nil then
        u166:disconnect()
    end
    u163 = ""
    u165 = nil
    if u164 ~= nil then
        u164:Stop()
        u164:Destroy()
        u164 = nil
    end
    return v1
end

function onRunning(a1) -- Line: 353
    -- upvalues: Parent (val), Humanoid (val), u39 (ref), u30 (ref), u90 (val), u38 (ref)
    local v1 = a1 / Parent:GetScale()
    if not (v1 > 0.01) then
        if u90[u38] == nil then
            playAnimation("idle", 0.1, Humanoid)
            u30 = "Standing"
        end
        return
    end
    playAnimation("walk", 0.1, Humanoid)
    if u39 and u39.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
        setAnimationSpeed(v1 / 14.5)
    end
    u30 = "Running"
end

function onDied() -- Line: 370 -- upvalues: u30 (ref)
    u30 = "Dead"
end

function onJumping() -- Line: 374 -- upvalues: Humanoid (val), u150 (ref), u30 (ref)
    playAnimation("jump", 0.1, Humanoid)
    u150 = 0.3
    u30 = "Jumping"
end

function onClimbing(a1) -- Line: 380 -- upvalues: Parent (val), Humanoid (val), u30 (ref)
    local v1 = a1 / Parent:GetScale()
    playAnimation("climb", 0.1, Humanoid)
    setAnimationSpeed(v1 / 12)
    u30 = "Climbing"
end

function onGettingUp() -- Line: 388 -- upvalues: u30 (ref)
    u30 = "GettingUp"
end

function onFreeFall() -- Line: 392 -- upvalues: u150 (ref), Humanoid (val), u30 (ref)
    if u150 <= 0 then
        playAnimation("fall", 0.3, Humanoid)
    end
    u30 = "FreeFall"
end

function onFallingDown() -- Line: 399 -- upvalues: u30 (ref)
    u30 = "FallingDown"
end

function onSeated() -- Line: 403 -- upvalues: u30 (ref)
    u30 = "Seated"
end

function onPlatformStanding() -- Line: 407 -- upvalues: u30 (ref)
    u30 = "PlatformStanding"
end

function onSwimming(a1) -- Line: 411 -- upvalues: u30 (ref)
    if a1 > 0 then
        u30 = "Running"
        return
    end
    u30 = "Standing"
end

function getTool() -- Line: 419 -- upvalues: Parent (val)
    for i, v in ipairs(Parent:GetChildren()) do
        if v.className == "Tool" then
            return v
        end
    end
    return nil
end

function getToolAnim(a1) -- Line: 426
    for i, v in ipairs(a1:GetChildren()) do
        if v.Name == "toolanim" and v.className == "StringValue" then
            return v
        end
    end
    return nil
end

function animateTool() -- Line: 435 -- upvalues: u148 (ref), Humanoid (val)
    if u148 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
        return
    end
    if u148 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
        return
    end
    if u148 ~= "Lunge" then
        return
    end
    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
end

function moveSit() -- Line: 453 -- upvalues: u9 (val), u13 (val), u17 (val), u21 (val)
    u9.MaxVelocity = 0.15
    u13.MaxVelocity = 0.15
    u9:SetDesiredAngle(1.57)
    u13:SetDesiredAngle(-1.57)
    u17:SetDesiredAngle(1.57)
    u21:SetDesiredAngle(-1.57)
end

local u190 = 0

function move(a1) -- Line: 464
    -- upvalues: u190 (ref), u150 (ref), u30 (ref), Humanoid (val), u9 (val), u13 (val), u17 (val), u21 (val)
    -- upvalues: u148 (ref), u149 (ref), u165 (ref)
    local v1, v2
    local v3 = 1
    local v4 = 1
    local v5 = a1 - u190
    u190 = a1
    local v6 = false
    if u150 > 0 then
        u150 = u150 - v5
    end
    if u30 == "FreeFall" and u150 <= 0 then
        playAnimation("fall", 0.3, Humanoid)
        if v6 then
            v1 = v3 * math.sin(a1 * v4)
            u9:SetDesiredAngle(v1 + 0)
            u13:SetDesiredAngle(v1 - 0)
            u17:SetDesiredAngle(-v1)
            u21:SetDesiredAngle(-v1)
        end
        v1 = getTool()
        if v1 and v1:FindFirstChild("Handle") then
            v2 = getToolAnim(v1)
            if v2 then
                u148 = v2.Value
                v2.Parent = nil
                u149 = a1 + 0.3
            end
            if u149 < a1 then
                u149 = 0
                u148 = "None"
            end
            animateTool()
            return
        end
        stopToolAnimations()
        u148 = "None"
        u165 = nil
        u149 = 0
        return
    end
    if u30 == "Seated" then
        playAnimation("sit", 0.5, Humanoid)
        return
    end
    if u30 == "Running" then
        playAnimation("walk", 0.1, Humanoid)
    elseif u30 == "Dead"
        or u30 == "GettingUp"
        or u30 == "FallingDown"
        or u30 == "Seated"
        or u30 == "PlatformStanding" then
        stopAllAnimations()
        v3 = 0.1
        v4 = 1
        v6 = true
    end
    if v6 then
        v1 = v3 * math.sin(a1 * v4)
        u9:SetDesiredAngle(v1 + 0)
        u13:SetDesiredAngle(v1 - 0)
        u17:SetDesiredAngle(-v1)
        u21:SetDesiredAngle(-v1)
    end
    v1 = getTool()
    if v1 and v1:FindFirstChild("Handle") then
        v2 = getToolAnim(v1)
        if v2 then
            u148 = v2.Value
            v2.Parent = nil
            u149 = a1 + 0.3
        end
        if u149 < a1 then
            u149 = 0
            u148 = "None"
        end
        animateTool()
        return
    end
    stopToolAnimations()
    u148 = "None"
    u165 = nil
    u149 = 0
end

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
if not success or not result then
    (game:GetService("Players")).LocalPlayer.Chatted:connect(function(a1) -- Line: 542 -- upvalues: u86 (val), u30 (ref), u90 (val), Humanoid (val)
        local v1 = ""
        if a1 == "/e dance" then
            v1 = u86[math.random(1, #u86)]
        elseif string.sub(a1, 1, 3) == "/e " then
            v1 = string.sub(a1, 4)
        elseif string.sub(a1, 1, 7) == "/emote " then
            v1 = string.sub(a1, 8)
        end
        if u30 == "Standing" and u90[v1] ~= nil then
            playAnimation(v1, 0.1, Humanoid)
        end
    end)
end
local PlayEmote = script:WaitForChild("PlayEmote")

function PlayEmote.OnInvoke(a1) -- Line: 559 -- upvalues: u30 (ref), u90 (val), Humanoid (val), u40 (ref)
    if u30 ~= "Standing" then
        return
    end
    if u90[a1] == nil then
        return false
    end
    playAnimation(a1, 0.1, Humanoid)
    return true, u40
end

playAnimation("idle", 0.1, Humanoid)
while Parent.Parent ~= nil do
    _, v1 = wait(0.1)
    move(v1)
end
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ConfettiGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ConfettiGUI
-- Decompile time: 5.44 ms

local u0 = {}
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConfettiGui = LocalPlayer.PlayerGui:WaitForChild("ConfettiGui")
local ConfettiCreator = require(ConfettiGui.ConfettiCreator)
local ConfettiCreatorNew = require(ConfettiGui.ConfettiCreatorNew)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
;((require(ReplicatedStorage.Utils.CommunicationUtils)).TryGetRemoteEvent("ComfettiGUI", "FireFollowerRE")).OnClientEvent:Connect(function() -- Line: 16 -- upvalues: u0 (val)
    u0.FireFlower()
end)

function u0.FireFlower() -- Line: 20 -- upvalues: u0 (val), SoundPlayer (val)
    u0.FireFlowerLeft(0.1, 0.2, 35)
    u0.FireFlowerRight(0.9, 0.2, 35)
    SoundPlayer.playSound("GonfettiCreator")
end

function u0.FireFlowerLeft(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15) -- Line: 26
    -- upvalues: ConfettiCreator (val)
    if not a3 then
        a3 = 10
    end
    task.spawn(function() -- Line: 46 -- upvalues: ConfettiCreator (upval), a1 (val), a2 (val), a3 (ref)
        ConfettiCreator(UDim2.fromScale(a1, a2), a3, {
            Color3.new(1, 0.174502, 0.173648),
            Color3.new(0.394522, 0.932494, 0.406073),
            Color3.new(0.0399939, 0.473487, 0.932494),
            Color3.new(0.918441, 0.932494, 0.228336),
            Color3.new(0.870344, 0.364446, 0.932494),
            (Color3.new(0.0395514, 0.920409, 0.932494)),
        }, 0, 0, 40, 60, -400, 300, 2, 18, 35, 37, 0.3, 0.5)
    end)
end

function u0.FireFlowerRight(a1, a2, a3) -- Line: 69 -- upvalues: ConfettiCreator (val)
    if not a3 then
        a3 = 10
    end
    task.spawn(function() -- Line: 73 -- upvalues: ConfettiCreator (upval), a1 (val), a2 (val), a3 (ref)
        ConfettiCreator(UDim2.fromScale(a1, a2), a3, {
            Color3.new(1, 0.174502, 0.173648),
            Color3.new(0.394522, 0.932494, 0.406073),
            Color3.new(0.0399939, 0.473487, 0.932494),
            Color3.new(0.918441, 0.932494, 0.228336),
            Color3.new(0.870344, 0.364446, 0.932494),
            (Color3.new(0.0395514, 0.920409, 0.932494)),
        }, 0, 0, 40, 60, -400, 300, -2, -18, 35, 37, 0.3, 0.5)
    end)
end

function u0.ClaimedIndexExp(a1) -- Line: 100 -- upvalues: ConfettiGui (val), ConfettiCreatorNew (val)
    if not a1 then
        return
    end
    local AbsoluteSize_2 = ConfettiGui.AbsoluteSize
    local AbsolutePosition = a1.AbsolutePosition
    local AbsoluteSize = a1.AbsoluteSize
    local u10 = (AbsolutePosition.X + AbsoluteSize.X / 2) / AbsoluteSize_2.X
    local u15 = (AbsolutePosition.Y + AbsoluteSize.Y) / AbsoluteSize_2.Y
    task.spawn(function() -- Line: 111 -- upvalues: ConfettiCreatorNew (upval), u10 (val), u15 (val)
        ConfettiCreatorNew({
            count = 20,
            minCreateDT = 0,
            maxCreateDT = 0,
            minSize = 10,
            maxSize = 20,
            minUpwardVelocity = -100,
            maxUpwardVelocity = 100,
            minHorizontalSpeed = -7,
            maxHorizontalSpeed = 7,
            minDownwardAcceleration = 17,
            maxDownwardAcceleration = 19,
            minXDecay = 1,
            maxXDecay = 1,
            minAngularSpeed = 10,
            maxAngularSpeed = 25,
            minLifetime = 1,
            maxLifetime = 1.5,
            origin = UDim2.fromScale(u10, u15),
            colors = {
                Color3.fromRGB(255, 30, 50),
                Color3.fromRGB(255, 140, 0),
                Color3.fromRGB(255, 230, 0),
                Color3.fromRGB(30, 220, 60),
                Color3.fromRGB(0, 160, 255),
                Color3.fromRGB(180, 0, 255),
                (Color3.fromRGB(255, 0, 180)),
            },
        })
    end)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.DeadGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.DeadGUI
-- Decompile time: 2.37 ms

local v1 = {}
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Dead_2 = LocalPlayer.PlayerGui:WaitForChild("Dead")
local Dead = Dead_2:WaitForChild("Dead")
local DungeonDead = Dead_2:WaitForChild("DungeonDead")
local UIController = require(ReplicatedStorage.Utils.UIController)
local Monetization = require(ReplicatedStorage.Config.Monetization)
local u42 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetBindableEvent("Dungeon", "DungeonGiveUpBE")

function v1.OpenDeadUI() -- Line: 18 -- upvalues: Dead (val), UIController (val)
    Dead.Visible = true
    UIController.closeAll()
    UIController.ShowHud(false)
end

function v1.CloseDeadUI() -- Line: 24 -- upvalues: Dead (val), UIController (val)
    Dead.Visible = false
    UIController.ShowHud(true)
end

function v1.start() -- Line: 30
    -- upvalues: DungeonDead (val), MarketplaceService (val), LocalPlayer (val), Monetization (val), u42 (val)
    local Button = (DungeonDead:WaitForChild("Main")):WaitForChild("Button")
    ;((Button:WaitForChild("Rebirth")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 33 -- upvalues: MarketplaceService (upval), LocalPlayer (upval), Monetization (upval)
        MarketplaceService:PromptProductPurchase(LocalPlayer, Monetization.DevProducts.DungeonRebirth.Id)
    end)
    ;((Button:WaitForChild("GiveUp")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 38 -- upvalues: u42 (upval)
        u42:Fire()
    end)
end

function v1.OpenDungronDeadUI() -- Line: 43 -- upvalues: DungeonDead (val), UIController (val)
    DungeonDead.Visible = true
    local Button = (DungeonDead:WaitForChild("Main")):WaitForChild("Button")
    Button.Visible = false
    task.delay(1.2, function() -- Line: 47 -- upvalues: Button (val)
        Button.Visible = true
    end)
    UIController.closeAll()
    UIController.ShowHud(false)
end

function v1.CloseDungronDeadUI() -- Line: 54 -- upvalues: DungeonDead (val), UIController (val)
    DungeonDead.Visible = false
    UIController.ShowHud(true)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.DungeonFightGUI
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.DungeonFightGUI
-- Decompile time: 18.58 ms

local u0 = {}
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
LocalPlayer.PlayerGui:WaitForChild("Main")
local Dungeon = LocalPlayer.PlayerGui:WaitForChild("Dungeon")
local Info = LocalPlayer.PlayerGui:WaitForChild("Info")
local Top = Dungeon:WaitForChild("Top")
local Exit = Dungeon:WaitForChild("Exit")
local RoundCompleted = Info:WaitForChild("RoundCompleted")
local DungeonResult = Info:WaitForChild("DungeonResult")
local TimeFormatUntil = require(ReplicatedStorage.Utils.TimeFormatUntil)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u79 = CommunicationUtils.TryGetBindableEvent("Stage", "ExitDungeonBE")

function u0.start() -- Line: 29 -- upvalues: Exit (val), u79 (val)
    Exit.MouseButton1Down:Connect(function() -- Line: 30 -- upvalues: u79 (upval)
        u79:Fire()
    end)
end

function u0.Open() -- Line: 35 -- upvalues: u0 (val), Hud (val)
    u0.OpenDungeonUI()
    local Left = Hud:WaitForChild("Left")
    Left.Visible = false
    local LeftInfos = Hud:WaitForChild("LeftInfos")
    LeftInfos.Visible = false
    local RightTop = Hud:WaitForChild("RightTop")
    RightTop.Visible = false
    local Right = Hud:WaitForChild("Right")
    Right.Visible = false
    local Race = Hud:WaitForChild("Race")
    Race.Visible = false
end

function u0.Close() -- Line: 43 -- upvalues: u0 (val), Hud (val)
    u0.CloseDungeonUI()
    local Left = Hud:WaitForChild("Left")
    Left.Visible = true
    local LeftInfos = Hud:WaitForChild("LeftInfos")
    LeftInfos.Visible = true
    local RightTop = Hud:WaitForChild("RightTop")
    RightTop.Visible = true
    local Right = Hud:WaitForChild("Right")
    Right.Visible = true
    local Race = Hud:WaitForChild("Race")
    Race.Visible = true
end

function u0.OpenDungeonUI() -- Line: 52 -- upvalues: Dungeon (val)
    Dungeon.Enabled = true
end

function u0.CloseDungeonUI() -- Line: 55 -- upvalues: Dungeon (val)
    Dungeon.Enabled = false
end

function u0.SetRoundText(a1) -- Line: 59 -- upvalues: Top (val)
    local TextLabel = ((Top:WaitForChild("Round")):WaitForChild("text")):WaitForChild("TextLabel")
    TextLabel.Text = ("Round %*"):format(a1)
end

function u0.SetLastTime(a1) -- Line: 63 -- upvalues: Top (val), TimeFormatUntil (val)
    if tonumber(a1) then
        local Tex = (Top:WaitForChild("Time")):WaitForChild("Tex")
        Tex.Text = TimeFormatUntil.MMSS(a1)
        return
    end
    local Time_2 = Top:WaitForChild("Time")
    Time_2:WaitForChild("Tex").Text = a1
end

function u0.ShowCompletedOnce(a1, a2, a3) -- Line: 74
    -- upvalues: RoundCompleted (val), GameSetting (val), AnyHelper (val), Helper (val), ReplicatedStorage (val)
    -- upvalues: AbbreviateNumber (val), TweenService (val)
    task.spawn(function() -- Line: 75
        -- upvalues: RoundCompleted (upval), a3 (val), a1 (val), GameSetting (upval), AnyHelper (upval), Helper (upval)
        -- upvalues: ReplicatedStorage (upval), AbbreviateNumber (upval), TweenService (upval)
        local Coin, Frame, ID, Mingzi, Number, Number_2, Type, Type_2, X2, shuzi, v1, v2, v3, v4
        RoundCompleted.Visible = true
        local v5 = (RoundCompleted:WaitForChild("Header")):WaitForChild("X2")
        v5.Visible = true
        local Common = (RoundCompleted:WaitForChild("Header")):WaitForChild("Common")
        Common.Visible = false
        local Main = (RoundCompleted:WaitForChild("Info")):WaitForChild("Main")
        local TextLabel = (v5:WaitForChild("text")):WaitForChild("TextLabel")
        TextLabel.Text = ("Rouond %* Completed"):format(a3)
        local v6 = {}
        local v7 = nil
        local v8 = nil
        for i, j in a1, v7, v8 do
            ID = j.ID
            Number_2 = j.Number
            Type_2 = j.Type
            if not v6[ID] then
                v6[ID] = {Number = 0, Type = Type_2}
            end
            v1 = v6[ID]
            v1.Number = v1.Number + Number_2
        end
        local v9 = {}
        local List = Main:WaitForChild("List")
        for k, n in List:GetChildren() do
            if n:IsA("TextButton") or n:IsA("Frame") then
                n:Destroy()
            end
        end
        local v10 = nil
        local v11 = nil
        for m, i5 in v6, v10, v11 do
            Number = i5.Number
            Type = i5.Type
            if m ~= "Coin" then
                Coin = AnyHelper.GetImage(Type, m)
                v1 = AnyHelper.GetDisName(Type, m)
                v2 = AnyHelper.GetRarity(Type, m) or "Common"
                v2 = Helper.GetTextRarity(v2)
            else
                Coin = GameSetting.Icon.Coin
                v1 = "Coin"
                v2 = "Common"
            end
            v3 = Helper.GetRarityLevel(v2)
            v4 = ReplicatedStorage.Assets.Rarity.SquareFrame:WaitForChild(v2):Clone()
            v4.Visible = false
            v4.Parent = List
            v4.LayoutOrder = v3
            X2 = v4:WaitForChild("X2")
            X2.Visible = false
            Frame = v4:WaitForChild("Frame")
            Frame:WaitForChild("ImageLabel").Image = Coin
            Mingzi = (v4:WaitForChild("Frame")):WaitForChild("Mingzi")
            Mingzi.Text = ("%* x%*"):format(v1, (AbbreviateNumber(Number)))
            shuzi = (v4:WaitForChild("Frame")):WaitForChild("shuzi")
            shuzi.Text = ""
            table.insert(v9, {Frame = v4, Layout = v3})
        end
        table.sort(v9, function(a1, a2) -- Line: 147
            return a1.Layout < a2.Layout
        end)
        for i6, i7 in v9 do
            i7.Frame.LayoutOrder = i7.Layout
        end
        v5.Position = UDim2.fromScale(2, 0.5)
        Main.Position = UDim2.fromScale(0.5, 2)
        TweenService:Create(
            Main,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.fromScale(0.5, 0.5)}
        ):Play()
        TweenService:Create(v5, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.fromScale(0.5, 0.5)}):Play()
        task.wait(0.6)
        for i8, i9 in v9 do
            i9.Frame.Visible = true
            task.wait(0.1)
        end
        task.wait(1)
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.fromScale(0.5, 2)}):Play()
        TweenService:Create(v5, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.fromScale(-2, 0.5)}):Play()
        task.delay(0.4, function() -- Line: 180 -- upvalues: RoundCompleted (upval)
            RoundCompleted.Visible = false
        end)
    end)
end

function u0.ShowDungeonResult(a1) -- Line: 186
    -- upvalues: DungeonResult (val), TweenService (val), TimeFormatUntil (val), AbbreviateNumber (val)
    -- upvalues: GameSetting (val), AnyHelper (val), Helper (val), ReplicatedStorage (val)
    local Coin, Frame, ID, Mingzi, Number, Number_2, Type, Type_2, X2, shuzi, v1, v2, v3, v4
    local v5 = a1.KillNumber or 0
    local v6 = a1.TotalTime or 0
    local v7 = a1.TotalDamage or 0
    local v8 = a1.MaxRound or 0
    local ResultList = a1.ResultList
    DungeonResult.Visible = true
    DungeonResult.Position = UDim2.fromScale(0.5, 0.5)
    DungeonResult.Size = UDim2.fromScale(0, 0)
    TweenService:Create(DungeonResult, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play()
    local List = (DungeonResult:WaitForChild("Main")):WaitForChild("List")
    local Title = (List:WaitForChild("Reward")):WaitForChild("Title")
    local KillNumber = Title:WaitForChild("KillNumber")
    KillNumber.Text = ("Kills:%*"):format(v5)
    local TotalTime = Title:WaitForChild("TotalTime")
    TotalTime.Text = ("Play Time:%*"):format((TimeFormatUntil.MMSS(v6)))
    local MaxRound = Title:WaitForChild("MaxRound")
    MaxRound.Text = ("Max Floor:%*"):format(v8)
    local TotalDamage = Title:WaitForChild("TotalDamage")
    TotalDamage.Text = ("Total Dmg:%*"):format((AbbreviateNumber(v7)))
    local v9 = {}
    local v10 = nil
    local v11 = nil
    for i, j in ResultList, v10, v11 do
        ID = j.ID
        Number_2 = j.Number
        Type_2 = j.Type
        if not v9[ID] then
            v9[ID] = {Number = 0, Type = Type_2}
        end
        v1 = v9[ID]
        v1.Number = v1.Number + Number_2
    end
    local v12 = {}
    local List_2 = (List:WaitForChild("Reward")):WaitForChild("List")
    for k, n in List_2:GetChildren() do
        if n:IsA("TextButton") or n:IsA("Frame") then
            n:Destroy()
        end
    end
    local v13 = nil
    local v14 = nil
    for m, i5 in v9, v13, v14 do
        Number = i5.Number
        Type = i5.Type
        if m ~= "Coin" then
            Coin = AnyHelper.GetImage(Type, m)
            v1 = AnyHelper.GetDisName(Type, m)
            v2 = Helper.GetTextRarity((AnyHelper.GetRarity(Type, m)))
        else
            Coin = GameSetting.Icon.Coin
            v1 = "Coin"
            v2 = "Common"
        end
        v3 = Helper.GetRarityLevel(v2)
        v4 = ReplicatedStorage.Assets.Rarity.SquareFrame:WaitForChild(v2):Clone()
        v4.Visible = false
        v4.Parent = List_2
        v4.LayoutOrder = v3
        X2 = v4:WaitForChild("X2")
        X2.Visible = false
        Frame = v4:WaitForChild("Frame")
        Frame:WaitForChild("ImageLabel").Image = Coin
        Mingzi = (v4:WaitForChild("Frame")):WaitForChild("Mingzi")
        Mingzi.Text = ("%* x%*"):format(v1, (AbbreviateNumber(Number)))
        shuzi = (v4:WaitForChild("Frame")):WaitForChild("shuzi")
        shuzi.Text = ""
        table.insert(v12, {Frame = v4, Layout = v3})
    end
    table.sort(v12, function(a1, a2) -- Line: 264
        return a1.Layout < a2.Layout
    end)
    for i6, i7 in v12 do
        i7.Frame.LayoutOrder = i7.Layout
    end
    task.wait(0.3)
    for i8, i9 in v12 do
        i9.Frame.Visible = true
        task.wait(0.1)
    end
    local u171 = nil

    local function End() -- Line: 278 -- upvalues: DungeonResult (upval), u171 (ref), TweenService (upval)
        if DungeonResult.Visible and u171 then
            u171:Disconnect()
            u171 = nil
            TweenService:Create(
                DungeonResult,
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.fromScale(0.5, 2)}
            ):Play()
            task.delay(0.4, function() -- Line: 285 -- upvalues: DungeonResult (upval)
                DungeonResult.Visible = false
            end)
        end
    end

    u171 = (DungeonResult:WaitForChild("ClickAnyWhere")).MouseButton1Down:Connect(function() -- Line: 291 -- upvalues: End (val)
        End()
    end)
    task.delay(5, function() -- Line: 294 -- upvalues: DungeonResult (upval), u171 (ref), End (val)
        if DungeonResult.Visible and u171 then
            End()
        end
    end)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.DungeonGUI
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.DungeonGUI
-- Decompile time: 29.59 ms

local u0 = {}
game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.RichTextUtils)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local MarketUtils = require(ReplicatedStorage.Utils.MarketUtils)
local StatsData = require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
local DungeonData = require(ReplicatedStorage.LocalData.DungeonData)
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
require(ReplicatedStorage.Config.Weapon.Helper)
require(ReplicatedStorage.Config.Armor.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Ore.Helper)
require(ReplicatedStorage.Config.PlrSkill.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper_3 = require(ReplicatedStorage.Config.EnchStone.Helper)
local Helper_4 = require(ReplicatedStorage.Config.Dungeon.Helper)
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local UIVFX = LocalPlayer.PlayerGui:WaitForChild("UIVFX")
local Dungeon = Main:WaitForChild("Dungeon")
local Info_2 = ((Dungeon:WaitForChild("zheng")):WaitForChild("wuqi")):WaitForChild("Info")
local ScrollingFrame = ((Info_2:WaitForChild("Left")):WaitForChild("Difficulty")):WaitForChild("ScrollingFrame")
local Bottom = Info_2:WaitForChild("Bottom")
local Info = (Info_2:WaitForChild("Icon")):WaitForChild("Info")
local DailyGet = Dungeon:WaitForChild("DailyGet")
local Right = Dungeon:WaitForChild("Right")
local u181 = TableUtils.getTableLegth(Helper_4.GetConfig())
local u182 = nil
workspace:GetAttribute("today")
local WorldModel = workspace:WaitForChild("WorldModel")
local rebirth = (LocalPlayer:WaitForChild("Eco")):WaitForChild("rebirth")

function u0.init() -- Line: 61 -- upvalues: rebirth (val), WorldModel (val), Message (val)
    local function CheckCanUnlock() -- Line: 62 -- upvalues: rebirth (upval), WorldModel (upval)
        if 2 <= rebirth.Value then
            if (WorldModel:WaitForChild("DungeonMap")):FindFirstChild("LockWall") then
                local LockWall = (WorldModel:WaitForChild("DungeonMap")):FindFirstChild("LockWall")
                LockWall.CanCollide = false
            end
            if WorldModel:FindFirstChild("DungeChain")
                and (WorldModel:FindFirstChild("DungeChain")):FindFirstChild("Lock")
                and ((WorldModel:FindFirstChild("DungeChain")):FindFirstChild("Lock")):FindFirstChild("New") then
                ((WorldModel:FindFirstChild("DungeChain")):FindFirstChild("Lock")):FindFirstChild("New"):Destroy()
            end
        end
    end

    rebirth.Changed:Connect(function(a1) -- Line: 79 -- upvalues: CheckCanUnlock (val), Message (upval)
        CheckCanUnlock()
        if a1 == 2 then
            Message.showMessage("You have unlocked the Frozen Tower.")
        end
    end)
    CheckCanUnlock()
    if 2 <= rebirth.Value then
        if (WorldModel:WaitForChild("DungeonMap")):FindFirstChild("LockWall") then
            local LockWall = (WorldModel:WaitForChild("DungeonMap")):FindFirstChild("LockWall")
            LockWall.CanCollide = false
        end
        if WorldModel:FindFirstChild("DungeChain") then
            WorldModel:FindFirstChild("DungeChain"):Destroy()
        end
    end
end

function u0.start() -- Line: 100
    -- upvalues: u181 (val), ScrollingFrame (val), u0 (val), Bottom (val), u182 (ref), DungeonData (val)
    -- upvalues: BackpackData (val), Dungeon (val), DailyGet (val), Message (val), rebirth (val), LocalPlayer (val)
    -- upvalues: Right (val), MarketUtils (val), StatsData (val)
    local Button_2, Selected_2, TextLabel, TextLabel_2, Val, Val_2, v1, v2, v3, v4
    local v5 = math.floor((u181 - 1) / 5) + 1
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    for k = 1, v5 do
        v1 = (k - 1) * 5 + 1
        v2 = math.min(k * 5, u181)
        local u38 = ("%*_%*"):format(v1, v2)
        v3 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild("temple"):Clone()
        v3.Parent = ScrollingFrame
        v3.Name = u38
        v3.Visible = true
        TextLabel = ((v3:WaitForChild("Button")):WaitForChild("Main")):WaitForChild("TextLabel")
        TextLabel.Text = ("%*~%*"):format(v1, v2)
        TextLabel_2 = ((v3:WaitForChild("Selected")):WaitForChild("Main")):WaitForChild("TextLabel")
        TextLabel_2.Text = ("%*~%*"):format(v1, v2)
        v3.LayoutOrder = k
        Selected_2 = v3:WaitForChild("Selected")
        Selected_2.Visible = false
        Button_2 = v3:WaitForChild("Button")
        Button_2.Visible = true
        ;(v3:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 129 -- upvalues: u0 (upval), u38 (val)
            u0.OpenRounds(u38)
        end)
    end
    ;((Bottom:WaitForChild("Button")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 135 -- upvalues: u182 (upval), DungeonData (upval), u0 (upval)
        local v1 = tonumber((u182:split("_"))[1])
        if DungeonData.TryIntoDungeon(v1) then
            u0.StartDungeon()
        end
    end)
    DungeonData.AddCallback(function() -- Line: 142 -- upvalues: u0 (upval)
        u0.UpdateLeft()
        u0.UpdateDaily()
    end)
    local u130 = nil
    BackpackData.AddCallback(function() -- Line: 147 -- upvalues: BackpackData (upval), u130 (ref), u0 (upval)
        local v1 = BackpackData.GetItemDataByIDType("Dungeon_Ticket", "Material")
        local Number = if v1 then v1.Number else 0
        if Number ~= u130 then
            u130 = Number
            u0.UpdateLeft()
        end
    end)
    ;((Dungeon:WaitForChild("De")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 161 -- upvalues: u0 (upval)
        u0.close()
    end)
    ;(DailyGet:WaitForChild("Claim")).MouseButton1Down:Connect(function() -- Line: 165 -- upvalues: DungeonData (upval)
        DungeonData.TryClaimDailyDunTic()
    end)
    ;(DailyGet:WaitForChild("Claimed")).MouseButton1Down:Connect(function() -- Line: 168 -- upvalues: Message (upval)
        Message.showMessage("You have already claimed today.")
    end)
    u0.OpenRounds("1_5")
    u0.UpdateDaily()
    u0.UpdatePayPack()
    if rebirth.Value < 2 then
        local u182_2 = nil
        local v6 = ((workspace:WaitForChild("TOUCHED")):WaitForChild("DungeonOpen")).Touched:Connect(function(a1) -- Line: 178 -- upvalues: LocalPlayer (upval), rebirth (upval), u182_2 (ref), u0 (upval)
            if a1 == LocalPlayer.Character.PrimaryPart and 2 <= rebirth.Value then
                u182_2:Disconnect()
                u0.DungeonOpenShow()
            end
        end)
    end
    for n, m in Right:GetChildren() do
        if m:IsA("TextButton") then
            local Name = m.Name
            v4 = tonumber((Name:split("_"))[2])
            ;(((m:WaitForChild("EquipBest")):WaitForChild("Buy")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 196 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.TryBuy(Name)
            end)
            ;(((m:WaitForChild("EquipBest")):WaitForChild("Buy")):WaitForChild("LIWU")).MouseButton1Down:Connect(function() -- Line: 200 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.OpenGiftUI(Name)
            end)
            Val = ((((m:WaitForChild("EquipBest")):WaitForChild("Buy")):WaitForChild("Button")):WaitForChild("Frame")):WaitForChild("Val")
            Val.Text = MarketUtils.GetCost(Name)
            m.MouseButton1Down:Connect(function() -- Line: 207 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.TryBuy(Name)
            end)
            Val_2 = (m:WaitForChild("PriceHolder")):WaitForChild("Val")
            Val_2.Text = ("x%*"):format((MarketUtils.GetMonConfig("TowerTicketPack", v4)))
        end
    end
    StatsData.AddCallback(function() -- Line: 213 -- upvalues: u0 (upval)
        u0.UpdatePayPack()
    end)
end

function u0.update() -- Line: 217 -- upvalues: u0 (val)
    u0.UpdateLeft()
    u0.UpdateRightInfo()
    u0.UpdateDaily()
end

function u0.UpdateLeft() -- Line: 223
    -- upvalues: u182 (ref), ScrollingFrame (val), DungeonData (val), Bottom (val), Info (val), BackpackData (val)
    local Lock, Number, Selected, v1
    if not u182 then
        return
    end
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            v1 = tonumber((j.Name:split("_"))[1])
            Selected = j:WaitForChild("Selected")
            Selected.Visible = j.Name == u182
            Lock = (j:WaitForChild("Button")):WaitForChild("Lock")
            Lock.Visible = not DungeonData.CheckCanUnlock(v1)
        end
    end
    local Tex = (Bottom:WaitForChild("Frame")):WaitForChild("Tex")
    Tex.Text = ("Highest Round %*"):format((DungeonData.GetData()).maxRound or 0)
    local Val = (Info:WaitForChild("Ticket")):WaitForChild("Val")
    local v2 = BackpackData.GetItemDataByIDType("Dungeon_Ticket", "Material")
    Val.Text = ("x%*"):format(if v2 then v2.Number else 0)
    if Number == 0 then
        Val.TextColor3 = Color3.fromRGB(255, 61, 61)
        return
    end
    Val.TextColor3 = Color3.fromRGB(29, 255, 17)
end

function u0.UpdateRightInfo() -- Line: 257
    -- upvalues: u182 (ref), Helper_4 (val), Info (val), GameSetting (val), AnyHelper (val), Helper_3 (val)
    -- upvalues: Helper_2 (val), Helper (val)
    local ID, v1, v2, v3, v4, v5, v6, v7
    if not u182 then
        return
    end
    local v8 = {}
    local v9 = false
    for i = (tonumber((u182:split("_"))[1])), (tonumber((u182:split("_"))[2])) do
        v6 = Helper_4.GetLootIDWeightTab(i)
        v7 = nil
        v1 = nil
        for j, k in v6, v7, v1 do
            if Helper_4.GetLootEnhantStone2Chance(j) then
                v9 = true
            end
            v2 = Helper_4.GetLootRewardWeightTab(j)
            v3 = nil
            v4 = nil
            for n, m in v2, v3, v4 do
                if not v8[n] then
                    v8[n] = 0
                end
                v8[n] = v8[n] + k * m
            end
        end
    end
    local v10 = {}
    local v11 = nil
    local v12 = nil
    for i5, i6 in v8, v11, v12 do
        table.insert(v10, {ID = i5, BaseWeight = i6, IsForce = i5 == "Coin"})
    end
    table.sort(v10, function(a1, a2) -- Line: 290
        return a1.BaseWeight < a2.BaseWeight
    end)
    for i7, i8 in Info:WaitForChild("Reward"):GetChildren() do
        if i8:IsA("TextButton") then
            i8:Destroy()
        end
    end
    local u137 = 1

    local function Insert(a1, a2, a3) -- Line: 304 -- upvalues: Info (upval), u137 (ref)
        local v1 = ((Info:WaitForChild("Reward")):WaitForChild("Folder")):WaitForChild(a1):Clone()
        v1.Parent = Info:WaitForChild("Reward")
        v1.Visible = true
        v1.LayoutOrder = u137
        u137 = u137 + 1
        local Frame = v1:WaitForChild("Frame")
        Frame:WaitForChild("Mingzi").Text = a3
        local shuzi = (v1:WaitForChild("Frame")):WaitForChild("shuzi")
        shuzi.Text = ""
        local Frame_3 = v1:WaitForChild("Frame")
        Frame_3:WaitForChild("ImageLabel").Image = a2
    end

    Insert("Common", GameSetting.Icon.Coin, "Coin")
    v12 = 1
    v6 = {}
    for i9, i10 in v10 do
        ID = i10.ID
        v3 = AnyHelper.GetTypeByID(ID)
        if v3 ~= "Ore" then
            if v3 == "EnchStone" then
                v12 = math.max(tonumber((ID:split("_"))[2]), v12)
            elseif ID == "SeasonCoin" then
                Insert(AnyHelper.GetRarity("GameSetting", "SeasonCoin"), AnyHelper.GetImage("GameSetting", "SeasonCoin"), "Season Coin")
            end
        elseif #v6 < 2 then
            table.insert(v6, ID)
        end
    end
    Insert("Legendary", AnyHelper.GetImage("Material", "EnhantStone_1"), AnyHelper.GetDisName("Material", "EnhantStone_1"))
    if v9 then
        Insert(
            AnyHelper.GetRarity("Material", "EnhantStone_2"),
            AnyHelper.GetImage("Material", "EnhantStone_2"),
            AnyHelper.GetDisName("Material", "EnhantStone_2")
        )
    end
    for i11, i12 in {"Fire", "Ice", "Poison", "Thunder"} do
        v3 = ("%*_%*"):format(i12, v12)
        v5 = Helper_3.GetDisName(v3) or ""
        Insert(Helper_3.GetRarity(v3), Helper_3.GetImage(v3) or "", v5)
    end
    for i13, i14 in v6 do
        v3 = Helper_2.GetImage(i14)
        v4 = Helper_2.GetDisName(i14)
        Insert(Helper.GetTextRarity((Helper_2.GetRarity(i14))), v3, v4)
    end
end

function u0.UpdateDaily() -- Line: 362 -- upvalues: DungeonData (val), DailyGet (val)
    local v1 = DungeonData.CheckTodayClaimed()
    local Claim = DailyGet:WaitForChild("Claim")
    Claim.Visible = not v1
    DailyGet:WaitForChild("Claimed").Visible = v1
end

function u0.UpdatePayPack() -- Line: 369 -- upvalues: Right (val), StatsData (val)
    local Bonus, v1
    for i, j in Right:GetChildren() do
        if j:IsA("TextButton") then
            v1 = StatsData.getStatsInfo(j.Name .. "_Pay") ~= 0
            Bonus = j:WaitForChild("Bonus")
            Bonus.Visible = not v1
        end
    end
end

function u0.OpenRounds(a1) -- Line: 380 -- upvalues: u182 (ref), DungeonData (val), u0 (val)
    if u182 == a1 or not DungeonData.CheckCanUnlock((tonumber((a1:split("_"))[1]))) then
        return
    end
    u182 = a1
    u0.UpdateLeft()
    u0.UpdateRightInfo()
end

function u0.open() -- Line: 396 -- upvalues: rebirth (val), UIController (val), Dungeon (val)
    if rebirth.Value < 2 then
        return
    end
    UIController.openScreen(Dungeon.Name)
end

function u0.close() -- Line: 403 -- upvalues: UIController (val), Dungeon (val)
    UIController.closeScreen(Dungeon.Name)
end

function u0.StartDungeon() -- Line: 407 -- upvalues: u0 (val)
    u0.close()
end

local u212 = false
local CameraUtils = require(ReplicatedStorage.Utils.CameraUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local shaker = require(ReplicatedStorage.Tool.shaker)
local Camera = workspace.Camera

function u0.DungeonOpenShow() -- Line: 417
    -- upvalues: u212 (ref), UIVFX (val), WorldModel (val), CameraUtils (val), shaker (val), Camera (val)
    -- upvalues: TweenService (val), ModelVFXUtils (val)
    local v1, v2, v3
    if u212 then
        return
    end
    u212 = true
    UIVFX.Enabled = false
    local DungeChain = WorldModel:WaitForChild("DungeChain")
    local Lock = DungeChain:WaitForChild("Lock")
    local Pivot_2 = Lock:GetPivot()
    CameraUtils.CameraTween(TweenInfo.new(1), CFrame.lookAt(Pivot_2.Position - Pivot_2.RightVector * 100, Pivot_2.Position))
    task.wait(1)
    local v4 = shaker.new(Enum.RenderPriority.Camera.Value, function(a1) -- Line: 432 -- upvalues: Camera (upval)
        Camera.CFrame = Camera.CFrame * a1
    end)
    v4:ShakeOnce(1.5, 8, 3, 6)
    v4:Start()
    local w = (DungeChain:WaitForChild("VFX")):WaitForChild("w")
    w.Enabled = true
    for i, j in DungeChain:GetDescendants() do
        if j:IsA("BasePart") and j.Name ~= "VFX" then
            j.Material = Enum.Material.Neon
            v3 = TweenService
            v1 = TweenInfo.new(5)
            v2 = {Color = Color3.fromRGB(230, 230, 230)}
            v3:Create(j, v1, v2):Play()
        end
    end
    task.wait(2.5)
    ;(Lock:WaitForChild("Head")):PivotTo((CFrame.new((Lock:WaitForChild("Head"):GetPivot()).Position)))
    for k, n in DungeChain:GetDescendants() do
        if n:IsA("BasePart") and n.Name ~= "VFX" then
            v3 = TweenService
            v1 = TweenInfo.new(1.5)
            v3:Create(n, v1, {Transparency = 1}):Play()
        end
    end
    for m, i5 in DungeChain:GetChildren() do
        if i5:IsA("Model") then
            local Pivot = i5:GetPivot()
            local u158 = (CFrame.new(Pivot.Position + Vector3.new(0, -150, (math.random(-20, 20))))) * Pivot.Rotation
            task.spawn(function() -- Line: 458 -- upvalues: ModelVFXUtils (upval), i5 (val), Pivot (val), u158 (val)
                ModelVFXUtils.Parabola(i5, Pivot.Position, u158.Position, 8, 0.2, 1.2)
            end)
        end
    end
    local w_2 = (DungeChain:WaitForChild("VFX")):WaitForChild("w")
    w_2.Enabled = false
    task.wait(2.5)
    UIVFX.Enabled = true
    DungeChain:Destroy()
    CameraUtils.BackToPlr(1)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.EnchanceGUI
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.EnchanceGUI
-- Decompile time: 28.17 ms

local u0 = {}
game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.RichTextUtils)
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
require(ReplicatedStorage.LocalData.DungeonData)
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local BackpackGUI = require(ReplicatedStorage.GuiUtils.BackpackGUI)
require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
require(ReplicatedStorage.Config.Weapon.Helper)
require(ReplicatedStorage.Config.Armor.Helper)
require(ReplicatedStorage.Config.Ore.Helper)
require(ReplicatedStorage.Config.PlrSkill.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper_2 = require(ReplicatedStorage.Config.EnchStone.Helper)
require(ReplicatedStorage.Config.Dungeon.Helper)
local Trove = require(ReplicatedStorage.Packages.Trove)
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local Info = LocalPlayer.PlayerGui:WaitForChild("Info")
local Enchance = Main:WaitForChild("Enchance")
local Main_2 = (Enchance:WaitForChild("zheng")):WaitForChild("Main")
local Left = Main_2:WaitForChild("Left")
local Middle = Main_2:WaitForChild("Middle")
local Right = Main_2:WaitForChild("Right")
local IntoEnchance = Main:WaitForChild("IntoEnchance")
local Left_2 = IntoEnchance:WaitForChild("Left")
local ScrollingFrame = (((IntoEnchance:WaitForChild("Main")):WaitForChild("Right")):WaitForChild("Bg")):WaitForChild("ScrollingFrame")
local UnEnchStone = Info:WaitForChild("UnEnchStone")
local Button = (UnEnchStone:WaitForChild("xinxi")):WaitForChild("Button")
local u194 = {}
local u195 = {}
local u196 = nil
local u197 = nil
local u198 = nil
local u199 = nil
local u200 = nil
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u203 = Trove.new()

function u0.init() end

function u0.start() -- Line: 78
    -- upvalues: Left_2 (val), u0 (val), IntoEnchance (val), u197 (ref), Left (val), u198 (ref), Right (val), u200 (ref)
    -- upvalues: BackpackData (val), UnEnchStone (val), Button (val), Enchance (val)
    for i, j in Left_2:GetChildren() do
        if j:IsA("TextButton") then
            j.MouseButton1Down:Connect(function() -- Line: 81 -- upvalues: u0 (upval), j (val)
                u0.OpenIntoSelectType(j.Name)
            end)
        end
    end
    ;((IntoEnchance:WaitForChild("Bottom")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 87 -- upvalues: u197 (upval), u0 (upval)
        if u197 then
            u0.OpenEnchFrame()
        end
    end)
    for k, n in Left:WaitForChild("Title"):GetChildren() do
        if n:IsA("Frame") then
            (n:WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 97 -- upvalues: u198 (upval), u0 (upval), n (val)
                u198 = nil
                u0.OpenEnchLeftStoneType(n.Name)
                u0.UpdateEnchRightFrame()
                u0.UpdateEnchLeftFrame()
            end)
        end
    end
    ;((((Right:WaitForChild("Main")):WaitForChild("Button")):WaitForChild("Enchance")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 106 -- upvalues: u197 (upval), u198 (upval), u200 (upval), BackpackData (upval)
        if u197 and u198 and u200 then
            BackpackData.EnchantEquipment(u197, u198, u200)
            return
        end
    end)
    ;((((Right:WaitForChild("Main")):WaitForChild("Button")):WaitForChild("Unequip")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 117 -- upvalues: u197 (upval), u200 (upval), UnEnchStone (upval)
        if u197 and u200 then
            UnEnchStone.Visible = true
            return
        end
    end)
    ;((Button:WaitForChild("Yes")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 125 -- upvalues: u197 (upval), u200 (upval), BackpackData (upval), UnEnchStone (upval)
        if u197 and u200 then
            BackpackData.UnEnchantEquipment(u197, u200)
            UnEnchStone.Visible = false
            return
        end
    end)
    ;((Button:WaitForChild("No")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 134 -- upvalues: UnEnchStone (upval)
        UnEnchStone.Visible = false
    end)
    for m, i5 in (Left:WaitForChild("List")):WaitForChild("ScrollingFrame"):GetChildren() do
        if i5:IsA("Frame") or i5:IsA("TextButton") then
            i5:Destroy()
        end
    end
    ;((Enchance:WaitForChild("De")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 143 -- upvalues: u0 (upval)
        u0.close()
    end)
    ;((IntoEnchance:WaitForChild("De")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 147 -- upvalues: u0 (upval)
        u0.close()
    end)
    BackpackData.AddCallback(function() -- Line: 150 -- upvalues: Enchance (upval), u0 (upval)
        if Enchance.Visible then
            u0.UpdateEnchLeftFrame()
            u0.UpdateEnchMiddleFrame()
            u0.UpdateEnchRightFrame()
        end
    end)
    ;((Enchance:WaitForChild("Bottom")):WaitForChild("Back")).MouseButton1Down:Connect(function() -- Line: 159 -- upvalues: u0 (upval)
        u0.open()
    end)
end

function u0.update() end

function u0.OpenIntoFrame() -- Line: 169
    -- upvalues: u197 (ref), ScrollingFrame (val), u194 (ref), BackpackData (val), BackpackGUI (val), u0 (val)
    local v1, v2, v3, v4, v5
    u197 = nil
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    u194 = {}
    local have = BackpackData.GetData().have
    local v6 = nil
    local v7 = nil
    for k, n in have, v6, v7 do
        if n.Type == "Weapon" or n.Type == "Hat" or n.Type == "Armor" then
            v3, v4, v5 = BackpackGUI.CreateOneItemFrame(k, n)
            v3.Parent = ScrollingFrame
            ;(v3:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 189 -- upvalues: u197 (upval), k (val), u0 (upval)
                u197 = k
                u0.OpenEnchFrame()
            end)
            v1 = u194
            v2 = {Frame = v3, Type = n.Type, Affix = v4, IsEquiped = v5}
            v1[k] = v2
        end
    end
    local v8 = {}
    for m, i5 in u194 do
        table.insert(v8, {
            Frame = i5.Frame,
            Price = i5.Price or 0,
            Affix = i5.Affix,
            IsEquiped = i5.IsEquiped,
        })
    end
    table.sort(v8, function(a1, a2) -- Line: 209
        if a1.Affix and a2.Affix then
            return a2.Affix < a1.Affix
        end
        return a2.Price < a1.Price
    end)
    for i6, i7 in v8 do
        if not i7.IsEquiped then
            i7.Frame.LayoutOrder = i6 + 1000
        else
            i7.Frame.LayoutOrder = i6
        end
    end
    u0.OpenIntoSelectType("Weapon")
    u0.UpdateIntoFrame()
end

function u0.OpenIntoSelectType(a1) -- Line: 228 -- upvalues: u196 (ref), Left_2 (val), u194 (ref)
    local zhong
    for i, j in Left_2:GetChildren() do
        if j:IsA("TextButton") then
            zhong = j:WaitForChild("zhong")
            zhong.Visible = j.Name == a1
        end
    end
    local v1 = nil
    local v2 = nil
    for k, n in u194, v1, v2 do
        n.Frame.Visible = n.Type == a1
    end
end

function u0.UpdateIntoFrame() -- Line: 244 -- upvalues: u194 (ref), u197 (ref)
    local zhong
    local v1 = nil
    local v2 = nil
    for i, j in u194, v1, v2 do
        zhong = ((j.Frame:WaitForChild("Button")):WaitForChild("Frame")):WaitForChild("zhong")
        zhong.Visible = i == u197
    end
end

function u0.OpenEnchFrame() -- Line: 253
    -- upvalues: u197 (ref), Message (val), u200 (ref), u198 (ref), BackpackData (val), u203 (val), UIController (val)
    -- upvalues: Enchance (val), AnyHelper (val), Helper (val), Middle (val), AbbreviateNumber (val), u0 (val)
    local Name, v1
    if not u197 then
        Message.showMessage("Please select equipment.")
        return
    end
    u200 = nil
    u198 = nil
    local v2 = BackpackData.GetItemData(u197)
    if (v2.EnchanceNum or 0) <= 0 then
        Message.showMessage("This equipment has no enchantment slots.")
        return
    end
    u203:Clean()
    UIController.openScreen(Enchance.Name)
    local Type = v2.Type
    local ID = v2.ID
    local v3 = v2.Level or 0
    local v4 = AnyHelper.GetTypeByID(ID)
    local v5 = AnyHelper.GetImage(v4, ID) or ""
    local v6 = AnyHelper.GetDisName(v4, ID) or ""
    local v7 = Helper.GetTextRarity(AnyHelper.GetRarity(v4, ID) or "Common")
    local v8 = AnyHelper.GetSellPrice(v4, ID)
    for i, j in Middle:WaitForChild("BG"):GetChildren() do
        if j:IsA("Frame") then
            if j.Name == v7 then
                j.Visible = true
            else
                j.Visible = false
            end
        end
    end
    local Info = Middle:WaitForChild("Info")
    if not v8 then
        v1 = (Info:WaitForChild("Bottom")):WaitForChild("$")
        v1.Text = "Priceless"
    else
        v1 = (Info:WaitForChild("Bottom")):WaitForChild("$")
        v1.Text = ("%*$"):format((AbbreviateNumber((math.round(v8)))))
    end
    local Top = Info:WaitForChild("Top")
    Top:WaitForChild("Name").Text = v6
    local Lv = (Info:WaitForChild("Top")):WaitForChild("Lv")
    Lv.Text = ("Enhance +%*"):format(v3)
    local Lv_2 = (Info:WaitForChild("Top")):WaitForChild("Lv")
    Lv_2.Visible = v3 > 0
    Info:WaitForChild("ImageLabel").Image = v5
    local Button = Info:WaitForChild("Button")
    Button.Visible = true
    for k, n in Button:GetChildren() do
        if n:IsA("TextButton") then
            Name = n.Name
            local u204 = tonumber((Name:sub(Name:len(), (Name:len()))))
            u203:Add((n.MouseButton1Down:Connect(function() -- Line: 317 -- upvalues: u200 (upval), u204 (val), u0 (upval)
                u200 = u204
                u0.UpdateEnchRightFrame()
                u0.UpdateEnchMiddleFrame()
            end)))
        end
    end
    u0.UpdateEnchLeftFrame()
    u0.UpdateEnchRightFrame()
    u0.UpdateEnchMiddleFrame()
    u0.OpenEnchLeftStoneType("Fire")
end

function u0.UpdateEnchLeftFrame() -- Line: 332 -- upvalues: BackpackData (val), u195 (val), u0 (val)
    local v1 = BackpackData.GetData()
    for i, j in u195 do
        if not v1.have[i] then
            u0.DestroyEnchStone(i)
        end
    end
    for k, n in u195 do
        if v1.have[k] then
            u0.UpdateEnchStone(k, n.Data)
        end
    end
    for m, i5 in v1.have do
        if not u195[m] then
            u0.CreateEnchStone(m, i5)
        end
    end
end

function u0.OpenEnchLeftStoneType(a1) -- Line: 355 -- upvalues: u199 (ref), Left (val), u195 (val)
    local zhong
    for i, j in Left:WaitForChild("Title"):GetChildren() do
        if j:IsA("Frame") then
            zhong = (j:WaitForChild("TextButton")):WaitForChild("zhong")
            zhong.Visible = a1 == j.Name
        end
    end
    local v1 = nil
    local v2 = nil
    for k, n in u195, v1, v2 do
        n.Frame.Visible = n.StoneType == a1
    end
end

function u0.CreateEnchStone(a1, a2) -- Line: 371
    -- upvalues: Helper_2 (val), Helper (val), Left (val), u198 (ref), u0 (val), u195 (val)
    if a2.Type ~= "EnchStone" then
        return
    end
    local Type = a2.Type
    local ID = a2.ID
    local Number = a2.Number
    local v1 = ID:split("_")[1]
    local v2 = Helper_2.GetImage(ID)
    local v3 = Helper_2.GetDisName(ID)
    local v4 = Helper_2.GetRarity(ID)
    local v5 = Helper.GetRarityLevel(v4)
    local v6 = (((Left:WaitForChild("List")):WaitForChild("ScrollingFrame")):WaitForChild("Temple")):WaitForChild(v4):Clone()
    v6.Parent = (Left:WaitForChild("List")):WaitForChild("ScrollingFrame")
    v6.Name = a1
    v6.Visible = true
    v6.LayoutOrder = -v5
    local Frame = v6:WaitForChild("Frame")
    Frame:WaitForChild("ImageLabel").Image = v2
    Frame:WaitForChild("Mingzi").Text = v3
    local shuzi = Frame:WaitForChild("shuzi")
    shuzi.Text = ("x%*"):format(Number)
    v6.MouseButton1Down:Connect(function() -- Line: 399 -- upvalues: u198 (upval), a1 (val), u0 (upval)
        u198 = a1
        u0.UpdateEnchLeftFrame()
        u0.UpdateEnchRightFrame()
    end)
    u195[a1] = {Frame = v6, StoneType = v1}
    u0.UpdateEnchStone(a1, a2)
end

function u0.UpdateEnchStone(a1) -- Line: 411 -- upvalues: BackpackData (val), u195 (val), u198 (ref)
    local v1 = BackpackData.GetItemData(a1)
    if v1 and v1.Type == "EnchStone" then
        local Type = v1.Type
        local ID = v1.ID
        local Number = v1.Number
        local v2 = ID:split("_")[1]
        local Frame = u195[a1].Frame:WaitForChild("Frame")
        local shuzi = Frame:WaitForChild("shuzi")
        shuzi.Text = ("x%*"):format(Number)
        local v3 = Frame:WaitForChild("2")
        v3.Enabled = u198 == a1
        return
    end
end

function u0.DestroyEnchStone(a1, a2) -- Line: 428 -- upvalues: u195 (val)
    u195[a1].Frame:Destroy()
    u195[a1] = nil
end

function u0.UpdateEnchMiddleFrame() -- Line: 433
    -- upvalues: BackpackData (val), u197 (ref), Middle (val), Helper_2 (val), u200 (ref)
    local Bg_2, Icon, Name, UIGradient, v1, v2, v3
    local v4 = BackpackData.GetItemData(u197)
    local v5 = v4.EnchanceNum or 0
    local EnchanceList = v4.EnchanceList
    for i, j in Middle:WaitForChild("Info"):WaitForChild("Button"):GetChildren() do
        if j:IsA("TextButton") then
            Name = j.Name
            v1 = tonumber((Name:sub(Name:len(), (Name:len()))))
            v2 = v1 <= v5
            j.Visible = v2
            if not EnchanceList[v1] then
                Icon = ((j:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("Icon")
                Icon.Image = ""
            else
                v3 = Helper_2.GetImage(EnchanceList[v1].ID) or ""
                Bg_2 = (j:WaitForChild("Bg")):WaitForChild("Bg")
                Bg_2:WaitForChild("Icon").Image = v3
            end
            UIGradient = ((j:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("UIGradient")
            UIGradient.Enabled = v1 == u200
        end
    end
end

function u0.UpdateEnchRightFrame() -- Line: 464
    -- upvalues: u200 (ref), BackpackData (val), u197 (ref), u198 (ref), Helper_2 (val), Right (val), Helper (val)
    -- upvalues: AbbreviateNumber (val)
    local v1, v2
    local ID = nil
    local v3 = false
    if u200 then
        v1 = BackpackData.GetItemData(u197)
        if v1.EnchanceList[u200] then
            ID = v1.EnchanceList[u200].ID
            v3 = false
        end
    end
    if not ID and u198 then
        v1 = BackpackData.GetItemData(u198)
        if v1 then
            ID = v1.ID
            v3 = true
        end
    end
    if not ID then
        local Main_2 = Right:WaitForChild("Main")
        local Icon_3 = (Main_2:WaitForChild("Icon")):WaitForChild("Icon")
        Icon_3.Image = ""
        v2 = (Main_2:WaitForChild("Add")):WaitForChild("2")
        v2.Text = ""
        local Num_2 = (Main_2:WaitForChild("Tex")):WaitForChild("Num")
        Num_2.Text = ""
        local Num_3 = ((Main_2:WaitForChild("Tex")):WaitForChild("quality")):WaitForChild("Num")
        Num_3.Text = ""
        Helper.DestroyUIQIU(((Main_2:WaitForChild("Tex")):WaitForChild("quality")):WaitForChild("Num"))
        local Button_7 = Main_2:WaitForChild("Button")
        Button_7.Visible = false
        return
    end
    v1 = Helper_2.GetImage(ID)
    v2 = Helper_2.GetDisName(ID)
    local v4 = Helper_2.GetRarity(ID)
    local v5 = Helper_2.GetDescription(ID)
    local Main = Right:WaitForChild("Main")
    local Icon = Main:WaitForChild("Icon")
    Icon:WaitForChild("Icon").Image = v1
    local Add = Main:WaitForChild("Add")
    Add:WaitForChild("2").Text = v5
    local Tex = Main:WaitForChild("Tex")
    Tex:WaitForChild("Num").Text = v2
    local quality = (Main:WaitForChild("Tex")):WaitForChild("quality")
    quality:WaitForChild("Num").Text = v4
    Helper.SetUIQiu(((Main:WaitForChild("Tex")):WaitForChild("quality")):WaitForChild("Num"), v4)
    if not u200 then
        local Button = Main:WaitForChild("Button")
        Button.Visible = false
        return
    end
    local Button_2 = Main:WaitForChild("Button")
    Button_2.Visible = true
    local Button_3 = Main:WaitForChild("Button")
    Button_3:WaitForChild("Enchance").Visible = v3
    local Unequip = (Main:WaitForChild("Button")):WaitForChild("Unequip")
    Unequip.Visible = not v3
    if not v3 then
        local TextLabel_2 = (Main:WaitForChild("Button")):WaitForChild("TextLabel")
        TextLabel_2.Text = ("Price: %*"):format((AbbreviateNumber(1000)))
        return
    end
    local v6 = Helper_2.GetEnchancePrice(ID)
    local TextLabel = (Main:WaitForChild("Button")):WaitForChild("TextLabel")
    TextLabel.Text = ("Price: %*"):format((AbbreviateNumber(v6)))
end

function u0.open() -- Line: 541 -- upvalues: u0 (val), UIController (val), IntoEnchance (val)
    u0.OpenIntoFrame()
    UIController.openScreen(IntoEnchance.Name)
end

function u0.close() -- Line: 545 -- upvalues: UIController (val), IntoEnchance (val), Enchance (val)
    UIController.closeScreen(IntoEnchance.Name)
    UIController.closeScreen(Enchance.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.EnhantEventGUI
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.EnhantEventGUI
-- Decompile time: 14.62 ms

local u0 = {}
game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
LocalPlayer.PlayerGui:WaitForChild("Hud")
require(ReplicatedStorage.LocalData.BackpackData)
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
local StatsData = require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
local EnhantEventData = require(ReplicatedStorage.LocalData.EnhantEventData)
require(ReplicatedStorage.GuiUtils.Message)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.RichTextUtils)
require(ReplicatedStorage.Utils.BalanceUtils)
local MarketUtils = require(ReplicatedStorage.Utils.MarketUtils)
require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
require(ReplicatedStorage.Config.Enhant.Helper)
local EventHelper = require(ReplicatedStorage.Config.Enhant.EventHelper)
local Monetization = require(ReplicatedStorage.Config.Monetization)
local EnhantEvent = Main:WaitForChild("EnhantEvent")
local ScrollingFrame = ((EnhantEvent:WaitForChild("Main")):WaitForChild("Info")):WaitForChild("ScrollingFrame")
local Right1 = (EnhantEvent:WaitForChild("Main")):WaitForChild("Right1")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local rebirth = (LocalPlayer:WaitForChild("Eco")):WaitForChild("rebirth", 999)

function u0.init() end

function u0.start() -- Line: 49
    -- upvalues: EventHelper (val), ScrollingFrame (val), AnyHelper (val), Helper (val), ReplicatedStorage (val)
    -- upvalues: AbbreviateNumber (val), EnhantEventData (val), u0 (val), EnhantEvent (val), Right1 (val)
    -- upvalues: Monetization (val), MarketUtils (val), StatsData (val)
    local Cost, Frame_3, Left, Mingzi, Right, luobao, shuzi, shuzi_2, v1, v2, v3, v4, v5, v6, v7
    local v8 = EventHelper.GetQuestConfig()
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    local v9 = nil
    local v10 = nil
    for k, n in v8, v9, v10 do
        v6 = EventHelper.GetRewardConfigByIndex(k)
        EventHelper.GetNeedType(k)
        EventHelper.GetNeedNumber(k)
        v7 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild("temple"):Clone()
        v7.Parent = ScrollingFrame
        v7.Visible = true
        v7.LayoutOrder = tonumber(k)
        v7.Name = k
        Left = (v7:WaitForChild("Frame")):WaitForChild("Left")
        Right = (v7:WaitForChild("Frame")):WaitForChild("Right")
        for m, i5 in Left:GetChildren() do
            if i5:IsA("TextButton") or i5:IsA("Frame") then
                i5:Destroy()
            end
        end
        for i6, i7 in v6 do
            if not (i7 <= 0) then
                v1 = AnyHelper.GetRarity("Material", i6)
                v2 = AnyHelper.GetImage("Material", i6)
                v3 = AnyHelper.GetDisName("Material", i6)
                v4 = Helper.GetRarityLevel(v1)
                v5 = ReplicatedStorage.Assets.Rarity.SquareFrame:WaitForChild(v1):Clone()
                v5.Parent = Left
                v5.Visible = true
                v5.LayoutOrder = -v4
                Frame_3 = v5:WaitForChild("Frame")
                Mingzi = Frame_3:WaitForChild("Mingzi")
                Mingzi.Text = ("%*"):format(v3)
                shuzi = Frame_3:WaitForChild("shuzi")
                shuzi.Visible = true
                shuzi_2 = Frame_3:WaitForChild("shuzi")
                shuzi_2.Text = ("x%*"):format((AbbreviateNumber(i7)))
                Frame_3:WaitForChild("ImageLabel").Image = v2
            end
        end
        ;((Right:WaitForChild("Buttons")):WaitForChild("Yes")).MouseButton1Down:Connect(function() -- Line: 100 -- upvalues: EnhantEventData (upval), k (val)
            EnhantEventData.TryClaimQuest(k)
        end)
    end
    EnhantEventData.AddCallback(function() -- Line: 105 -- upvalues: u0 (upval)
        u0.update()
    end)
    ;((EnhantEvent:WaitForChild("De")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 109 -- upvalues: u0 (upval)
        u0.close()
    end)
    u0.update()
    for i8, i9 in Right1:GetChildren() do
        if i9:IsA("TextButton") then
            local Name = i9.Name
            Cost = Monetization.DevProducts[Name].Cost
            luobao = i9:WaitForChild("luobao")
            luobao:WaitForChild("TextLabel").Text = Cost
            i9.MouseButton1Down:Connect(function() -- Line: 123 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.TryBuy(Name)
            end)
            ;(i9:WaitForChild("LIWU")).MouseButton1Down:Connect(function() -- Line: 126 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.OpenGiftUI(Name)
            end)
        end
    end
    u0.UpdateRight()
    StatsData.AddCallback(function() -- Line: 131 -- upvalues: u0 (upval)
        u0.UpdateRight()
    end)
    ;(((EnhantEvent:WaitForChild("BottomButton")):WaitForChild("Skip")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 138 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("SkipEnhantQuest")
    end)
end

function u0.update() -- Line: 143 -- upvalues: ScrollingFrame (val), EventHelper (val), EnhantEventData (val)
    local Buttons, Name, No, Right, TextLabel, TextLabel_2, Val, Val_2, v1, v2, v3, v4, v5, v6
    local v7 = false
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            Name = j.Name
            v4 = EventHelper.GetNeedType(Name)
            v5 = EventHelper.GetNeedNumber(Name)
            v6 = EnhantEventData.GetRecordNum(v4)
            v1 = EventHelper.GetDescriptionByNeedType(v4)
            v2 = EnhantEventData.CheckIsClaimed(Name)
            v3 = not v2 and v5 <= v6
            j:WaitForChild("Claimed").Visible = v2
            ;(j:WaitForChild("Frame")):WaitForChild("Left")
            Right = (j:WaitForChild("Frame")):WaitForChild("Right")
            TextLabel = (Right:WaitForChild("zi")):WaitForChild("TextLabel")
            TextLabel.Text = ("(%*/%*) %*"):format(math.min(v6, v5), v5, v1)
            Buttons = Right:WaitForChild("Buttons")
            Buttons:WaitForChild("Yes").Visible = v3
            No = (Right:WaitForChild("Buttons")):WaitForChild("No")
            No.Visible = not v3
            if v2 then
                Val = (((Right:WaitForChild("Buttons")):WaitForChild("No")):WaitForChild("Frame")):WaitForChild("Val")
                Val.Text = "Claimed"
                TextLabel_2 = (Right:WaitForChild("zi")):WaitForChild("TextLabel")
                TextLabel_2.Text = ("(%*/%*) %*"):format(v5, v5, v1)
            elseif v6 < v5 then
                Val_2 = (((Right:WaitForChild("Buttons")):WaitForChild("No")):WaitForChild("Frame")):WaitForChild("Val")
                Val_2.Text = "Claim"
            end
            if v3 then
                v7 = true
            end
        end
    end
    local EnhantEvent = (workspace:WaitForChild("WorldModel")):WaitForChild("EnhantEvent")
    if (EnhantEvent:FindFirstChild("!")):WaitForChild("!") then
        local Attachment = ((EnhantEvent:FindFirstChild("!")):WaitForChild("!")):WaitForChild("Attachment")
        Attachment:WaitForChild("ParticleEmitter").Enabled = v7
    end
end

function u0.UpdateRight() -- Line: 195 -- upvalues: Right1 (val), StatsData (val)
    local Bonus, v1
    for i, j in Right1:GetChildren() do
        if j:IsA("TextButton") then
            v1 = StatsData.getStatsInfo(j.Name .. "_Pay") ~= 0
            Bonus = j:WaitForChild("Bonus")
            Bonus.Visible = not v1
        end
    end
end

function u0.open() -- Line: 206 -- upvalues: rebirth (val), UIController (val), EnhantEvent (val)
    if rebirth.Value < 6 then
        return
    end
    UIController.openScreen(EnhantEvent.Name)
end

function u0.close() -- Line: 212 -- upvalues: UIController (val), EnhantEvent (val)
    UIController.closeScreen(EnhantEvent.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ExitGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ExitGUI
-- Decompile time: 1.10 ms

local v1 = {}
local GuiService = game:GetService("GuiService")
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local OfflineTick = LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("OfflineTick")

function v1.start() -- Line: 13 -- upvalues: GuiService (val), SoundPlayer (val), OfflineTick (val)
    GuiService.MenuOpened:Connect(function() -- Line: 14 -- upvalues: SoundPlayer (upval), OfflineTick (upval)
        SoundPlayer.playSound("ExitSound")
        OfflineTick.Visible = true
    end)
    GuiService.MenuClosed:Connect(function() -- Line: 18 -- upvalues: OfflineTick (upval)
        OfflineTick.Visible = false
    end)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ExitGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ExitGUI
-- Decompile time: 1.14 ms

local v1 = {}
local GuiService = game:GetService("GuiService")
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local OfflineTick = LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("OfflineTick")

function v1.start() -- Line: 13 -- upvalues: GuiService (val), SoundPlayer (val), OfflineTick (val)
    GuiService.MenuOpened:Connect(function() -- Line: 14 -- upvalues: SoundPlayer (upval), OfflineTick (upval)
        SoundPlayer.playSound("ExitSound")
        OfflineTick.Visible = true
    end)
    GuiService.MenuClosed:Connect(function() -- Line: 18 -- upvalues: OfflineTick (upval)
        OfflineTick.Visible = false
    end)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.EyeGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.EyeGUI
-- Decompile time: 1.53 ms

local v1 = {}
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Hud_Eye = LocalPlayer.PlayerGui:WaitForChild("Hud_Eye")
local Button = (((Hud:WaitForChild("RightTop")):WaitForChild("Button")):WaitForChild("Eye")):WaitForChild("Button")
local Button_2 = (((Hud_Eye:WaitForChild("RightTop")):WaitForChild("Button")):WaitForChild("Eye")):WaitForChild("Button")

function v1.start() -- Line: 13 -- upvalues: Button (val), Hud (val), Hud_Eye (val), Button_2 (val)
    Button.MouseButton1Down:Connect(function() -- Line: 14 -- upvalues: Hud (upval), Hud_Eye (upval)
        Hud.Enabled = false
        Hud_Eye.Enabled = true
    end)
    Button_2.MouseButton1Down:Connect(function() -- Line: 18 -- upvalues: Hud (upval), Hud_Eye (upval)
        Hud.Enabled = true
        Hud_Eye.Enabled = false
    end)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.ForgeGUI
-- Took 0.07s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.ForgeGUI
-- Decompile time: 71.72 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local IndexData = require(ReplicatedStorage.LocalData.IndexData)
local PemData = require(ReplicatedStorage.LocalData.PemData)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
local VFXSuit = require(ReplicatedStorage.Utils.VFXSuit)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.TableUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local CameraUtils = require(ReplicatedStorage.Utils.CameraUtils)
local TextureUtils = require(ReplicatedStorage.Utils.TextureUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local ForgeUtils = require(ReplicatedStorage.Utils.ForgeUtils)
local LocalPlayerUtils = require(ReplicatedStorage.Utils.LocalPlayerUtils)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Weapon.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Armor.Helper)
local Helper_4 = require(ReplicatedStorage.Config.PlrSkill.Helper)
local Helper_5 = require(ReplicatedStorage.Config.Ore.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Monetization = require(ReplicatedStorage.Config.Monetization)
LocalPlayer.PlayerGui:WaitForChild("Hud")
LocalPlayer.PlayerGui:WaitForChild("Main")
local Info = LocalPlayer.PlayerGui:WaitForChild("Info")
local ScreenMain = LocalPlayer.PlayerGui:WaitForChild("ScreenMain")
local UIVFX_Full = LocalPlayer.PlayerGui:WaitForChild("UIVFX_Full")
local UIVFX = LocalPlayer.PlayerGui:WaitForChild("UIVFX")
local Forge = ScreenMain:WaitForChild("Forge")
local Left = Forge:WaitForChild("Left")
local Right = Forge:WaitForChild("Right")
Forge:WaitForChild("Top")
local Bottom = Forge:WaitForChild("Bottom")
local Close = Right:WaitForChild("Close")
local ScrollingFrame = (Right:WaitForChild("List")):WaitForChild("ScrollingFrame")
local Bottom_2 = Right:WaitForChild("Bottom")
local ScrollingFrame_2 = Left:WaitForChild("ScrollingFrame")
local OreList = Bottom:WaitForChild("OreList")
local ForgeButton = Bottom:WaitForChild("ForgeButton")
local Skip = Info:WaitForChild("Skip")
local SkipForging = Info:WaitForChild("SkipForging")
local u219 = nil
local u223 = CommunicationUtils.TryGetRemoteFunction("Forge", "ForgeRF")
local u227 = CommunicationUtils.TryGetBindableEvent("Forge", "PutOreNumBE")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u229 = {}
local u230 = {}
local u231 = nil
local u232 = false
local u233 = nil
local ForgeTable = (workspace:WaitForChild("WorldModel")):WaitForChild("ForgeTable")
local Moon2Cutscene = require(ReplicatedStorage.Tool.Moon2Cutscene)
local Prelude = ReplicatedStorage.Assets.MoonAnim.Prelude
local Exit = ReplicatedStorage.Assets.MoonAnim.Exit
local Forge_002 = ReplicatedStorage.Assets.MoonAnim.Forge_002
local u258 = Moon2Cutscene.new(Prelude)
local u261 = Moon2Cutscene.new(Exit)
u258:replace(7, (UIVFX_Full:WaitForChild("Black")))
u261:replace(7, (UIVFX_Full:WaitForChild("Black")))
local Sequence = workspace:WaitForChild("Sequence")
local Pivot = (Sequence:WaitForChild("Model")):WaitForChild("Light"):GetPivot()
local Pivot_2 = (Sequence:WaitForChild("试用（正式会删除）")):WaitForChild("LJ_15"):GetPivot()
;(Sequence:WaitForChild("Model")):WaitForChild("Light"):Destroy()
;(Sequence:WaitForChild("试用（正式会删除）")):WaitForChild("LJ_15"):Destroy()

local function GetBPType(a1) -- Line: 102
    if a1 == "Hat" then
        return "Armor"
    end
    return a1
end

local function GetOreListTTNum() -- Line: 109 -- upvalues: u229 (ref)
    local v1 = 0
    for i, j in u229 do
        if j and j.Number then
            v1 = v1 + j.Number
        end
    end
    return v1
end

local function GetOreTab() -- Line: 120 -- upvalues: u229 (ref)
    local v1 = {}
    for i, j in u229 do
        if j and j.Number then
            v1[j.OreID] = j.Number
        end
    end
    return v1
end

local function GetOreListAvgPower() -- Line: 131 -- upvalues: GetOreTab (val), ForgeUtils (val)
    return ForgeUtils.GetOreAvgPower((GetOreTab()))
end

function u0.init() end

function u0.start() -- Line: 140
    -- upvalues: Close (val), u0 (val), Bottom_2 (val), OreList (val), u229 (ref), ForgeButton (val), u232 (ref)
    -- upvalues: u231 (ref), u223 (val), Message (val), SoundPlayer (val), BackpackData (val), Forge (val)
    -- upvalues: IndexData (val), u233 (ref), ForgeTable (val), Sequence (val), UserInputService (val)
    -- upvalues: ScrollingFrame (val)
    Close.MouseButton1Down:Connect(function() -- Line: 141 -- upvalues: u0 (upval)
        u0.close()
    end)
    for i, j in Bottom_2:GetChildren() do
        if j:IsA("TextButton") then
            j.MouseButton1Down:Connect(function() -- Line: 148 -- upvalues: u0 (upval), j (val)
                u0.OpenConfigType(j.Name)
            end)
        end
    end
    for k, n in OreList:GetChildren() do
        if n:IsA("TextButton") then
            local u90 = tonumber(n.Name)
            n.MouseButton1Down:Connect(function() -- Line: 157 -- upvalues: u229 (upval), u90 (val), u0 (upval)
                if u229[u90] and u229[u90].UUID then
                    u0.PopOre(u229[u90].UUID)
                end
            end)
        end
    end
    local u32 = false
    ForgeButton.MouseButton1Down:Connect(function() -- Line: 165
        -- upvalues: u232 (upval), u32 (ref), u229 (upval), u231 (upval), u223 (upval), u0 (upval), Message (upval)
        -- upvalues: SoundPlayer (upval)
        if not u232 or u32 then
            return
        end
        u32 = true
        task.delay(3, function() -- Line: 169 -- upvalues: u32 (upval)
            if u32 then
                u32 = false
            end
        end)
        local v1 = 0
        for i, j in u229 do
            if j and j.Number then
                v1 = v1 + j.Number
            end
        end
        if not (v1 >= 4) then
            Message.showMessage("You need to input at least 4 ores.")
            SoundPlayer.playSound("OrePackFull")
        else
            v1 = {}
            for k, n in u229 do
                v1[n.UUID] = n.Number
            end
            local u31 = {ConfigType = u231, UUIDList = v1}
            pcall(function() -- Line: 183 -- upvalues: u223 (upval), u31 (val), u0 (upval)
                local v1 = u223:InvokeServer(u31)
                if v1 then
                    PlayForgeAnim(v1)
                    u0.CleanOreList()
                    u0.UpdateBottom()
                end
            end)
        end
        u32 = false
    end)
    BackpackData.AddCallback(function() -- Line: 198 -- upvalues: Forge (upval), u0 (upval)
        if Forge.Visible then
            u0.UpdateRight()
        end
    end)
    IndexData.AddCallback(function() -- Line: 203 -- upvalues: Forge (upval), u0 (upval)
        if Forge.Visible then
            u0.UpdateLeft()
        end
    end)
    task.spawn(function() -- Line: 209 -- upvalues: u233 (upval), ForgeTable (upval), u0 (upval), Sequence (upval)
        u233 = Instance.new("ProximityPrompt", ForgeTable:WaitForChild("Part", 999))
        u233.Style = Enum.ProximityPromptStyle.Custom
        u233.RequiresLineOfSight = false
        u233.MaxIndicatorDistance = 20
        u233.HoldDuration = 0
        u233.ActionText = "Forge"
        u233.Enabled = true
        u233.Triggered:Connect(function() -- Line: 217 -- upvalues: u0 (upval)
            u0.open()
        end)
        u233.PromptShown:Connect(function() -- Line: 220 -- upvalues: Sequence (upval)
            local v1 = Instance.new("Highlight", Sequence)
            v1.Name = "HIGHT"
            v1.FillTransparency = 1
            v1.OutlineTransparency = 0
            v1.DepthMode = Enum.HighlightDepthMode.Occluded
        end)
        u233.PromptHidden:Connect(function() -- Line: 227 -- upvalues: Sequence (upval)
            if Sequence:FindFirstChild("HIGHT") then
                Sequence:FindFirstChild("HIGHT"):Destroy()
            end
        end)
        ;(workspace:GetAttributeChangedSignal("SCREENMAINOPEN")):Connect(function() -- Line: 233 -- upvalues: u233 (upval)
            if workspace:GetAttribute("SCREENMAINOPEN") then
                u233.Enabled = false
                return
            end
            u233.Enabled = true
        end)
    end)
    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 242 -- upvalues: u0 (upval)
        if a2 then
            return
        end
        if a1.KeyCode == Enum.KeyCode.ButtonB then
            u0.close()
        end
    end)
    for m, i5 in ScrollingFrame:GetChildren() do
        if i5:IsA("Frame") or i5:IsA("TextButton") then
            i5:Destroy()
        end
    end
end

function u0.update() -- Line: 257 -- upvalues: u0 (val)
    u0.UpdateLeft()
    u0.UpdateBottom()
    u0.UpdateRight()
end

function u0.UpdateLeft() -- Line: 263
    -- upvalues: u229 (ref), u231 (ref), Helper_2 (val), Helper_3 (val), AnyHelper (val), ScrollingFrame_2 (val)
    -- upvalues: IndexData (val)
    local ID, ImageLabel, Name, Percent, TextLabel, TextLabel_2, TextLabel_3, TextLabel_4, bai_2, bai_4, huang_2, huang_4, v1, v2, v3, v4, v5
    local v6 = 0
    for i, j in u229 do
        if j and j.Number then
            v6 = v6 + j.Number
        end
    end
    local v7 = false
    if v6 < 4 then
        v6 = 4
        v7 = true
    end
    local v8 = if u231 ~= "Weapon" then Helper_3.GetForgePercentByNumber(v6) or {} else Helper_2.GetForgePercentByNumber(v6) or {}
    local v9 = {}
    local u278 = 0
    for k, n in v8 do
        table.insert(v9, {ID = k, Value = n})
        u278 = u278 + n
    end
    table.sort(v9, function(a1, a2) -- Line: 286 -- upvalues: u278 (ref)
        a1.Percent = math.clamp(a1.Value / u278, 0, 1)
        a2.Percent = math.clamp(a2.Value / u278, 0, 1)
        return a2.Value < a1.Value
    end)
    local v10 = nil
    local v11 = nil
    for m, i5 in v9, v10, v11 do
        ID = i5.ID
        Percent = i5.Percent
        v1 = AnyHelper.GetDisName(u231, ID)
        v2 = ScrollingFrame_2:FindFirstChild(ID .. "-Top")
        if v2 then
            v2.LayoutOrder = m * 2
            if not v7 then
                TextLabel_3 = (v2:WaitForChild("bai")):WaitForChild("TextLabel")
                TextLabel_3.Text = ("%*: %*%%"):format(v1, (math.round(Percent * 100)))
                TextLabel_4 = (v2:WaitForChild("huang")):WaitForChild("TextLabel")
                TextLabel_4.Text = ("%*: %*%%"):format(v1, (math.round(Percent * 100)))
                bai_4 = v2:WaitForChild("bai")
                bai_4.Visible = m ~= 1
                huang_4 = v2:WaitForChild("huang")
                huang_4.Visible = m == 1
            else
                TextLabel = (v2:WaitForChild("bai")):WaitForChild("TextLabel")
                TextLabel.Text = ("%*: 0%%"):format(v1)
                TextLabel_2 = (v2:WaitForChild("huang")):WaitForChild("TextLabel")
                TextLabel_2.Text = ("%*: 0%%}"):format(v1)
                bai_2 = v2:WaitForChild("bai")
                bai_2.Visible = true
                huang_2 = v2:WaitForChild("huang")
                huang_2.Visible = false
            end
        end
        v3 = ScrollingFrame_2:FindFirstChild(i5.ID .. "-Main")
        if v3 then
            v3.LayoutOrder = m * 2 + 1
            for i6, i7 in v3:WaitForChild("PetInfo"):GetChildren() do
                if i7:IsA("TextButton") then
                    Name = i7.Name
                    v4 = IndexData.IsUnlocked(if u231 ~= "Weapon" then Helper_3.GetBigType(Name) else "Weapon", Name)
                    ImageLabel = (i7:WaitForChild("Frame")):WaitForChild("ImageLabel")
                    v5 = v4 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
                    ImageLabel.ImageColor3 = v5
                end
            end
        end
    end
end

function u0.UpdateBottom() -- Line: 337
    -- upvalues: OreList (val), u229 (ref), Helper (val), BackpackData (val), Helper_5 (val), GetOreTab (val)
    -- upvalues: ForgeUtils (val), Bottom (val)
    local Frame, ID, ImageLabel, Number, Number_2, Number_3, TextLabel_2, TextLabel_3, UUID, v1, v2, v3, v4
    local v5 = 0
    for i, j in OreList:GetChildren() do
        if j:IsA("TextButton") then
            v3 = tonumber(j.Name)
            v4 = u229[v3]
            Frame = j:WaitForChild("Frame")
            if v4 then
                UUID = v4.UUID
                Number_2 = v4.Number
                v5 = v5 + Number_2
                ID = BackpackData.GetItemData(UUID).ID
                v1 = Helper_5.GetImage(ID)
                v2 = Helper.GetTextRarity(Helper_5.GetRarity(ID))
                Frame:WaitForChild("ImageLabel").Image = v1
                TextLabel_3 = Frame:WaitForChild("TextLabel")
                TextLabel_3.Text = ""
                Number_3 = Frame:WaitForChild("Number")
                Number_3.Text = ("x%*"):format(Number_2)
                if UUID ~= j:GetAttribute("UUID") then
                    j:SetAttribute("UUID", UUID)
                    Helper.DestroyUIQIU(Frame:WaitForChild("1"))
                    Helper.DestroyUIQIU(Frame)
                    Helper.SetUIQiu(Frame:WaitForChild("1"), v2)
                    Helper.SetUIQiu(Frame, v2)
                end
            else
                ImageLabel = Frame:WaitForChild("ImageLabel")
                ImageLabel.Image = ""
                TextLabel_2 = Frame:WaitForChild("TextLabel")
                TextLabel_2.Text = "Empty"
                Number = Frame:WaitForChild("Number")
                Number.Text = ""
                Helper.DestroyUIQIU(Frame:WaitForChild("1"))
                Helper.DestroyUIQIU(Frame)
                j:SetAttribute("UUID", nil)
            end
        end
    end
    local v6 = ForgeUtils.GetOreAvgPower((GetOreTab()))
    local TextLabel = ((Bottom:WaitForChild("ForgeButton")):WaitForChild("POWER")):WaitForChild("TextLabel")
    TextLabel.Text = ("Mutiplier: %*"):format((math.floor(v6 * 100)) / 100)
    local Yes = (Bottom:WaitForChild("ForgeButton")):WaitForChild("Yes")
    Yes.Visible = v5 >= 4
    local No = (Bottom:WaitForChild("ForgeButton")):WaitForChild("No")
    No.Visible = v5 < 4
end

function u0.UpdateRight() -- Line: 385 -- upvalues: BackpackData (val), u230 (val), u0 (val)
    local v1 = BackpackData.GetData()
    for i, j in u230 do
        if not v1.have[i] then
            u0.DestroyOreButton(i)
        end
    end
    for k, n in v1.have do
        if n.Type == "Ore" then
            if u230[k] then
                u0.UpdateOreButton(k, n)
            else
                u0.CreateOreButton(k, n)
            end
        end
    end
end

function u0.CreateOreButton(a1, a2) -- Line: 404
    -- upvalues: Helper_5 (val), Helper (val), ScrollingFrame (val), u230 (val), u0 (val)
    local ID = a2.ID
    local Number = a2.Number
    if Number and not (Number <= 0) then
        local v1 = Helper_5.GetLayout(ID)
        local v2 = Helper.GetTextRarity(Helper_5.GetRarity(ID))
        local v3 = Helper_5.GetDisName(ID) or ""
        local v4 = Helper_5.GetImage(ID) or ""
        local v5 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild(v2):Clone()
        v5.Parent = ScrollingFrame
        v5.Name = a1
        v5.Visible = true
        v5.LayoutOrder = -v1
        local Frame = v5:WaitForChild("Frame")
        v5.MouseButton1Down:Connect(function() -- Line: 422 -- upvalues: u230 (upval), a1 (val), u0 (upval), ID (val)
            if (u230[a1].UseNum or 0) < (u230[a1].ItemData.Number or 0) then
                u0.PutOre(a1, ID)
            end
        end)
        Frame:WaitForChild("shuzi").Text = Number
        Frame:WaitForChild("Mingzi").Text = v3
        Frame:WaitForChild("ImageLabel").Image = v4
        u230[a1] = {Frame = v5, ItemData = a2}
        return v5
    end
end

function u0.UpdateOreButton(a1, a2) -- Line: 442 -- upvalues: u230 (val)
    if not u230[a1] then
        return
    end
    if not a2 then
        a2 = u230[a1].ItemData
    end
    local Number = a2.Number
    local Frame = u230[a1].Frame
    local Frame_2 = Frame:WaitForChild("Frame")
    local v1 = u230[a1].UseNum or 0
    if not (Number <= v1) then
        Frame.Visible = true
        local shuzi = Frame_2:WaitForChild("shuzi")
        shuzi.Text = Number - v1
    else
        Frame.Visible = false
    end
    u230[a1].ItemData = a2
end

function u0.DestroyOreButton(a1, a2) -- Line: 463 -- upvalues: u230 (val)
    if not u230[a1] then
        return
    end
    u230[a1].Frame:Destroy()
    u230[a1] = nil
end

function u0.PutOre(a1, a2) -- Line: 471
    -- upvalues: u230 (val), u229 (ref), Message (val), ScrollingFrame (val), u0 (val), ReplicatedStorage (val)
    -- upvalues: ForgeTable (val), SoundPlayer (val), u227 (val), u231 (ref), GetOreTab (val)
    local v1
    if not u230[a1] then
        return
    end
    local v2 = false
    local v3 = nil
    local v4 = nil
    for i, j in u229, v4 do
        if j.UUID == a1 then
            v1 = u229[i]
            v1.Number = v1.Number + 1
            v3 = i
            v2 = true
            break
        end
    end
    if not v2 then
        if #u229 >= 4 then
            Message.showMessage("You can only place up to 4 ore types.")
            return
        end
        table.insert(u229, {Number = 1, UUID = a1, OreID = a2, OreModelList = {}})
        v3 = #u229
    end
    ScrollingFrame:FindFirstChild(a1)
    if not u230[a1].UseNum then
        v4 = u230[a1]
        v4.UseNum = 0
    end
    v4 = u230[a1]
    v4.UseNum = v4.UseNum + 1
    u0.UpdateOreButton(a1)
    v4 = ReplicatedStorage.Assets.Ore:WaitForChild(a2):Clone()
    v4.Parent = workspace
    v4.PrimaryPart.CollisionGroup = "Default"
    v4:ScaleTo((v4:GetScale()) * 0.6)
    v4:PivotTo((ForgeTable:WaitForChild("OrePoint")).CFrame)
    table.insert(u229[v3].OreModelList, v4)
    SoundPlayer.playSound("PutOre")
    u0.UpdateBottom()
    u0.UpdateLeft()
    local v5 = 0
    for k, n in u229 do
        if n and n.Number then
            v5 = v5 + n.Number
        end
    end
    u227:Fire(v5, u231, (GetOreTab()))
end

function u0.PopOre(a1) -- Line: 519
    -- upvalues: u230 (val), u229 (ref), u0 (val), u227 (val), u231 (ref), GetOreTab (val)
    local v1
    if not u230[a1] then
        return
    end
    local v2 = false
    local v3 = nil
    local v4 = u229
    for i, j in v4 do
        if j.UUID == a1 then
            v1 = u229[i]
            v1.Number = v1.Number - 1
            v3 = i
            v2 = true
            if not (u229[i].Number <= 0) then
                break
            end
            for k, n in u229[i].OreModelList do
                n:Destroy()
            end
            table.remove(u229, i)
            break
        end
    end
    if not v2 then
        warn("非法矿石", a1)
        return
    end
    if not u230[a1].UseNum then
        v4 = u230[a1]
        v4.UseNum = 0
    end
    v4 = u230[a1]
    v4.UseNum = v4.UseNum - 1
    u0.UpdateOreButton(a1)
    if u229[v3] and u229[v3].OreModelList and u229[v3].OreModelList[1] then
        u229[v3].OreModelList[1]:Destroy()
        table.remove(u229[v3].OreModelList, 1)
    end
    u0.UpdateBottom()
    u0.UpdateLeft()
    local v5 = 0
    for m, i5 in u229 do
        if i5 and i5.Number then
            v5 = v5 + i5.Number
        end
    end
    u227:Fire(v5, u231, (GetOreTab()))
end

function u0.CleanOreList() -- Line: 561 -- upvalues: u229 (ref), u230 (val), u0 (val)
    local v1
    if not u229 then
        u229 = {}
        return
    end
    local v2 = nil
    local v3 = nil
    for i, j in u229, v2, v3 do
        if j.OreModelList then
            for k, n in j.OreModelList do
                if n and n.Parent then
                    n:Destroy()
                end
            end
        end
    end
    u229 = {}
    for m, i5 in u230 do
        if i5.UseNum then
            v1 = u230[m]
            v1.UseNum = 0
            u0.UpdateOreButton(m)
        end
    end
end

function u0.OpenConfigType(a1) -- Line: 585
    -- upvalues: u231 (ref), Helper_2 (val), Helper_3 (val), ScrollingFrame_2 (val), Bottom_2 (val), AnyHelper (val)
    -- upvalues: u0 (val), u227 (val), u229 (ref), GetOreTab (val)
    local Anniu, Anniu1, Frame, IDList, Lock, Name, Size, Type, UIGridLayout, UIGridLayout_2, bai, huang, v1, v2, v3, v4, v5, v6, v7, v8, v9
    u231 = a1
    local v10 = {}
    if a1 == "Weapon" then
        for k, n in (Helper_2.GetForgeTypes()) do
            v10[k] = {}
            v10[k].Type = n
            v10[k].IDList = Helper_2.GetForgeWeaponsByForgeType(n)
        end
    elseif a1 == "Armor" then
        for i, j in (Helper_3.GetForgeTypes()) do
            v10[i] = {}
            v10[i].Type = j
            v10[i].IDList = Helper_3.GetForgeArmorsByForgeType(j)
        end
    end
    for m, i5 in ScrollingFrame_2:GetChildren() do
        if i5:IsA("Frame") then
            i5:Destroy()
        end
    end
    for i6, i7 in Bottom_2:GetChildren() do
        if i7:IsA("TextButton") then
            Name = i7.Name
            Anniu = i7:WaitForChild("Anniu")
            Anniu.Visible = u231 ~= Name
            Anniu1 = i7:WaitForChild("Anniu1")
            Anniu1.Visible = u231 == Name
        end
    end
    local v11 = nil
    local v12 = nil
    for i8, i9 in v10, v11, v12 do
        Type = i9.Type
        IDList = i9.IDList
        v9 = AnyHelper.GetDisName(a1, Type)
        v1 = (ScrollingFrame_2:WaitForChild("Temple")):WaitForChild("Temple_Top"):Clone()
        v2 = (ScrollingFrame_2:WaitForChild("Temple")):WaitForChild("Temple_Main"):Clone()
        v1.Parent = ScrollingFrame_2
        v2.Parent = ScrollingFrame_2
        v1.Name = Type .. "-Top"
        v2.Name = Type .. "-Main"
        v1.LayoutOrder = i8 * 2
        v2.LayoutOrder = i8 * 2 + 1
        v1.Visible = true
        v2.Visible = true
        for i10, i11 in v2:WaitForChild("PetInfo"):GetChildren() do
            if i11:IsA("TextButton") then
                i11:Destroy()
            end
        end
        bai = v1:WaitForChild("bai")
        bai:WaitForChild("TextLabel").Text = v9
        huang = v1:WaitForChild("huang")
        huang:WaitForChild("TextLabel").Text = v9
        Size = v2.Size
        v3 = math.ceil(#IDList / 4)
        v2.Size = UDim2.fromScale(Size.X.Scale, v3 * 0.15)
        UIGridLayout = (v2:WaitForChild("PetInfo")):WaitForChild("UIGridLayout")
        UIGridLayout.CellSize = UDim2.fromScale(0.25, 0.8 / v3)
        UIGridLayout_2 = (v2:WaitForChild("PetInfo")):WaitForChild("UIGridLayout")
        UIGridLayout_2.CellPadding = UDim2.fromScale(0, 0.2 / v3)
        v4 = {}
        v5 = nil
        v6 = nil
        for i12, i13 in IDList, v5, v6 do
            if a1 ~= "Weapon" then
                if a1 ~= "Armor" or Helper_3.GetTLevel(i13) then
                    v7 = AnyHelper.GetImage(a1, i13) or ""
                    v8 = (ScrollingFrame_2:WaitForChild("Temple")):WaitForChild("Temple_Button"):Clone()
                    v8.Parent = v2:WaitForChild("PetInfo")
                    v8.Visible = true
                    v8.Name = i13
                    table.insert(v4, {Frame = v8, Price = AnyHelper.GetSellPrice(a1, i13) or 0})
                    Frame = v8:WaitForChild("Frame")
                    Frame:WaitForChild("ImageLabel").Image = v7
                    Lock = v8:WaitForChild("Lock")
                    Lock.Visible = false
                end
            elseif Helper_2.GetTLevel(i13) then
                v7 = AnyHelper.GetImage(a1, i13) or ""
                v8 = (ScrollingFrame_2:WaitForChild("Temple")):WaitForChild("Temple_Button"):Clone()
                v8.Parent = v2:WaitForChild("PetInfo")
                v8.Visible = true
                v8.Name = i13
                table.insert(v4, {Frame = v8, Price = AnyHelper.GetSellPrice(a1, i13) or 0})
                Frame = v8:WaitForChild("Frame")
                Frame:WaitForChild("ImageLabel").Image = v7
                Lock = v8:WaitForChild("Lock")
                Lock.Visible = false
            end
        end
        table.sort(v4, function(a1, a2) -- Line: 689
            return a1.Price < a2.Price
        end)
        for i14, i15 in v4 do
            i15.Frame.LayoutOrder = i14
        end
    end
    u0.UpdateLeft()
    v12 = 0
    for i16, i17 in u229 do
        if i17 and i17.Number then
            v12 = v12 + i17.Number
        end
    end
    u227:Fire(v12, u231, (GetOreTab()))
end

function u0.open() -- Line: 700
    -- upvalues: u232 (ref), UIController (val), Forge (val), u0 (val), u258 (val), LocalPlayer (val), SoundPlayer (val)
    -- upvalues: LocalPlayerUtils (val), UIVFX (val)
    if u232 then
        return
    end
    u232 = true
    UIController.OpenScreenMain(Forge.Name)
    u0.CleanOreList()
    u0.OpenConfigType("Weapon")
    u0.update()
    u258:play(true)
    local HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    HumanoidRootPart.Anchored = true
    task.delay(0.1, function() -- Line: 710 -- upvalues: SoundPlayer (upval)
        SoundPlayer.playSound("LineSFX")
    end)
    LocalPlayerUtils.DisablePlrAction(true)
    UIVFX.Enabled = false
end

function u0.close() -- Line: 717
    -- upvalues: u232 (ref), SoundPlayer (val), u0 (val), UIController (val), Forge (val), u258 (val), u261 (val)
    -- upvalues: CameraUtils (val), LocalPlayer (val), LocalPlayerUtils (val), UIVFX (val)
    if not u232 then
        return
    end
    u232 = false
    SoundPlayer.playSound("LineSFX")
    u0.CleanOreList()
    UIController.CloseScreenMain(Forge.Name)
    if u258.isPlaying then
        u258.stop(u258)
    end
    u261:play(true)
    u261.wait(u261)
    u261:reset()
    CameraUtils.BackToPlr(0)
    local HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    HumanoidRootPart.Anchored = false
    LocalPlayerUtils.EnablePlrAction(true)
    UIVFX.Enabled = true
end

function PlayForgeAnim(a1) -- Line: 739
    -- upvalues: Helper_2 (val), ReplicatedStorage (val), VFXSuit (val), Sequence (val), Pivot (val), TextureUtils (val)
    -- upvalues: Pivot_2 (val), LocalPlayer (val), ForgeTable (val), u258 (val), UIController (val), Forge (val)
    -- upvalues: Moon2Cutscene (val), Forge_002 (val), TimeListFunc (val), SoundPlayer (val), PemData (val), Skip (val)
    -- upvalues: MarketplaceService (val), Monetization (val), SkipForging (val), u229 (ref), ModelVFXUtils (val)
    -- upvalues: Info (val)
    local v1
    local v2 = a1[1]
    local v3 = a1[2]
    workspace:SetAttribute("ForgeAnimation", true)
    local ID = v2.ID
    local v4 = if v2.Type ~= "Weapon" then ReplicatedStorage.Assets.Armor:WaitForChild(ID) else (ReplicatedStorage.Assets.Weapon:WaitForChild((Helper_2.GetSmallType(ID)))):WaitForChild(ID)
    VFXSuit.EnableBeam((Sequence:WaitForChild("Beam")):WaitForChild("Solution"))
    local u51 = v4:Clone()
    u51.Parent = Sequence:WaitForChild("Model")
    u51.Name = "Light"
    for i, j in u51:GetDescendants() do
        if j:IsA("BasePart") then
            j.Anchored = true
        end
    end
    u51:PivotTo(Pivot)
    local v5 = u51.PrimaryPart.PivotOffset * CFrame.Angles(0, 3.141592653589793, 0)
    u51.PrimaryPart.PivotOffset = v5
    u51:ScaleTo((u51:GetScale()) * 0.8)
    TextureUtils.SetFullTexture(u51, ReplicatedStorage.Assets.MoonAnim:WaitForChild("Lava"))
    local u105 = v4:Clone()
    u105.Parent = Sequence:WaitForChild("试用（正式会删除）")
    u105.Name = "LJ_15"
    for k, n in u105:GetDescendants() do
        if n:IsA("BasePart") then
            n.Anchored = true
        end
    end
    local v6 = u105.PrimaryPart.PivotOffset * CFrame.Angles(0, 3.141592653589793, 0)
    u105.PrimaryPart.PivotOffset = v6
    u105:PivotTo(Pivot_2)
    u105.PrimaryPart.Anchored = true
    u105:ScaleTo((u105:GetScale()) * 0.8)
    ReplicatedStorage.Assets.MoonAnim:WaitForChild("Highlight"):Clone().Parent = u105
    local Character = LocalPlayer.Character
    if Character then
        Character:PivotTo(ForgeTable:WaitForChild("CharWatch").CFrame)
    end
    if u258.isPlaying then
        u258.stop(u258)
    end
    UIController.CloseScreenMain(Forge.Name, true)
    local u183 = Moon2Cutscene.new(Forge_002)
    local VFX = Sequence:WaitForChild("VFX")
    local u191 = TimeListFunc.new()
    u191:AddTickFunc(0.5833333333333334, function() -- Line: 805 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("Flame"))
        SoundPlayer.playSound("Flame")
    end)
    u191:AddTickFunc(4.166666666666667, function() -- Line: 809 -- upvalues: SoundPlayer (upval)
        SoundPlayer.playSound("magma")
    end)
    u191:AddTickFunc(8.083333333333334, function() -- Line: 813 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("Explosion"))
        SoundPlayer.playSound("blow up")
    end)
    u191:AddTickFunc(9.216666666666667, function() -- Line: 817 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("knock"))
        SoundPlayer.playSound("Forging_02")
    end)
    u191:AddTickFunc(9.5, function() -- Line: 821 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("knock"))
        SoundPlayer.playSound("Forging_02")
    end)
    u191:AddTickFunc(9.833333333333334, function() -- Line: 825 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("knock"))
        SoundPlayer.playSound("Forging_02")
    end)
    u191:AddTickFunc(10.166666666666666, function() -- Line: 829 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("knock"))
        SoundPlayer.playSound("Forging_02")
    end)
    u191:AddTickFunc(10.666666666666666, function() -- Line: 833 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("knock_1"))
        SoundPlayer.playSound("Forging_02")
    end)
    u191:AddTickFunc(12.15, function() -- Line: 837 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("Steam"))
        SoundPlayer.playSound("Steam")
    end)
    u191:AddTickFunc(14.316666666666666, function() -- Line: 841 -- upvalues: VFXSuit (upval), VFX (val), SoundPlayer (upval)
        VFXSuit.EmitByPart(VFX:WaitForChild("Rainbow"))
        SoundPlayer.playSound("Appear")
    end)
    u191:StartTimeList()
    u183:play(true)
    if not PemData.isHavePem("SkipForge") then
        SkipForging.Visible = true
        v1 = (SkipForging:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 866
            -- upvalues: PemData (upval), u183 (val), u191 (val), Skip (upval), MarketplaceService (upval)
            -- upvalues: LocalPlayer (upval), Monetization (upval)
            if not PemData.isHavePem("SkipForge") then
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, Monetization.Gamepasses.SkipForge.Id)
                return
            end
            u183.timeElapsed = 850
            u183:setFrame(850)
            u191:SetTime(14.166666666666666)
            Skip.Visible = false
        end)
    else
        Skip.Visible = true
        v1 = Skip.MouseButton1Down:Connect(function() -- Line: 853
            -- upvalues: PemData (upval), u183 (val), u191 (val), Skip (upval), MarketplaceService (upval)
            -- upvalues: LocalPlayer (upval), Monetization (upval)
            if not PemData.isHavePem("SkipForge") then
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, Monetization.Gamepasses.SkipForge.Id)
                return
            end
            u183.timeElapsed = 850
            u183:setFrame(850)
            u191:SetTime(14.166666666666666)
            Skip.Visible = false
        end)
    end
    task.delay(1, function() -- Line: 881 -- upvalues: u229 (upval), ModelVFXUtils (upval)
        local TWTransparency, v1
        local v2 = nil
        local v3 = nil
        for i, j in u229, v2, v3 do
            if j.OreModelList then
                for k, n in j.OreModelList do
                    if n and n.Parent then
                        TWTransparency = ModelVFXUtils.TWTransparency
                        v1 = TweenInfo.new(2)
                        TWTransparency(n, v1, 1)
                    end
                end
            end
        end
    end)
    u183:wait()
    v1:Disconnect()
    Skip.Visible = false
    SkipForging.Visible = false
    task.wait(1)
    ShowForgeResult(v2, v3)
    task.wait(1)
    local ClickAnyWhere = Info:WaitForChild("ClickAnyWhere")
    ClickAnyWhere.Visible = true
    local u316 = nil

    local function CloseResult() -- Line: 907
        -- upvalues: u316 (ref), ClickAnyWhere (val), u183 (val), u258 (upval), UIController (upval), Forge (upval)
        -- upvalues: u105 (val), u51 (val), VFXSuit (upval), Sequence (upval)
        u316:Disconnect()
        ClickAnyWhere.Visible = false
        CloseForgeResult()
        u183:reset()
        u258:play(true)
        UIController.OpenScreenMain(Forge.Name)
        u105:Destroy()
        u51:Destroy()
        VFXSuit.DisableBeam((Sequence:WaitForChild("Beam")):WaitForChild("Solution"))
        workspace:SetAttribute("ForgeAnimation", nil)
    end

    local v7 = ClickAnyWhere.MouseButton1Down:Connect(function() -- Line: 920 -- upvalues: CloseResult (val)
        CloseResult()
    end)
end

function ShowForgeResult(a1, a2) -- Line: 925
    -- upvalues: Helper_2 (val), u219 (ref), Info (val), AnyHelper (val), Helper_3 (val), Helper (val)
    -- upvalues: AbbreviateNumber (val), Helper_4 (val), RichTextUtils (val), TweenService (val)
    local v1, v2, v3, v4
    local ID = a1.ID
    local Type = a1.Type
    local v5 = if Type ~= "Hat" then Type else "Armor"
    if Type ~= "Weapon" then
        v3 = Helper_3.GetMainAffix(ID)
        u219 = Info:WaitForChild("Equipment")
        v4 = AnyHelper.GetDisName(v5, Type)
    else
        v3 = Helper_2.GetMainAffix(ID)
        u219 = Info:WaitForChild("Weapon")
        v4 = AnyHelper.GetDisName(v5, Helper_2.GetSmallType(ID))
    end
    u219.Visible = true
    local xinxi = u219:WaitForChild("xinxi")
    local tx = (xinxi:WaitForChild("1")):WaitForChild("tx")
    local tx1 = (xinxi:WaitForChild("1")):WaitForChild("tx1")
    local BG = (xinxi:WaitForChild("1")):WaitForChild("BG")
    local v6 = AnyHelper.GetSellPrice(v5, ID)
    local v7 = AnyHelper.GetImage(v5, ID) or ""
    local v8 = Helper.GetTextRarity(AnyHelper.GetRarity(v5, ID))
    local v9 = AnyHelper.GetDisName(v5, ID) or ""
    local v10, v11 = a1, a2
    for i, j in BG:WaitForChild("BG"):GetChildren() do
        if j:IsA("Frame") then
            v1 = j.Name == v8
            j.Visible = v1
        end
    end
    local Info_2 = BG:WaitForChild("Info")
    Info_2:WaitForChild("ImageLabel").Image = v7
    local EnchanceNum = v10.EnchanceNum
    local Button = (BG:WaitForChild("Info")):WaitForChild("Button")
    if not EnchanceNum then
        Button.Visible = false
    else
        local Icon, Name, v12
        Button.Visible = true
        for k, n in Button:GetChildren() do
            if n:IsA("TextButton") then
                Name = n.Name
                v12 = tonumber((Name:sub(Name:len(), (Name:len())))) <= EnchanceNum
                n.Visible = v12
                Icon = ((n:WaitForChild("Bg")):WaitForChild("Bg")):WaitForChild("Icon")
                Icon.Image = ""
            end
        end
    end
    local Name_2 = tx1:WaitForChild("Name")
    Name_2:WaitForChild("TextLabel").Text = v9
    local Rarity = tx1:WaitForChild("Rarity")
    Rarity:WaitForChild("TextLabel").Text = v8
    local TextLabel = (tx1:WaitForChild("Price")):WaitForChild("TextLabel")
    TextLabel.Text = AbbreviateNumber(v6)
    local Class = tx1:WaitForChild("Class")
    Class:WaitForChild("TextLabel").Text = v4
    for m, i5 in (tx1:WaitForChild("Rarity")):WaitForChild("TextLabel"):GetChildren() do
        if i5:IsA("UIGradient") then
            v2 = i5.Name == v8
            i5.Enabled = v2
        end
    end
    if Type == "Weapon" then
        local TextLabel_2 = (tx:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_2.Text = "Power"
        local TextLabel_3 = (tx1:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_3.Text = ("+%*"):format((AbbreviateNumber(v3)))
    elseif Type == "Hat" then
        local TextLabel_4 = (tx:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_4.Text = "Power"
        local TextLabel_5 = (tx1:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_5.Text = ("+%*%%"):format((math.round(v3 * 100)))
    elseif Type == "Armor" then
        local TextLabel_6 = (tx:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_6.Text = "Defence"
        local TextLabel_7 = (tx1:WaitForChild("Power")):WaitForChild("TextLabel")
        TextLabel_7.Text = ("+%*%%"):format((math.round(v3 * 100)))
    end
    if v5 == "Weapon" then
        local ID_2 = v10.SkillList[1].ID
        local v13 = Helper_4.GetImage(ID_2) or ""
        local v14 = Helper_4.GetDescription(ID_2)
        local v15 = Helper_4.GetSkillLevelImage((Helper_4.GetSkillLevel(ID_2)))
        v2 = Helper_4.GetSkillCD(ID_2)
        local Bg_3 = (xinxi:WaitForChild("2")):WaitForChild("Bg")
        Bg_3:WaitForChild("ImageLabel").Image = v13
        local Level = ((xinxi:WaitForChild("2")):WaitForChild("Bg")):WaitForChild("Level")
        Level:WaitForChild("ImageLabel").Image = v15
        local v16 = (xinxi:WaitForChild("2")):WaitForChild("2")
        v16.Text = v14 .. ("CD:%*"):format((RichTextUtils.RichToColor(("%*s"):format(v2), (Color3.fromRGB(0, 255, 0)))))
    end
    local UIScale = u219:FindFirstChild("UIScale")
    UIScale.Scale = 0.1
    TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    local u448 = {
        Name = 1,
        Class = 2,
        Rarity = 3,
        Power = 4,
        Price = 5,
    }
    task.spawn(function() -- Line: 1047 -- upvalues: tx (val), u448 (val), TweenService (upval), tx1 (val)
        for i, j in tx:GetChildren() do
            if j:IsA("Frame") and j:FindFirstChild("TextLabel") then
                local TextLabel_2 = j:FindFirstChild("TextLabel")
                TextLabel_2.Position = UDim2.fromScale(1.5, 0.5)
                task.delay(0.8 + u448[j.Name] * 0.2, function() -- Line: 1053 -- upvalues: TweenService (upval), TextLabel_2 (val)
                    TweenService:Create(
                        TextLabel_2,
                        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.fromScale(0.5, 0.5)}
                    ):Play()
                end)
            end
        end
        for k, n in tx1:GetChildren() do
            if n:IsA("Frame") and n:FindFirstChild("TextLabel") then
                local TextLabel = n:FindFirstChild("TextLabel")
                TextLabel.Position = UDim2.fromScale(-0.5, 0.5)
                task.delay(0.8 + u448[n.Name] * 0.2, function() -- Line: 1066 -- upvalues: TweenService (upval), TextLabel (val)
                    TweenService:Create(
                        TextLabel,
                        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.fromScale(0.5, 0.5)}
                    ):Play()
                end)
            end
        end
    end)
    v11 = not not v11
    local Top = u219:WaitForChild("Top")
    Top.Visible = not v11
end

function CloseForgeResult() -- Line: 1083 -- upvalues: u219 (ref)
    u219.Visible = false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.GearPackGUI
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.GearPackGUI
-- Decompile time: 9.99 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
local Main = PlayerGui:WaitForChild("Main")
PlayerGui:WaitForChild("Hud")
local Info = PlayerGui:WaitForChild("Info")
local Message = require(ReplicatedStorage.GuiUtils.Message)
require(ReplicatedStorage.GuiUtils.RewardShow)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.TimeFormatUntil)
require(ReplicatedStorage.Utils.CommunicationUtils)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local MarketUtils = require(ReplicatedStorage.Utils.MarketUtils)
require(ReplicatedStorage.Config.GameSetting)
require(ReplicatedStorage.Config.Monetization)
require(ReplicatedStorage.Config.Weapon.Helper)
require(ReplicatedStorage.Config.PlrSkill.Helper)
local Helper = require(ReplicatedStorage.Config.Limited.Helper)
require(ReplicatedStorage.LocalData.PemData)
local SkillShowGUI = require(ReplicatedStorage.GuiUtils.SkillShowGUI)
local AnyInfoGUI = require(ReplicatedStorage.GuiUtils.AnyInfoGUI)
local GreaPack_2 = Main:WaitForChild("GreaPack_2")
local TextButton = (GreaPack_2:WaitForChild("De")):WaitForChild("TextButton")
local Button = ((GreaPack_2:WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("Button")
local LIWU = ((GreaPack_2:WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("LIWU")
Info:WaitForChild("AnyInfoSmall")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local getDianDianNumber = AbbNumber.getDianDianNumber
local GearSet_2 = (workspace:WaitForChild("LimitedFolder")):WaitForChild("GearSet_2")

function u0.start() -- Line: 52 -- upvalues: u0 (val), TextButton (val), Helper (val), GearSet_2 (val), GreaPack_2 (val)
    u0.updateGearPack_2()
    TextButton.MouseButton1Down:Connect(function() -- Line: 55 -- upvalues: u0 (upval)
        u0.close()
    end)
    local GearSet_2_2 = (Helper.GetConfig()).GearSet_2

    local function UpdLimited() -- Line: 61 -- upvalues: GearSet_2 (upval), GearSet_2_2 (val), GreaPack_2 (upval)
        local v1 = GearSet_2_2 - GearSet_2.Value
        if v1 < 0 then
            v1 = 0
        end
        local TextLabel = (((GreaPack_2:WaitForChild("Main")):WaitForChild("Frame")):WaitForChild("Limited")):WaitForChild("TextLabel")
        TextLabel.Text = ("Limited:%*/%*"):format(v1, GearSet_2_2)
    end

    GearSet_2.Changed:Connect(function(a1) -- Line: 72 -- upvalues: UpdLimited (val)
        UpdLimited()
    end)
    UpdLimited()
end

function u0.open() -- Line: 78 -- upvalues: UIController (val), GreaPack_2 (val)
    UIController.openScreen(GreaPack_2.Name)
end

function u0.close() -- Line: 81 -- upvalues: UIController (val), GreaPack_2 (val)
    UIController.closeScreen(GreaPack_2.Name)
end

function u0.updateGearPack_2() -- Line: 85
    -- upvalues: GreaPack_2 (val), Button (val), GearSet_2 (val), Message (val), MarketUtils (val), LIWU (val)
    -- upvalues: AnyInfoGUI (val), RichTextUtils (val), SkillShowGUI (val)
    local Frame = (GreaPack_2:WaitForChild("Main")):WaitForChild("Frame")
    Button.MouseButton1Down:Connect(function() -- Line: 90 -- upvalues: GearSet_2 (upval), Message (upval), MarketUtils (upval)
        if 500 <= GearSet_2.Value then
            Message.showMessage("Out of stock")
            return
        end
        MarketUtils.TryBuy("GearSet_2")
    end)
    LIWU.MouseButton1Down:Connect(function() -- Line: 98 -- upvalues: GearSet_2 (upval), Message (upval), MarketUtils (upval)
        if 500 <= GearSet_2.Value then
            Message.showMessage("Out of stock")
            return
        end
        MarketUtils.OpenGiftUI("GearSet_2")
    end)
    local Val = (Button:WaitForChild("Frame")):WaitForChild("Val")
    Val.Text = MarketUtils.GetCost("GearSet_2")
    local Weapon = (Frame:WaitForChild("PetInfo")):WaitForChild("Weapon")
    local Hat = (Frame:WaitForChild("PetInfo")):WaitForChild("Hat")
    local Armor = (Frame:WaitForChild("PetInfo")):WaitForChild("Armor")
    local Other = (Frame:WaitForChild("PetInfo")):WaitForChild("Other")
    ;(Weapon:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 119 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_2_Weapon")
    end)
    ;(Hat:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 122 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_2_Hat")
    end)
    ;(Armor:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 125 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_2_Armor")
    end)
    AnyInfoGUI.LoadFrame(Weapon, {Type = "Weapon", ID = "G_1002"})
    AnyInfoGUI.LoadFrame(Hat, {Type = "Hat", ID = "HHat_1002"})
    AnyInfoGUI.LoadFrame(Armor, {Type = "Armor", ID = "HArmor_1002"})
    AnyInfoGUI.LoadFrame(Other, {
        Text = ("Race Roll %*."):format((RichTextUtils.RichToColor("x25", (Color3.fromRGB(0, 255, 0))))),
    })
    AnyInfoGUI.LoadFrame(Weapon:WaitForChild("Name"), {Type = "Weapon", ID = "G_1002"})
    AnyInfoGUI.LoadFrame(Hat:WaitForChild("Name"), {Type = "Hat", ID = "HHat_1002"})
    AnyInfoGUI.LoadFrame(Armor:WaitForChild("Name"), {Type = "Armor", ID = "HArmor_1002"})
    AnyInfoGUI.LoadFrame(Other:WaitForChild("Name"), {
        Text = ("Race Roll %*."):format((RichTextUtils.RichToColor("x25", (Color3.fromRGB(0, 255, 0))))),
    })
    ;((Frame:WaitForChild("Skill")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 149 -- upvalues: SkillShowGUI (upval)
        SkillShowGUI.StartShowSkill("G_Skill_1001")
    end)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.IndexGUI
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.IndexGUI
-- Decompile time: 24.33 ms

local u0 = {}
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local Index = ((Hud:WaitForChild("Left")):WaitForChild("Buttons")):WaitForChild("Index")
local Index_2 = Main:WaitForChild("Index")
local Left = Index_2:WaitForChild("Left")
local zheng = Index_2:WaitForChild("zheng")
local Shang = (zheng:WaitForChild("Shuxing")):WaitForChild("Shang")
local ScrollingFrame = ((zheng:WaitForChild("wuqi")):WaitForChild("Bg")):WaitForChild("ScrollingFrame")
local TextButton = (Index_2:WaitForChild("De")):WaitForChild("TextButton")
local UIController = require(ReplicatedStorage.Utils.UIController)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Config.Monetization)
require(ReplicatedStorage.GuiUtils.Message)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local Trove = require(ReplicatedStorage.Packages.Trove)
local IndexData = require(ReplicatedStorage.LocalData.IndexData)
local Helper = require(ReplicatedStorage.Config.Index.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Weapon.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Armor.Helper)
local Helper_4 = require(ReplicatedStorage.Config.Ore.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper_5 = require(ReplicatedStorage.Config.Rarity.Helper)
local UIVFXUtils = require(ReplicatedStorage.GuiUtils.UIVFXUtils)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local getDianDianNumber = AbbNumber.getDianDianNumber
local u166 = nil
local u167 = nil
Trove.new()

function ClaimIndexVFX(a1) -- Line: 69 -- upvalues: SoundPlayer (val), UIVFXUtils (val)
    SoundPlayer.playSound("Reward_Index")
    UIVFXUtils.UnlockIndexVFX(a1)
end

function u0.init() end

function u0.start() -- Line: 78 -- upvalues: u0 (val)
    u0.StartChangeButtons()
    u0.StartRightInfo()
    u0.StartOther()
    u0.StartIndexFrame()
    u0.OpenScroFrame("Weapon")
    u0.update()
end

function u0.StartChangeButtons() -- Line: 89 -- upvalues: Left (val), u0 (val)
    for i, j in Left:GetChildren() do
        if j:IsA("TextButton") then
            j.MouseButton1Down:Connect(function() -- Line: 92 -- upvalues: u0 (upval), j (val)
                u0.OpenScroFrame(j.Name)
            end)
        end
    end
end

function u0.StartIndexFrame() -- Line: 99
    -- upvalues: ScrollingFrame (val), Helper_2 (val), Helper_3 (val), Helper_4 (val), Helper_5 (val), AnyHelper (val)
    -- upvalues: Helper (val), u167 (ref), u0 (val), IndexData (val)
    local Exp, Info, TextLabel, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    local v11 = {
        Weapon = Helper_2.GetConfig(),
        Armor = Helper_3.GetConfig(),
        Ore = Helper_4.GetConfig(),
    }
    local v12 = nil
    local v13 = nil
    for k, n in v11, v12, v13 do
        v8 = {}
        v9 = nil
        v10 = nil
        for m, i5 in n, v9, v10 do
            v1 = Helper_5.GetTextRarity(AnyHelper.GetRarity(k, m))
            v2 = AnyHelper.GetImage(k, m) or ""
            v3 = AnyHelper.GetSellPrice(k, m) or 0
            if k ~= "Armor" then
                u99 = k
            else
                local u99 = Helper_3.GetBigType(m)
            end
            local u106 = Helper.GetIndexID(u99, m)
            v4 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild(v1):Clone()
            v4.Name = u106
            v4.Visible = true
            v4.Parent = ScrollingFrame
            v4:SetAttribute("Type", u99)
            v4:SetAttribute("OriDisName", AnyHelper.GetDisName(k, m) or "")
            v5 = 0
            if k == "Weapon" then
                v6 = Helper_2.GetSmallType(m)
                if v6 == "Katana" then
                    v5 = 1
                elseif v6 == "Great" then
                    v5 = 2
                end
            elseif k == "Armor" then
                v6 = Helper_3.GetSmallType(m)
                if v6 ~= "Light" then
                    if v6 ~= "Light" then
                        if v6 ~= "Heave" then
                            if v6 == "Heave" and u99 == "Armor" then
                                v5 = 4
                            end
                        elseif u99 == "Hat" then
                            v5 = 3
                        elseif v6 == "Heave" and u99 == "Armor" then
                            v5 = 4
                        end
                    elseif u99 == "Armor" then
                        v5 = 2
                    elseif v6 ~= "Heave" then
                        if v6 == "Heave" and u99 == "Armor" then
                            v5 = 4
                        end
                    elseif u99 == "Hat" then
                        v5 = 3
                    elseif v6 == "Heave" and u99 == "Armor" then
                        v5 = 4
                    end
                elseif u99 == "Hat" then
                    v5 = 1
                elseif v6 ~= "Light" then
                    if v6 ~= "Heave" then
                        if v6 == "Heave" and u99 == "Armor" then
                            v5 = 4
                        end
                    elseif u99 == "Hat" then
                        v5 = 3
                    elseif v6 == "Heave" and u99 == "Armor" then
                        v5 = 4
                    end
                elseif u99 == "Armor" then
                    v5 = 2
                elseif v6 ~= "Heave" then
                    if v6 == "Heave" and u99 == "Armor" then
                        v5 = 4
                    end
                elseif u99 == "Hat" then
                    v5 = 3
                elseif v6 == "Heave" and u99 == "Armor" then
                    v5 = 4
                end
            end
            table.insert(v8, {
                Frame = v4,
                RarityLayout = Helper_5.GetRarityLevel(v1),
                TypeLayout = v5,
                PriceLayout = v3,
            })
            local Button = v4:WaitForChild("Button")
            Info = Button:WaitForChild("Info")
            Info:WaitForChild("ImageLabel").Image = v2
            Exp = Button:WaitForChild("Exp")
            Exp.Visible = false
            Button.MouseButton1Down:Connect(function() -- Line: 168
                -- upvalues: u167 (upval), u106 (val), u0 (upval), IndexData (upval), u99 (ref), m (val), Button (val)
                u167 = u106
                u0.UpdateIndex()
                if not IndexData.IsUnlocked(u99, m) then
                    return
                end
                if IndexData.IsUnlocked(u99, m)
                    and not IndexData.IsClaimed(u99, m)
                    and IndexData.TryClaimedExp(u99, m) then
                    ClaimIndexVFX(Button:WaitForChild("Exp"))
                end
            end)
            v7 = Helper.GetRarityExp(v1)
            TextLabel = (Button:WaitForChild("Exp")):WaitForChild("TextLabel")
            TextLabel.Text = ("+%*EXP"):format(v7)
        end
        table.sort(v8, function(a1, a2) -- Line: 192
            if a1.RarityLayout ~= a2.RarityLayout then
                return a1.RarityLayout < a2.RarityLayout
            end
            if a1.TypeLayout ~= a2.TypeLayout then
                return a1.TypeLayout < a2.TypeLayout
            end
            return a1.PriceLayout < a2.PriceLayout
        end)
        for i6, i7 in v8 do
            i7.Frame.LayoutOrder = i6
        end
    end
end

function u0.StartRightInfo() -- Line: 210
    -- upvalues: LocalPlayer (val), Players (val), Shang (val), IndexData (val), SoundPlayer (val)
    local UserThumbnailAsync = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    local Ship = ((Shang:WaitForChild("Head")):WaitForChild("Head")):WaitForChild("Ship")
    Ship:WaitForChild("Icon").Image = UserThumbnailAsync
    local Tex = ((Shang:WaitForChild("Head")):WaitForChild("Name")):WaitForChild("Tex")
    Tex.Text = LocalPlayer.DisplayName
    ;(((((Shang:WaitForChild("Reward")):WaitForChild("Info")):WaitForChild("Buttons")):WaitForChild("Button")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 222 -- upvalues: IndexData (upval), SoundPlayer (upval)
        if IndexData.TryClaimedLevel() then
            SoundPlayer.playSound("IndexUp")
        end
    end)
end

function u0.StartOther() -- Line: 229 -- upvalues: Index (val), u0 (val), TextButton (val), IndexData (val)
    Index.MouseButton1Down:Connect(function() -- Line: 230 -- upvalues: u0 (upval)
        u0.open()
    end)
    TextButton.MouseButton1Down:Connect(function() -- Line: 233 -- upvalues: u0 (upval)
        u0.close()
    end)
    IndexData.AddCallback(function() -- Line: 236 -- upvalues: u0 (upval)
        u0.update()
    end)
end

function u0.update() -- Line: 241 -- upvalues: IndexData (val), u0 (val)
    local v1 = IndexData.GetData()
    u0.UpdateIndex(v1)
    u0.UpdateRightInfo(v1)
end

function u0.UpdateIndex(a1) -- Line: 248
    -- upvalues: IndexData (val), Helper_2 (val), Helper_3 (val), Helper_4 (val), Left (val), Index (val)
    -- upvalues: ScrollingFrame (val), u166 (ref), u167 (ref)
    local Attribute, Attribute_2, Button, Exp, ImageLabel, Info_2, Name, New_2, New_3, New_4, New_5, TextLa, v1, v2, v3, v4, v5
    if not a1 then
        v1 = IndexData.GetData()
    end
    v1 = {
        Weapon = Helper_2.GetConfig(),
        Armor = Helper_3.GetConfig(),
        Ore = Helper_4.GetConfig(),
    }
    for i, j in Left:GetChildren() do
        if j:IsA("TextButton") then
            New_5 = j:WaitForChild("New")
            New_5.Visible = false
        end
    end
    local New = Index:WaitForChild("New")
    New.Visible = false
    for k, n in ScrollingFrame:GetChildren() do
        if n:IsA("Frame") then
            Name = n.Name
            Attribute = n:GetAttribute("Type")
            Button = n:WaitForChild("Button")
            v2 = false
            if u166 == Attribute then
                v2 = u167 == Name
            end
            v3 = IndexData.IsUnlocked(Name)
            v4 = IndexData.IsClaimed(Name)
            Attribute_2 = n:GetAttribute("OriDisName")
            ImageLabel = (Button:WaitForChild("Info")):WaitForChild("ImageLabel")
            v5 = v3 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
            ImageLabel.ImageColor3 = v5
            Info_2 = Button:WaitForChild("Info")
            Info_2:WaitForChild("zhong").Visible = v2
            TextLa = (Button:WaitForChild("Info")):WaitForChild("TextLa")
            TextLa.Text = v3 and Attribute_2 or "???"
            if v3 and not v4 then
                Exp = Button:WaitForChild("Exp")
                Exp.Visible = true
            end
            New_2 = Button:WaitForChild("New")
            New_2.Visible = not v4 and v3
            if not v4 and v3 then
                New_3 = (Left:FindFirstChild(Attribute)):WaitForChild("New")
                New_3.Visible = true
                New_4 = Index:WaitForChild("New")
                New_4.Visible = true
            end
        end
    end
end

function u0.UpdateRightInfo(a1) -- Line: 302
    -- upvalues: IndexData (val), Shang (val), Helper (val), AbbreviateNumber (val), GameSetting (val)
    local v1
    if not a1 then
        a1 = IndexData.GetData()
    end
    local Head = Shang:WaitForChild("Head")
    local Reward = Shang:WaitForChild("Reward")
    local level = a1.level
    local exp = a1.exp
    local v2 = Helper.GetMaxTitleLevel(level)
    local v3 = Helper.GetTitleText(v2) or ""
    for i, j in Head:WaitForChild("Title"):GetChildren() do
        if j:IsA("TextLabel") then
            v1 = j.Name == tostring(v2)
            j.Visible = v1
            if j.Name == tostring(v2) then
                j.Text = v3
            end
        end
    end
    local v4 = Helper.GetNeedExp(level + 1)
    if not v4 then
        local num = ((Head:WaitForChild("Bar")):WaitForChild("1")):WaitForChild("num")
        num.Text = "Max Level!"
        local Bar_5 = (((((Head:WaitForChild("Bar")):WaitForChild("2")):WaitForChild("Top")):WaitForChild("Bar")):WaitForChild("Bar")):WaitForChild("Bar")
        Bar_5.Size = UDim2.fromScale(1, 1)
        local TextLabel = (((((Head:WaitForChild("Bar")):WaitForChild("2")):WaitForChild("Top")):WaitForChild("Bar")):WaitForChild("Bar")):WaitForChild("TextLabel")
        TextLabel.Text = ("XP:%*"):format((AbbreviateNumber(exp)))
        local Lock = Reward:WaitForChild("Lock")
        Lock.Visible = true
        local Buttons = (Reward:WaitForChild("Info")):WaitForChild("Buttons")
        Buttons.Visible = false
        local Icon_3 = (((((Reward:WaitForChild("Info")):WaitForChild("Icon")):WaitForChild("Icon")):WaitForChild("Button")):WaitForChild("Info")):WaitForChild("Icon")
        Icon_3.Image = ""
        return
    end
    local v5 = math.clamp(exp / v4, 0, 1)
    local num_2 = ((Head:WaitForChild("Bar")):WaitForChild("1")):WaitForChild("num")
    num_2.Text = "Level: " .. level + 1
    local TextLabel_2 = (((((Head:WaitForChild("Bar")):WaitForChild("2")):WaitForChild("Top")):WaitForChild("Bar")):WaitForChild("Bar")):WaitForChild("TextLabel")
    TextLabel_2.Text = ("XP:%*/%*"):format(AbbreviateNumber(exp), (AbbreviateNumber(v4)))
    local Bar_16 = (((((Head:WaitForChild("Bar")):WaitForChild("2")):WaitForChild("Top")):WaitForChild("Bar")):WaitForChild("Bar")):WaitForChild("Bar")
    Bar_16.Size = UDim2.fromScale(v5, 1)
    Helper.GetBoost(level + 1)
    local v6 = Helper.GetBoostType(level + 1)
    local v7 = Helper.GetText(level + 1)
    v1 = Helper.GetHeadText(level + 1)
    Helper.GetID(level + 1)
    local v8 = GameSetting.Icon[v6]
    local Lock_2 = Reward:WaitForChild("Lock")
    Lock_2.Visible = v5 < 1
    local Info_5 = ((((Reward:WaitForChild("Info")):WaitForChild("Icon")):WaitForChild("Icon")):WaitForChild("Button")):WaitForChild("Info")
    Info_5:WaitForChild("Icon").Image = v8
    local v9 = (((Reward:WaitForChild("Info")):WaitForChild("Buttons")):WaitForChild("Text")):WaitForChild("1")
    v9:WaitForChild("num").Text = v1
    v9 = (((Reward:WaitForChild("Info")):WaitForChild("Buttons")):WaitForChild("Text")):WaitForChild("2")
    v9:WaitForChild("num").Text = v7
end

function u0.open() -- Line: 388 -- upvalues: UIController (val), Index_2 (val)
    UIController.openScreen(Index_2.Name)
end

function u0.OpenScroFrame(a1) -- Line: 392 -- upvalues: u166 (ref), Left (val), ScrollingFrame (val)
    local v1, zhong
    if a1 == u166 then
        return
    end
    for i, j in Left:GetChildren() do
        if j:IsA("TextButton") then
            zhong = j:WaitForChild("zhong")
            zhong.Visible = a1 == j.Name
        end
    end
    for k, n in ScrollingFrame:GetChildren() do
        if n:IsA("Frame") then
            v1 = (n:GetAttribute("Type")) == a1
            n.Visible = v1
        end
    end
end

function u0.close() -- Line: 413 -- upvalues: UIController (val), Index_2 (val)
    UIController.closeScreen(Index_2.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.LeftInfoGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.LeftInfoGUI
-- Decompile time: 3.14 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local UpgradeData = require(ReplicatedStorage.LocalData.UpgradeData)
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
LocalPlayer.PlayerGui:WaitForChild("Main")
local rebirth = (LocalPlayer:WaitForChild("Eco")):WaitForChild("rebirth")
local coin = (LocalPlayer:WaitForChild("Eco")):WaitForChild("coin")
local LeftInfos = Hud:WaitForChild("LeftInfos")
local Coin = LeftInfos:WaitForChild("Coin")
local OrePack = LeftInfos:WaitForChild("OrePack")
local Rebirth = LeftInfos:WaitForChild("Rebirth")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local getDianDianNumber = AbbNumber.getDianDianNumber

function u0.init() end

function u0.start() -- Line: 28 -- upvalues: u0 (val), coin (val), rebirth (val)
    u0.UpdateOrePack(0)
    coin.Changed:Connect(function() -- Line: 30 -- upvalues: u0 (upval)
        u0.UpdateCoin()
    end)
    rebirth.Changed:Connect(function() -- Line: 33 -- upvalues: u0 (upval)
        u0.UpdateRebirth()
    end)
    u0.update()
end

function u0.update() -- Line: 38 -- upvalues: u0 (val)
    u0.UpdateCoin()
    u0.UpdateRebirth()
end

function u0.UpdateRebirth() -- Line: 44 -- upvalues: rebirth (val), Rebirth (val)
    local Value = rebirth.Value
    Rebirth:WaitForChild("Title").Text = Value
end

function u0.UpdateCoin() -- Line: 48 -- upvalues: coin (val), Coin (val), AbbreviateNumber (val)
    local Value = coin.Value
    local Title = Coin:WaitForChild("Title")
    Title.Text = AbbreviateNumber(Value)
end

local u66 = 0

function u0.UpdateOrePack(a1) -- Line: 54 -- upvalues: u66 (ref), UpgradeData (val), OrePack (val)
    if not a1 then
        a1 = 0
    end
    u66 = a1
    local OrePack_2 = UpgradeData.GetMaxNum("OrePack")
    local Title = OrePack:WaitForChild("Title")
    Title.Text = ("%*/%*"):format(a1, OrePack_2)
end

function u0.GetOrePack() -- Line: 64 -- upvalues: u66 (ref)
    return u66
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.LostOreGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.LostOreGUI
-- Decompile time: 5.68 ms

local u0 = {}
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Monetization = require(ReplicatedStorage.Config.Monetization)
require(ReplicatedStorage.Utils.CommunicationUtils)
local Helper = require(ReplicatedStorage.Config.Ore.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Rarity.Helper)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local LostOre = LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("LostOre")
local Button = LostOre:WaitForChild("Button")
local Bar = (LostOre:WaitForChild("Main")):WaitForChild("Bar")
local ScrollingFrame = ((LostOre:WaitForChild("Main")):WaitForChild("List")):WaitForChild("ScrollingFrame")

function u0.init() end

function u0.start() -- Line: 27
    -- upvalues: Button (val), u0 (val), MarketplaceService (val), LocalPlayer (val), Monetization (val)
    ((Button:WaitForChild("GiveUp")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 28 -- upvalues: u0 (upval)
        u0.CloseLost()
    end)
    ;((Button:WaitForChild("Buy")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 31 -- upvalues: MarketplaceService (upval), LocalPlayer (upval), Monetization (upval)
        MarketplaceService:PromptProductPurchase(LocalPlayer, Monetization.DevProducts.RecoverOre.Id)
    end)
end

function u0.update() end

function u0.OpenLost(a1) -- Line: 41
    -- upvalues: TableUtils (val), LostOre (val), RunUtils (val), u0 (val), Bar (val), ScrollingFrame (val)
    -- upvalues: Helper (val), Helper_2 (val), ReplicatedStorage (val)
    if a1 and TableUtils.getTableLegth(a1) ~= 0 then
        local Frame, shuzi, v1, v2, v3, v4, v5
        LostOre.Visible = true
        local u7 = 4
        RunUtils:RegistPreRender("LostOreUI", nil, function(a1) -- Line: 48 -- upvalues: u7 (ref), u0 (upval), Bar (upval)
            u7 = u7 - a1
            if u7 <= 0 then
                u0.CloseLost()
                return
            end
            local v1 = math.clamp(u7 / 4, 0, 1)
            local Bar_2 = Bar:WaitForChild("Bar")
            Bar_2.Size = UDim2.fromScale(v1, 1)
        end)
        for i, j in ScrollingFrame:GetChildren() do
            if j:IsA("Frame") or j:IsA("TextButton") then
                j:Destroy()
            end
        end
        local v6 = {}
        local v7 = nil
        local v8 = nil
        for k, n in a1, v7, v8 do
            if not v6[n] then
                v6[n] = 0
            end
            v6[n] = v6[n] + 1
        end
        for m, i5 in v6 do
            v4 = Helper_2.GetTextRarity((Helper.GetRarity(m)))
            v5 = Helper.GetImage(m)
            v1 = Helper.GetDisName(m)
            v2 = Helper_2.GetRarityLevel(v4)
            v3 = ReplicatedStorage.Assets.Rarity.SquareFrame:WaitForChild(v4):Clone()
            v3.Parent = ScrollingFrame
            v3.Visible = true
            v3.LayoutOrder = -v2 * 50 - i5
            Frame = v3:WaitForChild("Frame")
            Frame:WaitForChild("Mingzi").Text = v1
            Frame:WaitForChild("ImageLabel").Image = v5
            shuzi = Frame:WaitForChild("shuzi")
            shuzi.Text = ("x%*"):format(i5)
        end
        return
    end
end

function u0.CloseLost() -- Line: 90 -- upvalues: LostOre (val), RunUtils (val)
    LostOre.Visible = false
    RunUtils:RemoveRun("LostOreUI")
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.LuckSkillGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.LuckSkillGUI
-- Decompile time: 8.47 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local UIController = require(ReplicatedStorage.Utils.UIController)
local LocalPlayer = game.Players.LocalPlayer
local LuckSkill = LocalPlayer.PlayerGui:WaitForChild("LuckSkill")
LocalPlayer.PlayerGui:WaitForChild("Hud")
LocalPlayer.PlayerGui:WaitForChild("Main")
local ScrollingFrame = ((((LuckSkill:WaitForChild("Lottery")):WaitForChild("Main")):WaitForChild("Title")):WaitForChild("Frame")):WaitForChild("ScrollingFrame")
local u70 = CommunicationUtils.TryGetRemoteEvent("Backpack", "ShowSkillCell_2RE")
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.ScrollingEnabled = false
local u73 = false

local function ClearSpinItems() -- Line: 38 -- upvalues: ScrollingFrame (val)
    for i, v in ipairs(ScrollingFrame:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
end

local function GetCenterCanvasPosForFrame(a1) -- Line: 48 -- upvalues: ScrollingFrame (val)
    return Vector2.new(0, (math.max(
        a1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y + a1.AbsoluteSize.Y / 2 - ScrollingFrame.AbsoluteSize.Y / 2,
        0
    )))
end

local function GetScaleByDistance(a1, a2) -- Line: 56
    return (1 - math.clamp(a1 / a2, 0, 1)) * 0.7 + 0.55
end

function CreateOneSkillFrame(a1) -- Line: 61 -- upvalues: Helper (val), ScrollingFrame (val)
    local v1 = Helper.GetImage(a1)
    local v2 = Helper.GetSkillLevelImage((Helper.GetSkillLevel(a1)))
    local v3 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild("temple"):Clone()
    v3.Visible = true
    local Frame = v3:WaitForChild("Frame")
    Frame:WaitForChild("ImageLabel").Image = v1
    local Level = (v3:WaitForChild("Frame")):WaitForChild("Level")
    Level:WaitForChild("ImageLabel").Image = v2
    return v3
end

function u0.start() -- Line: 74 -- upvalues: u70 (val), u0 (val)
    u70.OnClientEvent:Connect(function(a1) -- Line: 75 -- upvalues: u0 (upval)
        u0.ShowSkillCell_2(a1)
    end)
end

function u0.ShowSkillCell_2(a1) -- Line: 81
    -- upvalues: u73 (ref), Helper (val), LuckSkill (val), UIController (val), ClearSpinItems (val)
    -- upvalues: ScrollingFrame (val), RunService (val), TweenService (val)
    local v1
    if u73 then
        return
    end
    u73 = true
    local v2 = Helper.GetSkillIDList(a1)
    LuckSkill.Enabled = true
    UIController.ShowHud(false)
    ClearSpinItems()
    ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
    local v3 = {}
    for i = 1, 47 do
        if i ~= 5 then
            v3[i] = v2[math.random(1, #v2)]
        else
            v3[i] = a1
        end
    end
    local u186 = {}
    local u189 = {}
    for i2, v in ipairs(v3) do
        v1 = CreateOneSkillFrame(v)
        v1.Name = "SpinItem_" .. i2
        v1.LayoutOrder = i2
        v1.ZIndex = if i2 ~= 5 then 5 else 10
        v1.Parent = ScrollingFrame
        u186[i2] = v1
        u189[i2] = v1.Size
    end
    RunService.Heartbeat:Wait()
    RunService.Heartbeat:Wait()
    local v4 = u186[47]
    local CanvasPosition = ScrollingFrame.CanvasPosition
    local v5 = Vector2.new(0, (math.max(
        v4.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + CanvasPosition.Y + v4.AbsoluteSize.Y / 2 - ScrollingFrame.AbsoluteSize.Y / 2,
        0
    )))
    local v6 = u186[5]
    local CanvasPosition_2 = ScrollingFrame.CanvasPosition
    v4 = Vector2.new(0, (math.max(
        v6.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + CanvasPosition_2.Y + v6.AbsoluteSize.Y / 2 - ScrollingFrame.AbsoluteSize.Y / 2,
        0
    )))
    ScrollingFrame.CanvasPosition = v5
    local u131 = ScrollingFrame.AbsoluteSize.Y / 2
    local v7 = RunService.Heartbeat:Connect(function() -- Line: 129 -- upvalues: ScrollingFrame (upval), u131 (val), u186 (val), u189 (val)
        local new, v1, v2, v3, v4, v5
        local v6 = ScrollingFrame.AbsolutePosition.Y + u131
        for i, v in ipairs(u186) do
            if v.Parent then
                v5 = (1 - math.clamp((math.abs(v.AbsolutePosition.Y + v.AbsoluteSize.Y / 2 - v6)) / (u131 + v.AbsoluteSize.Y / 2), 0, 1)) * 0.7 + 0.55
                v1 = u189[i]
                new = UDim2.new
                v2 = v1.X.Scale * v5
                v3 = v1.X.Offset * v5
                v4 = v1.Y.Scale * v5
                v.Size = new(v2, v3, v4, v1.Y.Offset * v5)
            end
        end
    end)
    local v8 = TweenService:Create(ScrollingFrame, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CanvasPosition = v4})
    v8:Play()
    v8.Completed:Wait()
    if v7 then
        v7:Disconnect()
    end
    task.wait(0.5)
    LuckSkill.Enabled = false
    UIController.ShowHud(true)
    ClearSpinItems()
    u73 = false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.Message
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.Message
-- Decompile time: 8.00 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
game:GetService("RunService")
local CanvasGroup = ((game.Players.LocalPlayer.PlayerGui:WaitForChild("Message", 999)):WaitForChild("Message"):WaitForChild("Tip")):WaitForChild("CanvasGroup")
local u44 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetRemoteEvent("Message", "MessageRE")
require(ReplicatedStorage.Utils.AbbNumber)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local u58 = tick()
local u59 = {}

local function GetCurrentTime() -- Line: 26
    return time()
end

local function getShowTime(a1) -- Line: 30 -- types: a1: string
    return #a1 * 0.08 + 1.2
end

function u0.init() end

function u0.start() -- Line: 39
    -- upvalues: u58 (ref), u0 (val), u44 (val), CanvasGroup (val), RunUtils (val), u59 (val)
    local function GetMessage(a1, a2) -- Line: 40 -- upvalues: u58 (upval), u0 (upval)
        if tick() - u58 <= 0.05 then
            return
        end
        u58 = tick()
        u0.showMessage(a1, nil, a2)
    end

    u44.OnClientEvent:Connect(function(a1, a2) -- Line: 48 -- upvalues: u58 (upval), u0 (upval)
        if tick() - u58 <= 0.05 then
            return
        end
        u58 = tick()
        u0.showMessage(a1, nil, a2)
    end)
    for i, j in CanvasGroup:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    RunUtils:RegistPreRender(nil, 0.5, function() -- Line: 58 -- upvalues: u59 (upval), u0 (upval)
        local v1 = time()
        for i, j in u59 do
            if j.EndTick <= v1 then
                u0.CloseMessage(u59[i])
                u59[i] = nil
            end
        end
    end)
end

function u0.showMessage(a1, a2, a3) -- Line: 70
    -- upvalues: u59 (val), CanvasGroup (val), SoundPlayer (val), TweenService (val)
    local v1
    if u59[a1] then
        v1 = u59[a1]
        v1.EndTick = time() + u59[a1].ShowTime
        ShakeMessage(u59[a1])
        return
    end
    if not a3 then
        v1 = (CanvasGroup:WaitForChild("Temple")):WaitForChild("Tip"):Clone()
    else
        v1 = (CanvasGroup:WaitForChild("Temple")):WaitForChild(a3 .. "Tip"):Clone()
        SoundPlayer.playSound("GradeMessageShow")
    end
    v1.Parent = CanvasGroup
    v1.Visible = true
    v1:WaitForChild("Tip").Text = a1
    local Size = v1.Size
    v1.Size = UDim2.fromScale(Size.X.Scale, 0)
    TweenService:Create(v1, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = Size}):Play()
    local v2 = a2 or #a1 * 0.08 + 1.2
    u59[a1] = {Frame = v1, StartTick = time(), EndTick = time() + v2, ShowTime = v2}
end

function u0.CloseMessage(a1) -- Line: 106 -- upvalues: TweenService (val)
    if not a1 then
        return
    end
    local Frame = a1.Frame
    local u18 = TweenService:Create(
        Frame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.fromScale(Frame.Size.X.Scale, 0)}
    )
    u18:Play()
    task.spawn(function() -- Line: 116 -- upvalues: u18 (val), Frame (val)
        u18.Completed:Wait()
        Frame:Destroy()
    end)
end

function u0.ShowGuide(a1, a2) -- Line: 122 -- upvalues: CanvasGroup (val)
    local GUIDE = CanvasGroup:FindFirstChild("GUIDE")
    if not GUIDE then
        GUIDE = (CanvasGroup:WaitForChild("Temple")):WaitForChild("Tip"):Clone()
        GUIDE.Parent = CanvasGroup
        GUIDE.Visible = true
        GUIDE.Name = "GUIDE"
        GUIDE.LayoutOrder = -1
    end
    GUIDE:WaitForChild("Tip").Text = a1
end

function u0.DestoryGuide() -- Line: 135 -- upvalues: CanvasGroup (val)
    local GUIDE = CanvasGroup:FindFirstChild("GUIDE")
    if GUIDE then
        GUIDE:Destroy()
    end
end

function ShakeMessage(a1) -- Line: 146 -- upvalues: SoundPlayer (val), RunUtils (val)
    SoundPlayer.playSound("MessageShake")
    local Frame = a1.Frame
    local Tip = Frame:WaitForChild("Tip")
    local u17 = {elapsed = 0, basePosition = Tip.Position, noiseSeed = math.random(1, 10000)}
    if a1.ShakeConnect then
        a1.ShakeConnect:Disconnect()
        Tip.Position = UDim2.fromScale(0.5, 0.5)
    end
    local u27 = nil
    u27 = RunUtils:RegistPreRender(nil, nil, function(a1) -- Line: 161 -- upvalues: Frame (val), u27 (ref), u17 (ref), Tip (val) -- types: a1: number
        if Frame and Frame.Parent then
            local v1 = u17
            v1.elapsed = v1.elapsed + a1
            if 0.3 <= u17.elapsed then
                u27:Disconnect()
                Tip.Position = UDim2.fromScale(0.5, 0.5)
                return
            end
            local v2 = 1 - u17.elapsed / 0.3
            local v3 = math.noise(u17.elapsed * 13, u17.noiseSeed) * 2 * 26 * v2
            Tip.Position = UDim2.new(u17.basePosition.X.Scale, u17.basePosition.X.Offset + v3, u17.basePosition.Y.Scale, u17.basePosition.Y.Offset)
            return
        end
        u27:Disconnect()
    end)
    a1.ShakeConnect = u27
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.OfflineReward
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.OfflineReward
-- Decompile time: 4.86 ms

local u0 = {}
game:GetService("RunService")
game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
LocalPlayer.PlayerGui:WaitForChild("Info")
local OfflineReward = Main:WaitForChild("OfflineReward")
local Info_2 = (OfflineReward:WaitForChild("Main")):WaitForChild("Info")
local Button = Info_2:WaitForChild("Button")
local Tex = Info_2:WaitForChild("Tex")
local TextButton = (OfflineReward:WaitForChild("De")):WaitForChild("TextButton")
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local Monetization = require(ReplicatedStorage.Config.Monetization)
require(ReplicatedStorage.GuiUtils.Message)
require(ReplicatedStorage.Utils.TimeFormatUntil)
local u98 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetRemoteEvent("Offline", "TryClaimOfflineRewardRE")

function u0.init() end

local u100 = nil
local u101 = nil

function u0.start() -- Line: 39
    -- upvalues: LocalPlayer (val), u101 (ref), u0 (val), u100 (ref), Button (val), u98 (val), TextButton (val)
    -- upvalues: MarketplaceService (val), Monetization (val)
    local u0_2 = nil
    local v1 = LocalPlayer.AttributeChanged:Connect(function(a1) -- Line: 41 -- upvalues: u101 (upval), LocalPlayer (upval), u0 (upval), u0_2 (ref), u100 (upval)
        if a1 == "OfflineRewardValue" then
            u101 = LocalPlayer:GetAttribute("OfflineRewardValue")
            if not u101 then
                u0.close()
                u0_2:Disconnect()
            else
                u0.open()
            end
        end
        if a1 == "OfflineTime" then
            u100 = LocalPlayer:GetAttribute("OfflineTime")
            if u100 then
                u0.open()
            end
        end
    end)
    u101 = LocalPlayer:GetAttribute("OfflineRewardValue")
    u100 = LocalPlayer:GetAttribute("OfflineTime")
    if u101 and u100 then
        u0.open()
    end
    ;(Button:WaitForChild("Claim")).MouseButton1Click:Connect(function() -- Line: 66 -- upvalues: u98 (upval), u0 (upval)
        u98:FireServer()
        u0.close()
    end)
    TextButton.MouseButton1Click:Connect(function() -- Line: 70 -- upvalues: u98 (upval), u0 (upval)
        u98:FireServer()
        u0.close()
    end)
    ;((Button:WaitForChild("Buy10Egg")):WaitForChild("Button")).MouseButton1Click:Connect(function() -- Line: 75 -- upvalues: MarketplaceService (upval), LocalPlayer (upval), Monetization (upval)
        MarketplaceService:PromptProductPurchase(LocalPlayer, Monetization.DevProducts.OfflineRewardx10.Id)
    end)
    u0.update()
end

function u0.update() end

function u0.open() -- Line: 86
    -- upvalues: u100 (ref), u101 (ref), UIController (val), OfflineReward (val), Button (val), AbbNumber (val)
    -- upvalues: Tex (val)
    if u100 and u101 then
        UIController.openScreen(OfflineReward.Name)
        local Amount = (((Button:WaitForChild("Buy10Egg")):WaitForChild("Button")):WaitForChild("Frame")):WaitForChild("Amount")
        Amount.Text = AbbNumber.getDianDianNumber(u101 * 10)
        local Desc = ((Tex:WaitForChild("Bg")):WaitForChild("Time")):WaitForChild("Desc")
        Desc.Text = "Power: " .. AbbNumber.getDianDianNumber(u101)
        return
    end
end

function u0.close() -- Line: 100 -- upvalues: UIController (val), OfflineReward (val)
    UIController.closeScreen(OfflineReward.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.OnlineGift
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.OnlineGift
-- Decompile time: 17.11 ms

local u0 = {}
game:GetService("RunService")
local TweenService = game:GetService("TweenService")
game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Online = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("Online")
local Button = ((Hud:WaitForChild("Right")):WaitForChild("Online")):WaitForChild("Button")
local TextButton = (Online:WaitForChild("De")):WaitForChild("TextButton")
local Icon = Button:WaitForChild("Icon")
local Time = Button:WaitForChild("Time")
local RightInfo = ((Online:WaitForChild("zheng")):WaitForChild("wuqi")):WaitForChild("RightInfo")
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
require(ReplicatedStorage.Utils.AbbNumber)
local TimeFormatUntil = require(ReplicatedStorage.Utils.TimeFormatUntil)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.LocalData.PemData)
require(ReplicatedStorage.LocalData.StatsData)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local RewardShow = require(ReplicatedStorage.GuiUtils.RewardShow)
local Reward = require(ReplicatedStorage.Config.Online.Reward)
local Helper_2 = require(ReplicatedStorage.Config.Online.Helper)
require(ReplicatedStorage.Config.Monetization)
require(ReplicatedStorage.Config.GameSetting)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local OnlineData = require(ReplicatedStorage.LocalData.OnlineData)
local u145 = 0
local u146 = false
local u148 = Helper_2.GetOnlineTimeConfig()
local u149 = false
local u150 = false
local Size = Icon.Size
local u167 = TweenService:Create(Icon, TweenInfo.new(0.2), {
    Rotation = -30,
    Size = UDim2.fromScale(Size.X.Scale * 1.2, Size.Y.Scale * 1.2),
})
local u179 = TweenService:Create(Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, true), {Rotation = 30})
local u189 = TweenService:Create(Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Rotation = 30})
local u197 = TweenService:Create(Icon, TweenInfo.new(0.2), {Rotation = 0, Size = Size})
u167.Completed:Connect(function() -- Line: 95 -- upvalues: u179 (val)
    u179:Play()
end)
u179.Completed:Connect(function() -- Line: 98 -- upvalues: u189 (val)
    u189:Play()
end)
u189.Completed:Connect(function() -- Line: 101 -- upvalues: u197 (val)
    u197:Play()
end)
u197.Completed:Connect(function() -- Line: 104 -- upvalues: u146 (ref), u167 (val), u150 (ref)
    task.wait(1)
    if u146 then
        u167:Play()
        return
    end
    u150 = false
end)

function u0.init() end

function u0.start() -- Line: 117
    -- upvalues: RunUtils (val), u0 (val), Button (val), TextButton (val), RightInfo (val), OnlineData (val), u145 (ref)
    -- upvalues: u148 (val), Message (val), Reward (val), RewardShow (val), AnyHelper (val), Helper (val), u149 (ref)
    local Button_2, Item, Item_2, v1, v2, v3, v4
    RunUtils:RegistPreRender(nil, 1, u0.update)
    Button.MouseButton1Click:Connect(function() -- Line: 120 -- upvalues: u0 (upval)
        u0.open()
    end)
    TextButton.MouseButton1Click:Connect(function() -- Line: 123 -- upvalues: u0 (upval)
        u0.close()
    end)
    for i, j in RightInfo:GetChildren() do
        if j:IsA("Frame") then
            local Name = j.Name
            Button_2 = j:WaitForChild("Button")
            Button_2.MouseButton1Click:Connect(function() -- Line: 133 -- upvalues: OnlineData (upval), Name (val), u145 (upval), u148 (upval), Message (upval)
                if OnlineData.GetData().Reward[Name] then
                    return
                end
                if u145 < u148[Name] then
                    Message.showMessage("Not yet.")
                    return
                end
                OnlineData.TryClaim(Name)
            end)
            v2 = Reward[Name]
            v3, v4 = RewardShow.getShow(v2)
            if v3 ~= nil and type(v3) == "string" then
                Item = Button_2:WaitForChild("Item")
                Item:WaitForChild("Icon").Image = v3
            end
            if v4 ~= nil then
                Item_2 = Button_2:WaitForChild("Item")
                Item_2:WaitForChild("Title").Text = v4
            end
            v1 = AnyHelper.GetRarity(v2.Type, v2.ID)
            if v1 then
                v1 = Helper.GetTextRarity(v1)
                Helper.SetUIQiu((Button_2:WaitForChild("Item")):WaitForChild("Title"), v1)
            end
        end
    end
    u0.update()
    OnlineData.AddCallback(function() -- Line: 165 -- upvalues: u0 (upval)
        u0.update()
    end)
    u149 = true
end

function u0.update() -- Line: 171
    -- upvalues: u146 (ref), OnlineData (val), u145 (ref), RightInfo (val), u148 (val), TimeFormatUntil (val)
    -- upvalues: Time (val), u150 (ref), u167 (val)
    local Button, Name, Title, Title_2, Title_3, Title_4, Title_5, v1, v2, v3, v4
    local v5 = 9999
    local v6 = true
    u146 = false
    local v7 = OnlineData.GetData()
    u145 = math.floor(v7.PassTime + (workspace:GetAttribute("ServerTime") or os.time()) - (v7.StartTick or os.time()))
    for i, j in RightInfo:GetChildren() do
        if j:IsA("Frame") then
            Name = j.Name
            v1 = v7.Reward[Name] or false
            v2 = u148[Name] - u145
            v6 = v6 and v1
            v3 = not v1 and v2 <= 0
            Button = j:WaitForChild("Button")
            Title = Button:WaitForChild("Title")
            v4 = v3 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
            Title.TextColor3 = v4
            j:FindFirstChild("Click").Visible = v3
            if v1 then
                Title_2 = Button:WaitForChild("Title")
                Title_2.Text = "Claimed!"
            elseif not v3 then
                if v2 < v5 then
                    v5 = v2
                end
                if not (v2 >= 3600) then
                    Title_5 = Button:WaitForChild("Title")
                    Title_5.Text = TimeFormatUntil.MMSS(v2)
                else
                    Title_4 = Button:WaitForChild("Title")
                    Title_4.Text = TimeFormatUntil.HHMMSS(v2)
                end
            else
                u146 = true
                Title_3 = Button:WaitForChild("Title")
                Title_3.Text = "Claim!"
            end
        end
    end
    if v6 then
        Time.Text = "All Claimed"
        Time.TextColor3 = Color3.fromRGB(255, 255, 255)
        return
    end
    if not u146 then
        Time.Text = TimeFormatUntil.MMSS(v5)
        Time.TextColor3 = Color3.fromRGB(255, 255, 255)
        return
    end
    if not u150 then
        u150 = true
        u167:Play()
    end
    Time.Text = "Claim!"
    Time.TextColor3 = Color3.fromRGB(0, 255, 0)
end

function u0.open() -- Line: 228
    -- upvalues: Online (val), UIController (val), RightInfo (val), Reward (val), RewardShow (val)
    if not Online.Visible then
        local Button, Item, Item_2, Name, v1, v2, v3
        UIController.openScreen(Online.Name)
        for i, j in RightInfo:GetChildren() do
            if j:IsA("Frame") then
                Name = j.Name
                Button = j:WaitForChild("Button")
                v1 = Reward[Name]
                if v1.Type == "TimePower" then
                    v2, v3 = RewardShow.getShow(v1)
                    if v2 ~= nil and type(v2) == "string" then
                        Item = Button:WaitForChild("Item")
                        Item:WaitForChild("Icon").Image = v2
                    end
                    if v3 ~= nil then
                        Item_2 = Button:WaitForChild("Item")
                        Item_2:WaitForChild("Title").Text = v3
                    end
                end
            end
        end
    end
end

function u0.close() -- Line: 255 -- upvalues: Online (val), UIController (val)
    if Online.Visible then
        UIController.closeScreen(Online.Name)
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.OnlineGift.WaitClaim
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.OnlineGift.WaitClaim
-- Decompile time: 1.10 ms

local Selected = script.Parent:FindFirstChild("Selected")
if Selected then
    local u8 = Selected:Clone()
    u8.Parent = script.Parent
    u8.Name = "CLONESELECT"
    local u29 = (game:GetService("TweenService")):Create(u8, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(1, 1)})
    u29:Play()
    u29.Completed:Connect(function() -- Line: 15 -- upvalues: u8 (val), u29 (val)
        u8.Size = UDim2.fromScale(0.8, 0.8)
        task.wait(0.1)
        u29:Play()
    end)
end
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.RebirthGUI
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.RebirthGUI
-- Decompile time: 10.92 ms

local u0 = {}
game:GetService("RunService")
game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Rebirth = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("Rebirth")
local Rebirth_2 = ((Hud:WaitForChild("Left")):WaitForChild("Buttons")):WaitForChild("Rebirth")
local TextButton = (Rebirth:WaitForChild("De")):WaitForChild("TextButton")
local Top = ((Rebirth:WaitForChild("Main")):WaitForChild("Info")):WaitForChild("Top")
local Bottom = ((Rebirth:WaitForChild("Main")):WaitForChild("Info")):WaitForChild("Bottom")
local RebDT = ((Rebirth:WaitForChild("Main")):WaitForChild("Info")):WaitForChild("RebDT")
local Bar = Bottom:WaitForChild("Bar")
local Button = Bottom:WaitForChild("Button")
local coin = Top:WaitForChild("coin")
local power = Top:WaitForChild("power")
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.SoundPlayer)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.LocalData.StatsData)
require(ReplicatedStorage.LocalData.PemData)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local ConfettiGUI = require(ReplicatedStorage.GuiUtils.ConfettiGUI)
local Monetization = require(ReplicatedStorage.Config.Monetization)
local Helper = require(ReplicatedStorage.Config.Rebirth.Helper)
local u154 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetRemoteEvent("Rebirth", "TryRebirthRE")
local rebirth = (LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("rebirth", 999)
;(LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("power", 999)
local level = (LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("level", 999)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local getDianDianNumber = AbbNumber.getDianDianNumber

function u0.init() end

function u0.start() -- Line: 74
    -- upvalues: Rebirth_2 (val), u0 (val), TextButton (val), Button (val), rebirth (val), Helper (val), Message (val)
    -- upvalues: level (val), u154 (val), MarketplaceService (val), LocalPlayer (val), Monetization (val)
    -- upvalues: ConfettiGUI (val)
    Rebirth_2.MouseButton1Down:Connect(function() -- Line: 75 -- upvalues: u0 (upval)
        u0.open()
    end)
    TextButton.MouseButton1Down:Connect(function() -- Line: 78 -- upvalues: u0 (upval)
        u0.close()
    end)
    ;((Button:WaitForChild("Rebirth")):WaitForChild("Button")).MouseButton1Click:Connect(function() -- Line: 82 -- upvalues: rebirth (upval), Helper (upval), Message (upval), level (upval), u154 (upval)
        local Value = rebirth.Value
        if Helper.CheckIsMax(Value) then
            Message.showMessage("Max level.")
            return
        end
        if (Helper.GetNeedLevel(Value + 1)) <= level.Value then
            u154:FireServer()
            return
        end
        Message.showMessage("Level not high enough.")
    end)
    ;((Button:WaitForChild("Skip")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 98
        -- upvalues: rebirth (upval), Helper (upval), Message (upval), MarketplaceService (upval), LocalPlayer (upval)
        -- upvalues: Monetization (upval)
        local Value = rebirth.Value
        if Helper.CheckIsMax(Value) then
            Message.showMessage("Max level.")
            return
        end
        MarketplaceService:PromptProductPurchase(LocalPlayer, Monetization.DevProducts["SkipRebirth_" .. Value + 1].Id)
    end)
    rebirth.Changed:Connect(function(a1) -- Line: 110 -- upvalues: u0 (upval), ConfettiGUI (upval), Message (upval)
        u0.updateRebirth()
        ConfettiGUI.FireFlower()
        Message.showMessage("Rebirth successful.")
    end)
    level.Changed:Connect(function(a1) -- Line: 118 -- upvalues: u0 (upval)
        u0.UpdatePercent(a1)
    end)
    local v1 = GetPercent()
    local Percent = ((Rebirth_2:WaitForChild("Frame")):WaitForChild("%")):WaitForChild("Percent")
    Percent.Text = ("%*%%"):format((math.floor(v1 * 100)))
    u0.update()
end

function u0.update() -- Line: 129 -- upvalues: u0 (val)
    u0.updateBar()
    u0.updateRebirth()
    u0.UpdatePercent()
end

function u0.UpdatePercent() -- Line: 135 -- upvalues: Rebirth_2 (val), Message (val), Rebirth (val), u0 (val)
    local v1 = GetPercent()
    local Percent = ((Rebirth_2:WaitForChild("Frame")):WaitForChild("%")):WaitForChild("Percent")
    Percent.Text = ("%*%%"):format((math.floor(v1 * 100)))
    if not (v1 >= 1) then
        if Percent:HasTag("Rock") then
            Percent:RemoveTag("Rock")
            Percent.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    elseif not Percent:HasTag("Rock") then
        Percent:AddTag("Rock")
        Percent.TextColor3 = Color3.fromRGB(0, 255, 0)
        Message.showMessage("You can rebirth.")
    end
    if Rebirth.Visible then
        u0.updateBar()
    end
end

function GetPercent() -- Line: 159 -- upvalues: rebirth (val), level (val), Helper (val)
    local Value = rebirth.Value
    return (math.clamp(level.Value / (if Helper.CheckIsMax(Value) then Helper.GetNeedLevel(Value) else Helper.GetNeedLevel(Value + 1)), 0, 1))
end

function u0.updateBar() -- Line: 175
    -- upvalues: Rebirth (val), rebirth (val), level (val), Helper (val), Bar (val), Button (val)
    if not Rebirth.Visible then
        return
    end
    local Value = rebirth.Value
    local Value_2 = level.Value
    local v1 = GetPercent()
    local UIGradient = ((Bar:WaitForChild("Mask")):WaitForChild("Bar")):WaitForChild("UIGradient")
    UIGradient.Offset = Vector2.new(v1 - 0.5, 0)
    local v2 = (Bar:WaitForChild("TX")):WaitForChild("1")
    v2.Text = ("Lv.%*/Lv.%*"):format(Value_2, if Helper.CheckIsMax(Value) then Helper.GetNeedLevel(Value) else Helper.GetNeedLevel(Value + 1))
    local NO = (Button:WaitForChild("Rebirth")):WaitForChild("NO")
    NO.Visible = v1 < 1
    local Button_2 = (Button:WaitForChild("Rebirth")):WaitForChild("Button")
    Button_2.Visible = v1 >= 1
end

function u0.updateRebirth() -- Line: 200
    -- upvalues: rebirth (val), Helper (val), coin (val), power (val), RebDT (val), Button (val), Monetization (val)
    local v1, v2
    local Value = rebirth.Value
    local v3 = Value + 1
    if Helper.CheckIsMax(Value) then
        RebDT.Visible = false
        v1 = Helper.GetExpBasic(Value)
        v2 = Helper.GetCoinBasic(Value)
        local TextLabel_5 = (coin:WaitForChild("1")):WaitForChild("TextLabel")
        TextLabel_5.Text = ("x%*"):format(v2)
        local TextLabel_6 = (coin:WaitForChild("2")):WaitForChild("TextLabel")
        TextLabel_6.Text = "Max"
        local TextLabel_7 = (power:WaitForChild("1")):WaitForChild("TextLabel")
        TextLabel_7.Text = ("x%*"):format(v1)
        local TextLabel_8 = (power:WaitForChild("2")):WaitForChild("TextLabel")
        TextLabel_8.Text = "Max"
        local Skip_3 = Button:WaitForChild("Skip")
        Skip_3.Visible = false
        return
    end
    v1 = Helper.GetExpBasic(Value)
    v2 = Helper.GetCoinBasic(Value)
    local v4 = Helper.GetExpBasic(v3)
    local v5 = Helper.GetCoinBasic(v3)
    local TextLabel = (coin:WaitForChild("1")):WaitForChild("TextLabel")
    TextLabel.Text = ("x%*"):format(v2)
    local TextLabel_2 = (coin:WaitForChild("2")):WaitForChild("TextLabel")
    TextLabel_2.Text = ("x%*"):format(v5)
    local TextLabel_3 = (power:WaitForChild("1")):WaitForChild("TextLabel")
    TextLabel_3.Text = ("x%*"):format(v1)
    local TextLabel_4 = (power:WaitForChild("2")):WaitForChild("TextLabel")
    TextLabel_4.Text = ("x%*"):format(v4)
    local v6 = Helper.GetDungeonTicket(v3)
    if not v6 or not (v6 > 0) then
        RebDT.Visible = false
    else
        RebDT.Visible = true
        local Number = RebDT:WaitForChild("Number")
        Number.Text = ("x%*"):format(v6)
    end
    local Skip = Button:WaitForChild("Skip")
    Skip.Visible = true
    local Val = ((Button:WaitForChild("Skip")):WaitForChild("Current")):WaitForChild("Val")
    Val.Text = Monetization.DevProducts["SkipRebirth_" .. v3].Cost
end

function u0.open() -- Line: 250 -- upvalues: Rebirth (val), UIController (val), u0 (val)
    if not Rebirth.Visible then
        UIController.openScreen(Rebirth.Name)
        u0.update()
    end
end

function u0.close() -- Line: 257 -- upvalues: Rebirth (val), UIController (val)
    if Rebirth.Visible then
        UIController.closeScreen(Rebirth.Name)
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.RewardShow
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.RewardShow
-- Decompile time: 14.67 ms

local u0 = {}
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game.ReplicatedStorage
local LocalPlayer = game.Players.LocalPlayer
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Item = LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("Item")
;(Item:WaitForChild("Temple")):WaitForChild("Item")
;(Item:WaitForChild("Temple")):WaitForChild("Item_VP")
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local CalculateUtils = require(ReplicatedStorage.Utils.CalculateUtils)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Buff.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Potion.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Ore.Helper)
local Helper_4 = require(ReplicatedStorage.Config.Rarity.Helper)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local u88 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowSpinRE")
local u92 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowPotionRE")
local u96 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowBoostRE")
local u100 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowEcoRE")
CommunicationUtils.TryGetRemoteEvent("Reward", "ShowEggRE")
local u108 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowPetRE")
local u112 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowItemRE")
local u116 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowRollRE")
local u120 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowAnyRE")
local u124 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowTrailRE")
local u128 = CommunicationUtils.TryGetRemoteEvent("Reward", "ShowGameSettingRE")
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u130 = false

function u0.init() end

function u0.start() -- Line: 46
    -- upvalues: u100 (val), u0 (val), u108 (val), u92 (val), u88 (val), u96 (val), u112 (val), u116 (val), u120 (val)
    -- upvalues: u124 (val), u128 (val)
    u100.OnClientEvent:Connect(function(a1, a2) -- Line: 48 -- upvalues: u0 (upval)
        u0.ShowEco(a1, a2)
    end)
    u108.OnClientEvent:Connect(function(a1) -- Line: 51 -- upvalues: u0 (upval)
        u0.ShowPet(a1)
    end)
    u92.OnClientEvent:Connect(function(a1, a2) -- Line: 54 -- upvalues: u0 (upval)
        u0.ShowPotion(a1, a2)
    end)
    u88.OnClientEvent:Connect(function(a1) -- Line: 57 -- upvalues: u0 (upval)
        u0.ShowSpin(a1)
    end)
    u96.OnClientEvent:Connect(function(a1, a2) -- Line: 60 -- upvalues: u0 (upval)
        u0.ShowBoost(a1, a2)
    end)
    u112.OnClientEvent:Connect(function(a1, a2) -- Line: 63 -- upvalues: u0 (upval)
        u0.ShowItem(a1, a2)
    end)
    u116.OnClientEvent:Connect(function(a1) -- Line: 66 -- upvalues: u0 (upval)
        u0.ShowRoll(a1)
    end)
    u120.OnClientEvent:Connect(function(a1) -- Line: 69 -- upvalues: u0 (upval)
        u0.ShowAny(a1)
    end)
    u124.OnClientEvent:Connect(function(a1) -- Line: 72 -- upvalues: u0 (upval)
        u0.ShowTrail(a1)
    end)
    u128.OnClientEvent:Connect(function(a1, a2) -- Line: 75 -- upvalues: u0 (upval)
        u0.ShowGameSetting(a1, a2)
    end)
end

function u0.getShow(a1) -- Line: 81 -- upvalues: u0 (val)
    local Type = a1.Type
    local Number = a1.Number
    local ID = a1.ID
    if type(Number) == "string" then
        Number = tonumber(Number)
    end
    if Type ~= "Coin" and Type ~= "coin" then
        if Type ~= "Eco" and Type ~= "eco" then
            if Type ~= "TimePower" and Type ~= "timePower" then
                if Type ~= "Weapon" and Type ~= "weapon" then
                    if Type ~= "Hat" and Type ~= "hat" and Type ~= "Armor" and Type ~= "armor" then
                        if Type ~= "Potion" and Type ~= "potion" then
                            if Type ~= "Ore" and Type ~= "ore" then
                                if Type ~= "PotionPack" and Type ~= "potionPack" then
                                    if Type ~= "Boost" and Type ~= "boost" and Type ~= "Buff" and Type ~= "buff" then
                                        if Type == "GameSetting" then
                                            return u0.GetGameSetting(ID, Number)
                                        end
                                        return u0.GetAny(a1)
                                    end
                                    return u0.GetBoostShow(ID, Number)
                                end
                                return u0.GetPotionPackShow(Number)
                            end
                            return u0.GetOreShow(ID, Number)
                        end
                        return u0.GetPotionShow(ID, Number)
                    end
                    return u0.GetAny({Type = "Armor", ID = ID, Number = Number})
                end
                return u0.GetAny({Type = "Weapon", ID = ID, Number = Number})
            end
            return u0.GetTimePowerShow(Number)
        end
        return u0.GetEcoShow(ID, Number)
    end
    return u0.GetEcoShow(Number)
end

function u0.ShowEco(a1, a2) -- Line: 129 -- upvalues: u0 (val)
    local v1, v2 = u0.GetEcoShow(a1, a2)
    ShowReward(v1, v2)
end

function u0.GetEcoShow(a1, a2) -- Line: 133 -- upvalues: GameSetting (val), AbbreviateNumber (val)
    local v1 = GameSetting.Icon[a1]
    if a1 == "coin" then
        return v1, "Coin +" .. AbbreviateNumber(a2)
    end
    if a1 == "power" then
        return v1, "Power +" .. AbbreviateNumber(a2)
    end
    if a1 == "diamond" then
        return v1, "Kills +" .. AbbreviateNumber(a2)
    end
    return v1, "+" .. AbbreviateNumber(a2)
end

function u0.ShowPotion(a1, a2) -- Line: 148 -- upvalues: u0 (val)
    local v1, v2 = u0.GetPotionShow(a1, a2)
    ShowReward(v1, v2)
end

function u0.GetPotionShow(a1, a2) -- Line: 152 -- upvalues: Helper_2 (val)
    return (Helper_2.GetImage(a1)), (Helper_2.GetDisName(a1)) .. " x" .. a2
end

function u0.ShowBoost(a1, a2) -- Line: 158 -- upvalues: u0 (val)
    local v1, v2 = u0.GetBoostShow(a1, a2)
    ShowReward(v1, v2)
end

function u0.GetBoostShow(a1, a2) -- Line: 162 -- upvalues: Helper (val)
    return (Helper.GetImage(a1)), (Helper.GetDesc(a1)) .. (" For %*min"):format((math.floor(a2 / 60)))
end

function u0.ShowOreShow(a1, a2) -- Line: 168 -- upvalues: u0 (val), AnyHelper (val), Helper_4 (val)
    local v1, v2 = u0.GetOreShow(a1, a2)
    local v3 = nil
    local v4 = AnyHelper.GetRarity("Ore", a1)
    if v4 then
        v3 = Helper_4.GetTextRarity(v4)
    end
    ShowReward(v1, v2, v3)
end

function u0.GetOreShow(a1, a2) -- Line: 178 -- upvalues: Helper_3 (val)
    return (Helper_3.GetImage(a1)), (Helper_3.GetDisName(a1)) .. " x" .. a2
end

function u0.ShowPotionPack(a1) -- Line: 184 -- upvalues: u0 (val)
    local v1, v2 = u0.GetPotionPackShow(a1)
    ShowReward(v1, v2)
end

function u0.GetPotionPackShow(a1) -- Line: 188 -- upvalues: GameSetting (val)
    return GameSetting.Icon.PotionPack, "x" .. a1
end

function u0.ShowTimePower(a1) -- Line: 194 -- upvalues: u0 (val)
    local v1, v2 = u0.GetTimePowerShow(a1)
    ShowReward(v1, v2)
end

function u0.GetTimePowerShow(a1) -- Line: 198
    -- upvalues: CalculateUtils (val), LocalPlayer (val), GameSetting (val), AbbreviateNumber (val)
    local v1 = CalculateUtils.CCTrainPowerByTime(LocalPlayer, a1)
    return GameSetting.Icon.power, (("Power +%*"):format((AbbreviateNumber(v1))))
end

function u0.ShowAny(a1) -- Line: 206 -- upvalues: u0 (val), AnyHelper (val), Helper_4 (val)
    local v1, v2 = u0.GetAny(a1)
    local Type = a1.Type
    local ID = a1.ID
    local v3 = nil
    if Type and ID then
        local v4 = AnyHelper.GetRarity(Type, ID)
        if v4 then
            v3 = Helper_4.GetTextRarity(v4)
        end
    end
    ShowReward(v1, v2, v3)
end

function u0.GetAny(a1) -- Line: 220 -- upvalues: AnyHelper (val)
    local Type = a1.Type
    local ID = a1.ID
    local Number = a1.Number
    local v1 = AnyHelper.GetImage(Type, ID)
    local v2 = AnyHelper.GetDisName(Type, ID)
    return v1, if not Number then v2 else if type(Number) ~= "number" then v2 else if not (Number > 0) then v2 else ("%* x%*"):format(v2, Number)
end

function u0.ShowGameSetting(a1, a2) -- Line: 239 -- upvalues: u0 (val), GameSetting (val)
    local v1, v2 = u0.GetGameSetting(a1, a2)
    local v3 = GameSetting.Rarity[a1] or "Common"
    ShowReward(v1, v2, v3)
end

function u0.GetGameSetting(a1, a2) -- Line: 245 -- upvalues: GameSetting (val)
    local v1 = GameSetting.Icon[a1]
    local v2 = GameSetting.DisName[a1] or a1
    return v1, if not a2 then v2 else if type(a2) ~= "number" then v2 else if not (a2 > 0) then v2 else ("%* x%*"):format(v2, a2)
end

local CanvasGroup = (LocalPlayer.PlayerGui:WaitForChild("Info"):WaitForChild("Gain")):WaitForChild("CanvasGroup")
local Temple = CanvasGroup:WaitForChild("Temple")
local u167 = {}

function ShowReward(a1, a2, a3) -- Line: 264 -- upvalues: u0 (val)
    if not a3 then
        a3 = "Common"
    end
    u0.AddLootQuery(a1, a2, a3)
end

function u0.AddLootQuery(a1, a2, a3) -- Line: 272 -- upvalues: Helper_4 (val), u167 (val), u0 (val)
    local v1 = {Number = 0, Image = a1, Rarity = a3 or "Common", Text = a2}
    v1.RarityLevel = Helper_4.GetRarityLevel(v1.Rarity)
    table.insert(u167, v1)
    task.spawn(function() -- Line: 281 -- upvalues: u0 (upval)
        u0.StartShowLoot()
    end)
end

function u0.StartShowLoot() -- Line: 285 -- upvalues: u130 (ref), u167 (val), u0 (val)
    if IsShowing then
        return
    end
    IsShowing = true
    repeat
        task.wait(0.05)
    until not u130

    local function ShowAndSort() -- Line: 295 -- upvalues: u167 (upval), u0 (upval)
        table.sort(u167, function(a1, a2) -- Line: 297
            return a2.RarityLevel < a1.RarityLevel
        end)
        local v1 = u167[1]
        table.remove(u167, 1)
        local Rarity = v1.Rarity
        local v2 = v1.Image or ""
        local v3 = v1.Text or ""
        local Number = v1.Number
        u0.CreateLoot(v2, v3, Rarity)
    end

    repeat
        ShowAndSort()
        task.wait(0.1)
    until #u167 == 0
    u0.EndShowLoot()
end

function u0.EndShowLoot() -- Line: 319
    if not IsShowing then
        return
    end
    IsShowing = false
end

function u0.CreateLoot(a1, a2, a3) -- Line: 325
    -- upvalues: SoundPlayer (val), Temple (val), CanvasGroup (val), TweenService (val), u0 (val)
    SoundPlayer.PlaySoundCopy("RewardShow")
    local u14 = Temple:WaitForChild(a3):Clone()
    u14.Parent = CanvasGroup
    u14.Visible = true
    local Main = u14:WaitForChild("Main")
    local Tex = Main:WaitForChild("Tex")
    local Icon = Tex:WaitForChild("Icon")
    Icon:WaitForChild("Icon").Image = a1
    Tex:WaitForChild("Text").Text = a2
    local Number = Tex:WaitForChild("Number")
    Number.Text = ""
    local Position = Main.Position
    Main.Position = UDim2.fromScale(1.5, 0.5)
    TweenService:Create(Main, TweenInfo.new(0.3), {Position = Position}):Play()
    task.delay(2.5, function() -- Line: 342 -- upvalues: u0 (upval), u14 (val)
        u0.DestroyLoot(u14)
    end)
end

function u0.DestroyLoot(a1) -- Line: 347 -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(0.3), {Size = UDim2.fromScale(0, 0)})
    v1:Play()
    v1.Completed:Wait()
    v1:Destroy()
    a1:Destroy()
end

function u0.StopShow() -- Line: 357 -- upvalues: u130 (ref)
    u130 = true
end

function u0.StartShow() -- Line: 360 -- upvalues: u130 (ref)
    u130 = false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.SellGUI
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.SellGUI
-- Decompile time: 13.71 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local UIController = require(ReplicatedStorage.Utils.UIController)
local AnyHelper = require(ReplicatedStorage.Config.AnyHelper)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local BalanceUtils = require(ReplicatedStorage.Utils.BalanceUtils)
local Helper = require(ReplicatedStorage.Config.Rarity.Helper)
local GameSetting = require(ReplicatedStorage.Config.GameSetting)
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Sell = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("Sell")
local ScrollingFrame = (Sell:WaitForChild("zheng")):WaitForChild("ScrollingFrame")
local Bottom = Sell:WaitForChild("Bottom")
local TextButton = (Sell:WaitForChild("De")):WaitForChild("TextButton")
local u77 = {}
local AbbreviateNumber = AbbNumber.AbbreviateNumber

function u0.init() end

function u0.start() -- Line: 33
    -- upvalues: BackpackData (val), Sell (val), u0 (val), TextButton (val), ScrollingFrame (val), Bottom (val)
    BackpackData.AddCallback(function() -- Line: 34 -- upvalues: Sell (upval), u0 (upval)
        if Sell.Visible then
            u0.update()
        end
    end)
    TextButton.MouseButton1Down:Connect(function() -- Line: 39 -- upvalues: u0 (upval)
        u0.close()
    end)
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    ;(Bottom:WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 49 -- upvalues: BackpackData (upval)
        BackpackData.SellAll()
    end)
end

function u0.update() -- Line: 53 -- upvalues: BackpackData (val), u77 (val), u0 (val)
    local v1 = BackpackData.GetData()
    local v2 = nil
    local v3 = nil
    for i, j in u77, v2, v3 do
        if not v1.have[i] or BackpackData.IsEquipedUUID(i) then
            u0.DestroySellFrame(i)
        end
    end
    v2 = nil
    v3 = nil
    for k, n in v1.have, v2, v3 do
        if u77[k] or BackpackData.IsEquipedUUID(k) then
            u0.UpdateSellFrame(k, n)
        else
            u0.CreateSellFrame(k, n)
        end
    end
end

function u0.CreateSellFrame(a1, a2) -- Line: 73
    -- upvalues: BackpackData (val), AnyHelper (val), BalanceUtils (val), LocalPlayer (val), Helper (val)
    -- upvalues: ScrollingFrame (val), AbbreviateNumber (val), GameSetting (val), u77 (val), u0 (val)
    local Type = a2.Type
    local ID = a2.ID
    local Number = a2.Number
    local Lock = a2.Lock
    local v1 = BackpackData.GetConfigType(Type)
    local v2 = AnyHelper.GetPrice(v1, ID)
    v2 = AnyHelper.GetImage(v1, ID) or ""
    local v3 = AnyHelper.GetDisName(v1, ID) or ""
    local v4 = AnyHelper.GetSellPrice(v1, ID) or 0
    local v5 = BalanceUtils.GetStatsBoost(LocalPlayer, "Coin")
    if v4 and not (v4 <= 0) then
        local v6 = Helper.GetTextRarity(AnyHelper.GetRarity(v1, ID) or "Common")
        local v7 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild(v6):Clone()
        v7.Parent = ScrollingFrame
        v7.Name = a1
        v7.Visible = not Lock
        local Frame = ((v7:WaitForChild("Main")):WaitForChild("Main")):WaitForChild("Frame")
        local anniu = Frame:WaitForChild("anniu")
        local zuo = Frame:WaitForChild("zuo")
        local Button = (anniu:WaitForChild("LUO")):WaitForChild("Button")
        local Button_2 = (anniu:WaitForChild("Bottom")):WaitForChild("Button")
        local TextLabel = (Button:WaitForChild("Frame")):WaitForChild("TextLabel")
        TextLabel.Text = ("%*"):format((AbbreviateNumber((math.round(v4 * v5)))))
        local ImageLabel = (Button:WaitForChild("Frame")):WaitForChild("ImageLabel")
        ImageLabel.Image = GameSetting.Icon.Coin
        if v5 > 1 then
            local TextLabel_2 = (Button:WaitForChild("Frame")):WaitForChild("TextLabel")
            TextLabel_2.TextColor3 = Color3.fromRGB(0, 255, 94)
        end
        local Im = zuo:WaitForChild("Im")
        Im:WaitForChild("ImageLabel").Image = v2
        local TextLa = (zuo:WaitForChild("Im")):WaitForChild("TextLa")
        TextLa.Text = Number and ("x%*"):format(Number) or ""
        local ming = zuo:WaitForChild("ming")
        ming:WaitForChild("TextLa").Text = v6
        local ming_2 = zuo:WaitForChild("ming")
        ming_2:WaitForChild("TextLabel").Text = v3
        if not Number or Number <= 1 then
            local Bottom_2 = anniu:WaitForChild("Bottom")
            Bottom_2.Visible = false
        end
        Button.MouseButton1Down:Connect(function() -- Line: 125 -- upvalues: BackpackData (upval), a1 (val)
            BackpackData.TrySellItem(a1, 1)
        end)
        Button_2.MouseButton1Down:Connect(function() -- Line: 128 -- upvalues: BackpackData (upval), a1 (val)
            BackpackData.TrySellItem(a1, 9999)
        end)
        u77[a1] = {
            Frame = v7,
            Data = a2,
            OriSellPrice = AnyHelper.GetSellPrice(v1, ID),
            NumberText = (zuo:WaitForChild("Im")):WaitForChild("TextLa"),
        }
        u0.UpdateSellFrame(a1, a2)
        return
    end
end

function u0.UpdateSellFrame(a1, a2) -- Line: 140
    -- upvalues: u77 (val), u0 (val), BalanceUtils (val), LocalPlayer (val), AbbreviateNumber (val)
    if not u77[a1] then
        u0.DestroySellFrame(a1)
        return
    end
    u77[a1].Data = a2
    local Number = u77[a1].Data.Number
    local Lock = u77[a1].Data.Lock
    local NumberText = u77[a1].NumberText
    NumberText.Text = Number and ("x%*"):format(Number) or ""
    local OriSellPrice = u77[a1].OriSellPrice
    local Button = ((((u77[a1].Frame:WaitForChild("Main")):WaitForChild("Main")):WaitForChild("Frame")):WaitForChild("anniu"):WaitForChild("LUO")):WaitForChild("Button")
    local v1 = BalanceUtils.GetStatsBoost(LocalPlayer, "Coin")
    local TextLabel = (Button:WaitForChild("Frame")):WaitForChild("TextLabel")
    TextLabel.Text = ("%*"):format((AbbreviateNumber((math.round(OriSellPrice * v1)))))
    u77[a1].Frame.Visible = not Lock
end

function u0.DestroySellFrame(a1) -- Line: 163 -- upvalues: u77 (val)
    if u77[a1] then
        u77[a1].Frame:Destroy()
        u77[a1] = nil
    end
end

function u0.open() -- Line: 170 -- upvalues: UIController (val), Sell (val), u0 (val)
    UIController.openScreen(Sell.Name)
    u0.update()
end

function u0.close() -- Line: 174 -- upvalues: UIController (val), Sell (val)
    UIController.closeScreen(Sell.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.Setting
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.Setting
-- Decompile time: 10.29 ms

local u0 = {}
local ReplicatedStorage = game.ReplicatedStorage
local LocalPlayer = game.Players.LocalPlayer
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
local Setting = Main:WaitForChild("Setting")
local TextButton = (Setting:WaitForChild("De")):WaitForChild("TextButton")
local ScrollingFrame = ((Setting:WaitForChild("zheng")):WaitForChild("wuqi")):WaitForChild("ScrollingFrame")
local OFF = ((ScrollingFrame:WaitForChild("MusicVolume")):WaitForChild("Main")):WaitForChild("OFF")
local ON = ((ScrollingFrame:WaitForChild("MusicVolume")):WaitForChild("Main")):WaitForChild("ON")
local OFF_2 = ((ScrollingFrame:WaitForChild("SoundVolume")):WaitForChild("Main")):WaitForChild("OFF")
local ON_2 = ((ScrollingFrame:WaitForChild("SoundVolume")):WaitForChild("Main")):WaitForChild("ON")
local OFF_3 = ((ScrollingFrame:WaitForChild("ShadowEnabled")):WaitForChild("Main")):WaitForChild("OFF")
local ON_3 = ((ScrollingFrame:WaitForChild("ShadowEnabled")):WaitForChild("Main")):WaitForChild("ON")
local OFF_4 = ((ScrollingFrame:WaitForChild("OtherSkillEnabled")):WaitForChild("Main")):WaitForChild("OFF")
local ON_4 = ((ScrollingFrame:WaitForChild("OtherSkillEnabled")):WaitForChild("Main")):WaitForChild("ON")
local FeedBack = ScrollingFrame:WaitForChild("FeedBack")
local UIController = require(ReplicatedStorage.Utils.UIController)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local BGMUtils = require(ReplicatedStorage.Utils.BGMUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u163 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetRemoteEvent("Feedback", "FeedbackRE")
local u164 = true
local u165 = true
local u166 = true
local u167 = false
local Button = (((Hud:WaitForChild("RightTop")):WaitForChild("Button")):WaitForChild("Setting")):WaitForChild("Button")

function u0.init() -- Line: 63 -- upvalues: Button (val), u0 (val)
    local Setting = game.Workspace:FindFirstChild("Setting")
    if not Setting then
        Setting = Instance.new("Folder")
        Setting.Name = "Setting"
        Setting.Parent = game.Workspace
    end
    if not Setting:FindFirstChild("SceneEffect") then
        local BoolValue = Instance.new("BoolValue")
        BoolValue.Name = "SceneEffect"
        BoolValue.Parent = Setting
        BoolValue.Value = true
    end
    Button.MouseButton1Down:Connect(function() -- Line: 78 -- upvalues: u0 (upval)
        u0.open()
    end)
end

function u0.start() -- Line: 84
    -- upvalues: TextButton (val), u0 (val), OFF (val), u165 (ref), BGMUtils (val), ON (val), OFF_2 (val), u164 (ref)
    -- upvalues: SoundPlayer (val), ON_2 (val), ON_3 (val), u166 (ref), OFF_3 (val), ON_4 (val), u167 (ref), OFF_4 (val)
    -- upvalues: FeedBack (val), u163 (val)
    TextButton.MouseButton1Click:Connect(function() -- Line: 88 -- upvalues: u0 (upval)
        u0.close()
    end)
    OFF.MouseButton1Click:Connect(function() -- Line: 92 -- upvalues: u165 (upval), BGMUtils (upval), u0 (upval)
        u165 = true
        BGMUtils.setBGM(u165)
        u0.update()
    end)
    ON.MouseButton1Click:Connect(function() -- Line: 98 -- upvalues: u165 (upval), BGMUtils (upval), u0 (upval)
        u165 = false
        BGMUtils.setBGM(u165)
        u0.update()
    end)
    OFF_2.MouseButton1Click:Connect(function() -- Line: 104 -- upvalues: u164 (upval), SoundPlayer (upval), u0 (upval)
        u164 = true
        SoundPlayer.setSoundVolume(u164)
        u0.update()
    end)
    ON_2.MouseButton1Click:Connect(function() -- Line: 110 -- upvalues: u164 (upval), SoundPlayer (upval), u0 (upval)
        u164 = false
        SoundPlayer.setSoundVolume(u164)
        u0.update()
    end)
    ON_3.MouseButton1Click:Connect(function() -- Line: 127 -- upvalues: u166 (upval), u0 (upval)
        u166 = false
        u0.ShadowControl(false)
        u0.update()
    end)
    OFF_3.MouseButton1Click:Connect(function() -- Line: 132 -- upvalues: u166 (upval), u0 (upval)
        u166 = true
        u0.ShadowControl(true)
        u0.update()
    end)
    ON_4.MouseButton1Click:Connect(function() -- Line: 139 -- upvalues: u167 (upval), u0 (upval)
        u167 = false
        workspace:SetAttribute("HideOtherSkill", false)
        u0.update()
    end)
    OFF_4.MouseButton1Click:Connect(function() -- Line: 144 -- upvalues: u167 (upval), u0 (upval)
        u167 = true
        workspace:SetAttribute("HideOtherSkill", true)
        u0.update()
    end)
    local TextBox = ((FeedBack:WaitForChild("Input")):WaitForChild("Texter")):WaitForChild("TextBox")
    TextBox.MultiLine = true
    TextBox.TextWrapped = true
    ;((FeedBack:WaitForChild("Submit")):WaitForChild("Button")).MouseButton1Click:Connect(function() -- Line: 155 -- upvalues: TextBox (val), u163 (upval)
        local Text = TextBox.Text
        TextBox.Text = ""
        u163:FireServer(Text)
    end)
    u0.update()
end

function u0.update() -- Line: 165
    -- upvalues: ON_2 (val), u164 (ref), OFF_2 (val), ON (val), u165 (ref), OFF (val), ON_3 (val), u166 (ref)
    -- upvalues: OFF_3 (val), ON_4 (val), u167 (ref), OFF_4 (val)
    ON_2.Visible = u164
    OFF_2.Visible = not u164
    ON.Visible = u165
    OFF.Visible = not u165
    ON_3.Visible = u166
    OFF_3.Visible = not u166
    ON_4.Visible = u167
    OFF_4.Visible = not u167
end

function u0.open() -- Line: 184 -- upvalues: UIController (val), Setting (val)
    UIController.openScreen(Setting.Name)
end

function u0.close() -- Line: 188 -- upvalues: UIController (val), Setting (val)
    UIController.closeScreen(Setting.Name)
end

local u190 = Trove.new()
local u191 = {}

function u0.EmitterControl(a1) -- Line: 194 -- upvalues: u191 (ref), u190 (val)
    if a1 then
        for k, n in u191 do
            if k and k.Parent and n and n.Parent then
                k.Parent = n
            end
        end
        u190:Clean()
        u191 = {}
        return
    end
    for i, j in game.Workspace:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") then
            u191[j] = j.Parent
            j.Parent = script
        end
    end
    u190:Add((game.Workspace.DescendantAdded:Connect(function(a1) -- Line: 215 -- upvalues: u191 (upval)
        if a1:IsA("ParticleEmitter") or a1:IsA("Trail") then
            u191[a1] = a1.Parent
            a1.Parent = script
        end
    end)))
end

Trove.new()

function u0.ShadowControl(a1) -- Line: 226
    game:GetService("Lighting").GlobalShadows = a1
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.Shop
-- Took 0.03s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.Shop
-- Decompile time: 35.58 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
local Main = PlayerGui:WaitForChild("Main")
local Hud = PlayerGui:WaitForChild("Hud")
PlayerGui:WaitForChild("Info")
local Shop = Main:WaitForChild("Shop")
local ScrollingFrame = (Shop:WaitForChild("wuqi")):WaitForChild("zheng"):WaitForChild("ScrollingFrame")
local Shop_2 = ((Hud:WaitForChild("Left")):WaitForChild("Buttons")):WaitForChild("Shop")
local TextButton = (Shop:WaitForChild("De")):WaitForChild("TextButton")
local Gamepass = ScrollingFrame:WaitForChild("Gamepass")
local Potion = ScrollingFrame:WaitForChild("Potion")
local PowerPack = ScrollingFrame:WaitForChild("PowerPack")
local TrainArea = ScrollingFrame:WaitForChild("TrainArea")
local StarterPack = ScrollingFrame:WaitForChild("StarterPack")
local GearPack_1 = ScrollingFrame:WaitForChild("GearPack_1")
local Code = ScrollingFrame:WaitForChild("Code")
require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.GuiUtils.Message)
local RewardShow = require(ReplicatedStorage.GuiUtils.RewardShow)
local AnyInfoGUI = require(ReplicatedStorage.GuiUtils.AnyInfoGUI)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local UIController = require(ReplicatedStorage.Utils.UIController)
require(ReplicatedStorage.Utils.TimeFormatUntil)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
require(ReplicatedStorage.Config.GameSetting)
local Helper = require(ReplicatedStorage.Config.Potion.Helper)
local Helper_2 = require(ReplicatedStorage.Config.Weapon.Helper)
local Helper_3 = require(ReplicatedStorage.Config.PlrSkill.Helper)
local PemData = require(ReplicatedStorage.LocalData.PemData)
local PotionData = require(ReplicatedStorage.LocalData.PotionData)
local RichTextUtils = require(ReplicatedStorage.Utils.RichTextUtils)
local MarketUtils = require(ReplicatedStorage.Utils.MarketUtils)
local SkillShowGUI = require(ReplicatedStorage.GuiUtils.SkillShowGUI)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local getDianDianNumber = AbbNumber.getDianDianNumber
local u171 = CommunicationUtils.TryGetRemoteEvent("Shop", "UpdateGamePassRE")
local u175 = CommunicationUtils.TryGetRemoteFunction("Code", "TryUseCodeRF")
local u176 = {}
local u178 = Trove.new()
local u179 = {}

function u0.updateGamePass() -- Line: 71
    -- upvalues: u178 (val), Gamepass (val), u179 (val), PemData (val), MarketUtils (val)
    local Button, Button_2, LIWU, Val
    u178:Clean()
    for i, j in ((Gamepass:WaitForChild("Main")):WaitForChild("Main")):WaitForChild("Others"):GetChildren() do
        if j:IsA("Frame") then
            u179[j.Name] = j
        end
    end
    u179.VIP = (((Gamepass:WaitForChild("Main")):WaitForChild("VIP")):WaitForChild("Title")):WaitForChild("VIP")
    local v1 = nil
    local v2 = nil
    for k, n in u179, v1, v2 do
        if n:IsA("Frame") then
            Button = n:WaitForChild("Button")
            Button_2 = ((Button:WaitForChild("Left")):WaitForChild("Buy")):WaitForChild("Button")
            LIWU = ((Button:WaitForChild("Left")):WaitForChild("Buy")):WaitForChild("LIWU")
            Val = (Button_2:WaitForChild("Frame")):WaitForChild("Val")
            if not PemData.isHavePem(k) then
                Val.Text = MarketUtils.GetCost(k)
                u178:Add((Button_2.MouseButton1Click:Connect(function() -- Line: 101 -- upvalues: MarketUtils (upval), k (val)
                    MarketUtils.TryBuy(k)
                end)))
            else
                Val.Text = "Own"
            end
            u178:Add((LIWU.MouseButton1Click:Connect(function() -- Line: 105 -- upvalues: MarketUtils (upval), k (val)
                MarketUtils.OpenGiftUI(k)
            end)))
        end
    end
end

local u182 = Trove.new()

function u0.updatePotion() -- Line: 112
    -- upvalues: u182 (val), Potion (val), Helper (val), PotionData (val), MarketUtils (val)
    local Buy, LIWU, PackName, Use, Val, Val_2, v1, v2, v3
    u182:Clean()
    for i, j in (Potion:WaitForChild("Main")):WaitForChild("Main"):GetChildren() do
        if j:IsA("Frame") then
            local Name = j.Name
            v1 = Helper.GetDisName(Name)
            v2 = Helper.GetDesc(Name)
            v3 = PotionData.GetData()[Name] or 0
            j:WaitForChild("PackName").Text = v1
            PackName = j:WaitForChild("PackName")
            PackName:WaitForChild("PackName").Text = v1
            j:WaitForChild("TextLabel").Text = v2
            Use = j:WaitForChild("Use")
            Buy = j:WaitForChild("Buy")
            LIWU = j:WaitForChild("LIWU")
            Val = Use:WaitForChild("Val")
            Val.Text = ("x%*"):format(v3)
            Val_2 = (Buy:WaitForChild("Frame")):WaitForChild("Val")
            Val_2.Text = MarketUtils.GetCost(Name .. "_1")
            u182:Add((Use.MouseButton1Click:Connect(function() -- Line: 140 -- upvalues: PotionData (upval), Name (val)
                PotionData.UsePotion(Name, 1)
            end)))
            u182:Add((Buy.MouseButton1Click:Connect(function() -- Line: 143 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.TryBuy(Name .. "_1")
            end)))
            u182:Add((LIWU.MouseButton1Click:Connect(function() -- Line: 146 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.OpenGiftUI(Name .. "_1")
            end)))
        end
    end
end

local Main_3 = (PowerPack:WaitForChild("Main")):WaitForChild("Main")
local u192 = {}
local Money1 = (Main_3:WaitForChild("1-3")):WaitForChild("Money1")
local Money2 = (Main_3:WaitForChild("1-3")):WaitForChild("Money2")
local Money3 = (Main_3:WaitForChild("1-3")):WaitForChild("Money3")
local v1 = Main_3:WaitForChild("4-5")
u192[1] = Money1
u192[2] = Money2
u192[3] = Money3
u192[4] = v1:WaitForChild("Money5")

function u0.updatePowerPack() -- Line: 159 -- upvalues: u192 (val), MarketUtils (val)
    local Frame, Frame_2, v1
    for i, j in u192 do
        local u12 = "PowerPack_" .. i
        v1 = MarketUtils.GetCost(u12)
        Frame = j:WaitForChild("Frame")
        ;((Frame:WaitForChild("Buy")):WaitForChild("Button")).MouseButton1Click:Connect(function() -- Line: 167 -- upvalues: MarketUtils (upval), u12 (val)
            MarketUtils.TryBuy(u12)
        end)
        ;((Frame:WaitForChild("Buy")):WaitForChild("LIWU")).MouseButton1Click:Connect(function() -- Line: 171 -- upvalues: MarketUtils (upval), u12 (val)
            MarketUtils.OpenGiftUI(u12)
        end)
        Frame_2 = ((Frame:WaitForChild("Buy")):WaitForChild("Button")):WaitForChild("Frame")
        Frame_2:WaitForChild("Val").Text = v1
    end
end

function u0.RealUpdatePowerPack() -- Line: 180 -- upvalues: u192 (val), MarketUtils (val), RewardShow (val)
    local Frame, TextLabel_2, v1, v2
    for i, j in u192 do
        v1 = "PowerPack_" .. i
        Frame = j:WaitForChild("Frame")
        _, v2 = RewardShow.GetTimePowerShow((MarketUtils.GetMonConfig("PowerPack", i)))
        v2 = v2:split(" ")[2]
        Frame:WaitForChild("TextLabel").Text = v2
        if (Frame:WaitForChild("TextLabel")):FindFirstChild("TextLabel") then
            TextLabel_2 = Frame:WaitForChild("TextLabel")
            TextLabel_2:FindFirstChild("TextLabel").Text = v2
        end
    end
end

function u0.updateStartPack() -- Line: 199
    -- upvalues: StarterPack (val), PemData (val), MarketUtils (val), Helper_2 (val), AnyInfoGUI (val), Helper_3 (val)
    local Attribute, Button_2, ID, ImageLabel, LIWU, Percent, Title, Val, Weapon, v1, v2, v3, v4, v5, v6
    local Frame = StarterPack:WaitForChild("Frame")
    for i, j in Frame:GetChildren() do
        if j:IsA("Frame") and j.Name ~= "Top" then
            local Name = j.Name
            local SkillLoots = j:WaitForChild("SkillLoots")
            SkillLoots.Visible = false
            Button_2 = (((j:WaitForChild("Frame")):WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("Button")
            LIWU = (((j:WaitForChild("Frame")):WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("LIWU")
            Button_2.MouseButton1Down:Connect(function() -- Line: 220 -- upvalues: PemData (upval), Name (val), MarketUtils (upval)
                if not PemData.isHavePem(Name) then
                    MarketUtils.TryBuy(Name)
                end
            end)
            LIWU.MouseButton1Down:Connect(function() -- Line: 225 -- upvalues: MarketUtils (upval), Name (val)
                MarketUtils.OpenGiftUI(Name)
            end)
            Val = (Button_2:WaitForChild("Frame")):WaitForChild("Val")
            Val.Text = MarketUtils.GetCost(Name)
            Weapon = ((j:WaitForChild("Frame")):WaitForChild("PetInfo")):WaitForChild("Weapon")
            Attribute = Weapon:GetAttribute("WeaponID")
            v1 = Helper_2.GetSmallType(Attribute)
            v2 = Helper_2.GetSkillLootID(Attribute)
            ;(Weapon:WaitForChild("?")).MouseButton1Down:Connect(function() -- Line: 240 -- upvalues: SkillLoots (val)
                SkillLoots.Visible = not SkillLoots.Visible
            end)
            AnyInfoGUI.LoadFrame(Weapon, {Type = "Weapon", ID = Attribute})
            v3 = Helper_3.GetWeaponSkillLoots(v1, v2)
            local u210 = 0
            v4 = {}
            for k, n in v3 do
                u210 = u210 + n
                table.insert(v4, {Weight = n, ID = k, Layout = Helper_3.GetSkillLevelLayout(k)})
            end
            table.sort(v4, function(a1, a2) -- Line: 258 -- upvalues: u210 (ref)
                a1.Percent = a1.Weight / u210
                a2.Percent = a2.Weight / u210
                return a1.Layout < a2.Layout
            end)
            for m, i5 in v4 do
                v5 = (SkillLoots:WaitForChild("xinxi")):FindFirstChild(m)
                if v5 then
                    ID = i5.ID
                    Percent = i5.Percent
                    v6 = Helper_3.GetSkillLevelImage(ID)
                    v5:WaitForChild("ImageLabel").Image = v6
                    ImageLabel = (v5:WaitForChild("Level")):WaitForChild("ImageLabel")
                    ImageLabel.Image = ""
                    Title = v5:WaitForChild("Title")
                    Title.Text = ("%*%%"):format((math.round(Percent * 1000)) / 10)
                end
            end
        end
    end

    local function Check() -- Line: 281 -- upvalues: Frame (val), PemData (upval), MarketUtils (upval)
        local Button_2, Name, Val, Val_2, off, off_2
        for i, j in Frame:GetChildren() do
            if j:IsA("Frame") and j.Name ~= "Top" then
                Name = j.Name
                Button_2 = (((j:WaitForChild("Frame")):WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("Button")
                if not PemData.isHavePem(Name) then
                    Val_2 = (Button_2:WaitForChild("Frame")):WaitForChild("Val")
                    Val_2.Text = MarketUtils.GetCost(Name)
                    off_2 = Button_2:WaitForChild("off")
                    off_2.Visible = true
                else
                    Val = (Button_2:WaitForChild("Frame")):WaitForChild("Val")
                    Val.Text = "Own"
                    off = Button_2:WaitForChild("off")
                    off.Visible = false
                end
            end
        end
    end

    PemData.AddCallback(Check)
    Check()
end

function u0.updateGearPack_1() -- Line: 308
    -- upvalues: GearPack_1 (val), MarketUtils (val), AnyInfoGUI (val), RichTextUtils (val), SkillShowGUI (val)
    local Main_2 = ((GearPack_1:WaitForChild("Main")):WaitForChild("Frame")):WaitForChild("Main")
    local Button_2 = (((Main_2:WaitForChild("Frame")):WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("Button")
    local LIWU = (((Main_2:WaitForChild("Frame")):WaitForChild("Button")):WaitForChild("Buy")):WaitForChild("LIWU")
    Button_2.MouseButton1Down:Connect(function() -- Line: 318 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_1")
    end)
    LIWU.MouseButton1Down:Connect(function() -- Line: 321 -- upvalues: MarketUtils (upval)
        MarketUtils.OpenGiftUI("GearSet_1")
    end)
    local Val = (Button_2:WaitForChild("Frame")):WaitForChild("Val")
    Val.Text = MarketUtils.GetCost("GearSet_1")
    local Weapon = ((Main_2:WaitForChild("Frame")):WaitForChild("PetInfo")):WaitForChild("Weapon")
    local Hat = ((Main_2:WaitForChild("Frame")):WaitForChild("PetInfo")):WaitForChild("Hat")
    local Armor = ((Main_2:WaitForChild("Frame")):WaitForChild("PetInfo")):WaitForChild("Armor")
    local Other = ((Main_2:WaitForChild("Frame")):WaitForChild("PetInfo")):WaitForChild("Other")
    ;(Weapon:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 337 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_1_Weapon")
    end)
    ;(Hat:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 340 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_1_Hat")
    end)
    ;(Armor:WaitForChild("Button")).MouseButton1Up:Connect(function() -- Line: 343 -- upvalues: MarketUtils (upval)
        MarketUtils.TryBuy("GearSet_1_Armor")
    end)
    AnyInfoGUI.LoadFrame(Weapon, {Type = "Weapon", ID = "K_1002"})
    AnyInfoGUI.LoadFrame(Hat, {Type = "Hat", ID = "HHat_1001"})
    AnyInfoGUI.LoadFrame(Armor, {Type = "Armor", ID = "HArmor_1001"})
    AnyInfoGUI.LoadFrame(Other, {
        Text = ("Tower Ticket %*."):format((RichTextUtils.RichToColor("x50", (Color3.fromRGB(0, 255, 0))))),
    })
    AnyInfoGUI.LoadFrame(Weapon:WaitForChild("Name"), {Type = "Weapon", ID = "K_1002"})
    AnyInfoGUI.LoadFrame(Hat:WaitForChild("Name"), {Type = "Hat", ID = "HHat_1001"})
    AnyInfoGUI.LoadFrame(Armor:WaitForChild("Name"), {Type = "Armor", ID = "HArmor_1001"})
    AnyInfoGUI.LoadFrame(Other:WaitForChild("Name"), {
        Text = ("Tower Ticket %*."):format((RichTextUtils.RichToColor("x50", (Color3.fromRGB(0, 255, 0))))),
    })
    ;(((Main_2:WaitForChild("Frame")):WaitForChild("Skill")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 366 -- upvalues: SkillShowGUI (upval)
        SkillShowGUI.StartShowSkill("K_Skill_1001")
    end)
end

local u229 = {}
u229.AutoTrainArea_9 = (((TrainArea:WaitForChild("Main")):WaitForChild("1")):WaitForChild("Input")):WaitForChild("Frame")
u229.AutoTrainArea_10 = ((((TrainArea:WaitForChild("Main")):WaitForChild("2")):WaitForChild("10")):WaitForChild("Button")):WaitForChild("CanvasGroup")
u229.AutoTrainArea_11 = ((((TrainArea:WaitForChild("Main")):WaitForChild("2")):WaitForChild("11")):WaitForChild("Button")):WaitForChild("CanvasGroup")

function u0.updateTrainArea() -- Line: 382 -- upvalues: u229 (val), PemData (val), MarketUtils (val)
    local Button, LIWU
    for i, j in u229 do
        Button = ((j:WaitForChild("Left")):WaitForChild("Buy")):WaitForChild("Button")
        LIWU = ((j:WaitForChild("Left")):WaitForChild("Buy")):WaitForChild("LIWU")
        Button.MouseButton1Down:Connect(function() -- Line: 387 -- upvalues: PemData (upval), i (val), MarketUtils (upval)
            if not PemData.isHavePem(i) then
                MarketUtils.TryBuy(i)
            end
        end)
        LIWU.MouseButton1Down:Connect(function() -- Line: 392 -- upvalues: MarketUtils (upval), i (val)
            MarketUtils.OpenGiftUI(i)
        end)
    end

    local function Check() -- Line: 397 -- upvalues: u229 (upval), PemData (upval), MarketUtils (upval)
        local Button, Val, Val_2
        for i, j in u229 do
            Button = ((j:WaitForChild("Left")):WaitForChild("Buy")):WaitForChild("Button")
            if not PemData.isHavePem(i) then
                Val_2 = (Button:WaitForChild("Frame")):WaitForChild("Val")
                Val_2.Text = MarketUtils.GetCost(i)
            else
                Val = (Button:WaitForChild("Frame")):WaitForChild("Val")
                Val.Text = "Own"
            end
        end
    end

    PemData.AddCallback(Check)
    Check()
end

function u0.updateCode() -- Line: 414 -- upvalues: Code (val), u175 (val)
    local TextBox = ((((Code:WaitForChild("Main")):WaitForChild("Main")):WaitForChild("Input")):WaitForChild("Texter")):WaitForChild("TextBox")
    ;((((Code:WaitForChild("Main")):WaitForChild("Main")):WaitForChild("Submit")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 419 -- upvalues: TextBox (val), u175 (upval)
        local Text = TextBox.Text
        TextBox.Text = ""
        u175:InvokeServer(Text)
    end)
end

function u0.close() -- Line: 426 -- upvalues: UIController (val), Shop (val)
    UIController.closeScreen(Shop.Name)
end

function u0.open() -- Line: 431 -- upvalues: UIController (val), Shop (val), u0 (val)
    UIController.openScreen(Shop.Name)
    u0.RealUpdatePowerPack()
end

function u0.init() end

function u0.start() -- Line: 441
    -- upvalues: ScrollingFrame (val), u176 (val), PotionData (val), u0 (val), u171 (val), Shop_2 (val)
    -- upvalues: TextButton (val), PemData (val), Hud (val)
    local LayoutOrder
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            LayoutOrder = j.LayoutOrder
            table.insert(u176, {Frame = j, Layout = LayoutOrder})
        end
    end
    table.sort(u176, function(a1, a2) -- Line: 465
        return a1.Layout < a2.Layout
    end)
    PotionData.AddCallback(function() -- Line: 469 -- upvalues: u0 (upval)
        u0.updatePotion()
    end)
    u171.OnClientEvent:Connect(function() -- Line: 472 -- upvalues: u0 (upval)
        u0.updateGamePass()
    end)
    Shop_2.MouseButton1Down:Connect(function() -- Line: 475 -- upvalues: u0 (upval)
        u0.open()
    end)
    TextButton.MouseButton1Click:Connect(function() -- Line: 478 -- upvalues: u0 (upval)
        u0.close()
    end)
    u0.updatePotion()
    u0.updateGamePass()
    u0.updatePowerPack()
    u0.updateStartPack()
    u0.updateTrainArea()
    u0.updateGearPack_1()
    u0.updateCode()
    u0.JumpToFrame("GearPack_1")
    PemData.AddCallback(function() -- Line: 491 -- upvalues: PemData (upval), Hud (upval)
        if PemData.isHavePem("SoulPack") then
            pcall(function() -- Line: 493 -- upvalues: Hud (upval)
                if (((Hud:WaitForChild("Right")):WaitForChild("Pack")):WaitForChild("Info")):FindFirstChild("SoulPack") then
                    (((Hud:WaitForChild("Right")):WaitForChild("Pack")):WaitForChild("Info")):FindFirstChild("SoulPack"):Destroy()
                end
                if (workspace:WaitForChild("TOUCHED")):FindFirstChild("SoulPack") then
                    (workspace:WaitForChild("TOUCHED")):WaitForChild("SoulPack"):Destroy()
                end
            end)
        end
    end)
    if PemData.isHavePem("SoulPack") then
        pcall(function() -- Line: 508 -- upvalues: Hud (upval)
            (((Hud:WaitForChild("Right")):WaitForChild("Pack")):WaitForChild("Info")):WaitForChild("SoulPack"):Destroy()
            if (workspace:WaitForChild("TOUCHED")):FindFirstChild("SoulPack") then
                (workspace:WaitForChild("TOUCHED")):WaitForChild("SoulPack"):Destroy()
            end
        end)
    end
end

function u0.ToGamePass() -- Line: 520 -- upvalues: TweenService (val), ScrollingFrame (val)
    TweenService:Create(ScrollingFrame, TweenInfo.new(0.3), {CanvasPosition = Vector2.new(0, 0)}):Play()
end

function u0.ToPotion() -- Line: 526 -- upvalues: ScrollingFrame (val), TweenService (val)
    local Y = (ScrollingFrame:WaitForChild("GamePass")).AbsoluteSize.Y
    TweenService:Create(ScrollingFrame, TweenInfo.new(0.3), {CanvasPosition = Vector2.new(0, Y)}):Play()
end

function u0.JumpToFrame(a1, a2) -- Line: 534 -- upvalues: u176 (val), TweenService (val), ScrollingFrame (val)
    local v1 = 0
    if not a2 then
        a2 = 0
    end
    for i, j in u176 do
        if j.Frame.Name == a1 then
            TweenService:Create(ScrollingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {CanvasPosition = Vector2.new(0, v1 + a2)}):Play()
            return
        end
        v1 = v1 + j.Frame.AbsoluteSize.Y
    end
    print((("没有%*页面"):format(a1)))
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.UpgradeGUI
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.UpgradeGUI
-- Decompile time: 5.67 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
require(ReplicatedStorage.Utils.UIController)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local UIController = require(ReplicatedStorage.Utils.UIController)
local LeftInfoGUI = require(ReplicatedStorage.GuiUtils.LeftInfoGUI)
local UpgradeData = require(ReplicatedStorage.LocalData.UpgradeData)
local Helper = require(ReplicatedStorage.Config.Upgrade.Helper)
LocalPlayer.PlayerGui:WaitForChild("Hud")
local Upgrade = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("Upgrade")
local ScrollingFrame = (Upgrade:WaitForChild("zheng")):WaitForChild("ScrollingFrame")
local TextButton = (Upgrade:WaitForChild("De")):WaitForChild("TextButton")
local AbbreviateNumber = AbbNumber.AbbreviateNumber

function u0.init() end

function u0.start() -- Line: 31
    -- upvalues: TextButton (val), u0 (val), UpgradeData (val), LeftInfoGUI (val), ScrollingFrame (val)
    TextButton.MouseButton1Down:Connect(function() -- Line: 32 -- upvalues: u0 (upval)
        u0.close()
    end)
    UpgradeData.AddCallback(function() -- Line: 36 -- upvalues: u0 (upval), LeftInfoGUI (upval)
        u0.update()
        LeftInfoGUI.UpdateOrePack(0)
    end)
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            local Name = j.Name
            ;((((j:WaitForChild("Frame")):WaitForChild("hou2")):WaitForChild("Button"):WaitForChild("Price")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 47 -- upvalues: UpgradeData (upval), Name (val)
                UpgradeData.UpgradeOnce(Name)
            end)
        end
    end
    u0.update()
end

function u0.update() -- Line: 54
    -- upvalues: UpgradeData (val), ScrollingFrame (val), Helper (val), AbbreviateNumber (val)
    local Name, Price, Val, hou2, v1, v2, v3, v4, v5, v6
    UpgradeData.GetData()
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            Name = j.Name
            v5 = UpgradeData.GetLevel(Name)
            hou2 = (j:WaitForChild("Frame")):WaitForChild("hou2")
            v6 = Helper.GetNumber(Name, v5)
            ;("Lv.%*"):format(v5 + 1)
            v1 = Helper.CheckIsMax(Name, v5)
            v4 = not v1 and ("Lv.%*"):format(v5 + 2) or "Max"
            v3 = not v1 and Helper.GetPrice(Name, v5 + 1) or nil
            v2 = not v1 and Helper.GetNumber(Name, v5 + 1) or "Max"
            if Name ~= "OrePack" then
                v6 = if not (v6 < 1) then ("+%*"):format(v6) else ("+%*%%"):format((math.round(v6 * 100)))
                if not v1 then
                    v2 = if not (v2 < 1) then ("+%*"):format(v2) else ("+%*%%"):format((math.round(v2 * 100)))
                end
            else
                v6 = v6 - 4
                v6 = ("+%*"):format(v6)
                if not v1 then
                    v2 = v2 - 4
                    v2 = ("+%*"):format(v2)
                end
            end
            v4 = (hou2:WaitForChild("zi")):WaitForChild("1")
            v4:WaitForChild("qian").Text = v6
            v4 = (hou2:WaitForChild("zi")):WaitForChild("1")
            v4:WaitForChild("hou").Text = v2
            v4 = (hou2:WaitForChild("zi")):WaitForChild("2")
            v4.Visible = false
            Price = (hou2:WaitForChild("Button")):WaitForChild("Price")
            Price.Visible = v3
            if v3 then
                Val = ((Price:WaitForChild("Button")):WaitForChild("Frame")):WaitForChild("Val")
                Val.Text = AbbreviateNumber(v3)
            end
        end
    end
end

function u0.open() -- Line: 114 -- upvalues: UIController (val), Upgrade (val)
    UIController.openScreen(Upgrade.Name)
end

function u0.close() -- Line: 117 -- upvalues: UIController (val), Upgrade (val)
    UIController.closeScreen(Upgrade.Name)
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").GuiUtils.WorldBossGUI
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.GuiUtils.WorldBossGUI
-- Decompile time: 27.03 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
game:GetService("RunService")
local Players = game:GetService("Players")
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local UIController = require(ReplicatedStorage.Utils.UIController)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Config.AnyHelper)
local RewardShow = require(ReplicatedStorage.GuiUtils.RewardShow)
local Helper = require(ReplicatedStorage.Config.WorldBoss.Helper)
require(ReplicatedStorage.Utils.TranslateUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local TimeFormatUntil = require(ReplicatedStorage.Utils.TimeFormatUntil)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local Helper_2 = require(ReplicatedStorage.Config.Enemy.Helper)
local Helper_3 = require(ReplicatedStorage.Config.Rarity.Helper)
local LocalPlayer = game.Players.LocalPlayer
local Hud = LocalPlayer.PlayerGui:WaitForChild("Hud")
LocalPlayer.PlayerGui:WaitForChild("Main")
local Info = LocalPlayer.PlayerGui:WaitForChild("Info")
local BossFight = LocalPlayer.PlayerGui:WaitForChild("BossFight")
local WorldBossTips = Info:WaitForChild("WorldBossTips")
local BossFrame = BossFight:WaitForChild("BossFrame")
local BossReward = BossFight:WaitForChild("BossReward")
local Cards = BossReward:WaitForChild("Cards")
local u118 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "BossWillSpawnRE")
CommunicationUtils.TryGetRemoteEvent("WorldBoss", "BossSpawnRE")
CommunicationUtils.TryGetRemoteEvent("WorldBoss", "BossEscapeRE")
local u130 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "BossDeadRE")
local u134 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "TryClaimBossRewardRE")
local u138 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "ShowBossRewardRE")
CommunicationUtils.TryGetRemoteEvent("WorldBoss", "ExitWorldBossFight")
local u143 = nil
local u144 = nil
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local u147 = Helper.GetRebirthTime()
Helper.GetFirstRebirthTime()
local u151 = Helper.GetEscapeTime()

local function GetBossEscapeTime() -- Line: 55 -- upvalues: u151 (val), u147 (val)
    if not workspace:GetAttribute("NextWorldBossTick") or not workspace:GetAttribute("CurrentWorldBoss") then
        return nil
    end
    local Attribute = workspace:GetAttribute("ServerTime") or os.time()
    return workspace:GetAttribute("NextWorldBossTick") + u151 - u147 - Attribute
end

function u0.init() -- Line: 68 -- upvalues: WorldBossTips (val)
    WorldBossTips.Visible = false
end

function u0.start() -- Line: 71
    -- upvalues: WorldBossTips (val), u0 (val), u143 (ref), u118 (val), Message (val), LocalPlayer (val), u130 (val)
    -- upvalues: u138 (val), BossReward (val), Helper (val), TableUtils (val), RewardShow (val), Helper_3 (val)
    -- upvalues: BossFrame (val), u144 (ref)
    local Rarity, Val, v1, v2, v3, v4, v5
    ;(((WorldBossTips:WaitForChild("Button")):WaitForChild("Yes")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 73 -- upvalues: u0 (upval), u143 (upval)
        u0.CloseIntoFightTips()
        if u143 then
            u143(true)
        end
    end)
    ;(((WorldBossTips:WaitForChild("Button")):WaitForChild("No")):WaitForChild("Button")).MouseButton1Down:Connect(function() -- Line: 80 -- upvalues: u0 (upval)
        u0.CloseIntoFightTips()
    end)
    u118.OnClientEvent:Connect(function() -- Line: 84 -- upvalues: Message (upval), LocalPlayer (upval), u0 (upval)
        if workspace:GetAttribute("SCREENMAINOPEN") then
            Message.showMessage("World Boss will comming.")
            return
        end
        if not LocalPlayer:GetAttribute("IntoFight") then
            u0.OpenIntoFightTips("World Boss spawning soon. Join the battle?")
        end
    end)
    u130.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 95 -- upvalues: u0 (upval)
        task.wait(3)
        u0.OpenBossRewardUI(a3)
    end)
    u138.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 103 -- upvalues: u0 (upval)
        u0.ShowCardVFX(a1, a2, a3)
    end)

    local function ListenWB() -- Line: 108 -- upvalues: u0 (upval)
        local Attribute = workspace:GetAttribute("CurrentWorldBoss")
        if Attribute then
            u0.StartWBListen(Attribute)
            return
        end
        u0.EndWBListen()
    end

    ;(workspace:GetAttributeChangedSignal("CurrentWorldBoss")):Connect(function() -- Line: 116 -- upvalues: u0 (upval)
        local Attribute = workspace:GetAttribute("CurrentWorldBoss")
        if Attribute then
            u0.StartWBListen(Attribute)
            return
        end
        u0.EndWBListen()
    end)
    local Attribute = workspace:GetAttribute("CurrentWorldBoss")
    if not Attribute then
        u0.EndWBListen()
    else
        u0.StartWBListen(Attribute)
    end
    local Left = BossReward:WaitForChild("Left")
    ;((Left:WaitForChild("?")):WaitForChild("TextButton")).MouseButton1Down:Connect(function() -- Line: 123 -- upvalues: Left (val)
        local di = Left:WaitForChild("di")
        di.Visible = not Left:WaitForChild("di").Visible
    end)
    for i, j in (Left:WaitForChild("di")):WaitForChild("Frame"):GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    for k, n in (TableUtils.WeightTabToPercentTab((Helper.GetWeightTab(1)))) do
        v5 = (((Left:WaitForChild("di")):WaitForChild("Frame")):WaitForChild("Temple")):WaitForChild("temple"):Clone()
        v5.Parent = (Left:WaitForChild("di")):WaitForChild("Frame")
        v5.Name = k
        v5.Visible = true
        v5.LayoutOrder = tonumber(k)
        v1 = Helper.GetReward(k)
        v2, v3 = RewardShow.getShow(v1)
        v4 = v5:WaitForChild("2")
        v4:WaitForChild("Icon").Image = v2
        v4 = v5:WaitForChild("3")
        v4:WaitForChild("Val").Text = v3
        Val = (v5:WaitForChild("4")):WaitForChild("Val")
        Val.Text = ("%*%%"):format((math.round(n * 10000)) / 100)
        Rarity = v1.Rarity
        Helper_3.SetUIQiu((v5:WaitForChild("3")):WaitForChild("Val"), Rarity)
        Helper_3.SetUIQiu((v5:WaitForChild("4")):WaitForChild("Val"), Rarity)
    end
    ;(BossFrame:WaitForChild("Exit")).MouseButton1Down:Connect(function() -- Line: 153 -- upvalues: u144 (upval)
        u144(true)
    end)
end

function u0.OpenIntoFightTips(a1) -- Line: 159 -- upvalues: WorldBossTips (val), RunUtils (val), u0 (val)
    WorldBossTips.Visible = true
    local text = (((WorldBossTips:WaitForChild("Header")):WaitForChild("Head")):WaitForChild("Frame")):WaitForChild("text")
    text:WaitForChild("TextLabel").Text = a1
    local u24 = 5
    RunUtils:RegistPreRender("WorldBossTips", nil, function(a1) -- Line: 167 -- upvalues: u24 (ref), u0 (upval), WorldBossTips (upval)
        u24 = u24 - a1
        if u24 <= 0 then
            u0.CloseIntoFightTips()
            return
        end
        local v1 = math.clamp(u24 / 5, 0, 1)
        local Bar_2 = ((WorldBossTips:WaitForChild("Main")):WaitForChild("Bar")):WaitForChild("Bar")
        Bar_2.Size = UDim2.fromScale(v1, 1)
    end)
end

function u0.CloseIntoFightTips() -- Line: 180 -- upvalues: WorldBossTips (val), RunUtils (val)
    WorldBossTips.Visible = false
    RunUtils:RemoveRun("WorldBossTips")
end

function u0.SetJoinFightCB(a1) -- Line: 185 -- upvalues: u143 (ref)
    u143 = a1
end

function u0.SetExitFightCB(a1) -- Line: 188 -- upvalues: u144 (ref)
    u144 = a1
end

function u0.OpenBossRewardUI(a1) -- Line: 192 -- upvalues: BossReward (val), Cards (val), u134 (val)
    local Back, Card, Common, Epic, Info, Legendary, Name, Selected, v1
    BossReward.Visible = true
    local AnyWhere = BossReward:WaitForChild("AnyWhere")
    AnyWhere.Visible = false
    for i, j in Cards:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    for k = 1, 8 do
        v1 = (Cards:WaitForChild("Temple")):WaitForChild("temple"):Clone()
        v1.Parent = Cards
        v1.Visible = true
        v1.Name = k
        v1.LayoutOrder = k
        Name = v1:WaitForChild("Name")
        Name.Visible = false
        Card = v1:WaitForChild("Card")
        Card.Visible = true
        Back = Card:WaitForChild("Back")
        Back.Visible = true
        Info = Card:WaitForChild("Info")
        Info.Visible = false
        Common = Card:WaitForChild("Common")
        Common.Visible = false
        Epic = Card:WaitForChild("Epic")
        Epic.Visible = false
        Legendary = Card:WaitForChild("Legendary")
        Legendary.Visible = false
        Selected = Card:WaitForChild("Selected")
        Selected.Visible = false
        Card.MouseButton1Down:Connect(function() -- Line: 217 -- upvalues: u134 (upval), k (val)
            u134:FireServer((tostring(k)))
        end)
    end
end

function u0.ShowCardVFX(a1, a2, a3) -- Line: 223
    -- upvalues: Cards (val), Players (val), TweenService (val), Helper (val), RewardShow (val), LocalPlayer (val)
    -- upvalues: BossReward (val)
    local Back, Frame_3, Info, Num, UIAspectRatioConstraint_2, v1, v2, v3, v4
    local v5 = Cards:FindFirstChild(a3)
    v5:SetAttribute("UserID", a1.UserId)
    local Name = v5:WaitForChild("Name")
    Name.Visible = true
    local Card = v5:WaitForChild("Card")
    Card.Interactable = false
    local UIAspectRatioConstraint = Card:WaitForChild("UIAspectRatioConstraint")
    local AspectRatio = UIAspectRatioConstraint.AspectRatio
    local UserThumbnailAsync = Players:GetUserThumbnailAsync(a1.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    local text = ((v5:WaitForChild("Name")):WaitForChild("Frame")):WaitForChild("text")
    text:WaitForChild("ImageLabel").Image = UserThumbnailAsync
    local TextLabel = (((v5:WaitForChild("Name")):WaitForChild("Frame")):WaitForChild("text")):WaitForChild("TextLabel")
    TextLabel.Text = a1.DisplayName
    local v6 = TweenService:Create(UIAspectRatioConstraint, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {AspectRatio = 0.01})
    v6:Play()
    local v7 = {}
    for i, j in a2 do
        v1 = Card:Clone()
        v1.Parent = v5
        v1.Visible = false
        Back = v1:WaitForChild("Back")
        Back.Visible = false
        v7[i] = v1
        v2 = Helper.GetReward(j)
        v3 = v1:FindFirstChild(v2.Rarity)
        v3.Visible = true
        Info = v1:WaitForChild("Info")
        Info.Visible = true
        v3, v4 = RewardShow.getShow(v2)
        Frame_3 = (v1:WaitForChild("Info")):WaitForChild("Frame")
        Frame_3:WaitForChild("Icon").Image = v3
        Frame_3:WaitForChild("Name").Text = v4
        Num = Frame_3:WaitForChild("Num")
        Num.Text = ""
    end
    v6.Completed:Wait()
    for k, n in a2 do
        local u138 = v7[k]
        u138.Visible = true
        UIAspectRatioConstraint_2 = u138:WaitForChild("UIAspectRatioConstraint")
        UIAspectRatioConstraint_2.AspectRatio = 0.01
        local u155 = TweenService:Create(UIAspectRatioConstraint_2, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {AspectRatio = AspectRatio})
        u155:Play()
        task.spawn(function() -- Line: 274 -- upvalues: u155 (val), a2 (val), k (val), TweenService (upval), u138 (val)
            u155.Completed:Wait()
            local v1 = 0
            local zero = Vector2.zero
            if #a2 ~= 2 then
                if #a2 == 1 then
                    v1 = 0
                end
            elseif k == 1 then
                v1 = -15
                zero = Vector2.new(-0.2, 0)
            elseif k == 2 then
                v1 = 15
                zero = Vector2.new(0.2, 0)
            end
            TweenService:Create(u138, TweenInfo.new(0.2), {Rotation = v1, Position = UDim2.fromScale(0.5 + zero.X, 1)}):Play()
        end)
    end
    Card.Visible = false
    task.wait(2)
    if a1 == LocalPlayer then
        local u119 = nil
        local AnyWhere = BossReward:WaitForChild("AnyWhere")
        AnyWhere.Visible = true
        local v8 = (BossReward:WaitForChild("AnyWhere")).MouseButton1Down:Connect(function() -- Line: 303 -- upvalues: u119 (ref), BossReward (upval)
            u119:Disconnect()
            BossReward.Visible = false
        end)
    end
end

function u0.OpenBossFrame() -- Line: 311 -- upvalues: UIController (val), BossFrame (val), Hud (val)
    UIController.closeCurrentScreen()
    UIController.CloseCurrentScreenMain()
    BossFrame.Visible = true
    local Left = Hud:WaitForChild("Left")
    Left.Visible = false
    local LeftInfos = Hud:WaitForChild("LeftInfos")
    LeftInfos.Visible = false
    local RightTop = Hud:WaitForChild("RightTop")
    RightTop.Visible = false
    local Right = Hud:WaitForChild("Right")
    Right.Visible = false
    local Race = Hud:WaitForChild("Race")
    Race.Visible = false
end

function u0.CloseBossFrame() -- Line: 322 -- upvalues: BossFrame (val), Hud (val)
    BossFrame.Visible = false
    local Left = Hud:WaitForChild("Left")
    Left.Visible = true
    local LeftInfos = Hud:WaitForChild("LeftInfos")
    LeftInfos.Visible = true
    local RightTop = Hud:WaitForChild("RightTop")
    RightTop.Visible = true
    local Right = Hud:WaitForChild("Right")
    Right.Visible = true
    local Race = Hud:WaitForChild("Race")
    Race.Visible = true
end

function u0.SetBossHPBar(a1, a2) -- Line: 331
    -- upvalues: BossFrame (val), AbbreviateNumber (val)
    local v1 = math.clamp(a1 / a2, 0, 1)
    local BossHP = (BossFrame:WaitForChild("Top")):WaitForChild("BossHP")
    local v2 = (BossHP:WaitForChild("TX")):WaitForChild("2")
    v2.Text = ("%*/%*"):format(AbbreviateNumber(a1), (AbbreviateNumber(a2)))
    local UIGradient = ((BossHP:WaitForChild("Mask")):WaitForChild("Bar")):WaitForChild("UIGradient")
    UIGradient.Offset = Vector2.new(v1 - 0.5, 0)
end

local u164 = {}

function u0.StartWBListen(a1) -- Line: 342
    -- upvalues: u164 (val), Helper_2 (val), BossFrame (val), u0 (val), AbbreviateNumber (val), Players (val)
    -- upvalues: RunUtils (val), GetBossEscapeTime (val), TimeFormatUntil (val)
    u164.ListenList = {}
    local v1 = (workspace:WaitForChild("EnemyFolder_Server")):WaitForChild(a1, 60)
    if not v1 then
        warn("怎么回事？")
        return
    end
    repeat
        task.wait()
    until v1:GetAttribute("EnemyID")
    local v2 = Helper_2.GetDisName((v1:GetAttribute("EnemyID")))
    local BossHP = (BossFrame:WaitForChild("Top")):WaitForChild("BossHP")
    ;(BossFrame:WaitForChild("Left")):WaitForChild("ScrollingFrame")
    BossHP.Visible = true
    BossHP:WaitForChild("BoostLabel").Text = v2
    local HPValue = v1:WaitForChild("HPValue")
    local Attribute = HPValue:GetAttribute("MaxHP")
    HPValue.Changed:Connect(function(a1) -- Line: 366 -- upvalues: u0 (upval), Attribute (val)
        u0.SetBossHPBar(a1, Attribute)
    end)
    u0.SetBossHPBar(HPValue.Value, Attribute)
    local ScrollingFrame = (BossFrame:WaitForChild("Left")):WaitForChild("ScrollingFrame")
    for i, j in ScrollingFrame:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
    local WorldBossFolder = workspace:WaitForChild("WorldBossFolder")

    local function UpdatePlrDmgList() -- Line: 381
        -- upvalues: WorldBossFolder (val), ScrollingFrame (val), AbbreviateNumber (upval)
        local Dmg, v1
        local v2 = {}
        for i, j in WorldBossFolder:GetChildren() do
            if j:IsA("NumberValue") then
                v1 = ScrollingFrame:FindFirstChild(j.Name)
                if v1 then
                    table.insert(v2, {Frame = v1, Damage = j.Value})
                    Dmg = ((v1:WaitForChild("Rank")):WaitForChild("3")):WaitForChild("Dmg")
                    Dmg.Text = ("DMG: %*"):format((AbbreviateNumber(j.Value)))
                end
            end
        end
        table.sort(v2, function(a1, a2) -- Line: 399
            return a2.Damage < a1.Damage
        end)
        for k, n in v2 do
            n.Frame.LayoutOrder = k
            v1 = (n.Frame:WaitForChild("Rank")):WaitForChild("1")
            v1:WaitForChild("Damage Rank").Text = k
        end
    end

    local function DestroyPlrDmgValue(a1) -- Line: 408 -- upvalues: ScrollingFrame (val), UpdatePlrDmgList (val)
        local Name = a1.Name
        if ScrollingFrame:FindFirstChild(Name) then
            ScrollingFrame:FindFirstChild(Name):Destroy()
        end
        UpdatePlrDmgList()
    end

    local function LoadPlrDmgValue(a1) -- Line: 416
        -- upvalues: UpdatePlrDmgList (val), Players (upval), ScrollingFrame (val)
        a1.Changed:Connect(function() -- Line: 417 -- upvalues: UpdatePlrDmgList (upval)
            UpdatePlrDmgList()
        end)
        local v1 = tonumber(a1.Name)
        local PlayerByUserId = Players:GetPlayerByUserId(v1)
        local HeadShot = Enum.ThumbnailType.HeadShot
        local Size420x420 = Enum.ThumbnailSize.Size420x420
        local UserThumbnailAsync = Players:GetUserThumbnailAsync(v1, HeadShot, Size420x420)
        local v2 = (ScrollingFrame:WaitForChild("Temple")):WaitForChild("temple"):Clone()
        v2.Parent = ScrollingFrame
        v2.Name = v1
        v2.Visible = true
        local v3 = (v2:WaitForChild("Rank")):WaitForChild("2")
        v3:WaitForChild("Icon").Image = UserThumbnailAsync
        local Multiplier = ((v2:WaitForChild("Rank")):WaitForChild("3")):WaitForChild("Multiplier")
        Multiplier.Text = PlayerByUserId.DisplayName
        UpdatePlrDmgList()
        a1.Destroying:Connect(function() -- Line: 436 -- upvalues: a1 (val), ScrollingFrame (upval), UpdatePlrDmgList (upval)
            local Name = a1.Name
            if ScrollingFrame:FindFirstChild(Name) then
                ScrollingFrame:FindFirstChild(Name):Destroy()
            end
            UpdatePlrDmgList()
        end)
    end

    for k, n in WorldBossFolder:GetChildren() do
        LoadPlrDmgValue(n)
    end
    table.insert(u164.ListenList, (WorldBossFolder.ChildAdded:Connect(function(a1) -- Line: 444 -- upvalues: LoadPlrDmgValue (val)
        LoadPlrDmgValue(a1)
    end)))
    table.insert(u164.ListenList, (RunUtils:RegistPreRender(nil, 1, function() -- Line: 447 -- upvalues: GetBossEscapeTime (upval), BossHP (val), TimeFormatUntil (upval)
        local v1 = GetBossEscapeTime()
        local Boostime = BossHP:WaitForChild("Boostime")
        Boostime.Text = ("Escape Time: %*"):format((TimeFormatUntil.MMSS(v1)))
    end)))
end

function u0.EndWBListen() -- Line: 454 -- upvalues: BossFrame (val), u164 (val)
    local BossHP = (BossFrame:WaitForChild("Top")):WaitForChild("BossHP")
    BossHP.Visible = false
    if u164 and u164.ListenList then
        for i, j in u164.ListenList do
            if j then
                j:Disconnect()
            end
        end
    end
end

function u0.OpenExitButton() -- Line: 468 -- upvalues: BossFrame (val)
    local Exit = BossFrame:WaitForChild("Exit")
    Exit.Visible = true
end

function u0.CloseExitButton() -- Line: 471 -- upvalues: BossFrame (val)
    local Exit = BossFrame:WaitForChild("Exit")
    Exit.Visible = false
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").LocalData.UpgradeData
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.LocalData.UpgradeData
-- Decompile time: 2.32 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local ProfileData = require(ReplicatedStorage.ProfileData)
local Helper = require(ReplicatedStorage.Config.Upgrade.Helper)
local u21 = CommunicationUtils.TryGetRemoteEvent("Upgrade", "UpgradeOnceRE")
local u22 = nil
local u23 = {}

function u0.GetData() -- Line: 14 -- upvalues: u22 (ref)
    return u22
end

function u0.init() -- Line: 18 -- upvalues: u22 (ref), ProfileData (val), u23 (val)
    u22 = ProfileData.GetStoreData("Upgrade")
    ProfileData.AddStoreCallback("Upgrade", function(a1) -- Line: 20 -- upvalues: u22 (upval), u23 (upval)
        u22 = a1
        for i, v in ipairs(u23) do
            v()
        end
    end)
end

function u0.AddCallback(a1) -- Line: 28 -- upvalues: u23 (val)
    if type(a1) == "function" then
        table.insert(u23, a1)
    end
end

function u0.GetLevel(a1) -- Line: 34 -- upvalues: u22 (ref)
    if not u22[a1] then
        return 0
    end
    return u22[a1].Level or 0
end

function u0.GetNumber(a1) -- Line: 41 -- upvalues: u22 (ref)
    if not u22[a1] then
        return 0
    end
    return u22[a1].Number or 0
end

function u0.UpgradeOnce(a1) -- Line: 49 -- upvalues: u21 (val)
    u21:FireServer(a1)
end

function u0.GetMaxNum(a1) -- Line: 52 -- upvalues: u0 (val), Helper (val)
    local v1 = u0.GetLevel(a1)
    local v2 = u0.GetNumber(a1)
    return Helper.GetNumber(a1, v1) + v2
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").LocalData.StatsData
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.LocalData.StatsData
-- Decompile time: 1.56 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.CommunicationUtils)
local ProfileData = require(ReplicatedStorage.ProfileData)
local u13 = nil
local u14 = {}

function v1.GetData() -- Line: 12 -- upvalues: u13 (ref)
    return u13
end

function v1.init() -- Line: 16 -- upvalues: u13 (ref), ProfileData (val), u14 (val)
    u13 = ProfileData.GetStoreData("Stats")
    ProfileData.AddStoreCallback("Stats", function(a1) -- Line: 18 -- upvalues: u13 (upval), u14 (upval)
        u13 = a1
        for i, v in ipairs(u14) do
            v()
        end
    end)
end

function v1.AddCallback(a1) -- Line: 26 -- upvalues: u14 (val)
    if type(a1) == "function" then
        table.insert(u14, a1)
    end
end

function v1.getStatsInfo(a1) -- Line: 32 -- upvalues: u13 (ref)
    return u13[a1] or 0
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").LocalData.PotionData
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.LocalData.PotionData
-- Decompile time: 1.56 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local ProfileData = require(ReplicatedStorage.ProfileData)
local u16 = CommunicationUtils.TryGetRemoteEvent("Potion", "TryUsePotionRE")
local u17 = nil
local u18 = {}

function v1.init() -- Line: 12 -- upvalues: u17 (ref), ProfileData (val), u18 (val)
    u17 = ProfileData.GetStoreData("Potion")
    ProfileData.AddStoreCallback("Potion", function(a1) -- Line: 14 -- upvalues: u17 (upval), u18 (upval)
        u17 = a1
        for i, v in ipairs(u18) do
            v()
        end
    end)
end

function v1.AddCallback(a1) -- Line: 21 -- upvalues: u18 (val)
    if type(a1) == "function" then
        table.insert(u18, a1)
    end
end

function v1.GetData() -- Line: 27 -- upvalues: u17 (ref)
    return u17
end

function v1.UsePotion(a1, a2) -- Line: 30 -- upvalues: u16 (val)
    u16:FireServer(a1, a2)
end

return v1
-- Script Path: game:GetService("ReplicatedStorage").Packages.Cooldown
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.Packages.Cooldown
-- Decompile time: 3.69 ms

local Players = game:GetService("Players")
local u5 = {}
u5.__index = u5

function u5.new(a1) -- Line: 15 -- upvalues: u5 (val), Players (val)
    local u4 = setmetatable({}, u5)
    u4._list = {}
    u4._timeList = {}
    u4._timeBetween = a1
    Players.PlayerRemoving:Connect(function(a1) -- Line: 22 -- upvalues: u4 (val)
        u4:Remove(a1)
    end)
    return u4
end

function u5.CanFire(a1, a2) -- Line: 29
    if not a1._list[a2] then
        return true
    end
    local _timeBetween = a1._timeList[a2] or a1._timeBetween
    if _timeBetween <= tick() - a1._list[a2] then
        return true
    end
    return false
end

function u5.SetTimeBetween(a1, a2, a3) -- Line: 42
    a1._timeList[a2] = a3
end

function u5.AddTimestamp(a1, a2) -- Line: 46
    a1._list[a2] = (tick())
    if typeof(a2) == "Instance" then
        a1:_watchInstance(a2)
    end
end

function u5:Remove(a2) -- Line: 54
    self._list[a2] = nil
    self._timeList[a2] = nil
end

function u5._watchInstance(a1, a2) -- Line: 59 -- types: a1: table, a2: userdata
    if not a2:IsA("Player") then
        a2.Destroying:Connect(function() -- Line: 61 -- upvalues: a1 (val), a2 (val)
            a1:Remove(a2)
        end)
    end
end

return u5
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL
-- Decompile time: 4.43 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local CoolDown = require(ReplicatedStorage.Object.CoolDown)
local u20 = CommunicationUtils.TryGetRemoteEvent("Attack", "UseAnyATKRE")
local u24 = CommunicationUtils.TryGetRemoteEvent("Attack", "UseAnySkillRE")
local u25 = {}
for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        u25[j.Name] = (require(j))
    end
end

local function CheckLocalPlayerCanAction() -- Line: 21 -- upvalues: LocalPlayer (val)
    if LocalPlayer:GetAttribute("Dead") then
        return false
    end
    return true
end

local u41 = 1
local u45 = CoolDown.new(2)
u45:AddCallback(function() -- Line: 30 -- upvalues: u41 (ref)
    u41 = 1
end)

function u0.ATK(a1, a2) -- Line: 33 -- upvalues: LocalPlayer (val), u41 (ref), u0 (val), u45 (val), u20 (val)
    if a1 ~= LocalPlayer then
        return
    end
    if not not LocalPlayer:GetAttribute("Dead") or LocalPlayer:GetAttribute("UsingSkillID") then
        return false
    end
    local Attribute = LocalPlayer:GetAttribute("WeaponType")
    if not Attribute then
        return false
    end
    local v1 = nil
    if Attribute == "Katana" then
        v1 = "K_ATK_" .. u41
    elseif Attribute == "Great" then
        v1 = "G_ATK_" .. u41
    end
    if u0.AnySkill(a1, v1, a2) then
        LocalPlayer:SetAttribute("UsingSkillID", v1)
        u41 = u41 + 1
        if u41 > 3 then
            u41 = 1
        end
        u45:StartCD()
        u20:FireServer(v1, (workspace:GetServerTimeNow()))
    end
end

function u0.UseSkill(a1, a2, a3) -- Line: 64 -- upvalues: LocalPlayer (val), u0 (val), u24 (val)
    if a1 ~= LocalPlayer then
        return
    end
    if not not LocalPlayer:GetAttribute("Dead") then
        return false
    end
    local SkillIndex = a3.SkillIndex
    local Attribute = a1:GetAttribute(SkillIndex .. "_SkillNextTick")
    local ServerTimeNow = workspace:GetServerTimeNow()
    if Attribute and ServerTimeNow < Attribute then
        return false
    end
    if LocalPlayer:GetAttribute("UsingSkillID") then
        local Attribute_2 = LocalPlayer:GetAttribute("UsingSkillID")
        if Attribute_2:split("_")[2] ~= "ATK" then
            return
        else
            u0.StopAnySkill(a1, Attribute_2)
        end
    end
    if u0.AnySkill(a1, a2, a3) then
        LocalPlayer:SetAttribute("UsingSkillID", a2)
        u24:FireServer(a2, SkillIndex, (workspace:GetServerTimeNow()))
    end
end

function CheckPlay(a1, a2, a3) -- Line: 99 -- upvalues: u25 (val)
    if not a3 then
        return false
    end
    if u25[a2] and u25[a2].Play then
        return true
    end
    return false
end

function CheckStop(a1, a2, a3) -- Line: 108 -- upvalues: u25 (val)
    if u25[a2] and u25[a2].Stop then
        return true
    end
    return false
end

function u0.AnySkill(a1, a2, a3) -- Line: 115 -- upvalues: u25 (val)
    if CheckPlay(a1, a2, a3) then
        return u25[a2].Play(a1, a3)
    end
end

function u0.StopAnySkill(a1, a2, a3) -- Line: 122 -- upvalues: u25 (val)
    if CheckStop(a1, a2, a3) then
        return u25[a2].Stop(a1, a3)
    end
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_ATK_1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_ATK_1
-- Decompile time: 4.87 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Player:WaitForChild(Name)
local u67 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = {}

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u67 (ref), TimeListFunc (val), u72 (val), Trove (val), Name (val), SoundUtils (val), DamageUtils (val)
    -- upvalues: CameraUtils (val), CharUtils (val), VFXUtils (val), u60 (val), u0 (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local v1 = TimeListFunc.new()
    if not u72[a1] then
        u72[a1] = (Trove.new())
    end
    u72[a1]:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 56 -- upvalues: AnimObj (val), Name (upval), SoundUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        SoundUtils.PlaySound(a1, Name)
    end)
    for k, v in pairs(Phase) do
        v1:AddTickFunc(v.DelayTime, function() -- Line: 61
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval), VFXUtils (upval), u60 (upval)
            local v1
            local v2 = nil
            if v.DamageConfig then
                local v3
                v1, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v2 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v2)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
            v1 = VFXUtils.CreateCharVFX(Char, u60:WaitForChild("Attack"), 1)
            VFXUtils.LockVFXToModel(v1.PrimaryPart, Char, "RootAttachment")
            VFXUtils.EmitByPart(v1)
        end)
    end
    v1:AddTickFunc(ActionTime, function() -- Line: 79 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1) -- Line: 86 -- upvalues: u72 (val) -- types: a1: userdata
    a1:SetAttribute("UsingSkillID", nil)
    u72[a1]:Destroy()
    u72[a1] = nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_ATK_2
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_ATK_2
-- Decompile time: 4.61 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Player:WaitForChild(Name)
local u67 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = {}

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u67 (ref), TimeListFunc (val), u72 (val), Trove (val), Name (val), SoundUtils (val), DamageUtils (val)
    -- upvalues: CameraUtils (val), CharUtils (val), VFXUtils (val), u60 (val), u0 (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local v1 = TimeListFunc.new()
    if not u72[a1] then
        u72[a1] = (Trove.new())
    end
    u72[a1]:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 53 -- upvalues: AnimObj (val), Name (upval), SoundUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        SoundUtils.PlaySound(a1, Name)
    end)
    for k, v in pairs(Phase) do
        v1:AddTickFunc(v.DelayTime, function() -- Line: 59
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval), VFXUtils (upval), u60 (upval)
            local v1
            local v2 = nil
            if v.DamageConfig then
                local v3
                v1, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v2 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v2)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
            v1 = VFXUtils.CreateCharVFX(Char, u60:WaitForChild("Attack"), 1)
            VFXUtils.LockVFXToModel(v1.PrimaryPart, Char, "RootAttachment")
            VFXUtils.EmitByPart(v1)
        end)
    end
    v1:AddTickFunc(ActionTime, function() -- Line: 76 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 83 -- upvalues: u72 (val) -- types: a1: userdata
    a1:SetAttribute("UsingSkillID", nil)
    u72[a1]:Destroy()
    u72[a1] = nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_ATK_3
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_ATK_3
-- Decompile time: 4.80 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Player:WaitForChild(Name)
local u67 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = {}

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u67 (ref), TimeListFunc (val), u72 (val), Trove (val), Name (val), SoundUtils (val), DamageUtils (val)
    -- upvalues: CameraUtils (val), CharUtils (val), VFXUtils (val), u60 (val), u0 (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local v1 = TimeListFunc.new()
    if not u72[a1] then
        u72[a1] = (Trove.new())
    end
    u72[a1]:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 53 -- upvalues: AnimObj (val), Name (upval), SoundUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        SoundUtils.PlaySound(a1, Name)
    end)
    for k, v in pairs(Phase) do
        v1:AddTickFunc(v.DelayTime, function() -- Line: 59
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval), VFXUtils (upval), u60 (upval)
            local v1
            local v2 = nil
            if v.DamageConfig then
                local v3
                v1, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v2 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v2)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
            v1 = VFXUtils.CreateCharVFX(Char, u60:WaitForChild("Attack"), 1)
            VFXUtils.LockVFXToModel(v1.PrimaryPart, Char, "RootAttachment")
            VFXUtils.EmitByPart(v1)
        end)
    end
    v1:AddTickFunc(ActionTime, function() -- Line: 76 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 83 -- upvalues: u72 (val) -- types: a1: userdata
    a1:SetAttribute("UsingSkillID", nil)
    u72[a1]:Destroy()
    u72[a1] = nil
end

return u0
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_10
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_10
-- Decompile time: 4.90 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), DamageUtils (val), CameraUtils (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u64 (val), SoundUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval)
            local v1 = nil
            if v.DamageConfig then
                local v2, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v1 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v1)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 64 -- upvalues: VFXUtils (upval), u64 (upval), Char (ref), SoundUtils (upval), a1 (val)
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("VFX"), Char:GetPivot())
        SoundUtils.PlaySound(a1, "G_Skill_10")
        SoundUtils.PlaySound(a1, "G_Skill_10_1")
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 72 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_1001
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_1001
-- Decompile time: 5.22 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 27
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), CameraUtils (val), CharUtils (val), VFXUtils (val)
    -- upvalues: u64 (val), SoundUtils (val), DamageUtils (val), ModelVFXUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 41 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 46 -- upvalues: v (val), CameraUtils (upval), Char (ref), CharUtils (upval)
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    local u32 = nil
    u14:AddTickFunc(0, function() -- Line: 58 -- upvalues: VFXUtils (upval), Char (ref), u64 (upval), u32 (ref)
        local v1 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("VFX_1"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v1)
        u32 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("VFX_2"), 6, "RootAttachment")
        VFXUtils.EmitByPart(u32)
    end)
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 67 -- upvalues: VFXUtils (upval), Char (ref), u64 (upval), SoundUtils (upval), a1 (val)
        local v1 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("SpeedLine"), 20, "RootAttachment")
        VFXUtils.EmitByPart(v1)
        SoundUtils.PlaySound(a1, "K_Skill_3")
    end)
    u14:AddTickFunc(Phase[2].DelayTime, function() -- Line: 73
        -- upvalues: Char (ref), SoundUtils (upval), a1 (val), Phase (val), VFXUtils (upval), u64 (upval)
        -- upvalues: DamageUtils (upval), Name (upval), ModelVFXUtils (upval), u32 (ref)
        if Char and Char.Parent then
            local Pivot = Char:GetPivot()
            SoundUtils.PlaySound(a1, "G_Skill_1001_1")
            SoundUtils.PlaySound(a1, "G_Skill_1001")
            local DamageConfig = Phase[2].DamageConfig
            local RingTime = DamageConfig.RingTime
            local u37 = VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("VFX_3"), Pivot * CFrame.new(0, -60, 0), RingTime, nil, true)
            DamageUtils.RingDamage_CFrame(Char, Pivot, Name, 2, DamageConfig)
            task.spawn(function() -- Line: 88 -- upvalues: ModelVFXUtils (upval), u37 (val), Pivot (val)
                ModelVFXUtils.TWCFrame(u37, TweenInfo.new(0.3), Pivot)
            end)
            task.spawn(function() -- Line: 91 -- upvalues: u32 (upval), VFXUtils (upval), ModelVFXUtils (upval)
                if u32 and u32.Parent then
                    VFXUtils.UnlockVFX(u32.PrimaryPart)
                    u32.Parent = workspace
                    u32.PrimaryPart.Anchored = true
                    ModelVFXUtils.TWScale(u32, TweenInfo.new(0.3), 2.8)
                end
            end)
            return
        end
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 107 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_2
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_2
-- Decompile time: 3.98 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), DamageUtils (val), CameraUtils (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u64 (val), SoundUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval)
            local v1 = nil
            if v.DamageConfig then
                local v2, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v1 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v1)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 64
        -- upvalues: VFXUtils (upval), Char (ref), u64 (upval), SoundUtils (upval), a1 (val), Name (upval)
        local v1 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("Submit_1"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v1)
        SoundUtils.PlaySound(a1, Name)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 72 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_3
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_3
-- Decompile time: 6.00 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), CameraUtils (val), CharUtils (val), VFXUtils (val)
    -- upvalues: u64 (val), DamageUtils (val), SoundUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49 -- upvalues: v (val), CameraUtils (upval), Char (ref), CharUtils (upval)
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 60 -- upvalues: Char (ref), VFXUtils (upval), u64 (upval), CharUtils (upval)
        local Pivot = Char:GetPivot()
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Submit_1"), Pivot, 3)
        CharUtils.PlayerParabola(Char, Pivot.LookVector + Pivot.UpVector, 50, 0.65)
    end)
    local u41 = nil
    u14:AddTickFunc(Phase[3].DelayTime, function() -- Line: 70
        -- upvalues: Phase (val), DamageUtils (upval), Char (ref), Name (upval), VFXUtils (upval), u64 (upval)
        -- upvalues: u41 (ref), SoundUtils (upval), a1 (val)
        local v1 = Phase[3]
        DamageUtils.AOEDamage_Self(Char, Name, 3, v1.DamageConfig)
        local Pivot = Char:GetPivot()
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Submit_2"), Pivot, 3)
        u41 = VFXUtils.CreateVFX(u64:WaitForChild("Ground"), Pivot, 3)
        SoundUtils.PlaySound(a1, "G_Skill_3")
    end)
    u14:AddTickFunc(Phase[4].DelayTime, function() -- Line: 85
        -- upvalues: VFXUtils (upval), u41 (ref), Phase (val), DamageUtils (upval), Char (ref), Name (upval)
        VFXUtils.EmitByPart(u41)
        local v1 = Phase[4]
        DamageUtils.RingDamage_CFrame(Char, u41.PrimaryPart.CFrame, Name, 4, v1.DamageConfig)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 91 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_4
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_4
-- Decompile time: 5.35 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), CameraUtils (val), CharUtils (val), SoundUtils (val)
    -- upvalues: DamageUtils (val), VFXUtils (val), u64 (val), ModelVFXUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49 -- upvalues: v (val), CameraUtils (upval), Char (ref), CharUtils (upval)
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    local u32 = nil
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 61
        -- upvalues: Char (ref), SoundUtils (upval), a1 (val), DamageUtils (upval), Name (upval), Phase (val)
        -- upvalues: VFXUtils (upval), u64 (upval), u32 (ref), ModelVFXUtils (upval)
        local Pivot = Char:GetPivot()
        SoundUtils.PlaySound(a1, "G_Skill_4")
        DamageUtils.AOEDamage_Self(Char, Name, 1, Phase[1].DamageConfig)
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Submit_1"), Pivot, 2)
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Ground"), Pivot, 2)
        u32 = VFXUtils.CreateVFX(u64:WaitForChild("SwordQi"), Pivot, 10)
        VFXUtils.EnablePart(u32)
        ModelVFXUtils.TWCFrame(
            u32,
            TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            (CFrame.new(Pivot.Position + Pivot.LookVector * 15)) * Pivot.Rotation
        )
    end)
    u14:AddTickFunc(Phase[2].DelayTime, function() -- Line: 84
        -- upvalues: Phase (val), DamageUtils (upval), Char (ref), u32 (ref), Name (upval), VFXUtils (upval)
        local v1 = Phase[2]
        DamageUtils.RingDamage_PartCF(Char, u32.PrimaryPart, Name, 2, v1.DamageConfig)
        task.delay(v1.DamageConfig.RingTime, function() -- Line: 88 -- upvalues: VFXUtils (upval), u32 (upval)
            VFXUtils.DisablePart(u32)
            task.wait(1)
            u32:Destroy()
        end)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 94 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_5
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_5
-- Decompile time: 7.24 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), DamageUtils (val), CameraUtils (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u64 (val), SoundUtils (val), ModelVFXUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval)
            local v1 = nil
            if v.DamageConfig then
                local v2, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v1 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v1)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 65 -- upvalues: Char (ref), VFXUtils (upval), u64 (upval), SoundUtils (upval), a1 (val)
        Char:GetPivot()
        local v1 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("Submit_1"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v1)
        SoundUtils.PlaySound(a1, "G_Skill_5_1")
    end)
    u14:AddTickFunc(Phase[2].DelayTime, function() -- Line: 74 -- upvalues: Phase (val), Char (ref), VFXUtils (upval), u64 (upval), SoundUtils (upval), a1 (val)
        local v1 = Phase[2]
        Char:GetPivot()
        local v2 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("Submit_2"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v2)
        SoundUtils.PlaySound(a1, "G_Skill_5_1")
    end)
    u14:AddTickFunc(Phase[3].DelayTime, function() -- Line: 84 -- upvalues: Phase (val), Char (ref), VFXUtils (upval), u64 (upval)
        local v1 = Phase[3]
        local Pivot = Char:GetPivot()
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Submit_3"), Pivot, 2)
    end)
    u14:AddTickFunc(Phase[4].DelayTime, function() -- Line: 90
        -- upvalues: Phase (val), Char (ref), VFXUtils (upval), u64 (upval), SoundUtils (upval), a1 (val)
        -- upvalues: ModelVFXUtils (upval)
        local v1 = Phase[4]
        local Pivot = Char:GetPivot()
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Submit_4"), Pivot, 2)
        local v2 = VFXUtils.CreateVFX(u64:WaitForChild("Rock"), Pivot * CFrame.new(0, -3, 0), 3)
        SoundUtils.PlaySound(a1, "G_Skill_5_2")
        ModelVFXUtils.TWCFrame(v2, TweenInfo.new(0.2), Pivot)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 106 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_6
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_6
-- Decompile time: 7.87 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local ModelVFXUtils = require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), CameraUtils (val), CharUtils (val), VFXUtils (val)
    -- upvalues: u64 (val), DamageUtils (val), SoundUtils (val), ModelVFXUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49 -- upvalues: v (val), CameraUtils (upval), Char (ref), CharUtils (upval)
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, nil)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
        end)
    end
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 62 -- upvalues: Char (ref), VFXUtils (upval), u64 (upval), CameraUtils (upval)
        Char:GetPivot()
        local v1 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("Enable_1"), 1, "RootAttachment")
        VFXUtils.EnablePart(v1)
        CameraUtils.TWFOV(Char, TweenInfo.new(0.6), 65)
    end)
    u14:AddTickFunc(Phase[2].DelayTime, function() -- Line: 72
        -- upvalues: Phase (val), Char (ref), VFXUtils (upval), u64 (upval), DamageUtils (upval), Name (upval)
        -- upvalues: SoundUtils (upval), a1 (val), CameraUtils (upval)
        local v1 = Phase[2]
        Char:GetPivot()
        local v2 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("SwordQi"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v2)
        DamageUtils.AOEDamage_Self(Char, Name, 2, v1.DamageConfig)
        SoundUtils.PlaySound(a1, "G_Skill_6_1")
        CameraUtils.TWFOV(Char, TweenInfo.new(0.4), 85)
        task.delay(0.5, function() -- Line: 84 -- upvalues: CameraUtils (upval), Char (upval)
            CameraUtils.TWFOV(Char, TweenInfo.new(0.4), 70)
        end)
    end)
    u14:AddTickFunc(Phase[3].DelayTime, function() -- Line: 89
        -- upvalues: Phase (val), Char (ref), VFXUtils (upval), u64 (upval), SoundUtils (upval), a1 (val)
        -- upvalues: ModelVFXUtils (upval), DamageUtils (upval), Name (upval)
        local v1, v2
        local DamageConfig = Phase[3].DamageConfig
        local Pivot = Char:GetPivot()
        local v3 = VFXUtils.CreateCharVFX(Char, u64:WaitForChild("Submit_1"), 2, "RootAttachment")
        VFXUtils.EmitByPart(v3)
        for i = 1, 3 do
            v1 = (CFrame.new(Pivot.Position + Pivot.LookVector * (i * 14 - 3))) * Pivot.Rotation
            v2 = VFXUtils.CreateVFX(u64:WaitForChild("BZ_" .. i), v1, 3)
            SoundUtils.PlaySoundInPosition(a1, {soundName = "G_Skill_6_2", position = v1.Position})
            VFXUtils.EmitByPart(v2)
            VFXUtils.ToGroundColor(v2:WaitForChild("Rock"))
            ;(v2:WaitForChild("Rock")):PivotTo(v1 * (CFrame.new(0, -6, 0)))
            ModelVFXUtils.TWCFrame(v2:WaitForChild("Rock"), TweenInfo.new(0.1), v1 * CFrame.new(0, -2, 0))
            DamageUtils.AOEDamage_CFrame(a1, v1, Name, 3, DamageConfig)
            task.wait(0.05)
        end
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 123 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_7
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_7
-- Decompile time: 5.89 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u64 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u71 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 26
    -- upvalues: u71 (ref), TimeListFunc (val), Name (val), CameraUtils (val), SoundUtils (val), VFXUtils (val)
    -- upvalues: u64 (val), DamageUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u71.ActionTime
    local Phase = u71.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 44 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    for k, v in pairs(Phase) do
        u14:AddTickFunc(v.DelayTime, function() -- Line: 49 -- upvalues: v (val), CameraUtils (upval), Char (ref)
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake)
            end
        end)
    end
    local u32 = nil
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 58
        -- upvalues: Phase (val), Char (ref), SoundUtils (upval), a1 (val), VFXUtils (upval), u64 (upval), u32 (ref)
        -- upvalues: DamageUtils (upval), Name (upval)
        local v1 = Phase[1]
        local DamageConfig = v1.DamageConfig
        local FlightSpeed = DamageConfig.FlightSpeed
        local FlightTime = DamageConfig.FlightTime
        local Pivot = Char:GetPivot()
        SoundUtils.PlaySound(a1, "G_Skill_7")
        SoundUtils.PlaySound(a1, "G_ATK_3")
        VFXUtils.CreateVFXEmiteOnce(u64:WaitForChild("Ground"), Pivot, 2)
        u32 = VFXUtils.CreateVFX(u64:WaitForChild("SwordQi"), Pivot, FlightTime)
        VFXUtils.FlyVFX(u32, Pivot, Pivot.LookVector, FlightSpeed, FlightTime)
        DamageUtils.FlightDamage_CFrame(Char, (CFrame.new(Pivot.Position + Pivot.LookVector)) * Pivot.Rotation, Name, 1, v1.DamageConfig)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 81 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.G_Skill_8
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.G_Skill_8
-- Decompile time: 3.71 ms

local v1 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Player:FindFirstChild(Name)
local u67 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))

function v1.Play(a1, a2) -- Line: 25
    -- upvalues: u67 (ref), TimeListFunc (val), Name (val), DamageUtils (val), CameraUtils (val), CharUtils (val)
    -- upvalues: VFXUtils (val), u60 (val), SoundUtils (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local u14 = TimeListFunc.new()
    u14:AddTickFunc(0, function() -- Line: 43 -- upvalues: AnimObj (val), Name (upval)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
    end)
    u14:AddTickFunc(Phase[1].DelayTime, function() -- Line: 47
        -- upvalues: Phase (val), DamageUtils (upval), Char (ref), Name (upval), CameraUtils (upval), CharUtils (upval)
        -- upvalues: VFXUtils (upval), u60 (upval), SoundUtils (upval), a1 (val)
        local v1 = Phase[1]
        local v2 = nil
        if v1.DamageConfig then
            local v3, v4 = DamageUtils.AOEDamage_Self(Char, Name, 1, v1.DamageConfig)
            v2 = v4
        end
        if v1.CameraShake then
            CameraUtils.ShakeBySetting(Char, v1.CameraShake, v2)
        end
        if v1.Velocity then
            CharUtils.VeloctiyBySetting(Char, v1.Velocity)
        end
        local Pivot = Char:GetPivot()
        VFXUtils.CreateVFXEmiteOnce(u60:WaitForChild("VFX"), Pivot, 10)
        SoundUtils.PlaySound(a1, Name)
    end)
    u14:AddTickFunc(ActionTime, function() -- Line: 68 -- upvalues: u14 (val), a1 (val)
        u14:Destroy()
        a1:SetAttribute("UsingSkillID", nil)
    end)
    u14:StartTimeList()
    return true
end

function v1.Stop(a1, a2) end

return v1
-- Script Path: game:GetService("ReplicatedStorage").SkillSystemNew.SkillCTRL.K_ATK_1
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: ReplicatedStorage.SkillSystemNew.SkillCTRL.K_ATK_1
-- Decompile time: 5.49 ms

local u0 = {}
local Name = script.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.RunUtils)
local Helper = require(ReplicatedStorage.Config.PlrSkill.Helper)
local TimeListFunc = require(ReplicatedStorage.Object.TimeListFunc)
local DamageUtils = require(ReplicatedStorage.SkillSystemNew.Utils.DamageUtils)
local CameraUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CameraUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundUtils = require(ReplicatedStorage.SkillSystemNew.Utils.SoundUtils)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local u60 = ReplicatedStorage.Assets.SkillVFX_Player:WaitForChild(Name)
local u67 = TableUtils.DeepCopy((Helper.GetPlrSkillData(Name)))
local Trove = require(ReplicatedStorage.Packages.Trove)
local u72 = {}

function u0.Play(a1, a2) -- Line: 28
    -- upvalues: u67 (ref), TimeListFunc (val), u72 (val), Trove (val), Name (val), SoundUtils (val), DamageUtils (val)
    -- upvalues: CameraUtils (val), CharUtils (val), VFXUtils (val), u60 (val), u0 (val)
    if not a1 then
        return
    end
    local Char = a2.Char
    if not Char then
        Char = a1.Character
        if not Char then
            return
        end
    end
    local AnimObj = (if a2 then a2 else {}).AnimObj
    local ActionTime = u67.ActionTime
    local Phase = u67.Phase
    local v1 = TimeListFunc.new()
    if not u72[a1] then
        u72[a1] = (Trove.new())
    end
    u72[a1]:Add(v1)
    v1:AddTickFunc(0, function() -- Line: 53 -- upvalues: AnimObj (val), Name (upval), SoundUtils (upval), a1 (val)
        if AnimObj then
            AnimObj:PlayAnim(Name)
        end
        SoundUtils.PlaySound(a1, Name)
    end)
    for k, v in pairs(Phase) do
        v1:AddTickFunc(v.DelayTime, function() -- Line: 58
            -- upvalues: v (val), DamageUtils (upval), Char (ref), Name (upval), k (val), CameraUtils (upval)
            -- upvalues: CharUtils (upval), VFXUtils (upval), u60 (upval)
            local v1
            local v2 = nil
            if v.DamageConfig then
                local v3
                v1, v3 = DamageUtils.AOEDamage_Self(Char, Name, k, v.DamageConfig)
                v2 = v3
            end
            if v.CameraShake then
                CameraUtils.ShakeBySetting(Char, v.CameraShake, v2)
            end
            if v.Velocity then
                CharUtils.VeloctiyBySetting(Char, v.Velocity)
            end
            v1 = VFXUtils.CreateCharVFX(Char, u60:WaitForChild("Attack"), 1)
            VFXUtils.LockVFXToModel(v1.PrimaryPart, Char, "RootAttachment")
            VFXUtils.EmitByPart(v1)
        end)
    end
    v1:AddTickFunc(ActionTime, function() -- Line: 77 -- upvalues: u0 (upval), a1 (val)
        u0.Stop(a1)
    end)
    v1:StartTimeList()
    return true
end

function u0.Stop(a1, a2) -- Line: 84 -- upvalues: u72 (val) -- types: a1: userdata
    a1:SetAttribute("UsingSkillID", nil)
    u72[a1]:Clean()
    u72[a1] = nil
end

return u0
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.ProximityPromptManager
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.ProximityPromptManager
-- Decompile time: 17.16 ms

local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PromptUIEffects = require(script:WaitForChild("PromptUIEffects"))
local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.ChildAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Temple = (((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("UI")):WaitForChild("ProximityPrompt")):WaitForChild("Temple")
local u66 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png",
}
local u77 = {
    ["'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png",
}
local u83 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12",
    [Enum.KeyCode.PageUp] = "PgUp",
    [Enum.KeyCode.PageDown] = "PgDn",
    [Enum.KeyCode.Home] = "Home",
    [Enum.KeyCode.End] = "End",
    [Enum.KeyCode.Insert] = "Ins",
    [Enum.KeyCode.Delete] = "Del",
}
local u128 = {
    [Enum.KeyCode.LeftControl] = 12,
    [Enum.KeyCode.RightControl] = 12,
    [Enum.KeyCode.LeftAlt] = 12,
    [Enum.KeyCode.RightAlt] = 12,
    [Enum.KeyCode.F10] = 12,
    [Enum.KeyCode.F11] = 12,
    [Enum.KeyCode.F12] = 12,
    [Enum.KeyCode.PageUp] = 8,
    [Enum.KeyCode.PageDown] = 8,
    [Enum.KeyCode.Home] = 8,
    [Enum.KeyCode.End] = 10,
    [Enum.KeyCode.Insert] = 10,
    [Enum.KeyCode.Delete] = 10,
}
local u158 = Vector2.new(1920, 1080)
local u159 = nil

local function getScreenGui() -- Line: 85 -- upvalues: PlayerGui (val), u159 (ref)
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui")
        ProximityPrompts.Name = "ProximityPrompts"
        ProximityPrompts.ResetOnSpawn = false
        ProximityPrompts.Parent = PlayerGui
        ProximityPrompts.IgnoreGuiInset = true
        u159 = ProximityPrompts.AbsoluteSize
    end
    return ProximityPrompts
end

local function setupInputVisual(a1, a2, a3, a4) -- Line: 101
    -- upvalues: UserInputService (val), u66 (val), u77 (val), u83 (val), u128 (val)
    a3.Visible = false
    a4.Visible = false
    if a2 == Enum.ProximityPromptInputType.Gamepad then
        a4.Text = "X"
        a4.Visible = true
        return 1.33
    end
    if a2 == Enum.ProximityPromptInputType.Touch then
        a3.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        a4.Text = "E"
        a4.Visible = true
        return 1.6
    end
    local StringForKeyCode = UserInputService:GetStringForKeyCode(a1.KeyboardKeyCode)
    local v1 = u66[a1.KeyboardKeyCode]
    if v1 == nil then
        v1 = u77[StringForKeyCode]
    end
    if v1 == nil then
        local v2 = u83[a1.KeyboardKeyCode]
        if v2 then
            StringForKeyCode = v2
        end
    end
    if v1 then
        a3.Image = v1
    elseif StringForKeyCode == nil or StringForKeyCode == "" then
        error("ProximityPrompt '" .. a1.Name .. "' 有一个不支持的键码来渲染 UI: " .. tostring(a1.KeyboardKeyCode))
    else
        a3.Image = "rbxasset://textures/ui/Controls/key_single.png"
        a4.Text = StringForKeyCode
        a4.TextSize = u128[a1.KeyboardKeyCode] or 14
        a4.Visible = true
    end
    return 1.33
end

local function createPrompt(a1, a2, a3) -- Line: 157
    -- upvalues: Temple (val), u159 (ref), PlayerGui (val), u158 (val), setupInputVisual (val), PromptUIEffects (val)
    -- upvalues: RunService (val)
    local u6 = Temple:Clone()
    u6.Name = "Prompt"
    u6.AlwaysOnTop = true
    u6.Active = false
    local u29 = 1
    if not u159 then
        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
        if ProximityPrompts then
            u159 = ProximityPrompts.AbsoluteSize
        end
    end
    if u159 then
        u29 = (u159.X + u159.Y) / (u158.X + u158.Y)
        local Frame_2 = u6:WaitForChild("Frame")
        Frame_2:WaitForChild("UIScale").Scale = u29
        local TextButton_2 = u6:WaitForChild("TextButton")
        TextButton_2:WaitForChild("UIScale").Scale = u29
    end
    local Frame = u6.Frame
    local UIPadding = Frame.UIPadding
    local UIListLayout = Frame.UIListLayout
    local Frame_3 = Frame.InputFrame.Frame
    local UIScale = Frame_3.UIScale
    local RoundFrame = Frame_3.RoundFrame
    local ButtonImage = Frame_3.ButtonImage
    local ButtonText = Frame_3.ButtonText
    local TextFrame = Frame.TextFrame
    local ActionText = TextFrame.ActionText
    local ObjectText = TextFrame.ObjectText
    local TextButton = u6.TextButton
    TextButton.Active = false
    local v1 = setupInputVisual(a1, a2, ButtonImage, ButtonText)
    local v2 = nil
    if 0 < a1.HoldDuration then
        v2 = PromptUIEffects.createProgressBar()
        v2.Parent = Frame_3
    end
    local u79 = {
        Frame = Frame,
        ListLayout = UIListLayout,
        TextFrame = TextFrame,
        ActionText = ActionText,
        ObjectText = ObjectText,
        RoundFrame = RoundFrame,
        ButtonImage = ButtonImage,
        ButtonText = ButtonText,
        InputScale = UIScale,
        InputScaleFactor = v1,
        ProgressBar = v2,
    }
    PromptUIEffects.setHidden(u79)
    if a2 == Enum.ProximityPromptInputType.Touch or a1.ClickablePrompt then
        TextButton.Active = true
        u6.Active = true
        local u105 = false
        TextButton.InputBegan:Connect(function(a1_2) -- Line: 226 -- upvalues: a1 (val), u105 (ref)
            if a1_2.UserInputType == Enum.UserInputType.Touch then
                if a1_2.UserInputState ~= Enum.UserInputState.Change then
                    a1:InputHoldBegin()
                    u105 = true
                end
            elseif a1_2.UserInputType == Enum.UserInputType.MouseButton1
                and a1_2.UserInputState ~= Enum.UserInputState.Change then
                a1:InputHoldBegin()
                u105 = true
            end
        end)
        TextButton.InputEnded:Connect(function(a1_2) -- Line: 233 -- upvalues: u105 (ref), a1 (val)
            if a1_2.UserInputType == Enum.UserInputType.Touch then
                if u105 then
                    u105 = false
                    a1:InputHoldEnd()
                end
            elseif a1_2.UserInputType == Enum.UserInputType.MouseButton1 and u105 then
                u105 = false
                a1:InputHoldEnd()
            end
        end)
    end
    local u131 = nil
    local u137 = nil
    if 0 < a1.HoldDuration then
        u131 = a1.PromptButtonHoldBegan:Connect(function() -- Line: 249 -- upvalues: PromptUIEffects (upval), u79 (val), a1 (val)
            PromptUIEffects.playHoldBegin(u79, a1.HoldDuration)
        end)
        u137 = a1.PromptButtonHoldEnded:Connect(function() -- Line: 253 -- upvalues: PromptUIEffects (upval), u79 (val)
            PromptUIEffects.playHoldEnd(u79)
        end)
    end
    local u145 = a1.Triggered:Connect(function() -- Line: 258 -- upvalues: PromptUIEffects (upval), u79 (val)
        PromptUIEffects.playFadeOut(u79)
    end)
    local u151 = a1.TriggerEnded:Connect(function() -- Line: 262 -- upvalues: PromptUIEffects (upval), u79 (val)
        PromptUIEffects.playFadeIn(u79)
    end)

    local function updateUIFromPrompt() -- Line: 266
        -- upvalues: a1 (val), ActionText (val), ObjectText (val), UIPadding (val), RunService (upval), Frame (val)
        local u0 = 72
        local v1 = 0
        if a1.ObjectText ~= nil and a1.ObjectText ~= "" then
            v1 = 9
        end
        ActionText.Text = a1.ActionText
        ObjectText.Text = a1.ObjectText
        ActionText.AutoLocalize = a1.AutoLocalize
        ActionText.RootLocalizationTable = a1.RootLocalizationTable
        ObjectText.AutoLocalize = a1.AutoLocalize
        ObjectText.RootLocalizationTable = a1.RootLocalizationTable
        local v2 = 0 - v1
        if a1.ActionText == nil then
            if a1.ObjectText == nil or a1.ObjectText == "" then
                UIPadding.PaddingRight = UDim.new(0, 0)
            else
                UIPadding.PaddingRight = UDim.new(0, v2)
            end
        elseif a1.ActionText ~= "" then
            UIPadding.PaddingRight = UDim.new(0, v2)
        elseif a1.ObjectText == nil or a1.ObjectText == "" then
            UIPadding.PaddingRight = UDim.new(0, 0)
        else
            UIPadding.PaddingRight = UDim.new(0, v2)
        end
        ObjectText.Visible = ObjectText.Text ~= ""
        task.defer(function() -- Line: 307 -- upvalues: RunService (upval), u0 (ref), Frame (upval)
            RunService.RenderStepped:Wait()
            RunService.RenderStepped:Wait()
            u0 = Frame.AbsoluteSize.X
        end)
    end

    local u170 = a1.Changed:Connect(updateUIFromPrompt)
    updateUIFromPrompt()
    u6.Adornee = a1.Parent
    u6.Parent = a3
    local u187 = a1.AncestryChanged:Connect(function() -- Line: 324 -- upvalues: u6 (val), a1 (val)
        u6.Adornee = a1.Parent
    end)
    PromptUIEffects.playFadeIn(u79)

    local function updateScale() -- Line: 332 -- upvalues: a1 (val), u6 (val), u29 (ref)
        local Attribute = a1:GetAttribute("Scale")
        if Attribute then
            local UIScale = (u6:WaitForChild("Frame")):WaitForChild("UIScale")
            UIScale.Scale = u29 * Attribute
            local UIScale_2 = (u6:WaitForChild("TextButton")):WaitForChild("UIScale")
            UIScale_2.Scale = u29 * Attribute
        end
    end

    local u206 = (a1:GetAttributeChangedSignal("Scale")):Connect(updateScale)
    updateScale()
    return function() -- Line: 342
        -- upvalues: u131 (ref), u137 (ref), u206 (val), u145 (ref), u151 (ref), u170 (val), u187 (val)
        -- upvalues: PromptUIEffects (upval), u79 (val), u6 (val)
        if u131 then
            u131:Disconnect()
        end
        if u137 then
            u137:Disconnect()
        end
        if u206 then
            u206:Disconnect()
        end
        u145:Disconnect()
        u151:Disconnect()
        u170:Disconnect()
        u187:Disconnect()
        PromptUIEffects.playFadeOut(u79)
        task.wait(0.2)
        u6.Parent = nil
    end
end

local function createIndicator(a1, a2) -- Line: 370 -- upvalues: TweenService (val)
    local u2 = {}
    local v1 = {}
    local v2 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "Indicator"
    BillboardGui.Size = UDim2.fromOffset(15, 15)
    BillboardGui.AlwaysOnTop = true
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundTransparency = 1
    Frame.BackgroundColor3 = Color3.new(0.07, 0.07, 0.07)
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.fromScale(0.5, 0)
    Frame.Parent = BillboardGui
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.new(1, 1, 1)
    UIStroke.Thickness = 1.5
    UIStroke.Transparency = 1
    UIStroke.Parent = Frame
    table.insert(u2, (TweenService:Create(Frame, v2, {BackgroundTransparency = 1})))
    table.insert(u2, (TweenService:Create(UIStroke, v2, {Transparency = 1})))
    table.insert(v1, (TweenService:Create(Frame, v2, {BackgroundTransparency = 0.2})))
    table.insert(v1, (TweenService:Create(UIStroke, v2, {Transparency = 0.2})))
    BillboardGui.Adornee = a1.Parent
    BillboardGui.Parent = a2
    local u102 = a1.AncestryChanged:Connect(function() -- Line: 407 -- upvalues: BillboardGui (val), a1 (val)
        BillboardGui.Adornee = a1.Parent
    end)
    for i, v in ipairs(v1) do
        v:Play()
    end
    return function() -- Line: 416 -- upvalues: u102 (val), u2 (val), BillboardGui (val)
        u102:Disconnect()
        for i, v in ipairs(u2) do
            v:Play()
        end
        task.wait(0.2)
        BillboardGui.Parent = nil
    end
end

;(function() -- Line: 431
    -- upvalues: ProximityPromptService (val), PlayerGui (val), u159 (ref), createPrompt (val), createIndicator (val)
    ProximityPromptService.PromptShown:Connect(function(a1, a2) -- Line: 432 -- upvalues: PlayerGui (upval), u159 (upval), createPrompt (upval)
        if a1.Style ~= Enum.ProximityPromptStyle.Custom then
            return
        end
        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui")
            ProximityPrompts.Name = "ProximityPrompts"
            ProximityPrompts.ResetOnSpawn = false
            ProximityPrompts.Parent = PlayerGui
            ProximityPrompts.IgnoreGuiInset = true
            u159 = ProximityPrompts.AbsoluteSize
        end
        local v1 = createPrompt(a1, a2, ProximityPrompts)
        local BindableEvent = Instance.new("BindableEvent")
        local v2 = a1.PromptHidden:Connect(function() -- Line: 443 -- upvalues: BindableEvent (val)
            BindableEvent:Fire()
        end)
        local v3 = a1.Destroying:Connect(function() -- Line: 446 -- upvalues: BindableEvent (val)
            BindableEvent:Fire()
        end)
        BindableEvent.Event:Wait()
        v2:Disconnect()
        v3:Disconnect()
        v1()
    end)
    ProximityPromptService.IndicatorShown:Connect(function(a1) -- Line: 456 -- upvalues: PlayerGui (upval), u159 (upval), createIndicator (upval)
        if a1.Style ~= Enum.ProximityPromptStyle.Custom then
            return
        end
        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui")
            ProximityPrompts.Name = "ProximityPrompts"
            ProximityPrompts.ResetOnSpawn = false
            ProximityPrompts.Parent = PlayerGui
            ProximityPrompts.IgnoreGuiInset = true
            u159 = ProximityPrompts.AbsoluteSize
        end
        local v1 = createIndicator(a1, ProximityPrompts)
        local BindableEvent = Instance.new("BindableEvent")
        local v2 = a1.IndicatorHidden:Connect(function() -- Line: 467 -- upvalues: BindableEvent (val)
            BindableEvent:Fire()
        end)
        local v3 = a1.Destroying:Connect(function() -- Line: 470 -- upvalues: BindableEvent (val)
            BindableEvent:Fire()
        end)
        BindableEvent.Event:Wait()
        v2:Disconnect()
        v3:Disconnect()
        v1()
    end)
end)()
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.ProximityPromptManager.PromptUIEffects
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.ProximityPromptManager.PromptUIEffects
-- Decompile time: 10.83 ms

local TweenService = game:GetService("TweenService")
local v1 = {}
local u10 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local u15 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u20 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function tween(a1, a2, a3) -- Line: 30 -- upvalues: TweenService (val)
    if a1 == nil then
        return
    end
    TweenService:Create(a1, a2, a3):Play()
end

local function createProgressBarGradient(a1, a2) -- Line: 41
    local Frame = Instance.new("Frame")
    Frame.Name = if not a2 then "RightFill" else "LeftFill"
    Frame.Size = UDim2.fromScale(0.5, 1)
    Frame.Position = UDim2.fromScale(if not a2 then 0.5 else 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.ClipsDescendants = true
    Frame.Visible = false
    Frame.Parent = a1
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "RadialImage"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ImageTransparency = 1
    ImageLabel.ZIndex = 10
    ImageLabel.Size = UDim2.fromScale(2, 1)
    ImageLabel.Position = UDim2.fromScale(if not a2 then -1 else 0, 0)
    ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
    ImageLabel.Parent = Frame
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.51, 1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    UIGradient.Rotation = if not a2 then 0 else 180
    UIGradient.Parent = ImageLabel
    return UIGradient, Frame
end

function v1.createProgressBar() -- Line: 75 -- upvalues: createProgressBarGradient (val)
    local Frame = Instance.new("Frame")
    Frame.Name = "CircularProgressBar"
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.fromScale(1.1, 1.1)
    Frame.BackgroundTransparency = 1
    local u20, u21 = createProgressBarGradient(Frame, true)
    local u25, u26 = createProgressBarGradient(Frame, false)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "Progress"
    NumberValue.Parent = Frame
    NumberValue.Changed:Connect(function(a1) -- Line: 90 -- upvalues: u21 (val), u20 (val), u26 (val), u25 (val)
        local v1 = math.clamp(a1 * 360, 0, 360)
        u21.Visible = a1 > 0.5
        u20.Rotation = math.clamp(v1, 180, 360)
        u26.Visible = a1 > 0.01
        u25.Rotation = math.clamp(v1, 0, 180)
    end)
    return Frame
end

local function tweenProgressRadialImages(a1, a2, a3) -- Line: 101 -- upvalues: TweenService (val)
    if a1 == nil then
        return
    end
    local LeftFill = a1:FindFirstChild("LeftFill")
    local RightFill = a1:FindFirstChild("RightFill")
    if LeftFill then
        local RadialImage = LeftFill:FindFirstChild("RadialImage")
        local v1 = {ImageTransparency = a3}
        if RadialImage ~= nil then
            TweenService:Create(RadialImage, a2, v1):Play()
        end
    end
    if RightFill then
        local RadialImage_2 = RightFill:FindFirstChild("RadialImage")
        if RadialImage_2 == nil then
            return
        end
        TweenService:Create(RadialImage_2, a2, {ImageTransparency = a3}):Play()
    end
end

function v1.playFadeIn(a1) -- Line: 121
    -- upvalues: TweenService (val), u15 (val), u10 (val), tweenProgressRadialImages (val)
    a1.Frame.Position = UDim2.fromScale(0.3, 0)
    a1.Frame.Rotation = 40
    local Frame = a1.Frame
    local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    local v2 = {Size = UDim2.fromScale(1, 1)}
    if Frame ~= nil then
        TweenService:Create(Frame, v1, v2):Play()
    end
    local Frame_2 = a1.Frame
    v1 = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
    v2 = {Position = UDim2.fromScale(0.5, 0.5)}
    if Frame_2 ~= nil then
        TweenService:Create(Frame_2, v1, v2):Play()
    end
    local Frame_3 = a1.Frame
    v1 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    if Frame_3 ~= nil then
        TweenService:Create(Frame_3, v1, {Rotation = 0}):Play()
    end
    local ObjectText = a1.ObjectText
    if ObjectText ~= nil then
        TweenService:Create(ObjectText, u15, {TextTransparency = 0}):Play()
    end
    local ListLayout = a1.ListLayout
    v2 = {Padding = UDim.new(0, 0)}
    if ListLayout ~= nil then
        TweenService:Create(ListLayout, u15, v2):Play()
    end
    local ButtonText = a1.ButtonText
    if ButtonText ~= nil then
        TweenService:Create(ButtonText, u10, {TextTransparency = 0}):Play()
    end
    tweenProgressRadialImages(a1.ProgressBar, u10, 0)
end

function v1.playFadeOut(a1) -- Line: 143
    -- upvalues: TweenService (val), u15 (val), u10 (val), tweenProgressRadialImages (val)
    local Frame = a1.Frame
    local v1 = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    local v2 = {Position = UDim2.fromScale(0.3, 0)}
    if Frame ~= nil then
        TweenService:Create(Frame, v1, v2):Play()
    end
    local Frame_2 = a1.Frame
    v1 = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    if Frame_2 ~= nil then
        TweenService:Create(Frame_2, v1, {Rotation = -30}):Play()
    end
    local Frame_3 = a1.Frame
    v1 = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    v2 = {Size = UDim2.fromScale(0, 0)}
    if Frame_3 ~= nil then
        TweenService:Create(Frame_3, v1, v2):Play()
    end
    local ObjectText = a1.ObjectText
    if ObjectText ~= nil then
        TweenService:Create(ObjectText, u15, {TextTransparency = 1}):Play()
    end
    local ListLayout = a1.ListLayout
    v2 = {Padding = UDim.new(-0.25, 0)}
    if ListLayout ~= nil then
        TweenService:Create(ListLayout, u15, v2):Play()
    end
    local ButtonText = a1.ButtonText
    if ButtonText ~= nil then
        TweenService:Create(ButtonText, u10, {TextTransparency = 1}):Play()
    end
    tweenProgressRadialImages(a1.ProgressBar, u10, 1)
end

function v1.setHidden(a1) -- Line: 163
    a1.ObjectText.TextTransparency = 1
    a1.ListLayout.Padding = UDim.new(-0.25, 0)
    a1.ButtonText.TextTransparency = 1
end

function v1.playHoldBegin(a1, a2) -- Line: 179 -- upvalues: u15 (val), TweenService (val)
    local InputScale = a1.InputScale
    local v1 = {Scale = a1.InputScaleFactor or 1.33}
    if InputScale ~= nil then
        TweenService:Create(InputScale, u15, v1):Play()
    end
    local ObjectText = a1.ObjectText
    if ObjectText ~= nil then
        TweenService:Create(ObjectText, u15, {TextTransparency = 1}):Play()
    end
    local ListLayout = a1.ListLayout
    v1 = {Padding = UDim.new(-0.25, 0)}
    if ListLayout ~= nil then
        TweenService:Create(ListLayout, u15, v1):Play()
    end
    local ProgressBar = a1.ProgressBar
    if ProgressBar and a2 and a2 > 0 then
        local v2 = TweenInfo.new(a2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local Progress = ProgressBar:FindFirstChild("Progress")
        if Progress == nil then
            return
        end
        TweenService:Create(Progress, v2, {Value = 1}):Play()
    end
end

function v1.playHoldEnd(a1) -- Line: 194 -- upvalues: u15 (val), TweenService (val), u20 (val)
    local InputScale = a1.InputScale
    if InputScale ~= nil then
        TweenService:Create(InputScale, u15, {Scale = 1}):Play()
    end
    local ObjectText = a1.ObjectText
    if ObjectText ~= nil then
        TweenService:Create(ObjectText, u15, {TextTransparency = 0}):Play()
    end
    local ListLayout = a1.ListLayout
    local v1 = {Padding = UDim.new(0, 0)}
    if ListLayout ~= nil then
        TweenService:Create(ListLayout, u15, v1):Play()
    end
    local ProgressBar = a1.ProgressBar
    if ProgressBar then
        local Progress = ProgressBar:FindFirstChild("Progress")
        if Progress == nil then
            return
        end
        TweenService:Create(Progress, u20, {Value = 0}):Play()
    end
end

v1.playCancel = v1.playHoldEnd
return v1
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.BGMManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.BGMManager
-- Decompile time: 1.22 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BGMUtils = require(ReplicatedStorage.Utils.BGMUtils)
local LocalPlayer = game.Players.LocalPlayer
repeat
    task.wait()
until workspace:GetAttribute("OpenAnimDone")
BGMUtils.PlayFolderBGM("Music")
;(LocalPlayer:GetAttributeChangedSignal("IntoFight")):Connect(function() -- Line: 13 -- upvalues: LocalPlayer (val), BGMUtils (val)
    local Attribute = LocalPlayer:GetAttribute("IntoFight")
    if not Attribute then
        BGMUtils.PlayFolderBGM("Music")
        return
    end
    if Attribute == "Stage" then
        BGMUtils.PlayFolderBGM("Fight")
        return
    end
    if Attribute == "Dungeon" then
        BGMUtils.PlayFolderBGM("Dungeon")
        return
    end
    if Attribute == "WorldBoss" then
        BGMUtils.PlayFolderBGM("WorldBoss")
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.ClientManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.ClientManager
-- Decompile time: 3.77 ms

local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local ProfileData = require(ReplicatedStorage.ProfileData)
local LocalData = ReplicatedStorage.LocalData
local GuiUtils = ReplicatedStorage.GuiUtils
local Attribute = script:GetAttribute("IsPrint")
local Main = LocalPlayer.PlayerGui:WaitForChild("Main")
workspace:SetAttribute("ScreenResolution", Main.AbsoluteSize)
local v2 = {}
for i, j in GuiUtils:GetChildren() do
    if j:IsA("ModuleScript") then
        table.insert(v2, j)
    end
end
local v3 = os.clock()
print("开始加载")
ProfileData.init()
for k, n in LocalData:GetChildren() do
    if n:IsA("ModuleScript") then
        if Attribute then
            print(n.Name)
        end
        v1 = require(n)
        if v1.init then
            v1.init()
        end
    end
end
print("加载完本地数据，耗时：", os.clock() - v3)
v3 = os.clock()
local v4 = nil
local v5 = nil
for m, i5 in v2, v4, v5 do
    if Attribute then
        print(i5.Name)
    end
    v1 = require(i5)
    if v1.init then
        v1.init()
    end
end
print("加载完UI初始化，耗时：", os.clock() - v3)
v3 = os.clock()
v4 = nil
v5 = nil
for i6, i7 in v2, v4, v5 do
    if Attribute then
        print(i7.Name)
    end
    local u125 = require(i7)
    task.spawn(function() -- Line: 56 -- upvalues: u125 (val)
        if u125.start then
            u125.start()
        end
    end)
end
print("加载完UIStart，耗时：", os.clock() - v3)
workspace:SetAttribute("UIInitDone", true)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.DamageManager
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.DamageManager
-- Decompile time: 27.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local CalculateUtils = require(ReplicatedStorage.Utils.CalculateUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local DebuffUtils = require(ReplicatedStorage.Utils.DebuffUtils)
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local Helper = require(ReplicatedStorage.Config.EnchStone.Helper)
local v1 = CommunicationUtils.TryGetBindableEvent("Attack", "AttackPlayerBE")
local v2 = CommunicationUtils.TryGetRemoteEvent("Attack", "AttackPlayerRE")
local v3 = CommunicationUtils.TryGetBindableEvent("Attack", "AttackEnemyBE")
local v4 = CommunicationUtils.TryGetBindableEvent("Attack", "AttackDummyBE")
local u48 = CommunicationUtils.TryGetBindableEvent("Attack", "DummyHitBE")
local u52 = CommunicationUtils.TryGetBindableEvent("Attack", "EnemyHitBE")
local u56 = CommunicationUtils.TryGetBindableEvent("Attack", "PlrHitBE")
local EnemyFolder = workspace:WaitForChild("EnemyFolder")
local EnemyFolder_Server = workspace:WaitForChild("EnemyFolder_Server")
v1.Event:Connect(function(a1, a2) -- Line: 26 -- upvalues: EnemyFolder (val), CalculateUtils (val), LocalPlayer (val), u56 (val)
    local v1 = EnemyFolder:FindFirstChild(a1)
    if not v1 then
        return
    end
    a2.ATK = v1:GetAttribute("ATK") or 100
    u56:Fire((CalculateUtils.CCEnemyDamage(a2)) / (CalculateUtils.CCPlrDefence(LocalPlayer)), a1)
end)
v2.OnClientEvent:Connect(function(a1, a2) -- Line: 43 -- upvalues: EnemyFolder_Server (val), CalculateUtils (val), LocalPlayer (val), u56 (val)
    local v1 = EnemyFolder_Server:FindFirstChild(a1)
    if not v1 then
        return
    end
    a2.ATK = v1:GetAttribute("ATK") or 100
    u56:Fire((CalculateUtils.CCEnemyDamage(a2)) / (CalculateUtils.CCPlrDefence(LocalPlayer)), a1)
end)
v4.Event:Connect(function(a1, a2) -- Line: 63 -- upvalues: CalculateUtils (val), LocalPlayer (val), u48 (val)
    local v1, v2
    local v3 = CalculateUtils.CCPlrDamage(LocalPlayer, a2)
    local v4 = CalculateUtils.CCCrit(LocalPlayer)
    local SkillID = a2.SkillID
    local v5 = nil
    local v6 = nil
    for i, j in a1, v5, v6 do
        if math.random() <= v4 then
            v3 = v3 * 1.5
        end
        u48:Fire(j, v3, {SkillID = SkillID, IsCrit = v1, Damage = v3})
        v2 = SkillID:split("_")[2] == "ATK"
        if j.PrimaryPart and j.PrimaryPart:FindFirstChild("EnemyHPUI") then
            SetOnceEnchance(v2, j, "Dummy")
        end
    end
end)
v3.Event:Connect(function(a1, a2) -- Line: 88 -- upvalues: CalculateUtils (val), LocalPlayer (val), u52 (val), EnemyFolder (val)
    local v1, v2, v3
    local Attacker = a2.Attacker
    local SkillID = a2.SkillID
    local v4 = CalculateUtils.CCPlrDamage(Attacker, a2)
    local v5 = CalculateUtils.CCCrit(LocalPlayer)
    local v6 = nil
    local v7 = nil
    for i, j in a1, v6, v7 do
        if math.random() <= v5 then
            v4 = v4 * 1.5
        end
        u52:Fire(j, v4, {SkillID = SkillID, IsCrit = v1, Damage = v4})
        if Attacker == LocalPlayer then
            v2 = EnemyFolder:FindFirstChild(j)
            if v2 and not v2:GetAttribute("Dead") then
                v3 = SkillID:split("_")[2] == "ATK"
                SetOnceEnchance(v3, v2, "Enemy", j)
                continue
            end
            return
        end
    end
end)

function SetOnceEnchance(a1, a2, a3, a4) -- Line: 119
    -- upvalues: CalculateUtils (val), LocalPlayer (val), BackpackData (val), DebuffUtils (val), Helper (val), u52 (val)
    -- upvalues: u48 (val)
    if a2 and not a2:GetAttribute("Dead") then
        local AddBuff, AddBuff_3, AddBuff_4, BoomPercent, BuffPercent, BuffTime, BuffTime_2, BuffTime_3, BuffValue, EquipmentType, ID, IcePercent, Level, Type, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        CalculateUtils.CCPlrOnceDamage(LocalPlayer)
        local Weapon = BackpackData.GetItemDataByIndex("Weapon")
        local v11 = BackpackData.GetItemDataByIndex("Hat") or nil
        local v12 = BackpackData.GetItemDataByIndex("Armor") or nil
        local v13 = DebuffUtils.GetCharBuffs(a2) or {}
        local v14 = CalculateUtils.CCPlrOnceDamage(LocalPlayer)
        local v15 = {Weapon, v11, v12}
        local v16 = nil
        local v17 = nil
        for i, j in v15, v16, v17 do
            if j and j.EnchanceList then
                Type = j.Type
                v1 = {}
                v2 = nil
                v3 = nil
                for k, n in j.EnchanceList, v2, v3 do
                    if n then
                        ID = n.ID
                        if ID then
                            v4 = ID:split("_")[1]
                            v5 = tonumber((ID:split("_"))[2])
                            v6 = Helper.GetStoneConfig(ID)
                            BuffPercent = v6.BuffPercent
                            v7 = math.random() < BuffPercent
                            if v4 ~= "Thunder" and not a1 then
                                v7 = false
                            end
                            if v7 then
                                if not v1[v4] then
                                    v1[v4] = {}
                                end
                                if not v1[v4].Level then
                                    v1[v4].Level = v5
                                else
                                    v8 = v1[v4]
                                    v8.Level = math.max(v1[v4].Level, v5)
                                end
                                if v4 == "Fire" then
                                    BoomPercent = v6.BoomPercent
                                    if math.random() < BoomPercent and not v1[v4].IsBoom then
                                        v1[v4].IsBoom = true
                                    end
                                elseif v4 == "Ice" then
                                    IcePercent = v6.IcePercent
                                    if math.random() < IcePercent and not v1[v4].IsFreezen then
                                        v1[v4].IsFreezen = true
                                    end
                                elseif v4 ~= "Thunder" then
                                end
                            end
                        end
                    end
                end
                v2 = nil
                v3 = nil
                for m, i5 in v1, v2, v3 do
                    EquipmentType = i5.EquipmentType
                    Level = i5.Level
                    v6 = Helper.GetStoneConfig((("%*_%*"):format(m, Level)))
                    BuffValue = v6.BuffValue
                    v7 = false
                    v8 = v13
                    v9 = nil
                    for i6, i7 in v8, v9 do
                        if i7.ID == m and i7.Config.EquipmentType == EquipmentType then
                            v7 = true
                        end
                    end
                    if not v7 then
                        if m == "Ice" then
                            AddBuff = DebuffUtils.AddBuff
                            BuffTime = v6.BuffTime
                            AddBuff(a2, m, BuffTime, {BuffValue = BuffValue, EquipmentType = EquipmentType})
                            if i5.IsFreezen then
                                local u120 = v14 * v6.IceValue
                                DebuffUtils.AddBuff(a2, "Freezen", v6.IceTime, {
                                    BuffValue = BuffValue,
                                    EquipmentType = EquipmentType,
                                    ExitFunc = function() -- Line: 228 -- upvalues: a3 (val), u52 (upval), a4 (val), u120 (val), u48 (upval), a2 (val)
                                        if a3 == "Enemy" then
                                            u52:Fire(a4, u120, {DamageType = "Ice"})
                                            return
                                        end
                                        if a3 == "Dummy" then
                                            u48:Fire(a2, u120, {DamageType = "Ice"})
                                        end
                                    end,
                                })
                            end
                        elseif m == "Fire" then
                            local u131 = v14 * BuffValue
                            AddBuff_3 = DebuffUtils.AddBuff
                            BuffTime_2 = v6.BuffTime
                            v10 = {
                                BuffValue = BuffValue,
                                EquipmentType = EquipmentType,
                                Interval = v6.DamageInterval,
                                IntervalFunc = function() -- Line: 245 -- upvalues: a2 (val), a3 (val), u52 (upval), a4 (val), u131 (val), u48 (upval)
                                    if a2 and a2.Parent then
                                        if a3 == "Enemy" then
                                            u52:Fire(a4, u131, {DamageType = "Fire"})
                                            return
                                        end
                                        if a3 == "Dummy" then
                                            u48:Fire(a2, u131, {DamageType = "Fire"})
                                        end
                                        return
                                    end
                                end,
                            }
                            AddBuff_3(a2, m, BuffTime_2, v10)
                            if i5.IsBoom then
                                DebuffUtils.AddBuff(a2, "FireBoom", 0.1)
                                v9 = v14 * v6.BoomValue
                                if a3 == "Enemy" then
                                    u52:Fire(a4, v9, {DamageType = "Fire"})
                                elseif a3 == "Dummy" then
                                    u48:Fire(a2, v9, {DamageType = "Fire"})
                                end
                            end
                        elseif m == "Poison" then
                            local u164 = v14 * BuffValue
                            AddBuff_4 = DebuffUtils.AddBuff
                            BuffTime_3 = v6.BuffTime
                            v10 = {
                                BuffValue = BuffValue,
                                EquipmentType = EquipmentType,
                                Interval = v6.DamageInterval,
                                IntervalFunc = function() -- Line: 274 -- upvalues: a2 (val), a3 (val), u52 (upval), a4 (val), u164 (val), u48 (upval)
                                    if a2 and a2.Parent then
                                        if a3 == "Enemy" then
                                            u52:Fire(a4, u164, {DamageType = "Poison"})
                                            return
                                        end
                                        if a3 == "Dummy" then
                                            u48:Fire(a2, u164, {DamageType = "Poison"})
                                        end
                                        return
                                    end
                                end,
                            }
                            AddBuff_4(a2, m, BuffTime_3, v10)
                        elseif m == "Thunder" then
                            DebuffUtils.AddBuff(a2, "Thunder", 0.1)
                            v8 = v14 * BuffValue
                            if a3 == "Enemy" then
                                u52:Fire(a4, v8, {DamageType = "Thunder"})
                            elseif a3 == "Dummy" then
                                u48:Fire(a2, v8, {DamageType = "Thunder"})
                            end
                        end
                    end
                end
            end
        end
        return
    end
end
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.DummyManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.DummyManager
-- Decompile time: 1.71 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrainCTRL = require(ReplicatedStorage.CTRL.TrainCTRL)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local HitVFXUtils = require(ReplicatedStorage.Utils.HitVFXUtils)
local v1 = CommunicationUtils.TryGetBindableEvent("Attack", "DummyHitBE")
TrainCTRL.StartTrain()
v1.Event:Connect(function(a1, a2, a3) -- Line: 10 -- upvalues: HitVFXUtils (val)
    if not a3 then
        a3 = {}
    end
    if not a3.Damage then
        a3.Damage = a2
    end
    HitVFXUtils.GetHurtVFX("Dummy", a1, a3)
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.DungeonManager
-- Took 0.01s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.DungeonManager
-- Decompile time: 17.46 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
local TranslateUtils = require(ReplicatedStorage.Utils.TranslateUtils)
require(ReplicatedStorage.Utils.UUIDUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local HitVFXUtils = require(ReplicatedStorage.Utils.HitVFXUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Tool.BehaviorTree_Creater)
require(ReplicatedStorage.Object.AnimatorObj)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
local EnemyCTRL = require(ReplicatedStorage.CTRL.EnemyCTRL)
require(ReplicatedStorage.GuiUtils.TopGUI)
local DungeonFightGUI = require(ReplicatedStorage.GuiUtils.DungeonFightGUI)
local Helper = require(ReplicatedStorage.Config.Dungeon.Helper)
require(ReplicatedStorage.Config.Enemy.Helper)
local DungeonData = require(ReplicatedStorage.LocalData.DungeonData)
local RewardUtils = require(script.RewardUtils)
local LocalPlayer = Players.LocalPlayer
local DungeonMap = (workspace:WaitForChild("WorldModel")):WaitForChild("DungeonMap")
local EnemyPoint = DungeonMap:WaitForChild("EnemyPoint")
local v1 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerDeadBE")
local v2 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerRebirthBE")
local v3 = CommunicationUtils.TryGetBindableEvent("Stage", "ExitDungeonBE")
local v4 = CommunicationUtils.TryGetBindableEvent("Attack", "EnemyHitBE")
local AbbreviateNumber = AbbNumber.AbbreviateNumber

function LoadOtherPlr(a1) -- Line: 47 -- upvalues: LocalPlayer (val)
    if a1 == LocalPlayer then
        return
    end
    ;(a1:GetAttributeChangedSignal("IntoFight")):Connect(function() -- Line: 52 -- upvalues: a1 (val)
        if not (a1:GetAttribute("IntoFight") == "Dungeon") then
            local Character = a1.Character
            if Character:FindFirstChild("HumanoidRootPart")
                and (Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")
                and ((Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")):FindFirstChild("BillboardGui") then
                local BillboardGui = ((Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")):FindFirstChild("BillboardGui")
                BillboardGui.Enabled = true
            end
        end
    end)
end

for i, j in Players:GetPlayers() do
    LoadOtherPlr(j)
end
Players.PlayerAdded:Connect(function(a1) -- Line: 70
    LoadOtherPlr(a1)
end)
;(LocalPlayer:GetAttributeChangedSignal("IntoFight")):Connect(function() -- Line: 75 -- upvalues: LocalPlayer (val)
    if LocalPlayer:GetAttribute("IntoFight") == "Dungeon" then
        StartDungeon()
    end
end)
local u144 = {}

local function ResetDungeon() -- Line: 83 -- upvalues: u144 (ref)
    u144 = {
        Fighting = false,
        Round = 0,
        PassTime = 0,
        TotalPassTime = 0,
        KillNumber = 0,
        TotalDamage = 0,
        Finished = false,
        ResultList = {},
        EnemyTab = {},
    }
end

ResetDungeon()
RunUtils:RegistPreRender(nil, nil, function(a1) -- Line: 98 -- upvalues: LocalPlayer (val), Players (val), DungeonMap (val)
    local BillboardGui, Character
    if not (LocalPlayer:GetAttribute("IntoFight") == "Dungeon") then
        return
    end
    for i, j in Players:GetPlayers() do
        if j ~= LocalPlayer and j:GetAttribute("IntoFight") == "Dungeon" then
            Character = j.Character
            if Character then
                Character:PivotTo((DungeonMap:WaitForChild("DungeonBin"):GetPivot()))
                if Character:FindFirstChild("HumanoidRootPart")
                    and (Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")
                    and ((Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")):FindFirstChild("BillboardGui") then
                    BillboardGui = ((Character:FindFirstChild("HumanoidRootPart")):FindFirstChild("PlayerHead")):FindFirstChild("BillboardGui")
                    BillboardGui.Enabled = false
                end
            end
        end
    end
end)
RunUtils:RegistPreRender(nil, 1, function() -- Line: 123 -- upvalues: LocalPlayer (val), u144 (ref), DungeonFightGUI (val)
    if LocalPlayer:GetAttribute("IntoFight") ~= "Dungeon" or LocalPlayer:GetAttribute("Dead") then
        return
    end
    local v1 = u144
    v1.PassTime = v1.PassTime + 1
    v1 = u144
    v1.TotalPassTime = v1.TotalPassTime + 1
    if u144.IsReady then
        DungeonFightGUI.SetLastTime("Ready")
        return
    end
    if u144.Finished then
        DungeonFightGUI.SetLastTime("Finished")
        return
    end
    v1 = 80 - u144.PassTime
    DungeonFightGUI.SetLastTime((math.max(v1, 0)))
    if v1 <= 0 then
        ExitDungeon()
    end
end)
RunUtils:RegistPreRender(nil, 6, function(a1) -- Line: 147 -- upvalues: u144 (ref), TableUtils (val)
    if u144 and u144.EnemyTab and not u144.Fighting and 0 < (TableUtils.getTableLegth(u144.EnemyTab)) then
        warn("竟然需要清理！！！")
        CleanAllEnemyData()
    end
end)

function StartDungeon(a1) -- Line: 159
    -- upvalues: LocalPlayer (val), TranslateUtils (val), DungeonFightGUI (val), u144 (ref)
    if LocalPlayer:GetAttribute("IntoFight") ~= "Dungeon" then
        return
    end
    LocalPlayer:SetAttribute("StageID", -1)
    if not a1 then
        a1 = LocalPlayer:GetAttribute("CurrentRound")
    end
    TranslateUtils.TranslateStartVFX(LocalPlayer.Character)
    TranslateUtils.ToDungeon(LocalPlayer.Character)
    DungeonFightGUI.Open()
    DungeonFightGUI.SetRoundText(a1)
    u144.IsReady = true
    u144.Fighting = true
    TranslateUtils.TranslateEndVFX(LocalPlayer.Character)
    task.wait(1)
    u144.IsReady = nil
    StartRound(a1)
end

function ExitDungeon() -- Line: 181
    -- upvalues: LocalPlayer (val), u144 (ref), DungeonFightGUI (val), DungeonData (val), ResetDungeon (val)
    -- upvalues: TranslateUtils (val)
    LocalPlayer:SetAttribute("StageID", nil)
    DungeonFightGUI.ShowDungeonResult({
        TotalTime = u144.TotalPassTime,
        TotalDamage = u144.TotalDamage,
        KillNumber = u144.KillNumber,
        MaxRound = u144.Round,
        ResultList = u144.ResultList,
    })
    DungeonData.ExitDungeon()
    DungeonFightGUI.Close()
    CleanAllEnemyData()
    ResetDungeon()
    TranslateUtils.ToSpawn(LocalPlayer.Character)
end

function StartRound(a1) -- Line: 200
    -- upvalues: LocalPlayer (val), u144 (ref), DungeonData (val), DungeonFightGUI (val)
    if LocalPlayer:GetAttribute("IntoFight") ~= "Dungeon" then
        return
    end
    if u144.Round == a1 and not u144.Finished then
        return
    end
    if not u144.Fighting then
        return
    end
    DungeonData.StartRound(a1)
    u144.Round = a1
    u144.Finished = false
    u144.PassTime = 0
    CreateRoundEnemys(a1)
    DungeonFightGUI.SetRoundText(a1)
end

function FinishRound() -- Line: 219
    -- upvalues: Helper (val), u144 (ref), DungeonData (val), RewardUtils (val), DungeonFightGUI (val), HPCTRL (val)
    -- upvalues: LocalPlayer (val)
    if Helper.Finished then
        return
    end
    u144.Finished = true
    task.delay(3, function() -- Line: 224 -- upvalues: Helper (upval), u144 (upval)
        if not Helper.GetConfig()[u144.Round + 1] then
            ExitDungeon()
            return
        end
        StartRound(u144.Round + 1)
    end)
    local v1, v2 = DungeonData.CompleteRound(u144.Round)
    table.move(v1, 1, #v1, #u144.ResultList + 1, u144.ResultList)
    RewardUtils.CreateOres(u144.DeadCF, v1)
    DungeonFightGUI.ShowCompletedOnce(v1, v2, u144.Round)
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
end

function CheckFinishedOnce() -- Line: 240 -- upvalues: u144 (ref), EnemyCTRL (val)
    if not u144.EnemyTab then
        return nil
    end
    for i, j in u144.EnemyTab do
        if not EnemyCTRL.IsDead(i) then
            return false
        end
    end
    FinishRound()
end

function CreateRoundEnemys(a1) -- Line: 252 -- upvalues: u144 (ref), Helper (val)
    local IsBoss, v1, v2
    CleanAllEnemyData()
    u144.IsEnemy = true
    local v3 = {}
    local v4 = 1
    local v5 = (Helper.GetRoundEnemyTab(a1))
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        IsBoss = j.IsBoss
        v1 = j.Number or 1
        for k = 1, v1 do
            if u144.Fighting then
                v2 = CreateOneEnemy(a1, i, IsBoss, v4, j.Number)
                v4 = v4 + 1
                v3[v2] = true
            end
        end
    end
    u144.EnemyTab = v3
end

function CreateOneEnemy(a1, a2, a3, a4, a5) -- Line: 274 -- upvalues: EnemyPoint (val), EnemyCTRL (val)
    local v1 = #EnemyPoint:GetChildren()
    local v2 = a4
    while v1 < v2 do
        v2 = v2 - v1
    end
    local v3, v4, v5 = EnemyCTRL.CreateOneEnemy({
        StageID = -1,
        EnemyID = a2,
        IsBoss = a3,
        OriCF = (EnemyPoint:FindFirstChild(v2)).CFrame,
        Round = a1,
    })
    return v3, v4, v5
end

function HurtEnemy(a1, a2, a3) -- Line: 293 -- upvalues: u144 (ref), EnemyCTRL (val)
    local v1
    if not u144.EnemyTab[a1] then
        return
    end
    if EnemyCTRL.HurtEnemy(a1, a2, a3) then
        v1 = EnemyCTRL.DeadEnemyData(a1)
        if v1 then
            local v2 = u144
            v2.KillNumber = v2.KillNumber + 1
            u144.DeadCF = v1
            CheckFinishedOnce()
        end
    end
    v1 = u144
    v1.TotalDamage = v1.TotalDamage + a2
end

v4.Event:Connect(HurtEnemy)

function DestroyEnemyData(a1) -- Line: 310 -- upvalues: EnemyCTRL (val)
    EnemyCTRL.DestroyEnemyData(a1)
end

function CleanAllEnemyData() -- Line: 314 -- upvalues: u144 (ref)
    for i, j in u144.EnemyTab do
        DestroyEnemyData(i)
    end
    u144.EnemyTab = {}
end

v1.Event:Connect(function(a1) -- Line: 321 -- upvalues: DungeonFightGUI (val)
    if a1 == "DungeonDead" then
        DungeonFightGUI.CloseDungeonUI()
    end
end)
v2.Event:Connect(function(a1) -- Line: 326
    if a1 == "DungeonDead" then
        ExitDungeon()
    end
end)
v3.Event:Connect(function() -- Line: 331 -- upvalues: HPCTRL (val), LocalPlayer (val)
    ExitDungeon()
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
end)
;(CommunicationUtils.TryGetRemoteEvent("Dungeon", "DungeonRebirthRE")).OnClientEvent:Connect(function() -- Line: 337
    -- upvalues: LocalPlayer (val), TranslateUtils (val), HitVFXUtils (val), HPCTRL (val), DungeonFightGUI (val)
    local Character = LocalPlayer.Character
    TranslateUtils.ToDungeon(Character)
    HitVFXUtils.RebirthVFX("Player", Character)
    LocalPlayer:SetAttribute("Dead", nil)
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
    DungeonFightGUI.OpenDungeonUI()
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.DungeonManager.RewardUtils
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.DungeonManager.RewardUtils
-- Decompile time: 4.45 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.ModelVFXUtils)
require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
require(ReplicatedStorage.Config.Rarity.Helper)
local Helper = require(ReplicatedStorage.Config.Ore.Helper)
local Helper_2 = require(ReplicatedStorage.Config.EnchStone.Helper)
require(ReplicatedStorage.Config.AnyHelper)
require(ReplicatedStorage.Utils.RunUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.SoundPlayer)
local LocalVFXUtils = require(ReplicatedStorage.Utils.LocalVFXUtils)
local UUIDUtils = require(ReplicatedStorage.Utils.UUIDUtils)
local OreDropUtils = require(ReplicatedStorage.Utils.OreDropUtils)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local LocalPlayer = game.Players.LocalPlayer

function v1.CreateOres(a1, a2) -- Line: 24
    -- upvalues: ReplicatedStorage (val), Helper_2 (val), Helper (val), UUIDUtils (val), OreDropUtils (val)
    -- upvalues: LocalVFXUtils (val)
    local ID, Type, v1, v2
    local v3 = nil
    local v4 = nil
    local v5 = a1
    for i, j in a2, v3, v4 do
        ID = j.ID
        Type = j.Type
        v2 = nil
        v1 = nil
        if ID == "Coin" then
            v2 = ReplicatedStorage.Assets.VFX:WaitForChild("CoinBall"):Clone()
            v1 = "Common"
        elseif Type == "EnchStone" then
            v2 = ReplicatedStorage.Assets.EnchStone:WaitForChild(ID):Clone()
            v1 = Helper_2.GetRarity(ID)
        elseif Type == "Ore" then
            v2 = ReplicatedStorage.Assets.Ore:WaitForChild(ID):Clone()
            v1 = Helper.GetRarity(ID)
        end
        local u67 = UUIDUtils.generateAbsoluteID()
        OreDropUtils.CreateOneDrop({
            StageID = -1,
            Type = Type,
            ID = ID,
            Model = v2,
            Rarity = v1,
            OriCF = v5,
            UUID = u67,
        })
        task.delay(1.2, function() -- Line: 51 -- upvalues: OreDropUtils (upval), u67 (val)
            OreDropUtils.FlyToPlayer(u67)
        end)
    end
    LocalVFXUtils.CreateHPBallVFX(v5)
end

return v1
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.PlrManager
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.PlrManager
-- Decompile time: 24.74 ms

game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Debris")
local LocalPlayer = game.Players.LocalPlayer
local SkillSystemNew = ReplicatedStorage.SkillSystemNew
local AnimatorObj = require(ReplicatedStorage.Object.AnimatorObj)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local VFXSuit = require(ReplicatedStorage.Utils.VFXSuit)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
require(ReplicatedStorage.Utils.CameraUtils)
local HitVFXUtils = require(ReplicatedStorage.Utils.HitVFXUtils)
require(ReplicatedStorage.Utils.CalculateUtils)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local TranslateUtils = require(ReplicatedStorage.Utils.TranslateUtils)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
local TrainCTRL = require(ReplicatedStorage.CTRL.TrainCTRL)
local SkillCTRL = require(SkillSystemNew.SkillCTRL)
require(SkillSystemNew.Utils.SoundUtils)
require(SkillSystemNew.Utils.CharUtils)
local BackpackData = require(ReplicatedStorage.LocalData.BackpackData)
local LostOreGUI = require(ReplicatedStorage.GuiUtils.LostOreGUI)
local PlayerInfoGUI = require(ReplicatedStorage.GuiUtils.PlayerInfoGUI)
require(script.Parent.StageManager.StageUtils)
local v1 = CommunicationUtils.TryGetRemoteEvent("Attack", "WhoUsedSkillRE")
CommunicationUtils.TryGetRemoteEvent("Stage", "ClaimedAllOreRE")
local u130 = CommunicationUtils.TryGetRemoteFunction("Stage", "LostAllOreRF")
local u134 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerDeadBE")
local u138 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerRebirthBE")
local v2 = CommunicationUtils.TryGetBindableEvent("Attack", "ATKOnceBE")
local v3 = CommunicationUtils.TryGetBindableEvent("Skill", "UseSkillByIndexBE")
local v4 = CommunicationUtils.TryGetBindableEvent("Attack", "PlrHitBE")
local u154 = CommunicationUtils.TryGetRemoteEvent("Player", "SetPlrDeadRE")
local u155 = {}
repeat
    task.wait()
until workspace:GetAttribute("UIInitDone")
local u163 = nil
local u164 = nil

function LoadPlayer() -- Line: 65 -- upvalues: u163 (ref), LocalPlayer (val), AnimatorObj (val), u164 (ref)
    local function PlayStateAnim(a1) -- Line: 66 -- upvalues: u163 (upval), LocalPlayer (upval)
        if u163 then
            if not a1 then
                u163:StopAnim()
            else
                local Attribute = LocalPlayer:GetAttribute("WeaponType")
                if Attribute then
                    u163:PlayAnim(a1 .. (("_%*"):format((Attribute:sub(1, 1)))))
                    return
                end
            end
        end
    end

    local function LoadCharAnim(a1) -- Line: 79
        -- upvalues: u163 (upval), AnimatorObj (upval), u164 (upval), LocalPlayer (upval)
        local Animator = (a1:WaitForChild("Humanoid")):WaitForChild("Animator")
        u163 = AnimatorObj.new("Player_State", Animator)
        u164 = AnimatorObj.new("Player_Action", Animator)
        if LocalPlayer:GetAttribute("WeaponType") then
            local Attribute = LocalPlayer:GetAttribute("CharState")
            if u163 then
                if not Attribute then
                    u163:StopAnim()
                else
                    local Attribute_2 = LocalPlayer:GetAttribute("WeaponType")
                    if Attribute_2 then
                        u163:PlayAnim(Attribute .. (("_%*"):format((Attribute_2:sub(1, 1)))))
                        return
                    end
                end
            end
        end
    end

    LoadCharAnim(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
    LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 90 -- upvalues: LoadCharAnim (val)
        LoadCharAnim(a1)
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("WeaponType")):Connect(function() -- Line: 93 -- upvalues: LocalPlayer (upval), u163 (upval)
        local Attribute = LocalPlayer:GetAttribute("CharState")
        if u163 then
            if not Attribute then
                u163:StopAnim()
            else
                local Attribute_2 = LocalPlayer:GetAttribute("WeaponType")
                if Attribute_2 then
                    u163:PlayAnim(Attribute .. (("_%*"):format((Attribute_2:sub(1, 1)))))
                    return
                end
            end
        end
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("CharState")):Connect(function() -- Line: 98 -- upvalues: LocalPlayer (upval), u163 (upval)
        local Attribute = LocalPlayer:GetAttribute("CharState")
        if u163 then
            if not Attribute then
                u163:StopAnim()
            else
                local Attribute_2 = LocalPlayer:GetAttribute("WeaponType")
                if Attribute_2 then
                    u163:PlayAnim(Attribute .. (("_%*"):format((Attribute_2:sub(1, 1)))))
                    return
                end
            end
        end
    end)
end

function DestroyAnyPlayer(a1) -- Line: 104 -- upvalues: u155 (val) -- types: a1: userdata
    u155[a1] = nil
end

LoadPlayer()
RunUtils:RegistPreRender(nil, nil, function(a1) -- Line: 111 -- upvalues: LocalPlayer (val)
    if LocalPlayer:GetAttribute("Dead") or LocalPlayer:GetAttribute("StopCharAnim") then
        LocalPlayer:SetAttribute("CharState", nil)
        return
    end
    local Character = LocalPlayer.Character
    if not Character then
        return
    end
    local Humanoid = Character:WaitForChild("Humanoid")
    local PrimaryPart = Character.PrimaryPart
    if not PrimaryPart then
        return
    end
    LocalPlayer:GetAttribute("CharState")
    local v1 = if 0.1 <= Humanoid.MoveDirection.Magnitude then "Walk" else if not (1 <= PrimaryPart.AssemblyLinearVelocity.Magnitude) then "Idle" else "Walk"
    if LocalPlayer:GetAttribute("CharState") ~= v1 then
        LocalPlayer:SetAttribute("CharState", v1)
    end
end)
UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 139 -- upvalues: LocalPlayer (val), SkillCTRL (val), u164 (ref)
    if a2 or LocalPlayer:GetAttribute("StopAllAction") then
        return
    end
    if a1.UserInputType == Enum.UserInputType.MouseButton1
        or a1.UserInputType == Enum.UserInputType.Touch
        or a1.KeyCode == Enum.KeyCode.ButtonR2 then
        SkillCTRL.ATK(LocalPlayer, {AnimObj = u164})
    end
end)
v2.Event:Connect(function() -- Line: 156 -- upvalues: LocalPlayer (val), SkillCTRL (val), u164 (ref)
    if LocalPlayer:GetAttribute("StopAllAction") then
        return
    end
    SkillCTRL.ATK(LocalPlayer, {AnimObj = u164})
end)

local function TryUseSkill(a1) -- Line: 165
    -- upvalues: LocalPlayer (val), BackpackData (val), SkillCTRL (val), u164 (ref)
    if LocalPlayer:GetAttribute("StopAllAction") then
        return
    end
    local v1 = BackpackData.GetWeaponSkillIDByIndex(a1)
    if v1 then
        local UseSkill = SkillCTRL.UseSkill
    end
end

UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 180 -- upvalues: TryUseSkill (val)
    if a2 then
        return
    end
    if a1.KeyCode == Enum.KeyCode.Q or a1.KeyCode == Enum.KeyCode.ButtonL1 then
        TryUseSkill(1)
    end
    if a1.KeyCode == Enum.KeyCode.E or a1.KeyCode == Enum.KeyCode.ButtonR1 then
        TryUseSkill(2)
    end
end)
v3.Event:Connect(function(a1) -- Line: 193 -- upvalues: TryUseSkill (val)
    TryUseSkill(a1)
end)
v1.OnClientEvent:Connect(function(a1, a2) -- Line: 197 -- upvalues: LocalPlayer (val), SkillCTRL (val)
    if a1 == LocalPlayer or workspace:GetAttribute("HideOtherSkill") then
        return
    end
    local Character = a1.Character
    local Character_2 = LocalPlayer.Character
    if Character and Character_2 then
        if not Character:FindFirstChild("HumanoidRootPart")
            or 200 <= (Character:GetPivot().Position - Character_2:GetPivot().Position).Magnitude
            or not workspace:GetAttribute("UIInitDone") then
            return
        end
        SkillCTRL.AnySkill(a1, a2, {})
        return
    end
end)
HPCTRL.RegistPlayerHP(LocalPlayer, 100)
HPCTRL.ListenHPChanged(LocalPlayer, PlayerInfoGUI.UpdateHPBar)
v4.Event:Connect(function(a1, a2) -- Line: 227
    PlayerHurt(a1, a2)
end)

function PlayerHurt(a1, a2) -- Line: 230 -- upvalues: LocalPlayer (val), HitVFXUtils (val), HPCTRL (val)
    if LocalPlayer:GetAttribute("Dead") then
        return
    end
    HitVFXUtils.GetHurtVFX("Player", LocalPlayer.Character, {Damage = a1})
    if HPCTRL.DamageOnce(LocalPlayer, a1) then
        PlayerDead()
    end
end

local u229 = ""
local u230 = {}

function PlayerDead() -- Line: 244
    -- upvalues: LocalPlayer (val), u229 (ref), u230 (ref), HitVFXUtils (val), u130 (val), u134 (val), u154 (val)
    if LocalPlayer:GetAttribute("Dead") then
        return
    end
    u229 = ""
    u230 = {}
    LocalPlayer:SetAttribute("Dead", true)
    local Character = LocalPlayer.Character
    local Attribute = LocalPlayer:GetAttribute("IntoFight")
    if Attribute == "Dungeon" then
        task.spawn(function() -- Line: 256 -- upvalues: HitVFXUtils (upval), Character (val)
            HitVFXUtils.DeadVFX("Player", Character, {Dungeon = true})
        end)
        u229 = "DungeonDead"
    elseif Attribute == "Stage" then
        task.spawn(function() -- Line: 261 -- upvalues: HitVFXUtils (upval), Character (val)
            HitVFXUtils.DeadVFX("Player", Character, {})
        end)
        u229 = "StageDead"
        task.delay(3, function() -- Line: 265 -- upvalues: u229 (upval)
            PlayerRebirth(u229)
        end)
        u230.LostOreTab = u130:InvokeServer()
    elseif Attribute == "WorldBoss" then
        task.spawn(function() -- Line: 270 -- upvalues: HitVFXUtils (upval), Character (val)
            HitVFXUtils.DeadVFX("Player", Character, {})
        end)
        u229 = "WorldBossDead"
        task.delay(3, function() -- Line: 275 -- upvalues: u229 (upval)
            PlayerRebirth(u229)
        end)
    end
    u134:Fire(u229)
    u154:FireServer(true)
end

CommunicationUtils.TryGetBindableEvent("Dungeon", "DungeonGiveUpBE").Event:Connect(function() -- Line: 284
    PlayerRebirth("DungeonDead")
end)

function PlayerRebirth() -- Line: 288
    -- upvalues: LocalPlayer (val), u138 (val), u229 (ref), u154 (val), HitVFXUtils (val), HPCTRL (val), u230 (ref)
    -- upvalues: TableUtils (val), LostOreGUI (val), TranslateUtils (val)
    local Character = LocalPlayer.Character
    if not Character then
        return
    end
    u138:Fire(u229)
    u154:FireServer(false)
    HitVFXUtils.RebirthVFX("Player", Character)
    LocalPlayer:SetAttribute("Dead", nil)
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
    if u229 ~= "StageDead" then
        if u229 == "WorldBossDead" then
            TranslateUtils.ToWorldBoss(Character)
            return
        end
        TranslateUtils.ToSpawn(Character)
        return
    end
    local LostOreTab = u230.LostOreTab
    if LostOreTab and TableUtils.getTableLegth(LostOreTab) ~= 0 then
        LostOreGUI.OpenLost(LostOreTab)
    end
    TranslateUtils.ToSpawn(Character)
end

local u252 = Trove.new()
local EnemyFolder = workspace:WaitForChild("EnemyFolder")
;(LocalPlayer:GetAttributeChangedSignal("IntoFight")):Connect(function() -- Line: 323
    -- upvalues: LocalPlayer (val), u252 (val), RunUtils (val), EnemyFolder (val), SkillCTRL (val), u164 (ref)
    -- upvalues: TrainCTRL (val)
    local Attribute = LocalPlayer:GetAttribute("IntoFight")
    if Attribute ~= "Stage" then
        return
    end
    u252:Clean()
    if Attribute then
        u252:Add((RunUtils:RegistPreRender(nil, 0.1, function() -- Line: 330
            -- upvalues: EnemyFolder (upval), LocalPlayer (upval), SkillCTRL (upval), u164 (upval), TrainCTRL (upval)
            if not EnemyFolder then
                return
            end
            local Character = LocalPlayer.Character
            if not Character then
                return
            end
            local Pivot = Character:GetPivot()
            local v1 = false
            for i, j in EnemyFolder:GetChildren() do
                if not j:IsA("Model") then
                    return
                end
                if (j:GetPivot().Position - Pivot.Position).Magnitude <= 20 then
                    v1 = true
                    break
                end
            end
            if v1 then
                SkillCTRL.ATK(LocalPlayer, {AnimObj = u164})
                TrainCTRL.TrainOnce()
            end
        end)))
    end
end)
local v5 = CommunicationUtils.TryGetRemoteFunction("WorldBoss", "TryGetHPBallRF")

function v5.OnClientInvoke(a1) -- Line: 361
    -- upvalues: HPCTRL (val), LocalPlayer (val), VFXSuit (val), ReplicatedStorage (val), SoundPlayer (val)
    local v1 = HPCTRL.GetCurrentHP(LocalPlayer)
    if HPCTRL.GetMaxHP(LocalPlayer) <= v1 then
        print("满血不需要")
        return false
    end
    HPCTRL.SetCurrentHP(LocalPlayer, v1 + a1)
    local Character = LocalPlayer.Character
    if Character then
        VFXSuit.EmitByPart((VFXSuit.CreateCharVFX(Character, ReplicatedStorage.Assets.VFX:WaitForChild("RecoverVFX"), 2, "RootAttachment")))
        SoundPlayer.PlaySoundCopy("HealHP")
    end
    return true
end
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.SomeVFXManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.SomeVFXManager
-- Decompile time: 2.78 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local CoolDown = require(ReplicatedStorage.Object.CoolDown)
local level = (LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("level", 999)
local rebirth = (LocalPlayer:WaitForChild("Eco", 999)):WaitForChild("rebirth", 999)
local Value = level.Value
local Value_2 = rebirth.Value
local u45 = CoolDown.new(2)
local u46 = 1
level.Changed:Connect(function(a1) -- Line: 17
    -- upvalues: Value (ref), VFXUtils (val), LocalPlayer (val), ReplicatedStorage (val), u46 (ref), u45 (val)
    -- upvalues: SoundPlayer (val)
    if Value < a1 then
        VFXUtils.EmitByPart((VFXUtils.CreateCharVFX(LocalPlayer.Character, ReplicatedStorage.Assets.VFX:WaitForChild("LevelUpVFX"), 2, "RootAttachment")))
        u46 = math.min(u46 + 0.1, 1.4)
        u45:StartCD(function() -- Line: 26 -- upvalues: u46 (upval)
            u46 = 1
        end)
        SoundPlayer.PlaySoundCopy("LevelUp", u46)
    end
    Value = a1
end)
rebirth.Changed:Connect(function(a1) -- Line: 34 -- upvalues: Value_2 (ref), VFXUtils (val), LocalPlayer (val), ReplicatedStorage (val)
    if Value_2 < a1 then
        VFXUtils.EmitByPart((VFXUtils.CreateCharVFX(LocalPlayer.Character, ReplicatedStorage.Assets.VFX:WaitForChild("RebirthVFX"), 2, "RootAttachment")))
    end
    Value_2 = a1
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.StageManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.StageManager
-- Decompile time: 3.48 ms

local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.UUIDUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
require(ReplicatedStorage.Utils.HitVFXUtils)
require(ReplicatedStorage.Utils.CalculateUtils)
require(ReplicatedStorage.Config.Stage.Helper)
require(ReplicatedStorage.Config.Enemy.Helper)
require(ReplicatedStorage.Tool.BehaviorTree_Creater)
require(ReplicatedStorage.Object.AnimatorObj)
local StageUtils = require(script.StageUtils)
local TopGUI = require(ReplicatedStorage.GuiUtils.TopGUI)
local v1 = CommunicationUtils.TryGetBindableEvent("Stage", "ExitFightBE")
local v2 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerDeadBE")
local v3 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerRebirthBE")
local v4 = CommunicationUtils.TryGetBindableEvent("Attack", "EnemyHitBE")
;(workspace:WaitForChild("WorldModel")):WaitForChild("StageMap")
;(LocalPlayer:GetAttributeChangedSignal("StageID")):Connect(function() -- Line: 67 -- upvalues: LocalPlayer (val), StageUtils (val)
    local Attribute = LocalPlayer:GetAttribute("StageID")
    if not Attribute then
        return
    end
    if tonumber(Attribute) and Attribute <= 0 then
        return
    end
    if LocalPlayer:GetAttribute("Dead") then
        return
    end
    if LocalPlayer:GetAttribute("IntoFight") ~= "Stage" then
        StageUtils.StartFight(Attribute)
        return
    end
    StageUtils.StartStage(Attribute)
end)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
v1.Event:Connect(function(a1, a2) -- Line: 82 -- upvalues: StageUtils (val), HPCTRL (val), LocalPlayer (val)
    StageUtils.ExitFight(a1, a2)
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
end)
v2.Event:Connect(function(a1) -- Line: 87 -- upvalues: TopGUI (val)
    if a1 == "StageDead" then
        TopGUI.CloseReturnButton()
    end
end)
v3.Event:Connect(function(a1) -- Line: 92 -- upvalues: StageUtils (val)
    if a1 == "StageDead" then
        StageUtils.ExitFight(false)
    end
end)
v4.Event:Connect(StageUtils.HurtEnemy)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.StageManager.OreUtils
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.StageManager.OreUtils
-- Decompile time: 4.05 ms

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Utils.ModelVFXUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local LeftInfoGUI = require(ReplicatedStorage.GuiUtils.LeftInfoGUI)
local RewardShow = require(ReplicatedStorage.GuiUtils.RewardShow)
require(ReplicatedStorage.Config.Rarity.Helper)
require(ReplicatedStorage.Config.Ore.Helper)
require(ReplicatedStorage.Utils.RunUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local SoundPlayer = require(ReplicatedStorage.Utils.SoundPlayer)
local OreDropUtils = require(ReplicatedStorage.Utils.OreDropUtils)
local UpgradeData = require(ReplicatedStorage.LocalData.UpgradeData)
local IndexData = require(ReplicatedStorage.LocalData.IndexData)
local Message = require(ReplicatedStorage.GuiUtils.Message)
local AbbreviateNumber = AbbNumber.AbbreviateNumber
local Ore = ReplicatedStorage.Assets.Ore
local LocalPlayer = game.Players.LocalPlayer
local u70 = CommunicationUtils.TryGetRemoteFunction("Stage", "GetOreRF")
local u74 = CommunicationUtils.TryGetBindableEvent("Stage", "PickupOreBE")
local u78 = CommunicationUtils.TryGetRemoteEvent("Stage", "GetEnhantStoneRE")

function v1.CreateOres(a1, a2, a3) -- Line: 32
    -- upvalues: OreDropUtils (val), RewardShow (val), u78 (val), IndexData (val), LeftInfoGUI (val), UpgradeData (val)
    -- upvalues: Message (val), SoundPlayer (val), u74 (val), u70 (val)
    local v1
    for i, j in a2 do
        if type(j) ~= "table" then
            v1 = not IndexData.IsUnlocked("Ore", j)
            OreDropUtils.CreateOneDrop({
                Type = "Ore",
                Number = 1,
                LightVFX = true,
                ShowBillboard = true,
                PPButton = true,
                ID = j,
                UUID = i,
                StageID = a3,
                OriCF = a1,
                IsNew = v1,
                PPButtonCallback = function() -- Line: 59
                    -- upvalues: LeftInfoGUI (upval), UpgradeData (upval), Message (upval), SoundPlayer (upval)
                    -- upvalues: OreDropUtils (upval), i (val), u74 (upval), u70 (upval)
                    local v1 = LeftInfoGUI.GetOrePack()
                    if UpgradeData.GetMaxNum("OrePack") <= v1 then
                        Message.showMessage("Pack is full.")
                        return
                    end
                    SoundPlayer.playSound("CollectOre")
                    OreDropUtils.FlyToPlayer(i)
                    LeftInfoGUI.UpdateOrePack(v1 + 1)
                    u74:Fire()
                    u70:InvokeServer(i)
                end,
            })
        else
            local ID = j.ID
            local Type = j.Type
            local Number = j.Number
            OreDropUtils.CreateOneDrop({
                Type = Type,
                ID = ID,
                Number = Number,
                UUID = i,
                StageID = a3,
                OriCF = a1,
            })
            task.delay(1.2, function() -- Line: 47
                -- upvalues: OreDropUtils (upval), i (val), RewardShow (upval), Type (val), ID (val), Number (val)
                OreDropUtils.FlyToPlayer(i, function() -- Line: 48 -- upvalues: RewardShow (upval), Type (upval), ID (upval), Number (upval)
                    RewardShow.ShowAny({Type = Type, ID = ID, Number = Number})
                end)
            end)
            u78:FireServer(i)
        end
    end
end

function v1.CleanOres() -- Line: 95 -- upvalues: OreDropUtils (val), LeftInfoGUI (val)
    OreDropUtils.CleanOres()
    LeftInfoGUI.UpdateOrePack(0)
end

function v1.CleanStageOres(a1) -- Line: 100 -- upvalues: OreDropUtils (val)
    OreDropUtils.CleanStageOres(a1)
end

return v1
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.StageManager.StageUtils
-- Took 0.02s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.StageManager.StageUtils
-- Decompile time: 25.86 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local Config = ReplicatedStorage.Config
local Assets = ReplicatedStorage.Assets
local OreUtils = require(script.Parent.OreUtils)
require(ReplicatedStorage.Packages.Trove)
local RunUtils = require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.UUIDUtils)
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
require(ReplicatedStorage.Utils.HitVFXUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local CameraUtils = require(ReplicatedStorage.Utils.CameraUtils)
require(ReplicatedStorage.Utils.ModelVFXUtils)
require(ReplicatedStorage.Utils.SoundPlayer)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)
local TranslateUtils = require(ReplicatedStorage.Utils.TranslateUtils)
local LocalVFXUtils = require(ReplicatedStorage.Utils.LocalVFXUtils)
local TopGUI = require(ReplicatedStorage.GuiUtils.TopGUI)
require(ReplicatedStorage.GuiUtils.SpeedLineGUI)
local Helper = require(ReplicatedStorage.Config.Stage.Helper)
require(ReplicatedStorage.Config.Enemy.Helper)
require(ReplicatedStorage.Tool.BehaviorTree_Creater)
require(ReplicatedStorage.Object.AnimatorObj)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
local EnemyCTRL = require(ReplicatedStorage.CTRL.EnemyCTRL)
local CharUtils = require(ReplicatedStorage.SkillSystemNew.Utils.CharUtils)
local VFXUtils = require(ReplicatedStorage.SkillSystemNew.Utils.VFXUtils)
local StageMap = (workspace:WaitForChild("WorldModel")):WaitForChild("StageMap")
local LocalPlayer = game.Players.LocalPlayer
local AbbreviateNumber = AbbNumber.AbbreviateNumber
workspace:WaitForChild("EnemyFolder")
local u131 = CommunicationUtils.TryGetRemoteEvent("Stage", "ClaimedAllOreRE")
local u135 = CommunicationUtils.TryGetRemoteFunction("Stage", "StageFinishedRF")
local u139 = CommunicationUtils.TryGetBindableEvent("Stage", "StageFinishedBE")
CommunicationUtils.TryGetRemoteEvent("Stage", "SetIntoStageRE")
local u144 = {}

function ResetAllStage() -- Line: 50 -- upvalues: u144 (val)
    for i, j in u144 do
        u144[i] = {
            IsOpen = false,
            IsEnemy = false,
            IsWaitRebirth = false,
            IsFinished = false,
            EnemyTab = {},
        }
    end
end

ResetAllStage()
local StringValue = Instance.new("StringValue")
StringValue.Value = ""
StringValue.Changed:Connect(function(a1) -- Line: 68 -- upvalues: u0 (val)
    if a1 then
        u0.UpdateStageCanInto(a1)
        u0.UpdateStageBoards(a1)
    end
end)
local u157 = {}
u157.Prink = Color3.fromRGB(184, 120, 197)
u157.White = Color3.fromRGB(177, 177, 177)
u157.Blue = Color3.fromRGB(91, 149, 197)
u157.Yellow = Color3.fromRGB(197, 171, 128)
u157.Red = Color3.fromRGB(197, 95, 95)

function u0.Init() -- Line: 83
    -- upvalues: LocalPlayer (val), StageMap (val), Helper (val), u144 (val), RunUtils (val), u0 (val)
    -- upvalues: StringValue (val)
    repeat
        task.wait()
    until LocalPlayer.Character
    local Character = LocalPlayer.Character
    ;(Character:WaitForChild("HumanoidRootPart")).Touched:Connect(function(a1) -- Line: 89 -- upvalues: StageMap (upval), LocalPlayer (upval)
        if a1:IsDescendantOf((StageMap:WaitForChild("AreaPart"))) and a1:IsA("BasePart") then
            local Name = a1.Name
            LocalPlayer:SetAttribute("StageID", Name)
        end
    end)
    ;(Character:WaitForChild("HumanoidRootPart")).TouchEnded:Connect(function(a1) -- Line: 97 -- upvalues: StageMap (upval), LocalPlayer (upval)
        if a1:IsDescendantOf((StageMap:WaitForChild("AreaPart"))) and a1:IsA("BasePart") then
            LocalPlayer:SetAttribute("StageID", nil)
        end
    end)
    for i, j in (Helper.GetStageEnemyConfig()) do
        u144[i] = {}
    end
    ResetAllStage()
    RunUtils:RegistHeartbeat(nil, 1, function() -- Line: 111 -- upvalues: u144 (upval), StageMap (upval), u0 (upval)
        local NextTime, NextTime_2, TextLabel, v1, v2
        if not u144 then
            return
        end
        local Attribute = workspace:GetAttribute("ServerTime") or os.time()
        local v3 = nil
        local v4 = nil
        for i, j in u144, v3, v4 do
            v1 = (StageMap:WaitForChild("RebirthTime")):FindFirstChild(i)
            if not j.IsWaitRebirth then
                if v1 then
                    NextTime_2 = ((v1:WaitForChild("Attachment")):WaitForChild("BillboardGui")):WaitForChild("NextTime")
                    if NextTime_2.Visible then
                        NextTime_2.Visible = false
                    end
                end
            elseif j.IsCanInto then
                if j.RebirthTick <= Attribute then
                    j.IsWaitRebirth = false
                    u0.CreateStageEnemys(i)
                end
                if v1 then
                    v2 = j.RebirthTick - Attribute
                    NextTime = ((v1:WaitForChild("Attachment")):WaitForChild("BillboardGui")):WaitForChild("NextTime")
                    if not NextTime.Visible then
                        NextTime.Visible = true
                    end
                    TextLabel = NextTime:WaitForChild("TextLabel")
                    TextLabel.Text = ("Respawning in : %*s"):format((math.round(v2)))
                end
            elseif v1 then
                NextTime_2 = ((v1:WaitForChild("Attachment")):WaitForChild("BillboardGui")):WaitForChild("NextTime")
                if NextTime_2.Visible then
                    NextTime_2.Visible = false
                end
            end
        end
    end)
    StringValue.Value = "Stage_0"
end

function u0.StartFight(a1) -- Line: 154 -- upvalues: LocalPlayer (val), TopGUI (val), u0 (val)
    if LocalPlayer:GetAttribute("IntoFight") then
        return
    end
    LocalPlayer:SetAttribute("IntoFight", "Stage")
    if not a1 then
        a1 = "Stage_1"
    end
    TopGUI.OpenReturnButton()
    u0.StartStage(a1)
end

function u0.ExitFight(a1, a2) -- Line: 162
    -- upvalues: LocalPlayer (val), StringValue (val), u144 (val), u0 (val), u131 (val), OreUtils (val), TopGUI (val)
    -- upvalues: TranslateUtils (val)
    if LocalPlayer:GetAttribute("IntoFight") ~= "Stage" then
        return
    end
    LocalPlayer:SetAttribute("IntoFight", nil)
    StringValue.Value = ""
    for i, j in u144 do
        u0.DestroyStageAllEnemyData(i)
    end
    if a1 then
        u131:FireServer()
    end
    OreUtils.CleanOres()
    ResetAllStage()
    TopGUI.CloseReturnButton()
    if not a2 then
        TranslateUtils.ToSpawn(LocalPlayer.Character)
    end
end

function u0.StartStage(a1) -- Line: 178 -- upvalues: u144 (val), u0 (val)
    if u144[a1].IsOpen then
        return
    end
    local v1 = u144[a1]
    v1.IsOpen = true
    u0.CreateStageEnemys(a1)
end

function u0.FinishStage(a1) -- Line: 184
    -- upvalues: LocalPlayer (val), StringValue (val), u144 (val), u0 (val), TableUtils (val), OreUtils (val)
    -- upvalues: CharUtils (val), CameraUtils (val), VFXUtils (val), ReplicatedStorage (val), LocalVFXUtils (val)
    -- upvalues: HPCTRL (val), u139 (val)
    local Character = LocalPlayer.Character
    if not Character then
        return
    end

    local function CheckMaxFinishedStage() -- Line: 188 -- upvalues: StringValue (upval), a1 (val)
        if StringValue.Value == "" then
            StringValue.Value = a1
            return
        end
        if (tonumber((StringValue.Value:split("_"))[2])) < tonumber((a1:split("_"))[2]) then
            StringValue.Value = a1
        end
    end

    if StringValue.Value == "" or (tonumber((StringValue.Value:split("_"))[2])) < tonumber((a1:split("_"))[2]) then
        StringValue.Value = a1
    end
    local v1 = u144[a1]
    v1.IsFinished = true
    v1 = u144[a1]
    v1.IsEnemy = false
    v1 = u144[a1]
    v1.IsWaitRebirth = true
    v1 = u144[a1]
    v1.RebirthTick = workspace:GetAttribute("ServerTime") + 30
    local DeadCF = u144[a1].DeadCF
    u0.DestroyStageAllEnemyData(a1)
    repeat
        task.wait()
    until u144[a1].FinishedOreTab
    local v2 = TableUtils.DeepCopy(u144[a1].FinishedOreTab)
    local v3 = u144[a1]
    v3.FinishedOreTab = nil
    OreUtils.CreateOres(DeadCF, v2, a1)
    CharUtils.SetWalkSpeedPercent(Character, 1.5, 100, "StageFinished")
    CameraUtils.TWFOV(TweenInfo.new(0.25), 95)
    task.delay(2.5, function() -- Line: 219 -- upvalues: CharUtils (upval), Character (val), CameraUtils (upval)
        CharUtils.RemoveWalkSpeed(Character, "StageFinished")
        CameraUtils.TWFOV(TweenInfo.new(0.5), 70)
    end)
    VFXUtils.CreateCharVFX(Character, ReplicatedStorage.Assets.VFX:WaitForChild("Speed"), 2.5, "RootAttachment")
    LocalVFXUtils.CreateHPBallVFX(DeadCF)
    HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
    u139:Fire()
end

function CheckStageFinishedOnce(a1) -- Line: 232 -- upvalues: u144 (val), EnemyCTRL (val), u0 (val)
    if not u144[a1] or not u144[a1].EnemyTab then
        return nil
    end
    for i, j in u144[a1].EnemyTab do
        if not EnemyCTRL.IsDead(i) then
            return false
        end
    end
    u0.FinishStage(a1)
    return true
end

function u0.CreateStageEnemys(a1, a2) -- Line: 242
    -- upvalues: u144 (val), StageMap (val), u0 (val), Helper (val), u135 (val)
    local v1
    if u144[a1].IsEnemy then
        return
    end
    if not (StageMap:WaitForChild("EnemyPoint")):FindFirstChild(a1) then
        warn(a1, "缺少敌人点位")
        return
    end
    local v2 = u144[a1]
    v2.IsEnemy = true
    u0.DestroyStageAllEnemyData(a1)
    v2 = {}
    for i, j in (Helper.GetEnemyConfig(a1)) do
        v1 = CreateOneEnemy(a1, j, i)
        if v1 then
            v2[v1] = true
        end
    end
    u144[a1].EnemyTab = v2
    task.spawn(function() -- Line: 263 -- upvalues: u135 (upval), a1 (val), u144 (upval)
        local v1 = u135:InvokeServer(a1)
        u144[a1].FinishedOreTab = v1
    end)
end

function CreateOneEnemy(a1, a2, a3) -- Line: 270 -- upvalues: StageMap (val), EnemyCTRL (val)
    local v1, v2, v3 = EnemyCTRL.CreateOneEnemy({
        EnemyID = a2.EnemyID,
        IsBoss = a2.IsBoss,
        StageID = a1,
        OriCF = (((StageMap:WaitForChild("EnemyPoint")):FindFirstChild(a1)):FindFirstChild(a2.PointID)).CFrame,
    })
    return v1, v2, v3
end

function u0.DestroyStageAllEnemyData(a1) -- Line: 289 -- upvalues: u144 (val), EnemyCTRL (val)
    local EnemyTab = u144[a1].EnemyTab
    if not EnemyTab then
        return
    end
    for i, j in EnemyTab do
        EnemyCTRL.DestroyEnemyData(i)
    end
    local v1 = u144[a1]
    v1.EnemyTab = {}
end

function u0.HurtEnemy(a1, a2, a3) -- Line: 298 -- upvalues: u144 (val), EnemyCTRL (val)
    local v1 = nil
    local v2 = nil
    local v3 = nil
    local v4, v5, v6 = a1, a2, a3
    for i, j in u144, v2, v3 do
        if j.EnemyTab then
            for k, n in j.EnemyTab do
                if v4 == k then
                    v1 = i
                    break
                end
            end
        end
    end
    if not v1 then
        return
    end
    if EnemyCTRL.HurtEnemy(v4, v5, v6) then
        v2 = EnemyCTRL.DeadEnemyData(v4)
        if v2 then
            u144[v1].DeadCF = v2
            CheckStageFinishedOnce(v1)
        end
    end
end

function u0.UpdateStageCanInto(a1) -- Line: 320 -- upvalues: u144 (val), OreUtils (val)
    if not a1 or a1 == "" then
        a1 = "Stage_0"
    end
    local v1 = tonumber((a1:split("_"))[2]) or 0
    local v2 = "Stage_" .. v1 + 1
    if u144[v2] then
        local v3 = nil
        local v4 = nil
        for i, j in u144, v3, v4 do
            if i == a1 then
                j.IsCanInto = true
            elseif i ~= v2 then
                j.IsCanInto = nil
                OreUtils.CleanStageOres(i)
            else
                j.IsCanInto = true
            end
        end
    end
end

function u0.UpdateStageBoards(a1) -- Line: 341 -- upvalues: StageMap (val), u157 (val)
    local Boss, Boss_2, Frame, Recommend, Recommend_2, SurfaceGui, SurfaceGui_2, SurfaceGui_3, TextLabel, TextLabel_2, TextLabel_3, v1, v2
    if not a1 or a1 == "" then
        a1 = "Stage_0"
    end
    local v3 = tonumber((a1:split("_"))[2]) or 0
    local v4 = "Stage_" .. v3 + 1
    local v5 = "Stage_" .. v3 + 2
    for i, j in StageMap:WaitForChild("Boards"):GetChildren() do
        if j:IsA("BasePart") and j.Name ~= "Stage_1" and j.Name ~= "WORKING" then
            v2 = j.Name ~= v4
            j.CanCollide = v2
            j:WaitForChild("Back").Enabled = v2
            v1 = ("STAGE %*"):format((tonumber((j.Name:split("_"))[2])))
            if j.Name == v4 then
                j.Color = u157.White
                if j:FindFirstChild("SurfaceGui") then
                    SurfaceGui = j:FindFirstChild("SurfaceGui")
                    SurfaceGui.Enabled = true
                    Recommend = SurfaceGui:WaitForChild("Recommend")
                    Recommend.Visible = true
                    Frame = SurfaceGui:WaitForChild("Frame")
                    Frame:WaitForChild("TextLabel").Text = v1
                    TextLabel = (SurfaceGui:WaitForChild("Frame")):WaitForChild("TextLabel")
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    if SurfaceGui:FindFirstChild("Boss") then
                        Boss = SurfaceGui:FindFirstChild("Boss")
                        Boss.Visible = true
                    end
                end
            elseif j.Name == v5 then
                j.Color = u157.Red
                if j:FindFirstChild("SurfaceGui") then
                    SurfaceGui_2 = j:FindFirstChild("SurfaceGui")
                    SurfaceGui_2.Enabled = true
                    Recommend_2 = SurfaceGui_2:WaitForChild("Recommend")
                    Recommend_2.Visible = false
                    TextLabel_2 = (SurfaceGui_2:WaitForChild("Frame")):WaitForChild("TextLabel")
                    TextLabel_2.Text = "FIGHT"
                    TextLabel_3 = (SurfaceGui_2:WaitForChild("Frame")):WaitForChild("TextLabel")
                    TextLabel_3.TextColor3 = Color3.fromRGB(255, 0, 0)
                    if SurfaceGui_2:FindFirstChild("Boss") then
                        Boss_2 = SurfaceGui_2:FindFirstChild("Boss")
                        Boss_2.Visible = false
                    end
                end
            elseif v2 then
                j.Color = u157.Red
                if j:FindFirstChild("SurfaceGui") then
                    SurfaceGui_3 = j:FindFirstChild("SurfaceGui")
                    SurfaceGui_3.Enabled = false
                end
            end
        end
    end
end

u0.Init()
return u0
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.SuperLootManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.SuperLootManager
-- Decompile time: 8.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
game:GetService("Players")
require(ReplicatedStorage.Utils.RunUtils)
require(ReplicatedStorage.Utils.UUIDUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
require(ReplicatedStorage.Utils.TableUtils)
require(ReplicatedStorage.Utils.HitVFXUtils)
local TimeFormatUntil = require(ReplicatedStorage.Utils.TimeFormatUntil)
local EnemyCTRL = require(ReplicatedStorage.CTRL.EnemyCTRL)
require(ReplicatedStorage.CTRL.HPCTRL)
local OreUtils = require(script.Parent.StageManager.OreUtils)
local Helper = require(ReplicatedStorage.Config.SuperLoot.Helper)
require(ReplicatedStorage.Config.Ore.Helper)
;(workspace:WaitForChild("WorldModel")):WaitForChild("StageMap")
local v1 = CommunicationUtils.TryGetRemoteEvent("SuperLoot", "RefreshSuperLootRE")
local u79 = CommunicationUtils.TryGetRemoteEvent("SuperLoot", "KillSuperLootRE")
local u80 = {}
v1.OnClientEvent:Connect(function(a1, a2, a3, a4, a5) -- Line: 28
    CreateOneSuperLoot(a1, a2, a3, a4, a5)
end)

function CreateOneSuperLoot(a1, a2, a3, a4, a5) -- Line: 32 -- upvalues: u80 (val), EnemyCTRL (val), Helper (val)
    if u80 then
        for i, j in u80 do
            if j.Rarity == a1 then
                DestroyEnemyData(i)
            end
        end
    end
    local v1 = ("Stage_%*"):format(a4)
    local v2, v3, v4 = EnemyCTRL.CreateOneSuperLoot({HP = Helper.GetHP(a1), UUID = a2, OriCF = a5, StageID = v1})
    ;(v4:WaitForChild("HumanoidRootPart")):WaitForChild("SuperLootBGM"):Play()
    u80[v2] = {
        Rarity = a1,
        OreID = a3,
        Model = v4,
        EnemyData = v3,
        StageID = v1,
    }
end

function DestroyEnemyData(a1) -- Line: 62 -- upvalues: EnemyCTRL (val), u80 (val)
    EnemyCTRL.DestroyEnemyData(a1)
    u80[a1] = nil
end

;(CommunicationUtils.TryGetBindableEvent("Attack", "EnemyHitBE")).Event:Connect(function(a1, a2, a3) -- Line: 68 -- upvalues: u80 (val), EnemyCTRL (val), u79 (val), OreUtils (val)
    if not u80[a1] then
        return
    end
    if not a3 then
        a3 = {}
    end
    local Model = u80[a1].Model
    local EnemyData = u80[a1].EnemyData
    if EnemyData and not EnemyData.Dead then
        local v1 = ("%*%%"):format((math.round(1 / EnemyData.BTObj.HP * 100)))
        a3.Damage = v1
        if EnemyCTRL.HurtEnemy(a1, v1, a3) and EnemyCTRL.DeadEnemyData(a1) then
            (Model:WaitForChild("HumanoidRootPart")):WaitForChild("SuperLootBGM"):Stop()
            u79:FireServer(a1)
            local CreateOres = OreUtils.CreateOres
            local Pivot = Model:GetPivot()
            local v2 = {}
            v2[a1] = u80[a1].OreID
            CreateOres(Pivot, v2, u80[a1].StageID)
        end
    end
end)
repeat
    task.wait()
until workspace:GetAttribute("UIInitDone")
local SuperLootFolder = workspace:WaitForChild("SuperLootFolder")

function LoadRarityValue(a1) -- Line: 101 -- upvalues: TimeFormatUntil (val)
    if not a1:IsA("NumberValue") then
        return
    end
    local Name = a1.Name
    a1.Changed:Connect(function(a1) -- Line: 105 -- upvalues: Name (val), TimeFormatUntil (upval)
        if not (workspace:WaitForChild("WorldModel")):FindFirstChild("SuperLoot") then
            return
        end
        local TextLabel = (((((workspace:WaitForChild("WorldModel")):FindFirstChild("SuperLoot")):WaitForChild("SurfaceGui")):WaitForChild("Main"):WaitForChild("Right")):WaitForChild(Name)):WaitForChild("TextLabel")
        TextLabel.Text = ("%* ore in %*"):format(Name, (TimeFormatUntil.MMSS(a1)))
    end)
end

for i, j in SuperLootFolder:GetChildren() do
    LoadRarityValue(j)
end
SuperLootFolder.ChildAdded:Connect(LoadRarityValue)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.TopListManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.TopListManager
-- Decompile time: 6.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local LocalPlayer = (game:GetService("Players")).LocalPlayer
local AbbNumber = require(ReplicatedStorage.Utils.AbbNumber)
local u27 = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetRemoteFunction("TopList", "GetMyBestRF")
local TopList = game.Workspace:WaitForChild("WorldModel"):WaitForChild("TopList")
local u38 = nil

function LoadSurfaceUIList() -- Line: 16 -- upvalues: LocalPlayer (val), u38 (ref), TopList (val)
    LocalPlayer:GetAttribute("WorldID")
    u38 = {
        Forge = {((TopList:WaitForChild("Forge")):WaitForChild("main")):WaitForChild("S")},
        OnlineTime = {((TopList:WaitForChild("OnlineTime")):WaitForChild("main")):WaitForChild("S")},
        Power = {((TopList:WaitForChild("Power")):WaitForChild("main")):WaitForChild("S")},
        Robux = {((TopList:WaitForChild("Robux")):WaitForChild("main")):WaitForChild("S")},
    }
end

LoadSurfaceUIList()
task.spawn(function() -- Line: 38 -- upvalues: u38 (ref), u27 (val), AbbNumber (val)
    local v1, v2
    while true do
        v1 = nil
        v2 = nil
        for i, j in u38, v1, v2 do
            for k, n in j do
                pcall(function() -- Line: 44 -- upvalues: n (val), u27 (upval), i (val), AbbNumber (upval)
                    local main = n:FindFirstChild("main")
                    if not main then
                        return
                    end
                    local S = main:WaitForChild("S")
                    local v1 = u27:InvokeServer(i)
                    local v2 = if i ~= "OnlineTime" then AbbNumber.AbbreviateNumber(v1) else ("%*h"):format((math.floor(v1 / 3600 * 10)) / 10)
                    local Val = ((S:FindFirstChild("Info")):FindFirstChild("Stats")):FindFirstChild("Val")
                    Val.Text = "Your Best: " .. v2
                end)
            end
        end
        task.wait(120)
    end
end)
require(ReplicatedStorage.Config.Weapon.Helper)
task.spawn(function() -- Line: 68 -- upvalues: u38 (ref), TopList (val), ReplicatedStorage (val)
    for i, j in u38 do
        local Rig = ((TopList:WaitForChild("Stage")):WaitForChild(i)):WaitForChild("Rig")
        local Animator = (Rig:WaitForChild("Humanoid")):WaitForChild("Animator")
        local u31 = nil

        local function UpdateTrack() -- Line: 79
            -- upvalues: Rig (val), ReplicatedStorage (upval), u31 (ref), Animator (val)
            local Attribute = Rig:GetAttribute("WeaponType") or "Great"
            local v1 = ReplicatedStorage.Assets.Animation.Player_State:FindFirstChild((("Walk_%*"):format((Attribute:sub(1, 1)))))
            if v1 then
                if u31 then
                    u31:Stop()
                    u31:Destroy()
                end
                u31 = Animator:LoadAnimation(v1)
                u31.Looped = true
                u31:Play()
            end
        end

        ;(Rig:GetAttributeChangedSignal("WeaponType")):Connect(function() -- Line: 95 -- upvalues: UpdateTrack (val)
            UpdateTrack()
        end)
        UpdateTrack()
    end
end)
-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Manager.WorldBossManager
-- Took 0s to decompile.
-- Executor: Real (2.7.4)

-- Script path: StarterPlayer.StarterPlayerScripts.Manager.WorldBossManager
-- Decompile time: 3.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game.Players.LocalPlayer
local TranslateUtils = require(ReplicatedStorage.Utils.TranslateUtils)
local CommunicationUtils = require(ReplicatedStorage.Utils.CommunicationUtils)
local HPCTRL = require(ReplicatedStorage.CTRL.HPCTRL)
local WorldBossGUI = require(ReplicatedStorage.GuiUtils.WorldBossGUI)
local u27 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "IntoWorldBossFight")
local u31 = CommunicationUtils.TryGetRemoteEvent("WorldBoss", "ExitWorldBossFight")
local v1 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerDeadBE")
local v2 = CommunicationUtils.TryGetBindableEvent("Stage", "PlayerRebirthBE")
local v3 = CommunicationUtils.TryGetBindableEvent("Stage", "ExitWorldBossBE")
repeat
    task.wait()
until LocalPlayer.Character
local Character = LocalPlayer.Character

function JoinWorldBossFight(a1) -- Line: 25
    -- upvalues: TranslateUtils (val), Character (val), u27 (val), LocalPlayer (val), WorldBossGUI (val)
    if not workspace:GetAttribute("CurrentWorldBoss") and not a1 then
        return
    end
    TranslateUtils.TranslateStartVFX(Character)
    u27:FireServer()
    LocalPlayer:SetAttribute("IntoFight", "WorldBoss")
    WorldBossGUI.OpenBossFrame()
    TranslateUtils.ToWorldBoss(Character)
    TranslateUtils.TranslateEndVFX(Character)
end

function ExitWorldBossFight(a1) -- Line: 39
    -- upvalues: u31 (val), LocalPlayer (val), WorldBossGUI (val), TranslateUtils (val), HPCTRL (val)
    u31:FireServer()
    LocalPlayer:SetAttribute("IntoFight", nil)
    WorldBossGUI.CloseBossFrame()
    if a1 then
        local Character = LocalPlayer.Character
        TranslateUtils.TranslateStartVFX(Character)
        TranslateUtils.ToSpawn(Character)
        TranslateUtils.TranslateEndVFX(Character)
        HPCTRL.SetCurrentHP(LocalPlayer, HPCTRL.GetMaxHP(LocalPlayer))
    end
end

Character:WaitForChild("HumanoidRootPart").Touched:Connect(function(a1) -- Line: 53
    if a1 == (workspace:WaitForChild("TOUCHED")):FindFirstChild("WorldBoss") then
        JoinWorldBossFight()
        return
    end
    if a1 == (workspace:WaitForChild("TOUCHED")):FindFirstChild("WorldBoss_Back") then
        ExitWorldBossFight(true)
    end
end)
v1.Event:Connect(function(a1) -- Line: 61 -- upvalues: WorldBossGUI (val)
    if a1 ~= "WorldBossDead" then
        return
    end
    print("世界Boss战死了")
    WorldBossGUI.CloseExitButton()
end)
v2.Event:Connect(function(a1) -- Line: 69 -- upvalues: WorldBossGUI (val)
    if a1 ~= "WorldBossDead" then
        return
    end
    WorldBossGUI.OpenExitButton()
end)
WorldBossGUI.SetJoinFightCB(JoinWorldBossFight)
WorldBossGUI.SetExitFightCB(ExitWorldBossFight)
v3.Event:Connect(function(a1) -- Line: 80
    ExitWorldBossFight(a1)
end)
