Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24659723DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbjFFJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbjFFJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:35:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED3E6D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:35:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39a50fcc719so4024449b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686044128; x=1688636128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWQiXuIRb46Lzjnlp2OWrFgW8Gqy2tURjcQ9J82M55w=;
        b=OPCxTmlTxf6teYDR6rwJlRL1rX1Rv3Lz4uuaJAMXwwowD5mwY/djSulAFjKP0PY4Dl
         gB55UCf89Anw/UEmcQM0vcVftbCn5uN1EXecvF/lFEzk+PYoBIMxSMHODn6Oyka1mKQJ
         KTTpRYMiNW0jAAeLSwkie6zD1IQmwJJHvVtYaWipA4a9z8au405BLJ0u6A+crsG1TZba
         7b1Wp0bBlbAXE9Sd8Y50RJSSwlYFHAyJORr6IpRGH/CBq8eH9qcyO8ZhMONENoRAVryq
         2f9ftLrl5M42p60uCXre/gvOx7+3qyoxxirvl9F7RERnJbikG3v6cNyDqQ+6sISUhYhN
         G9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044128; x=1688636128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWQiXuIRb46Lzjnlp2OWrFgW8Gqy2tURjcQ9J82M55w=;
        b=VPzUkorkJfLj2EezxF5YkpJx6qk58kJKfQ8+saqIrGfETsGPFriymZ7WVVtcC5nwSF
         ick/NyXuTf7E9OqhxLzAvPNxCXxKlACgDCuCJ2fFnX+ISu/M9Hh24dwO/ayXwMYdtfpf
         7PZZGOOgi+hzAqh7dj9OQUvVy0ZBWJeKCHZp/CkQ+B6hMymO4Ci4N713qiOsp/3MvC9h
         6kMTRC2q6RlZZGNnn4X31ZdQQZFtovQIErg+OM1Te0QQSdkjUlidgBGR8nyyaLmiDXY1
         PmMydXqcptRzRsvg0C3fzISPMwiOcRPhxpiHY4G+9WRT5CnguV0vDYPARCs10E80jaFk
         D7Sw==
X-Gm-Message-State: AC+VfDx55PygaZoF/JrmMtWFCxo2vJPsm16OlS1NKRp4gDAydTw3C4jJ
        K1uB5y49/9owZPVgThuz5UOFZQCvAhU2CormXfUgLBZbhwGFkQ==
X-Google-Smtp-Source: ACHHUZ6JSA+qKyoJHk2sSeuPtQ7PrnpRCYmhI1jJcYIVfxsAPpXxHyZC2TmasRF5HML9S8+c6uLLh3pLtf6juKw5Wf4=
X-Received: by 2002:a05:6808:3a1:b0:383:e7c8:4000 with SMTP id
 n1-20020a05680803a100b00383e7c84000mr1621122oie.13.1686044128540; Tue, 06 Jun
 2023 02:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-2-cerasuolodomenico@gmail.com> <CAJD7tka+_-MZDwbyt8vewvgRzRNg9jpFL7pxfu4ruceGpCkqCw@mail.gmail.com>
In-Reply-To: <CAJD7tka+_-MZDwbyt8vewvgRzRNg9jpFL7pxfu4ruceGpCkqCw@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Tue, 6 Jun 2023 11:35:17 +0200
Message-ID: <CA+CLi1ikS52d+ztjMbT56bMD0Cqnb2H0WimXgOJw72hznymmEg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm: zswap: add pool shrinking mechanism
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

On Tue, Jun 6, 2023 at 4:19=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Hi Domenico,
>
> On Mon, Jun 5, 2023 at 1:54=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
> > function, which is called from zpool_shrink. However, with this commit,
> > a unified shrink function is added to zswap. The ultimate goal is to
> > eliminate the need for zpool_shrink once all zpool implementations have
> > dropped their shrink code.
> >
> > To ensure the functionality of each commit, this change focuses solely
> > on adding the mechanism itself. No modifications are made to
> > the backends, meaning that functionally, there are no immediate changes=
.
> > The zswap mechanism will only come into effect once the backends have
> > removed their shrink code. The subsequent commits will address the
> > modifications needed in the backends.
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zswap.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 78 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index bcb82e09eb64..80d7780bf066 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -159,6 +159,8 @@ struct zswap_pool {
> >         struct work_struct shrink_work;
> >         struct hlist_node node;
> >         char tfm_name[CRYPTO_MAX_ALG_NAME];
> > +       struct list_head lru;
> > +       spinlock_t lock;
>
> If this lock is only protecting the lru then I believe it's better to
> call in lru_lock to make it explicit.

Hi Yosry,

thanks for the input, it makes sense to call it lru_lock, will update.

>
> >  };
> >
> >  /*
> > @@ -176,10 +178,12 @@ struct zswap_pool {
> >   *            be held while changing the refcount.  Since the lock mus=
t
> >   *            be held, there is no reason to also make refcount atomic=
.
> >   * length - the length in bytes of the compressed page data.  Needed d=
uring
> > - *          decompression. For a same value filled page length is 0.
> > + *          decompression. For a same value filled page length is 0, a=
nd both
> > + *          pool and lru are invalid and must be ignored.
> >   * pool - the zswap_pool the entry's data is in
> >   * handle - zpool allocation handle that stores the compressed page da=
ta
> >   * value - value of the same-value filled pages which have same conten=
t
> > + * lru - handle to the pool's lru used to evict pages.
> >   */
> >  struct zswap_entry {
> >         struct rb_node rbnode;
> > @@ -192,6 +196,7 @@ struct zswap_entry {
> >                 unsigned long value;
> >         };
> >         struct obj_cgroup *objcg;
> > +       struct list_head lru;
> >  };
> >
> >  struct zswap_header {
> > @@ -364,6 +369,9 @@ static void zswap_free_entry(struct zswap_entry *en=
try)
> >         if (!entry->length)
> >                 atomic_dec(&zswap_same_filled_pages);
> >         else {
> > +               spin_lock(&entry->pool->lock);
> > +               list_del_init(&entry->lru);
> > +               spin_unlock(&entry->pool->lock);
>
> I think we should document the lock ordering somewhere (tree lock ->
> lru lock), otherwise we may run into an ABBA deadlock down the road.

Will update in the next iteration.

>
> >                 zpool_free(entry->pool->zpool, entry->handle);
> >                 zswap_pool_put(entry->pool);
> >         }
> > @@ -584,14 +592,65 @@ static struct zswap_pool *zswap_pool_find_get(cha=
r *type, char *compressor)
> >         return NULL;
> >  }
> >
> > +static int zswap_shrink(struct zswap_pool *pool)
> > +{
> > +       struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > +       struct zswap_header *zhdr;
> > +       struct zswap_tree *tree;
> > +       swp_entry_t swpentry;
> > +       int ret;
> > +
> > +       /* get a reclaimable entry from LRU */
> > +       spin_lock(&pool->lock);
> > +       if (list_empty(&pool->lru)) {
> > +               spin_unlock(&pool->lock);
> > +               return -EINVAL;
> > +       }
> > +       lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, l=
ru);
> > +       list_del_init(&lru_entry->lru);
> > +       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL=
_MM_RO);
> > +       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > +       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > +       swpentry =3D zhdr->swpentry;
> > +       spin_unlock(&pool->lock);
> > +
> > +       /* hold a reference from tree so it won't be freed during write=
back */
> > +       spin_lock(&tree->lock);
> > +       tree_entry =3D zswap_entry_find_get(&tree->rbroot, swp_offset(s=
wpentry));
> > +       if (tree_entry !=3D lru_entry) {
> > +               if (tree_entry)
> > +                       zswap_entry_put(tree, tree_entry);
> > +               spin_unlock(&tree->lock);
> > +               return -EAGAIN;
> > +       }
> > +       spin_unlock(&tree->lock);
> > +
> > +       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > +
> > +       spin_lock(&tree->lock);
> > +       if (ret) {
> > +               spin_lock(&pool->lock);
> > +               list_move(&lru_entry->lru, &pool->lru);
> > +               spin_unlock(&pool->lock);
> > +       }
> > +       zswap_entry_put(tree, tree_entry);
> > +       spin_unlock(&tree->lock);
> > +
> > +       return ret ? -EAGAIN : 0;
> > +}
> > +
> >  static void shrink_worker(struct work_struct *w)
> >  {
> >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                                 shrink_work);
> >         int ret, failures =3D 0;
> >
> > +       /* zpool_evictable will be removed once all 3 backends have mig=
rated*/
> >         do {
> > -               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +               if (zpool_evictable(pool->zpool))
> > +                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +               else
> > +                       ret =3D zswap_shrink(pool);
> >                 if (ret) {
> >                         zswap_reject_reclaim_fail++;
> >                         if (ret !=3D -EAGAIN)
> > @@ -655,6 +714,8 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
> >          */
> >         kref_init(&pool->kref);
> >         INIT_LIST_HEAD(&pool->list);
> > +       INIT_LIST_HEAD(&pool->lru);
> > +       spin_lock_init(&pool->lock);
> >         INIT_WORK(&pool->shrink_work, shrink_worker);
> >
> >         zswap_pool_debug("created", pool);
> > @@ -1270,7 +1331,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >         }
> >
> >         /* store */
> > -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0=
;
> > +       hlen =3D sizeof(zhdr);
> >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >         if (zpool_malloc_support_movable(entry->pool->zpool))
> >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1313,6 +1374,13 @@ static int zswap_frontswap_store(unsigned type, =
pgoff_t offset,
> >                         zswap_entry_put(tree, dupentry);
> >                 }
> >         } while (ret =3D=3D -EEXIST);
> > +       INIT_LIST_HEAD(&entry->lru);
> > +       /* zpool_evictable will be removed once all 3 backends have mig=
rated*/
> > +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> > +               spin_lock(&entry->pool->lock);
> > +               list_add(&entry->lru, &entry->pool->lru);
> > +               spin_unlock(&entry->pool->lock);
> > +       }
> >         spin_unlock(&tree->lock);
> >
> >         /* update stats */
> > @@ -1384,8 +1452,7 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >         /* decompress */
> >         dlen =3D PAGE_SIZE;
> >         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPO=
OL_MM_RO);
> > -       if (zpool_evictable(entry->pool->zpool))
> > -               src +=3D sizeof(struct zswap_header);
> > +       src +=3D sizeof(struct zswap_header);
> >
> >         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> >                 memcpy(tmp, src, entry->length);
> > @@ -1415,6 +1482,12 @@ static int zswap_frontswap_load(unsigned type, p=
goff_t offset,
> >  freeentry:
> >         spin_lock(&tree->lock);
> >         zswap_entry_put(tree, entry);
> > +       /* zpool_evictable will be removed once all 3 backends have mig=
rated*/
> > +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> > +               spin_lock(&entry->pool->lock);
> > +               list_move(&entry->lru, &entry->pool->lru);
> > +               spin_unlock(&entry->pool->lock);
> > +       }
> >         spin_unlock(&tree->lock);
> >
> >         return ret;
> > --
> > 2.34.1
> >
