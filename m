Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6946396F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKZQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:00:44 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51596193D4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:00:43 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-14286d5ebc3so8395012fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wpP6JR3ohpFtxNxi+eQL8kVyFvR7jXdT/GTV32yyhaQ=;
        b=kofHMRzIYR+4yok+psbGjNw6OL2V8qRtJW6d0Tb9Z/tdOqPn3OkZQFgFAOnI0+F6Lk
         Nuyvd+wJ3W5mJlTQjlXEBngB5lzzs2FHj8YXcBEnudGLl6kb+JsE08kpBoQr/MVfU3Tq
         VVHMJKNaIto1H7BzgeGp4q3Oa+A5rwYyGS3P59UiBUHRNkZq+4QyFz2rzdQGhVWP7v8a
         ku6Ko8H8ZWWhjK+gazLuQ/3gPbOm8ipfNZefedBKHyikDJ9a4DP8aF2AEWgEX8lI/zhG
         Ocl6hMJmT+4jiwhoWivL82vx8XQNIk+11ka59vd1gSkK+7BVfGX9aypZaHDQwXzZNpbo
         HDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpP6JR3ohpFtxNxi+eQL8kVyFvR7jXdT/GTV32yyhaQ=;
        b=VAy3pSWEyECydDsRsCieMO79FOWxXDZyt5teE714SqPmfsZ4SiARDFJrzKlLV4QKQe
         OprGiM1odHaF7G+cox7BohLO2Pc2A9PYQ72U2TISz+Wyo7uzHsgM48m737PuAjazbyfP
         s/8QSTUUNOOsKT6IxzEFG0LLF/BfwtWx3vOvPHhWmR8xDr5cYFsSpLaT1aPW0B7tQZuV
         kQoUiitT3kywRawsh3krL2cAbzNPiQaox+PLRRKNOerlvKDnlgboMw9zHffYunDpkFPh
         6ICRjZfthRSQ5SquMrWIHCQqEERVNCec1OvvResh6tk2oo2XvHZNkj0CkbxMPxdlM6J+
         skfA==
X-Gm-Message-State: ANoB5pktizlCOZx0czfQQ+6+02fvfoeNqHBUKLVRbEwem/RGwkHGuMUP
        UNKzffWdg1y5RZGB4+pI4e6C/nBxa0E3Bc0c/ZdBuA==
X-Google-Smtp-Source: AA0mqf5T3W5wYZEA20m4aqdjFwdIOFOK3DoSU1V4DKJiwp6OUmqa/TjZw9wDOAtKYpyETFIWvYiKOJF6IpYeCCkFUPE=
X-Received: by 2002:a05:6870:3b0a:b0:142:ff0f:3db with SMTP id
 gh10-20020a0568703b0a00b00142ff0f03dbmr14192735oab.17.1669478442429; Sat, 26
 Nov 2022 08:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20221114093904.1669461-1-apatel@ventanamicro.com>
 <20221114093904.1669461-4-apatel@ventanamicro.com> <87y1rxubty.wl-maz@kernel.org>
 <CAK9=C2UeMVnMBKOgO_nseUZnmvG+CUu7xaRXtt6j3Esr+ap04g@mail.gmail.com> <87sfi5u6wx.wl-maz@kernel.org>
In-Reply-To: <87sfi5u6wx.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 26 Nov 2022 21:30:31 +0530
Message-ID: <CAK9=C2V351pAjjP4pkrOuUDzOv1xBKO7+iJvPJgQ2swoBFo=8w@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Sat, Nov 26, 2022 at 7:58 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 26 Nov 2022 13:31:46 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Sat, Nov 26, 2022 at 6:12 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Mon, 14 Nov 2022 09:39:00 +0000,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > +struct ipi_mux_control {
> > > > +     void                            *data;
> > > > +     unsigned int                    nr;
> > >
> > > Honestly, I think we can get rid of this. The number of IPIs Linux
> > > uses is pretty small, and assuming a huge value (like 32) would be
> > > enough. It would save looking up this value on each IPI handling.
> >
> > I had kept in-case some driver wanted to create fewer (< 32)
> > muxed IPIs.
>
> I'm fine with being able to specifying the max, but I'm not sure there
> is a need to keep track of it any further. Certainly, the overhead of
> loading this value on each IPI could be removed. On most architecture,
> for_each_set_bit() and co and better optimised with a fixed number of
> bits.

Okay, I will update like you suggested.

>
> > > > +static const struct irq_chip ipi_mux_chip = {
> > > > +     .name           = "IPI Mux",
> > > > +     .irq_mask       = ipi_mux_mask,
> > > > +     .irq_unmask     = ipi_mux_unmask,
> > > > +     .ipi_send_mask  = ipi_mux_send_mask,
> > > > +};
> > >
> > > I really think this could either be supplied by the irqchip, or
> > > somehow patched to avoid the pointless imux->ops->ipi_mux_send
> > > indirection. Pointer chasing hurts.
> >
> > Once we remove ipi_mux_pre/post_handle() callbacks, the
> > "ops" will be pointless and we will be able to remove one level
> > of indirection here.
> >
> > We certainly need a mux irqchip to implement the
> > mask/unmask semantics for muxed IPIs.
>
> I'm not disputing that last point.
>
> > > > +/**
> > > > + * ipi_mux_create - Create virtual IPIs multiplexed on top of a single
> > > > + * parent IPI.
> > > > + * @parent_virq:     virq of the parent per-CPU IRQ
> > > > + * @nr_ipi:          number of virtual IPIs to create. This should
> > > > + *                   be <= BITS_PER_TYPE(int)
> > > > + * @ops:             multiplexing operations for the parent IPI
> > > > + * @data:            opaque data used by the multiplexing operations
> > >
> > > What is the use for data? If anything, that data should be passed via
> > > the mux interrupt. But the whole point of this is to make the mux
> > > invisible. So this whole 'data' business is a mystery to me.
> >
> > This is added only to pass back driver data in ipi_mux_send().
>
> Again, what is the purpose of such data? If you need per-interrupt
> data, this should be provided by the requester of the interrupt.

Currently, the irqchip drivers that we care about don't need this
data pointer so I will remove it. If required we can add it in future.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Anup
