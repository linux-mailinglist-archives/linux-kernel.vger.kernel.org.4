Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BD60EA95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiJZUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiJZUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:51:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1D7286A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:51:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m2so11247840pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YeygMNC1bvvP4dcp+sNmGP0csnZPsocgrlb2fYDiWOY=;
        b=mT0Gj/1hgbfHpr4tBRM0sIv8kGBgibduh6mGLVFoszyYauSXlp7FNBO4ryODJHkNi0
         tYGUuYF+EMS0BzEXPKp9l3Fs/9jRiab58j3H835hiKh9MUdsZOsifalrpQyREpY9Gx/T
         Wdkj5JipzbWXHC9NfXrckH7J0sYhgXKE+hv+iKh7i1eEMS0pzxT88WK7vLhp9uaUM2Ux
         XlhpEk4EcjhdFDnb2y7HU/8SEfux2krNwImfa7XQxVT6kGThwswMniIPrPAm2RUxahmP
         7Lcv5e8AGDmG+ZMsYUk7zn5U7eLy2wfB1e55QQKxCYzfkCwklPXpS24pfhxcE0TKElBx
         Iv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeygMNC1bvvP4dcp+sNmGP0csnZPsocgrlb2fYDiWOY=;
        b=XoZXrIEP9EDohJ5lyoBMfJ4IeGq7EpGmqB/h+Vc1u2Otpo3ChhOb5vZX9s/IESJcas
         os2HiCW8gk5wtKGPkzq7AM8rY9tgAGkcd9nkATRh2ZwPBUu4vvu/fUy3e1vnBa17nASG
         odwOKpMUxotr7bsTiKYts1cejSQLCHXxNNjVcSAO+dFdJ9L+roBBWIyRC4H3Omxilaat
         yPBX/TFa/anguJdZn4IC83X763d8KPVLCDBH92/TkSceDSVUPCUWCdx11n5CAnCbpFTE
         XYBTwGXcr+h4JWmnit5Pk1kwxxdlLG1Zn/NhLe9KVXmw7lGIHW5R5wq8jUkn3LNKY7XR
         2i+Q==
X-Gm-Message-State: ACrzQf3HAdI3BtnBMJQ7Byl1yLIO27xH/YYvKjwx5iutpTMO4/Du3Z8Y
        AMdVME4llSP25juDsS6H5L2veRduUljs6om753Q=
X-Google-Smtp-Source: AMsMyM4i0/+LPtnjst3vkT/fbWzXVFqE9ysDPhBIrR5lM0MKIcPUs4V6vo+39FROICRRSsLKk5L03kciNgz3lD91nkM=
X-Received: by 2002:a17:90b:4a09:b0:20d:5b67:1496 with SMTP id
 kk9-20020a17090b4a0900b0020d5b671496mr6175529pjb.67.1666817503002; Wed, 26
 Oct 2022 13:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org> <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org> <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
In-Reply-To: <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 26 Oct 2022 13:51:22 -0700
Message-ID: <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Oct 25, 2022 at 02:53:01PM -0700, Yang Shi wrote:
> > On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > > > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > Direct reclaim stats are useful for identifying a potential source for
> > > > > application latency, as well as spotting issues with kswapd. However,
> > > > > khugepaged currently distorts the picture: as a kernel thread it
> > > > > doesn't impose allocation latencies on userspace, and it explicitly
> > > > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > > > cause confusion when trying to understand actual kswapd behavior.
> > > > >
> > > > > Break out khugepaged from the direct reclaim counters into new
> > > > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > > > >
> > > > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > > > >
> > > > > pgsteal_kswapd 1342185
> > > > > pgsteal_direct 0
> > > > > pgsteal_khugepaged 3623
> > > > > pgscan_kswapd 1345025
> > > > > pgscan_direct 0
> > > > > pgscan_khugepaged 3623
> > > >
> > > > There are other kernel threads or works may allocate memory then
> > > > trigger memory reclaim, there may be similar problems for them and
> > > > someone may try to add a new stat. So how's about we make the stats
> > > > more general, for example, call it "pg{steal|scan}_kthread"?
> > >
> > > I'm not convinved that's a good idea.
> > >
> > > Can you generally say that userspace isn't indirectly waiting for one
> > > of those allocating threads? With khugepaged, we know.
> >
> > AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM.
>
> Right, but ksm also uses __GFP_KSWAPD_RECLAIM. So while userspace
> isn't directly waiting for ksm, when ksm enters direct reclaim it's
> because kswapd failed. This is of interest to kernel developers.
> Userspace will likely see direct reclaim in that scenario as well, so
> the ksm direct reclaim counts aren't liable to confuse users.
>
> Khugepaged on the other hand will *always* reclaim directly, even if
> there is no memory pressure or kswapd failure. The direct reclaim
> counts there are misleading to both developers and users.
>
> What it really should be is pgscan_nokswapd_nouserprocesswaiting, but
> that just seems kind of long ;-)
>
> I'm also not sure anybody but khugepaged is doing direct reclaim
> without kswapd reclaim. It seems unlikely we'll get more of those.

IIUC you actually don't care about how many direct reclaim are
triggered by khugepaged, but you would like to separate the direct
reclaim stats between that are triggered directly by userspace
actions, which may stall userspace, and that aren't, which don't stall
userspace. If so it doesn't sound that important to distinguish
whether the direct reclaim are triggered by khugepaged or other kernel
threads even though other kthreads are not liable to confuse users
IMHO.

>
> > Some device mapper drivers may do heavy lift in the work queue, for
> > example, dm-crypt, particularly for writing.
>
> Userspace will wait for those through dirty throttling. We'd want to

Not guaranteed.

Anyway I just thought pgscan_khugepaged might be more confusing for
the users even the developers who are not familiar with
THP/khugepaged.

> know about kswapd failures in that case - again, without them being
> muddied by khugepaged.
>
> > > And those other allocations are usually ___GFP_KSWAPD_RECLAIM, so if
> > > they do direct reclaim, we'd probably want to know that kswapd is
> > > failing to keep up (doubly so if userspace is waiting). In a shared
> > > kthread counter, khugepaged would again muddy the waters.
