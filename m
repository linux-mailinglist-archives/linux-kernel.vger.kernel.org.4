Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C394763FFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLBFES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLBFEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:04:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDCCF7A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:04:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so3645077plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 21:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKYS0jpJbkIqxASXUqLjfSITbe2oU3nanhe00O7VSVI=;
        b=AgI4sbAaYF05oUj5+9tB/44lCq5vuYoki64AfWNo1FHcmjo9mQ+mgoN8xpQf8CX5Fe
         F9H3IORJE68/bKO21HfXusNxNvubMYDPTFhf05XsWms3KHoZS6kUL6WE1J1wwAe7KbgT
         ufonXrWpfVtdkaz2AP+vB4LbnJYTwzLCe5+seYyBqM23eYvZ7d/AbraLkAOrwaOgpbME
         NIlF2RAIVWIxTsVJPQRIgecmlJyUUXgZkvwRKVNdhI1d+uBENjckDSxHnjYH4YIOfw/G
         QY07xuk7L6APA5F5n3/afGhaQD3yhUjOWrTgIrJu38SCeY7lNTNo1e6U4lWBDARN4VTB
         TqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKYS0jpJbkIqxASXUqLjfSITbe2oU3nanhe00O7VSVI=;
        b=V+i/Wdn4H056rrUjTh+eAOLaBGtNG98hwX74RjUsOhBz27e1SXu05GmMMThOMdja7n
         JDsHMO9fh1WOGFJ+Bkq/PQm62h0WijIXjfqzWPBqL206Qj1oR4U1c0Ev9Qia1Kji0kAM
         XIEJsVVXvsSLHe+KAqqzTjZF5aRBcW15bJuLlbBx4XUVrhAzZKEfUkB72RBwoSGgxNrl
         3KzFUlNEsdbXGvWCcFTOi+cDBjgAh0F9/qWOjJQe0Lzv+FnLNgyZqw1VOFyMUnG8siC6
         4L3R/klbEZyUmtTmE82kEAQ2ahb9/CqZ0q/jC17B/Xaw6Xn9qlwYpvBNT3vCPnRoznbj
         o4kg==
X-Gm-Message-State: ANoB5pmCnlA3Txnq3UZitPUg0rlF/647c7SBciCHjte8lgpvFPsc+2gp
        iQHEp44bm9/cX7wu3SDJRgdGx3OuhLcHWFnSGC6LiA==
X-Google-Smtp-Source: AA0mqf55l/aEVbdhJaayQjSQsgVyfIaQL0naLHHG9mxExGrPbkRJdowf+4jmYJdVjh/R0rm0SD0Betn8VWlF6C8nkBU=
X-Received: by 2002:a17:90a:df0e:b0:20b:22fb:2ef with SMTP id
 gp14-20020a17090adf0e00b0020b22fb02efmr80646165pjb.158.1669957453812; Thu, 01
 Dec 2022 21:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
 <20221201130135.1115380-4-apatel@ventanamicro.com> <87v8mvqbvq.ffs@tglx>
 <CAK9=C2WN57hHUz=3SDruyWPdAobn+QP8uGwugjPAobeFG7dBkw@mail.gmail.com> <87h6yer1z4.ffs@tglx>
In-Reply-To: <87h6yer1z4.ffs@tglx>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 2 Dec 2022 10:34:00 +0530
Message-ID: <CAK9=C2Vnp9gTqX7AHxqCaVzVx1qGGRE0fCG1uxQUnh6n0dSm-g@mail.gmail.com>
Subject: Re: [PATCH v14 3/8] genirq: Add mechanism to multiplex a single HW IPI
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 7:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Anup!
>
> On Thu, Dec 01 2022 at 23:30, Anup Patel wrote:
> > On Thu, Dec 1, 2022 at 10:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > irqchip driver and it is shared by various RISC-V irqchip drivers.
> >>
> >> Sure, but now we have two copies of this. One in the Apple AIC and one
> >> here. The obvious thing to do is:
> >>
> >>    1) Provide generic infrastructure
> >>
> >>    2) Convert AIC to use it
> >
> > Mark Z already has a converted version of AIC driver.
> > https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-mux
>
> You are submitting generic infrastructure which is supposed to go
> through the relevant maintainer tree and not be funneled through some
> riscv branch.
>
> So obviously this very maintainer asks the predictable question and also
> wants to see the Acked/Tested-by of the folks who maintain apple-AIC.

Not CCing apple-AIC maintainers was purely accidental.

Actually, I had started off ipi-mux with the intent to share across
RISC-V irqchip drivers. Only in recent patch revisions (based on
suggestion from Marc Z), I tried to converge and make it useful
for apple-AIC driver as well. Unfortunately, I don't have apple HW
for testing this so I was hoping someone will help.

Thanks to Marc Z, we now have a patch for apple-AIC driver as well.

>
> How is that supposed to work without integrating this patch into your
> series and without having the apple-AIC folks on cc?

Okay, I will include the apple-AIC patch from Marc Z in the next revision
and add apple-AIC folks in CC.

>
> You did not start kernel development as of yesterday, right?
>
> Thanks,
>
>         tglx

Regards,
Anup
