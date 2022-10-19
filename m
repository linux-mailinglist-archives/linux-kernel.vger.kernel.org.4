Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918B76040DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiJSK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJSKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:25:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD8A2877
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:05:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g27so24442680edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVCVIDWRBFfk68X5/TRkj6PUws6XmZMzdOrMsfE4jbc=;
        b=pSce+6cLeyiOhyJ0wk2H/4tLAuy/lqgl1pvwnDNsSranB4bdrv79UaGPm1E8P9EZiW
         Elsau+aJjsIrZ1kTcZgI9tVCcseXLSCbFrEZT1zw5sT499oS18AibZJl+V6KTxZQFsAc
         na96M/Zn+RTIhGJyfcXWSc9Whd/CVLth6u+hBSNDpdPGOj6DGrydggXhQWoBNj85ZZjh
         MbzHMbTdHoyNz5FmrTB1/8kZcVvAuEFqObeNB9KrSO/w74Mfq29BNjqNETFqoPi2VlDg
         76I0o1ERCQ6zi8Z44iAEx1Y7cpXNvPRXx3lbXbgP2ZGvWTn8/tTwaeZDqK6rgoLm7dia
         oSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVCVIDWRBFfk68X5/TRkj6PUws6XmZMzdOrMsfE4jbc=;
        b=1GaIMclIJg+PHO9UqG/O4xQh2rJ6h0DqhOoY9n4bolSbmNYrnB4eqibFEr2cXm6YJV
         99klMh4EiKI5dLteU1zEBOF6Zf5uu865Wo9zDABGNjHuyPiXG7YPNpIRTID3QY9Kv3Ty
         eviOYV5bTJ82ektxZSYN7+QgR+1PZW2+9XRFz4Sh+RRs2nVoCYsvydBbnCAr5GGhxpAy
         HgS3trvcrxWCeE3q4ucFl/3e51EWxNsX+RTechmK9TkvRWuu2yqEk9hj1se5gNkXpAMK
         hq3IrW+WtdpPYzt6WRhlfueL7AJoC92crtWOIkB8VnsEBssmadRK7yv+gpSP1ZdxGCv7
         fMoA==
X-Gm-Message-State: ACrzQf34HXJvMbWcZqHHy30Sd4wTvJVRX/FVumc97SsoUPWA8S3XUrLv
        /0W4og2mm0mZ0DFLMUCQEfRPQbfykwEeOrcl5FDvSxcLGiU10VtNuhE=
X-Google-Smtp-Source: AMsMyM4u8Xgv8c019ItnUoBHv74N0spP0xPX0Pwray41AlLJxFowiBZ88UwMY3oWvvUr9BWNrDk3CmL4we1xiLxfTqo=
X-Received: by 2002:aa7:c314:0:b0:458:dc90:467a with SMTP id
 l20-20020aa7c314000000b00458dc90467amr6394310edq.284.1666173814868; Wed, 19
 Oct 2022 03:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221017031847.2407930-1-chenhuacai@loongson.cn> <87k04wgsrk.wl-maz@kernel.org>
In-Reply-To: <87k04wgsrk.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 19 Oct 2022 18:03:22 +0800
Message-ID: <CAAhV-H66VSuwdNGS2C0kR8oOqoLMHM5ZygwtrHTx9Vy7WjoPMA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-htvec: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
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

Hi, Marc,

On Wed, Oct 19, 2022 at 3:47 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 17 Oct 2022 04:18:47 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > HTVECINTC stands for "HyperTransport Interrupts" that described in
> > Section 14.3 of "Loongson 3A5000 Processor Reference Manual". For more
> > information please refer Documentation/loongarch/irq-chip-model.rst.
> >
> > Though the extended model is the recommended one, there are still some
> > legacy model machines. So we add ACPI init support for HTVECINTC.
> >
> > Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/irq.h       |   2 +-
> >  drivers/irqchip/Kconfig                |   1 +
> >  drivers/irqchip/irq-loongson-htvec.c   | 145 +++++++++++++++++++------
> >  drivers/irqchip/irq-loongson-liointc.c |  21 +++-
> >  4 files changed, 133 insertions(+), 36 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
> > index d06d4542b634..9d3d36e41afe 100644
> > --- a/arch/loongarch/include/asm/irq.h
> > +++ b/arch/loongarch/include/asm/irq.h
> > @@ -93,7 +93,7 @@ int liointc_acpi_init(struct irq_domain *parent,
> >  int eiointc_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_eio_pic *acpi_eiointc);
> >
> > -struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
> > +int htvec_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_ht_pic *acpi_htvec);
> >  int pch_lpc_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_lpc_pic *acpi_pchlpc);
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 7ef9f5e696d3..17396e6e42fc 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -576,6 +576,7 @@ config IRQ_LOONGARCH_CPU
> >       select GENERIC_IRQ_CHIP
> >       select IRQ_DOMAIN
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > +     select LOONGSON_HTVEC
> >       select LOONGSON_LIOINTC
> >       select LOONGSON_EIOINTC
> >       select LOONGSON_PCH_PIC
> > diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
> > index 60a335d7e64e..1bb414ec6e78 100644
> > --- a/drivers/irqchip/irq-loongson-htvec.c
> > +++ b/drivers/irqchip/irq-loongson-htvec.c
> > @@ -20,7 +20,6 @@
> >  /* Registers */
> >  #define HTVEC_EN_OFF         0x20
> >  #define HTVEC_MAX_PARENT_IRQ 8
> > -
> >  #define VEC_COUNT_PER_REG    32
> >  #define VEC_REG_IDX(irq_id)  ((irq_id) / VEC_COUNT_PER_REG)
> >  #define VEC_REG_BIT(irq_id)  ((irq_id) % VEC_COUNT_PER_REG)
> > @@ -32,6 +31,8 @@ struct htvec {
> >       raw_spinlock_t          htvec_lock;
> >  };
> >
> > +static struct htvec *htvec_priv;
> > +
> >  static void htvec_irq_dispatch(struct irq_desc *desc)
> >  {
> >       int i;
> > @@ -155,64 +156,140 @@ static void htvec_reset(struct htvec *priv)
> >       }
> >  }
> >
> > -static int htvec_of_init(struct device_node *node,
> > -                             struct device_node *parent)
> > +static int htvec_init(phys_addr_t addr, unsigned long size,
> > +             int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
> >  {
> > +     int i;
> >       struct htvec *priv;
> > -     int err, parent_irq[8], i;
> >
> >       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> >               return -ENOMEM;
> >
> > +     priv->num_parents = num_parents;
> > +     priv->base = ioremap(addr, size);
> >       raw_spin_lock_init(&priv->htvec_lock);
> > -     priv->base = of_iomap(node, 0);
> > -     if (!priv->base) {
> > -             err = -ENOMEM;
> > -             goto free_priv;
> > -     }
> > -
> > -     /* Interrupt may come from any of the 8 interrupt lines */
> > -     for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
> > -             parent_irq[i] = irq_of_parse_and_map(node, i);
> > -             if (parent_irq[i] <= 0)
> > -                     break;
> > -
> > -             priv->num_parents++;
> > -     }
> > -
> > -     if (!priv->num_parents) {
> > -             pr_err("Failed to get parent irqs\n");
> > -             err = -ENODEV;
> > -             goto iounmap_base;
> > -     }
> >
> > -     priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> > +     /* Setup IRQ domain */
> > +     priv->htvec_domain = irq_domain_create_linear(domain_handle,
> >                                       (VEC_COUNT_PER_REG * priv->num_parents),
> >                                       &htvec_domain_ops, priv);
> >       if (!priv->htvec_domain) {
> > -             pr_err("Failed to create IRQ domain\n");
> > -             err = -ENOMEM;
> > -             goto irq_dispose;
> > +             pr_err("loongson-htvec: cannot add IRQ domain\n");
> > +             goto iounmap_base;
> >       }
> >
> >       htvec_reset(priv);
> >
> > -     for (i = 0; i < priv->num_parents; i++)
> > +     for (i = 0; i < priv->num_parents; i++) {
> >               irq_set_chained_handler_and_data(parent_irq[i],
> >                                                htvec_irq_dispatch, priv);
> > +     }
> > +
> > +     htvec_priv = priv;
> >
> >       return 0;
> >
> > -irq_dispose:
> > -     for (; i > 0; i--)
> > -             irq_dispose_mapping(parent_irq[i - 1]);
> >  iounmap_base:
> >       iounmap(priv->base);
> > -free_priv:
> >       kfree(priv);
> >
> > -     return err;
> > +     return -EINVAL;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +
> > +static int htvec_of_init(struct device_node *node,
> > +                             struct device_node *parent)
> > +{
> > +     int i, err;
> > +     int parent_irq[8];
> > +     int num_parents = 0;
> > +     struct resource res;
> > +
> > +     if (of_address_to_resource(node, 0, &res))
> > +             return -EINVAL;
> > +
> > +     /* Interrupt may come from any of the 8 interrupt lines */
> > +     for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
> > +             parent_irq[i] = irq_of_parse_and_map(node, i);
> > +             if (parent_irq[i] <= 0)
> > +                     break;
> > +
> > +             num_parents++;
> > +     }
> > +
> > +     err = htvec_init(res.start, resource_size(&res),
> > +                     num_parents, parent_irq, of_node_to_fwnode(node));
> > +     if (err < 0)
> > +             return err;
> > +
> > +     return 0;
> >  }
> >
> >  IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
> > +
> > +#endif
> > +
> > +#ifdef CONFIG_ACPI
> > +static int __init
> > +pch_pic_parse_madt(union acpi_subtable_headers *header,
> > +                    const unsigned long end)
>
> Please write the function name and the return type on the same
> line. Long lines are just fine.
This style keeps the same as other loongson irqchips, if I change it,
then should I send another patch to restyle other drivers?

>
> > +{
> > +     struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
> > +
> > +     return pch_pic_acpi_init(htvec_priv->htvec_domain, pchpic_entry);
> > +}
> > +
> > +static int __init
> > +pch_msi_parse_madt(union acpi_subtable_headers *header,
> > +                    const unsigned long end)
> > +{
> > +     struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
> > +
> > +     return pch_msi_acpi_init(htvec_priv->htvec_domain, pchmsi_entry);
> > +}
> > +
> > +static int __init acpi_cascade_irqdomain_init(void)
> > +{
> > +     acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
> > +                           pch_pic_parse_madt, 0);
> > +     acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
> > +                           pch_msi_parse_madt, 0);
>
> What if any of these fail? They have a return value for a reason.
Similar to above, this keeps the same as other loongson irqchips, if I
change it, then should I send another patch to adjust other drivers?

>
> > +     return 0;
>
> There is only a single possible return value, which is never checked.
>
> > +}
> > +
> > +int __init htvec_acpi_init(struct irq_domain *parent,
> > +                                struct acpi_madt_ht_pic *acpi_htvec)
> > +{
> > +     int i, ret;
> > +     int num_parents, parent_irq[8];
> > +     struct fwnode_handle *domain_handle;
> > +
> > +     if (!acpi_htvec)
> > +             return -EINVAL;
> > +
> > +     num_parents = HTVEC_MAX_PARENT_IRQ;
> > +
> > +     domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_htvec);
>
> NAK. Enough. I already mopped the floor for you during the previous
> cycle, I'm not going to do it again. Please see 7e4fd7a1a6fd.
Sorry, this will be fixed in the next version.

Huacai
>
> > +     if (!domain_handle) {
> > +             pr_err("Unable to allocate domain handle\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Interrupt may come from any of the 8 interrupt lines */
> > +     for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++)
> > +             parent_irq[i] = irq_create_mapping(parent, acpi_htvec->cascade[i]);
> > +
> > +     ret = htvec_init(acpi_htvec->address, acpi_htvec->size,
> > +                     num_parents, parent_irq, domain_handle);
> > +
> > +     if (ret == 0)
> > +             acpi_cascade_irqdomain_init();
> > +     else
> > +             irq_domain_free_fwnode(domain_handle);
> > +
> > +     return ret;
> > +}
> > +
> > +#endif
> > diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> > index 0da8716f8f24..ddf23b1114cb 100644
> > --- a/drivers/irqchip/irq-loongson-liointc.c
> > +++ b/drivers/irqchip/irq-loongson-liointc.c
> > @@ -349,6 +349,22 @@ IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
> >  #endif
> >
> >  #ifdef CONFIG_ACPI
> > +static int __init htintc_parse_madt(union acpi_subtable_headers *header,
> > +                                     const unsigned long end)
> > +{
> > +     struct acpi_madt_ht_pic *htintc_entry = (struct acpi_madt_ht_pic *)header;
> > +     struct irq_domain *parent = irq_find_matching_fwnode(liointc_handle, DOMAIN_BUS_ANY);
> > +
> > +     return htvec_acpi_init(parent, htintc_entry);
> > +}
> > +
> > +static int __init acpi_cascade_irqdomain_init(void)
> > +{
> > +     acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC,
> > +                           htintc_parse_madt, 0);
> > +     return 0;
>
> Same comments as above.
>
> > +}
> > +
> >  int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc)
> >  {
> >       int ret;
> > @@ -365,9 +381,12 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
> >               pr_err("Unable to allocate domain handle\n");
> >               return -ENOMEM;
> >       }
> > +
> >       ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
> >                          1, domain_handle, NULL);
> > -     if (ret)
> > +     if (ret == 0)
> > +             acpi_cascade_irqdomain_init();
> > +     else
> >               irq_domain_free_fwnode(domain_handle);
> >
> >       return ret;
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
