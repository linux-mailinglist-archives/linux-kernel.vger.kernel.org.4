Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2C738D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFUR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFUR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:26:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2B1B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:26:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-978863fb00fso937137666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687368414; x=1689960414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzH3xxs939UBNL4aqrrmjpjc/lWuYbheLSA3AXtGpAg=;
        b=U48DiOe3RGCz38+m6dovOMUxSOBvRoB5xG6FRedeM+Y77S1Qozx4Bk+b6y95EMHbbA
         BgUs/F9k/noM8PU3mMcorVTEaE3DayDl5WKc82As3BDym0Uivt7nKRtY47ydWfdFRosc
         z60gcJyGLZQfr/3369tLnqxE/WRwT5ZJMK2IBXFWxY2A9KAJ9cncSBzd0vWGh6UJGP/k
         6v6IbS6OwW32JsfcN0rp/2MO9wfbGfAeCzA9tzF2C9J9scdYEk6iTm4gaq5t62KLMSqc
         EZ7plCqijnzJQ78YQYachTuMoQqt0+Yv5DHD7NmfVRBzVWJRlC0++O8PmQqUXPrGHaq4
         y6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368414; x=1689960414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzH3xxs939UBNL4aqrrmjpjc/lWuYbheLSA3AXtGpAg=;
        b=S+lXlcj97O7kDO1k0rXfQiNFiZv/uXM+0oL2PPk9WaXYmwodrMg0/mzl6CS91oSp+I
         a/IWasvDLIakprD9t37u6rIzJfcSXN3yfzftQLUzHyAMXWvCZaIojKlkPlMPG4TF4o8g
         CISHgjdfKzGkjYyYG3xTs8L2q7zN+bv84MR/Rz+Kur2nY0zX6sZsqk0OgI7riUKX1Zwr
         iGOBEgpUezzlDfdA6tohap5zh3PpRZmjo9+2lVqkdZ3NLwwjJ13Utr2SpfF2rx+JcWt/
         fVy5ggB34vJ7VVMK3717lEUjiIfUcggC2QJRRb+c0w5YeE2pB5HXbPW57cHFUbvD/m3b
         BGfA==
X-Gm-Message-State: AC+VfDz5H1RO3K0qdAWQ7K5LS+1f1cfaJbnOGNp6GqzFdNqxdszKVPY4
        MHEWHIQaYoyoKS4pn1xaB5sQIi0n8pq6u6sxd+r23w==
X-Google-Smtp-Source: ACHHUZ5o+curCNGwadyHRfyuJGoR8Q+Y2lSWnmjqhliqrOVHbGZG9d/Y7iEc7lfewfryEG2c3SNw131g9ccPwD7PPH0=
X-Received: by 2002:a17:907:708:b0:97b:956f:e6b5 with SMTP id
 xb8-20020a170907070800b0097b956fe6b5mr14291606ejb.23.1687368413654; Wed, 21
 Jun 2023 10:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093009.637544-1-yosryahmed@google.com> <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com>
In-Reply-To: <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 21 Jun 2023 10:26:17 -0700
Message-ID: <CAJD7tkYGz3A3-mkzbZBfoHX5gATPseqiwZon0i3rug2h2M3jyg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix double invalidate with exclusive loads
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 21, 2023 at 3:20=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > If exclusive loads are enabled for zswap, we invalidate the entry befor=
e
> > returning from zswap_frontswap_load(), after dropping the local
> > reference. However, the tree lock is dropped during decompression after
> > the local reference is acquired, so the entry could be invalidated
> > before we drop the local ref. If this happens, the entry is freed once
> > we drop the local ref, and zswap_invalidate_entry() tries to invalidate
> > an already freed entry.
> >
> > Fix this by:
> > (a) Making sure zswap_invalidate_entry() is always called with a local
> >     ref held, to avoid being called on a freed entry.
> > (b) Making sure zswap_invalidate_entry() only drops the ref if the entr=
y
> >     was actually on the rbtree. Otherwise, another invalidation could
> >     have already happened, and the initial ref is already dropped.
> >
> > With these changes, there is no need to check that there is no need to
> > make sure the entry still exists in the tree in zswap_reclaim_entry()
> > before invalidating it, as zswap_reclaim_entry() will make this check
> > internally.
> >
> > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 87b204233115..62195f72bf56 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *root, =
struct zswap_entry *entry,
> >         return 0;
> >  }
> >
> > -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *e=
ntry)
> > +static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *e=
ntry)
> >  {
> >         if (!RB_EMPTY_NODE(&entry->rbnode)) {
> >                 rb_erase(&entry->rbnode, root);
> >                 RB_CLEAR_NODE(&entry->rbnode);
> > +               return true;
> >         }
> > +       return false;
> >  }
> >
> >  /*
> > @@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find_get(cha=
r *type, char *compressor)
> >         return NULL;
> >  }
> >
> > +/*
> > + * If the entry is still valid in the tree, drop the initial ref and r=
emove it
> > + * from the tree. This function must be called with an additional ref =
held,
> > + * otherwise it may race with another invalidation freeing the entry.
> > + */
>
> On re-reading this comment there's one thing I'm not sure I get, do we
> really need to hold an additional local ref to call this? As far as I
> understood, once we check that the entry was in the tree before putting
> the initial ref, there's no need for an additional local one.

I believe it is, but please correct me if I am wrong. Consider the
following scenario:

// Initially refcount is at 1

CPU#1:                                  CPU#2:
spin_lock(tree_lock)
zswap_entry_get() // 2 refs
spin_unlock(tree_lock)
                                            spin_lock(tree_lock)
                                            zswap_invalidate_entry() // 1 r=
ef
                                            spin_unlock(tree_lock)
zswap_entry_put() // 0 refs
zswap_invalidate_entry() // problem

That last zswap_invalidate_entry() call in CPU#1 is problematic. The
entry would have already been freed. If we check that the entry is on
the tree by checking RB_EMPTY_NODE(&entry->rbnode), then we are
reading already freed and potentially re-used memory.

We would need to search the tree to make sure the same entry still
exists in the tree (aka what zswap_reclaim_entry() currently does).
This is not ideal in the fault path to have to do the lookups twice.

Also, in zswap_reclaim_entry(), would it be possible if we call
zswap_invalidate_entry() after we drop the local ref that the swap
entry has been reused for a different page? I didn't look closely, but
if yes, then the slab allocator may have repurposed the zswap_entry
and we may find the entry in the tree for the same offset, even though
it is referring to a different page now. This sounds practically
unlikely but perhaps theoretically possible.

I think it's more reliable to call zswap_invalidate_entry() on an
entry that we know is valid before dropping the local ref. Especially
that it's easy to do today by just moving a few lines around.




>
> >  static void zswap_invalidate_entry(struct zswap_tree *tree,
> >                                    struct zswap_entry *entry)
> >  {
> > -       /* remove from rbtree */
> > -       zswap_rb_erase(&tree->rbroot, entry);
> > -
> > -       /* drop the initial reference from entry creation */
> > -       zswap_entry_put(tree, entry);
> > +       if (zswap_rb_erase(&tree->rbroot, entry))
> > +               zswap_entry_put(tree, entry);
> >  }
> >
> >  static int zswap_reclaim_entry(struct zswap_pool *pool)
> > @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_pool *p=
ool)
> >          * swapcache. Drop the entry from zswap - unless invalidate alr=
eady
> >          * took it out while we had the tree->lock released for IO.
> >          */
> > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffset))
> > -               zswap_invalidate_entry(tree, entry);
> > +       zswap_invalidate_entry(tree, entry);
> >
> >  put_unlock:
> >         /* Drop local reference */
> > @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >                 count_objcg_event(entry->objcg, ZSWPIN);
> >  freeentry:
> >         spin_lock(&tree->lock);
> > -       zswap_entry_put(tree, entry);
> >         if (!ret && zswap_exclusive_loads_enabled) {
> >                 zswap_invalidate_entry(tree, entry);
> >                 *exclusive =3D true;
> > @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
> >                 list_move(&entry->lru, &entry->pool->lru);
> >                 spin_unlock(&entry->pool->lru_lock);
> >         }
> > +       zswap_entry_put(tree, entry);
> >         spin_unlock(&tree->lock);
> >
> >         return ret;
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
