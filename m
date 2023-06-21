Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DC7381B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFUJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFUJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:19:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240F19A5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:19:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25eb777c7f2so2443085a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687339142; x=1689931142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG46ChCK+BwfP68y/KI81ahnd53s4HpMp6bIweLRvmo=;
        b=UsJVwK9XgNJyoTnbXVkKVlaTZi1ATL7zgAzLxoTk9o8k/ED17vxHDscITHgoHs6//F
         0QlHmOuCfBH+enSBNnvn78cEnEqZAzQX9oQVoblE6/re4T4LWZ/0RFtLvFgkb7E3falJ
         eYozQOzUWsYKBoa231vF/wpDycEU01iKR5syBTUXmIrhWI+NmBnQccW4BfTT7Rfuac4K
         VW9YFskP8Lhe2tXHFx9xgjtJIyJb13D2t2RmnNjOWcnt6zxBbcT1gAOqtxPurnR3hnCz
         2FiwemCr9RY5qyQGEyrsX29Yt4NvqL+oNHi0YX1vAzdR0CfCgBX8cZxfsF0KEHTu1/hT
         lzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339142; x=1689931142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG46ChCK+BwfP68y/KI81ahnd53s4HpMp6bIweLRvmo=;
        b=GM2Jfi0fX1yPfA9pNy8S7/8FErTrAAGXwKAxKWm9bkm5ATN7Lg2JxOlUgIzcDPrt/f
         ir0HaMP33Ol5P0pGy0pbjVpnz2+v/301HJzGJ00VrRHzZZyI8o2hmB7kRoCcgxDkiIuK
         1lN7zpEpbznZEYngvW4qLkY9kvhjoXxRMNt0UU1j3u3jk8XB5n+tSVDE/Adyk2GFq56A
         aBB29tENTctHdiRnYG7dNsEYJv/y3fNoa1bVScUoOyQjhxWctz0xaUd24k/T/RXRCd6z
         +MHC643sXT2KQEnPZmD0hAsPgR5KJhX6oz7yH17C8zVyQTd5Sn7dEKS4oJSalkV83GfM
         yecw==
X-Gm-Message-State: AC+VfDz5AFL7I2jV2BK6J7m7vGnLSosE6Ln2BFoOaoF1wfiXVt+/0UCH
        l1z+HP2nUpDraK0IsdqoABdrFuqYCJYiFyNzX3k=
X-Google-Smtp-Source: ACHHUZ7A0sTZuMdN04LlG0KEWoMuNP0IS/Mj6i9rchT/ZccWposruguveBaa5vSLzQ3FrOHWCh2P1RjxoNK/NMx0sIw=
X-Received: by 2002:a17:90b:11c7:b0:24b:2fc1:8a9c with SMTP id
 gv7-20020a17090b11c700b0024b2fc18a9cmr8961892pjb.11.1687339141972; Wed, 21
 Jun 2023 02:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230607195143.1473802-1-yosryahmed@google.com>
 <ZJKgThENoFlkJQmB@fedora> <CAJD7tkYEZEihcQFVrb5KR18r6o5496uXSRJbDrs+woGHwv6zWg@mail.gmail.com>
In-Reply-To: <CAJD7tkYEZEihcQFVrb5KR18r6o5496uXSRJbDrs+woGHwv6zWg@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Wed, 21 Jun 2023 11:18:50 +0200
Message-ID: <CA+CLi1hxowDTfK6DNRN5SBp_wktpCdQTjU7CtS4E6h0nZJkV6w@mail.gmail.com>
Subject: Re: [BUG mm-unstable] "kernel BUG at mm/swap.c:393!" on commit b9c91c43412f2e
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Jun 21, 2023 at 10:06=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Wed, Jun 21, 2023 at 12:01=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.c=
om> wrote:
> >
> > On Wed, Jun 07, 2023 at 07:51:43PM +0000, Yosry Ahmed wrote:
> > > Commit 71024cb4a0bf ("frontswap: remove frontswap_tmem_exclusive_gets=
")
> > > removed support for exclusive loads from frontswap as it was not used=
.
> > > Bring back exclusive loads support to frontswap by adding an "exclusi=
ve"
> > > output parameter to frontswap_ops->load.
> > >
> > > On the zswap side, add a module parameter to enable/disable exclusive
> > > loads, and a config option to control the boot default value.
> > > Refactor zswap entry invalidation in zswap_frontswap_invalidate_page(=
)
> > > into zswap_invalidate_entry() to reuse it in zswap_frontswap_load() i=
f
> > > exclusive loads are enabled.
> > >
> > > With exclusive loads, we avoid having two copies of the same page in
> > > memory (compressed & uncompressed) after faulting it in from zswap. O=
n
> > > the other hand, if the page is to be reclaimed again without being
> > > dirtied, it will be re-compressed. Compression is not usually slow, a=
nd
> > > a page that was just faulted in is less likely to be reclaimed again
> > > soon.
> > >
> > > Suggested-by: Yu Zhao <yuzhao@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >
> > > v1 -> v2:
> > > - Add a module parameter to control whether exclusive loads are enabl=
ed
> > >   or not, the config option now controls the default boot value inste=
ad.
> > >   Replaced frontswap_ops->exclusive_loads by an output parameter to
> > >   frontswap_ops->load() (Johannes Weiner).
> > > ---
> >
> > Hi Yosry, I was testing the latest mm-unstable and encountered a bug.
> > It was bisectable and this is the first bad commit.
> >
> >
> > Attached config file and bisect log.
> > The oops message is available at:
> >
> > https://social.kernel.org/media/eace06d71655b3cc76411366573e4a8ce240ad6=
5b8fd20977d7c73eec9dc2253.jpg
> >
> > (the head commit is b9c91c43412f2e07 "mm: zswap: support exclusive load=
s")
> > (it's an image because I tested it on real machine)
> >
> >
> > This is what I have as swap space:
> >
> > $ cat /proc/swaps
> > Filename                                Type            Size           =
 Used            Priority
> > /var/swap                               file            134217724      =
 0               -2
> > /dev/zram0                              partition       8388604        =
 0               100
>
>
> Hi Hyeonggon,
>
> Thanks for reporting this! I think I know what went wrong. Could you
> please verify if the below fix works if possible?
>
> Domenico, I believe the below fix would also fix a problem with the
> recent writeback series. If the entry is invalidated before we grab the
> lock to put the local ref in zswap_frontswap_load(), then the entry
> will be freed once we call zswap_entry_put(), and the movement to the
> beginning LRU will be operating on a freed entry. It also modifies
> your recently added commit 418fd29d9de5 ("mm: zswap: invaldiate entry
> after writeback"). I would appreciate it if you also take a look.

Hi Yosry,

Thanks, this makes sense indeed. I've been running a stress test too for
an hour now and it seems fine.

>
> If this works as intended, I can send a formal patch (applies on top
> of fd247f029cd0 ("mm/gup: do not return 0 from pin_user_pages_fast()
> for bad args")):
>
> From 4b7f949b3ffb42d969d525d5b576fad474f55276 Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Wed, 21 Jun 2023 07:43:51 +0000
> Subject: [PATCH] mm: zswap: fix double invalidate with exclusive loads
>
> If exclusive loads are enabled for zswap, we invalidate the entry before
> returning from zswap_frontswap_load(), after dropping the local
> reference. However, the tree lock is dropped during decompression after
> the local reference is acquired, so the entry could be invalidated
> before we drop the local ref. If this happens, the entry is freed once
> we drop the local ref, and zswap_invalidate_entry() tries to invalidate
> an already freed entry.
>
> Fix this by:
> (a) Making sure zswap_invalidate_entry() is always called with a local
>     ref held, to avoid being called on a freed entry.
> (b) Making sure zswap_invalidate_entry() only drops the ref if the entry
>     was actually on the rbtree. Otherwise, another invalidation could
>     have already happened, and the initial ref is already dropped.
>
> With these changes, there is no need to check that there is no need to
> make sure the entry still exists in the tree in zswap_reclaim_entry()
> before invalidating it, as zswap_reclaim_entry() will make this check
> internally.
>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 87b204233115..62195f72bf56 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *root,
> struct zswap_entry *entry,
>         return 0;
>  }
>
> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
> +static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
>  {
>         if (!RB_EMPTY_NODE(&entry->rbnode)) {
>                 rb_erase(&entry->rbnode, root);
>                 RB_CLEAR_NODE(&entry->rbnode);
> +               return true;
>         }
> +       return false;
>  }
>
>  /*
> @@ -599,14 +601,16 @@ static struct zswap_pool
> *zswap_pool_find_get(char *type, char *compressor)
>         return NULL;
>  }
>
> +/*
> + * If the entry is still valid in the tree, drop the initial ref and rem=
ove it
> + * from the tree. This function must be called with an additional ref he=
ld,
> + * otherwise it may race with another invalidation freeing the entry.
> + */
>  static void zswap_invalidate_entry(struct zswap_tree *tree,
>                                    struct zswap_entry *entry)
>  {
> -       /* remove from rbtree */
> -       zswap_rb_erase(&tree->rbroot, entry);
> -
> -       /* drop the initial reference from entry creation */
> -       zswap_entry_put(tree, entry);
> +       if (zswap_rb_erase(&tree->rbroot, entry))
> +               zswap_entry_put(tree, entry);
>  }
>
>  static int zswap_reclaim_entry(struct zswap_pool *pool)
> @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_pool *poo=
l)
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
>          * took it out while we had the tree->lock released for IO.
>          */
> -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffset))
> -               zswap_invalidate_entry(tree, entry);
> +       zswap_invalidate_entry(tree, entry);
>
>  put_unlock:
>         /* Drop local reference */
> @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned type,
> pgoff_t offset,
>                 count_objcg_event(entry->objcg, ZSWPIN);
>  freeentry:
>         spin_lock(&tree->lock);
> -       zswap_entry_put(tree, entry);
>         if (!ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>                 *exclusive =3D true;
> @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned type,
> pgoff_t offset,
>                 list_move(&entry->lru, &entry->pool->lru);
>                 spin_unlock(&entry->pool->lru_lock);
>         }
> +       zswap_entry_put(tree, entry);
>         spin_unlock(&tree->lock);
>
>         return ret;
> --
> 2.41.0.162.gfafddb0af9-goog
