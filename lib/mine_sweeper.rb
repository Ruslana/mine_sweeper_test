require 'yaml'

class MineSweeper
  BOARDS_FILE = 'boards.yml'

  def initialize(kind)
    @kind = kind
    ensure_level_is_correct
  end

  def render(file)
    board = get_board(@kind)
    map = BoardMap.new(board["size"], board["mines"]).to_s
    file.write(map)
  end

  def ensure_level_is_correct
    raise ArgumentError unless %w(empty easy medium hard).include?(@kind)
  end

  def load_boards
    @boards ||= YAML.load(File.read(BOARDS_FILE))
  end

  def get_board(kind)
    load_boards.detect{ |x| x["type"] == kind }
  end
end
