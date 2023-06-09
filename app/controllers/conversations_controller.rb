class ConversationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def new
    @persona = Persona.find(params[:persona_id])
  end

  def create
    service = OpenaiService.new
    message = params[:message]
    conversation_id = params[:conversation_id]  # conversation_idを受け取るようにします。
    persona = Persona.find(params[:persona_id])

    # ユーザーからのメッセージを保存
    user_message = Message.create(conversation_id: conversation_id, sender: current_user, content: message)  # conversation_idを使用します。

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
    Message.create(conversation_id: conversation_id, sender: persona, content: response)  # conversation_idを使用します。

    # 応答をクライアントに返す
    render json: { message: response }
  end

  def show
    @conversation = Conversation.find(params[:id])
  end
end
