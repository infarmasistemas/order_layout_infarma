module OrderLayoutInfarma
  class FileContentComposer
    attr_accessor :compose_order, :order_items

    def initialize(compose_order)
      self.compose_order = compose_order
    end

    def get_file_content
      file_content = StringIO.new()
      file_content << "01#{'%-6s' % 1.02}"
      file_content << "#{compose_order.client_cnpj_order}"
      file_content << "#{"%06i" % compose_order.cod_client}"
      file_content << "#{"%09i" % compose_order.num_order}"
      file_content << "#{compose_order.formatted_current_date}"
      file_content << "#{"%02i" % compose_order.current_date.hour}"
      file_content << "#{"%02i" % compose_order.current_date.min}"
      file_content << "#{"%04i" % compose_order.marketing_policy_id}"
      file_content << "#{"%03i" % compose_order.deadline_id.to_i}"
      file_content << "#{compose_order.establishment_cnpj.to_s}"
      file_content.puts
      file_content << "02[#{compose_order.current_user_name}: *#{compose_order.comment}*]" # 40
      file_content.puts

      total = 0
      total_units = 0

      compose_order.order_items.each do |order_item|
        total += 1
        total_units += order_item.quantity

        file_content << "031"
        file_content << "#{"%013i" % order_item.product_id}"
        file_content << "#{"%07i" % order_item.quantity}"
        file_content << "00"
        file_content << "#{"%04i" % order_item.marketing_policy_id}"
        file_content.puts
      end

      file_content << "09"
      file_content << "#{"%04i" % total}"
      file_content << "#{"%08i" % total_units}"
      file_content << "00"

      file_content.string
    end

  end
end