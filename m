Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81946728C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjARTzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjARTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:55:21 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AC058983
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:55:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 123so6361681ybv.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ml4Mq1HxoprduSmaOtE/7qmWaOPc7rT86hVq2mfhQLo=;
        b=PbeDPrXRrIm7rSfckMx4+MttBahJf6IY5jVAIjntleKZy4etq34NmHOU6XAyeR+Fab
         ORwDD6aeT/o+Lzatahvs1Df3hC8Zp4wztM3Tsi7zeoFTDN3ZXTRRATMchdXmd1w6iq9r
         ULB35+cs0evngWClWp+S7DE9yLcIJr+6DdMZNcBfFC64ZUZ8obBNsKaTSHZoXlg8lZnA
         wrs0Z7xqGozVMTtQXoGy0Ii+xstY22ORN6Rk8NwXfb9Mdy0EMr8jfUqnhJDwLBzm4CO0
         FxiAdjNv/LNw5Q6CHI1oIM4T8Lczsjebkmmr3AaJHUcG3MLFcXdAW7CuWHhXkm5sY8GX
         boDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ml4Mq1HxoprduSmaOtE/7qmWaOPc7rT86hVq2mfhQLo=;
        b=Msne5DG0fdDxSDGR/OdfWV0J/Y01u5Yl5dts0hWE1vwfRbjKrL9OVcKR4gtdI/Ovgk
         jcmlp2WITIERW8Iu+L7CfZSAGTWcu9VokCXYQDk1Uq7GzyZY52DwricRvMaaTfhRV38U
         nvg9/99OvoJIR1bos/ExHJLDRcHgBy7BLFfhzjvT8+PKkqnQ6LhAPPN6V5inutqe8VcS
         Zvj0JLqBT3ZNe/nEjBpUQXuTk9eGTrln0o9F8gUsSe3wIfStLTtG1HzaA6rZ0PTcIxKS
         iGuw58zxev0dwxAoX9+OKFSnh1S+uKR/4meWtL93AX9fHk2TqTuGlvEPg3VVDij8csM6
         o9Ag==
X-Gm-Message-State: AFqh2kpi3fi2TvLN6PiAgupVbHQq/YgHo3nY0Ki9vqtgy8YWfZxZPRZh
        jawgds7aBmYgurIK1Z8rOJC51g3eKlZrokAmxsbBpQ==
X-Google-Smtp-Source: AMrXdXvFdbyYmxgjrhbrPZ+DHMRuLbevMB2fbnG5spWSq+oHRVEA8MSUcimroDBHgsm9LSnvYVm1PM3o2CDb/QRmG9U=
X-Received: by 2002:a25:bd14:0:b0:73f:fb7d:400 with SMTP id
 f20-20020a25bd14000000b0073ffb7d0400mr1277748ybk.352.1674071718749; Wed, 18
 Jan 2023 11:55:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p6>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
 <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
In-Reply-To: <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 18 Jan 2023 11:55:07 -0800
Message-ID: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     John Stultz <jstultz@google.com>
Cc:     jaewon31.kim@samsung.com,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > > quite much time in page allocation perspective.
> > >
> > > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > > unpredictable delay.
> > >
> > > To get reasonable allocation speed from dma-buf system heap, use
> > > HIGH_ORDER_GFP for order 4 to avoid reclaim.
>
> Thanks for sharing this!
> The case where the allocation gets stuck behind reclaim under pressure
> does sound undesirable, but I'd be a bit hesitant to tweak numbers
> that have been used for a long while (going back to ion) without a bit
> more data.
>
> It might be good to also better understand the tradeoff of potential
> on-going impact to performance from using low order pages when the
> buffer is used.  Do you have any details like or tests that you could
> share to help ensure this won't impact other users?
>
> TJ: Do you have any additional thoughts on this?
>
I don't have any data on how often we hit reclaim for mid order
allocations. That would be interesting to know. However the 70th
percentile of system-wide buffer sizes while running the camera on my
phone is still only 1 page, so it looks like this change would affect
a subset of use-cases.

Wouldn't this change make it less likely to get an order 4 allocation
(under memory pressure)? The commit message makes me think the goal of
the change is to get more of them.

Actually with the low order being 0, I don't think __GFP_COMP makes
sense in LOW_ORDER_GFP. But I guess that flag isn't harmful there.

> thanks
> -john
