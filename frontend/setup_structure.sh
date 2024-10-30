#!/bin/bash

# Crée les dossiers de base
mkdir -p src/assets/avatars
mkdir -p src/components
mkdir -p src/views
mkdir -p src/stores
mkdir -p src/services

# Crée les fichiers principaux
touch public/index.html
touch src/App.vue
touch src/main.js
touch src/components/AvatarCard.vue
touch src/components/AvatarForm.vue
touch src/views/AvatarsView.vue
touch src/stores/avatarsStore.js
touch src/services/storage.js

# Contenu de base pour chaque fichier
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue AI Chat App</title>
</head>
<body>
    <div id="app"></div>
</body>
</html>' > public/index.html

echo '<template>
  <router-view />
</template>

<script setup>
</script>

<style scoped>
/* Styles globaux */
</style>' > src/App.vue

echo 'import { createApp } from "vue";
import { createPinia } from "pinia";
import App from "./App.vue";

const app = createApp(App);
const pinia = createPinia();

app.use(pinia);
app.mount("#app");' > src/main.js

echo '<template>
  <div class="avatar-card">
    <!-- Avatar Card template here -->
  </div>
</template>

<script setup>
import { defineProps } from "vue";
const props = defineProps({
  avatar: {
    type: Object,
    required: true,
  },
});
</script>

<style scoped>
/* Styles pour AvatarCard */
</style>' > src/components/AvatarCard.vue

echo '<template>
  <form @submit.prevent="handleSubmit">
    <!-- Avatar Form template here -->
  </form>
</template>

<script setup>
import { ref } from "vue";
import { useAvatarsStore } from "../stores/avatarsStore";

const avatarsStore = useAvatarsStore();
const name = ref("");
const image = ref("");
const description = ref("");
const type = ref("formel");

function handleSubmit() {
  avatarsStore.addAvatar({
    id: Date.now(),
    name: name.value,
    image: image.value,
    description: description.value,
    type: type.value,
  });
}
</script>

<style scoped>
/* Styles pour AvatarForm */
</style>' > src/components/AvatarForm.vue

echo '<template>
  <div>
    <h1>Liste des Avatars</h1>
    <AvatarForm />
    <div class="avatar-list">
      <AvatarCard v-for="avatar in avatars" :key="avatar.id" :avatar="avatar" />
    </div>
  </div>
</template>

<script setup>
import { useAvatarsStore } from "../stores/avatarsStore";
import AvatarForm from "../components/AvatarForm.vue";
import AvatarCard from "../components/AvatarCard.vue";

const avatarsStore = useAvatarsStore();
const avatars = avatarsStore.avatars;
</script>

<style scoped>
/* Styles pour AvatarsView */
</style>' > src/views/AvatarsView.vue

echo 'import { defineStore } from "pinia";
import { loadAvatars, saveAvatars } from "../services/storage";

export const useAvatarsStore = defineStore("avatarsStore", {
  state: () => ({
    avatars: loadAvatars(),
  }),
  actions: {
    addAvatar(avatar) {
      this.avatars.push(avatar);
      saveAvatars(this.avatars);
    },
    deleteAvatar(id) {
      this.avatars = this.avatars.filter((avatar) => avatar.id !== id);
      saveAvatars(this.avatars);
    },
  },
});' > src/stores/avatarsStore.js

echo 'const AVATARS_KEY = "avatars";

export function loadAvatars() {
  const avatars = localStorage.getItem(AVATARS_KEY);
  return avatars ? JSON.parse(avatars) : [];
}

export function saveAvatars(avatars) {
  localStorage.setItem(AVATARS_KEY, JSON.stringify(avatars));
}' > src/services/storage.js

echo "Structure de fichiers créée avec succès."
