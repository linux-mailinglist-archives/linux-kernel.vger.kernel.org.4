Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD2723E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjFFJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjFFJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:47:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66F83
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:47:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256766a1c43so2533889a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686044836; x=1688636836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6/p0egB2xSCdijhlAHkclt0Tm9uUMr3f+Fl7mXVcsA=;
        b=lB2rMXED9OBqcEO2snv8d0n29rczUof+XXCOg5hk1L9TOTHlXH7DdNMFjO3fWKeSxg
         0CeZ0PYfCo2TwHk/+KSJgFko+hUm+osl+vX7mGhdl5kUK52Fl0tLwmTf+6jQvUP9dpPP
         GUW/gDubiuDxe+8RidLduQc32BEgkvExKxqq/ytylB1OkimdLR7jOIooOTLB3AlkEba3
         /5xC4AA6XcCPTTkZsD/TBr76fn8Kp1PeYYOr51Vlu3CJwYz/F/N11QNjWEaOdy77arbK
         PtzGgqy6CUqdj4JkAgZX9h6F3THS2wBVG7/Fv1Q6cB6khzSWLHPR2Yiwr+Pjc6TiT9TP
         C0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044836; x=1688636836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6/p0egB2xSCdijhlAHkclt0Tm9uUMr3f+Fl7mXVcsA=;
        b=QmJ0Wv8eGnECxUBIi6WHdQBaFMTNopfORUUIX6vpRxqAK6tsp45l+kvhsWez2OUckc
         enpKmvyE7xuwAUUwQxUaZWqHpmf3T5YjxcWjmH+cZlaieXgceG9jBh7CiHX3BNNCR5+9
         DxoHruoUAtTg/T+HEEfDhzMYg40b1GduFDYDE0g0x/jr9lUlch3CHamZhJwrNDihPmK/
         AMM+NwjI6PtcnHZTbHmBRZUGUDlaESwUl5wIw4Zvo6r1gPeUn4ZsTi0/n104EWqaBeZF
         6ed8Um0V83w6gQ6tapGK/fwHou81wWxuBoHOurBT6iCn75O/MF+3xqWNEMX2B6nr4aUc
         e3RA==
X-Gm-Message-State: AC+VfDxM2e42T2Qzg/yli3kESSdz/EY9YMB+cpdAf8XA0DWvCcAcc2m3
        9RZAv5MMLZeXZw+p3mdxl/akm7KsDkPAbwfy9tFyiO5uL59jkKCf
X-Google-Smtp-Source: ACHHUZ4LoTFUv7++nwEsmeNtU2ZceL+XCjDXrajuzCG6R/yJHaYiKNfTWObHBjMy4DKLFj7Kkfj3Z88Yc7EHQ1AYgMo=
X-Received: by 2002:a17:90a:384d:b0:255:4635:830c with SMTP id
 l13-20020a17090a384d00b002554635830cmr549058pjf.40.1686044836342; Tue, 06 Jun
 2023 02:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-5-cerasuolodomenico@gmail.com> <CAKEwX=OsG5YNEeAVgOeNfiWewahUrUP6ftvwdMo1eENxBi0qCg@mail.gmail.com>
In-Reply-To: <CAKEwX=OsG5YNEeAVgOeNfiWewahUrUP6ftvwdMo1eENxBi0qCg@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Tue, 6 Jun 2023 11:47:05 +0200
Message-ID: <CA+CLi1iQgmT=Pd0oWoBVwFNt2A86shDrCokcd9HPcskPD3zSQA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm: zswap: remove page reclaim logic from zsmalloc
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 1:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jun 5, 2023 at 1:54=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > With the recent enhancement to zswap enabling direct page writeback, th=
e
> > need for the shrink code in zsmalloc has become obsolete. As a result,
> > this commit removes the page reclaim logic from zsmalloc entirely.
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zsmalloc.c | 291 +-------------------------------------------------
> >  1 file changed, 2 insertions(+), 289 deletions(-)
> >
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 02f7f414aade..c87a60514f21 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -250,13 +250,6 @@ struct zs_pool {
> >         /* Compact classes */
> >         struct shrinker shrinker;
> >
> > -#ifdef CONFIG_ZPOOL
> > -       /* List tracking the zspages in LRU order by most recently adde=
d object */
> > -       struct list_head lru;
> > -       struct zpool *zpool;
> > -       const struct zpool_ops *zpool_ops;
> > -#endif
> > -
> >  #ifdef CONFIG_ZSMALLOC_STAT
> >         struct dentry *stat_dentry;
> >  #endif
> > @@ -279,13 +272,6 @@ struct zspage {
> >         unsigned int freeobj;
> >         struct page *first_page;
> >         struct list_head list; /* fullness list */
> > -
> > -#ifdef CONFIG_ZPOOL
> > -       /* links the zspage to the lru list in the pool */
> > -       struct list_head lru;
> > -       bool under_reclaim;
> > -#endif
> > -
> >         struct zs_pool *pool;
> >         rwlock_t lock;
> >  };
> > @@ -393,14 +379,7 @@ static void *zs_zpool_create(const char *name, gfp=
_t gfp,
> >          * different contexts and its caller must provide a valid
> >          * gfp mask.
> >          */
> > -       struct zs_pool *pool =3D zs_create_pool(name);
> > -
> > -       if (pool) {
> > -               pool->zpool =3D zpool;
> > -               pool->zpool_ops =3D zpool_ops;
> > -       }
> > -
> > -       return pool;
> > +       return zs_create_pool(name);
> >  }
> >
> >  static void zs_zpool_destroy(void *pool)
> > @@ -422,27 +401,6 @@ static void zs_zpool_free(void *pool, unsigned lon=
g handle)
> >         zs_free(pool, handle);
> >  }
> >
> > -static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)=
;
> > -
> > -static int zs_zpool_shrink(void *pool, unsigned int pages,
> > -                       unsigned int *reclaimed)
> > -{
> > -       unsigned int total =3D 0;
> > -       int ret =3D -EINVAL;
> > -
> > -       while (total < pages) {
> > -               ret =3D zs_reclaim_page(pool, 8);
> > -               if (ret < 0)
> > -                       break;
> > -               total++;
> > -       }
> > -
> > -       if (reclaimed)
> > -               *reclaimed =3D total;
> > -
> > -       return ret;
> > -}
> > -
> >  static void *zs_zpool_map(void *pool, unsigned long handle,
> >                         enum zpool_mapmode mm)
> >  {
> > @@ -481,7 +439,7 @@ static struct zpool_driver zs_zpool_driver =3D {
> >         .malloc_support_movable =3D true,
> >         .malloc =3D                 zs_zpool_malloc,
> >         .free =3D                   zs_zpool_free,
> > -       .shrink =3D                 zs_zpool_shrink,
> > +       .shrink =3D                 NULL,
> >         .map =3D                    zs_zpool_map,
> >         .unmap =3D                  zs_zpool_unmap,
> >         .total_size =3D             zs_zpool_total_size,
> > @@ -884,14 +842,6 @@ static inline bool obj_allocated(struct page *page=
, void *obj, unsigned long *ph
> >         return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
> >  }
> >
> > -#ifdef CONFIG_ZPOOL
> > -static bool obj_stores_deferred_handle(struct page *page, void *obj,
> > -               unsigned long *phandle)
> > -{
> > -       return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
> > -}
> > -#endif
> > -
> >  static void reset_page(struct page *page)
> >  {
> >         __ClearPageMovable(page);
> > @@ -1006,9 +956,6 @@ static void free_zspage(struct zs_pool *pool, stru=
ct size_class *class,
> >         }
> >
> >         remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
> > -#ifdef CONFIG_ZPOOL
> > -       list_del(&zspage->lru);
> > -#endif
> >         __free_zspage(pool, class, zspage);
> >  }
> >
> > @@ -1054,11 +1001,6 @@ static void init_zspage(struct size_class *class=
, struct zspage *zspage)
> >                 off %=3D PAGE_SIZE;
> >         }
> >
> > -#ifdef CONFIG_ZPOOL
> > -       INIT_LIST_HEAD(&zspage->lru);
> > -       zspage->under_reclaim =3D false;
> > -#endif
> > -
> >         set_freeobj(zspage, 0);
> >  }
> >
> > @@ -1525,13 +1467,6 @@ unsigned long zs_malloc(struct zs_pool *pool, si=
ze_t size, gfp_t gfp)
> >         /* We completely set up zspage so mark them as movable */
> >         SetZsPageMovable(pool, zspage);
> >  out:
> > -#ifdef CONFIG_ZPOOL
> > -       /* Add/move zspage to beginning of LRU */
> > -       if (!list_empty(&zspage->lru))
> > -               list_del(&zspage->lru);
> > -       list_add(&zspage->lru, &pool->lru);
> > -#endif
> > -
> >         spin_unlock(&pool->lock);
> >
> >         return handle;
> > @@ -1600,20 +1535,6 @@ void zs_free(struct zs_pool *pool, unsigned long=
 handle)
> >         class =3D zspage_class(pool, zspage);
> >
> >         class_stat_dec(class, ZS_OBJS_INUSE, 1);
> > -
> > -#ifdef CONFIG_ZPOOL
> > -       if (zspage->under_reclaim) {
> > -               /*
> > -                * Reclaim needs the handles during writeback. It'll fr=
ee
> > -                * them along with the zspage when it's done with them.
> > -                *
> > -                * Record current deferred handle in the object's heade=
r.
> > -                */
> > -               obj_free(class->size, obj, &handle);
> > -               spin_unlock(&pool->lock);
> > -               return;
> > -       }
> > -#endif
> >         obj_free(class->size, obj, NULL);
> >
> >         fullness =3D fix_fullness_group(class, zspage);
> > @@ -1890,23 +1811,6 @@ static void lock_zspage(struct zspage *zspage)
> >  }
> >  #endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
>
> If I recall correctly, the defined(CONFIG_ZPOOL) condition is
> only needed for the lock_zspage() call in zs_reclaim_page().
>
> You might be able to get away with just
> #ifdef CONFIG_COMPACTION if you're removing writeback.
>
> Do fact-check me of course - try to build with these CONFIGs turned
> off and see. I'm surprised kernel test robot has not complained about
> unused static function lock_zspage() in the case
> CONFIG_ZPOOL && !CONFIG_COMPACTION
>

Thanks! It is indeed the case, with CONFIG_ZPOOL && !CONFIG_COMPACTION
lock_zspage becomes unused -> will go with #ifdef CONFIG_COMPACTION alone.

> >
> > -#ifdef CONFIG_ZPOOL
> > -/*
> > - * Unlocks all the pages of the zspage.
> > - *
> > - * pool->lock must be held before this function is called
> > - * to prevent the underlying pages from migrating.
> > - */
> > -static void unlock_zspage(struct zspage *zspage)
> > -{
> > -       struct page *page =3D get_first_page(zspage);
> > -
> > -       do {
> > -               unlock_page(page);
> > -       } while ((page =3D get_next_page(page)) !=3D NULL);
> > -}
> > -#endif /* CONFIG_ZPOOL */
> > -
> >  static void migrate_lock_init(struct zspage *zspage)
> >  {
> >         rwlock_init(&zspage->lock);
> > @@ -2126,9 +2030,6 @@ static void async_free_zspage(struct work_struct =
*work)
> >                 VM_BUG_ON(fullness !=3D ZS_INUSE_RATIO_0);
> >                 class =3D pool->size_class[class_idx];
> >                 spin_lock(&pool->lock);
> > -#ifdef CONFIG_ZPOOL
> > -               list_del(&zspage->lru);
> > -#endif
> >                 __free_zspage(pool, class, zspage);
> >                 spin_unlock(&pool->lock);
> >         }
> > @@ -2474,10 +2375,6 @@ struct zs_pool *zs_create_pool(const char *name)
> >          */
> >         zs_register_shrinker(pool);
> >
> > -#ifdef CONFIG_ZPOOL
> > -       INIT_LIST_HEAD(&pool->lru);
> > -#endif
> > -
> >         return pool;
> >
> >  err:
> > @@ -2520,190 +2417,6 @@ void zs_destroy_pool(struct zs_pool *pool)
> >  }
> >  EXPORT_SYMBOL_GPL(zs_destroy_pool);
> >
> > -#ifdef CONFIG_ZPOOL
> > -static void restore_freelist(struct zs_pool *pool, struct size_class *=
class,
> > -               struct zspage *zspage)
> > -{
> > -       unsigned int obj_idx =3D 0;
> > -       unsigned long handle, off =3D 0; /* off is within-page offset *=
/
> > -       struct page *page =3D get_first_page(zspage);
> > -       struct link_free *prev_free =3D NULL;
> > -       void *prev_page_vaddr =3D NULL;
> > -
> > -       /* in case no free object found */
> > -       set_freeobj(zspage, (unsigned int)(-1UL));
> > -
> > -       while (page) {
> > -               void *vaddr =3D kmap_atomic(page);
> > -               struct page *next_page;
> > -
> > -               while (off < PAGE_SIZE) {
> > -                       void *obj_addr =3D vaddr + off;
> > -
> > -                       /* skip allocated object */
> > -                       if (obj_allocated(page, obj_addr, &handle)) {
> > -                               obj_idx++;
> > -                               off +=3D class->size;
> > -                               continue;
> > -                       }
> > -
> > -                       /* free deferred handle from reclaim attempt */
> > -                       if (obj_stores_deferred_handle(page, obj_addr, =
&handle))
> > -                               cache_free_handle(pool, handle);
> > -
> > -                       if (prev_free)
> > -                               prev_free->next =3D obj_idx << OBJ_TAG_=
BITS;
> > -                       else /* first free object found */
> > -                               set_freeobj(zspage, obj_idx);
> > -
> > -                       prev_free =3D (struct link_free *)vaddr + off /=
 sizeof(*prev_free);
> > -                       /* if last free object in a previous page, need=
 to unmap */
> > -                       if (prev_page_vaddr) {
> > -                               kunmap_atomic(prev_page_vaddr);
> > -                               prev_page_vaddr =3D NULL;
> > -                       }
> > -
> > -                       obj_idx++;
> > -                       off +=3D class->size;
> > -               }
> > -
> > -               /*
> > -                * Handle the last (full or partial) object on this pag=
e.
> > -                */
> > -               next_page =3D get_next_page(page);
> > -               if (next_page) {
> > -                       if (!prev_free || prev_page_vaddr) {
> > -                               /*
> > -                                * There is no free object in this page=
, so we can safely
> > -                                * unmap it.
> > -                                */
> > -                               kunmap_atomic(vaddr);
> > -                       } else {
> > -                               /* update prev_page_vaddr since prev_fr=
ee is on this page */
> > -                               prev_page_vaddr =3D vaddr;
> > -                       }
> > -               } else { /* this is the last page */
> > -                       if (prev_free) {
> > -                               /*
> > -                                * Reset OBJ_TAG_BITS bit to last link =
to tell
> > -                                * whether it's allocated object or not=
.
> > -                                */
> > -                               prev_free->next =3D -1UL << OBJ_TAG_BIT=
S;
> > -                       }
> > -
> > -                       /* unmap previous page (if not done yet) */
> > -                       if (prev_page_vaddr) {
> > -                               kunmap_atomic(prev_page_vaddr);
> > -                               prev_page_vaddr =3D NULL;
> > -                       }
> > -
> > -                       kunmap_atomic(vaddr);
> > -               }
> > -
> > -               page =3D next_page;
> > -               off %=3D PAGE_SIZE;
> > -       }
> > -}
> > -
> > -static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> > -{
> > -       int i, obj_idx, ret =3D 0;
> > -       unsigned long handle;
> > -       struct zspage *zspage;
> > -       struct page *page;
> > -       int fullness;
> > -
> > -       /* Lock LRU and fullness list */
> > -       spin_lock(&pool->lock);
> > -       if (list_empty(&pool->lru)) {
> > -               spin_unlock(&pool->lock);
> > -               return -EINVAL;
> > -       }
> > -
> > -       for (i =3D 0; i < retries; i++) {
> > -               struct size_class *class;
> > -
> > -               zspage =3D list_last_entry(&pool->lru, struct zspage, l=
ru);
> > -               list_del(&zspage->lru);
> > -
> > -               /* zs_free may free objects, but not the zspage and han=
dles */
> > -               zspage->under_reclaim =3D true;
> > -
> > -               class =3D zspage_class(pool, zspage);
> > -               fullness =3D get_fullness_group(class, zspage);
> > -
> > -               /* Lock out object allocations and object compaction */
> > -               remove_zspage(class, zspage, fullness);
> > -
> > -               spin_unlock(&pool->lock);
> > -               cond_resched();
> > -
> > -               /* Lock backing pages into place */
> > -               lock_zspage(zspage);
> > -
> > -               obj_idx =3D 0;
> > -               page =3D get_first_page(zspage);
> > -               while (1) {
> > -                       handle =3D find_alloced_obj(class, page, &obj_i=
dx);
> > -                       if (!handle) {
> > -                               page =3D get_next_page(page);
> > -                               if (!page)
> > -                                       break;
> > -                               obj_idx =3D 0;
> > -                               continue;
> > -                       }
> > -
> > -                       /*
> > -                        * This will write the object and call zs_free.
> > -                        *
> > -                        * zs_free will free the object, but the
> > -                        * under_reclaim flag prevents it from freeing
> > -                        * the zspage altogether. This is necessary so
> > -                        * that we can continue working with the
> > -                        * zspage potentially after the last object
> > -                        * has been freed.
> > -                        */
> > -                       ret =3D pool->zpool_ops->evict(pool->zpool, han=
dle);
> > -                       if (ret)
> > -                               goto next;
> > -
> > -                       obj_idx++;
> > -               }
> > -
> > -next:
> > -               /* For freeing the zspage, or putting it back in the po=
ol and LRU list. */
> > -               spin_lock(&pool->lock);
> > -               zspage->under_reclaim =3D false;
> > -
> > -               if (!get_zspage_inuse(zspage)) {
> > -                       /*
> > -                        * Fullness went stale as zs_free() won't touch=
 it
> > -                        * while the page is removed from the pool. Fix=
 it
> > -                        * up for the check in __free_zspage().
> > -                        */
> > -                       zspage->fullness =3D ZS_INUSE_RATIO_0;
> > -
> > -                       __free_zspage(pool, class, zspage);
> > -                       spin_unlock(&pool->lock);
> > -                       return 0;
> > -               }
> > -
> > -               /*
> > -                * Eviction fails on one of the handles, so we need to =
restore zspage.
> > -                * We need to rebuild its freelist (and free stored def=
erred handles),
> > -                * put it back to the correct size class, and add it to=
 the LRU list.
> > -                */
> > -               restore_freelist(pool, class, zspage);
> > -               putback_zspage(class, zspage);
> > -               list_add(&zspage->lru, &pool->lru);
> > -               unlock_zspage(zspage);
> > -       }
> > -
> > -       spin_unlock(&pool->lock);
> > -       return -EAGAIN;
> > -}
> > -#endif /* CONFIG_ZPOOL */
> > -
> >  static int __init zs_init(void)
> >  {
> >         int ret;
> > --
> > 2.34.1
> >
