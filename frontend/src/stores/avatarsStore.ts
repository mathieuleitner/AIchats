import { defineStore } from 'pinia';

export interface Avatar {
  id: number;
  name: string;
  image: string;
  description: string;
  type: string;
}

export interface Message {
  id: number;
  sender: 'user' | 'avatar';
  text: string;
}

const AVATARS_KEY = 'avatars';
const CONVERSATIONS_KEY = 'conversations';

export const useAvatarsStore = defineStore('avatarsStore', {
  state: () => ({
    avatars: loadAvatars(), // Load avatars from LocalStorage on initialization
    conversations: loadConversations(), // Load conversations from LocalStorage on initialization
  }),
  
  actions: {
    // Add a new avatar and save it to LocalStorage
    addAvatar(avatar: Avatar) {
      this.avatars.push(avatar);
      saveAvatars(this.avatars);
    },

    // Add a new message to the avatar's conversation and save to LocalStorage
    addMessage(avatarId: number, message: Omit<Message, 'id'>) {
      const newMessage = { ...message, id: Date.now() };
      if (!this.conversations[avatarId]) {
        this.conversations[avatarId] = [];
      }
      this.conversations[avatarId].push(newMessage);
      saveConversations(this.conversations);
    },

    // Get messages for a specific avatar
    getMessagesForAvatar(avatarId: number): Message[] {
      return this.conversations[avatarId] || [];
    },
  },
});

// Load avatars from LocalStorage
function loadAvatars(): Avatar[] {
  const avatars = localStorage.getItem(AVATARS_KEY);
  return avatars ? JSON.parse(avatars) : [];
}

// Save avatars to LocalStorage
function saveAvatars(avatars: Avatar[]) {
  console.log('save')
  localStorage.setItem(AVATARS_KEY, JSON.stringify(avatars));
}

// Load conversations from LocalStorage
function loadConversations(): Record<number, Message[]> {
  const conversations = localStorage.getItem(CONVERSATIONS_KEY);
  return conversations ? JSON.parse(conversations) : {};
}

// Save conversations to LocalStorage
function saveConversations(conversations: Record<number, Message[]>) {
  localStorage.setItem(CONVERSATIONS_KEY, JSON.stringify(conversations));
}
