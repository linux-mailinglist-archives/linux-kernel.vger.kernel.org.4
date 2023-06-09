Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA717296E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbjFIKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjFIKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:31:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C363C3B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:23:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso395102a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686306211; x=1688898211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdKhQXwXNvtUHkggQ5c30dvq3G/GIzlIIawFCJvGlDI=;
        b=LIBIt0qp66qi8MlL6wVZinsvDKGB5NTZ6UDe9Im8UNb+VHGJnTN4n/6zPq20yuXc3f
         O4NkmoPZXHLOaQ9CiRD5Hpys3LlcavuO5x6fCe/Z8ZXjCientHxmUkbjbV3X1sNCdWnK
         CZ7biVHIl10nNzE3nuVIKCiX8C1mqRqmfK2OmROR43KB1gwWfugVLCZmxuHuNj7PhLkW
         iTPvR7u0rgL3AB3uhjPb1Uy/fTuxz+eiDxQ82OKG8PMwWZnnjZhnkDwvO/Nw/bVFMW6G
         OpuVnyW8gPLJQwheiDfF+lafmJ9Q5FDY6YFq5BIlfbT82Ii2Mwv5frM2mLD/fA/GGDoQ
         q0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306211; x=1688898211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdKhQXwXNvtUHkggQ5c30dvq3G/GIzlIIawFCJvGlDI=;
        b=NKQJVxiaayOPdiEPlf4rhSLBF7lQsFok6cBn8ZB7GLVyRYhnFe9pMkjTcgtJgz29wH
         I9dRiOlItSWNYsh0p+3eoDt6C208g4QeG9Bl8zMrxh/91iGgEH+QElfwBpaVykBTqq/M
         zZwEpQROrpsysiOnuvDeqpp1ostb6L+1tMPmYvvWLWuIQ+ht1i8c4jR9nB+zoQ4XpnqA
         3hVUp3t7raQ2oyjUK31Iyccck+9/0D79JHFqdqEnEQUyHT55fXq0fSKcJRdgcKqDKPRf
         UI20YB+9JMwPBaa6clN/onfASiPOL5CPZnZGZn0AOu2quHqFVVVNwIfNjd4ndMvMNPps
         XCYw==
X-Gm-Message-State: AC+VfDz5JKCoHqw57pDRebYdArgEqpIYhtEr6iI2urIit7yCzkNn0oCO
        dW4zm7xgxBpSI7MfZnwoJbTMEVp22ukkzfyYFKI=
X-Google-Smtp-Source: ACHHUZ7oc696J5MY/EQGMWVcaBtgnlKYZnTkw4YhUQMQkHGCgTWTB73RR53I68XS1rgPMZULBfeVqECWyULPnkavBLw=
X-Received: by 2002:a17:90a:19c4:b0:256:4196:f722 with SMTP id
 4-20020a17090a19c400b002564196f722mr557324pjj.47.1686306211036; Fri, 09 Jun
 2023 03:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-7-cerasuolodomenico@gmail.com> <CAJD7tkY09KvHGGVwQqSj7XHvHe+z5iC1-Ghj97gHbbWnDk1_kg@mail.gmail.com>
In-Reply-To: <CAJD7tkY09KvHGGVwQqSj7XHvHe+z5iC1-Ghj97gHbbWnDk1_kg@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Fri, 9 Jun 2023 12:23:19 +0200
Message-ID: <CA+CLi1iJ=PCoQJx_qF1tOnR61jXBXpLoNJUsFrtxaoFUC51OHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 11:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > Previously, in zswap, the writeback function was passed to zpool driver=
s
> > for their usage in calling the writeback operation. However, since the
> > drivers did not possess references to entries and the function was
> > specifically designed to work with handles, the writeback process has
> > been modified to occur directly within zswap. Consequently, this change
> > allows for some simplification of the writeback function, taking into
> > account the updated workflow.
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zswap.c | 69 ++++++++++++++----------------------------------------
> >  1 file changed, 17 insertions(+), 52 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 2831bf56b168..ef8604812352 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -250,7 +250,8 @@ static bool zswap_has_pool;
> >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> >                  zpool_get_type((p)->zpool))
> >
> > -static int zswap_writeback_entry(struct zpool *pool, unsigned long han=
dle);
> > +static int zswap_writeback_entry(struct zswap_entry *entry, struct zsw=
ap_header *zhdr,
> > +                                struct zswap_tree *tree);
> >  static int zswap_pool_get(struct zswap_pool *pool);
> >  static void zswap_pool_put(struct zswap_pool *pool);
> >
> > @@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool)
> >         }
> >         spin_unlock(&tree->lock);
> >
> > -       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > +       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> >
> >         spin_lock(&tree->lock);
> >         if (ret) {
> >                 spin_lock(&pool->lru_lock);
> >                 list_move(&lru_entry->lru, &pool->lru);
> >                 spin_unlock(&pool->lru_lock);
> > +               zswap_entry_put(tree, tree_entry);
> > +       } else {
> > +               /* free the local reference */
> > +               zswap_entry_put(tree, tree_entry);
> > +               /* free the entry if it's not been invalidated*/
> > +               if (lru_entry =3D=3D zswap_rb_search(&tree->rbroot, swp=
offset))
> > +                       zswap_entry_put(tree, tree_entry);
>
> The comment that was here about the 2 possible cases was useful imo,
> maybe keep it?

I honestly found it brittle in that we're not interested in the refcount th=
ere,
but rather in releasing the base reference that keeps the entry valid.
There's not way to know which refcount value it should be though, consider
that throughout this series the values can be 1 or 0, but also 2 or 1,
depending on where this function is called (zpool_shrink or zswap_shrink).

>
> Also, I am not sure why we need to do a tree search vs. just reading
> the refcount here before the first put. We can even make
> zswap_entry_put() return the refcount after the put to know if we need
> the additional put or not.
>
> Can anyone think of any reason why we need to explicitly search the tree =
here?

I think that the reasoning here is that refcount > 0 doesn't necessarily me=
an
that the entry is on the tree. I'm not sure if reading refcount directly he=
re
would cause an issue now, probably not, but I wonder if bugs could be
introduced if the context in which this function is called changes.

>
> >         }
> > -       zswap_entry_put(tree, tree_entry);
> >         spin_unlock(&tree->lock);
> >
> >         return ret ? -EAGAIN : 0;
> > @@ -1039,16 +1046,14 @@ static int zswap_get_swap_cache_page(swp_entry_=
t entry,
> >   * the swap cache, the compressed version stored by zswap can be
> >   * freed.
> >   */
> > -static int zswap_writeback_entry(struct zpool *pool, unsigned long han=
dle)
> > +static int zswap_writeback_entry(struct zswap_entry *entry, struct zsw=
ap_header *zhdr,
> > +                                struct zswap_tree *tree)
> >  {
> > -       struct zswap_header *zhdr;
> > -       swp_entry_t swpentry;
> > -       struct zswap_tree *tree;
> > -       pgoff_t offset;
> > -       struct zswap_entry *entry;
> > +       swp_entry_t swpentry =3D zhdr->swpentry;
> >         struct page *page;
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> > +       struct zpool *pool =3D entry->pool->zpool;
> >
> >         u8 *src, *tmp =3D NULL;
> >         unsigned int dlen;
> > @@ -1063,25 +1068,6 @@ static int zswap_writeback_entry(struct zpool *p=
ool, unsigned long handle)
> >                         return -ENOMEM;
> >         }
> >
> > -       /* extract swpentry from data */
> > -       zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> > -       swpentry =3D zhdr->swpentry; /* here */
> > -       tree =3D zswap_trees[swp_type(swpentry)];
> > -       offset =3D swp_offset(swpentry);
> > -       zpool_unmap_handle(pool, handle);
> > -
> > -       /* find and ref zswap entry */
> > -       spin_lock(&tree->lock);
> > -       entry =3D zswap_entry_find_get(&tree->rbroot, offset);
> > -       if (!entry) {
> > -               /* entry was invalidated */
> > -               spin_unlock(&tree->lock);
> > -               kfree(tmp);
> > -               return 0;
> > -       }
> > -       spin_unlock(&tree->lock);
> > -       BUG_ON(offset !=3D entry->offset);
> > -
> >         /* try to allocate swap cache page */
> >         switch (zswap_get_swap_cache_page(swpentry, &page)) {
> >         case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened =
*/
> > @@ -1115,12 +1101,12 @@ static int zswap_writeback_entry(struct zpool *=
pool, unsigned long handle)
> >                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >                 dlen =3D PAGE_SIZE;
> >
> > -               zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> > +               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM=
_RO);
> >                 src =3D (u8 *)zhdr + sizeof(struct zswap_header);
> >                 if (!zpool_can_sleep_mapped(pool)) {
> >                         memcpy(tmp, src, entry->length);
> >                         src =3D tmp;
> > -                       zpool_unmap_handle(pool, handle);
> > +                       zpool_unmap_handle(pool, entry->handle);
> >                 }
> >
> >                 mutex_lock(acomp_ctx->mutex);
> > @@ -1135,7 +1121,7 @@ static int zswap_writeback_entry(struct zpool *po=
ol, unsigned long handle)
> >                 if (!zpool_can_sleep_mapped(pool))
> >                         kfree(tmp);
> >                 else
> > -                       zpool_unmap_handle(pool, handle);
> > +                       zpool_unmap_handle(pool, entry->handle);
> >
> >                 BUG_ON(ret);
> >                 BUG_ON(dlen !=3D PAGE_SIZE);
> > @@ -1152,23 +1138,7 @@ static int zswap_writeback_entry(struct zpool *p=
ool, unsigned long handle)
> >         put_page(page);
> >         zswap_written_back_pages++;
> >
> > -       spin_lock(&tree->lock);
> > -       /* drop local reference */
> > -       zswap_entry_put(tree, entry);
> > -
> > -       /*
> > -       * There are two possible situations for entry here:
> > -       * (1) refcount is 1(normal case),  entry is valid and on the tr=
ee
> > -       * (2) refcount is 0, entry is freed and not on the tree
> > -       *     because invalidate happened during writeback
> > -       *  search the tree and free the entry if find entry
> > -       */
> > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, offset))
> > -               zswap_entry_put(tree, entry);
> > -       spin_unlock(&tree->lock);
> > -
> >         return ret;
> > -
> >  fail:
> >         if (!zpool_can_sleep_mapped(pool))
> >                 kfree(tmp);
> > @@ -1177,13 +1147,8 @@ static int zswap_writeback_entry(struct zpool *p=
ool, unsigned long handle)
> >         * if we get here due to ZSWAP_SWAPCACHE_EXIST
> >         * a load may be happening concurrently.
> >         * it is safe and okay to not free the entry.
> > -       * if we free the entry in the following put
> >         * it is also okay to return !0
> >         */
> > -       spin_lock(&tree->lock);
> > -       zswap_entry_put(tree, entry);
> > -       spin_unlock(&tree->lock);
> > -
> >         return ret;
> >  }
> >
> > --
> > 2.34.1
> >
