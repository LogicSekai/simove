<script setup lang="ts">
const config = useAppConfig()

const animeList = ref({
    isLoading: true,
    data: <any>[]
})

const fetchList = async () => {
    animeList.value.isLoading = true
    try {
        const res = <any>await $fetch(config.uri + '/anime/list') // Ganti dengan API kamu
        animeList.value.data = res.data
        console.log(res.data);
    } catch (error) {
        console.error('Fetch failed:', error)
    } finally {
        animeList.value.isLoading = false
    }
}

onMounted(() => {
    fetchList()
})
</script>

<template>
    <div v-if="animeList.data.filterList" class="container mx-auto max-w-screen-2xl mb-4 mt-4 px-4 !px-0 min-height-[85vh]">
        <div class="text-card-foreground flex flex-col border shadow-sm p-2 my-2 gap-2 rounded-none mb-2 bg-background">
            <div class="col-span-1 sm:col-span-1 md:col-span-2 xl:col-span-5 flex justify-center items-center gap-4 flex-wrap">
                <a v-for="item in animeList.data.filterList" :key="item" :href="item.index">
                    <button class="justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive shadow-xs hover:bg-primary/90 h-8 rounded-md px-3 has-[&gt;svg]:px-2.5 cursor-pointer opacity-100 flex items-center gap-1 text-accent-foreground hover:text-white sm:bg-background bg-primary border-2 border-gray-100">
                        <span>{{ item.name }}</span>
                    </button>
                </a>
            </div>
        </div>

        <template v-if="animeList.data.dataList">
            <div v-for="items in animeList.data.dataList" :key="items" class="mt-4 gap-2 rounded-md mt-2 mb-8">
                <div class="bg-card text-card-foreground flex flex-col gap-6 border shadow-sm py-0 px-4 rounded-md rounded-b-none md-4 mb-1">
                    <div class="@container/card-header auto-rows-min grid-rows-[auto_auto] gap-1.5 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6 px-0 flex justify-between items-center">
                        <div class="leading-none font-semibold py-2">{{ items.name }}</div>
                        <a :name="items.index"></a>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-2 gap-2">
                    <div v-for="item in items.list" :key="item" class="bg-card text-card-foreground flex flex-col border shadow-sm p-1 gap-2 rounded-md hover:bg-primary hover:text-primary-foreground group">
                        <div class="p-0 px-2 flex items-center justify-between">
                            <NuxtLink class="text-sm undefined hover:text-primary-foreground flex flex-col" :to="item.link">
                                <p>{{ item.title }} <span v-if="item.ongoing" class="text-[10px] text-green-600">On-going</span></p>
                            </NuxtLink>
                        </div>
                    </div>
                </div>
            </div>
        </template>
    </div>
</template>

<style>
html {
    scroll-behavior: smooth;
}
</style>