Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AB7297CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjFILG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjFILGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:06:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B930D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:06:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53063897412so694287a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686308764; x=1688900764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXzRh8LgZwDLUj+D3WXWLnveS92UjU0wAmFYLn9Q2uE=;
        b=oz03+L/a+HXd9AqnlLpWxFJBLErTROuoyRbOGTCc4mPeadAzAMxHGjFiJdzb+SO26+
         hKybnppI5RC9s5g8XflvMMGOLdhDxzUYsXoRJP8NES7NIKadRLZ1BqEOAI9tfJ623AVN
         GSD98x3EgSMzruZ02FFLQyfgl12RnNVyb1PIILiq4R3VgoQhmhQ+KA1jNAkf6KgYu0Qw
         IEdirRVEY7bDHJ2m6MJ00fT4Q98yw0bIl6GLlUqS2+Z7/kOZOcaeYlCdv4syTEPEL7Fu
         y3AsgFpCx5RMeuEf4bde+ggN80HMs40iIvs4j7QMoRvSdODVaPOuLAc9XeKJQZvO37M2
         LZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308764; x=1688900764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXzRh8LgZwDLUj+D3WXWLnveS92UjU0wAmFYLn9Q2uE=;
        b=RRZDiWVPQHByqiw8MlDzpi0EA6GLxbREZCw8V7btVZGiGZbvGrCdPivUYNQDt3y8Cg
         7AEHAzKw3LsL+hOyEXh6tOJd4SCbS63sHM9XXEd8Ao7Ac9DJuV9zxRVyt1gZqTAFUTxt
         nvLaorMh4LeWkK5JJQu1jl37WgPqaoHD1umcopUWod+8Ck9CCiyZbFBT8X2cygk8xrT8
         Mb0G9r/+vUt2SFSJzdhREAMds8We4nu7D5ROFvDfynXPElsd+nfHOdu4i+MtAsqfUuPO
         QikvCDMldkfl638nSde3ZIWLOz9+pojWElziXoIQWprjOzTkH3ZqSA6rQTeiq6zbjuw2
         llpA==
X-Gm-Message-State: AC+VfDxhG/VShWTLajwpsi3ffJOnKZXcugtPwVo/9Xy7oZuK5WgI1mB8
        NnZOu5mR16+FXMFESH/Q/MxtKYoaB5gngJXQXYs=
X-Google-Smtp-Source: ACHHUZ7mkF6BFo9oUI+M4s7/lJCw04PgEQ1o0U/tWtR0tgzPuUCTZtjUKrbW28hjvytcgK+jAAk0tbSx1eWSk8ak20o=
X-Received: by 2002:a17:90a:2d8e:b0:256:8e2d:1ec8 with SMTP id
 p14-20020a17090a2d8e00b002568e2d1ec8mr918208pjd.41.1686308764285; Fri, 09 Jun
 2023 04:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-7-cerasuolodomenico@gmail.com> <20230608164844.GF352940@cmpxchg.org>
In-Reply-To: <20230608164844.GF352940@cmpxchg.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Fri, 9 Jun 2023 13:05:53 +0200
Message-ID: <CA+CLi1h3qbGYrZfXggbZYBkPthTt3GC0h6HCdOxSTO6-1qTVLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

On Thu, Jun 8, 2023 at 6:48=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> Hi Domenico,
>
> On Tue, Jun 06, 2023 at 04:56:10PM +0200, Domenico Cerasuolo wrote:
> > Previously, in zswap, the writeback function was passed to zpool driver=
s
> > for their usage in calling the writeback operation. However, since the
> > drivers did not possess references to entries and the function was
> > specifically designed to work with handles, the writeback process has
> > been modified to occur directly within zswap.
>
> I'm having trouble parsing this sentence.
>
> > Consequently, this change allows for some simplification of the
> > writeback function, taking into account the updated workflow.
>
> How about:
>
> zswap_writeback_entry() used to be a callback for the backends, which
> don't know about struct zswap_entry.
>
> Now that the only user is the generic zswap LRU reclaimer, it can be
> simplified: pass the pinned zswap_entry directly, and consolidate the
> refcount management in the shrink function.

Sounds clearer, will update.

>
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
> >       pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> >                zpool_get_type((p)->zpool))
> >
> > -static int zswap_writeback_entry(struct zpool *pool, unsigned long han=
dle);
> > +static int zswap_writeback_entry(struct zswap_entry *entry, struct zsw=
ap_header *zhdr,
> > +                              struct zswap_tree *tree);
> >  static int zswap_pool_get(struct zswap_pool *pool);
> >  static void zswap_pool_put(struct zswap_pool *pool);
> >
> > @@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool)
> >       }
> >       spin_unlock(&tree->lock);
> >
> > -     ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > +     ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> >
> >       spin_lock(&tree->lock);
> >       if (ret) {
> >               spin_lock(&pool->lru_lock);
> >               list_move(&lru_entry->lru, &pool->lru);
> >               spin_unlock(&pool->lru_lock);
>
> This could use a comment.
>
>                 /* Writeback failed, put entry back on LRU */
>
> > +             zswap_entry_put(tree, tree_entry);
>
> This put is a common factor in both branches, so you can consolidate.
>
> > +     } else {
> > +             /* free the local reference */
> > +             zswap_entry_put(tree, tree_entry);
> > +             /* free the entry if it's not been invalidated*/
>
> Missing space between text and */
>
> > +             if (lru_entry =3D=3D zswap_rb_search(&tree->rbroot, swpof=
fset))
> > +                     zswap_entry_put(tree, tree_entry);
> >       }
> > -     zswap_entry_put(tree, tree_entry);
> >       spin_unlock(&tree->lock);
>
> The success path freeing (hopefully the common path) is now
> unfortunately hidden in fairly deep indentation. I think this would be
> better with a goto for the error case.
>
> All together, something like this?
>
>         if (ret) {
>                 /* Writeback failed, put entry back on LRU */
>                 ...
>                 goto put_unlock;
>         }
>
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the base ref from the tree - unless invalidate
>          * already took it out while we had the tree->lock released for I=
O.
>          */
>         if (lru_entry =3D=3D zswap_rb_search(&tree->rb_root, swpoffset))
>                 zswap_entry_put(tree, entry);
>
> put_unlock:
>         /* Drop local reference */
>         zswap_entry_put(tree, tree_entry);
>         spin_unlock(&tree->lock);
>
>         return ret ? -EAGAIN : 0;
>

This feedback overlaps with the on in patch 1/7, I'm integrating them
so that in patch #1, the invalidation check is done only with rb search
and a first `goto unlock` for error.
Then here the base reference-drop is added after the `ret` check, and
errors go to `put_unlock`:

if (ret) {
        /* Writeback failed, put entry back on LRU */
        spin_lock(&pool->lru_lock);
        list_move(&entry->lru, &pool->lru);
        spin_unlock(&pool->lru_lock);
        goto put_unlock;
}

/* Check for invalidate() race */
if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset))
        goto put_unlock;

        /* Drop base reference */
        zswap_entry_put(tree, entry);

put_unlock:
        /* Drop local reference */
        zswap_entry_put(tree, entry);
unlock:
        spin_unlock(&tree->lock);
return ret ? -EAGAIN : 0;

> Btw, it's unsettling that we drop the tree reference without
> explicitly removing the entry for the tree. We rely on the final put
> that frees the entry to do tree removal, but this doesn't happen if
> somebody else is holding a reference; the entry can remain in the tree
> long after we've officially handed over ownership of the data to
> swapcache. TTBOMK there are currently no bugs because of that, but
> it's a data corruption waiting to happen.
>
> This should be:
>
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
>          * took it out while we had the tree->lock released for IO.
>          */
>         if (entry =3D=3D zswap_rb_search(&tree->rb_root, swpoffset))
>                 zswap_invalidate_entry(tree, entry);
>
> Would you care to send a follow-up patch?

Makes total sense, thanks will send a patch for this.
