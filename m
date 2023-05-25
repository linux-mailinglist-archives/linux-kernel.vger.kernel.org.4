Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2F711166
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEYQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjEYQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:53:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582E1A2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:53:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5343c3daff0so1318337a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685033587; x=1687625587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yHwoFl0A/2RKkd9CDZCOO1UVgBmrXuW4M9cQO6ErvY=;
        b=lpMRkuqLYneULplpBZz2RXh/cuyVkwoJ68sZeWdnaqCzMMgVPaSeFMDqzv4JPpMK06
         C3nvI3Jhsw/YNvHxVgu8/B2nJ/pAtQ0/R5TqhOgncfX9bJiZ3M3RF/rLUsNKvtspfsPe
         SwH5ebNGkl41kLCi/DP/M0OS8JLet+x9EUUQcv1r9ii1AmB69Wq31VOpC+n+d2PIZ9s5
         YBsaA3jHsJ+KQYNXczXFsZzbdQBskG01pkkVEgvEPX0Pc2ERoKcWOCNoz8T5/0bSIaA/
         T3Bu9rAWAJObEVv1Inq2PDL1lllQA2rBKqyrtvnSLVD9BD2BNS1GpV0bJXAXzVgoe+Uc
         YmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685033587; x=1687625587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yHwoFl0A/2RKkd9CDZCOO1UVgBmrXuW4M9cQO6ErvY=;
        b=IGSvZ5s2IWf9yl+B1tNZFopZMdIdGDP07e/tPO5oiX7hv50axfBFdbLuu8UoMGBEN5
         xY4MTbLFH419OG3CLD+Ne5a+meeZOT/QcCZK/fd5BgDvg3dNl79iI92pDWhRCJ2nsefg
         cLkrp2CWYY7nGez8Mo/bFLlAvTRhfBqkBA8iimtEUHXOmfRBlZcwTJ4ay7TK7reUE+XH
         fwDp+4Lrj6B8WPA0/Gqc2Gin6q8QiIwEqHzwztl8+FJW6ObjG9lWNubgtNch8hlLDP5C
         VY/K7ddp/4kBQ8sTDXjlFKHI4XrMQFBLjgYWnWCUrefwZmqdahYiTgeCEyCi2BGb91aa
         J1Zg==
X-Gm-Message-State: AC+VfDwHZTB/FuBH0c6Y0HkjTV0UAQHh5Ol4zz5yBgsqJ0agLbMUfQXd
        eCbVMQ7dAI/odalFV/pBLAxVMFxTI5TBGbuU5SQ=
X-Google-Smtp-Source: ACHHUZ5756kDyQ3thlbZSXVFs49/TzQSSWzfrXvvbCU9rvev1DAHCpYtHAWFgLoZPIxbSFz20FZvFNqWssJrqqcd+Ik=
X-Received: by 2002:a17:903:22d1:b0:1ad:fcdc:bcb9 with SMTP id
 y17-20020a17090322d100b001adfcdcbcb9mr3047115plg.23.1685033586859; Thu, 25
 May 2023 09:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com> <CAJD7tkY0j4xzstf=OCX-k-mujzbXf_nt=H4F5JCZNZ8N1iEEcg@mail.gmail.com>
In-Reply-To: <CAJD7tkY0j4xzstf=OCX-k-mujzbXf_nt=H4F5JCZNZ8N1iEEcg@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Thu, 25 May 2023 18:52:55 +0200
Message-ID: <CA+CLi1gzVop3=kmARn09NKKh6yW=bt9KYrzc0AfXB64J0r-9Ew@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        hannes@cmpxchg.org, kernel-team@fb.com
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

On Thu, May 25, 2023 at 2:59=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Hi Domenico,
>
> On Tue, May 23, 2023 at 11:50=E2=80=AFPM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > This update addresses an issue with the zswap reclaim mechanism, which
> > hinders the efficient offloading of cold pages to disk, thereby
> > compromising the preservation of the LRU order and consequently
> > diminishing, if not inverting, its performance benefits.
> >
> > The functioning of the zswap shrink worker was found to be inadequate,
> > as shown by basic benchmark test. For the test, a kernel build was
> > utilized as a reference, with its memory confined to 1G via a cgroup an=
d
> > a 5G swap file provided. The results are presented below, these are
> > averages of three runs without the use of zswap:
> >
> > real 46m26s
> > user 35m4s
> > sys 7m37s
> >
> > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > system), the results changed to:
> >
> > real 56m4s
> > user 35m13s
> > sys 8m43s
> >
> > written_back_pages: 18
> > reject_reclaim_fail: 0
> > pool_limit_hit:1478
> >
> > Besides the evident regression, one thing to notice from this data is
> > the extremely low number of written_back_pages and pool_limit_hit.
> >
> > The pool_limit_hit counter, which is increased in zswap_frontswap_store
> > when zswap is completely full, doesn't account for a particular
> > scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> > true; with this flag on, zswap_frontswap_store rejects pages if zswap i=
s
> > still above the acceptance threshold. Once we include the rejections du=
e
> > to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> > 1478 to a significant 21578266.
> >
> > Zswap is stuck in an undesirable state where it rejects pages because
> > it's above the acceptance threshold, yet fails to attempt memory
> > reclaimation. This happens because the shrink work is only queued when
> > zswap_frontswap_store detects that it's full and the work itself only
> > reclaims one page per run.
> >
> > This state results in hot pages getting written directly to disk,
> > while cold ones remain memory, waiting only to be invalidated. The LRU
> > order is completely broken and zswap ends up being just an overhead
> > without providing any benefits.
> >
> > This commit applies 2 changes: a) the shrink worker is set to reclaim
> > pages until the acceptance threshold is met and b) the task is also
> > enqueued when zswap is not full but still above the threshold.
> >
> > Testing this suggested update showed much better numbers:
> >
> > real 36m37s
> > user 35m8s
> > sys 9m32s
> >
> > written_back_pages: 10459423
> > reject_reclaim_fail: 12896
> > pool_limit_hit: 75653
>
> Impressive numbers, and great find in general!
>
> I wonder how other workloads benefit/regress from this change.
> Anything else that you happened to run? :)
>
Hi Yosry,

thanks for the quick feedback!

Besides stressers, I haven't tested any other actual workload, we don't hav=
e
writeback in production yet so I can't provide any data from there. I was
wondering what kind of actual workload I could use to test this on my deskt=
op,
but I couldn't think of anything relevant, I'm open to suggestions though :=
)
> >
> > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool lim=
it is hit")
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zswap.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 59da2a415fbb..2ee0775d8213 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                                 shrink_work);
> > +       int ret;
> >
> > -       if (zpool_shrink(pool->zpool, 1, NULL))
> > -               zswap_reject_reclaim_fail++;
> > +       do {
> > +               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +               if (ret)
> > +                       zswap_reject_reclaim_fail++;
> > +       } while (!zswap_can_accept() && ret !=3D -EINVAL);
>
> One question/comment here about the retry logic.
>
> So I looked through the awfully convoluted writeback code, and there
> are multiple layers, and some of them tend to overwrite the return
> value of the layer underneath :(
>
> For zsmalloc (as an example):
> zpool_shrink()->zs_zpool_shrink()->zs_reclaim_page()->zpool_ops.evict()->=
zswap_writeback_entry().
>
> First of all, that zpool_ops is an unnecessarily confusing
> indirection, but anyway.
>
> - zswap_writeback_entry() will either return -ENOMEM or -EEXIST on error
> - zs_reclaim_page()/zbud_reclaim_page() will return -EINVAL if the lru
> is empty, and -EAGAIN on other errors.
> - zs_zpool_shrink()/zbud_zpool_shrink() will mostly propagate the
> return value of  zs_reclaim_page()/zbud_reclaim_page().
> - zpool_shrink() will return -EINVAL if the driver does not support
> shrinking, otherwise it will propagate the return value from the
> driver.
>
> So it looks like we will get -EINVAL only if the driver lru is empty
> or the driver does not support writeback, so rightfully we should not
> retry.
>
> If zswap_writeback_entry() returns -EEXIST, it probably means that we
> raced with another task decompressing the page, so rightfully we
> should retry to writeback another page instead.
>
> If zswap_writeback_entry() returns -ENOMEM, it doesn't necessarily
> mean that we couldn't allocate memory (unfortunately), it looks like
> we will return -ENOMEM in other cases as well. Arguably, we can retry
> in all cases, because even if we were actually out of memory, we are
> trying to make an allocation that will eventually free more memory.
>
> In all cases, I think it would be nicer if we retry if ret =3D=3D -EAGAIN
> instead. It is semantically more sane. In this specific case it is
> functionally NOP as zs_reclaim_page()/zbud_reclaim_page() will mostly
> return -EAGAIN anyway, but in case someone tries to use saner errnos
> in the future, this will age better.
Retrying if ret =3D=3D -EAGAIN seems much nicer indeed, will change it.
>
> Also, do we intentionally want to keep retrying forever on failure? Do
> we want to add a max number of retries?
If the drivers guaranteed that zpool_shrink will remove at least an entry
from their LRU, the retry wouldn't be needed because the LRU will
eventually be emptied. But this is an assumption on the implementation of
the zpool, so yes, we could use a max retries. I think that being a sanity
check, it should overshoot the required number of iterations in order to
avoid a premature break, what about retrying a max of
zswap_stored_pages times?
>
> >         zswap_pool_put(pool);
> >  }
> >
> > @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >         if (zswap_pool_reached_full) {
> >                if (!zswap_can_accept()) {
> >                         ret =3D -ENOMEM;
> > -                       goto reject;
> > +                       goto shrink;
> >                 } else
> >                         zswap_pool_reached_full =3D false;
> >         }
> > --
> > 2.34.1
> >
