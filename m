Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7406466F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLHC2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:28:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5091C90D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:28:41 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id j26so22994qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 18:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIgQlGgIhG0OyS9HpmOnPmbLmlsWRwhH6Vpd/TwqCvQ=;
        b=nV61V+0I6eYrGFW1p+5LVtYxcfpX/y7oJlL0H6uc0elYp2gDgMyIlTJSUabfxQ882P
         evY5nrrS9CVgdAVcC5LYXqR/DbV2hxQFRn77mR1/TytPb5Qxe0des2U3ZSkKh23E2EX9
         YobHjvRO7KIbM2pkCB1Okd+wqPwdXMKZxcveCuZxhyT1l3DfC/I8meBZxBPbvL/VMZ70
         WVq7Yo6ifEdkiKQkTBmTCaQn4QzyfgvRhj3PfWn5mBNtOODA6BUpjJYzaNRJtpNhCvRh
         2lCKX/pA9Pu5URzpELxRaaqiWEWAGYbnpRw0HqqLVuy0UyQyE/M701sFwoqJeYwyHelR
         vNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIgQlGgIhG0OyS9HpmOnPmbLmlsWRwhH6Vpd/TwqCvQ=;
        b=UsEA1di15S80Hg72J5dXOUr7Gb+ylqaIT6TwPAU25pzZgLDZxdAZpzInWZs0sbhRWU
         Ql2cr+G1yCmrkDf1jW/UIp1IDG163RSS6yH02Q418FY+EjB+Trcl0qZnU1QZxyNn/Pjb
         7skuuQOlcORwnKz3YIr/APWVghVzv7846J/zJbZhkgMnyvb2D20c2Jh8GDne90NM294T
         sciNKbAsl2L8BxNuE2lFcR/N90D4lImTc5ETxM7gDfcQPeCSa/3B9NISN8fEYq/rWzBx
         oWzwwrNyOBsiVSqv9ZSUgY/9oIUynl74vF/gnpin5phzRdpb5VUYOCcP9RxuJCkXWp0u
         LyWg==
X-Gm-Message-State: ANoB5pk7F9VYVR+PozIKXYMfI2Lfqn2DpgXHheR9lYzaWnYvoFQfSSLj
        xpjtvcoLIxGppM2FiFaeEboJhSSlF8CMkf1w66Q=
X-Google-Smtp-Source: AA0mqf5/EtPujVXQkApq24nbl/NeWW+sfSIpoXYh4B8ivcTaOm1SAs/haloyLnJuEzER7muTFMbv5IktK49fIZCCydc=
X-Received: by 2002:a37:b944:0:b0:6fa:3699:e69e with SMTP id
 j65-20020a37b944000000b006fa3699e69emr81720160qkf.187.1670466520092; Wed, 07
 Dec 2022 18:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20221207135223.3938-1-jundongsong1@gmail.com> <86a63zkzru.wl-maz@kernel.org>
In-Reply-To: <86a63zkzru.wl-maz@kernel.org>
From:   Harry Song <jundongsong1@gmail.com>
Date:   Thu, 8 Dec 2022 10:28:29 +0800
Message-ID: <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 11:19 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 07 Dec 2022 13:52:23 +0000,
> Harry Song <jundongsong1@gmail.com> wrote:
> >
> > I know this is a very wrong patch, but my platform
> > has an abnormal ITS problem caused by data consistency:
> > My chip does not support Cache Coherent Interconnect (CCI).
>
> That doesn't mean much. Nothing mandates to have a CCI, and plenty of
> systems have other ways to maintain coherency.
>
> > By default, ITS driver is the inner memory attribute.
> > gits_write_cbaser() is used to write the inner memory
> > attribute. But hw doesn't return the hardware's non-shareable
> > property,so I don't think reading GITS_CBASER and GICR_PROPBASER
> > here will get the real property of the current hardware: inner
> > or outer shareable is not supported, so I would like to know
> > whether ITS driver cannot be used on chips without CCI, or
> > what method can be used to use ITS driver on chips without CCI?
>
> It's not about CCI or not CCI. It is about which shareability domain
> your ITS is in.
>
> And it doesn't only affect the ITS. It also affects the
> redistributors, and anything that accesses memory.
>

Yes, my current chip is Rockchip platform (rk3588), so is it because the chip
is not designed as a proper shared domain for ITS, so the exception of
ITS is caused?

> >
> > The current patch is designed to make ITS think that the current
> > chip has no inner or outer memory properties, and then use
> > its by flushing dcache.
> >
> > This is the log for bug reports without patches:
> >
> > [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000003460000
> > [    0.000000] ITS [mem 0x03440000-0x0345ffff]
> > [    0.000000] ITS@0x0000000003440000: allocated 8192 Devices @41850000 (indirect, esz 8, psz 64K, shr 0)
> > [    0.000000] ITS@0x0000000003440000: allocated 32768 Interrupt Collections @41860000 (flat, esz 2, psz 64K, shr 0)
> > [    0.000000] GICv3: using LPI property table @0x0000000041870000
> > [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000041880000
> > [    0.000000] ITS queue timeout (64 1)
> > [    0.000000] ITS cmd its_build_mapc_cmd failed
> > [    0.000000] ITS queue timeout (128 1)
> > [    0.000000] ITS cmd its_build_invall_cmd failed
>
> Ah, this suspiciously looks like a Rockchip machine...
>
> >
> > Signed-off-by: Harry Song <jundongsong1@gmail.com>
> > ---
> >
> > I am very sorry to bother you. This problem has been bothering me
> > for several weeks.  I am looking forward to your reply.
>
> If you have such issue, this needs to be handled as per-platform
> quirk. I'm not putting such generic hacks in the driver.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Are there currently other chip platforms that have this problem, and then ITS
is already compatible with the problem? Please tell me how to submit
hacks patch for rk3588 platform?

If the hacks patch cannot be submitted, please tell me whether it
requires the next generation
chip to have any design requirements for ITS?

Design ITS and CPU to be the same inner memory property?


Thank you very much for your answer,
Harry
