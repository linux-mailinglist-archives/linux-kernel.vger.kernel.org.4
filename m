Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249368DE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBGQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:56:21 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A365BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:56:20 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-52a849206adso57851837b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoBqPByP0q/RasE1UC460ExA2FKRxZXp/KeIkZ7c+rM=;
        b=sm9YPiJH9InbcrluLaZ8PfuBNR+JO/cR+R+Wps0a7BDKmT92kwftQaJPhjPTXmxqF+
         Gd/gTg3u9TklZp/h6sSeNUdyAVdB/BNlDDR+Cotrb+X1atYx087sh0XzFMQflrKJafsq
         Xc0UjRFv1hIUseZVxZPdAQcrWeIJ7UzKEPSt28eQyQtrGWNcEX2+aYhZW1T/NG9bDjGC
         JMzFWtXiEyjOqV9zs6OVK/81+8vjN0M7X9V+0aHejQEjBk1pEc26sBF3BgfaUjEG2k3A
         o3FEtuIozUy6W/cjtA29E14qRb9Brz3C9KZyGzzku4mPgeSBerDrKuYc8cU8Ggu9yea1
         8YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoBqPByP0q/RasE1UC460ExA2FKRxZXp/KeIkZ7c+rM=;
        b=b3PMSODW7qOzXldv4o9Rjq+ktQG4hCIrriT7RSHbsa9YYS314OZ299gG9atoP0XWay
         0mkL8vaBkCiNCRBwyUzPWhApjb5yK+02BsrCF85DeAvkhCMELN/NXAauFEyEC+IbvxQ0
         k7F4keF8tQEUYW4F9D4yVT2kS+iZgHHTsIfvlPfNHzTlFGG0pAhZQTGSr3b877QLwxBC
         5gBbvfdhh+gm9iMJbN0IQHm+H3xKKS15AKGgXRadDpEbcFDIw0kniSlearQ0vGko4Tru
         xPjIYEptcqPM4RMhUBGwHcYYDIFPGMpRQbbPw+Xq5zm6nWyQPzXL7eiMO5Z9ocYf9inp
         ZYZA==
X-Gm-Message-State: AO0yUKWyXvaljhD67RXM0KYAa3FJI3YnRcPTDpV7KPsX4ItzddFjhyrp
        QICvmKxpfQUAnA9iaXkbd3pWNG617mDJl/AEFzj7
X-Google-Smtp-Source: AK7set/lGFUD8trb7Vv6Bm1hGBjXHqr17EYv+SAYpiRHAofHJ+9Oij26D22fEgTKfXmq0epDM0gmSsU2vbH91U8kxpw=
X-Received: by 2002:a0d:cc8d:0:b0:52a:858b:2840 with SMTP id
 o135-20020a0dcc8d000000b0052a858b2840mr388141ywd.14.1675788979659; Tue, 07
 Feb 2023 08:56:19 -0800 (PST)
MIME-Version: 1.0
References: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
 <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
 <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
 <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
 <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
 <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
 <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com>
 <20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa@epcms1p8>
 <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p1>
 <CANDhNCrAMVT3rg0GPJhYKD75EAUn8bsivrp3yMJcsd6bouj1rQ@mail.gmail.com> <20230207073335epcms1p15df191db83bec0cb791e6f79dcecb31f@epcms1p1>
In-Reply-To: <20230207073335epcms1p15df191db83bec0cb791e6f79dcecb31f@epcms1p1>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 7 Feb 2023 08:56:07 -0800
Message-ID: <CANDhNCpM+R0sPuGoeBW0=he+6YMKTn2YLm4AZZ2+C=5YRLZBLg@mail.gmail.com>
Subject: Re: (2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "T.J. Mercier" <tjmercier@google.com>,
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

On Mon, Feb 6, 2023 at 11:33 PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> >I don't mean to discourage you, especially after all the effort here.
> >
> >Do you think evaluating the before and after impact to buffer usage
> >
> >(not just allocation) would be doable in the near term?
> >
>
> Hello sorry but I don't have expertise on iommu. Actually I'm also wondering
> all IOMMU can use order 4 free pages, if they are allocated. I am not sure
> but I remember I heard order 9 (2MB) could be used, but I don't know about order 8 4.
>
> I guess IOMMU mmap also be same patern like we expect. I mean if order 4 is
> prepared it could be faster like 1 to 4 times. But it, I think, should NOT be
> that much slow even though the entire free memory is prepared as order 0 pages.
>
> >
> >
> >If you don't think so, given the benefit to allocation under pressure
> >
> >is large (and I don't mean to give you hurdles to jump), I'm willing
> >
> >to ack your change to get it merged, but if we later see performance
> >
> >trouble, I'll be quick to advocate for reverting it.  Is that ok?
> >
>
> Yes sure. I also want to know if it is.

Ok. Please resend your latest patch and I'll go ahead and ack it and
we'll watch.

Thanks again for your efforts here!
-john
