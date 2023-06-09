class ConversationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def new
    @persona = Persona.find(params[:persona_id])
  end

  def create
    service = OpenaiService.new
    message = params[:message]
    persona_id = params[:persona_id]
    persona = Persona.find(persona_id)

    # ユーザーからのメッセージを保存
    user_message = Message.create(conversation_id: params[:id], sender: current_user, content: message)

    # ペルソナの特性を設定するシステムメッセージ
    system_message = {
      role: "system",
      content: persona.description
    }

    # ユーザーからのメッセージ
    user_message = {
      role: "user",
      content: message
    }

    # メッセージの配列を作成
    messages = [system_message, user_message]

    # OpenAI APIにリクエストを送信
    response = service.chat(messages)

    # ペルソナからの応答を保存
    Message.create(conversation_id: params[:id], sender: persona, content: response)

    # 応答をクライアントに返す
    render json: { message: response }
  end

  def show
    @conversation = Conversation.find(params[:id])
  end
end
