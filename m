Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A06F2F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjEAI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:28:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED0E4D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 01:28:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so1474762a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1682929708; x=1685521708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isGIqES6mkz5HuZNmQyxvQFr6Y5ulxaB1RDsa+ksiCY=;
        b=gIJzj325MOAgenEdJtaWbHg+1tsxRLVAAuZbr2XlywIVXOogwLoB/HHn0WGqGy99Bx
         gA+gQAW0GMUrlTt9ReaUJgq8fX0oMsFt6AOGIOZ1N6E8khKgbJeWVpZLV1B8IMxl+vXS
         rTPasFNXHXY3Ak4rD64HGG5uEe3HR0lA7QgMla1LGsFlNtIkAC6FH5/PdAyTKiYoR3ZV
         0WKD9F7WeIE3qcHBrVt4NpqOBTQ+DCp8Y+hjxc95ZIbh77Wc0QP6tmdT5H3ssqlQCNn+
         E0e5Mlc3GIdmfrNH9OEFQP1NVwLUc6Y3se1s9v5Vf9rlJ1veJvDKgvQPS5jslSzPqiFG
         tW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682929708; x=1685521708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGIqES6mkz5HuZNmQyxvQFr6Y5ulxaB1RDsa+ksiCY=;
        b=byIvgMwkTZ7Vy1QGaUfyy+zQeXf0/vEz80NPUQbdNKPr3qkV0F4lwzW1MFTjZnrGIn
         2RZMM7jQolyh5rk9BuhDV4n44qh3dEFztoWYjalUmhoUMXIds/bwZTXP5XnwMHmuX77v
         gd+cfiwkXTlUFjh7FTUbSb9UMHPaWZjKgx3NltDLPEVruDS1eIAjlmKQ8JZQQ6vLB3E4
         DiF/6kYuKG+3+W7hmImKE559NRLQ7ytURXXc9elO25CL16ztm0FddcB3MEkyufB0u5U9
         SaX6aDqkQVH3IeryD1t00MWfayKMeJbxR4PnKqgJMFvZXaNhWi7ESGgt0v9XkpyCbaBN
         t3Xw==
X-Gm-Message-State: AC+VfDy8rAv2YTIgfr6zf0ojH2x0a7Tfy+qQO3g57mw+tSdLn28OzFCD
        PBK53as0esB5WGcRcd74YtLBr5lm5asgYvMQkL28PeAMHl+Xrso1Zf99HQ==
X-Google-Smtp-Source: ACHHUZ77MWPt1gf4gd1HfsdusCzFvztwF5VZSb6CN3LIERcJ+KnIrXNGNaKBoRKS1Lbb5JCKqWj8kGNrUWfp/cpIeiY=
X-Received: by 2002:a17:906:4791:b0:960:ddba:e5bb with SMTP id
 cw17-20020a170906479100b00960ddbae5bbmr9387604ejc.43.1682929707981; Mon, 01
 May 2023 01:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-6-apatel@ventanamicro.com> <867cxqoic8.wl-maz@kernel.org>
In-Reply-To: <867cxqoic8.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 May 2023 13:58:16 +0530
Message-ID: <CAAhSdy39OJo1c0Yt9588m_aXc7BJ9OEVm1hCJEbv3Km31hmbkA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] irqchip: Add RISC-V incoming MSI controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 3:40=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 03 Jan 2023 14:14:05 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > The RISC-V advanced interrupt architecture (AIA) specification defines
> > a new MSI controller for managing MSIs on a RISC-V platform. This new
> > MSI controller is referred to as incoming message signaled interrupt
> > controller (IMSIC) which manages MSI on per-HART (or per-CPU) basis.
> > (For more details refer https://github.com/riscv/riscv-aia)
>
> And how about IPIs, which this driver seems to be concerned about?

Okay, I will mention about IPIs in the commit description.

>
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
> >       bool
> > -
> >  config ARM_GIC_V3
> >       bool
> >       select IRQ_DOMAIN_HIERARCHY
> > @@ -548,6 +547,19 @@ config SIFIVE_PLIC
> >       select IRQ_DOMAIN_HIERARCHY
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_IMSIC
> > +     bool
> > +     depends on RISCV
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select GENERIC_MSI_IRQ_DOMAIN
> > +
> > +config RISCV_IMSIC_PCI
> > +     bool
> > +     depends on RISCV_IMSIC
> > +     depends on PCI
> > +     depends on PCI_MSI
> > +     default RISCV_IMSIC
>
> This should definitely tell you that this driver needs splitting.

The code under "#ifdef CONFIG_RISCV_IMSIC_PCI" is hardly 40 lines
so I felt it was too small to deserve its own source file.

>
> > +
> >  config EXYNOS_IRQ_COMBINER
> >       bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
> >       depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 87b49a10962c..22c723cc6ec8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -96,6 +96,7 @@ obj-$(CONFIG_QCOM_MPM)                      +=3D irq-=
qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)          +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)             +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_IMSIC)            +=3D irq-riscv-imsic.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)             +=3D irq-imx-intmux.o
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
> > +#define IMSIC_DISABLE_EIDELIVERY     0
> > +#define IMSIC_ENABLE_EIDELIVERY              1
> > +#define IMSIC_DISABLE_EITHRESHOLD    1
> > +#define IMSIC_ENABLE_EITHRESHOLD     0
> > +
> > +#define imsic_csr_write(__c, __v)    \
> > +do {                                 \
> > +     csr_write(CSR_ISELECT, __c);    \
> > +     csr_write(CSR_IREG, __v);       \
> > +} while (0)
> > +
> > +#define imsic_csr_read(__c)          \
> > +({                                   \
> > +     unsigned long __v;              \
> > +     csr_write(CSR_ISELECT, __c);    \
> > +     __v =3D csr_read(CSR_IREG);       \
> > +     __v;                            \
> > +})
> > +
> > +#define imsic_csr_set(__c, __v)              \
> > +do {                                 \
> > +     csr_write(CSR_ISELECT, __c);    \
> > +     csr_set(CSR_IREG, __v);         \
> > +} while (0)
> > +
> > +#define imsic_csr_clear(__c, __v)    \
> > +do {                                 \
> > +     csr_write(CSR_ISELECT, __c);    \
> > +     csr_clear(CSR_IREG, __v);       \
> > +} while (0)
> > +
> > +struct imsic_mmio {
> > +     phys_addr_t pa;
> > +     void __iomem *va;
> > +     unsigned long size;
> > +};
> > +
> > +struct imsic_priv {
> > +     /* Global configuration common for all HARTs */
> > +     struct imsic_global_config global;
> > +
> > +     /* MMIO regions */
> > +     u32 num_mmios;
> > +     struct imsic_mmio *mmios;
> > +
> > +     /* Global state of interrupt identities */
> > +     raw_spinlock_t ids_lock;
> > +     unsigned long *ids_used_bimap;
> > +     unsigned long *ids_enabled_bimap;
> > +     unsigned int *ids_target_cpu;
> > +
> > +     /* Mask for connected CPUs */
> > +     struct cpumask lmask;
> > +
> > +     /* IPI interrupt identity */
> > +     u32 ipi_id;
> > +     u32 ipi_lsync_id;
> > +
> > +     /* IRQ domains */
> > +     struct irq_domain *base_domain;
> > +     struct irq_domain *pci_domain;
> > +     struct irq_domain *plat_domain;
> > +};
> > +
> > +struct imsic_handler {
> > +     /* Local configuration for given HART */
> > +     struct imsic_local_config local;
> > +
> > +     /* Pointer to private context */
> > +     struct imsic_priv *priv;
> > +};
> > +
> > +static bool imsic_init_done;
> > +
> > +static int imsic_parent_irq;
> > +static DEFINE_PER_CPU(struct imsic_handler, imsic_handlers);
> > +
> > +const struct imsic_global_config *imsic_get_global_config(void)
> > +{
> > +     struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers);
> > +
> > +     if (!handler || !handler->priv)
> > +             return NULL;
> > +
> > +     return &handler->priv->global;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
> > +
> > +const struct imsic_local_config *imsic_get_local_config(unsigned int c=
pu)
> > +{
> > +     struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, cp=
u);
> > +
> > +     if (!handler || !handler->priv)
> > +             return NULL;
>
> How can this happen?

These are redundant checks. I will drop.

>
> > +
> > +     return &handler->local;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_local_config);
>
> Why are these symbols exported? They have no user, so they shouldn't
> even exist here. I also seriously doubt there is a valid use case for
> exposing this information to the rest of the kernel.

The imsic_get_global_config() is used by APLIC driver and KVM RISC-V
module whereas imsic_get_local_config() is only used by KVM RISC-V.

The KVM RISC-V AIA irqchip patches are available in riscv_kvm_aia_v1
branch at: https://github.com/avpatel/linux.git. I have not posted KVM RISC=
-V
patches due various interdependencies.

>
> > +
> > +static int imsic_cpu_page_phys(unsigned int cpu,
> > +                            unsigned int guest_index,
> > +                            phys_addr_t *out_msi_pa)
> > +{
> > +     struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, cp=
u);
> > +     struct imsic_global_config *global;
> > +     struct imsic_local_config *local;
> > +
> > +     if (!handler || !handler->priv)
> > +             return -ENODEV;
> > +     local =3D &handler->local;
> > +     global =3D &handler->priv->global;
> > +
> > +     if (BIT(global->guest_index_bits) <=3D guest_index)
> > +             return -EINVAL;
> > +
> > +     if (out_msi_pa)
> > +             *out_msi_pa =3D local->msi_pa +
> > +                           (guest_index * IMSIC_MMIO_PAGE_SZ);
> > +
> > +     return 0;
> > +}
> > +
> > +static int imsic_get_cpu(struct imsic_priv *priv,
> > +                      const struct cpumask *mask_val, bool force,
> > +                      unsigned int *out_target_cpu)
> > +{
> > +     struct cpumask amask;
> > +     unsigned int cpu;
> > +
> > +     cpumask_and(&amask, &priv->lmask, mask_val);
> > +
> > +     if (force)
> > +             cpu =3D cpumask_first(&amask);
> > +     else
> > +             cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> > +
> > +     if (cpu >=3D nr_cpu_ids)
> > +             return -EINVAL;
> > +
> > +     if (out_target_cpu)
> > +             *out_target_cpu =3D cpu;
> > +
> > +     return 0;
> > +}
> > +
> > +static int imsic_get_cpu_msi_msg(unsigned int cpu, unsigned int id,
> > +                              struct msi_msg *msg)
> > +{
> > +     phys_addr_t msi_addr;
> > +     int err;
> > +
> > +     err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +     if (err)
> > +             return err;
> > +
> > +     msg->address_hi =3D upper_32_bits(msi_addr);
> > +     msg->address_lo =3D lower_32_bits(msi_addr);
> > +     msg->data =3D id;
> > +
> > +     return err;
> > +}
> > +
> > +static void imsic_id_set_target(struct imsic_priv *priv,
> > +                              unsigned int id, unsigned int target_cpu=
)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     priv->ids_target_cpu[id] =3D target_cpu;
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static unsigned int imsic_id_get_target(struct imsic_priv *priv,
> > +                                     unsigned int id)
> > +{
> > +     unsigned int ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     ret =3D priv->ids_target_cpu[id];
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __imsic_eix_update(unsigned long base_id,
> > +                            unsigned long num_id, bool pend, bool val)
> > +{
> > +     unsigned long i, isel, ireg, flags;
> > +     unsigned long id =3D base_id, last_id =3D base_id + num_id;
> > +
> > +     while (id < last_id) {
> > +             isel =3D id / BITS_PER_LONG;
> > +             isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +             isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
> > +
> > +             ireg =3D 0;
> > +             for (i =3D id & (__riscv_xlen - 1);
> > +                  (id < last_id) && (i < __riscv_xlen); i++) {
> > +                     ireg |=3D BIT(i);
> > +                     id++;
> > +             }
> > +
> > +             /*
> > +              * The IMSIC EIEx and EIPx registers are indirectly
> > +              * accessed via using ISELECT and IREG CSRs so we
> > +              * save/restore local IRQ to ensure that we don't
> > +              * get preempted while accessing IMSIC registers.
> > +              */
> > +             local_irq_save(flags);
> > +             if (val)
> > +                     imsic_csr_set(isel, ireg);
> > +             else
> > +                     imsic_csr_clear(isel, ireg);
> > +             local_irq_restore(flags);
>
> What is the actual requirement? no preemption? or no interrupts? This
> isn't the same thing. Also, a bunch of the users already disable
> interrupts. Consistency wouldn't hurt here.

No preemption is the only requirement. Since the callers of these
functions disable local IRQ, I think we don't need to not anything
special here. I will drop the local IRQ save/restore and update
the comments as well.

>
> > +     }
> > +}
> > +
> > +#define __imsic_id_enable(__id)              \
> > +     __imsic_eix_update((__id), 1, false, true)
> > +#define __imsic_id_disable(__id)     \
> > +     __imsic_eix_update((__id), 1, false, false)
> > +
> > +#ifdef CONFIG_SMP
> > +static void __imsic_id_smp_sync(struct imsic_priv *priv)
> > +{
> > +     struct imsic_handler *handler;
> > +     struct cpumask amask;
> > +     int cpu;
> > +
> > +     cpumask_and(&amask, &priv->lmask, cpu_online_mask);
>
> Can't this race against a CPU going down?

Yes, it can race if a CPU goes down while we are in this function
but this won't be a problem because the imsic_starting_cpu()
will unconditionally do imsic_ids_local_sync() when the CPU is
brought-up again. I will add a multiline comment block explaining
this.

>
> > +     for_each_cpu(cpu, &amask) {
> > +             if (cpu =3D=3D smp_processor_id())
> > +                     continue;
> > +
> > +             handler =3D per_cpu_ptr(&imsic_handlers, cpu);
> > +             if (!handler || !handler->priv || !handler->local.msi_va)=
 {
> > +                     pr_warn("CPU%d: handler not initialized\n", cpu);
>
> How many times are you going to do that? On each failing synchronisation?

My bad for adding these paranoid checks. I remove these checks
wherever possible.

>
> > +                     continue;
> > +             }
> > +
> > +             writel(handler->priv->ipi_lsync_id, handler->local.msi_va=
);
>
> As I understand it, this is a "behind the scenes" IPI. Why isn't that
> a *real* IPI?

Yes, that's correct. The ID enable bits are per-CPU accessible only
via CSRs hence we have a special "behind the scenes" IPI to
synchronize state of ID enable bits.

>
> > +     }
> > +}
> > +#else
> > +#define __imsic_id_smp_sync(__priv)
> > +#endif
> > +
> > +static void imsic_id_enable(struct imsic_priv *priv, unsigned int id)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     bitmap_set(priv->ids_enabled_bimap, id, 1);
> > +     __imsic_id_enable(id);
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +     __imsic_id_smp_sync(priv);
> > +}
> > +
> > +static void imsic_id_disable(struct imsic_priv *priv, unsigned int id)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     bitmap_clear(priv->ids_enabled_bimap, id, 1);
> > +     __imsic_id_disable(id);
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +     __imsic_id_smp_sync(priv);
> > +}
> > +
> > +static void imsic_ids_local_sync(struct imsic_priv *priv)
> > +{
> > +     int i;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     for (i =3D 1; i <=3D priv->global.nr_ids; i++) {
> > +             if (priv->ipi_id =3D=3D i || priv->ipi_lsync_id =3D=3D i)
> > +                     continue;
> > +
> > +             if (test_bit(i, priv->ids_enabled_bimap))
> > +                     __imsic_id_enable(i);
> > +             else
> > +                     __imsic_id_disable(i);
> > +     }
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static void imsic_ids_local_delivery(struct imsic_priv *priv, bool ena=
ble)
> > +{
> > +     if (enable) {
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHO=
LD);
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY=
);
> > +     } else {
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVER=
Y);
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESH=
OLD);
> > +     }
> > +}
> > +
> > +static int imsic_ids_alloc(struct imsic_priv *priv,
> > +                        unsigned int max_id, unsigned int order)
> > +{
> > +     int ret;
> > +     unsigned long flags;
> > +
> > +     if ((priv->global.nr_ids < max_id) ||
> > +         (max_id < BIT(order)))
> > +             return -EINVAL;
>
> Why do we need this check? Shouldn't that be guaranteed by
> construction?

Yes, these are redundant checks. I will remove it.

>
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     ret =3D bitmap_find_free_region(priv->ids_used_bimap,
> > +                                   max_id + 1, order);
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static void imsic_ids_free(struct imsic_priv *priv, unsigned int base_=
id,
> > +                        unsigned int order)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&priv->ids_lock, flags);
> > +     bitmap_release_region(priv->ids_used_bimap, base_id, order);
> > +     raw_spin_unlock_irqrestore(&priv->ids_lock, flags);
> > +}
> > +
> > +static int __init imsic_ids_init(struct imsic_priv *priv)
> > +{
> > +     int i;
> > +     struct imsic_global_config *global =3D &priv->global;
> > +
> > +     raw_spin_lock_init(&priv->ids_lock);
> > +
> > +     /* Allocate used bitmap */
> > +     priv->ids_used_bimap =3D kcalloc(BITS_TO_LONGS(global->nr_ids + 1=
),
> > +                                     sizeof(unsigned long), GFP_KERNEL=
);
>
> How about bitmap_alloc?

Okay, I will use bitmap_zalloc() here.

>
> > +     if (!priv->ids_used_bimap)
> > +             return -ENOMEM;
> > +
> > +     /* Allocate enabled bitmap */
> > +     priv->ids_enabled_bimap =3D kcalloc(BITS_TO_LONGS(global->nr_ids =
+ 1),
> > +                                        sizeof(unsigned long), GFP_KER=
NEL);
> > +     if (!priv->ids_enabled_bimap) {
> > +             kfree(priv->ids_used_bimap);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Allocate target CPU array */
> > +     priv->ids_target_cpu =3D kcalloc(global->nr_ids + 1,
> > +                                    sizeof(unsigned int), GFP_KERNEL);
> > +     if (!priv->ids_target_cpu) {
> > +             kfree(priv->ids_enabled_bimap);
> > +             kfree(priv->ids_used_bimap);
> > +             return -ENOMEM;
> > +     }
> > +     for (i =3D 0; i <=3D global->nr_ids; i++)
> > +             priv->ids_target_cpu[i] =3D UINT_MAX;
> > +
> > +     /* Reserve ID#0 because it is special and never implemented */
> > +     bitmap_set(priv->ids_used_bimap, 0, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __init imsic_ids_cleanup(struct imsic_priv *priv)
> > +{
> > +     kfree(priv->ids_target_cpu);
> > +     kfree(priv->ids_enabled_bimap);
> > +     kfree(priv->ids_used_bimap);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +     struct imsic_handler *handler =3D per_cpu_ptr(&imsic_handlers, cp=
u);
> > +
> > +     if (!handler || !handler->priv || !handler->local.msi_va) {
> > +             pr_warn("CPU%d: handler not initialized\n", cpu);
> > +             return;
> > +     }
> > +
> > +     writel(handler->priv->ipi_id, handler->local.msi_va);
> > +}
> > +
> > +static void imsic_ipi_enable(struct imsic_priv *priv)
> > +{
> > +     __imsic_id_enable(priv->ipi_id);
> > +     __imsic_id_enable(priv->ipi_lsync_id);
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(struct imsic_priv *priv)
> > +{
> > +     int virq;
> > +
> > +     /* Allocate interrupt identity for IPIs */
> > +     virq =3D imsic_ids_alloc(priv, priv->global.nr_ids, get_count_ord=
er(1));
> > +     if (virq < 0)
> > +             return virq;
> > +     priv->ipi_id =3D virq;
> > +
> > +     /* Create IMSIC IPI multiplexing */
> > +     virq =3D ipi_mux_create(BITS_PER_BYTE, imsic_ipi_send);
>
> Please! This BITS_PER_BYTE makes zero sense here. Have a proper define
> that says 8, and document *why* this is 8! You're not defining a type
> system, you're writing a irqchip driver.

Okay, I will add a "#define" for the number of IPI with an explanation
for *why*.

>
> > +     if (virq <=3D 0) {
> > +             imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +             return (virq < 0) ? virq : -ENOMEM;
> > +     }
> > +
> > +     /* Set vIRQ range */
> > +     riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, true);
> > +
> > +     /* Allocate interrupt identity for local enable/disable sync */
> > +     virq =3D imsic_ids_alloc(priv, priv->global.nr_ids, get_count_ord=
er(1));
> > +     if (virq < 0) {
> > +             imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +             return virq;
> > +     }
> > +     priv->ipi_lsync_id =3D virq;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __init imsic_ipi_domain_cleanup(struct imsic_priv *priv)
> > +{
> > +     imsic_ids_free(priv, priv->ipi_lsync_id, get_count_order(1));
> > +     if (priv->ipi_id)
> > +             imsic_ids_free(priv, priv->ipi_id, get_count_order(1));
> > +}
> > +#else
> > +static void imsic_ipi_enable(struct imsic_priv *priv)
> > +{
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(struct imsic_priv *priv)
> > +{
> > +     /* Clear the IPI ids because we are not using IPIs */
> > +     priv->ipi_id =3D 0;
> > +     priv->ipi_lsync_id =3D 0;
> > +     return 0;
> > +}
> > +
> > +static void __init imsic_ipi_domain_cleanup(struct imsic_priv *priv)
> > +{
> > +}
> > +#endif
> > +
> > +static void imsic_irq_mask(struct irq_data *d)
> > +{
> > +     imsic_id_disable(irq_data_get_irq_chip_data(d), d->hwirq);
> > +}
> > +
> > +static void imsic_irq_unmask(struct irq_data *d)
> > +{
> > +     imsic_id_enable(irq_data_get_irq_chip_data(d), d->hwirq);
> > +}
> > +
> > +static void imsic_irq_compose_msi_msg(struct irq_data *d,
> > +                                   struct msi_msg *msg)
> > +{
> > +     struct imsic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     unsigned int cpu;
> > +     int err;
> > +
> > +     cpu =3D imsic_id_get_target(priv, d->hwirq);
> > +     WARN_ON(cpu =3D=3D UINT_MAX);
> > +
> > +     err =3D imsic_get_cpu_msi_msg(cpu, d->hwirq, msg);
> > +     WARN_ON(err);
> > +
> > +     iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int imsic_irq_set_affinity(struct irq_data *d,
> > +                               const struct cpumask *mask_val,
> > +                               bool force)
> > +{
> > +     struct imsic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     unsigned int target_cpu;
> > +     int rc;
> > +
> > +     rc =3D imsic_get_cpu(priv, mask_val, force, &target_cpu);
> > +     if (rc)
> > +             return rc;
> > +
> > +     imsic_id_set_target(priv, d->hwirq, target_cpu);
> > +     irq_data_update_effective_affinity(d, cpumask_of(target_cpu));
> > +
> > +     return IRQ_SET_MASK_OK;
> > +}
> > +#endif
> > +
> > +static struct irq_chip imsic_irq_base_chip =3D {
> > +     .name                   =3D "RISC-V IMSIC-BASE",
> > +     .irq_mask               =3D imsic_irq_mask,
> > +     .irq_unmask             =3D imsic_irq_unmask,
> > +#ifdef CONFIG_SMP
> > +     .irq_set_affinity       =3D imsic_irq_set_affinity,
> > +#endif
> > +     .irq_compose_msi_msg    =3D imsic_irq_compose_msi_msg,
> > +     .flags                  =3D IRQCHIP_SKIP_SET_WAKE |
> > +                               IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int imsic_irq_domain_alloc(struct irq_domain *domain,
> > +                               unsigned int virq,
> > +                               unsigned int nr_irqs,
> > +                               void *args)
> > +{
> > +     struct imsic_priv *priv =3D domain->host_data;
> > +     msi_alloc_info_t *info =3D args;
> > +     phys_addr_t msi_addr;
> > +     int i, hwirq, err =3D 0;
> > +     unsigned int cpu;
> > +
> > +     err =3D imsic_get_cpu(priv, &priv->lmask, false, &cpu);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D imsic_cpu_page_phys(cpu, 0, &msi_addr);
> > +     if (err)
> > +             return err;
> > +
> > +     hwirq =3D imsic_ids_alloc(priv, priv->global.nr_ids,
> > +                             get_count_order(nr_irqs));
> > +     if (hwirq < 0)
> > +             return hwirq;
> > +
> > +     err =3D iommu_dma_prepare_msi(info->desc, msi_addr);
> > +     if (err)
> > +             goto fail;
> > +
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             imsic_id_set_target(priv, hwirq + i, cpu);
> > +             irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                 &imsic_irq_base_chip, priv,
> > +                                 handle_simple_irq, NULL, NULL);
> > +             irq_set_noprobe(virq + i);
> > +             irq_set_affinity(virq + i, &priv->lmask);
> > +     }
> > +
> > +     return 0;
> > +
> > +fail:
> > +     imsic_ids_free(priv, hwirq, get_count_order(nr_irqs));
> > +     return err;
> > +}
> > +
> > +static void imsic_irq_domain_free(struct irq_domain *domain,
> > +                               unsigned int virq,
> > +                               unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +     struct imsic_priv *priv =3D domain->host_data;
> > +
> > +     imsic_ids_free(priv, d->hwirq, get_count_order(nr_irqs));
> > +     irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> > +}
> > +
> > +static const struct irq_domain_ops imsic_base_domain_ops =3D {
> > +     .alloc          =3D imsic_irq_domain_alloc,
> > +     .free           =3D imsic_irq_domain_free,
> > +};
> > +
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +
> > +static void imsic_pci_mask_irq(struct irq_data *d)
> > +{
> > +     pci_msi_mask_irq(d);
> > +     irq_chip_mask_parent(d);
> > +}
> > +
> > +static void imsic_pci_unmask_irq(struct irq_data *d)
> > +{
> > +     pci_msi_unmask_irq(d);
> > +     irq_chip_unmask_parent(d);
> > +}
> > +
> > +static struct irq_chip imsic_pci_irq_chip =3D {
> > +     .name                   =3D "RISC-V IMSIC-PCI",
> > +     .irq_mask               =3D imsic_pci_mask_irq,
> > +     .irq_unmask             =3D imsic_pci_unmask_irq,
> > +     .irq_eoi                =3D irq_chip_eoi_parent,
> > +};
> > +
> > +static struct msi_domain_ops imsic_pci_domain_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imsic_pci_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS=
 |
> > +                MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
> > +     .ops    =3D &imsic_pci_domain_ops,
> > +     .chip   =3D &imsic_pci_irq_chip,
> > +};
> > +
> > +#endif
> > +
> > +static struct irq_chip imsic_plat_irq_chip =3D {
> > +     .name                   =3D "RISC-V IMSIC-PLAT",
> > +};
> > +
> > +static struct msi_domain_ops imsic_plat_domain_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imsic_plat_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS=
),
> > +     .ops    =3D &imsic_plat_domain_ops,
> > +     .chip   =3D &imsic_plat_irq_chip,
> > +};
> > +
> > +static int __init imsic_irq_domains_init(struct imsic_priv *priv,
> > +                                      struct fwnode_handle *fwnode)
> > +{
> > +     /* Create Base IRQ domain */
> > +     priv->base_domain =3D irq_domain_create_tree(fwnode,
> > +                                             &imsic_base_domain_ops, p=
riv);
> > +     if (!priv->base_domain) {
> > +             pr_err("Failed to create IMSIC base domain\n");
> > +             return -ENOMEM;
> > +     }
> > +     irq_domain_update_bus_token(priv->base_domain, DOMAIN_BUS_NEXUS);
> > +
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +     /* Create PCI MSI domain */
> > +     priv->pci_domain =3D pci_msi_create_irq_domain(fwnode,
> > +                                             &imsic_pci_domain_info,
> > +                                             priv->base_domain);
> > +     if (!priv->pci_domain) {
> > +             pr_err("Failed to create IMSIC PCI domain\n");
> > +             irq_domain_remove(priv->base_domain);
> > +             return -ENOMEM;
> > +     }
> > +#endif
> > +
> > +     /* Create Platform MSI domain */
> > +     priv->plat_domain =3D platform_msi_create_irq_domain(fwnode,
> > +                                             &imsic_plat_domain_info,
> > +                                             priv->base_domain);
> > +     if (!priv->plat_domain) {
> > +             pr_err("Failed to create IMSIC platform domain\n");
> > +             if (priv->pci_domain)
> > +                     irq_domain_remove(priv->pci_domain);
> > +             irq_domain_remove(priv->base_domain);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * To handle an interrupt, we read the TOPEI CSR and write zero in one
> > + * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
> > + * Linux interrupt number and let Linux IRQ subsystem handle it.
> > + */
> > +static void imsic_handle_irq(struct irq_desc *desc)
> > +{
> > +     struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers);
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     struct imsic_priv *priv =3D handler->priv;
> > +     irq_hw_number_t hwirq;
> > +     int err;
> > +
> > +     WARN_ON_ONCE(!handler->priv);
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((hwirq =3D csr_swap(CSR_TOPEI, 0))) {
> > +             hwirq =3D hwirq >> TOPEI_ID_SHIFT;
> > +
> > +             if (hwirq =3D=3D priv->ipi_id) {
> > +#ifdef CONFIG_SMP
> > +                     ipi_mux_process();
> > +#endif
> > +                     continue;
> > +             } else if (hwirq =3D=3D priv->ipi_lsync_id) {
> > +                     imsic_ids_local_sync(priv);
> > +                     continue;
> > +             }
> > +
> > +             err =3D generic_handle_domain_irq(priv->base_domain, hwir=
q);
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited(
> > +                             "hwirq %lu mapping not found\n", hwirq);
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +     struct imsic_handler *handler =3D this_cpu_ptr(&imsic_handlers);
> > +     struct imsic_priv *priv =3D handler->priv;
> > +
> > +     /* Enable per-CPU parent interrupt */
> > +     if (imsic_parent_irq)
> > +             enable_percpu_irq(imsic_parent_irq,
> > +                               irq_get_trigger_type(imsic_parent_irq))=
;
>
> Shouldn't that be the default already?

The imsic_parent_irq is already set before calling imsic_starting_cpu()
on each CPU so we can drop the if-check.

>
> > +     else
> > +             pr_warn("cpu%d: parent irq not available\n", cpu);
>
> And yet continue in sequence? Duh...

This warning is also not required.

>
> > +
> > +     /* Enable IPIs */
> > +     imsic_ipi_enable(priv);
> > +
> > +     /*
> > +      * Interrupts identities might have been enabled/disabled while
> > +      * this CPU was not running so sync-up local enable/disable state=
.
> > +      */
> > +     imsic_ids_local_sync(priv);
> > +
> > +     /* Locally enable interrupt delivery */
> > +     imsic_ids_local_delivery(priv, true);
> > +
> > +     return 0;
> > +}
> > +
> > +struct imsic_fwnode_ops {
> > +     u32 (*nr_parent_irq)(struct fwnode_handle *fwnode,
> > +                          void *fwopaque);
> > +     int (*parent_hartid)(struct fwnode_handle *fwnode,
> > +                          void *fwopaque, u32 index,
> > +                          unsigned long *out_hartid);
> > +     u32 (*nr_mmio)(struct fwnode_handle *fwnode, void *fwopaque);
> > +     int (*mmio_to_resource)(struct fwnode_handle *fwnode,
> > +                             void *fwopaque, u32 index,
> > +                             struct resource *res);
> > +     void __iomem *(*mmio_map)(struct fwnode_handle *fwnode,
> > +                               void *fwopaque, u32 index);
> > +     int (*read_u32)(struct fwnode_handle *fwnode,
> > +                     void *fwopaque, const char *prop, u32 *out_val);
> > +     bool (*read_bool)(struct fwnode_handle *fwnode,
> > +                       void *fwopaque, const char *prop);
> > +};
>
> Why do we need this sort of (terrible) indirection?

Okay, I will replace this indirection with fwnode APIs.

>
> > +
> > +static int __init imsic_init(struct imsic_fwnode_ops *fwops,
> > +                          struct fwnode_handle *fwnode,
> > +                          void *fwopaque)
> > +{
> > +     struct resource res;
> > +     phys_addr_t base_addr;
> > +     int rc, nr_parent_irqs;
> > +     struct imsic_mmio *mmio;
> > +     struct imsic_priv *priv;
> > +     struct irq_domain *domain;
> > +     struct imsic_handler *handler;
> > +     struct imsic_global_config *global;
> > +     u32 i, tmp, nr_handlers =3D 0;
> > +
> > +     if (imsic_init_done) {
> > +             pr_err("%pfwP: already initialized hence ignoring\n",
> > +                     fwnode);
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (!riscv_isa_extension_available(NULL, SxAIA)) {
> > +             pr_err("%pfwP: AIA support not available\n", fwnode);
> > +             return -ENODEV;
> > +     }
> > +
> > +     priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +     global =3D &priv->global;
> > +
> > +     /* Find number of parent interrupts */
> > +     nr_parent_irqs =3D fwops->nr_parent_irq(fwnode, fwopaque);
> > +     if (!nr_parent_irqs) {
> > +             pr_err("%pfwP: no parent irqs available\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of guest index bits in MSI address */
> > +     rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,guest-index-bits"=
,
> > +                          &global->guest_index_bits);
> > +     if (rc)
> > +             global->guest_index_bits =3D 0;
> > +     tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> > +     if (tmp < global->guest_index_bits) {
> > +             pr_err("%pfwP: guest index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of HART index bits */
> > +     rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,hart-index-bits",
> > +                          &global->hart_index_bits);
> > +     if (rc) {
> > +             /* Assume default value */
> > +             global->hart_index_bits =3D __fls(nr_parent_irqs);
> > +             if (BIT(global->hart_index_bits) < nr_parent_irqs)
> > +                     global->hart_index_bits++;
> > +     }
> > +     tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +           global->guest_index_bits;
> > +     if (tmp < global->hart_index_bits) {
> > +             pr_err("%pfwP: HART index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of group index bits */
> > +     rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,group-index-bits"=
,
> > +                          &global->group_index_bits);
> > +     if (rc)
> > +             global->group_index_bits =3D 0;
> > +     tmp =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +           global->guest_index_bits - global->hart_index_bits;
> > +     if (tmp < global->group_index_bits) {
> > +             pr_err("%pfwP: group index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /*
> > +      * Find first bit position of group index.
> > +      * If not specified assumed the default APLIC-IMSIC configuration=
.
> > +      */
> > +     rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,group-index-shift=
",
> > +                          &global->group_index_shift);
> > +     if (rc)
> > +             global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> > +     tmp =3D global->group_index_bits + global->group_index_shift - 1;
> > +     if (tmp >=3D BITS_PER_LONG) {
> > +             pr_err("%pfwP: group index shift too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of interrupt identities */
> > +     rc =3D fwops->read_u32(fwnode, fwopaque, "riscv,num-ids",
> > +                          &global->nr_ids);
> > +     if (rc) {
> > +             pr_err("%pfwP: number of interrupt identities not found\n=
",
> > +                     fwnode);
> > +             return rc;
> > +     }
> > +     if ((global->nr_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of interrupt identities\n",
> > +                     fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of guest interrupt identities */
> > +     if (fwops->read_u32(fwnode, fwopaque, "riscv,num-guest-ids",
> > +                         &global->nr_guest_ids))
> > +             global->nr_guest_ids =3D global->nr_ids;
> > +     if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_guest_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of guest interrupt identiti=
es\n",
> > +                     fwnode);
> > +             return -EINVAL;
> > +     }
>
> Please split the whole guest stuff out. It is totally unused!

The number of guest IDs is used by KVM RISC-V AIA support which
is in the pipeline. The KVM RISC-V only need imsic_get_global_config()
and imsic_get_local_config(). The "nr_guest_ids" is part of the
IMSIC global config.

>
> I've stopped reading. This needs structure, cleanups and a bit of
> taste. Not a lot of that here at the moment.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

It took a while to address all your comments and I also got
preempted by other stuff. Sorry for the delay.

Regards,
Anup
