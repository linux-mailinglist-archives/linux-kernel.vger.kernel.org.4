Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CF729FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbjFIQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbjFIQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:10:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF430D6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:10:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fe2275249so717487a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686327031; x=1688919031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xf7h0zanPU7RP4mw4sRoD1obtR31kMVuJjEw28C5Zc=;
        b=MYXR4t4bQ6Q6ykWWgrrXWkKphdndwX5GLUnhW7IlvTzJfMlen+SGjlGv0Zq/xJtrql
         yNCR+Wy/rnwVPrEvELzp6IXCA42XNIEKBHwnhjUoXyEs7gdvHyxZTjJn7TXBFIv7BmKa
         v7+ihCJLiOnKyIE5vE+ZYtVv6mD+1cTAsjE5l/3Q6orG4LTWVZJoMBD8FV1MfPBNxQL+
         gEeQIu7gWrFtunHawNuh49U1jnNXnlVlirdL4gbpTim1NFQgr+jfWnsojtaEr2B2b8/h
         M2ddJUvXsFH+wtGExx7x4gp5tehc0pxf02IzhsZDGZAjasU/YWzgPvAgLsADD758EY34
         fxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327031; x=1688919031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xf7h0zanPU7RP4mw4sRoD1obtR31kMVuJjEw28C5Zc=;
        b=XEPh+MmoJzS0CmJSv5xJx1Bd8YMK8XrDCgRgLYl0aZtnTM9dUtikXMSWQV6yfPnGqB
         ptydoOgFozfbvU1vOcfZ1NONjiua7kEi+YvAwFdJLjfYMgyjM2icxzQRdC6QY6AMv7gu
         qSnPSFflxojewTCOcxx28DJ/UWDS+TF7oYYesfZ69VwsG7HtLsazXyCOKB1cdrZPTZkn
         sj3CPR6ATA3avsEQiywPqcbvtx2ZZAVf+p9wLkMe412Z/kUNDdE9qgNONCuFCBXWWmyH
         fRt7vzmb6w0US5Ss9fd+69rYh/uKFGoFUN4W+sKK3SAGH+Gave3OSqsAmzMG959m/w/w
         QM/w==
X-Gm-Message-State: AC+VfDxRcMr0nEuTwtMLDXyNAEzf3+qr3kuE+y0jMHfHRD8OINRxmqXL
        wQpX40S/Y2GHA4PMeGCog0qqUO5z+JG+rPTwym8=
X-Google-Smtp-Source: ACHHUZ4ZbTGeErjhBqrch8kFu94kU/OqJlwNBstcHCUevv3lNGpmGAnVKZSSsdwnjbOzDGs5lHXI8iPw97XstzUBwxY=
X-Received: by 2002:a17:90a:1a0a:b0:246:85ec:d816 with SMTP id
 10-20020a17090a1a0a00b0024685ecd816mr1373221pjk.3.1686327031007; Fri, 09 Jun
 2023 09:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-8-cerasuolodomenico@gmail.com> <CAJD7tkY2+PgCzViFEH2W3YefnrLx66HiN_MnkZg=usdt_E1Eqw@mail.gmail.com>
In-Reply-To: <CAJD7tkY2+PgCzViFEH2W3YefnrLx66HiN_MnkZg=usdt_E1Eqw@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Fri, 9 Jun 2023 18:10:19 +0200
Message-ID: <CA+CLi1hqak85ggshr55wVYoiGz9SwEnQqvN9gnJVGniaZHDOYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] mm: zswap: remove zswap_header
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

On Wed, Jun 7, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > Previously, zswap_header served the purpose of storing the swpentry
> > within zpool pages. This allowed zpool implementations to pass relevant
> > information to the writeback function. However, with the current
> > implementation, writeback is directly handled within zswap.
> > Consequently, there is no longer a necessity for zswap_header, as the
> > swp_entry_t can be stored directly in zswap_entry.
> >
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Thanks for this cleanup. It gives us back some of the memory used by
> list_head in zswap entry, and remove an unnecessary zpool map
> operation.
>
> > ---
> >  mm/zswap.c | 52 ++++++++++++++++++++++------------------------------
> >  1 file changed, 22 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index ef8604812352..f689444dd5a7 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -193,7 +193,7 @@ struct zswap_pool {
> >   */
> >  struct zswap_entry {
> >         struct rb_node rbnode;
> > -       pgoff_t offset;
> > +       swp_entry_t swpentry;
> >         int refcount;
> >         unsigned int length;
> >         struct zswap_pool *pool;
> > @@ -205,10 +205,6 @@ struct zswap_entry {
> >         struct list_head lru;
> >  };
> >
> > -struct zswap_header {
> > -       swp_entry_t swpentry;
> > -};
> > -
> >  /*
> >   * The tree lock in the zswap_tree struct protects a few things:
> >   * - the rbtree
> > @@ -250,7 +246,7 @@ static bool zswap_has_pool;
> >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> >                  zpool_get_type((p)->zpool))
> >
> > -static int zswap_writeback_entry(struct zswap_entry *entry, struct zsw=
ap_header *zhdr,
> > +static int zswap_writeback_entry(struct zswap_entry *entry,
> >                                  struct zswap_tree *tree);
> >  static int zswap_pool_get(struct zswap_pool *pool);
> >  static void zswap_pool_put(struct zswap_pool *pool);
> > @@ -311,12 +307,14 @@ static struct zswap_entry *zswap_rb_search(struct=
 rb_root *root, pgoff_t offset)
> >  {
> >         struct rb_node *node =3D root->rb_node;
> >         struct zswap_entry *entry;
> > +       pgoff_t entry_offset;
> >
> >         while (node) {
> >                 entry =3D rb_entry(node, struct zswap_entry, rbnode);
> > -               if (entry->offset > offset)
> > +               entry_offset =3D swp_offset(entry->swpentry);
> > +               if (entry_offset > offset)
> >                         node =3D node->rb_left;
> > -               else if (entry->offset < offset)
> > +               else if (entry_offset < offset)
> >                         node =3D node->rb_right;
> >                 else
> >                         return entry;
> > @@ -333,13 +331,15 @@ static int zswap_rb_insert(struct rb_root *root, =
struct zswap_entry *entry,
> >  {
> >         struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> >         struct zswap_entry *myentry;
> > +       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpe=
ntry);
> >
> >         while (*link) {
> >                 parent =3D *link;
> >                 myentry =3D rb_entry(parent, struct zswap_entry, rbnode=
);
> > -               if (myentry->offset > entry->offset)
> > +               myentry_offset =3D swp_offset(myentry->swpentry);
> > +               if (myentry_offset > entry_offset)
> >                         link =3D &(*link)->rb_left;
> > -               else if (myentry->offset < entry->offset)
> > +               else if (myentry_offset < entry_offset)
>
> This whole myentry thing is very confusing to me. I initially thought
> myentry would be the entry passed in as an argument. Can we change the
> naming here to make it more consistent with zswap_rb_search() naming?
>

I'm not sure I understood the suggestion, is it related to the addition of
myentry_offset variable or is myentry itself that you would like to change?

> >                         link =3D &(*link)->rb_right;
> >                 else {
> >                         *dupentry =3D myentry;
> > @@ -598,7 +598,6 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
> >  static int zswap_shrink(struct zswap_pool *pool)
> >  {
> >         struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > -       struct zswap_header *zhdr;
> >         struct zswap_tree *tree;
> >         int swpoffset;
> >         int ret;
> > @@ -611,15 +610,13 @@ static int zswap_shrink(struct zswap_pool *pool)
> >         }
> >         lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, l=
ru);
> >         list_del_init(&lru_entry->lru);
> > -       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL=
_MM_RO);
> > -       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > -       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> >         /*
> >          * Once the pool lock is dropped, the lru_entry might get freed=
. The
> >          * swpoffset is copied to the stack, and lru_entry isn't deref'=
d again
> >          * until the entry is verified to still be alive in the tree.
> >          */
> > -       swpoffset =3D swp_offset(zhdr->swpentry);
> > +       swpoffset =3D swp_offset(lru_entry->swpentry);
> > +       tree =3D zswap_trees[swp_type(lru_entry->swpentry)];
> >         spin_unlock(&pool->lru_lock);
> >
> >         /* hold a reference from tree so it won't be freed during write=
back */
> > @@ -633,7 +630,7 @@ static int zswap_shrink(struct zswap_pool *pool)
> >         }
> >         spin_unlock(&tree->lock);
> >
> > -       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> > +       ret =3D zswap_writeback_entry(lru_entry, tree);
> >
> >         spin_lock(&tree->lock);
> >         if (ret) {
> > @@ -1046,10 +1043,10 @@ static int zswap_get_swap_cache_page(swp_entry_=
t entry,
> >   * the swap cache, the compressed version stored by zswap can be
> >   * freed.
> >   */
> > -static int zswap_writeback_entry(struct zswap_entry *entry, struct zsw=
ap_header *zhdr,
> > +static int zswap_writeback_entry(struct zswap_entry *entry,
> >                                  struct zswap_tree *tree)
> >  {
> > -       swp_entry_t swpentry =3D zhdr->swpentry;
> > +       swp_entry_t swpentry =3D entry->swpentry;
> >         struct page *page;
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> > @@ -1089,7 +1086,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry, struct zswap_header
> >                  * writing.
> >                  */
> >                 spin_lock(&tree->lock);
> > -               if (zswap_rb_search(&tree->rbroot, entry->offset) !=3D =
entry) {
> > +               if (zswap_rb_search(&tree->rbroot, swp_offset(entry->sw=
pentry)) !=3D entry) {
> >                         spin_unlock(&tree->lock);
> >                         delete_from_swap_cache(page_folio(page));
> >                         ret =3D -ENOMEM;
> > @@ -1101,8 +1098,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry, struct zswap_header
> >                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >                 dlen =3D PAGE_SIZE;
> >
> > -               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM=
_RO);
> > -               src =3D (u8 *)zhdr + sizeof(struct zswap_header);
> > +               src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_=
RO);
> >                 if (!zpool_can_sleep_mapped(pool)) {
> >                         memcpy(tmp, src, entry->length);
> >                         src =3D tmp;
> > @@ -1196,11 +1192,10 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> >         struct obj_cgroup *objcg =3D NULL;
> >         struct zswap_pool *pool;
> >         int ret;
> > -       unsigned int hlen, dlen =3D PAGE_SIZE;
> > +       unsigned int dlen =3D PAGE_SIZE;
> >         unsigned long handle, value;
> >         char *buf;
> >         u8 *src, *dst;
> > -       struct zswap_header zhdr =3D { .swpentry =3D swp_entry(type, of=
fset) };
> >         gfp_t gfp;
> >
> >         /* THP isn't supported */
> > @@ -1245,7 +1240,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >                 src =3D kmap_atomic(page);
> >                 if (zswap_is_page_same_filled(src, &value)) {
> >                         kunmap_atomic(src);
> > -                       entry->offset =3D offset;
> > +                       entry->swpentry =3D swp_entry(type, offset);
> >                         entry->length =3D 0;
> >                         entry->value =3D value;
> >                         atomic_inc(&zswap_same_filled_pages);
> > @@ -1299,11 +1294,10 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> >         }
> >
> >         /* store */
> > -       hlen =3D sizeof(zhdr);
> >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >         if (zpool_malloc_support_movable(entry->pool->zpool))
> >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > -       ret =3D zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &han=
dle);
> > +       ret =3D zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
> >         if (ret =3D=3D -ENOSPC) {
> >                 zswap_reject_compress_poor++;
> >                 goto put_dstmem;
> > @@ -1313,13 +1307,12 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> >                 goto put_dstmem;
> >         }
> >         buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_W=
O);
> > -       memcpy(buf, &zhdr, hlen);
> > -       memcpy(buf + hlen, dst, dlen);
> > +       memcpy(buf, dst, dlen);
> >         zpool_unmap_handle(entry->pool->zpool, handle);
> >         mutex_unlock(acomp_ctx->mutex);
> >
> >         /* populate entry */
> > -       entry->offset =3D offset;
> > +       entry->swpentry =3D swp_entry(type, offset);
> >         entry->handle =3D handle;
> >         entry->length =3D dlen;
> >
> > @@ -1418,7 +1411,6 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >         /* decompress */
> >         dlen =3D PAGE_SIZE;
> >         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPO=
OL_MM_RO);
> > -       src +=3D sizeof(struct zswap_header);
> >
> >         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> >                 memcpy(tmp, src, entry->length);
> > --
> > 2.34.1
> >
