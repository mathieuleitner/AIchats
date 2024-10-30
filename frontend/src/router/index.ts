// import { createRouter, createWebHistory } from 'vue-router'
// import AvatarsView from '@/views/AvatarsView.vue'
// import ChatView from '@/views/ChatView.vue'

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
//   routes: [
//     {
//       path: '/',
//       name: 'home',
//       component: AvatarsView,
//     },
//     {
//       path: '/chat/:id',
//       name: 'Chat',
//       component: ChatView,
//       props: true, // Passer les paramètres comme des props
//     },
//   ],
// })

// export default router


import { createRouter, createWebHistory } from 'vue-router'
import AvatarsView from '@/views/AvatarsView.vue'
import ChatView from '@/views/ChatView.vue'
import MainView from '@/views/MainView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: MainView,
    },
    {
      path: '/chat/:id',
      name: 'Chat',
      component: ChatView,
      props: true, // Passer les paramètres comme des props
    },
  ],
})

export default router
