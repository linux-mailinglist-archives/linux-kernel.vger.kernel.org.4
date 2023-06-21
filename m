Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11B737EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFUJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFUJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:09:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A3E60
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:09:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so765584366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687338589; x=1689930589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG2lXvo8ynTJGJsMqdSPccmtpLBchNBmTKGe+x6AzlI=;
        b=4pYZ8rFuPEyRoNobu2LBG9p/5grmUYsqYKPqSkG222JoaFLInGkFhnbovFTNI1ZkK5
         ULGHVhoPm6qlwrywBHQI83CZ4w9SVwijcvHtv6Q2cusD3LF74BjGXb/W4Tg6Ti2oTihV
         wVq86yhFI08DfeEVzQl4JguCYqt42HMQG01R97ZcP/5MfxP4jlcYaNzlhEZEW3GJvxWQ
         mgT6bWL0+KlL8hbddIlfv9HUZncuR4XtAMEBG7H8ikQ/fKjncDLWcddeDD/mqa6xVf3J
         XMpl24bhckc68YxhTqMd5ltB9GK72RxQmqOgwP+Ru+8bWVHhtU3K6L87iObfeabLLzMQ
         GwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687338589; x=1689930589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG2lXvo8ynTJGJsMqdSPccmtpLBchNBmTKGe+x6AzlI=;
        b=HYvIlqpaSmq27xilcUYIPpLMXehA4tZca/XAi8Mx0pxukfh1X/dUsP0DOqYLhdzTXn
         1WpcxLAG0pQni4lSTzEev3gZS3kfHaJsxlvKv8nrTlZf3pMgNYYGa+IZrNutN6ZZ0t5p
         pJzScUsBszJ02/lR15b51uOj9fyxMVr2IJAaoQLh5pZmOzy6X02JGQWKwP/tJuk4IiVt
         oCcfBa/g5R1D7eAC41LgWJKlR/Qu9TggojAtuG/Vf9ve8iuHmj+97Nfyt4JTU8mGvALe
         FAOqNGqeK2MRHWmb6drzXg8pkb3IYRj0YrO9RN8s083sCiyhKrL8cnvdu9eX4Lt2/sJI
         EQCA==
X-Gm-Message-State: AC+VfDyCrciJMkrG0tqGHrDXNWEbbm6+haPrTovVkvjiS7qzknbydJS9
        L66hgNbeyWrGe5UYOd7kAIl7Vy2yXnm2wfLPDUfMMA==
X-Google-Smtp-Source: ACHHUZ5Dk4MwHGdfv8f7OujyhRJV0h+jcKKQ3o7MDM0xd+Nx3KhlNRz83dOPSZ5H9svd9wp5rUg+yLi90cg4Pk25eQk=
X-Received: by 2002:a17:906:eecc:b0:974:62d1:e942 with SMTP id
 wu12-20020a170906eecc00b0097462d1e942mr13014405ejb.21.1687338588733; Wed, 21
 Jun 2023 02:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230607195143.1473802-1-yosryahmed@google.com>
 <ZJKgThENoFlkJQmB@fedora> <CAJD7tkYEZEihcQFVrb5KR18r6o5496uXSRJbDrs+woGHwv6zWg@mail.gmail.com>
 <ZJK9qCXAMkjom5dz@fedora>
In-Reply-To: <ZJK9qCXAMkjom5dz@fedora>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 21 Jun 2023 02:09:11 -0700
Message-ID: <CAJD7tkYrSxX49=T7aj9DYsTdkgpi-hzO7wEFxi_gqPj+1_dMFw@mail.gmail.com>
Subject: Re: [BUG mm-unstable] "kernel BUG at mm/swap.c:393!" on commit b9c91c43412f2e
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 21, 2023 at 2:06=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Wed, Jun 21, 2023 at 01:05:56AM -0700, Yosry Ahmed wrote:
> > On Wed, Jun 21, 2023 at 12:01=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail=
.com> wrote:
> > > Hi Yosry, I was testing the latest mm-unstable and encountered a bug.
> > > It was bisectable and this is the first bad commit.
> > >
> > >
> > > Attached config file and bisect log.
> > > The oops message is available at:
> > >
> > > https://social.kernel.org/media/eace06d71655b3cc76411366573e4a8ce240a=
d65b8fd20977d7c73eec9dc2253.jpg
> > >
> > > (the head commit is b9c91c43412f2e07 "mm: zswap: support exclusive lo=
ads")
> > > (it's an image because I tested it on real machine)
> > >
> > >
> > > This is what I have as swap space:
> > >
> > > $ cat /proc/swaps
> > > Filename                                Type            Size         =
   Used            Priority
> > > /var/swap                               file            134217724    =
   0               -2
> > > /dev/zram0                              partition       8388604      =
   0               100
> >
> >
> > Hi Hyeonggon,
> >
> > Thanks for reporting this! I think I know what went wrong. Could you
> > please verify if the below fix works if possible?
> >
>
> Works fine and I was not able to reproduce the bug with the patch
> applied.
>
> Not sure Andrew would prefer squashing it into original one or applying i=
t
> as separate patch, though (I'm totally fine with both way).

I think it already landed in mm-stable so it cannot be squashed at this poi=
nt.

>
> Anyway:
>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks a lot for reporting and testing this!

I will wait for Domenico to also respond then send the fix to Andrew.
Hopefully it's not too late for this rc.

>
> > Domenico, I believe the below fix would also fix a problem with the
> > recent writeback series. If the entry is invalidated before we grab the
> > lock to put the local ref in zswap_frontswap_load(), then the entry
> > will be freed once we call zswap_entry_put(), and the movement to the
> > beginning LRU will be operating on a freed entry. It also modifies
> > your recently added commit 418fd29d9de5 ("mm: zswap: invaldiate entry
> > after writeback"). I would appreciate it if you also take a look.
> >
> > If this works as intended, I can send a formal patch (applies on top
> > of fd247f029cd0 ("mm/gup: do not return 0 from pin_user_pages_fast()
> > for bad args")):
> >
> > From 4b7f949b3ffb42d969d525d5b576fad474f55276 Mon Sep 17 00:00:00 2001
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Date: Wed, 21 Jun 2023 07:43:51 +0000
> > Subject: [PATCH] mm: zswap: fix double invalidate with exclusive loads
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
>
> <...snip...>
>
> --
> Hyeonggon Yoo
>
> Undergraduate | Chungnam National University
