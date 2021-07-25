local Player = Object:extend()

function Player:Debug()
    print(self.tester)
end

function Player:Test(input)
    self.tester = input
    print('Set to ' .. input)
end

return Player