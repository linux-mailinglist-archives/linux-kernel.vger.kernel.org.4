Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE02F6712AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjAREhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAREhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:37:48 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B653E62
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:37:46 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v81so15860493vkv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV+y3pS5uagTDpD4P8W13RUr8f7qOx2hA0A+JfhUulA=;
        b=cXHKE3ue2N5jRzGup6dl4cIEbe6Y3+NGIMsohb71bhzVabjmJo4u1mBKO3ZyJ0OB3n
         OUZuY2yS6M326rAVP2ETPveWhsweGY2zez7FxjBC3XVHlxUeIwq8oMoOX1mEVnR0mB03
         TRs2kqrtkr4zKHDFfARs6NOGXABvgnAgGcCJRvwUY1M2svfTdI8yJ9QVqrXOFY8OH9tA
         x6suywa+DCMq1tgsjeqmZaIHH5Je1/Tbfm2GVJg5M5GIQhafotdL8jHrOr082OvEjZov
         R3dnLDO4ONmETSZmLAluPeyx9+uaSEqOqDO+3IZ9YkfOOCkIxrtapv+kgQsdkvYgPOGk
         059g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV+y3pS5uagTDpD4P8W13RUr8f7qOx2hA0A+JfhUulA=;
        b=eyMZuUo8ApySs5ks/gfmuDgxOG7vEWTkeYExS7yibjk5PkCdJx/qw/nlcTASny+sCl
         TyaYE6hoVqQkBX9CXwMS2n6HPCxAiZVHHUQ/avkBFRVFTES56mToJ1uVz8b87JxzHvRB
         SC0ArPyyXt5JR56MtWb+Tf9YY3dCbKi2o116n7xzLf3LfGrWQEnfBn7FU6fkRVCk5liE
         q/SCjcW2HHRfbtX9mPbpSjUkT1OGU7Y9xoWqLwEPCJVXd//siPKALLzCAONHOu0K8EQw
         wkDI06EvS9aulWXRwM5lJY65vCLpmf2lR5Wqygqc89OnIpn9l1LT5tSBJbBuPrmCPQCx
         Tomg==
X-Gm-Message-State: AFqh2koG2ThEdhITPb6TzjlDlwwewdvPKH+xdvIfaVNAWyVmWHu8A8vH
        8YaE0v3qbRvuNhsHUwlVmOxL+X2bqfXOdD/TwtL2uw==
X-Google-Smtp-Source: AMrXdXuMgTeA5VvFgp8C07DFlmZ8v6gYD8OHxWBL7p2KfDAIQXen60cX5qIetnts03RsYgQvpJkURaSNe9LbORUUX5E=
X-Received: by 2002:a1f:a6d0:0:b0:3e1:95e8:fe1e with SMTP id
 p199-20020a1fa6d0000000b003e195e8fe1emr768220vke.1.1674016665030; Tue, 17 Jan
 2023 20:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-8-apatel@ventanamicro.com> <CAPqJEFpmAvWiOdackxYwSPBfjo4DnTHXrXVSCC4snMn8tnZXPw@mail.gmail.com>
 <CABvJ_xhjMa8xTsO-Qa23TOqxPpYxyBYSfV6TmKney-Gp3oi8cA@mail.gmail.com> <CABvJ_xif_nw_Ehbs8OPOjoeh8rfr2jpHak4drkqH-QbOySGC9A@mail.gmail.com>
In-Reply-To: <CABvJ_xif_nw_Ehbs8OPOjoeh8rfr2jpHak4drkqH-QbOySGC9A@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 18 Jan 2023 10:07:32 +0530
Message-ID: <CAK9=C2UEBV2gGsf0smmwbF7P8KGOTXBH7jctOqadBLj-HGy3Tw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:39 PM Vincent Chen <vincent.chen@sifive.com> wro=
te:
>
> > From: Anup Patel <apatel@ventanamicro.com>
> > Date: Wed, Jan 4, 2023 at 1:19 AM
> > Subject: [PATCH v2 7/9] irqchip: Add RISC-V advanced PLIC driver
> > To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@s=
ifive.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.=
org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozl=
owski+dt@linaro.org>
> > Cc: Atish Patra <atishp@atishpatra.org>, Alistair Francis <Alistair.Fra=
ncis@wdc.com>, Anup Patel <anup@brainfault.org>, <linux-riscv@lists.infrade=
ad.org>, <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Anup=
 Patel <apatel@ventanamicro.com>
> >
> >
> > The RISC-V advanced interrupt architecture (AIA) specification defines
> > a new interrupt controller for managing wired interrupts on a RISC-V
> > platform. This new interrupt controller is referred to as advanced
> > platform-level interrupt controller (APLIC) which can forward wired
> > interrupts to CPUs (or HARTs) as local interrupts OR as message
> > signaled interrupts.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> I could not find an appropriate place to post my question, so I posted it=
 here.
>
> I am a little concerned about the current MSI IRQ handling in APLIC.
> According to the specification, when domaincfg.DM =3D 1, the pending bit
> is set to one by a low-to-high transition in the rectified input
> value. When the APLIC forward this interrupt by MSI, the pending bit
> will be cleared regardless of whether the interrupt type is
> level-sensitive or edge-trigger. However, the interrupted service
> routine may not deal with all requests at a time. When there are
> remaining pending requests after leaving the ISR, these requests may
> have no chance to be serviced if the IRQ type of this device is
> level-sensitive. This is because the rectified value of this interrupt
> changes from 0 to 1 only at the beginning. It causes the pending bit
> of this interrupt will not to be asserted again, so APLIC will not
> send the next MSI for this interrupt. Therefore, the ISR doesn't have
> a chance to deal with the remaining requests.
>
> One possible solution to fix this issue is to let the APLIC driver
> check if the rectified value of the serviced interrupt is one after
> returning from its ISR. When the value is 1, it means this device
> still has pending requests. In this case, the APLIC driver can set its
> pending bit by the setipnum register or the setip register. It will
> let APLIC send the next MSI for this device, and the ISR will have a
> chance to deal with the remaining requests.

This is situation and possible solutions are already described in
the section "4.9.2 Special consideration for level-sensitive interrupt
sources" of the AIA specification.

It is a human error on my part for having totally missed adding
relevant code here. Thanks for pointing. I will fix this in the v3 patch.

Regards,
Anup

>
>
>
> > This patch adds an irqchip driver for RISC-V APLIC found on RISC-V
> > platforms.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig             |   6 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-riscv-aplic.c   | 670 ++++++++++++++++++++++++++++
> >  include/linux/irqchip/riscv-aplic.h | 117 +++++
> >  4 files changed, 794 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic.c
> >  create mode 100644 include/linux/irqchip/riscv-aplic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index a1315189a595..936e59fe1f99 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -547,6 +547,12 @@ config SIFIVE_PLIC
> >         select IRQ_DOMAIN_HIERARCHY
> >         select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_APLIC
> > +       bool
> > +       depends on RISCV
> > +       select IRQ_DOMAIN_HIERARCHY
> > +       select GENERIC_MSI_IRQ_DOMAIN
> > +
> >  config RISCV_IMSIC
> >         bool
> >         depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 22c723cc6ec8..6154e5bc4228 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -96,6 +96,7 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D ir=
q-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_APLIC)              +=3D irq-riscv-aplic.o
> >  obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic.o
> >  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> > diff --git a/drivers/irqchip/irq-riscv-aplic.c b/drivers/irqchip/irq-ri=
scv-aplic.c
> > new file mode 100644
> > index 000000000000..63f20892d7d3
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic.c
> > @@ -0,0 +1,670 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqchip/riscv-aplic.h>
> > +#include <linux/irqchip/riscv-imsic.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/smp.h>
> > +
> > +#define APLIC_DEFAULT_PRIORITY         1
> > +#define APLIC_DISABLE_IDELIVERY                0
> > +#define APLIC_ENABLE_IDELIVERY         1
> > +#define APLIC_DISABLE_ITHRESHOLD       1
> > +#define APLIC_ENABLE_ITHRESHOLD                0
> > +
> > +struct aplic_msicfg {
> > +       phys_addr_t             base_ppn;
> > +       u32                     hhxs;
> > +       u32                     hhxw;
> > +       u32                     lhxs;
> > +       u32                     lhxw;
> > +};
> > +
> > +struct aplic_idc {
> > +       unsigned int            hart_index;
> > +       void __iomem            *regs;
> > +       struct aplic_priv       *priv;
> > +};
> > +
> > +struct aplic_priv {
> > +       struct device           *dev;
> > +       u32                     nr_irqs;
> > +       u32                     nr_idcs;
> > +       void __iomem            *regs;
> > +       struct irq_domain       *irqdomain;
> > +       struct aplic_msicfg     msicfg;
> > +       struct cpumask          lmask;
> > +};
> > +
> > +static unsigned int aplic_idc_parent_irq;
> > +static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
> > +
> > +static void aplic_irq_unmask(struct irq_data *d)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       writel(d->hwirq, priv->regs + APLIC_SETIENUM);
> > +
> > +       if (!priv->nr_idcs)
> > +               irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void aplic_irq_mask(struct irq_data *d)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
> > +
> > +       if (!priv->nr_idcs)
> > +               irq_chip_mask_parent(d);
> > +}
> > +
> > +static int aplic_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +       u32 val =3D 0;
> > +       void __iomem *sourcecfg;
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       switch (type) {
> > +       case IRQ_TYPE_NONE:
> > +               val =3D APLIC_SOURCECFG_SM_INACTIVE;
> > +               break;
> > +       case IRQ_TYPE_LEVEL_LOW:
> > +               val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
> > +               break;
> > +       case IRQ_TYPE_LEVEL_HIGH:
> > +               val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
> > +               break;
> > +       case IRQ_TYPE_EDGE_FALLING:
> > +               val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
> > +               break;
> > +       case IRQ_TYPE_EDGE_RISING:
> > +               val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
> > +       sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
> > +       writel(val, sourcecfg);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int aplic_set_affinity(struct irq_data *d,
> > +                             const struct cpumask *mask_val, bool forc=
e)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +       struct aplic_idc *idc;
> > +       unsigned int cpu, val;
> > +       struct cpumask amask;
> > +       void __iomem *target;
> > +
> > +       if (!priv->nr_idcs)
> > +               return irq_chip_set_affinity_parent(d, mask_val, force)=
;
> > +
> > +       cpumask_and(&amask, &priv->lmask, mask_val);
> > +
> > +       if (force)
> > +               cpu =3D cpumask_first(&amask);
> > +       else
> > +               cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> > +
> > +       if (cpu >=3D nr_cpu_ids)
> > +               return -EINVAL;
> > +
> > +       idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +       target =3D priv->regs + APLIC_TARGET_BASE;
> > +       target +=3D (d->hwirq - 1) * sizeof(u32);
> > +       val =3D idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> > +       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +       val |=3D APLIC_DEFAULT_PRIORITY;
> > +       writel(val, target);
> > +
> > +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +       return IRQ_SET_MASK_OK_DONE;
> > +}
> > +#endif
> > +
> > +static struct irq_chip aplic_chip =3D {
> > +       .name           =3D "RISC-V APLIC",
> > +       .irq_mask       =3D aplic_irq_mask,
> > +       .irq_unmask     =3D aplic_irq_unmask,
> > +       .irq_set_type   =3D aplic_set_type,
> > +#ifdef CONFIG_SMP
> > +       .irq_set_affinity =3D aplic_set_affinity,
> > +#endif
> > +       .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> > +                         IRQCHIP_SKIP_SET_WAKE |
> > +                         IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int aplic_irqdomain_translate(struct irq_domain *d,
> > +                                    struct irq_fwspec *fwspec,
> > +                                    unsigned long *hwirq,
> > +                                    unsigned int *type)
> > +{
> > +       if (WARN_ON(fwspec->param_count < 2))
> > +               return -EINVAL;
> > +       if (WARN_ON(!fwspec->param[0]))
> > +               return -EINVAL;
> > +
> > +       *hwirq =3D fwspec->param[0];
> > +       *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +       WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_irqdomain_msi_alloc(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs,
> > +                                    void *arg)
> > +{
> > +       int i, ret;
> > +       unsigned int type;
> > +       irq_hw_number_t hwirq;
> > +       struct irq_fwspec *fwspec =3D arg;
> > +       struct aplic_priv *priv =3D platform_msi_get_host_data(domain);
> > +
> > +       ret =3D aplic_irqdomain_translate(domain, fwspec, &hwirq, &type=
);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs)=
;
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i =3D 0; i < nr_irqs; i++)
> > +               irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq +=
 i,
> > +                                             &aplic_chip, priv);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aplic_irqdomain_msi_ops =3D {
> > +       .translate      =3D aplic_irqdomain_translate,
> > +       .alloc          =3D aplic_irqdomain_msi_alloc,
> > +       .free           =3D platform_msi_device_domain_free,
> > +};
> > +
> > +static int aplic_irqdomain_idc_alloc(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs,
> > +                                    void *arg)
> > +{
> > +       int i, ret;
> > +       unsigned int type;
> > +       irq_hw_number_t hwirq;
> > +       struct irq_fwspec *fwspec =3D arg;
> > +       struct aplic_priv *priv =3D domain->host_data;
> > +
> > +       ret =3D aplic_irqdomain_translate(domain, fwspec, &hwirq, &type=
);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i =3D 0; i < nr_irqs; i++) {
> > +               irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                   &aplic_chip, priv, handle_simple_ir=
q,
> > +                                   NULL, NULL);
> > +               irq_set_affinity(virq + i, &priv->lmask);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aplic_irqdomain_idc_ops =3D {
> > +       .translate      =3D aplic_irqdomain_translate,
> > +       .alloc          =3D aplic_irqdomain_idc_alloc,
> > +       .free           =3D irq_domain_free_irqs_top,
> > +};
> > +
> > +static void aplic_init_hw_irqs(struct aplic_priv *priv)
> > +{
> > +       int i;
> > +
> > +       /* Disable all interrupts */
> > +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
> > +               writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +                           (i / 32) * sizeof(u32));
> > +
> > +       /* Set interrupt type and default priority for all interrupts *=
/
> > +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +               writel(0, priv->regs + APLIC_SOURCECFG_BASE +
> > +                         (i - 1) * sizeof(u32));
> > +               writel(APLIC_DEFAULT_PRIORITY,
> > +                      priv->regs + APLIC_TARGET_BASE +
> > +                      (i - 1) * sizeof(u32));
> > +       }
> > +
> > +       /* Clear APLIC domaincfg */
> > +       writel(0, priv->regs + APLIC_DOMAINCFG);
> > +}
> > +
> > +static void aplic_init_hw_global(struct aplic_priv *priv)
> > +{
> > +       u32 val;
> > +#ifdef CONFIG_RISCV_M_MODE
> > +       u32 valH;
> > +
> > +       if (!priv->nr_idcs) {
> > +               val =3D priv->msicfg.base_ppn;
> > +               valH =3D (priv->msicfg.base_ppn >> 32) &
> > +                       APLIC_xMSICFGADDRH_BAPPN_MASK;
> > +               valH |=3D (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_LHXW_SHIFT;
> > +               valH |=3D (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_HHXW_SHIFT;
> > +               valH |=3D (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_LHXS_SHIFT;
> > +               valH |=3D (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_HHXS_SHIFT;
> > +               writel(val, priv->regs + APLIC_xMSICFGADDR);
> > +               writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> > +       }
> > +#endif
> > +
> > +       /* Setup APLIC domaincfg register */
> > +       val =3D readl(priv->regs + APLIC_DOMAINCFG);
> > +       val |=3D APLIC_DOMAINCFG_IE;
> > +       if (!priv->nr_idcs)
> > +               val |=3D APLIC_DOMAINCFG_DM;
> > +       writel(val, priv->regs + APLIC_DOMAINCFG);
> > +       if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
> > +               dev_warn(priv->dev,
> > +                        "unable to write 0x%x in domaincfg\n", val);
> > +}
> > +
> > +static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg =
*msg)
> > +{
> > +       unsigned int group_index, hart_index, guest_index, val;
> > +       struct device *dev =3D msi_desc_to_dev(desc);
> > +       struct aplic_priv *priv =3D dev_get_drvdata(dev);
> > +       struct irq_data *d =3D irq_get_irq_data(desc->irq);
> > +       struct aplic_msicfg *mc =3D &priv->msicfg;
> > +       phys_addr_t tppn, tbppn, msg_addr;
> > +       void __iomem *target;
> > +
> > +       /* For zeroed MSI, simply write zero into the target register *=
/
> > +       if (!msg->address_hi && !msg->address_lo && !msg->data) {
> > +               target =3D priv->regs + APLIC_TARGET_BASE;
> > +               target +=3D (d->hwirq - 1) * sizeof(u32);
> > +               writel(0, target);
> > +               return;
> > +       }
> > +
> > +       /* Sanity check on message data */
> > +       WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> > +
> > +       /* Compute target MSI address */
> > +       msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> > +       tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> > +
> > +       /* Compute target HART Base PPN */
> > +       tbppn =3D tppn;
> > +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> > +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> > +       WARN_ON(tbppn !=3D mc->base_ppn);
> > +
> > +       /* Compute target group and hart indexes */
> > +       group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hh=
xs)) &
> > +                    APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> > +       hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhx=
s)) &
> > +                    APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> > +       hart_index |=3D (group_index << mc->lhxw);
> > +       WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> > +
> > +       /* Compute target guest index */
> > +       guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +       WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> > +
> > +       /* Update IRQ TARGET register */
> > +       target =3D priv->regs + APLIC_TARGET_BASE;
> > +       target +=3D (d->hwirq - 1) * sizeof(u32);
> > +       val =3D (hart_index & APLIC_TARGET_HART_IDX_MASK)
> > +                               << APLIC_TARGET_HART_IDX_SHIFT;
> > +       val |=3D (guest_index & APLIC_TARGET_GUEST_IDX_MASK)
> > +                               << APLIC_TARGET_GUEST_IDX_SHIFT;
> > +       val |=3D (msg->data & APLIC_TARGET_EIID_MASK);
> > +       writel(val, target);
> > +}
> > +
> > +static int aplic_setup_msi(struct aplic_priv *priv)
> > +{
> > +       struct device *dev =3D priv->dev;
> > +       struct aplic_msicfg *mc =3D &priv->msicfg;
> > +       const struct imsic_global_config *imsic_global;
> > +
> > +       /*
> > +        * The APLIC outgoing MSI config registers assume target MSI
> > +        * controller to be RISC-V AIA IMSIC controller.
> > +        */
> > +       imsic_global =3D imsic_get_global_config();
> > +       if (!imsic_global) {
> > +               dev_err(dev, "IMSIC global config not found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* Find number of guest index bits (LHXS) */
> > +       mc->lhxs =3D imsic_global->guest_index_bits;
> > +       if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
> > +               dev_err(dev, "IMSIC guest index bits big for APLIC LHXS=
\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of HART index bits (LHXW) */
> > +       mc->lhxw =3D imsic_global->hart_index_bits;
> > +       if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
> > +               dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\=
n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of group index bits (HHXW) */
> > +       mc->hhxw =3D imsic_global->group_index_bits;
> > +       if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
> > +               dev_err(dev, "IMSIC group index bits big for APLIC HHXW=
\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find first bit position of group index (HHXS) */
> > +       mc->hhxs =3D imsic_global->group_index_shift;
> > +       if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
> > +               dev_err(dev, "IMSIC group index shift should be >=3D %d=
\n",
> > +                       (2 * APLIC_xMSICFGADDR_PPN_SHIFT));
> > +               return -EINVAL;
> > +       }
> > +       mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
> > +       if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
> > +               dev_err(dev, "IMSIC group index shift big for APLIC HHX=
S\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Compute PPN base */
> > +       mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_P=
PN_SHIFT;
> > +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs=
);
> > +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs=
);
> > +
> > +       /* Use all possible CPUs as lmask */
> > +       cpumask_copy(&priv->lmask, cpu_possible_mask);
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * To handle an APLIC IDC interrupts, we just read the CLAIMI register
> > + * which will return highest priority pending interrupt and clear the
> > + * pending bit of the interrupt. This process is repeated until CLAIMI
> > + * register return zero value.
> > + */
> > +static void aplic_idc_handle_irq(struct irq_desc *desc)
> > +{
> > +       struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
> > +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +       irq_hw_number_t hw_irq;
> > +       int irq;
> > +
> > +       chained_irq_enter(chip, desc);
> > +
> > +       while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
> > +               hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> > +               irq =3D irq_find_mapping(idc->priv->irqdomain, hw_irq);
> > +
> > +               if (unlikely(irq <=3D 0))
> > +                       pr_warn_ratelimited("hw_irq %lu mapping not fou=
nd\n",
> > +                                           hw_irq);
> > +               else
> > +                       generic_handle_irq(irq);
> > +       }
> > +
> > +       chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
> > +{
> > +       u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIV=
ERY;
> > +       u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRE=
SHOLD;
> > +
> > +       /* Priority must be less than threshold for interrupt triggerin=
g */
> > +       writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
> > +
> > +       /* Delivery must be set to 1 for interrupt triggering */
> > +       writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> > +}
> > +
> > +static int aplic_idc_dying_cpu(unsigned int cpu)
> > +{
> > +       if (aplic_idc_parent_irq)
> > +               disable_percpu_irq(aplic_idc_parent_irq);
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_idc_starting_cpu(unsigned int cpu)
> > +{
> > +       if (aplic_idc_parent_irq)
> > +               enable_percpu_irq(aplic_idc_parent_irq,
> > +                                 irq_get_trigger_type(aplic_idc_parent=
_irq));
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_setup_idc(struct aplic_priv *priv)
> > +{
> > +       int i, j, rc, cpu, setup_count =3D 0;
> > +       struct device_node *node =3D priv->dev->of_node;
> > +       struct device *dev =3D priv->dev;
> > +       struct of_phandle_args parent;
> > +       struct irq_domain *domain;
> > +       unsigned long hartid;
> > +       struct aplic_idc *idc;
> > +       u32 val;
> > +
> > +       /* Setup per-CPU IDC and target CPU mask */
> > +       for (i =3D 0; i < priv->nr_idcs; i++) {
> > +               if (of_irq_parse_one(node, i, &parent)) {
> > +                       dev_err(dev, "failed to parse parent for IDC%d.=
\n",
> > +                               i);
> > +                       return -EIO;
> > +               }
> > +
> > +               /* Skip IDCs which do not connect to external interrupt=
s */
> > +               if (parent.args[0] !=3D RV_IRQ_EXT)
> > +                       continue;
> > +
> > +               rc =3D riscv_of_parent_hartid(parent.np, &hartid);
> > +               if (rc) {
> > +                       dev_err(dev, "failed to parse hart ID for IDC%d=
.\n",
> > +                               i);
> > +                       return rc;
> > +               }
> > +
> > +               cpu =3D riscv_hartid_to_cpuid(hartid);
> > +               if (cpu < 0) {
> > +                       dev_warn(dev, "invalid cpuid for IDC%d\n", i);
> > +                       continue;
> > +               }
> > +
> > +               cpumask_set_cpu(cpu, &priv->lmask);
> > +
> > +               idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +               WARN_ON(idc->priv);
> > +
> > +               idc->hart_index =3D i;
> > +               idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_I=
DC_SIZE;
> > +               idc->priv =3D priv;
> > +
> > +               aplic_idc_set_delivery(idc, true);
> > +
> > +               /*
> > +                * Boot cpu might not have APLIC hart_index =3D 0 so ch=
eck
> > +                * and update target registers of all interrupts.
> > +                */
> > +               if (cpu =3D=3D smp_processor_id() && idc->hart_index) {
> > +                       val =3D idc->hart_index & APLIC_TARGET_HART_IDX=
_MASK;
> > +                       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +                       val |=3D APLIC_DEFAULT_PRIORITY;
> > +                       for (j =3D 1; j <=3D priv->nr_irqs; j++)
> > +                               writel(val, priv->regs + APLIC_TARGET_B=
ASE +
> > +                                           (j - 1) * sizeof(u32));
> > +               }
> > +
> > +               setup_count++;
> > +       }
> > +
> > +       /* Find parent domain and register chained handler */
> > +       domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                         DOMAIN_BUS_ANY);
> > +       if (!aplic_idc_parent_irq && domain) {
> > +               aplic_idc_parent_irq =3D irq_create_mapping(domain, RV_=
IRQ_EXT);
> > +               if (aplic_idc_parent_irq) {
> > +                       irq_set_chained_handler(aplic_idc_parent_irq,
> > +                                               aplic_idc_handle_irq);
> > +
> > +                       /*
> > +                        * Setup CPUHP notifier to enable IDC parent
> > +                        * interrupt on all CPUs
> > +                        */
> > +                       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                                         "irqchip/riscv/aplic:starting=
",
> > +                                         aplic_idc_starting_cpu,
> > +                                         aplic_idc_dying_cpu);
> > +               }
> > +       }
> > +
> > +       /* Fail if we were not able to setup IDC for any CPU */
> > +       return (setup_count) ? 0 : -ENODEV;
> > +}
> > +
> > +static int aplic_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *node =3D pdev->dev.of_node;
> > +       struct device *dev =3D &pdev->dev;
> > +       struct aplic_priv *priv;
> > +       struct resource *regs;
> > +       phys_addr_t pa;
> > +       int rc;
> > +
> > +       regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!regs) {
> > +               dev_err(dev, "cannot find registers resource\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +       platform_set_drvdata(pdev, priv);
> > +       priv->dev =3D dev;
> > +
> > +       priv->regs =3D devm_ioremap(dev, regs->start, resource_size(reg=
s));
> > +       if (WARN_ON(!priv->regs)) {
> > +               dev_err(dev, "failed ioremap registers\n");
> > +               return -EIO;
> > +       }
> > +
> > +       of_property_read_u32(node, "riscv,num-sources", &priv->nr_irqs)=
;
> > +       if (!priv->nr_irqs) {
> > +               dev_err(dev, "failed to get number of interrupt sources=
\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Setup initial state APLIC interrupts */
> > +       aplic_init_hw_irqs(priv);
> > +
> > +       /*
> > +        * Setup IDCs or MSIs based on parent interrupts in DT node
> > +        *
> > +        * If "msi-parent" DT property is present then we ignore the
> > +        * APLIC IDCs which forces the APLIC driver to use MSI mode.
> > +        */
> > +       priv->nr_idcs =3D of_property_read_bool(node, "msi-parent") ?
> > +                       0 : of_irq_count(node);
> > +       if (priv->nr_idcs)
> > +               rc =3D aplic_setup_idc(priv);
> > +       else
> > +               rc =3D aplic_setup_msi(priv);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* Setup global config and interrupt delivery */
> > +       aplic_init_hw_global(priv);
> > +
> > +       /* Create irq domain instance for the APLIC */
> > +       if (priv->nr_idcs)
> > +               priv->irqdomain =3D irq_domain_create_linear(
> > +                                               of_node_to_fwnode(node)=
,
> > +                                               priv->nr_irqs + 1,
> > +                                               &aplic_irqdomain_idc_op=
s,
> > +                                               priv);
> > +       else
> > +               priv->irqdomain =3D platform_msi_create_device_domain(d=
ev,
> > +                                               priv->nr_irqs + 1,
> > +                                               aplic_msi_write_msg,
> > +                                               &aplic_irqdomain_msi_op=
s,
> > +                                               priv);
> > +       if (!priv->irqdomain) {
> > +               dev_err(dev, "failed to add irq domain\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* Advertise the interrupt controller */
> > +       if (priv->nr_idcs) {
> > +               dev_info(dev, "%d interrupts directly connected to %d C=
PUs\n",
> > +                        priv->nr_irqs, priv->nr_idcs);
> > +       } else {
> > +               pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_S=
HIFT;
> > +               dev_info(dev, "%d interrupts forwared to MSI base %pa\n=
",
> > +                        priv->nr_irqs, &pa);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_remove(struct platform_device *pdev)
> > +{
> > +       struct aplic_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +       irq_domain_remove(priv->irqdomain);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id aplic_match[] =3D {
> > +       { .compatible =3D "riscv,aplic" },
> > +       {}
> > +};
> > +
> > +static struct platform_driver aplic_driver =3D {
> > +       .driver =3D {
> > +               .name           =3D "riscv-aplic",
> > +               .of_match_table =3D aplic_match,
> > +       },
> > +       .probe =3D aplic_probe,
> > +       .remove =3D aplic_remove,
> > +};
> > +
> > +static int __init aplic_init(void)
> > +{
> > +       return platform_driver_register(&aplic_driver);
> > +}
> > +core_initcall(aplic_init);
> > diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchi=
p/riscv-aplic.h
> > new file mode 100644
> > index 000000000000..88177eefd411
> > --- /dev/null
> > +++ b/include/linux/irqchip/riscv-aplic.h
> > @@ -0,0 +1,117 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
> > +#define __LINUX_IRQCHIP_RISCV_APLIC_H
> > +
> > +#include <linux/bitops.h>
> > +
> > +#define APLIC_MAX_IDC                  BIT(14)
> > +#define APLIC_MAX_SOURCE               1024
> > +
> > +#define APLIC_DOMAINCFG                        0x0000
> > +#define APLIC_DOMAINCFG_RDONLY         0x80000000
> > +#define APLIC_DOMAINCFG_IE             BIT(8)
> > +#define APLIC_DOMAINCFG_DM             BIT(2)
> > +#define APLIC_DOMAINCFG_BE             BIT(0)
> > +
> > +#define APLIC_SOURCECFG_BASE           0x0004
> > +#define APLIC_SOURCECFG_D              BIT(10)
> > +#define APLIC_SOURCECFG_CHILDIDX_MASK  0x000003ff
> > +#define APLIC_SOURCECFG_SM_MASK        0x00000007
> > +#define APLIC_SOURCECFG_SM_INACTIVE    0x0
> > +#define APLIC_SOURCECFG_SM_DETACH      0x1
> > +#define APLIC_SOURCECFG_SM_EDGE_RISE   0x4
> > +#define APLIC_SOURCECFG_SM_EDGE_FALL   0x5
> > +#define APLIC_SOURCECFG_SM_LEVEL_HIGH  0x6
> > +#define APLIC_SOURCECFG_SM_LEVEL_LOW   0x7
> > +
> > +#define APLIC_MMSICFGADDR              0x1bc0
> > +#define APLIC_MMSICFGADDRH             0x1bc4
> > +#define APLIC_SMSICFGADDR              0x1bc8
> > +#define APLIC_SMSICFGADDRH             0x1bcc
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +#define APLIC_xMSICFGADDR              APLIC_MMSICFGADDR
> > +#define APLIC_xMSICFGADDRH             APLIC_MMSICFGADDRH
> > +#else
> > +#define APLIC_xMSICFGADDR              APLIC_SMSICFGADDR
> > +#define APLIC_xMSICFGADDRH             APLIC_SMSICFGADDRH
> > +#endif
> > +
> > +#define APLIC_xMSICFGADDRH_L           BIT(31)
> > +#define APLIC_xMSICFGADDRH_HHXS_MASK   0x1f
> > +#define APLIC_xMSICFGADDRH_HHXS_SHIFT  24
> > +#define APLIC_xMSICFGADDRH_LHXS_MASK   0x7
> > +#define APLIC_xMSICFGADDRH_LHXS_SHIFT  20
> > +#define APLIC_xMSICFGADDRH_HHXW_MASK   0x7
> > +#define APLIC_xMSICFGADDRH_HHXW_SHIFT  16
> > +#define APLIC_xMSICFGADDRH_LHXW_MASK   0xf
> > +#define APLIC_xMSICFGADDRH_LHXW_SHIFT  12
> > +#define APLIC_xMSICFGADDRH_BAPPN_MASK  0xfff
> > +
> > +#define APLIC_xMSICFGADDR_PPN_SHIFT    12
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
> > +       (BIT(__lhxs) - 1)
> > +
> > +#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
> > +       (BIT(__lhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
> > +       ((__lhxs))
> > +#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
> > +       (APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
> > +        APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
> > +       (BIT(__hhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
> > +       ((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
> > +#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
> > +       (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
> > +        APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
> > +
> > +#define APLIC_SETIP_BASE               0x1c00
> > +#define APLIC_SETIPNUM                 0x1cdc
> > +
> > +#define APLIC_CLRIP_BASE               0x1d00
> > +#define APLIC_CLRIPNUM                 0x1ddc
> > +
> > +#define APLIC_SETIE_BASE               0x1e00
> > +#define APLIC_SETIENUM                 0x1edc
> > +
> > +#define APLIC_CLRIE_BASE               0x1f00
> > +#define APLIC_CLRIENUM                 0x1fdc
> > +
> > +#define APLIC_SETIPNUM_LE              0x2000
> > +#define APLIC_SETIPNUM_BE              0x2004
> > +
> > +#define APLIC_GENMSI                   0x3000
> > +
> > +#define APLIC_TARGET_BASE              0x3004
> > +#define APLIC_TARGET_HART_IDX_SHIFT    18
> > +#define APLIC_TARGET_HART_IDX_MASK     0x3fff
> > +#define APLIC_TARGET_GUEST_IDX_SHIFT   12
> > +#define APLIC_TARGET_GUEST_IDX_MASK    0x3f
> > +#define APLIC_TARGET_IPRIO_MASK        0xff
> > +#define APLIC_TARGET_EIID_MASK 0x7ff
> > +
> > +#define APLIC_IDC_BASE                 0x4000
> > +#define APLIC_IDC_SIZE                 32
> > +
> > +#define APLIC_IDC_IDELIVERY            0x00
> > +
> > +#define APLIC_IDC_IFORCE               0x04
> > +
> > +#define APLIC_IDC_ITHRESHOLD           0x08
> > +
> > +#define APLIC_IDC_TOPI                 0x18
> > +#define APLIC_IDC_TOPI_ID_SHIFT        16
> > +#define APLIC_IDC_TOPI_ID_MASK 0x3ff
> > +#define APLIC_IDC_TOPI_PRIO_MASK       0xff
> > +
> > +#define APLIC_IDC_CLAIMI               0x1c
> > +
> > +#endif
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
