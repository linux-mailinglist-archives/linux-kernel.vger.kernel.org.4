Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2476624FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjAIMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbjAIMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:04:19 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCAE1AA0B;
        Mon,  9 Jan 2023 04:04:12 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g8so4014202qkl.2;
        Mon, 09 Jan 2023 04:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVNn+YWwJiRPXNtsBieyEVWKNIb/zkrUFPfCeEPxMWw=;
        b=lVpGq0jRiH44fjieSWWDZP5itmNjimKwXoQjLA1EN74wGirOQjNnMTLfiYkb6HM4nU
         nzOiEF75i37tGplMLvwTJs6FiJtQ5Z4nActSx6jbLudKWge3rJFSdxC6PJtEWRAo953m
         GU9mVKdUaN03GRIkjLdeXSbrgtVzPHIhHFQBITbKJtH8EqrVohn1wN1Iqn5TRtw7vFCX
         Nn5Tp2CDucUfAeu0h25UZuZPUWt7a5qCppBRRILLJoOmPocn1Utvhhcz8Vi4HT3M3aAy
         6LY8RXVzInyCeWRvc2Rp+v3eFHGDequzembAnK+UmHGh/bpemH33EHzxJoBVaTaZYAsF
         xzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVNn+YWwJiRPXNtsBieyEVWKNIb/zkrUFPfCeEPxMWw=;
        b=7d/+nL5gxgkYEpOvviqUfJWAa7UX/V0wUK9o9nx5o/TrpGli9nWZcOqvn4Sb0Yftou
         X20ICh36EEM9PVvrNlJmq6bAx2Wzj0IR/52FDq10j67jCI2YlqlyutYx9zhcQsGlV8cV
         XnkVAHJ2vZ6vnIwqKXPjyaeTwm8aQDwFFXkjjqeW6HJk2ZSw6eezy/OZiBhFalAPv+5X
         ET3tu99xXOyUS92BnB/AjnFcWjGt1hbLk/5jQE7lj13diu/3EYzXSZKlJEbcUIeaqzhh
         GcKkN7d6kmLus/TT7WmhIgxfxsJWM4u9j5HE7yGY3WD88PKngH7b2r2pvcKmQl32PwN1
         W12g==
X-Gm-Message-State: AFqh2kpRjmnEThDfGXQOVM5ucw3v35ACbfmX6wFtyA6zmp6ZXcOhxp82
        nHsbg32/T02O0nwLGJEyHZg+B6ftmFKqdcUaIkY=
X-Google-Smtp-Source: AMrXdXtab23RPB/2ZXMcLY+PmC+jyscFXBJ8G2+xrfC95CqdAo2Wg45jeC1lnEQ0GwjR0BdWjHn+PJpw//FCdU9RsGI=
X-Received: by 2002:a05:620a:1001:b0:6ff:7b95:633e with SMTP id
 z1-20020a05620a100100b006ff7b95633emr2573684qkj.689.1673265851185; Mon, 09
 Jan 2023 04:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com> <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
In-Reply-To: <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 Jan 2023 12:03:44 +0000
Message-ID: <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 12:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jan 7, 2023, at 23:10, Lad, Prabhakar wrote:
>
> >> > +
> >> > +     memset(&thead_cmo_ops, 0x0, sizeof(thead_cmo_ops));
> >> > +     if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO)) {
> >> > +             thead_cmo_ops.clean_range = &thead_cmo_clean_range;
> >> > +             thead_cmo_ops.inv_range = &thead_cmo_inval_range;
> >> > +             thead_cmo_ops.flush_range = &thead_cmo_flush_range;
> >> > +             riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
> >> > +     }
> >>
> >> The implementation here looks reasonable, just wonder whether
> >> the classification as an 'errata' makes sense. I would probably
> >> consider this a 'driver' at this point, but that's just
> >> a question of personal preference.
> >>
> > zicbom is a CPU feature that doesn't have any DT node and hence no
> > driver and similarly for T-HEAD SoC.
>
> A driver does not have to be a 'struct platform_driver' that
> matches to a device node, my point was more about what to
> name it, regardless of how the code is entered.
>
> > Also the arch_setup_dma_ops()
> > happens quite early before driver probing due to which we get WARN()
> > messages during bootup hence I have implemented it as errata; as
> > errata patching happens quite early.
>
> But there is no more patching here, just setting the
> function pointers, right?
>
Yes that's right.

> >> > +struct riscv_cache_ops {
> >> > +     void (*clean_range)(unsigned long addr, unsigned long size);
> >> > +     void (*inv_range)(unsigned long addr, unsigned long size);
> >> > +     void (*flush_range)(unsigned long addr, unsigned long size);
> >> > +     void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
> >> > +                                           enum dma_data_direction dir,
> >> > +                                           enum dma_noncoherent_ops ops);
> >> > +};
> >>
> >> I don't quite see how the fourth operation is used here.
> >> Are there cache controllers that need something beyond
> >> clean/inv/flush?
> >>
> > This is for platforms that dont follow standard cache operations (like
> > done in patch 5/6) and there drivers decide on the operations
> > depending on the ops and dir.
>
> My feeling is that the set of operations that get called should
> not depend on the cache controller but at best the CPU. I tried to
> enumerate how zicbom and ax45 differ here, and how that compares
> to other architectures:
>
>                   zicbom      ax45,mips,arc      arm           arm64
> fromdevice      clean/flush   inval/inval   inval/inval   clean/inval
> todevice        clean/-       clean/-       clean/-       clean/-
> bidi            flush/flush   flush/inval   clean/inval   clean/inval
>
> So everyone does the same operation for DMA_TO_DEVICE, but
> they differ in the DMA_FROM_DEVICE handling, for reasons I
> don't quite see:
>
> Your ax45 code does the same as arc and mips. arm and
> arm64 skip invalidating the cache before bidi mappings,
> but arm has a FIXME comment about that. arm64 does a
> 'clean' instead of 'inval' when mapping a fromdevice
> page, which seems valid but slower than necessary.
>
> Could the zicbom operations be changed to do the same
> things as the ax45/mips/arc ones, or are there specific
> details in the zicbom spec that require this?
>
I'll let the RISC-V experts respond here.

Cheers,
Prabhakar
