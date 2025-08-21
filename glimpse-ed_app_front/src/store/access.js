import { defineStore } from 'pinia'
import http from '../api/http'

export const useAccessStore = defineStore('access', {
  state: () => ({
    token: null,
    group: null,
    items: [],
    expiresAt: null,
    remainingSec: 0,
    timerId: null,
  }),
  actions: {
    async load(token) {
      this.token = token
      const { data } = await http.get(`/access/${token}`)
      this.group = data.media_group
      this.items = data.items
      this.expiresAt = new Date(data.expires_at)
      this._startTimer()
    },
    _startTimer() {
      const update = () => {
        const now = new Date()
        this.remainingSec = Math.max(0, Math.floor((this.expiresAt - now) / 1000))
        if (this.remainingSec <= 0) {
          clearInterval(this.timerId)
          this.timerId = null
        }
      }
      update()
      this.timerId = setInterval(update, 1000)
    },
    streamUrl(itemId) {
      if (!this.token) return '#'
      return `${http.defaults.baseURL}/stream/${this.token}/${itemId}`
    }
  }
})