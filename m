Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AF671285
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjAREUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAREUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:20:21 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19016196BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:20:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt14so21393483ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WosleXhzzbyjk0f+fKAwlLjjj8lE4YIWbnAwLCrvEsI=;
        b=k2KfcjjZ2ooQT/vcQDMcrRGpfXZtE9XKC2075qgBWX704GN7zuMjlOe7v6p8J5Gi2B
         4HMYmLjZ/ldm1/M/IvMfvAVqmq9HA3apTJ7Wzt0lx3AFKvmbUl+Qv0Rht8XyN/a5GesI
         lq6/nUZmQ+YorR6wmOLOkH9/G2Mek6nGfjGG4Ir4fTRfhaIOozCjizpTfVgklsbrdiL8
         exnuJl6stZfVcdzbk7+0MtCKuXX2+zzp2YSOU0hf0JeOCAbd6Kfk5fpk09uboUrnum3a
         J49I5ewRayaFaRoUeUQY7QGi7+uWnxnAN5A7E+iBM99T3FiMT2O1b28SRrtjz5LdJtjP
         6taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WosleXhzzbyjk0f+fKAwlLjjj8lE4YIWbnAwLCrvEsI=;
        b=5oHQdalaN6ACNSsSWXmgVyVpoaBInz0YCVfUMQMlY+2EIV7ntw5W2r+kFUWwvm21mJ
         pjzW9uUEQivzXJnFkifL8JEmk0Xwin4tnFth0YqKCc4aMnQ5iNaFPDyZ4OuFqT3Pky7u
         gRmf1ajyh8GesVN0wQ5JXrrPz48IjieLBzbJYKvSmzx4fwxVmGYy4W5ZcrAvVr9zp1rO
         dLQMOwpXsockhA1otmeCFEtUa3H0UmFc8bgW40nnF+aqxjTGsEBHNY3SqmpIt6p6hLEd
         Ot3I47bSxzN2TJj/gWkFryKZ1IoJK4/b6yBIjKuKuKzPrraMJoJn3Jsev7V9pLj2PGVL
         8rag==
X-Gm-Message-State: AFqh2koH+6AZ5wR1JBJkHk7JAhD08s5gZj4WNiqVM07vGi29BteI/CeH
        bDPJW99iG/Qh2y1sfXrHpY3bvQlLHFZUi9qy88PXfQ==
X-Google-Smtp-Source: AMrXdXsCybCGRR4U/KOlWK59mD0/dIXrORyJmAtxwFZ0Sr/12WrLRvzzM+yJYLmfV9/P8k7TBRrdgrGpAt1/ubyc87o=
X-Received: by 2002:a17:907:c082:b0:84d:3d45:4222 with SMTP id
 st2-20020a170907c08200b0084d3d454222mr485117ejc.750.1674015616382; Tue, 17
 Jan 2023 20:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-6-apatel@ventanamicro.com> <CAPqJEFqhd-=-RYepKqnco7HySoxk7AhEctL+vzNozMSWe0mv7A@mail.gmail.com>
 <CABvJ_xhcuC92A_oo1mWQoRvtRzE8XXx9bbXKs7N7wKm0=Z3_Cw@mail.gmail.com> <CABvJ_xg6QWTHjSn2hO2BO_ana2Ze4m1At0rDDdzne6dn8kMV8w@mail.gmail.com>
In-Reply-To: <CABvJ_xg6QWTHjSn2hO2BO_ana2Ze4m1At0rDDdzne6dn8kMV8w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 18 Jan 2023 09:50:04 +0530
Message-ID: <CAAhSdy0w5BYsFm3FVtv1tuKysLO_xnr5OZHNuw=PeMmyiMGj1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] irqchip: Add RISC-V incoming MSI controller driver
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     apatel@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 9:20 AM Vincent Chen <vincent.chen@sifive.com> wrot=
e:
>
> > From: Anup Patel <apatel@ventanamicro.com>
> > Date: Wed, Jan 4, 2023 at 1:19 AM
> > Subject: [PATCH v2 5/9] irqchip: Add RISC-V incoming MSI controller dri=
ver
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
> > a new MSI controller for managing MSIs on a RISC-V platform. This new
> > MSI controller is referred to as incoming message signaled interrupt
> > controller (IMSIC) which manages MSI on per-HART (or per-CPU) basis.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> > This patch adds an irqchip driver for RISC-V IMSIC found on RISC-V
> > platforms.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig             |   14 +-
> >  drivers/irqchip/Makefile            |    1 +
> >  drivers/irqchip/irq-riscv-imsic.c   | 1174 +++++++++++++++++++++++++++
> >  include/linux/irqchip/riscv-imsic.h |   92 +++
> >  4 files changed, 1280 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic.c
> >  create mode 100644 include/linux/irqchip/riscv-imsic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 9e65345ca3f6..a1315189a595 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -29,7 +29,6 @@ config ARM_GIC_V2M
> >
> >  config GIC_NON_BANKED
> >         bool
> > -
> >  config ARM_GIC_V3
> >         bool
> >         select IRQ_DOMAIN_HIERARCHY
> > @@ -548,6 +547,19 @@ config SIFIVE_PLIC
> >         select IRQ_DOMAIN_HIERARCHY
> >         select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_IMSIC
> > +       bool
> > +       depends on RISCV
> > +       select IRQ_DOMAIN_HIERARCHY
> > +       select GENERIC_MSI_IRQ_DOMAIN
> > +
> > +config RISCV_IMSIC_PCI
> > +       bool
> > +       depends on RISCV_IMSIC
> > +       depends on PCI
> > +       depends on PCI_MSI
> > +       default RISCV_IMSIC
> > +
> >  config EXYNOS_IRQ_COMBINER
> >         bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
> >         depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 87b49a10962c..22c723cc6ec8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -96,6 +96,7 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D ir=
q-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic.o
> >  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)               +=3D irq-imx-intmux.o
> > diff --git a/drivers/irqchip/irq-riscv-imsic.c b/drivers/irqchip/irq-ri=
scv-imsic.c
> > new file mode 100644
> > index 000000000000..4c16b66738d6
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic.c
> > @@ -0,0 +1,1174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv-imsic: " fmt
> > +#include <linux/bitmap.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iommu.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqchip/riscv-imsic.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/smp.h>
> > +#include <asm/hwcap.h>
> > +
> > +#define IMSIC_DISABLE_EIDELIVERY       0
> > +#define IMSIC_ENABLE_EIDELIVERY                1
> > +#define IMSIC_DISABLE_EITHRESHOLD      1
> > +#define IMSIC_ENABLE_EITHRESHOLD       0
> > +
> > +#define imsic_csr_write(__c, __v)      \
> > +do {                                   \
> > +       csr_write(CSR_ISELECT, __c);    \
> > +       csr_write(CSR_IREG, __v);       \
> > +} while (0)
> > +
> > +#define imsic_csr_read(__c)            \
> > +({                                     \
> > +       unsigned long __v;              \
> > +       csr_write(CSR_ISELECT, __c);    \
> > +       __v =3D csr_read(CSR_IREG);       \
> > +       __v;                            \
> > +})
> > +
> > +#define imsic_csr_set(__c, __v)                \
> > +do {                                   \
> > +       csr_write(CSR_ISELECT, __c);    \
> > +       csr_set(CSR_IREG, __v);         \
> > +} while (0)
> > +
> > +#define imsic_csr_clear(__c, __v)      \
> > +do {                                   \
> > +       csr_write(CSR_ISELECT, __c);    \
> > +       csr_clear(CSR_IREG, __v);       \
> > +} while (0)
> > +
> > +struct imsic_mmio {
> > +       phys_addr_t pa;
> > +       void __iomem *va;
> > +       unsigned long size;
> > +};
> > +
> > +struct imsic_priv {
> > +       /* Global configuration common for all HARTs */
> > +       struct imsic_global_config global;
> > +
> > +       /* MMIO regions */
> > +       u32 num_mmios;
> > +       struct imsic_mmio *mmios;
> > +
> > +       /* Global state of interrupt identities */
> > +       raw_spinlock_t ids_lock;
> > +       unsigned long *ids_used_bimap;
> > +       unsigned long *ids_enabled_bimap;
> > +       unsigned int *ids_target_cpu;
> > +
> > +       /* Mask for connected CPUs */
> > +       struct cpumask lmask;
> > +
> > +       /* IPI interrupt identity */
> > +       u32 ipi_id;
> > +       u32 ipi_lsync_id;
> > +
> > +       /* IRQ domains */
> > +       struct irq_domain *base_domain;
> > +       struct irq_domain *pci_domain;
> > +       struct irq_domain *plat_domain;
> > +};
> > +
> > +struct imsic_handler {
> > +       /* Local configuration for given HART */
> > +       struct imsic_local_config local;
> > +
> > +       /* Pointer to private context */
> > +       struct imsic_priv *priv;
> > +};
> > +
> > +static bool imsic_init_done;
> > +
> > +static int imsic_parent_irq;
> > +static DEFINE_PER_CPU(struct imsic_handler, imsic_handlers);
> > +
> > +const struct imsic_global_config *imsic_get_global_config(void)
> > +{
> > +       struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers)=
;
> > +
> > +       if (!handler || !handler->priv)
> > +               return NULL;
> > +
> > +       return &handler->priv->global;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
> > +
> > +const struct imsic_local_config *imsic_get_local_config(unsigned int c=
pu)
> > +{
> > +       struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, =
cpu);
> > +
> > +       if (!handler || !handler->priv)
> > +               return NULL;
> > +
> > +       return &handler->local;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_local_config);
> > +
> > +static int imsic_cpu_page_phys(unsigned int cpu,
> > +                              unsigned int guest_index,
> > +                              phys_addr_t *out_msi_pa)
> > +{
> > +       struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, =
cpu);
> > +       struct imsic_global_config *global;
> > +       struct imsic_local_config *local;
> > +
> > +       if (!handler || !handler->priv)
> > +               return -ENODEV;
> > +       local =3D &handler->local;
> > +       global =3D &handler->priv->global;
> > +
> > +       if (BIT(global->guest_index_bits) <=3D guest_index)
> > +               return -EINVAL;
> > +
> > +       if (out_msi_pa)
> > +               *out_msi_pa =3D local->msi_pa +
> > +                             (guest_index * IMSIC_MMIO_PAGE_SZ);
> > +
> > +       return 0;
> > +}
> > +
> > +static int imsic_get_cpu(struct imsic_priv *priv,
> > +                        const struct cpumask *mask_val, bool force,
> > +                        unsigned int *out_target_cpu)
> > +{
> > +       struct cpumask amask;
> > +       unsigned int cpu;
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
> > +       if (out_target_cpu)
> > +               *out_target_cpu =3D cpu;
> > +
> > +       return 0;
> > +}
> > +
> > +static int imsic_get_cpu_msi_msg(unsigned int cpu, unsigned int id,
> > +                                struct msi_msg *msg)
> > +{
> > +       phys_addr_t msi_addr;
> > +       int err;
> > +
> > +       err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +       if (err)
> > +               return err;
> > +
> > +       msg->address_hi =3D upper_32_bits(msi_addr);
> > +       msg->address_lo =3D lower_32_bits(msi_addr);
> > +       msg->data =3D id;
> > +
> > +       return err;
> > +}
> > +
> > +static void imsic_id_set_target(struct imsic_priv *priv,
> > +                                unsigned int id, unsigned int target_c=
pu)
> > +{
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       priv->ids_target_cpu[id] =3D target_cpu;
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static unsigned int imsic_id_get_target(struct imsic_priv *priv,
> > +                                       unsigned int id)
> > +{
> > +       unsigned int ret;
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       ret =3D priv->ids_target_cpu[id];
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +       return ret;
> > +}
> > +
> > +static void __imsic_eix_update(unsigned long base_id,
> > +                              unsigned long num_id, bool pend, bool va=
l)
> > +{
> > +       unsigned long i, isel, ireg, flags;
> > +       unsigned long id =3D base_id, last_id =3D base_id + num_id;
> > +
> > +       while (id < last_id) {
> > +               isel =3D id / BITS_PER_LONG;
> > +               isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +               isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
> > +
> > +               ireg =3D 0;
> > +               for (i =3D id & (__riscv_xlen - 1);
> > +                    (id < last_id) && (i < __riscv_xlen); i++) {
> > +                       ireg |=3D BIT(i);
> > +                       id++;
> > +               }
> > +
> > +               /*
> > +                * The IMSIC EIEx and EIPx registers are indirectly
> > +                * accessed via using ISELECT and IREG CSRs so we
> > +                * save/restore local IRQ to ensure that we don't
> > +                * get preempted while accessing IMSIC registers.
> > +                */
> > +               local_irq_save(flags);
> > +               if (val)
> > +                       imsic_csr_set(isel, ireg);
> > +               else
> > +                       imsic_csr_clear(isel, ireg);
> > +               local_irq_restore(flags);
> > +       }
> > +}
> > +
> > +#define __imsic_id_enable(__id)                \
> > +       __imsic_eix_update((__id), 1, false, true)
> > +#define __imsic_id_disable(__id)       \
> > +       __imsic_eix_update((__id), 1, false, false)
> > +
> > +#ifdef CONFIG_SMP
> > +static void __imsic_id_smp_sync(struct imsic_priv *priv)
> > +{
> > +       struct imsic_handler *handler;
> > +       struct cpumask amask;
> > +       int cpu;
> > +
> > +       cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> > +       for_each_cpu(cpu, &amask) {
> > +               if (cpu =3D=3D smp_processor_id())
> > +                       continue;
> > +
> > +               handler =3D per_cpu_ptr(&imsic_handlers, cpu);
> > +               if (!handler || !handler->priv || !handler->local.msi_v=
a) {
> > +                       pr_warn("CPU%d: handler not initialized\n", cpu=
);
> > +                       continue;
> > +               }
> > +
> > +               writel(handler->priv->ipi_lsync_id, handler->local.msi_=
va);
> > +       }
> > +}
> > +#else
> > +#define __imsic_id_smp_sync(__priv)
> > +#endif
> > +
> > +static void imsic_id_enable(struct imsic_priv *priv, unsigned int id)
> > +{
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       bitmap_set(priv->ids_enabled_bimap, id, 1);
> > +       __imsic_id_enable(id);
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +       __imsic_id_smp_sync(priv);
> > +}
> > +
> > +static void imsic_id_disable(struct imsic_priv *priv, unsigned int id)
> > +{
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       bitmap_clear(priv->ids_enabled_bimap, id, 1);
> > +       __imsic_id_disable(id);
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +       __imsic_id_smp_sync(priv);
> > +}
> > +
> > +static void imsic_ids_local_sync(struct imsic_priv *priv)
> > +{
> > +       int i;
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       for (i =3D 1; i <=3D priv->global.nr_ids; i++) {
> > +               if (priv->ipi_id =3D=3D i || priv->ipi_lsync_id =3D=3D =
i)
> > +                       continue;
> > +
> > +               if (test_bit(i, priv->ids_enabled_bimap))
> > +                       __imsic_id_enable(i);
> > +               else
> > +                       __imsic_id_disable(i);
> > +       }
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static void imsic_ids_local_delivery(struct imsic_priv *priv, bool ena=
ble)
> > +{
> > +       if (enable) {
> > +               imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRES=
HOLD);
> > +               imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVE=
RY);
> > +       } else {
> > +               imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIV=
ERY);
> > +               imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRE=
SHOLD);
> > +       }
> > +}
> > +
> > +static int imsic_ids_alloc(struct imsic_priv *priv,
> > +                          unsigned int max_id, unsigned int order)
> > +{
> > +       int ret;
> > +       unsigned long flags;
> > +
> > +       if ((priv->global.nr_ids < max_id) ||
> > +           (max_id < BIT(order)))
> > +               return -EINVAL;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       ret =3D bitmap_find_free_region(priv->ids_used_bimap,
> > +                                     max_id + 1, order);
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +       return ret;
> > +}
> > +
> > +static void imsic_ids_free(struct imsic_priv *priv, unsigned int base_=
id,
> > +                          unsigned int order)
> > +{
> > +       unsigned long flags;
> > +
> > +       raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +       bitmap_release_region(priv->ids_used_bimap, base_id, order);
> > +       raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static int __init imsic_ids_init(struct imsic_priv *priv)
> > +{
> > +       int i;
> > +       struct imsic_global_config *global =3D &priv->global;
> > +
> > +       raw_spin_lock_init(&priv->ids_lock);
> > +
> > +       /* Allocate used bitmap */
> > +       priv->ids_used_bimap =3D kcalloc(BITS_TO_LONGS(global->nr_ids +=
 1),
> > +                                       sizeof(unsigned long), GFP_KERN=
EL);
> > +       if (!priv->ids_used_bimap)
> > +               return -ENOMEM;
> > +
> > +       /* Allocate enabled bitmap */
> > +       priv->ids_enabled_bimap =3D kcalloc(BITS_TO_LONGS(global->nr_id=
s + 1),
> > +                                          sizeof(unsigned long), GFP_K=
ERNEL);
> > +       if (!priv->ids_enabled_bimap) {
> > +               kfree(priv->ids_used_bimap);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* Allocate target CPU array */
> > +       priv->ids_target_cpu =3D kcalloc(global->nr_ids + 1,
> > +                                      sizeof(unsigned int), GFP_KERNEL=
);
> > +       if (!priv->ids_target_cpu) {
> > +               kfree(priv->ids_enabled_bimap);
> > +               kfree(priv->ids_used_bimap);
> > +               return -ENOMEM;
> > +       }
> > +       for (i =3D 0; i <=3D global->nr_ids; i++)
> > +               priv->ids_target_cpu[i] =3D UINT_MAX;
> > +
> > +       /* Reserve ID#0 because it is special and never implemented */
> > +       bitmap_set(priv->ids_used_bimap, 0, 1);
> > +
> > +       return 0;
> > +}
> > +
> > +static void __init imsic_ids_cleanup(struct imsic_priv *priv)
> > +{
> > +       kfree(priv->ids_target_cpu);
> > +       kfree(priv->ids_enabled_bimap);
> > +       kfree(priv->ids_used_bimap);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +       struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, =
cpu);
> > +
> > +       if (!handler || !handler->priv || !handler->local.msi_va) {
> > +               pr_warn("CPU%d: handler not initialized\n", cpu);
> > +               return;
> > +       }
> > +
> > +       writel(handler->priv->ipi_id, handler->local.msi_va);
> > +}
> > +
> > +static void imsic_ipi_enable(struct imsic_priv *priv)
> > +{
> > +       __imsic_id_enable(priv->ipi_id);
> > +       __imsic_id_enable(priv->ipi_lsync_id);
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(struct imsic_priv *priv)
> > +{
> > +       int virq;
> > +
> > +       /* Allocate interrupt identity for IPIs */
> > +       virq =3D imsic_ids_alloc(priv, priv->global.nr_ids, get_count_o=
rder(1));
> > +       if (virq < 0)
> > +               return virq;
> > +       priv->ipi_id =3D virq;
> > +
> > +       /* Create IMSIC IPI multiplexing */
> > +       virq =3D ipi_mux_create(BITS_PER_BYTE, imsic_ipi_send);
> > +       if (virq <=3D 0) {
> > +               imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +               return (virq < 0) ? virq : -ENOMEM;
> > +       }
> > +
> > +       /* Set vIRQ range */
> > +       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, true);
> > +
> > +       /* Allocate interrupt identity for local enable/disable sync */
> > +       virq =3D imsic_ids_alloc(priv, priv->global.nr_ids, get_count_o=
rder(1));
> > +       if (virq < 0) {
> > +               imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +               return virq;
> > +       }
> > +       priv->ipi_lsync_id =3D virq;
> > +
> > +       return 0;
> > +}
> > +
> > +static void __init imsic_ipi_domain_cleanup(struct imsic_priv *priv)
> > +{
> > +       imsic_ids_free(priv, priv->ipi_lsync_id, get_count_order(1));
> > +       if (priv->ipi_id)
> > +               imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +}
> > +#else
> > +static void imsic_ipi_enable(struct imsic_priv *priv)
> > +{
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(struct imsic_priv *priv)
> > +{
> > +       /* Clear the IPI ids because we are not using IPIs */
> > +       priv->ipi_id =3D 0;
> > +       priv->ipi_lsync_id =3D 0;
> > +       return 0;
> > +}
> > +
> > +static void __init imsic_ipi_domain_cleanup(struct imsic_priv *priv)
> > +{
> > +}
> > +#endif
> > +
> > +static void imsic_irq_mask(struct irq_data *d)
> > +{
> > +       imsic_id_disable(irq_data_get_irq_chip_data(d), d->hwirq);
> > +}
> > +
> > +static void imsic_irq_unmask(struct irq_data *d)
> > +{
> > +       imsic_id_enable(irq_data_get_irq_chip_data(d), d->hwirq);
> > +}
> > +
> > +static void imsic_irq_compose_msi_msg(struct irq_data *d,
> > +                                     struct msi_msg *msg)
> > +{
> > +       struct imsic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +       unsigned int cpu;
> > +       int err;
> > +
> > +       cpu =3D imsic_id_get_target(priv, d->hwirq);
> > +       WARN_ON(cpu =3D=3D UINT_MAX);
> > +
> > +       err =3D imsic_get_cpu_msi_msg(cpu, d->hwirq, msg);
> > +       WARN_ON(err);
> > +
> > +       iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int imsic_irq_set_affinity(struct irq_data *d,
> > +                                 const struct cpumask *mask_val,
> > +                                 bool force)
> > +{
> > +       struct imsic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +       unsigned int target_cpu;
> > +       int rc;
> > +
> > +       rc =3D imsic_get_cpu(priv, mask_val, force, &target_cpu);
> > +       if (rc)
> > +               return rc;
> > +
> > +       imsic_id_set_target(priv, d->hwirq, target_cpu);
> > +       irq_data_update_effective_affinity(d, cpumask_of(target_cpu));
> > +
> > +       return IRQ_SET_MASK_OK;
> > +}
> > +#endif
> > +
> > +static struct irq_chip imsic_irq_base_chip =3D {
> > +       .name                   =3D "RISC-V IMSIC-BASE",
> > +       .irq_mask               =3D imsic_irq_mask,
> > +       .irq_unmask             =3D imsic_irq_unmask,
> > +#ifdef CONFIG_SMP
> > +       .irq_set_affinity       =3D imsic_irq_set_affinity,
> > +#endif
> > +       .irq_compose_msi_msg    =3D imsic_irq_compose_msi_msg,
> > +       .flags                  =3D IRQCHIP_SKIP_SET_WAKE |
> > +                                 IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int imsic_irq_domain_alloc(struct irq_domain *domain,
> > +                                 unsigned int virq,
> > +                                 unsigned int nr_irqs,
> > +                                 void *args)
> > +{
> > +       struct imsic_priv *priv =3D domain->host_data;
> > +       msi_alloc_info_t *info =3D args;
> > +       phys_addr_t msi_addr;
> > +       int i, hwirq, err =3D 0;
> > +       unsigned int cpu;
> > +
> > +       err =3D imsic_get_cpu(priv, &priv->lmask, false, &cpu);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +       if (err)
> > +               return err;
> > +
> > +       hwirq =3D imsic_ids_alloc(priv, priv->global.nr_ids,
> > +                               get_count_order(nr_irqs));
> > +       if (hwirq < 0)
> > +               return hwirq;
> > +
> > +       err =3D iommu_dma_prepare_msi(info->desc, msi_addr);
>
> Hi Anup,
> First of all, thank you for completing this patch set to support all
> AIA features. After investigating this patch, I'm concerned that it
> may have a potential issue with changing CPU affinity.
>
> As far as I understand, the imsic_irq_domain_alloc() is only called
> once for a device when this device registers its IRQ. It means that
> the iommu_dma_prepare_msi() will be called once too. When a device has
> IOMMU support, the iommu_dma_prepare_msi() will allocate an IOVA for
> the physical MSI address of this device and then call iommu_map to
> create the mapping between this IOVA and the physical MSI address.
> Besides, it also calls msi_desc_set_iommu_cookie to set this IOVA to
> the iommu_cookie. Afterward, iommu_dma_compose_msi_msg() called by the
> imsic_irq_compose_msi_msg() will directly use this desc->iommu_cookie
> to compose the MSI address for this device. However, as mentioned
> early, the iommu_dma_prepare_msi() is called only when a device
> registers its IRQ. Therefore, it only allocates an IOVA for the 1st
> online CPU and sets this IOVA to desc->iommu_cookie. In this
> circumstance, I worry that changing the CPU affinity will not work for
> this device. This is because the IMSIC driver does not create the new
> IOMMU mapping for the MSI address of the new CPU when changing the CPU
> affinity. Besides, the desc->iommu_cookie still records the msi_msg of
> the old CPU without updating.
>
> To solve this problem, one possible solution is to create all IOVA to
> core IMSIC IOMMU mappings in the imsic_irq_domain_alloc(). Then, when
> changing the IRQ affinity to a new CPU, the IMSIC driver needs to
> update the desc->iommu_cookie with the IOVA of this new CPU. However,
> I'm not sure if updating desc->iommu_cookie every time the CPU
> affinity changes would break its original cookie spirit.

Thanks for pointing out this potential issue. I will try to solve this in
v3 patch.

Regards,
Anup

>
>
> > +       if (err)
> > +               goto fail;
> > +
> > +       for (i =3D 0; i < nr_irqs; i++) {
> > +               imsic_id_set_target(priv, hwirq + i, cpu);
> > +               irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                   &imsic_irq_base_chip, priv,
> > +                                   handle_simple_irq, NULL, NULL);
> > +               irq_set_noprobe(virq + i);
> > +               irq_set_affinity(virq + i, &priv->lmask);
> > +       }
> > +
> > +       return 0;
> > +
> > +fail:
> > +       imsic_ids_free(priv, hwirq, get_count_order(nr_irqs));
> > +       return err;
> > +}
> > +
> > +static void imsic_irq_domain_free(struct irq_domain *domain,
> > +                                 unsigned int virq,
> > +                                 unsigned int nr_irqs)
> > +{
> > +       struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +       struct imsic_priv *priv =3D domain->host_data;
> > +
> > +       imsic_ids_free(priv, d->hwirq, get_count_order(nr_irqs));
> > +       irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> > +}
> > +
> > +static const struct irq_domain_ops imsic_base_domain_ops =3D {
> > +       .alloc          =3D imsic_irq_domain_alloc,
> > +       .free           =3D imsic_irq_domain_free,
> > +};
> > +
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +
> > +static void imsic_pci_mask_irq(struct irq_data *d)
> > +{
> > +       pci_msi_mask_irq(d);
> > +       irq_chip_mask_parent(d);
> > +}
> > +
> > +static void imsic_pci_unmask_irq(struct irq_data *d)
> > +{
> > +       pci_msi_unmask_irq(d);
> > +       irq_chip_unmask_parent(d);
> > +}
> > +
> > +static struct irq_chip imsic_pci_irq_chip =3D {
> > +       .name                   =3D "RISC-V IMSIC-PCI",
> > +       .irq_mask               =3D imsic_pci_mask_irq,
> > +       .irq_unmask             =3D imsic_pci_unmask_irq,
> > +       .irq_eoi                =3D irq_chip_eoi_parent,
> > +};
> > +
> > +static struct msi_domain_ops imsic_pci_domain_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imsic_pci_domain_info =3D {
> > +       .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_O=
PS |
> > +                  MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
> > +       .ops    =3D &imsic_pci_domain_ops,
> > +       .chip   =3D &imsic_pci_irq_chip,
> > +};
> > +
> > +#endif
> > +
> > +static struct irq_chip imsic_plat_irq_chip =3D {
> > +       .name                   =3D "RISC-V IMSIC-PLAT",
> > +};
> > +
> > +static struct msi_domain_ops imsic_plat_domain_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imsic_plat_domain_info =3D {
> > +       .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_O=
PS),
> > +       .ops    =3D &imsic_plat_domain_ops,
> > +       .chip   =3D &imsic_plat_irq_chip,
> > +};
> > +
> > +static int __init imsic_irq_domains_init(struct imsic_priv *priv,
> > +                                        struct fwnode_handle *fwnode)
> > +{
> > +       /* Create Base IRQ domain */
> > +       priv->base_domain =3D irq_domain_create_tree(fwnode,
> > +                                               &imsic_base_domain_ops,=
 priv);
> > +       if (!priv->base_domain) {
> > +               pr_err("Failed to create IMSIC base domain\n");
> > +               return -ENOMEM;
> > +       }
> > +       irq_domain_update_bus_token(priv->base_domain, DOMAIN_BUS_NEXUS=
);
> > +
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +       /* Create PCI MSI domain */
> > +       priv->pci_domain =3D pci_msi_create_irq_domain(fwnode,
> > +                                               &imsic_pci_domain_info,
> > +                                               priv->base_domain);
> > +       if (!priv->pci_domain) {
> > +               pr_err("Failed to create IMSIC PCI domain\n");
> > +               irq_domain_remove(priv->base_domain);
> > +               return -ENOMEM;
> > +       }
> > +#endif
> > +
> > +       /* Create Platform MSI domain */
> > +       priv->plat_domain =3D platform_msi_create_irq_domain(fwnode,
> > +                                               &imsic_plat_domain_info=
,
> > +                                               priv->base_domain);
> > +       if (!priv->plat_domain) {
> > +               pr_err("Failed to create IMSIC platform domain\n");
> > +               if (priv->pci_domain)
> > +                       irq_domain_remove(priv->pci_domain);
> > +               irq_domain_remove(priv->base_domain);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * To handle an interrupt, we read the TOPEI CSR and write zero in one
> > + * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
> > + * Linux interrupt number and let Linux IRQ subsystem handle it.
> > + */
> > +static void imsic_handle_irq(struct irq_desc *desc)
> > +{
> > +       struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers)=
;
> > +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +       struct imsic_priv *priv =3D handler->priv;
> > +       irq_hw_number_t hwirq;
> > +       int err;
> > +
> > +       WARN_ON_ONCE(!handler->priv);
> > +
> > +       chained_irq_enter(chip, desc);
> > +
> > +       while ((hwirq =3D csr_swap(CSR_TOPEI, 0))) {
> > +               hwirq =3D hwirq >> TOPEI_ID_SHIFT;
> > +
> > +               if (hwirq =3D=3D priv->ipi_id) {
> > +#ifdef CONFIG_SMP
> > +                       ipi_mux_process();
> > +#endif
> > +                       continue;
> > +               } else if (hwirq =3D=3D priv->ipi_lsync_id) {
> > +                       imsic_ids_local_sync(priv);
> > +                       continue;
> > +               }
> > +
> > +               err =3D generic_handle_domain_irq(priv->base_domain, hw=
irq);
> > +               if (unlikely(err))
> > +                       pr_warn_ratelimited(
> > +                               "hwirq %lu mapping not found\n", hwirq)=
;
> > +       }
> > +
> > +       chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +       struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers)=
;
> > +       struct imsic_priv *priv =3D handler->priv;
> > +
> > +       /* Enable per-CPU parent interrupt */
> > +       if (imsic_parent_irq)
> > +               enable_percpu_irq(imsic_parent_irq,
> > +                                 irq_get_trigger_type(imsic_parent_irq=
));
> > +       else
> > +               pr_warn("cpu%d: parent irq not available\n", cpu);
> > +
> > +       /* Enable IPIs */
> > +       imsic_ipi_enable(priv);
> > +
> > +       /*
> > +        * Interrupts identities might have been enabled/disabled while
> > +        * this CPU was not running so sync-up local enable/disable sta=
te.
> > +        */
> > +       imsic_ids_local_sync(priv);
> > +
> > +       /* Locally enable interrupt delivery */
> > +       imsic_ids_local_delivery(priv, true);
> > +
> > +       return 0;
> > +}
> > +
> > +struct imsic_fwnode_ops {
> > +       u32 (*nr_parent_irq)(struct fwnode_handle *fwnode,
> > +                            void *fwopaque);
> > +       int (*parent_hartid)(struct fwnode_handle *fwnode,
> > +                            void *fwopaque, u32 index,
> > +                            unsigned long *out_hartid);
> > +       u32 (*nr_mmio)(struct fwnode_handle *fwnode, void *fwopaque);
> > +       int (*mmio_to_resource)(struct fwnode_handle *fwnode,
> > +                               void *fwopaque, u32 index,
> > +                               struct resource *res);
> > +       void __iomem *(*mmio_map)(struct fwnode_handle *fwnode,
> > +                                 void *fwopaque, u32 index);
> > +       int (*read_u32)(struct fwnode_handle *fwnode,
> > +                       void *fwopaque, const char *prop, u32 *out_val)=
;
> > +       bool (*read_bool)(struct fwnode_handle *fwnode,
> > +                         void *fwopaque, const char *prop);
> > +};
> > +
> > +static int __init imsic_init(struct imsic_fwnode_ops *fwops,
> > +                            struct fwnode_handle *fwnode,
> > +                            void *fwopaque)
> > +{
> > +       struct resource res;
> > +       phys_addr_t base_addr;
> > +       int rc, nr_parent_irqs;
> > +       struct imsic_mmio *mmio;
> > +       struct imsic_priv *priv;
> > +       struct irq_domain *domain;
> > +       struct imsic_handler *handler;
> > +       struct imsic_global_config *global;
> > +       u32 i, tmp, nr_handlers =3D 0;
> > +
> > +       if (imsic_init_done) {
> > +               pr_err("%pfwP: already initialized hence ignoring\n",
> > +                       fwnode);
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (!riscv_isa_extension_available(NULL, SxAIA)) {
> > +               pr_err("%pfwP: AIA support not available\n", fwnode);
> > +               return -ENODEV;
> > +       }
> > +
> > +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +       global =3D &priv->global;
> > +
> > +       /* Find number of parent interrupts */
> > +       nr_parent_irqs =3D fwops->nr_parent_irq(fwnode, fwopaque);
> > +       if (!nr_parent_irqs) {
> > +               pr_err("%pfwP: no parent irqs available\n", fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of guest index bits in MSI address */
> > +       rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,guest-index-bit=
s",
> > +                            &global->guest_index_bits);
> > +       if (rc)
> > +               global->guest_index_bits =3D 0;
> > +       tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> > +       if (tmp < global->guest_index_bits) {
> > +               pr_err("%pfwP: guest index bits too big\n", fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of HART index bits */
> > +       rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,hart-index-bits=
",
> > +                            &global->hart_index_bits);
> > +       if (rc) {
> > +               /* Assume default value */
> > +               global->hart_index_bits =3D __fls(nr_parent_irqs);
> > +               if (BIT(global->hart_index_bits) < nr_parent_irqs)
> > +                       global->hart_index_bits++;
> > +       }
> > +       tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +             global->guest_index_bits;
> > +       if (tmp < global->hart_index_bits) {
> > +               pr_err("%pfwP: HART index bits too big\n", fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of group index bits */
> > +       rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,group-index-bit=
s",
> > +                            &global->group_index_bits);
> > +       if (rc)
> > +               global->group_index_bits =3D 0;
> > +       tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +             global->guest_index_bits - global->hart_index_bits;
> > +       if (tmp < global->group_index_bits) {
> > +               pr_err("%pfwP: group index bits too big\n", fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /*
> > +        * Find first bit position of group index.
> > +        * If not specified assumed the default APLIC-IMSIC configurati=
on.
> > +        */
> > +       rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,group-index-shi=
ft",
> > +                            &global->group_index_shift);
> > +       if (rc)
> > +               global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2=
;
> > +       tmp =3D global->group_index_bits + global->group_index_shift - =
1;
> > +       if (tmp >=3D BITS_PER_LONG) {
> > +               pr_err("%pfwP: group index shift too big\n", fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of interrupt identities */
> > +       rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,num-ids",
> > +                            &global->nr_ids);
> > +       if (rc) {
> > +               pr_err("%pfwP: number of interrupt identities not found=
\n",
> > +                       fwnode);
> > +               return rc;
> > +       }
> > +       if ((global->nr_ids < IMSIC_MIN_ID) ||
> > +           (global->nr_ids >=3D IMSIC_MAX_ID) ||
> > +           ((global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +               pr_err("%pfwP: invalid number of interrupt identities\n=
",
> > +                       fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Find number of guest interrupt identities */
> > +       if (fwops->read_u32(fwnode, fwopaque, "riscv,num-guest-ids",
> > +                           &global->nr_guest_ids))
> > +               global->nr_guest_ids =3D global->nr_ids;
> > +       if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
> > +           (global->nr_guest_ids >=3D IMSIC_MAX_ID) ||
> > +           ((global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) =
{
> > +               pr_err("%pfwP: invalid number of guest interrupt identi=
ties\n",
> > +                       fwnode);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Compute base address */
> > +       rc =3D fwops->mmio_to_resource(fwnode, fwopaque, 0, &res);
> > +       if (rc) {
> > +               pr_err("%pfwP: first MMIO resource not found\n", fwnode=
);
> > +               return -EINVAL;
> > +       }
> > +       global->base_addr =3D res.start;
> > +       global->base_addr &=3D ~(BIT(global->guest_index_bits +
> > +                                  global->hart_index_bits +
> > +                                  IMSIC_MMIO_PAGE_SHIFT) - 1);
> > +       global->base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
> > +                              global->group_index_shift);
> > +
> > +       /* Find number of MMIO register sets */
> > +       priv->num_mmios =3D fwops->nr_mmio(fwnode, fwopaque);
> > +
> > +       /* Allocate MMIO register sets */
> > +       priv->mmios =3D kcalloc(priv->num_mmios, sizeof(*mmio), GFP_KER=
NEL);
> > +       if (!priv->mmios) {
> > +               rc =3D -ENOMEM;
> > +               goto out_free_priv;
> > +       }
> > +
> > +       /* Parse and map MMIO register sets */
> > +       for (i =3D 0; i < priv->num_mmios; i++) {
> > +               mmio =3D &priv->mmios[i];
> > +               rc =3D fwops->mmio_to_resource(fwnode, fwopaque, i, &re=
s);
> > +               if (rc) {
> > +                       pr_err("%pfwP: unable to parse MMIO regset %d\n=
",
> > +                               fwnode, i);
> > +                       goto out_iounmap;
> > +               }
> > +               mmio->pa =3D res.start;
> > +               mmio->size =3D res.end - res.start + 1;
> > +
> > +               base_addr =3D mmio->pa;
> > +               base_addr &=3D ~(BIT(global->guest_index_bits +
> > +                                  global->hart_index_bits +
> > +                                  IMSIC_MMIO_PAGE_SHIFT) - 1);
> > +               base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
> > +                              global->group_index_shift);
> > +               if (base_addr !=3D global->base_addr) {
> > +                       rc =3D -EINVAL;
> > +                       pr_err("%pfwP: address mismatch for regset %d\n=
",
> > +                               fwnode, i);
> > +                       goto out_iounmap;
> > +               }
> > +
> > +               mmio->va =3D fwops->mmio_map(fwnode, fwopaque, i);
> > +               if (!mmio->va) {
> > +                       rc =3D -EIO;
> > +                       pr_err("%pfwP: unable to map MMIO regset %d\n",
> > +                               fwnode, i);
> > +                       goto out_iounmap;
> > +               }
> > +       }
> > +
> > +       /* Initialize interrupt identity management */
> > +       rc =3D imsic_ids_init(priv);
> > +       if (rc) {
> > +               pr_err("%pfwP: failed to initialize interrupt managemen=
t\n",
> > +                      fwnode);
> > +               goto out_iounmap;
> > +       }
> > +
> > +       /* Configure handlers for target CPUs */
> > +       for (i =3D 0; i < nr_parent_irqs; i++) {
> > +               unsigned long reloff, hartid;
> > +               int j, cpu;
> > +
> > +               rc =3D fwops->parent_hartid(fwnode, fwopaque, i, &harti=
d);
> > +               if (rc) {
> > +                       pr_warn("%pfwP: hart ID for parent irq%d not fo=
und\n",
> > +                               fwnode, i);
> > +                       continue;
> > +               }
> > +
> > +               cpu =3D riscv_hartid_to_cpuid(hartid);
> > +               if (cpu < 0) {
> > +                       pr_warn("%pfwP: invalid cpuid for parent irq%d\=
n",
> > +                               fwnode, i);
> > +                       continue;
> > +               }
> > +
> > +               /* Find MMIO location of MSI page */
> > +               mmio =3D NULL;
> > +               reloff =3D i * BIT(global->guest_index_bits) *
> > +                        IMSIC_MMIO_PAGE_SZ;
> > +               for (j =3D 0; priv->num_mmios; j++) {
> > +                       if (reloff < priv->mmios[j].size) {
> > +                               mmio =3D &priv->mmios[j];
> > +                               break;
> > +                       }
> > +
> > +                       /*
> > +                        * MMIO region size may not be aligned to
> > +                        * BIT(global->guest_index_bits) * IMSIC_MMIO_P=
AGE_SZ
> > +                        * if holes are present.
> > +                        */
> > +                       reloff -=3D ALIGN(priv->mmios[j].size,
> > +                       BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE=
_SZ);
> > +               }
> > +               if (!mmio) {
> > +                       pr_warn("%pfwP: MMIO not found for parent irq%d=
\n",
> > +                               fwnode, i);
> > +                       continue;
> > +               }
> > +
> > +               handler =3D per_cpu_ptr(&imsic_handlers, cpu);
> > +               if (handler->priv) {
> > +                       pr_warn("%pfwP: CPU%d handler already configure=
d.\n",
> > +                               fwnode, cpu);
> > +                       goto done;
> > +               }
> > +
> > +               cpumask_set_cpu(cpu, &priv->lmask);
> > +               handler->local.msi_pa =3D mmio->pa + reloff;
> > +               handler->local.msi_va =3D mmio->va + reloff;
> > +               handler->priv =3D priv;
> > +
> > +done:
> > +               nr_handlers++;
> > +       }
> > +
> > +       /* If no CPU handlers found then can't take interrupts */
> > +       if (!nr_handlers) {
> > +               pr_err("%pfwP: No CPU handlers found\n", fwnode);
> > +               rc =3D -ENODEV;
> > +               goto out_ids_cleanup;
> > +       }
> > +
> > +       /* Find parent domain and register chained handler */
> > +       domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                         DOMAIN_BUS_ANY);
> > +       if (!domain) {
> > +               pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> > +               rc =3D -ENOENT;
> > +               goto out_ids_cleanup;
> > +       }
> > +       imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
> > +       if (!imsic_parent_irq) {
> > +               pr_err("%pfwP: Failed to create INTC mapping\n", fwnode=
);
> > +               rc =3D -ENOENT;
> > +               goto out_ids_cleanup;
> > +       }
> > +       irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
> > +
> > +       /* Initialize IPI domain */
> > +       rc =3D imsic_ipi_domain_init(priv);
> > +       if (rc) {
> > +               pr_err("%pfwP: Failed to initialize IPI domain\n", fwno=
de);
> > +               goto out_ids_cleanup;
> > +       }
> > +
> > +       /* Initialize IRQ and MSI domains */
> > +       rc =3D imsic_irq_domains_init(priv, fwnode);
> > +       if (rc) {
> > +               pr_err("%pfwP: Failed to initialize IRQ and MSI domains=
\n",
> > +                      fwnode);
> > +               goto out_ipi_domain_cleanup;
> > +       }
> > +
> > +       /*
> > +        * Setup cpuhp state
> > +        *
> > +        * Don't disable per-CPU IMSIC file when CPU goes offline
> > +        * because this affects IPI and the masking/unmasking of
> > +        * virtual IPIs is done via generic IPI-Mux
> > +        */
> > +       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                         "irqchip/riscv/imsic:starting",
> > +                         imsic_starting_cpu, NULL);
> > +
> > +       /*
> > +        * Only one IMSIC instance allowed in a platform for clean
> > +        * implementation of SMP IRQ affinity and per-CPU IPIs.
> > +        *
> > +        * This means on a multi-socket (or multi-die) platform we
> > +        * will have multiple MMIO regions for one IMSIC instance.
> > +        */
> > +       imsic_init_done =3D true;
> > +
> > +       pr_info("%pfwP:  hart-index-bits: %d,  guest-index-bits: %d\n",
> > +               fwnode, global->hart_index_bits, global->guest_index_bi=
ts);
> > +       pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
> > +               fwnode, global->group_index_bits, global->group_index_s=
hift);
> > +       pr_info("%pfwP: mapped %d interrupts for %d CPUs at %pa\n",
> > +               fwnode, global->nr_ids, nr_handlers, &global->base_addr=
);
> > +       if (priv->ipi_lsync_id)
> > +               pr_info("%pfwP: enable/disable sync using interrupt %d\=
n",
> > +                       fwnode, priv->ipi_lsync_id);
> > +       if (priv->ipi_id)
> > +               pr_info("%pfwP: providing IPIs using interrupt %d\n",
> > +                       fwnode, priv->ipi_id);
> > +
> > +       return 0;
> > +
> > +out_ipi_domain_cleanup:
> > +       imsic_ipi_domain_cleanup(priv);
> > +out_ids_cleanup:
> > +       imsic_ids_cleanup(priv);
> > +out_iounmap:
> > +       for (i =3D 0; i < priv->num_mmios; i++) {
> > +               if (priv->mmios[i].va)
> > +                       iounmap(priv->mmios[i].va);
> > +       }
> > +       kfree(priv->mmios);
> > +out_free_priv:
> > +       kfree(priv);
> > +       return rc;
> > +}
> > +
> > +static u32 __init imsic_dt_nr_parent_irq(struct fwnode_handle *fwnode,
> > +                                        void *fwopaque)
> > +{
> > +       return of_irq_count(to_of_node(fwnode));
> > +}
> > +
> > +static int __init imsic_dt_parent_hartid(struct fwnode_handle *fwnode,
> > +                                        void *fwopaque, u32 index,
> > +                                        unsigned long *out_hartid)
> > +{
> > +       struct of_phandle_args parent;
> > +       int rc;
> > +
> > +       rc =3D of_irq_parse_one(to_of_node(fwnode), index, &parent);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /*
> > +        * Skip interrupts other than external interrupts for
> > +        * current privilege level.
> > +        */
> > +       if (parent.args[0] !=3D RV_IRQ_EXT)
> > +               return -EINVAL;
> > +
> > +       return riscv_of_parent_hartid(parent.np, out_hartid);
> > +}
> > +
> > +static u32 __init imsic_dt_nr_mmio(struct fwnode_handle *fwnode,
> > +                                  void *fwopaque)
> > +{
> > +       u32 ret =3D 0;
> > +       struct resource res;
> > +
> > +       while (!of_address_to_resource(to_of_node(fwnode), ret, &res))
> > +               ret++;
> > +
> > +       return ret;
> > +}
> > +
> > +static int __init imsic_mmio_to_resource(struct fwnode_handle *fwnode,
> > +                                        void *fwopaque, u32 index,
> > +                                        struct resource *res)
> > +{
> > +       return of_address_to_resource(to_of_node(fwnode), index, res);
> > +}
> > +
> > +static void __iomem __init *imsic_dt_mmio_map(struct fwnode_handle *fw=
node,
> > +                                             void *fwopaque, u32 index=
)
> > +{
> > +       return of_iomap(to_of_node(fwnode), index);
> > +}
> > +
> > +static int __init imsic_dt_read_u32(struct fwnode_handle *fwnode,
> > +                                   void *fwopaque, const char *prop,
> > +                                   u32 *out_val)
> > +{
> > +       return of_property_read_u32(to_of_node(fwnode), prop, out_val);
> > +}
> > +
> > +static bool __init imsic_dt_read_bool(struct fwnode_handle *fwnode,
> > +                                     void *fwopaque, const char *prop)
> > +{
> > +       return of_property_read_bool(to_of_node(fwnode), prop);
> > +}
> > +
> > +static int __init imsic_dt_init(struct device_node *node,
> > +                               struct device_node *parent)
> > +{
> > +       struct imsic_fwnode_ops ops =3D {
> > +               .nr_parent_irq =3D imsic_dt_nr_parent_irq,
> > +               .parent_hartid =3D imsic_dt_parent_hartid,
> > +               .nr_mmio =3D imsic_dt_nr_mmio,
> > +               .mmio_to_resource =3D imsic_mmio_to_resource,
> > +               .mmio_map =3D imsic_dt_mmio_map,
> > +               .read_u32 =3D imsic_dt_read_u32,
> > +               .read_bool =3D imsic_dt_read_bool,
> > +       };
> > +
> > +       return imsic_init(&ops, &node->fwnode, NULL);
> > +}
> > +IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_dt_init);
> > diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchi=
p/riscv-imsic.h
> > new file mode 100644
> > index 000000000000..5d1387adc0ba
> > --- /dev/null
> > +++ b/include/linux/irqchip/riscv-imsic.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +#ifndef __LINUX_IRQCHIP_RISCV_IMSIC_H
> > +#define __LINUX_IRQCHIP_RISCV_IMSIC_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +
> > +#define IMSIC_MMIO_PAGE_SHIFT          12
> > +#define IMSIC_MMIO_PAGE_SZ             (1UL << IMSIC_MMIO_PAGE_SHIFT)
> > +#define IMSIC_MMIO_PAGE_LE             0x00
> > +#define IMSIC_MMIO_PAGE_BE             0x04
> > +
> > +#define IMSIC_MIN_ID                   63
> > +#define IMSIC_MAX_ID                   2048
> > +
> > +#define IMSIC_EIDELIVERY               0x70
> > +
> > +#define IMSIC_EITHRESHOLD              0x72
> > +
> > +#define IMSIC_EIP0                     0x80
> > +#define IMSIC_EIP63                    0xbf
> > +#define IMSIC_EIPx_BITS                        32
> > +
> > +#define IMSIC_EIE0                     0xc0
> > +#define IMSIC_EIE63                    0xff
> > +#define IMSIC_EIEx_BITS                        32
> > +
> > +#define IMSIC_FIRST                    IMSIC_EIDELIVERY
> > +#define IMSIC_LAST                     IMSIC_EIE63
> > +
> > +#define IMSIC_MMIO_SETIPNUM_LE         0x00
> > +#define IMSIC_MMIO_SETIPNUM_BE         0x04
> > +
> > +struct imsic_global_config {
> > +       /*
> > +        * MSI Target Address Scheme
> > +        *
> > +        * XLEN-1                                                12    =
 0
> > +        * |                                                     |     =
|
> > +        * ------------------------------------------------------------=
-
> > +        * |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  =
|
> > +        * ------------------------------------------------------------=
-
> > +        */
> > +
> > +       /* Bits representing Guest index, HART index, and Group index *=
/
> > +       u32 guest_index_bits;
> > +       u32 hart_index_bits;
> > +       u32 group_index_bits;
> > +       u32 group_index_shift;
> > +
> > +       /* Global base address matching all target MSI addresses */
> > +       phys_addr_t base_addr;
> > +
> > +       /* Number of interrupt identities */
> > +       u32 nr_ids;
> > +
> > +       /* Number of guest interrupt identities */
> > +       u32 nr_guest_ids;
> > +};
> > +
> > +struct imsic_local_config {
> > +       phys_addr_t msi_pa;
> > +       void __iomem *msi_va;
> > +};
> > +
> > +#ifdef CONFIG_RISCV_IMSIC
> > +
> > +extern const struct imsic_global_config *imsic_get_global_config(void)=
;
> > +
> > +extern const struct imsic_local_config *imsic_get_local_config(
> > +                                                       unsigned int cp=
u);
> > +
> > +#else
> > +
> > +static inline const struct imsic_global_config *imsic_get_global_confi=
g(void)
> > +{
> > +       return NULL;
> > +}
> > +
> > +static inline const struct imsic_local_config *imsic_get_local_config(
> > +                                                       unsigned int cp=
u)
> > +{
> > +       return NULL;
> > +}
> > +
> > +#endif
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
