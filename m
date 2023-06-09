Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873857297B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFILDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjFILC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:02:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B578273D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:02:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-974638ed5c5so357538466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686308543; x=1688900543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyEH71FGKoeq2QeMyLJVASNNz7vp30E/6Q71Nq3qif8=;
        b=Dq7n6qrnyonq0tToLe7fF5XfEJrj3QSmMpa/pAJqLUxWoJgE5T3RKCg8S9aQBU7v26
         mYq9uMmpPdLz9GH8CN5dAmrGTuTZ/5wsps62F/H3+bxTAn5QAlz3lixeQN2DsKlqLzEs
         EdNCYQZgrI0Mv3y9SwtDIFukBVD8VE8F2HkNB8yZpE6GGI1JPJw6ptQuvrG7E3Mw8IQg
         C4N4trb7MwunZK6vWCEwqPTff1pfuHlu1yoWqN1u+JIrGS2INR2h1Grn8CgVpMHLRG0R
         0cjS0cEVM2OIVFSf4ILyvsHGIeQS/lHhGypri5ua915kaltgD9ZPqlh9Z0ZO+9jl6PGz
         kdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308543; x=1688900543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyEH71FGKoeq2QeMyLJVASNNz7vp30E/6Q71Nq3qif8=;
        b=N28JhAfE3ZJvj5te3v0eTYo/N+jGUzEbX4ChALK7rc0Av7bKBs7m2LsldgzL2QJaFu
         aFul38O5kY6UoUDZJFd9KpaZxIPwOy5qJLUDVE2nHX8Y3MBdpnuj6uENBsyJktIHoaAS
         lBIhqjPCPCYzTormC7GVnn/B7+5dXl3NmYWQVBZu6N+fq6aqsw96wFuQGwcm7bDOPAl9
         CKnfFMQqUJyUUajm0jk9Na0hHW0B63PuQ8+B3olwddB67/L7Bbmheb0L1gr0APgztYy9
         gQui/ZqPrpzw06G3LcQenKklEUSmP5Zs4xJK8SUPuk1AV7gGTsq95hWXXW2b9psXPcZP
         I1sg==
X-Gm-Message-State: AC+VfDywQUUNvc6Da4ehryb/ckk1QM6bLR7VrtOjz7s0FRQbekeFvKfN
        mWEH78bDtxxvtqT8MablEuII/uhQ6LJzYCwLjNcFxw==
X-Google-Smtp-Source: ACHHUZ64rbGj3qg3jaP564y8zxkwh/GmmvZP+ZFR4ihQjXm0UMUkgir6gninXHxyVvjOEhSgMntb0nBctvqnPOEidTo=
X-Received: by 2002:a17:907:25ca:b0:971:55e2:82c3 with SMTP id
 ae10-20020a17090725ca00b0097155e282c3mr1078353ejc.20.1686308543224; Fri, 09
 Jun 2023 04:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-7-cerasuolodomenico@gmail.com> <CAJD7tkY09KvHGGVwQqSj7XHvHe+z5iC1-Ghj97gHbbWnDk1_kg@mail.gmail.com>
 <CA+CLi1iJ=PCoQJx_qF1tOnR61jXBXpLoNJUsFrtxaoFUC51OHQ@mail.gmail.com>
In-Reply-To: <CA+CLi1iJ=PCoQJx_qF1tOnR61jXBXpLoNJUsFrtxaoFUC51OHQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 9 Jun 2023 04:01:46 -0700
Message-ID: <CAJD7tkaHn8y6TsmOxwFWhCkhf9Sy++=3sN9x937EzKzHYbz5TA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
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
        TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 3:23=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 7, 2023 at 11:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > Previously, in zswap, the writeback function was passed to zpool driv=
ers
> > > for their usage in calling the writeback operation. However, since th=
e
> > > drivers did not possess references to entries and the function was
> > > specifically designed to work with handles, the writeback process has
> > > been modified to occur directly within zswap. Consequently, this chan=
ge
> > > allows for some simplification of the writeback function, taking into
> > > account the updated workflow.
> > >
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > ---
> > >  mm/zswap.c | 69 ++++++++++++++--------------------------------------=
--
> > >  1 file changed, 17 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 2831bf56b168..ef8604812352 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -250,7 +250,8 @@ static bool zswap_has_pool;
> > >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> > >                  zpool_get_type((p)->zpool))
> > >
> > > -static int zswap_writeback_entry(struct zpool *pool, unsigned long h=
andle);
> > > +static int zswap_writeback_entry(struct zswap_entry *entry, struct z=
swap_header *zhdr,
> > > +                                struct zswap_tree *tree);
> > >  static int zswap_pool_get(struct zswap_pool *pool);
> > >  static void zswap_pool_put(struct zswap_pool *pool);
> > >
> > > @@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool=
)
> > >         }
> > >         spin_unlock(&tree->lock);
> > >
> > > -       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle)=
;
> > > +       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> > >
> > >         spin_lock(&tree->lock);
> > >         if (ret) {
> > >                 spin_lock(&pool->lru_lock);
> > >                 list_move(&lru_entry->lru, &pool->lru);
> > >                 spin_unlock(&pool->lru_lock);
> > > +               zswap_entry_put(tree, tree_entry);
> > > +       } else {
> > > +               /* free the local reference */
> > > +               zswap_entry_put(tree, tree_entry);
> > > +               /* free the entry if it's not been invalidated*/
> > > +               if (lru_entry =3D=3D zswap_rb_search(&tree->rbroot, s=
wpoffset))
> > > +                       zswap_entry_put(tree, tree_entry);
> >
> > The comment that was here about the 2 possible cases was useful imo,
> > maybe keep it?
>
> I honestly found it brittle in that we're not interested in the refcount =
there,
> but rather in releasing the base reference that keeps the entry valid.
> There's not way to know which refcount value it should be though, conside=
r
> that throughout this series the values can be 1 or 0, but also 2 or 1,
> depending on where this function is called (zpool_shrink or zswap_shrink)=
.

Yeah looking at it with fresh eyes makes sense, we want to invalidate
the entry, not really caring about the refcount (see below).

>
> >
> > Also, I am not sure why we need to do a tree search vs. just reading
> > the refcount here before the first put. We can even make
> > zswap_entry_put() return the refcount after the put to know if we need
> > the additional put or not.
> >
> > Can anyone think of any reason why we need to explicitly search the tre=
e here?
>
> I think that the reasoning here is that refcount > 0 doesn't necessarily =
mean
> that the entry is on the tree. I'm not sure if reading refcount directly =
here
> would cause an issue now, probably not, but I wonder if bugs could be
> introduced if the context in which this function is called changes.

Yeah I agree. As Johannes suggested, using zswap_invalidate_entry()
(from my exclusive loads patch in mm-unstable) would be best here imo.

>
> >
> > >         }
> > > -       zswap_entry_put(tree, tree_entry);
> > >         spin_unlock(&tree->lock);
> > >
> > >         return ret ? -EAGAIN : 0;
> > > @@ -1039,16 +1046,14 @@ static int zswap_get_swap_cache_page(swp_entr=
y_t entry,
> > >   * the swap cache, the compressed version stored by zswap can be
> > >   * freed.
> > >   */
> > > -static int zswap_writeback_entry(struct zpool *pool, unsigned long h=
andle)
> > > +static int zswap_writeback_entry(struct zswap_entry *entry, struct z=
swap_header *zhdr,
> > > +                                struct zswap_tree *tree)
> > >  {
> > > -       struct zswap_header *zhdr;
> > > -       swp_entry_t swpentry;
> > > -       struct zswap_tree *tree;
> > > -       pgoff_t offset;
> > > -       struct zswap_entry *entry;
> > > +       swp_entry_t swpentry =3D zhdr->swpentry;
> > >         struct page *page;
> > >         struct scatterlist input, output;
> > >         struct crypto_acomp_ctx *acomp_ctx;
> > > +       struct zpool *pool =3D entry->pool->zpool;
> > >
> > >         u8 *src, *tmp =3D NULL;
> > >         unsigned int dlen;
> > > @@ -1063,25 +1068,6 @@ static int zswap_writeback_entry(struct zpool =
*pool, unsigned long handle)
> > >                         return -ENOMEM;
> > >         }
> > >
> > > -       /* extract swpentry from data */
> > > -       zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> > > -       swpentry =3D zhdr->swpentry; /* here */
> > > -       tree =3D zswap_trees[swp_type(swpentry)];
> > > -       offset =3D swp_offset(swpentry);
> > > -       zpool_unmap_handle(pool, handle);
> > > -
> > > -       /* find and ref zswap entry */
> > > -       spin_lock(&tree->lock);
> > > -       entry =3D zswap_entry_find_get(&tree->rbroot, offset);
> > > -       if (!entry) {
> > > -               /* entry was invalidated */
> > > -               spin_unlock(&tree->lock);
> > > -               kfree(tmp);
> > > -               return 0;
> > > -       }
> > > -       spin_unlock(&tree->lock);
> > > -       BUG_ON(offset !=3D entry->offset);
> > > -
> > >         /* try to allocate swap cache page */
> > >         switch (zswap_get_swap_cache_page(swpentry, &page)) {
> > >         case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happene=
d */
> > > @@ -1115,12 +1101,12 @@ static int zswap_writeback_entry(struct zpool=
 *pool, unsigned long handle)
> > >                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > >                 dlen =3D PAGE_SIZE;
> > >
> > > -               zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> > > +               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_=
MM_RO);
> > >                 src =3D (u8 *)zhdr + sizeof(struct zswap_header);
> > >                 if (!zpool_can_sleep_mapped(pool)) {
> > >                         memcpy(tmp, src, entry->length);
> > >                         src =3D tmp;
> > > -                       zpool_unmap_handle(pool, handle);
> > > +                       zpool_unmap_handle(pool, entry->handle);
> > >                 }
> > >
> > >                 mutex_lock(acomp_ctx->mutex);
> > > @@ -1135,7 +1121,7 @@ static int zswap_writeback_entry(struct zpool *=
pool, unsigned long handle)
> > >                 if (!zpool_can_sleep_mapped(pool))
> > >                         kfree(tmp);
> > >                 else
> > > -                       zpool_unmap_handle(pool, handle);
> > > +                       zpool_unmap_handle(pool, entry->handle);
> > >
> > >                 BUG_ON(ret);
> > >                 BUG_ON(dlen !=3D PAGE_SIZE);
> > > @@ -1152,23 +1138,7 @@ static int zswap_writeback_entry(struct zpool =
*pool, unsigned long handle)
> > >         put_page(page);
> > >         zswap_written_back_pages++;
> > >
> > > -       spin_lock(&tree->lock);
> > > -       /* drop local reference */
> > > -       zswap_entry_put(tree, entry);
> > > -
> > > -       /*
> > > -       * There are two possible situations for entry here:
> > > -       * (1) refcount is 1(normal case),  entry is valid and on the =
tree
> > > -       * (2) refcount is 0, entry is freed and not on the tree
> > > -       *     because invalidate happened during writeback
> > > -       *  search the tree and free the entry if find entry
> > > -       */
> > > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, offset))
> > > -               zswap_entry_put(tree, entry);
> > > -       spin_unlock(&tree->lock);
> > > -
> > >         return ret;
> > > -
> > >  fail:
> > >         if (!zpool_can_sleep_mapped(pool))
> > >                 kfree(tmp);
> > > @@ -1177,13 +1147,8 @@ static int zswap_writeback_entry(struct zpool =
*pool, unsigned long handle)
> > >         * if we get here due to ZSWAP_SWAPCACHE_EXIST
> > >         * a load may be happening concurrently.
> > >         * it is safe and okay to not free the entry.
> > > -       * if we free the entry in the following put
> > >         * it is also okay to return !0
> > >         */
> > > -       spin_lock(&tree->lock);
> > > -       zswap_entry_put(tree, entry);
> > > -       spin_unlock(&tree->lock);
> > > -
> > >         return ret;
> > >  }
> > >
> > > --
> > > 2.34.1
> > >
