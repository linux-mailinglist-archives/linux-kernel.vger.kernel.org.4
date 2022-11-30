Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14863DCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiK3SQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiK3SQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:16:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D592080
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:14:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z20so25160356edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j7K3QQjgetcF0dnn3oVBs1JgDTRJdaG+fBSNdtFt0EA=;
        b=Lk7DM7XhMtPu5Cq9CE5ZDFKoOKUT6mHLWd98yCqFse4aDUwytBmZ4YTHSrCY9SDbbV
         5GNe6VYUHia592/EGt6Aw2Ms/Nxx3i5XDODt6qHqTKfiJASGf0U8v7V3b77aTTCid0f4
         RsmsbiaDAMdUiAib7vvpXjCVipj88D6c2kLSoCUojsh+N81VU5hiI/shxf2QxrE/GOBT
         giA87QJP1iqm3bte6q7Tk1AjMyo6uw15OD0B1KZpRBFHKStnGmF6TqrXmPzUnvL61AJu
         5uOjwp1O6iWjUgy7P+fzoUDCeGeLGLp54c8jYTrrL8j+n0jV7Hbl+4a0o6aM7yNPeUOV
         loog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7K3QQjgetcF0dnn3oVBs1JgDTRJdaG+fBSNdtFt0EA=;
        b=juNMqGCWc+NTlg9nDzi9Cd3Wl9q/CeSQ6xO4lN1IhJBDqS7ezsCZRXR8eUmexcE75c
         53c9pfXkFES0IgTJpeyPLP2RhvNE8VB37Ox0gnf9tvz0z2TZtNc7tJmjSexMF/kP6qTE
         4WAA9O1aX2fJ+ayo5pkSI5JAeaK2emA+ZApVI8wCOwRJNC3qwnIr1RenFxYzfh+5zPbd
         w9sEkbQbg7fMbSUiB+vK4ylsnep3hV1kmWpFEq+jwIkFNObYcLzvKIIWOhyekppCgzuU
         EknkjJlnjrgpmU/wVaU4bR8tqNdvzTnpkNNBoSmSy+BDVyG5pbyyY+OG9MLejOA3E3uQ
         UIeQ==
X-Gm-Message-State: ANoB5pkvQ8W/3uVJOGeLAHv5TEv/dV9FqZw7LY3GfVgPLKe1v+u+bnNS
        1ILX/R4lMiiyjG7A7Qg0XLSGkxFqFPPG88joz+67ww==
X-Google-Smtp-Source: AA0mqf7dSb+Z4b+LNnNwU5LI2sxm66euhhg+3LH4pqNP+jRZVqBiw6TiJLwXhAFe/JBpYXUuzfFQVZtiJYwGge/i5ss=
X-Received: by 2002:aa7:c859:0:b0:461:17e9:4ea3 with SMTP id
 g25-20020aa7c859000000b0046117e94ea3mr56716157edt.49.1669832078541; Wed, 30
 Nov 2022 10:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20221129142449.886518-1-apatel@ventanamicro.com>
 <20221129142449.886518-5-apatel@ventanamicro.com> <86bkoomn4h.wl-maz@kernel.org>
 <CAAhSdy0T1G7=XVSmtYxONtfk+5-XYnv3qWyFL2Nnp-MS3aQroA@mail.gmail.com> <87o7sotj62.wl-maz@kernel.org>
In-Reply-To: <87o7sotj62.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 30 Nov 2022 23:44:27 +0530
Message-ID: <CAAhSdy0s_GN798C_CQO_D2ewUVQnJ8PSb1SZd429q9MzG8xVoQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] RISC-V: Treat IPIs as normal Linux IRQs
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

On Wed, Nov 30, 2022 at 11:32 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 30 Nov 2022 17:14:09 +0000,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Nov 30, 2022 at 9:48 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 29 Nov 2022 14:24:46 +0000,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > Currently, the RISC-V kernel provides arch specific hooks (i.e.
> > > > struct riscv_ipi_ops) to register IPI handling methods. The stats
> > > > gathering of IPIs is also arch specific in the RISC-V kernel.
> > > >
> > > > Other architectures (such as ARM, ARM64, and MIPS) have moved away
> > > > from custom arch specific IPI handling methods. Currently, these
> > > > architectures have Linux irqchip drivers providing a range of Linux
> > > > IRQ numbers to be used as IPIs and IPI triggering is done using
> > > > generic IPI APIs. This approach allows architectures to treat IPIs
> > > > as normal Linux IRQs and IPI stats gathering is done by the generic
> > > > Linux IRQ subsystem.
> > > >
> > > > We extend the RISC-V IPI handling as-per above approach so that arch
> > > > specific IPI handling methods (struct riscv_ipi_ops) can be removed
> > > > and the IPI handling is done through the Linux IRQ subsystem.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/Kconfig                |   2 +
> > > >  arch/riscv/include/asm/sbi.h      |  10 +-
> > > >  arch/riscv/include/asm/smp.h      |  35 ++++---
> > > >  arch/riscv/kernel/Makefile        |   1 +
> > > >  arch/riscv/kernel/cpu-hotplug.c   |   3 +-
> > > >  arch/riscv/kernel/irq.c           |   3 +-
> > > >  arch/riscv/kernel/sbi-ipi.c       |  81 ++++++++++++++++
> > > >  arch/riscv/kernel/sbi.c           | 106 +++-----------------
> > > >  arch/riscv/kernel/smp.c           | 155 +++++++++++++++---------------
> > > >  arch/riscv/kernel/smpboot.c       |   5 +-
> > > >  drivers/clocksource/timer-clint.c |  65 ++++++++++---
> > > >  drivers/irqchip/Kconfig           |   1 +
> > > >  drivers/irqchip/irq-riscv-intc.c  |  55 +++++------
> > > >  13 files changed, 287 insertions(+), 235 deletions(-)
> > > >  create mode 100644 arch/riscv/kernel/sbi-ipi.c
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> > > > new file mode 100644
> > > > index 000000000000..6466706b03a7
> > > > --- /dev/null
> > > > +++ b/arch/riscv/kernel/sbi-ipi.c
> > > > @@ -0,0 +1,81 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Multiplex several IPIs over a single HW IPI.
> > > > + *
> > > > + * Copyright (c) 2022 Ventana Micro Systems Inc.
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "riscv: " fmt
> > > > +#include <linux/cpu.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/irqdomain.h>
> > > > +#include <linux/percpu.h>
> > > > +#include <asm/sbi.h>
> > > > +
> > > > +static int sbi_ipi_virq;
> > > > +static DEFINE_PER_CPU_READ_MOSTLY(int, sbi_ipi_dummy_dev);
> > > > +
> > > > +static irqreturn_t sbi_ipi_handle(int irq, void *dev_id)
> > > > +{
> > > > +     csr_clear(CSR_IP, IE_SIE);
> > > > +     ipi_mux_process();
> > > > +     return IRQ_HANDLED;
> > >
> > > Urgh... I really wish I hadn't seen this. This requires a chained
> > > handler. You had it before, and yet you dropped it. Why?
> > >
> > > Either you call ipi_mux_process() from your root interrupt controller,
> > > or you implement a chained handler. But not this.
> > >
> > > Same thing about the clint stuff.
> >
> > We had chained handler all along but there is problem (which
> > was pointed to us) in using chained handler because the parent
> > RISC-V INTC irqchip driver does not have irq_eoi() so the
> > chained_irq_enter() and chained_irq_exit() will do the interrupt
> > mask/unmask dance which seems unnecessary.
> >
> > Is there a better way to avoid the interrupt mask/unmask dance ?
>
> Well, you could have an IPI-specific irqchip, with an empty EOI
> callback. Or something. But not *that*.

Is it okay to add an empty irq_eoi() in drivers/irqchip/irq-riscv-intc.c with
detailed comments since this driver uses handle_percpu_devid_irq()
flow ?

>
> And next time you change something of that importance, add it to your
> change log.

Sure, will do.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Regards,
Anup
