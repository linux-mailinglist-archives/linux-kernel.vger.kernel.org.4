Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6B73977D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFVGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:33:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85095
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:32:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-260a4020ebaso2913627a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687415578; x=1690007578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnXCS9HlHSWVmZGQQLXKESb1FrYUKFPp5xcZutPyndo=;
        b=WvEiEoTHBp8pgpKlLGnYz+e2z/Xmu06WRhAxqfsSacSkoiLiGK1I9e/KwlhQLzIcSL
         J5/teIkVdGLZ0eyrldV76c2ahkqSkDxGLX7zdD83bRrQFoNZ//WlqgvHJ8oi07/Ehkyt
         oHvseqFA/Qk3NxRkDGmb5y45pilex4etW1tyJSmaRT1mPbcFjWkVnL3nYvcBwtFRZtYm
         f6OiIlMiera6JGMRmXtee0oSrtJ5CqR1Za5zynoB6l9nmoDC/vqg/W4aIMiadxYbW4XD
         jrEz/vcy+nUaSBobWSgPbOlMCFJGGOoHhVpVfK+K7RKlhbKMJ0C/PdQhqME8yc/+Gz+7
         QmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415578; x=1690007578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnXCS9HlHSWVmZGQQLXKESb1FrYUKFPp5xcZutPyndo=;
        b=irwQ1bSfZZTunUiBHJM2fXU/QFB8cmPLX8Ubpx3vVya4um9ddK1tWhfvnadVVGz3i9
         IqGGmtOS7ontcvkEXYL4fZCQYSU4P4PDDANr5wXSdyxaXNzNW672lYop2tlE3hcI9Kc5
         oNAG8OmjIqxlIAc3q9f+V7rZKbHvuthS41+CLXSyrATFMraxKOD70VJhIKg4mmo+XAiK
         pidxrwxMDV/TdhqesAKcxwA7ALjZKphrItUyUjhJtyKr+Yrr+xfiGP0sT342QWD947D3
         oRmakPDDPeL9iWD5Ib4x+3Z4NUiO6mTayyfzNPkKg1o5EGZoVhLUmpZDwHDZEICYbotJ
         gD6w==
X-Gm-Message-State: AC+VfDzRYE4dzaroGz+sTt5Pzi73wFN6DFfQRyCagN1GTvoq7RYBGP89
        kN+BHK2vQHi2yavRTv5/qwaeHcJJFipGNy+p0M2qCRRKM3e42A==
X-Google-Smtp-Source: ACHHUZ4y6NoH6E6X9P7fPZPPpYvbQzD1QNv/EeyZqHGma+Q2Q3263VA7mheJntUALZaZ6K2a4TM5vmEFEIq5hhjER1c=
X-Received: by 2002:a17:90a:8984:b0:25b:e766:6c40 with SMTP id
 v4-20020a17090a898400b0025be7666c40mr18070652pjn.20.1687415578054; Wed, 21
 Jun 2023 23:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093009.637544-1-yosryahmed@google.com>
 <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com>
 <CAJD7tkYGz3A3-mkzbZBfoHX5gATPseqiwZon0i3rug2h2M3jyg@mail.gmail.com>
 <CA+CLi1hPfvy_kJyi8N6ygNhY9hNH5J6-kN9i1pRZz76dX5b0Lg@mail.gmail.com> <CAJD7tkY3hQpPiWo5mJgvHPgObFdgTJqsTBq_H4c5kMF4F4qGpQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY3hQpPiWo5mJgvHPgObFdgTJqsTBq_H4c5kMF4F4qGpQ@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Thu, 22 Jun 2023 08:32:46 +0200
Message-ID: <CA+CLi1jZAqfjvDiWcQKJ_R02110Zyk=t2nyov2BCZnVm0B3muQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix double invalidate with exclusive loads
To:     Yosry Ahmed <yosryahmed@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jun 21, 2023 at 12:36=E2=80=AFPM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 7:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Wed, Jun 21, 2023 at 3:20=E2=80=AFAM Domenico Cerasuolo
> > > <cerasuolodomenico@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 21, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@go=
ogle.com> wrote:
> > > > >
> > > > > If exclusive loads are enabled for zswap, we invalidate the entry=
 before
> > > > > returning from zswap_frontswap_load(), after dropping the local
> > > > > reference. However, the tree lock is dropped during decompression=
 after
> > > > > the local reference is acquired, so the entry could be invalidate=
d
> > > > > before we drop the local ref. If this happens, the entry is freed=
 once
> > > > > we drop the local ref, and zswap_invalidate_entry() tries to inva=
lidate
> > > > > an already freed entry.
> > > > >
> > > > > Fix this by:
> > > > > (a) Making sure zswap_invalidate_entry() is always called with a =
local
> > > > >     ref held, to avoid being called on a freed entry.
> > > > > (b) Making sure zswap_invalidate_entry() only drops the ref if th=
e entry
> > > > >     was actually on the rbtree. Otherwise, another invalidation c=
ould
> > > > >     have already happened, and the initial ref is already dropped=
.
> > > > >
> > > > > With these changes, there is no need to check that there is no ne=
ed to
> > > > > make sure the entry still exists in the tree in zswap_reclaim_ent=
ry()
> > > > > before invalidating it, as zswap_reclaim_entry() will make this c=
heck
> > > > > internally.
> > > > >
> > > > > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > > > > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > ---
> > > > >  mm/zswap.c | 21 ++++++++++++---------
> > > > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index 87b204233115..62195f72bf56 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *=
root, struct zswap_entry *entry,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static void zswap_rb_erase(struct rb_root *root, struct zswap_en=
try *entry)
> > > > > +static bool zswap_rb_erase(struct rb_root *root, struct zswap_en=
try *entry)
> > > > >  {
> > > > >         if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > > > >                 rb_erase(&entry->rbnode, root);
> > > > >                 RB_CLEAR_NODE(&entry->rbnode);
> > > > > +               return true;
> > > > >         }
> > > > > +       return false;
> > > > >  }
> > > > >
> > > > >  /*
> > > > > @@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find_g=
et(char *type, char *compressor)
> > > > >         return NULL;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * If the entry is still valid in the tree, drop the initial ref=
 and remove it
> > > > > + * from the tree. This function must be called with an additiona=
l ref held,
> > > > > + * otherwise it may race with another invalidation freeing the e=
ntry.
> > > > > + */
> > > >
> > > > On re-reading this comment there's one thing I'm not sure I get, do=
 we
> > > > really need to hold an additional local ref to call this? As far as=
 I
> > > > understood, once we check that the entry was in the tree before put=
ting
> > > > the initial ref, there's no need for an additional local one.
> > >
> > > I believe it is, but please correct me if I am wrong. Consider the
> > > following scenario:
> > >
> > > // Initially refcount is at 1
> > >
> > > CPU#1:                                  CPU#2:
> > > spin_lock(tree_lock)
> > > zswap_entry_get() // 2 refs
> > > spin_unlock(tree_lock)
> > >                                             spin_lock(tree_lock)
> > >                                             zswap_invalidate_entry() =
// 1 ref
> > >                                             spin_unlock(tree_lock)
> > > zswap_entry_put() // 0 refs
> > > zswap_invalidate_entry() // problem
> > >
> > > That last zswap_invalidate_entry() call in CPU#1 is problematic. The
> > > entry would have already been freed. If we check that the entry is on
> > > the tree by checking RB_EMPTY_NODE(&entry->rbnode), then we are
> > > reading already freed and potentially re-used memory.
> > >
> > > We would need to search the tree to make sure the same entry still
> > > exists in the tree (aka what zswap_reclaim_entry() currently does).
> > > This is not ideal in the fault path to have to do the lookups twice.
> >
> > Thanks for the clarification, it is indeed needed in that case. I was j=
ust
> > wondering if the wording of the comment is exact, in that before callin=
g
> > zswap_invalidate_entry one has to ensure that the entry has not been fr=
eed, not
> > specifically by holding an additional reference, if a lookup can serve =
the same
> > purpose.
>
>
> I am wondering if the scenario below is possible, in which case a
> lookup would not be enough. Let me try to clarify. Let's assume in
> zswap_reclaim_entry() we drop the local ref early (before we
> invalidate the entry), and rely on the lookup to ensure that the entry
> was not freed:
>
> - On CPU#1, in zswap_reclaim_entry() we release the lock during IO.
> Let's assume we drop the local ref here and rely on the lookup to make
> sure the zswap entry wasn't freed.
> - On CPU#2, invalidates the swap entry. The zswap entry is freed
> (returned to the slab allocator).
> - On CPU#2, we try to reclaim another page, and allocates the same
> swap slot (same type and offset).
> - On CPU#2, a zswap entry is allocated, and the slab allocator happens
> to hand us the same zswap_entry we just freed.
> - On CPU#1, after IO is done, we lookup the tree to make sure that the
> zswap entry was not freed. We find the same zswap entry (same address)
> at the same offset, so we assume it was not freed.
> - On CPU#1, we invalidate the zswap entry that was actually used by CPU#2=
.
>
> I am not entirely sure if this is possible, perhaps locking in the
> swap layer will prevent the swap entry reuse, but it seems like
> relying on the lookup can be fragile, and we should rely on the local
> ref instead to reliably prevent freeing/reuse of the zswap entry.
>
> Please correct me if I missed something.

I think it is, we definitely need an additional reference to pin down the e=
ntry.
Sorry if I was being pedantic, my original doubt was only about the wording=
 of
the comment, where it says that an additional reference must be held. I was
wondering if it was strictly needed, and now I see that it is :)

>
> >
> >
> > >
> > > Also, in zswap_reclaim_entry(), would it be possible if we call
> > > zswap_invalidate_entry() after we drop the local ref that the swap
> > > entry has been reused for a different page? I didn't look closely, bu=
t
> > > if yes, then the slab allocator may have repurposed the zswap_entry
> > > and we may find the entry in the tree for the same offset, even thoug=
h
> > > it is referring to a different page now. This sounds practically
> > > unlikely but perhaps theoretically possible.
> >
> > I'm not sure I understood the scenario, in zswap_reclaim_entry we keep =
a local
> > reference until the end in order to avoid a free.
>
>
> Right, I was just trying to reason about what might happen if we call
> zswap_invalidate_entry() after dropping the local ref, as I mentioned
> above.
>
>
> >
> >
> > >
> > > I think it's more reliable to call zswap_invalidate_entry() on an
> > > entry that we know is valid before dropping the local ref. Especially
> > > that it's easy to do today by just moving a few lines around.
> > >
> > >
> > >
> > >
> > > >
> > > > >  static void zswap_invalidate_entry(struct zswap_tree *tree,
> > > > >                                    struct zswap_entry *entry)
> > > > >  {
> > > > > -       /* remove from rbtree */
> > > > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > > > -
> > > > > -       /* drop the initial reference from entry creation */
> > > > > -       zswap_entry_put(tree, entry);
> > > > > +       if (zswap_rb_erase(&tree->rbroot, entry))
> > > > > +               zswap_entry_put(tree, entry);
> > > > >  }
> > > > >
> > > > >  static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > > > @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_p=
ool *pool)
> > > > >          * swapcache. Drop the entry from zswap - unless invalida=
te already
> > > > >          * took it out while we had the tree->lock released for I=
O.
> > > > >          */
> > > > > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffset=
))
> > > > > -               zswap_invalidate_entry(tree, entry);
> > > > > +       zswap_invalidate_entry(tree, entry);
> > > > >
> > > > >  put_unlock:
> > > > >         /* Drop local reference */
> > > > > @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned ty=
pe, pgoff_t offset,
> > > > >                 count_objcg_event(entry->objcg, ZSWPIN);
> > > > >  freeentry:
> > > > >         spin_lock(&tree->lock);
> > > > > -       zswap_entry_put(tree, entry);
> > > > >         if (!ret && zswap_exclusive_loads_enabled) {
> > > > >                 zswap_invalidate_entry(tree, entry);
> > > > >                 *exclusive =3D true;
> > > > > @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned ty=
pe, pgoff_t offset,
> > > > >                 list_move(&entry->lru, &entry->pool->lru);
> > > > >                 spin_unlock(&entry->pool->lru_lock);
> > > > >         }
> > > > > +       zswap_entry_put(tree, entry);
> > > > >         spin_unlock(&tree->lock);
> > > > >
> > > > >         return ret;
> > > > > --
> > > > > 2.41.0.162.gfafddb0af9-goog
> > > > >

Reviewed-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
