class User::WalletController < UserController
  before_action :set_wallet, only: %i[show cash_in destroy]

  def show; end

  def new
    @wallet = Wallet.new
  end

  def new_cash_in
    @wallet = current_user.wallet # Ensure @wallet is set here
  end

  def create
    if current_user.wallet
      redirect_to user_wallet_path(current_user.wallet), alert: 'You already have a wallet'
    else
      @wallet = Wallet.new(wallet_params.merge(user: current_user))
      if @wallet.save
        redirect_to user_wallet_path(@wallet), notice: 'Wallet created successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def cash_in
    new_balance = @wallet.balance.to_f + cash_in_params[:amount].to_f
    if @wallet.update(balance: new_balance)
      redirect_to user_wallet_path(@wallet), notice: 'Funds added successfully'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @wallet.destroy
      redirect_to user_wallet_path, notice: 'Wallet deleted successfully'
    else
      redirect_to user_wallet_path(@wallet), alert: 'Failed to delete wallet'
    end
  end

  private

  def set_wallet
    @wallet = current_user.wallet || Wallet.create(user: current_user, balance: 0.0)
  end

  def wallet_params
    params.require(:wallet).permit(:balance)
  end

  def cash_in_params
    params.require(:wallet).permit(:amount)
  end
end
