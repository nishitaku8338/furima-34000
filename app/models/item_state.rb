class ItemState < ActiveHash::Base
  self.data = [
    { id: 1,  name: '--'                },
    { id: 2,  name: '新品、未使用'        },
    { id: 3,  name: '未使用に近い'        },
    { id: 4,  name: '目立った汚れ傷はなし'  },
    { id: 5,  name: 'やや傷や汚れあり'     },
    { id: 6,  name: '傷や汚れあり'         },
    { id: 7,  name: 'その他'              }
  ]
  
  include ActiveHash::Associations
  has_many :items
end