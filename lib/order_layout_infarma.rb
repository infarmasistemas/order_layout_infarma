require 'date'
require 'net/ftp'
require_relative 'order_layout_infarma/ftp_contact'
require_relative 'order_layout_infarma/order_content_composer'
require_relative 'order_layout_infarma/file_composer'
require_relative 'order_layout_infarma/file_content_composer'

module OrderLayoutInfarma
  class << self
    def setup_ftp(ftp_port, ftp_url,
                  ftp_user, ftp_password,
                  ftp_passive, ftp_chdir)

      @ftp_contact = OrderLayoutInfarma::FtpContact.new(ftp_port, ftp_url,
                                                        ftp_user, ftp_password,
                                                        ftp_passive, ftp_chdir)
    end

    def setup_order_content(destination_directory_name,
                            cod_client,
                            num_order,
                            client_cnpj_order,
                            marketing_policy_id,
                            current_user_name,
                            comment,
                            deadline_id,
                            establishment_cnpj,
                            current_date,
                            order_items)

      @order_content_composer = OrderLayoutInfarma::OrderContentComposer.new(
          destination_directory_name,
          cod_client,
          num_order,
          client_cnpj_order,
          marketing_policy_id,
          current_user_name,
          comment,
          deadline_id,
          establishment_cnpj,
          current_date,
          order_items)
    end


    def create_order_file_and_send_ftp
      @file_content_composer = OrderLayoutInfarma::FileContentComposer.new(@order_content_composer)

      @file_composer = OrderLayoutInfarma::FileComposer.new(@order_content_composer,
                                                            @file_content_composer.get_file_content)
      @file_composer.write_file

      @ftp_contact.send_ftp(@file_composer.create_file_path)
    end
  end
end


