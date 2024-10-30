import type { Avatar } from '../stores/avatarsStore';

const AVATARS_KEY = 'avatars';

export function loadAvatars(): Avatar[] {
  const avatars = localStorage.getItem(AVATARS_KEY);
  return avatars ? JSON.parse(avatars) : [];
}

export function saveAvatars(avatars: Avatar[]) {
  localStorage.setItem(AVATARS_KEY, JSON.stringify(avatars));
}
