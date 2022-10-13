Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3413D5FE251
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJMTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJMS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:59:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649D2BE7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:59:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so5769700pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvYKf46PHYOJmgAyRzyeuv+VB39gNOqGOLL0irz94w8=;
        b=XaLwORTRw/VjAx8bIXFDPdJv+yW2cfiKbNkmIVGLr13TNgc9m0vr5RgDMXx7XjT3Ds
         zgDShhQEZ7fgrfAwm1OKMQUesnA8JrFtTZaZJCEGZajR40efwKr6RnAjP9YsAnU2jouL
         Rp6geHRvpjNyicZAj3JC1i3e5Lphd0K6h9lg2GTmEv6cxcJnF5ngqLk8/uw3lg03YpqV
         bTVK0z7SWIg/kk49S9NN/QRCsFr5lAuc7pMFeKAYZtuZXbBMSCnvOBupJppWBbvKTiAa
         y9MZLkyuPon0NTUdecV0girE/Wci3yk2WoK8wbXWh3wXk/Fkho6Jkf5tKEcQVM3E2NLt
         RxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvYKf46PHYOJmgAyRzyeuv+VB39gNOqGOLL0irz94w8=;
        b=F2lyxlRyT7/oHaIvoJNX6/OPSFrQLA/vbGnd5VTKfztRdIX/iyAI1s6Eh3pAU5Vl2b
         a+UTtrDvB8bnkThsjMPVe2Jp2CBeIZzUcKlvCn6zmzlJQsWLaAXChB2loi0rGfEix1fl
         0ig7yio/Z5oSyI7gv3TL5kQw2ZEsYOXmUgccELQqfDKWucWpcJTrAG3Ea/Rw5HKrmg1Z
         ckbrTPE95l6Xl3EsCcfD04hmvS3SGzC9gUk+SDr6k/ji8nTmQ6E4YbPXKq0et/U5EbZk
         V5SXZcMyR8U5HbRYf5qLGEa18RzVIyuBgVuK74HzTTxj617kDP3sFkWBdLwWgiw6H9Qe
         LMFg==
X-Gm-Message-State: ACrzQf1ZJqBxhd+HTAYM35sCqH5hNXgKHONzuuYMyifBYMU8rMzUvES6
        pVZPUgt5NpYFI/M+wVjcgYdSdhmmm6r2sl7tOsbwvg==
X-Google-Smtp-Source: AMsMyM65XwEcTC02Hor+zH+xGlpmE0yqlKAfmOVJU77FscI+UawvphHQez4IhZ/CVKiNivFX6KEnjFlKvT2hlTBIalg=
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id
 q6-20020a170902f78600b001806f9e023bmr1420066pln.37.1665687539427; Thu, 13 Oct
 2022 11:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au> <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <Y0b9SYI7v94ig5v8@google.com> <Y0hDdmD0yJ+PS2Kz@arm.com>
In-Reply-To: <Y0hDdmD0yJ+PS2Kz@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 13 Oct 2022 11:58:22 -0700
Message-ID: <CAGETcx8SZ8XjyTveh2iWiHK09iOpU_fsOkFcBL_EG4Qp93A_wA@mail.gmail.com>
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

On Thu, Oct 13, 2022 at 9:57 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Oct 12, 2022 at 10:45:45AM -0700, Isaac Manjarres wrote:
> > On Fri, Sep 30, 2022 at 07:32:50PM +0100, Catalin Marinas wrote:
> > > I started refreshing the series but I got stuck on having to do bouncing
> > > for small buffers even if when they go through the iommu (and I don't
> > > have the set up to test it yet).
> >
> > For devices that go through the IOMMU, are you planning on adding
> > similar logic as you did in the direct-DMA path to bounce the buffer
> > prior to calling into whatever DMA ops are registered for the device?
>
> Yes.
>
> > Also, there are devices with ARM64 CPUs that disable SWIOTLB usage because
> > none of the peripherals that they engage in DMA with need bounce buffering,
> > and also to reclaim the default 64 MB of memory that SWIOTLB uses. With
> > this approach, SWIOTLB usage will become mandatory if those devices need
> > to perform non-coherent DMA transactions that may not necessarily be DMA
> > aligned (e.g. small buffers), correct?
>
> Correct. I've been thinking about this and a way around is to combine
> the original series (dynamic kmalloc_minalign) with the new one so that
> the arch code can lower the minimum alignment either to 8 if swiotlb is
> available (usually in server space with more RAM) or the cache line size
> if there is no bounce buffer.
>
> > If so, would there be concerns that the memory savings we get back from
> > reducing the memory footprint of kmalloc might be defeated by how much
> > memory is needed for bounce buffering?
>
> It's not necessarily about the saved memory but also locality of the
> small buffer allocations, less cache and TLB pressure.

Part of the pushback we get when we try to move some of the Android
ecosystem from 32-bit to 64-bit is the memory usage increase. So,
while the main goal might not be memory savings, it'll be good to keep
that in mind too. I'd definitely not want this patch series to make
things worse. Ideally, it'd make things better. 10MB is considered a
lot on some of the super low speced devices.

> > I understand that we can use the
> > "swiotlb=num_slabs" command line parameter to minimize the amount of
> > memory allocated for bounce buffering. If this is the only way to
> > minimize this impact, how much memory would you recommend to allocate
> > for bounce buffering on a system that will only use bounce buffers for
> > non-DMA-aligned buffers?
>
> It's hard to tell, it would need to be guessed by trial and error on
> specific hardware if you want to lower it. Another issue is that IIRC
> the swiotlb is allocated in 2K slots, so you may need a lot more bounce
> buffers than the actual memory allocated.
>
> I wonder whether swiotlb is actually the best option for bouncing
> unaligned buffers. We could use something like mempool_alloc() instead
> if we stick to small buffers rather than any (even large) buffer that's
> not aligned to a cache line. Or just go for kmem_cache_alloc() directly.
> A downside is that we may need GFP_ATOMIC for such allocations, so
> higher risk of failure.

Yeah, a temporary kmem_cache_alloc() to bounce buffers off of feels
like a better idea than swiotlb. Especially for small allocations (say
8 byte allocations) that might have gone into the kmem-cache-64 if we
hadn't dropped KMALLOC_MIN_ALIGN to 8.

-Saravana
