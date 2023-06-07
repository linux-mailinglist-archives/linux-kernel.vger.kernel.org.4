Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C217725A74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbjFGJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbjFGJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:31:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA9EB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:31:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9745baf7c13so907922066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686130312; x=1688722312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwYzR2o8WcAa8FfzYaLSns1WLIjgOiUcygsuRU8mknw=;
        b=d1YSvvcAKQjI9TUdpM+UopsaTzWP2zetxJBwq5hkUwpByIItXy5b/+xShV3YaahRD9
         Z/1/zxiXuLzdSakyQMHE9A8freGIRNnWw4X4WCWvTRxP26Qc09jZKhq61H6FIvcvTFwK
         oIw9iA0KtCyRtNRohz/LnWIjZnXKZ0h8HQx0UspymZavnEI+ruyjzJ5hCO+QOMYz+C4D
         MTJfMfoeFcV8m8MYiQlEb0TBODo8SCrUirO8fp4sfKEQ6sKg+ebTCul13hhNdpgvHfCC
         wNsbovZGE+OeNf7dRmuLPJbC5hctx/YpSwAG4MgThLG8Mkd4B++enai1lwADU6dpjIjN
         PbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130312; x=1688722312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwYzR2o8WcAa8FfzYaLSns1WLIjgOiUcygsuRU8mknw=;
        b=Sf2HGoj+i3MN5zRSQj1r8vmhEDD4dxIwi6hdabjaqcVzP7XEcfHaCgJcyCwqOoVf3i
         RiYNCLI3Toy4n8JiBhB9TnCnm3c/w5Am5GpKBWj+xHZguqEiOQ7DybcS1AgXoQxvZ+e4
         +oOdhFPOcmEI51rG2wFMiK539LDYIlO71cbEBn294uLwinynhZz0nh0gDsE1OBdQCfSh
         NvXkCG7Fra0WPcJExgf+myYI2+RZfjVnbyuchSm8swTESsr49//+kXpjaXUrTUwqjrdt
         WjZXZMP1eTVKX2ak0ZTZvDDPnBG78QJf0rwaiAFnl8IuG03FIL15VILiEhC+MOzYX/q1
         B2hQ==
X-Gm-Message-State: AC+VfDzmlzt4AO03TNIx9O71oCTDN7T/0G0dCVKQnMPSr1NbvYQlYJFM
        7S9h7eB7sfLwxBwC274to7T+9p+Ug8xkQaaU3Xj+RQ==
X-Google-Smtp-Source: ACHHUZ7QY+KBO9LyrQdx7ajNY2km1lfdMJ0tZIqwSdP7UlZ1kFzU0bYIEnBN7e3JcPAunccbhOnZoiosXw494Bl8JtE=
X-Received: by 2002:a17:907:d93:b0:959:5407:3e65 with SMTP id
 go19-20020a1709070d9300b0095954073e65mr5702271ejc.55.1686130312231; Wed, 07
 Jun 2023 02:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com> <CAJD7tkYvGeDMHobekqzJJOQuvZM3S6eNq-HCRJQ8UQE6_tmwSA@mail.gmail.com>
 <CA+CLi1g6wa7PW8zCSbpxLj=CwS534MHKbN0v6ZLPWnuHaDVf_Q@mail.gmail.com>
In-Reply-To: <CA+CLi1g6wa7PW8zCSbpxLj=CwS534MHKbN0v6ZLPWnuHaDVf_Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:31:15 -0700
Message-ID: <CAJD7tkYxuO+sixDCdv7pLjtTtNa-AzL8pn5EkkvYr5Fc+oZfeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
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

On Wed, Jun 7, 2023 at 2:22=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 7, 2023 at 10:14=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > Each zpool driver (zbud, z3fold and zsmalloc) implements its own shri=
nk
> > > function, which is called from zpool_shrink. However, with this commi=
t,
> > > a unified shrink function is added to zswap. The ultimate goal is to
> > > eliminate the need for zpool_shrink once all zpool implementations ha=
ve
> > > dropped their shrink code.
> > >
> > > To ensure the functionality of each commit, this change focuses solel=
y
> > > on adding the mechanism itself. No modifications are made to
> > > the backends, meaning that functionally, there are no immediate chang=
es.
> > > The zswap mechanism will only come into effect once the backends have
> > > removed their shrink code. The subsequent commits will address the
> > > modifications needed in the backends.
> > >
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > ---
> > >  mm/zswap.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 91 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index bcb82e09eb64..c99bafcefecf 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -150,6 +150,12 @@ struct crypto_acomp_ctx {
> > >         struct mutex *mutex;
> > >  };
> > >
> > > +/*
> > > + * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
> > > + * The only case where lru_lock is not acquired while holding tree.l=
ock is
> > > + * when a zswap_entry is taken off the lru for writeback, in that ca=
se it
> > > + * needs to be verified that it's still valid in the tree.
> > > + */
> > >  struct zswap_pool {
> > >         struct zpool *zpool;
> > >         struct crypto_acomp_ctx __percpu *acomp_ctx;
> > > @@ -159,6 +165,8 @@ struct zswap_pool {
> > >         struct work_struct shrink_work;
> > >         struct hlist_node node;
> > >         char tfm_name[CRYPTO_MAX_ALG_NAME];
> > > +       struct list_head lru;
> > > +       spinlock_t lru_lock;
> > >  };
> > >
> > >  /*
> > > @@ -176,10 +184,12 @@ struct zswap_pool {
> > >   *            be held while changing the refcount.  Since the lock m=
ust
> > >   *            be held, there is no reason to also make refcount atom=
ic.
> > >   * length - the length in bytes of the compressed page data.  Needed=
 during
> > > - *          decompression. For a same value filled page length is 0.
> > > + *          decompression. For a same value filled page length is 0,=
 and both
> > > + *          pool and lru are invalid and must be ignored.
> > >   * pool - the zswap_pool the entry's data is in
> > >   * handle - zpool allocation handle that stores the compressed page =
data
> > >   * value - value of the same-value filled pages which have same cont=
ent
> > > + * lru - handle to the pool's lru used to evict pages.
> > >   */
> > >  struct zswap_entry {
> > >         struct rb_node rbnode;
> > > @@ -192,6 +202,7 @@ struct zswap_entry {
> > >                 unsigned long value;
> > >         };
> > >         struct obj_cgroup *objcg;
> > > +       struct list_head lru;
> > >  };
> > >
> > >  struct zswap_header {
> > > @@ -364,6 +375,12 @@ static void zswap_free_entry(struct zswap_entry =
*entry)
> > >         if (!entry->length)
> > >                 atomic_dec(&zswap_same_filled_pages);
> > >         else {
> > > +       /* zpool_evictable will be removed once all 3 backends have m=
igrated */
> > > +               if (!zpool_evictable(entry->pool->zpool)) {
> > > +                       spin_lock(&entry->pool->lru_lock);
> > > +                       list_del(&entry->lru);
> > > +                       spin_unlock(&entry->pool->lru_lock);
> > > +               }
> > >                 zpool_free(entry->pool->zpool, entry->handle);
> > >                 zswap_pool_put(entry->pool);
> > >         }
> > > @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(c=
har *type, char *compressor)
> > >         return NULL;
> > >  }
> > >
> > > +static int zswap_shrink(struct zswap_pool *pool)
> >
> > Nit: rename to zswap_shrink_one() so that it's clear we always
> > writeback one entry per call?
>
> I named it like that to mirror zpool_shrink but I think that you've got a=
 point
> in that it might not be very clear that it is shrinking by one page only.
> What about zswap_reclaim_entry? I'm not a native speaker, but with
> zswap_shrink_one I wouldn't obviously intend that the "one" refers to an
> entry.

I am not a native speaker either, but zswap_reclaim_entry() sounds
much better :)

>
> >
> > > +{
> > > +       struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > > +       struct zswap_header *zhdr;
> > > +       struct zswap_tree *tree;
> > > +       int swpoffset;
> > > +       int ret;
> > > +
> > > +       /* get a reclaimable entry from LRU */
> > > +       spin_lock(&pool->lru_lock);
> > > +       if (list_empty(&pool->lru)) {
> > > +               spin_unlock(&pool->lru_lock);
> > > +               return -EINVAL;
> > > +       }
> > > +       lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry,=
 lru);
> > > +       list_del_init(&lru_entry->lru);
> > > +       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPO=
OL_MM_RO);
> > > +       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > > +       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > > +       /*
> > > +        * Once the pool lock is dropped, the lru_entry might get fre=
ed. The
> >
> > Nit: lru lock*
> >
> > > +        * swpoffset is copied to the stack, and lru_entry isn't dere=
f'd again
> > > +        * until the entry is verified to still be alive in the tree.
> > > +        */
> > > +       swpoffset =3D swp_offset(zhdr->swpentry);
> > > +       spin_unlock(&pool->lru_lock);
> > > +
> > > +       /* hold a reference from tree so it won't be freed during wri=
teback */
> > > +       spin_lock(&tree->lock);
> > > +       tree_entry =3D zswap_entry_find_get(&tree->rbroot, swpoffset)=
;
> > > +       if (tree_entry !=3D lru_entry) {
> > > +               if (tree_entry)
> > > +                       zswap_entry_put(tree, tree_entry);
> > > +               spin_unlock(&tree->lock);
> > > +               return -EAGAIN;
> > > +       }
> > > +       spin_unlock(&tree->lock);
> > > +
> > > +       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle)=
;
> > > +
> > > +       spin_lock(&tree->lock);
> > > +       if (ret) {
> > > +               spin_lock(&pool->lru_lock);
> > > +               list_move(&lru_entry->lru, &pool->lru);
> > > +               spin_unlock(&pool->lru_lock);
> > > +       }
> > > +       zswap_entry_put(tree, tree_entry);
> > > +       spin_unlock(&tree->lock);
> > > +
> > > +       return ret ? -EAGAIN : 0;
> > > +}
> > > +
> > >  static void shrink_worker(struct work_struct *w)
> > >  {
> > >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> > >                                                 shrink_work);
> > >         int ret, failures =3D 0;
> > >
> > > +       /* zpool_evictable will be removed once all 3 backends have m=
igrated */
> > >         do {
> > > -               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > > +               if (zpool_evictable(pool->zpool))
> > > +                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > > +               else
> > > +                       ret =3D zswap_shrink(pool);
> > >                 if (ret) {
> > >                         zswap_reject_reclaim_fail++;
> > >                         if (ret !=3D -EAGAIN)
> > > @@ -655,6 +728,8 @@ static struct zswap_pool *zswap_pool_create(char =
*type, char *compressor)
> > >          */
> > >         kref_init(&pool->kref);
> > >         INIT_LIST_HEAD(&pool->list);
> > > +       INIT_LIST_HEAD(&pool->lru);
> > > +       spin_lock_init(&pool->lru_lock);
> > >         INIT_WORK(&pool->shrink_work, shrink_worker);
> > >
> > >         zswap_pool_debug("created", pool);
> > > @@ -1270,7 +1345,7 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> > >         }
> > >
> > >         /* store */
> > > -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) :=
 0;
> > > +       hlen =3D sizeof(zhdr);
> > >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> > >         if (zpool_malloc_support_movable(entry->pool->zpool))
> > >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > > @@ -1313,6 +1388,12 @@ static int zswap_frontswap_store(unsigned type=
, pgoff_t offset,
> > >                         zswap_entry_put(tree, dupentry);
> > >                 }
> > >         } while (ret =3D=3D -EEXIST);
> > > +       /* zpool_evictable will be removed once all 3 backends have m=
igrated */
> > > +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> > > +               spin_lock(&entry->pool->lru_lock);
> > > +               list_add(&entry->lru, &entry->pool->lru);
> > > +               spin_unlock(&entry->pool->lru_lock);
> > > +       }
> > >         spin_unlock(&tree->lock);
> > >
> > >         /* update stats */
> > > @@ -1384,8 +1465,7 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> > >         /* decompress */
> > >         dlen =3D PAGE_SIZE;
> > >         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, Z=
POOL_MM_RO);
> > > -       if (zpool_evictable(entry->pool->zpool))
> > > -               src +=3D sizeof(struct zswap_header);
> > > +       src +=3D sizeof(struct zswap_header);
> > >
> > >         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > >                 memcpy(tmp, src, entry->length);
> > > @@ -1415,6 +1495,12 @@ static int zswap_frontswap_load(unsigned type,=
 pgoff_t offset,
> > >  freeentry:
> > >         spin_lock(&tree->lock);
> > >         zswap_entry_put(tree, entry);
> > > +       /* zpool_evictable will be removed once all 3 backends have m=
igrated */
> > > +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> > > +               spin_lock(&entry->pool->lru_lock);
> > > +               list_move(&entry->lru, &entry->pool->lru);
> > > +               spin_unlock(&entry->pool->lru_lock);
> > > +       }
> >
> > It's not really this patch's fault, but when merged with commit
> > fe1d1f7d0fb5 ("mm: zswap: support exclusive loads") from mm-unstable
> > [1], and with CONFIG_ZSWAP_EXCLUSIVE_LOADS=3Dy, this causes a crash.
> >
> > This happens because fe1d1f7d0fb5 makes the loads exclusive, so
> > zswap_entry_put(tree, entry) above the added code causes the entry to
> > be freed, then we go ahead and deference multiple fields within it in
> > the added chunk. Moving the chunk above zswap_entry_put() (and
> > consequently also above zswap_invalidate_entry() from fe1d1f7d0fb5)
> > makes this work correctly.
> >
> > Perhaps it would be useful to rebase on top of fe1d1f7d0fb5 for your
> > next version(s), if any.
>
> Will definitely rebase, I just now saw that you tested the suggested reso=
lution
> below, thanks, it does make sense.
>
> >
> > Maybe the outcome would be something like:
> >
> > zswap_entry_put(tree, entry);
> > if (!ret && IS_ENABLED(CONFIG_ZSWAP_EXCLUSIVE_LOADS)) {
> >         zswap_invalidate_entry(tree, entry);
> > } else if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> >         spin_lock(&entry->pool->lru_lock);
> >         list_move(&entry->lru, &entry->pool->lru);
> >         spin_unlock(&entry->pool->lru_lock);
> > }
> >
> > I am assuming if we are going to invalidate the entry anyway there is
> > no need to move it to the front of the lru -- but I didn't really
> > think it through.
> >
> > [1]https://lore.kernel.org/lkml/20230530210251.493194-1-yosryahmed@goog=
le.com/
> >
> > >         spin_unlock(&tree->lock);
> > >
> > >         return ret;
> > > --
> > > 2.34.1
> > >
