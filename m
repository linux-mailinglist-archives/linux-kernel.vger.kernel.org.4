Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914C5F25DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJBWJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:09:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432638685
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 279F9B80DD8
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF317C433D6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664748538;
        bh=HfH4SXjoakBAXCnyUt76Zo2AktATIjMnXSVMSbQybwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=skUXldGKEjsSoWONew9/z6Em/MECHl3mpGGkv9FrbVUHZwZ9kC0pLmEQtX++slog7
         gorbTNqT6LY+1JEmP2ORe0mvtbJlQP9Gpx5ms6TnXCiAxwr+rSBizR6eeyaODCbbI0
         nrTVslhUkbeeYkl2wWpQwsfsStcax13Ra6McM28l/Tt0/NqHVNH9bD7ilsDF8hk00u
         WTQgTznDp7QMWKeuHhI27ivlgyt7KNKP5SLQM5tVp81xxK1h4yJvAyiULUD8EC6qkm
         /C1PCC4npfhqjlTV8/uc65LbKRPZY3iN7XvKAQ4TAAaWIqHC9AYc4uJ6mUIZyIsWTH
         9aDc+3wNjsMbQ==
Received: by mail-lf1-f45.google.com with SMTP id bu25so14186159lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 15:08:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf2KiuYr2qgJlNmMckB5iGJCUUlrp4tUoA3vc9SYST5Uof7VAB7t
        x6iNGjXSXCYQ0fBy0IfMbrjoNNlep5g4LkoHYbg=
X-Google-Smtp-Source: AMsMyM6Vdy1cSlR/92G2FLcKbxMWKKMKNWEi8NpZ+BN5QLTAlj2FTfDhj9at3UkO+w7Eo8/0f3jY6CP2H/8+sRUOoi8=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr411616lfc.228.1664748535957; Sun, 02
 Oct 2022 15:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au> <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
 <Yzi/X12rQTuT9Uqk@arm.com> <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
In-Reply-To: <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Oct 2022 00:08:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQH_Z+_HKOOd8LkzwPpbMahihT89qCDkB=ofCkicoYdA@mail.gmail.com>
Message-ID: <CAMj1kXHQH_Z+_HKOOd8LkzwPpbMahihT89qCDkB=ofCkicoYdA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 at 19:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Oct 1, 2022 at 3:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > The "force bouncing" in my series currently only checks for small
> > (potentially kmalloc'ed) sizes under the assumption that intra-object
> > DMA buffers were properly aligned to 128. So for something like below:
>
> Ahh, so your forced bouncing isn't actually safe.
>
> I would have hoped (but obviously never checked) that the force
> bouncing be made really safe and look at the actual alignment of the
> DMA (comparing it to the hardware coherency requirements), so that
> alignment at allocation time simply wouldn't matter.
>
> At that point, places like the ones you found would still work, they'd
> just cause bouncing.
>
> At which point you'd then have a choice of
>
>  (a) just let it bounce
>
>  (b) marking the allocations that led to them
>
> and (a) might actually be perfectly fine in a lot of situations.

Non-coherent DMA for networking is going to be fun, though.
Fortunately, we'll only need to bounce for inbound DMA (where the
cache invalidation might otherwise corrupt adjacent unrelated data),
and for inbound networking, the driver typically owns and maps the
buffers, and so in most cases, it can hopefully be easily modified to
round up the allocations and the length values passed to
dma_map_xxx(). And for outbound, we can just clean the SKB from the
caches without the risk of corruption.

It does mean that there is likely going to be a long tail of network
drivers that will non-negligibly regress in performance and in memory
footprint (as the entire RX ring will be double buffered all the time)
until they get updated.

-- 
Ard.
