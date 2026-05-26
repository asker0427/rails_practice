class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @squares = @game.squares.order(:position)

    # プレイヤーがいない場合はエントリー画面(setup.html.erb)を表示して処理終了
    if @game.players.count == 0
      render :setup
      return
    end

    @players = @game.players.order(:turn_order)
    @current_player = @players.find_by(turn_order: @game.current_player_order)
    
    # 終了判定：全員がゴールしているか
    @is_game_over = @players.all?(&:is_goal)
  end

  def start
    @game = Game.find(params[:id])

    player_names = params[:player_names].reject(&:blank?)
    if player_names.empty?
      flash[:notice] = "最低1人はプレイヤー名を入力してください"
      return redirect_to game_path(@game)
    end

    @game.update!(max_players: player_names.size, current_player_order:0)

    player_order = (0...@game.max_players).to_a.shuffle
    player_names.each_with_index do |name, i|
      @game.players.create!(
        name: name,
        position: 0,
        is_goal: false,
        turn_order: player_order[i],
        skip_turns: 0
      )
    end

    redirect_to game_path(@game)
  end

  def reset
    @game = Game.find(params[:id])
    @game.players.destroy_all
    redirect_to game_path(@game)
  end

  def roll
    @game = Game.find(params[:id])
    @current_player = @game.players.find_by(turn_order: @game.current_player_order)

    take_turn(@current_player)
    
    advance_turn!

    redirect_to game_path(@game)
  end

  private

  def take_turn(player)
    return false if player.is_goal

    if player.skip_turns.to_i > 0
      player.decrement!(:skip_turns)
      flash[:notice] = "#{player.name}さんはあと#{player.skip_turns}ターンおやすみです。"
      return false
    end

    dice = rand(1..6)
    new_position = player.position + dice
    max_position = @game.squares.maximum(:position)
    new_position = max_position if new_position > max_position

    current_square = @game.squares.find_by(position: new_position)
    message = "#{player.name} のターン！サイコロで '#{dice}'が出ました！#{current_square.position}マス目へ移動。（#{current_square.text}）"

    case current_square.effect
    when "move"
      new_position += current_square.value
      new_position = max_position if new_position > max_position
      new_position = 0 if new_position < 0
      message += " ➝ 効果で #{new_position}マス目になりました。"
    when "skip"
      player.skip_turns = current_square.value
      message += " ➝ 効果で #{player.skip_turns} 回休みになります。"
    when "finish"
      player.is_goal = true
      message += " ➝ ゴールしました！おめでとうございます！"
    end
    player.update!(position: new_position, is_goal: player.is_goal, skip_turns: player.skip_turns)
    flash[:notice] = message
    
    true
  end

  def advance_turn!
    next_order = (@game.current_player_order + 1) % @game.max_players
    @game.update!(
      current_player_order: next_order
    )
  end
end
