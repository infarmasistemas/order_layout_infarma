module OrderLayoutInfarma
  class OrderContentComposer

    attr_accessor :directory_name,
                  :cod_client,
                  :num_order,
                  :client_cnpj_order,
                  :marketing_policy_id,
                  :current_user_name,
                  :comment,
                  :deadline_id,
                  :establishment_cnpj,
                  :current_date,
                  :formatted_current_date,
                  :order_items

    def initialize(directory_name, cod_client, num_order,
                   client_cnpj_order, marketing_policy_id,
                   current_user_name, comment, deadline_id, establishment_cnpj,
                   current_date, order_items)

      self.directory_name = directory_name
      self.cod_client = cod_client
      self.num_order = num_order
      self.client_cnpj_order = client_cnpj_order
      self.marketing_policy_id = marketing_policy_id
      self.current_user_name = current_user_name
      self.comment = comment
      self.deadline_id = deadline_id
      self.establishment_cnpj = establishment_cnpj
      self.current_date = current_date
      self.order_items = order_items
      self.formatted_current_date = current_date.strftime("%Y%m%d")
    end
  end
end