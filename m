Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39DF72A108
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFIROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFIROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:14:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27C30DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:14:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-974638ed5c5so439237366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686330848; x=1688922848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irF8UG41gNc2r+NiuknM+btwYq/8Tu2mwe3MOYybROA=;
        b=aoxLKl9t1Gnm6uAL7ty+aHvGKW+MEhSS4kh1d7InSDx0EvAEWEKKy01QuvYJfr6FYZ
         L2kn2GXJn2gKJcCyKUWp3AUoR/6JRrLv8BOeax/VRf4J8af6R3fzcPAEOVmAeMe2b07R
         J3d88W6KAkx9t7QQ4k48GMlcpEfafBaYLzRi2u1wwA1RkjvXu6pN91nq0Rql6mS2dsDL
         uq4WV+HomVP4p7/k6TwwPvoYBvRLdE3u6bogKU24MXkMkNL0UUQeWswfVWNS5q6Okrn1
         To2OCUpezzG5I40Sp/0SoiALA93As9eopwGrUpV3H6EhzLQMTpBgRJAUsmuBsfjqt7bx
         g3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330848; x=1688922848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irF8UG41gNc2r+NiuknM+btwYq/8Tu2mwe3MOYybROA=;
        b=GzOnQkOP8KOCNcKn7+Kd94As+/ci/mQoIwvbbKHZgDEBABfLEAtTv4W6ukAgaULR5W
         zFjZei6YczC52+3QQDJJMdGQR70Ek9Qf7d1PeUWJrMCRYXqTGnVpnGwDVZDw36Sqph8F
         ekKSwqx1JcOczU1Y6KiRyHlyrpHzUGQaA0+gKxoYNK8Zqq99qOmFZvwmZ/QOMpLh4kwy
         1drNgAZZRh4RS0i0ZfLssVMUW6Ek+Ork1D5KsaUJPOr4DLnGz0FFyLH983lC2KA5cUEh
         +VRjap4TbClYo2tfgXd2gdUkgu6yfgEfoby8DiXZlJw4yuNV87NP7YiJnt2yUFvKl8rI
         UJcw==
X-Gm-Message-State: AC+VfDyD72LJuIsSevz5WcqXNgnohlz+53fMMKRrXyCC3HVzLGhdv6mI
        UeRjyqH7dYZ4EksPKrdZdtCXxpe0QsgFP0YpvoQLDQ==
X-Google-Smtp-Source: ACHHUZ6bhL5+0gNXjGW0nBXE0Q0N1vk/IkgLvZHOZfbcLZtKv2HmC5T/gw3Hl8MPRh+BG6Ch4k83Rxf/DdHUO/eZPOM=
X-Received: by 2002:a17:906:794b:b0:973:ddfe:e074 with SMTP id
 l11-20020a170906794b00b00973ddfee074mr2737309ejo.2.1686330847658; Fri, 09 Jun
 2023 10:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-8-cerasuolodomenico@gmail.com> <CAJD7tkY2+PgCzViFEH2W3YefnrLx66HiN_MnkZg=usdt_E1Eqw@mail.gmail.com>
 <CA+CLi1hqak85ggshr55wVYoiGz9SwEnQqvN9gnJVGniaZHDOYw@mail.gmail.com>
In-Reply-To: <CA+CLi1hqak85ggshr55wVYoiGz9SwEnQqvN9gnJVGniaZHDOYw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 9 Jun 2023 10:13:31 -0700
Message-ID: <CAJD7tkbUYKD36tkm_i3C-N5qRMN4T9mxYSFbdoQeZnt3DP2d9A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] mm: zswap: remove zswap_header
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

On Fri, Jun 9, 2023 at 9:10=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 7, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > Previously, zswap_header served the purpose of storing the swpentry
> > > within zpool pages. This allowed zpool implementations to pass releva=
nt
> > > information to the writeback function. However, with the current
> > > implementation, writeback is directly handled within zswap.
> > > Consequently, there is no longer a necessity for zswap_header, as the
> > > swp_entry_t can be stored directly in zswap_entry.
> > >
> > > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Thanks for this cleanup. It gives us back some of the memory used by
> > list_head in zswap entry, and remove an unnecessary zpool map
> > operation.
> >
> > > ---
> > >  mm/zswap.c | 52 ++++++++++++++++++++++------------------------------
> > >  1 file changed, 22 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index ef8604812352..f689444dd5a7 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -193,7 +193,7 @@ struct zswap_pool {
> > >   */
> > >  struct zswap_entry {
> > >         struct rb_node rbnode;
> > > -       pgoff_t offset;
> > > +       swp_entry_t swpentry;
> > >         int refcount;
> > >         unsigned int length;
> > >         struct zswap_pool *pool;
> > > @@ -205,10 +205,6 @@ struct zswap_entry {
> > >         struct list_head lru;
> > >  };
> > >
> > > -struct zswap_header {
> > > -       swp_entry_t swpentry;
> > > -};
> > > -
> > >  /*
> > >   * The tree lock in the zswap_tree struct protects a few things:
> > >   * - the rbtree
> > > @@ -250,7 +246,7 @@ static bool zswap_has_pool;
> > >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> > >                  zpool_get_type((p)->zpool))
> > >
> > > -static int zswap_writeback_entry(struct zswap_entry *entry, struct z=
swap_header *zhdr,
> > > +static int zswap_writeback_entry(struct zswap_entry *entry,
> > >                                  struct zswap_tree *tree);
> > >  static int zswap_pool_get(struct zswap_pool *pool);
> > >  static void zswap_pool_put(struct zswap_pool *pool);
> > > @@ -311,12 +307,14 @@ static struct zswap_entry *zswap_rb_search(stru=
ct rb_root *root, pgoff_t offset)
> > >  {
> > >         struct rb_node *node =3D root->rb_node;
> > >         struct zswap_entry *entry;
> > > +       pgoff_t entry_offset;
> > >
> > >         while (node) {
> > >                 entry =3D rb_entry(node, struct zswap_entry, rbnode);
> > > -               if (entry->offset > offset)
> > > +               entry_offset =3D swp_offset(entry->swpentry);
> > > +               if (entry_offset > offset)
> > >                         node =3D node->rb_left;
> > > -               else if (entry->offset < offset)
> > > +               else if (entry_offset < offset)
> > >                         node =3D node->rb_right;
> > >                 else
> > >                         return entry;
> > > @@ -333,13 +331,15 @@ static int zswap_rb_insert(struct rb_root *root=
, struct zswap_entry *entry,
> > >  {
> > >         struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > >         struct zswap_entry *myentry;
> > > +       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->sw=
pentry);
> > >
> > >         while (*link) {
> > >                 parent =3D *link;
> > >                 myentry =3D rb_entry(parent, struct zswap_entry, rbno=
de);
> > > -               if (myentry->offset > entry->offset)
> > > +               myentry_offset =3D swp_offset(myentry->swpentry);
> > > +               if (myentry_offset > entry_offset)
> > >                         link =3D &(*link)->rb_left;
> > > -               else if (myentry->offset < entry->offset)
> > > +               else if (myentry_offset < entry_offset)
> >
> > This whole myentry thing is very confusing to me. I initially thought
> > myentry would be the entry passed in as an argument. Can we change the
> > naming here to make it more consistent with zswap_rb_search() naming?
> >
>
> I'm not sure I understood the suggestion, is it related to the addition o=
f
> myentry_offset variable or is myentry itself that you would like to chang=
e?

Just the variable naming myentry (which existed before your patch) and
myentry_offset is confusing, because (at least to me) they seem like
they refer to the argument, but they actually refer to the search
iterator. It's also inconsistent with the naming convention used in
zswap_rb_search().

It's just a nit though, don't overthink it :)

>
> > >                         link =3D &(*link)->rb_right;
> > >                 else {
> > >                         *dupentry =3D myentry;
> > > @@ -598,7 +598,6 @@ static struct zswap_pool *zswap_pool_find_get(cha=
r *type, char *compressor)
> > >  static int zswap_shrink(struct zswap_pool *pool)
> > >  {
> > >         struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > > -       struct zswap_header *zhdr;
> > >         struct zswap_tree *tree;
> > >         int swpoffset;
> > >         int ret;
> > > @@ -611,15 +610,13 @@ static int zswap_shrink(struct zswap_pool *pool=
)
> > >         }
> > >         lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry,=
 lru);
> > >         list_del_init(&lru_entry->lru);
> > > -       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPO=
OL_MM_RO);
> > > -       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > > -       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > >         /*
> > >          * Once the pool lock is dropped, the lru_entry might get fre=
ed. The
> > >          * swpoffset is copied to the stack, and lru_entry isn't dere=
f'd again
> > >          * until the entry is verified to still be alive in the tree.
> > >          */
> > > -       swpoffset =3D swp_offset(zhdr->swpentry);
> > > +       swpoffset =3D swp_offset(lru_entry->swpentry);
> > > +       tree =3D zswap_trees[swp_type(lru_entry->swpentry)];
> > >         spin_unlock(&pool->lru_lock);
> > >
> > >         /* hold a reference from tree so it won't be freed during wri=
teback */
> > > @@ -633,7 +630,7 @@ static int zswap_shrink(struct zswap_pool *pool)
> > >         }
> > >         spin_unlock(&tree->lock);
> > >
> > > -       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> > > +       ret =3D zswap_writeback_entry(lru_entry, tree);
> > >
> > >         spin_lock(&tree->lock);
> > >         if (ret) {
> > > @@ -1046,10 +1043,10 @@ static int zswap_get_swap_cache_page(swp_entr=
y_t entry,
> > >   * the swap cache, the compressed version stored by zswap can be
> > >   * freed.
> > >   */
> > > -static int zswap_writeback_entry(struct zswap_entry *entry, struct z=
swap_header *zhdr,
> > > +static int zswap_writeback_entry(struct zswap_entry *entry,
> > >                                  struct zswap_tree *tree)
> > >  {
> > > -       swp_entry_t swpentry =3D zhdr->swpentry;
> > > +       swp_entry_t swpentry =3D entry->swpentry;
> > >         struct page *page;
> > >         struct scatterlist input, output;
> > >         struct crypto_acomp_ctx *acomp_ctx;
> > > @@ -1089,7 +1086,7 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry, struct zswap_header
> > >                  * writing.
> > >                  */
> > >                 spin_lock(&tree->lock);
> > > -               if (zswap_rb_search(&tree->rbroot, entry->offset) !=
=3D entry) {
> > > +               if (zswap_rb_search(&tree->rbroot, swp_offset(entry->=
swpentry)) !=3D entry) {
> > >                         spin_unlock(&tree->lock);
> > >                         delete_from_swap_cache(page_folio(page));
> > >                         ret =3D -ENOMEM;
> > > @@ -1101,8 +1098,7 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry, struct zswap_header
> > >                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > >                 dlen =3D PAGE_SIZE;
> > >
> > > -               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_=
MM_RO);
> > > -               src =3D (u8 *)zhdr + sizeof(struct zswap_header);
> > > +               src =3D zpool_map_handle(pool, entry->handle, ZPOOL_M=
M_RO);
> > >                 if (!zpool_can_sleep_mapped(pool)) {
> > >                         memcpy(tmp, src, entry->length);
> > >                         src =3D tmp;
> > > @@ -1196,11 +1192,10 @@ static int zswap_frontswap_store(unsigned typ=
e, pgoff_t offset,
> > >         struct obj_cgroup *objcg =3D NULL;
> > >         struct zswap_pool *pool;
> > >         int ret;
> > > -       unsigned int hlen, dlen =3D PAGE_SIZE;
> > > +       unsigned int dlen =3D PAGE_SIZE;
> > >         unsigned long handle, value;
> > >         char *buf;
> > >         u8 *src, *dst;
> > > -       struct zswap_header zhdr =3D { .swpentry =3D swp_entry(type, =
offset) };
> > >         gfp_t gfp;
> > >
> > >         /* THP isn't supported */
> > > @@ -1245,7 +1240,7 @@ static int zswap_frontswap_store(unsigned type,=
 pgoff_t offset,
> > >                 src =3D kmap_atomic(page);
> > >                 if (zswap_is_page_same_filled(src, &value)) {
> > >                         kunmap_atomic(src);
> > > -                       entry->offset =3D offset;
> > > +                       entry->swpentry =3D swp_entry(type, offset);
> > >                         entry->length =3D 0;
> > >                         entry->value =3D value;
> > >                         atomic_inc(&zswap_same_filled_pages);
> > > @@ -1299,11 +1294,10 @@ static int zswap_frontswap_store(unsigned typ=
e, pgoff_t offset,
> > >         }
> > >
> > >         /* store */
> > > -       hlen =3D sizeof(zhdr);
> > >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> > >         if (zpool_malloc_support_movable(entry->pool->zpool))
> > >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > > -       ret =3D zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &h=
andle);
> > > +       ret =3D zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
> > >         if (ret =3D=3D -ENOSPC) {
> > >                 zswap_reject_compress_poor++;
> > >                 goto put_dstmem;
> > > @@ -1313,13 +1307,12 @@ static int zswap_frontswap_store(unsigned typ=
e, pgoff_t offset,
> > >                 goto put_dstmem;
> > >         }
> > >         buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM=
_WO);
> > > -       memcpy(buf, &zhdr, hlen);
> > > -       memcpy(buf + hlen, dst, dlen);
> > > +       memcpy(buf, dst, dlen);
> > >         zpool_unmap_handle(entry->pool->zpool, handle);
> > >         mutex_unlock(acomp_ctx->mutex);
> > >
> > >         /* populate entry */
> > > -       entry->offset =3D offset;
> > > +       entry->swpentry =3D swp_entry(type, offset);
> > >         entry->handle =3D handle;
> > >         entry->length =3D dlen;
> > >
> > > @@ -1418,7 +1411,6 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> > >         /* decompress */
> > >         dlen =3D PAGE_SIZE;
> > >         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, Z=
POOL_MM_RO);
> > > -       src +=3D sizeof(struct zswap_header);
> > >
> > >         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> > >                 memcpy(tmp, src, entry->length);
> > > --
> > > 2.34.1
> > >
