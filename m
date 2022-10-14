Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF65FF47F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJNUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiJNUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:23:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB441D5843
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:23:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so5742095pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EpzOL2I39WBx4qybm1ABKOUs+/6ZbeAJj9uKHcYl/y0=;
        b=rqSEwkAGNU0A9qJXTxV51byK3octUtAdTJqjspf3Zo48mhS2+uaup2U//kMV6Qoi62
         syQwaRn9nsRagawb/MKhDXVvCpux2lI+M4XEw1iDZC0o2HhDC9k5j5PExZukHB5G/Jww
         j6ZItS6qhvBaudYRlPHGRKhhJBskxFwmJ78+J+X/HkBc6g758120CU0/QzDCX9fV81e4
         Eq4ii2IUaIpi9bIJt80Lspql5uGcRZWW9z8VL+EdbkVPXwT4p5ov9Q0wzUY09iwHM/MJ
         H5vBxIMqou+Z9ewA89od4rWZTGb9L0mvjcwT/loTUek4I3GIZ9PlVAhIZ1LDxwyojwlB
         VDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpzOL2I39WBx4qybm1ABKOUs+/6ZbeAJj9uKHcYl/y0=;
        b=qlOu+ErcEDu9pRcQBdYOpZczXJlIvVga1U110xztnifLJMbZLNHACmPAmvUf8VtHyu
         YPPSng72ceC7GYYUFwwXyzr6+R5qwSoz2nBqIWsNgPCosDy37u6lnj+iuxJfyoyfCf5p
         6dHkyWK1VBMYoc/HKytQbWHfr4Jtj8nxu69XC+7TBDU8Jx/SZqjOV1yuMxubYrw+iG7i
         uAbyTxD1FJxTOz1auAwazCNuRZVEOGBUpgyY+D/YWzQS+P9XwWuSteHQJ9OiKQ2VcXpv
         Z1VhBjOradarkBDXodbCrKdvpvh8wxEgYxE2t3jTfLp8Va+gzJ9n/IqhrITWHO6G65l3
         z4qA==
X-Gm-Message-State: ACrzQf19SKwaeA2OqDdNVt3T0Nox8M8vgAeOhtUkGyNwtWMsH0kgM9nu
        Rl9C5lcmMkVTTnKC9CtfZxxsK6Mr+7fo7wJhYXWIhw==
X-Google-Smtp-Source: AMsMyM5uLYl1iWzreHrWhR8NbPrXI1BfqD4vW2V0ddYzchLa9asDA1jsxo2N0h00jt4kdett3c5jH+ZmRt7EltGyW0o=
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id
 q6-20020a170902f78600b001806f9e023bmr7264149pln.37.1665779019201; Fri, 14 Oct
 2022 13:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com> <Y0hDdmD0yJ+PS2Kz@arm.com> <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
 <Y0mNek2pRpXexZxX@arm.com>
In-Reply-To: <Y0mNek2pRpXexZxX@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 14 Oct 2022 13:23:02 -0700
Message-ID: <CAGETcx9zGaFFBqQ8d4kF-jz3nOjyShkbu3Z4YHpFY9_N+16g-w@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kernel-team@android.com
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

On Fri, Oct 14, 2022 at 9:25 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Oct 13, 2022 at 11:58:22AM -0700, Saravana Kannan wrote:
> > On Thu, Oct 13, 2022 at 9:57 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > If so, would there be concerns that the memory savings we get back from
> > > > reducing the memory footprint of kmalloc might be defeated by how much
> > > > memory is needed for bounce buffering?
> > >
> > > It's not necessarily about the saved memory but also locality of the
> > > small buffer allocations, less cache and TLB pressure.
> >
> > Part of the pushback we get when we try to move some of the Android
> > ecosystem from 32-bit to 64-bit is the memory usage increase. So,
> > while the main goal might not be memory savings, it'll be good to keep
> > that in mind too. I'd definitely not want this patch series to make
> > things worse. Ideally, it'd make things better. 10MB is considered a
> > lot on some of the super low speced devices.
>
> Well, we can still add the option to skip allocating from the small
> kmalloc caches if there's no swiotlb available.

This seems like a good compromise.

> > > I wonder whether swiotlb is actually the best option for bouncing
> > > unaligned buffers. We could use something like mempool_alloc() instead
> > > if we stick to small buffers rather than any (even large) buffer that's
> > > not aligned to a cache line. Or just go for kmem_cache_alloc() directly.
> > > A downside is that we may need GFP_ATOMIC for such allocations, so
> > > higher risk of failure.
> >
> > Yeah, a temporary kmem_cache_alloc() to bounce buffers off of feels
> > like a better idea than swiotlb. Especially for small allocations (say
> > 8 byte allocations) that might have gone into the kmem-cache-64 if we
> > hadn't dropped KMALLOC_MIN_ALIGN to 8.
>
> I now remembered why this isn't trivial. On the dma_unmap_*() side, we
> can't easily tell whether the buffer was bounced and it needs freeing.
> The swiotlb solves this by checking whether the address is within the
> pre-allocated swiotlb range. With kmem_caches, we could dig into the
> slab internals and check whether the pointer is part of a slab page,
> then check with kmem_cache that was. It looks too complicated and I'm
> rather tempted to just go for swiotlb if available or prevent the
> creation of small kmalloc caches if no swiotlb (TBH, even the initial
> series was an improvement dropping KMALLOC_MIN_ALIGN from 128 to 64).

Agreed. Even allowing a 64-byte kmalloc cache on a system with a
64-byte cacheline size saves quite a bit of memory.

-Saravana
