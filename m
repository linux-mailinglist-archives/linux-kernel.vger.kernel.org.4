Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D872936E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbjFIIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjFIIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:40:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7530FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:40:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fb4ee9ba1so419284a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686300007; x=1688892007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeBp3LDqacG6dkXx6JUslaCBZFzIXO6+G11dxA8Ke/s=;
        b=MHb8l0EgEXMRA16v/paq8cbTXztgj69apT6QbfIrMBjssZlOUe1Ik+GX+KX126LiuK
         XRYVxXNM7FFT0HElUPko6MT9LwPKCYeltHPpDTnSYKzFQNql2n4EE/T4uanuEvP8iDIk
         ksn8WJeaGIVaQqip0ntgnb8plHn4LWbhG3hxty+4g0LysUsiIMkkNKRYEGju6ZK+7A12
         RKMxrMGwlv5UHg32EXkh40IwTEVRq8EPGBWWVUkh31Pp/X40z7Ph4yQdsHqPqlXR0SwQ
         dia6IkrMRFpWxFdpO8SPTIIwiD4kg4iYRK8cPvdkVLOuJgv2O2E41iiLQgfpaAWlr7pc
         vr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300007; x=1688892007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeBp3LDqacG6dkXx6JUslaCBZFzIXO6+G11dxA8Ke/s=;
        b=dsJE1PhfTyI0dMceW/LZcEoCOkxtn1nBf63565jZGArM97ZYDlTiqcn/RcyaYdANet
         oZCadjwzdMMUp3Il0GEGzACn6lkaXZYo9nSCzXZuEdGEmBsMPc1vsFGP9LCcbKEaOs3O
         hm5a+CI/VLjQVDCBfsGIaER6vZGgI8sbbd2xo9K7cjAbiIWKLmpd394e1VwDOMCOBtcq
         6PIWdM8T+I/n7h3T6Qg76Av0ng4yznQr4kAlR/z/T4Kk9gA8kKN/t9PI3JORK2jHQ7Rg
         6jzggxSBTZiOgLSKF1FFXTyGH2dhEa0SK32mop2H5opYf/4Tjd6EzKqnUqAMDk03hMFH
         NXCg==
X-Gm-Message-State: AC+VfDxcMB68tfce5uBpOWOrhp+QJZPtvf8AQTXWNpPXOJ+NWmL7sr1T
        YjAzbv64884rfKJGqWwWTKWFy+q9p6mh4r9LjTA=
X-Google-Smtp-Source: ACHHUZ7bJ3jCLg4oTcEEJ/UTneBwOzhQYRw5k4G6xp2b8bpURPESSI8BdkY4VNnmPZ4i8w5L/9c5mY+GdGriQucAym0=
X-Received: by 2002:a17:90b:4f44:b0:253:727e:4b41 with SMTP id
 pj4-20020a17090b4f4400b00253727e4b41mr370270pjb.34.1686300006768; Fri, 09 Jun
 2023 01:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com> <20230608165250.GG352940@cmpxchg.org>
 <20230608170459.GH352940@cmpxchg.org> <20230608184516.GA356779@cmpxchg.org>
In-Reply-To: <20230608184516.GA356779@cmpxchg.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Fri, 9 Jun 2023 10:39:55 +0200
Message-ID: <CA+CLi1gP6+tKrHSfUxBhLvYu=F7NMnuPp+gt-63cwonU4r25UA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 8:45=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Jun 08, 2023 at 01:05:00PM -0400, Johannes Weiner wrote:
> > On Thu, Jun 08, 2023 at 12:52:51PM -0400, Johannes Weiner wrote:
> > > On Tue, Jun 06, 2023 at 04:56:05PM +0200, Domenico Cerasuolo wrote:
> > > > @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get=
(char *type, char *compressor)
> > > >   return NULL;
> > > >  }
> > > >
> > > > +static int zswap_shrink(struct zswap_pool *pool)
> > > > +{
> > > > + struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > > > + struct zswap_header *zhdr;
> > > > + struct zswap_tree *tree;
> > > > + int swpoffset;
> > > > + int ret;
> > > > +
> > > > + /* get a reclaimable entry from LRU */
> > > > + spin_lock(&pool->lru_lock);
> > > > + if (list_empty(&pool->lru)) {
> > > > +         spin_unlock(&pool->lru_lock);
> > > > +         return -EINVAL;
> > > > + }
> > > > + lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> > > > + list_del_init(&lru_entry->lru);
> > > > + zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_M=
M_RO);
> > > > + tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > > > + zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > > > + /*
> > > > +  * Once the pool lock is dropped, the lru_entry might get freed. =
The
> > > > +  * swpoffset is copied to the stack, and lru_entry isn't deref'd =
again
> > > > +  * until the entry is verified to still be alive in the tree.
> > > > +  */
> > > > + swpoffset =3D swp_offset(zhdr->swpentry);
> > > > + spin_unlock(&pool->lru_lock);
> > > > +
> > > > + /* hold a reference from tree so it won't be freed during writeba=
ck */
> > > > + spin_lock(&tree->lock);
> > > > + tree_entry =3D zswap_entry_find_get(&tree->rbroot, swpoffset);
> > > > + if (tree_entry !=3D lru_entry) {
> > > > +         if (tree_entry)
> > > > +                 zswap_entry_put(tree, tree_entry);
> > > > +         spin_unlock(&tree->lock);
> > > > +         return -EAGAIN;
> > > > + }
> > > > + spin_unlock(&tree->lock);
> > > > +
> > > > + ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > > > +
> > > > + spin_lock(&tree->lock);
> > > > + if (ret) {
> > > > +         spin_lock(&pool->lru_lock);
> > > > +         list_move(&lru_entry->lru, &pool->lru);
> > > > +         spin_unlock(&pool->lru_lock);
> > > > + }
> > > > + zswap_entry_put(tree, tree_entry);
> > >
> > > On re-reading this, I find the lru_entry vs tree_entry distinction
> > > unnecessarily complicated. Once it's known that the thing coming off
> > > the LRU is the same thing as in the tree, there is only "the entry".
> > >
> > > How about 'entry' and 'tree_entry', and after validation use 'entry'
> > > throughout the rest of the function?
> >
> > Even better, safe the tree_entry entirely by getting the reference
> > from the LRU already, and then just search the tree for a match:
> >
> >       /* Get an entry off the LRU */
> >       spin_lock(&pool->lru_lock);
> >       entry =3D list_last_entry();
> >       list_del(&entry->lru);
> >       zswap_entry_get(entry);
> >       spin_unlock(&pool->lru_lock);
> >
> >       /* Check for invalidate() race */
> >       spin_lock(&tree->lock);
> >       if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
> >               ret =3D -EAGAIN;
> >               goto put_unlock;
> >       }
> >       spin_unlock(&tree->lock);
>
> Eh, brainfart. It needs the tree lock to bump the ref, of course.
>
> But this should work, right?
>
>         /* Check for invalidate() race */
>         spin_lock(&tree->lock);
>         if (entry !=3D zswap_rb_search(&tree->rbroot, swpoffset)) {
>                 ret =3D -EAGAIN;
>                 goto unlock;
>         }
>         zswap_entry_get(entry);
>         spin_unlock(&tree->lock);

This should work indeed, it's much cleaner with just one local
zswap_entry, will update!
