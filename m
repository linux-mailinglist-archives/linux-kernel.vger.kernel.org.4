Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78972CDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjFLSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjFLSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:18:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694F199
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:18:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-974638ed5c5so954195166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686593924; x=1689185924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCegMuLmkgKKIjp12zoMl7g1gHWpAi0hnuD+7lSH5gI=;
        b=W0PwfkbQCb8Bm4+yrRoaS10SzmZ/E6w3dBH2MJZaSU4s+TMcqUP0c70uBKSVBcXvVw
         He3r4YwsoZxqql+2sWns7SdCIoRl1nc1M48/bcRc7/wkcBJMKE/KeVoXJNxgobME/sXH
         AiyawVhAsxumUWDSyAu6Rvn348MnLPNOT59yN521h4YeTLOQYCG1NWOf218FTQuh2Yzx
         TYjYshVzwgiWaJoJ9fMCIw0/B5RgA5fmrdHqLk2pBO6Uo2XwcZU2HvJ6wmUOIXr9P3ku
         ghoZ23Jw/QVlbNDx8L3e6pIg4Ozc88Tf0CVvA9BhijHa9PNhGTP5BQ1J3r+2QQJQZqsl
         fWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593924; x=1689185924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCegMuLmkgKKIjp12zoMl7g1gHWpAi0hnuD+7lSH5gI=;
        b=ghrt7K4hQFVzrOuEGdnIPIriipDg2j8skPXwY4sA486cV6Py2AbyCwYR46uI/OVwjJ
         UVlkUcHMK3uou6JYfq0IUtPeLd+Gdn4W2tZ4v3iwd6A0YvqsMkm9nsIUv7YKfK7c+9pw
         Rd0w392/tSZe9tlz0Da7o96iNnFhXdau5pmMoXtnKCDoADjD8gi/wk0kPktiUZB3YO6x
         +oyXDc3MGJzMQ/kVvg0/Lrjo9VCrP441DIfL3W4btgH70jkg8ud3a0kMiLvCvnFarqyJ
         fOl2Cxi72t5hJkAIS/EnhNph5+ine4cybvKDmE8HkA1DNu2+tcsDj9LR+k+qxTGu2ep8
         JO4w==
X-Gm-Message-State: AC+VfDxDWEYKguVWVu+IwDvYqVb+vCKe7QWL9KuZ07MFmxVPzYrenyAa
        3qY3ZkoaYGLqPEUThgosDStPNkr3kGt08I9TNlCMYYq7gID50XXShs/GvQ==
X-Google-Smtp-Source: ACHHUZ5hiuYbW5oJPVtRwr2lj6pp5XmdmPS2jFgK2VzN0wQrX9wyQFh4mRlSLvXmrJ8K+zTu0FDI2hqQCnMq/AjMum4=
X-Received: by 2002:a17:907:25ca:b0:971:55e2:82c3 with SMTP id
 ae10-20020a17090725ca00b0097155e282c3mr7708937ejc.20.1686593924390; Mon, 12
 Jun 2023 11:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com> <20230612093815.133504-2-cerasuolodomenico@gmail.com>
In-Reply-To: <20230612093815.133504-2-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 12 Jun 2023 11:18:07 -0700
Message-ID: <CAJD7tkYYuy8n70tQXAgfi2ag5x2rWA77oxRd7yA+6w+Bbf3vqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 2:38=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
> function, which is called from zpool_shrink. However, with this commit,
> a unified shrink function is added to zswap. The ultimate goal is to
> eliminate the need for zpool_shrink once all zpool implementations have
> dropped their shrink code.
>
> To ensure the functionality of each commit, this change focuses solely
> on adding the mechanism itself. No modifications are made to
> the backends, meaning that functionally, there are no immediate changes.
> The zswap mechanism will only come into effect once the backends have
> removed their shrink code. The subsequent commits will address the
> modifications needed in the backends.
>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Tested-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 92 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9fa86265f6dd..0024ec5ed574 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -154,6 +154,12 @@ struct crypto_acomp_ctx {
>         struct mutex *mutex;
>  };
>
> +/*
> + * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
> + * The only case where lru_lock is not acquired while holding tree.lock =
is
> + * when a zswap_entry is taken off the lru for writeback, in that case i=
t
> + * needs to be verified that it's still valid in the tree.
> + */
>  struct zswap_pool {
>         struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
> @@ -163,6 +169,8 @@ struct zswap_pool {
>         struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +       struct list_head lru;
> +       spinlock_t lru_lock;
>  };
>
>  /*
> @@ -180,10 +188,12 @@ struct zswap_pool {
>   *            be held while changing the refcount.  Since the lock must
>   *            be held, there is no reason to also make refcount atomic.
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
> - *          decompression. For a same value filled page length is 0.
> + *          decompression. For a same value filled page length is 0, and=
 both
> + *          pool and lru are invalid and must be ignored.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
>   * value - value of the same-value filled pages which have same content
> + * lru - handle to the pool's lru used to evict pages.
>   */
>  struct zswap_entry {
>         struct rb_node rbnode;
> @@ -196,6 +206,7 @@ struct zswap_entry {
>                 unsigned long value;
>         };
>         struct obj_cgroup *objcg;
> +       struct list_head lru;
>  };
>
>  struct zswap_header {
> @@ -368,6 +379,12 @@ static void zswap_free_entry(struct zswap_entry *ent=
ry)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> +               /* zpool_evictable will be removed once all 3 backends ha=
ve migrated */
> +               if (!zpool_evictable(entry->pool->zpool)) {
> +                       spin_lock(&entry->pool->lru_lock);
> +                       list_del(&entry->lru);
> +                       spin_unlock(&entry->pool->lru_lock);
> +               }
>                 zpool_free(entry->pool->zpool, entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
> @@ -588,14 +605,72 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
>         return NULL;
>  }
>
> +static int zswap_reclaim_entry(struct zswap_pool *pool)
> +{
> +       struct zswap_header *zhdr;
> +       struct zswap_entry *entry;
> +       struct zswap_tree *tree;
> +       pgoff_t swpoffset;
> +       int ret;
> +
> +       /* Get an entry off the LRU */
> +       spin_lock(&pool->lru_lock);
> +       if (list_empty(&pool->lru)) {
> +               spin_unlock(&pool->lru_lock);
> +               return -EINVAL;
> +       }
> +       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> +       list_del_init(&entry->lru);
> +       zhdr =3D zpool_map_handle(pool->zpool, entry->handle, ZPOOL_MM_RO=
);
> +       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> +       zpool_unmap_handle(pool->zpool, entry->handle);
> +       /*
> +        * Once the lru lock is dropped, the entry might get freed. The
> +        * swpoffset is copied to the stack, and entry isn't deref'd agai=
n
> +        * until the entry is verified to still be alive in the tree.
> +        */
> +       swpoffset =3D swp_offset(zhdr->swpentry);
> +       spin_unlock(&pool->lru_lock);
> +
> +       /* Check for invalidate() race */
> +       spin_lock(&tree->lock);
> +       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> +               ret =3D -EAGAIN;
> +               goto unlock;
> +       }
> +       /* Hold a reference to prevent a free during writeback */
> +       zswap_entry_get(entry);
> +       spin_unlock(&tree->lock);
> +
> +       ret =3D zswap_writeback_entry(pool->zpool, entry->handle);
> +
> +       spin_lock(&tree->lock);
> +       if (ret) {
> +               /* Writeback failed, put entry back on LRU */
> +               spin_lock(&pool->lru_lock);
> +               list_move(&entry->lru, &pool->lru);
> +               spin_unlock(&pool->lru_lock);
> +       }
> +
> +       /* Drop local reference */
> +       zswap_entry_put(tree, entry);
> +unlock:
> +       spin_unlock(&tree->lock);
> +       return ret ? -EAGAIN : 0;
> +}
> +
>  static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
>         int ret, failures =3D 0;
>
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
>         do {
> -               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (zpool_evictable(pool->zpool))
> +                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               else
> +                       ret =3D zswap_reclaim_entry(pool);
>                 if (ret) {
>                         zswap_reject_reclaim_fail++;
>                         if (ret !=3D -EAGAIN)
> @@ -659,6 +734,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> +       INIT_LIST_HEAD(&pool->lru);
> +       spin_lock_init(&pool->lru_lock);
>         INIT_WORK(&pool->shrink_work, shrink_worker);
>
>         zswap_pool_debug("created", pool);
> @@ -1274,7 +1351,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         }
>
>         /* store */
> -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> +       hlen =3D sizeof(zhdr);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(entry->pool->zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> @@ -1317,6 +1394,12 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>                         zswap_entry_put(tree, dupentry);
>                 }
>         } while (ret =3D=3D -EEXIST);
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +               spin_lock(&entry->pool->lru_lock);
> +               list_add(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lru_lock);
> +       }
>         spin_unlock(&tree->lock);
>
>         /* update stats */
> @@ -1398,8 +1481,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         /* decompress */
>         dlen =3D PAGE_SIZE;
>         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL=
_MM_RO);
> -       if (zpool_evictable(entry->pool->zpool))
> -               src +=3D sizeof(struct zswap_header);
> +       src +=3D sizeof(struct zswap_header);
>
>         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
>                 memcpy(tmp, src, entry->length);
> @@ -1432,6 +1514,11 @@ static int zswap_frontswap_load(unsigned type, pgo=
ff_t offset,
>         if (!ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>                 *exclusive =3D true;
> +       } else if (entry->length && !zpool_evictable(entry->pool->zpool))=
 {
> +               /* zpool_evictable will be removed once all 3 backends ha=
ve migrated */
> +               spin_lock(&entry->pool->lru_lock);
> +               list_move(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lru_lock);
>         }
>         spin_unlock(&tree->lock);
>
> --
> 2.34.1
>
