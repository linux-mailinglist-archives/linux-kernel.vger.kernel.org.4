Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B0693588
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBLBxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 20:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 20:53:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EBA14484;
        Sat, 11 Feb 2023 17:53:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C6A60C39;
        Sun, 12 Feb 2023 01:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F32C4339C;
        Sun, 12 Feb 2023 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676166819;
        bh=iWYmgs0WbDiXdtQItHUIENcHjm0UVFT22zKPAOTteq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T7tItgzu8I0N17lwsshpnEk/8ISITPNPvXKc8rycUH2TmRXflT+9W6mNJsewP8XUx
         ne+nWOv75VrzyShMZ9E+yqET+zt1K+YKqmjRn7tJHVaFbJhdQxCCcMmbLcWlOfFTw1
         MOdfrMcnicFTAQhR4hXkTtyGhKEj19SpwJFw/lMTP2xBfDvUVMqVhd30/FkzBA5lUE
         rFQTsUYPbbfIzJ+pp8k7CzK0kZQVKlG9ynTUNnBZKljqWGLAwtk6sIXsRqhl2cfauv
         xsKr/BB3azbMy6H3JRB2qjigRLLOCQS2bQPMn1HozcQQjwlbhKfbV7A5XVT8tbEAtJ
         +JBh1y/wqJVTQ==
Received: by mail-ej1-f51.google.com with SMTP id sb24so385585ejb.8;
        Sat, 11 Feb 2023 17:53:39 -0800 (PST)
X-Gm-Message-State: AO0yUKXf/oC/zjkizFWl7c6ONarLM2/mLG1DYLu63miNNxF3if4uJMo7
        xCOrLIX73H1Y4zr/LKwizRlsDSNHr2uNXVpofH0=
X-Google-Smtp-Source: AK7set8g7S95wGsc/KNVqcFlY61cC8dFkQeu2HRBjwlnqhmUzIGORAMJ4QQTL2HSO8IW7meNVgEbWtiNtLfwd40IoZM=
X-Received: by 2002:a17:906:8557:b0:87b:da7a:f202 with SMTP id
 h23-20020a170906855700b0087bda7af202mr2853743ejy.1.1676166817356; Sat, 11 Feb
 2023 17:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230211024156.3530526-1-zhoubinbin@loongson.cn>
In-Reply-To: <20230211024156.3530526-1-zhoubinbin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 12 Feb 2023 09:53:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5JOD4WRyN2rZq9qZAja2--Vg5gdVWYU9Ue0OfioRLJPQ@mail.gmail.com>
Message-ID: <CAAhV-H5JOD4WRyN2rZq9qZAja2--Vg5gdVWYU9Ue0OfioRLJPQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-eiointc: Add DT init support
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Binbin,

On Sat, Feb 11, 2023 at 10:41 AM Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Add DT support for EIOINTC irqchip, which is needed for the Loongson-2K
> series, e.g. Loongson-2K500 soc.
Use SOC instead of soc.

>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 119 ++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index d15fd38c1756..d5e1ee6aada6 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -39,6 +39,7 @@ static int nr_pics;
>
>  struct eiointc_priv {
>         u32                     node;
> +       u32                     vec_count;
>         nodemask_t              node_map;
>         cpumask_t               cpuspan_map;
>         struct fwnode_handle    *domain_handle;
> @@ -156,18 +157,19 @@ static int eiointc_router_init(unsigned int cpu)
>         if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
>                 eiointc_enable();
>
> -               for (i = 0; i < VEC_COUNT / 32; i++) {
> +               for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
> +                       pr_info("");
Why print an empty string?

Others look good to me.

Huacai
>                         data = (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
>                         iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
>                 }
>
> -               for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
> +               for (i = 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
>                         bit = BIT(1 + index); /* Route to IP[1 + index] */
>                         data = bit | (bit << 8) | (bit << 16) | (bit << 24);
>                         iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
>                 }
>
> -               for (i = 0; i < VEC_COUNT / 4; i++) {
> +               for (i = 0; i < eiointc_priv[0]->vec_count / 4; i++) {
>                         /* Route to Node-0 Core-0 */
>                         if (index == 0)
>                                 bit = BIT(cpu_logical_map(0));
> @@ -178,7 +180,7 @@ static int eiointc_router_init(unsigned int cpu)
>                         iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
>                 }
>
> -               for (i = 0; i < VEC_COUNT / 32; i++) {
> +               for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
>                         data = 0xffffffff;
>                         iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
>                         iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
> @@ -198,7 +200,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
>
>         chained_irq_enter(chip, desc);
>
> -       for (i = 0; i < VEC_REG_COUNT; i++) {
> +       for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
>                 pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
>                 iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
>                 while (pending) {
> @@ -316,7 +318,7 @@ static void eiointc_resume(void)
>         eiointc_router_init(0);
>
>         for (i = 0; i < nr_pics; i++) {
> -               for (j = 0; j < VEC_COUNT; j++) {
> +               for (j = 0; j < eiointc_priv[i]->vec_count; j++) {
>                         desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
>                         if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
>                                 raw_spin_lock(&desc->lock);
> @@ -373,11 +375,44 @@ static int __init acpi_cascade_irqdomain_init(void)
>         return 0;
>  }
>
> +static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
> +                              u64 node_map)
> +{
> +       int i;
> +
> +       node_map = node_map ? node_map : -1ULL;
> +       for_each_possible_cpu(i) {
> +               if (node_map & (1ULL << (cpu_to_eio_node(i)))) {
> +                       node_set(cpu_to_eio_node(i), priv->node_map);
> +                       cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map,
> +                                  cpumask_of(i));
> +               }
> +       }
> +
> +       priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle,
> +                                                       priv->vec_count,
> +                                                       &eiointc_domain_ops,
> +                                                       priv);
> +       if (!priv->eiointc_domain) {
> +               pr_err("loongson-extioi: cannot add IRQ domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       eiointc_priv[nr_pics++] = priv;
> +       eiointc_router_init(0);
> +       irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
> +       register_syscore_ops(&eiointc_syscore_ops);
> +       cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
> +                                 "irqchip/loongarch/intc:starting",
> +                                 eiointc_router_init, NULL);
> +
> +       return 0;
> +}
> +
>  int __init eiointc_acpi_init(struct irq_domain *parent,
>                                      struct acpi_madt_eio_pic *acpi_eiointc)
>  {
> -       int i, ret, parent_irq;
> -       unsigned long node_map;
> +       int parent_irq, ret;
>         struct eiointc_priv *priv;
>
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> @@ -391,39 +426,20 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
>                 goto out_free_priv;
>         }
>
> +       priv->vec_count = VEC_COUNT;
>         priv->node = acpi_eiointc->node;
> -       node_map = acpi_eiointc->node_map ? : -1ULL;
> -
> -       for_each_possible_cpu(i) {
> -               if (node_map & (1ULL << cpu_to_eio_node(i))) {
> -                       node_set(cpu_to_eio_node(i), priv->node_map);
> -                       cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
> -               }
> -       }
> -
> -       /* Setup IRQ domain */
> -       priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle, VEC_COUNT,
> -                                       &eiointc_domain_ops, priv);
> -       if (!priv->eiointc_domain) {
> -               pr_err("loongson-eiointc: cannot add IRQ domain\n");
> -               goto out_free_handle;
> -       }
> -
> -       eiointc_priv[nr_pics++] = priv;
> -
> -       eiointc_router_init(0);
> -
>         parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
> -       irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
>
> -       register_syscore_ops(&eiointc_syscore_ops);
> -       cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
> -                                 "irqchip/loongarch/intc:starting",
> -                                 eiointc_router_init, NULL);
> +       ret = eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
> +       if (ret < 0)
> +               goto out_free_handle;
>
>         acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
>         acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
> +
>         ret = acpi_cascade_irqdomain_init();
> +       if (ret < 0)
> +               goto out_free_handle;
>
>         return ret;
>
> @@ -435,3 +451,39 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
>
>         return -ENOMEM;
>  }
> +
> +static int __init eiointc_of_init(struct device_node *of_node,
> +                                 struct device_node *parent)
> +{
> +       int parent_irq, ret;
> +       struct eiointc_priv *priv;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       parent_irq = of_irq_get_byname(of_node, "cascade");
> +       if (parent_irq <= 0) {
> +               ret = -ENODEV;
> +               goto out_free_priv;
> +       }
> +
> +       ret = of_property_read_u32(of_node, "vec_count", &priv->vec_count);
> +       if (ret < 0)
> +               goto out_free_priv;
> +
> +       priv->node = 0;
> +       priv->domain_handle = of_node_to_fwnode(of_node);
> +
> +       ret = eiointc_init(priv, parent_irq, 0);
> +       if (ret < 0)
> +               goto out_free_priv;
> +
> +       return 0;
> +
> +out_free_priv:
> +       kfree(priv);
> +       return ret;
> +}
> +
> +IRQCHIP_DECLARE(loongson_eiointc, "loongson,eiointc", eiointc_of_init);
> --
> 2.39.0
>
>
