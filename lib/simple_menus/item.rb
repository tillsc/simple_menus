# -*- encoding : utf-8 -*-

module SimpleMenus
  class Item
    attr_reader :id, :i18nkey, :url, :children, :active, :options

    def initialize(id, label_or_i18nkey, url, options = {}, &block)
      @id = id
      if label_or_i18nkey.is_a?(Symbol)
        @i18nkey = label_or_i18nkey
      else
        @label = label_or_i18nkey.to_s
      end
      @url = url
      @options = options
      @children = []
      block.call(self) if block
    end

    def <<(child)
      @children << child
      self
    end

    def item(id, label_or_i18nkey, url, options = {}, &block)
      self << self.class.new(id, label_or_i18nkey, url, options, &block)
    end

    def label
      @label ||
          I18n.t(self.i18nkey, :default => "").presence ||
          self.i18nkey.to_s.split(".").reject { |l| l == 'label' }.last.humanize
    end

    def find(item_or_id)
      return self if self == item_or_id || self.id == item_or_id
      return children.map{|c| c.find(item_or_id)}.compact.first
    end

    def find_path_to(item_or_id)
      return [self] if self == item_or_id || self.id == item_or_id
      children.each do |c|
        sub_path = c.find_path_to(item_or_id)
        return [self] + sub_path if sub_path.is_a?(Array) && !sub_path.empty?
      end
      return nil
    end

    def inspect
      "#<#{self.class.name}:0x#{self.object_id.to_s(16)} @id='#{@id}'>"
    end

  end
end
