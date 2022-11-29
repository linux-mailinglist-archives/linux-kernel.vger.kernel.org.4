Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6163C247
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiK2OSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiK2ORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:17:37 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4D69315
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:38 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so32841377ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28p5Nybo1rpmsnoEGgCuI1PFvoPigOmp1FVlfARCLEI=;
        b=0LO6RfyIF6PDQP1a0HnVo3mhkfhe3k2/fdE46iJVQLJ7Gu8kHdx5+JqY08fGyE8Ct9
         WlADV682W2pfuxXn4QnUiSjkLyPS5ZQdDBF1oFLCIE1ciUuayzLJINZ7OMbXziE3LTel
         YQ9M6svUJBxwZYtnZfuHf6ki/Jv06FyNNQfHKhwaNTlyvHFlVD9lE9H+fFFhdZQn+R9R
         /frovIXiA8EDDFs0cfy2l63oSS5GoFzHA+T5Fre0ammanuCGEsGCH7sxby4DT6fzPL/L
         f/6nLozNRdzYCdNb91mQmFFxscK8TzPprWkKGZN14NKfVUTXUYuNd3MXyE0RikJlr0cm
         SJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28p5Nybo1rpmsnoEGgCuI1PFvoPigOmp1FVlfARCLEI=;
        b=LG5vNTHWh3Qx60Lm7ahhDbwl/FpHER284HfKJLI2Yfh3BJLU7mpUakKxBTWrtCAbIC
         LIjYoY5KSvV+lpzZvcBPJjmmaqnNfT4Sqa3qsFEpVF9utwZrJDwny9M/DAgMqfSEefdX
         tXuRj306CbZHLs67WH5B0arwlSfyIJ4pxWU2j9OloKbpEDHzw57lfRC9fRBZTFa9FXtx
         irJSCGkMs0hdTkqxc51ujGbZpbprcqRV9Y3y8aiV7bzzrZgKcAU3WfN7UCxmuFTjqHFG
         zEse8vOIbQLIsT7Ep2q3obbVJI+WO7Xy57kV5NVTn6wWfBY6qJ9cv/AhMoJU5bz4o256
         aAZw==
X-Gm-Message-State: ANoB5plnfN3accWQGqNfO38SmP9Ju4MQvyv6SxvPuPqNgNfm5at15XaJ
        ae2M0Ihwf/Q9pZJL9ivFdRQraU/jHI55XXbb3P4EWWc8+YtSAg==
X-Google-Smtp-Source: AA0mqf66DRfZfyrccTa/g3bwp+fP30fFxYUaytiD2SdQ+GpfUg3GZ5zj43+WYuFxbLLRyi/7GTOF9+NomGDNuPMMFLE=
X-Received: by 2002:a17:906:c042:b0:781:541:8f1d with SMTP id
 bm2-20020a170906c04200b0078105418f1dmr49062609ejb.117.1669731335514; Tue, 29
 Nov 2022 06:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20221126173453.306088-1-apatel@ventanamicro.com>
 <20221126173453.306088-4-apatel@ventanamicro.com> <86k03fmkox.wl-maz@kernel.org>
 <CAK9=C2Un8vH-OM8PRGgU-OijnNjmEOXya_gC=2BUMBDuhpjWPQ@mail.gmail.com> <86ilizmi40.wl-maz@kernel.org>
In-Reply-To: <86ilizmi40.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 29 Nov 2022 19:45:24 +0530
Message-ID: <CAAhSdy2rNOAqY0ErJwE-yATiu+EXhNduX13d-3pvzwETscKa_w@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 5:00 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 28 Nov 2022 11:13:30 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 4:04 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sat, 26 Nov 2022 17:34:49 +0000,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> > > > +{
> > > > +     u32 ibit = BIT(irqd_to_hwirq(d));
> > > > +     struct ipi_mux_cpu *icpu = this_cpu_ptr(ipi_mux_pcpu);
> > > > +     struct cpumask *send_mask = &icpu->send_mask;
> > > > +     unsigned long flags;
> > > > +     int cpu;
> > > > +
> > > > +     /*
> > > > +      * We use send_mask as a per-CPU variable so disable local
> > > > +      * interrupts to avoid being preempted.
> > > > +      */
> > > > +     local_irq_save(flags);
> > >
> > > The correct way to avoid preemption is to use preempt_disable(), which
> > > is a lot cheaper than disabling interrupt on most architectures.
> >
> > Okay, I will update.
> >
> > >
> > > > +
> > > > +     cpumask_clear(send_mask);
> > >
> > > This thing is likely to be unnecessarily expensive on very large
> > > systems, as it is proportional to the number of CPUs.
> > >
> > > > +
> > > > +     for_each_cpu(cpu, mask) {
> > > > +             icpu = per_cpu_ptr(ipi_mux_pcpu, cpu);
> > > > +             atomic_or(ibit, &icpu->bits);
> > >
> > > The original code had an atomic_fetch_or_release() to allow eliding
> > > the IPI if the target interrupt was already pending. Why is that code
> > > gone? This is a pretty cheap and efficient optimisation.
> >
> > That optimization is causing RCU stalls on QEMU RISC-V virt
> > machine with large number of CPUs.
>
> Then there is a bug somewhere, either in the implementation of the
> atomic operations or in QEMU. Or maybe even in the original code
> (though this looks unlikely given how heavily this is used on actual
> HW - I'm typing this email from one of these machines, and I'd be
> pretty annoyed if I was missing IPIs).
>
> In any case, please don't paper over this.

I was trying to defer the optimization to a later stage until this
issue was fixed for RISC-V.

Anyways, I found the root cause. This turned out to be missing
broadcast timer initialization in time_init() for RISC-V. Removing
the optimization over here was simply hiding the issue.

I will bring back the optimization in the next patch revision.

>
> >
> > >
> > > > +
> > > > +             /*
> > > > +              * The atomic_or() above must complete before
> > > > +              * the atomic_read() below to avoid racing with
> > > > +              * ipi_mux_unmask().
> > > > +              */
> > > > +             smp_mb__after_atomic();
> > > > +
> > > > +             if (atomic_read(&icpu->enable) & ibit)
> > > > +                     cpumask_set_cpu(cpu, send_mask);
> > > > +     }
> > > > +
> > > > +     /* Trigger the parent IPI */
> > > > +     ipi_mux_send(send_mask);
> > >
> > > IPIs are very rarely made pending on more than a single CPU at a
> > > time. The overwhelming majority of them are targeting a single CPU. So
> > > accumulating bits to avoid doing two or more "send" actions only
> > > penalises the generic case.
> > >
> > > My conclusion is that this "send_mask" can probably be removed,
> > > together with the preemption fiddling.
> >
> > So, we should call ipi_mux_send() for one target CPU at a time ?
>
> I think so, as it matches my measurements from a few years ago. It
> also simplifies things significantly, leading to better performance
> for the common case. Add some instrumentation and see whether this is
> still the case though.

I did not see any difference in the hackbench running on QEMU RISC-V.
I will simplify ipi_mux_send() like you suggested.

>
> >
> > >
> > > > +
> > > > +     local_irq_restore(flags);
> > > > +}
> > > > +
> > > > +static const struct irq_chip ipi_mux_chip = {
> > > > +     .name           = "IPI Mux",
> > > > +     .irq_mask       = ipi_mux_mask,
> > > > +     .irq_unmask     = ipi_mux_unmask,
> > > > +     .ipi_send_mask  = ipi_mux_send_mask,
> > > > +};
> > >
> > > OK, you have now dropped the superfluous pre/post handlers. But the
> > > need still exists. Case in point, the aic_handle_ipi() prologue and
> > > epilogue to the interrupt handling. I have suggested last time that
> > > the driver could provide the actual struct irq_chip in order to
> > > provide the callbacks it requires.
> >
> > The aic_handle_ipi() can simply call ipi_mux_process() between
> > the prologue and epilogue.
>
> Hmm. OK. That's not what I had in mind, but fair enough.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
