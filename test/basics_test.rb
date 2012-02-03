#   Copyright 2011 Till Schulte-Coerne
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

$: << File.join(File.dirname(__FILE__), "..")
require 'test/test_helper'

class BasicsTest < Test::Unit::TestCase


  def test_menu_definition
    menu = SimpleMenus::Item.new('root_node', nil, '/') do |root|
      root.item('item1', 'Item 1', '/item1') do |item1|
        item1.item('item1.subitem1', 'Subitem 1', '/item1/subitem1')
      end
      root.item('item2', 'Item 2', '/item2')
    end

    assert_equal "Item 2", menu.find('item2').label
    assert_equal 3, menu.find_path_to('item1.subitem1').count
  end
  
end
