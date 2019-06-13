module OrderLayoutInfarma
  class FtpContact
    attr_accessor :ftp,
                  :ftp_port,
                  :ftp_url,
                  :ftp_user,
                  :ftp_password,
                  :ftp_passive,
                  :ftp_chdir

    def initialize(ftp_port, ftp_url, ftp_user, ftp_password, ftp_passive, ftp_chdir)
      self.ftp_port = ftp_port
      self.ftp_url = ftp_url
      self.ftp_user = ftp_user
      self.ftp_password = ftp_password
      self.ftp_passive = ftp_passive
      self.ftp_chdir = ftp_chdir
      # new(host = nil, user = nil, passwd = nil, acct = nil)
      # Creates and returns a new FTP object. If a host is given, a connection is made.
      # Additionally, if the user is given, the given user name, password, and (optionally) account are used to log in.
      self.ftp = Net::FTP.new(false)
    end

    def connect
      # connect(host, port = FTP_PORT)
      # Establishes an FTP connection to host, optionally overriding the default port.
      ftp.connect(ftp_url, ftp_port)
    end

    def login
      # login(user = "anonymous", passwd = nil, acct = nil)
      # string “anonymous” and the password is nil, a password of user@host is synthesized.
      # If the acct parameter is not nil, an FTP ACCT command is sent following the successful login.
      # ftp.login(Rails.application.config.ftp_user, Rails.application.config.ftp_password)
      ftp.login(ftp_user, ftp_password)
    end

    def set_passive
      # When true, the connection is in passive mode. Default: false.
      # ftp.passive = Rails.application.config.ftp_passive
      ftp.passive = ftp_passive
    end

    def set_remote_dir
      # Changes the (remote) directory.
      ftp.chdir(ftp_chdir)
    end

    def put(file_path)
      # Sending file
      ftp.put(file_path)
    end

    def close
      ftp.close
    end

    def send_ftp(file_path)
      connect
      login
      set_passive
      set_remote_dir
      put(file_path)
      close
    end
  end
end