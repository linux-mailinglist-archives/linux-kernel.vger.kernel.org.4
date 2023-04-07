Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05C6DA879
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjDGFMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDGFMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:12:47 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D54C2F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:12:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54184571389so778421667b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680844365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uusv0M8pzUZuhFBllleTZFmrVuInj4LMbYNtb9FUd9E=;
        b=UQB10SrC+9suQYS2CMuCOlNeV5lFEP+921z5yMw5670GZ8bRLJ7frNH7DTnvqh4+ub
         xPKzHZfAf8zLpgxryWFIsCA25rKAmjm4dkPSoiYd+ZszwYxy0A/ZGuBGv2Y9+0KivR9c
         cu750HODQxFS2fPFSgBf1QZ/ustdULyrqkXJWVINdX9cE88cNJv60MPaVDvKo7IvGcrz
         iKCeI62SGzPgvgHcy3Qp0R0ebOTbrKMyMmg/zi6A0PmZnmEg+PPuJaF3YmNl/WizHNv7
         Vtb7VS4a4XRMF4M2MFthsnbVfCtdhuqp4xhUcXhHq3iyvUkT1jCdEUCXVp5G21vJabni
         2oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680844365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uusv0M8pzUZuhFBllleTZFmrVuInj4LMbYNtb9FUd9E=;
        b=aFBShkAThpZeR/1q3RsvfH6ymiRt6iEMGc+I0QFife1zy25EjxyGX/pKsfGFd4PNhe
         Sz6wyUG/U9Uj2sGFGdlK/vcLSPNZtQDSBKbmwvPsx0qBJya2LMdDgTFolVQDQbNSIC16
         KxpjHuxtW/wJ64BwgcGnqqVNQmH/OLXydaTsArbsAgQ6nHsbtpToR/UeTlZXb2x5W8tT
         EVXCuiBMb9kfQz61kt67UA2Fmr8la8jVme8qg5RVf2jRdkv58PHgpeCwhoD1tWI66KWd
         KdVDc2q/w74HVAnOTPqay8tMkfJRjxjPYJNtt+7SWB3BFfkPFqQkAdGs/D8RJ3X+ZlYV
         RDSQ==
X-Gm-Message-State: AAQBX9e7AyWYrCMKtOQV/rwovgMcNpTBszx17dCWaMx4yBubSq9rxKhl
        aIrVkzirPCb/4rtC1ruiVd5KMG43rXfXLmhsHZrTxw==
X-Google-Smtp-Source: AKy350ZsYQ7Ar/uGdukXwX+Y6yRNooRBsCYO53br3TJvKjAeBH2LzjDJnwLpWC/CIWLPU1lu8+thSaJn9sRW/dVWcUU=
X-Received: by 2002:a81:ac15:0:b0:546:63a:6e23 with SMTP id
 k21-20020a81ac15000000b00546063a6e23mr470087ywh.0.1680844365042; Thu, 06 Apr
 2023 22:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
 <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
 <20230406000854.25764-1-jaewon31.kim@samsung.com> <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
 <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
 <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
 <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
 <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com>
 <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
 <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p4>
 <CABdmKX3NzTWHa3K_rna1iY+UERUrYK1Rq9WqUt9VQRaAKZsWwg@mail.gmail.com> <20230407022419epcms1p424f1f8a7100aeccac62651ce25cd6140@epcms1p4>
In-Reply-To: <20230407022419epcms1p424f1f8a7100aeccac62651ce25cd6140@epcms1p4>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 6 Apr 2023 22:12:34 -0700
Message-ID: <CABdmKX3qBrOU6K=JXZhU8=oi=quxBqBnVaKiV5p=4uCTLLsRPA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
To:     jaewon31.kim@samsung.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 7:24=E2=80=AFPM Jaewon Kim <jaewon31.kim@samsung.com=
> wrote:
>
> >On Thu, Apr 6, 2023 at 4:38?PM Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> >>
> >> On Thu, 6 Apr 2023 16:27:28 -0700 "T.J. Mercier" <tjmercier@google.com=
> wrote:
> >>
> >> > > When you say "decide what's the largest reasonable size", I think =
it
> >> > > is difficult as with the variety of RAM sizes and buffer sizes I d=
on't
> >> > > think there's a fixed limit. Systems with more ram will use larger
> >> > > buffers for image/video capture buffers.  And yes, you're right th=
at
> >> > > ram/2-1 in a single allocation is just as broken, but I'm not sure=
 how
> >> > > to establish a better guard rail.
> >> > >
> >> > > thanks
> >> > > -john
> >> >
> >> > I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
> >> > WARN_ON. We know for sure that's an invalid request, and it's pretty
> >> > cheap to check as opposed to trying a bunch of reclaim before failin=
g.
> >>
> >> Well, if some buggy caller has gone and requested eleventy bigabytes o=
f
> >:)
> >> memory, doing a lot of reclaiming before failing isn't really a proble=
m
> >> - we don't want to optimize for this case!
> >>
> >The issue I see is that it could delay other non-buggy callers, or
> >cause reclaim that wouldn't have happened if we just outright rejected
> >a known-bad allocation request from the beginning.
> >
> >> > For buffers smaller than that I agree with John in that I'm not sure
> >> > there's a definitive threshold.
> >>
> >> Well...  why do we want to do _anything_ here?  Why cater for buggy
> >> callers?  I think it's because "dma-buf behaves really badly with very
> >> large allocation requests".  Again, can we fix that instead?
> >>
> >There are a variety of different allocation strategies used by
> >different exporters so I don't think there's one dma-buf thing we
> >could fix for slow, large allocations in general. For the system_heap
> >in this patch it's really just alloc_pages. I'm saying I don't think
> >the kernel should ever ask alloc_pages for more memory than exists on
> >the system, which seems like a pretty reasonable sanity check to me.
> >Given that, I don't think we should do anything for buffers smaller
> >than totalram_pages() (except maybe to prevent OOM panics via
> >__GFP_RETRY_MAYFAIL when we attempt to exhaust system memory on any
> >request - valid or otherwise).
>
> I think T. J. also agree with me on what I shared.
>   if (len / PAGE_SIZE > totalram_pages()) return ERR_PTR(-ENOMEM);
>   #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP | __GFP_R=
ETRY_MAYFAIL)
>
Oh yeah, sorry if that wasn't clear. I was referring to your updated
check for just totalram_pages() above, not totalram_pages() / 2.

> Regarding the dma-buf behavior, I also would like to say that the dma-buf
> system heap seems to be designed to allocate that large memory. In mobile
> devices, we need that large memory for camera buffers or grahpics
> rendendering buffers. So that large memory should be allowed but the inva=
lid
> huge size over ram should be avoided.
>
> I agree on that mm should reclaim even for the large size. But that recla=
im
> process may affect system performance or user convenience. In that perspe=
ctive
> I thought ram / 2 was reasonable, but yes not a golden value. I hope to u=
se
> just ram size as sanity check.
>
> Additionally if all agree, we may be able to apply __GFP_RETRY_MAYFAIL to=
o.
>
> BR
