Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7298174B5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGGRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGGRvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:51:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13A10CE;
        Fri,  7 Jul 2023 10:51:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 367HomiK108890;
        Fri, 7 Jul 2023 12:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688752248;
        bh=A579pIuEfLRxSSqRnb3noaAXO5nSKibbRHfnvKiaJJ8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=urp+1ULQsuFdy59aSLz7DbuTvMwzdefU07KHsDwbrFQifwNpN+00so1BtxjEqEZwJ
         HzUIgXt+YpE2MU1SKPQzjmrzcxpwoM750209JBQLoW3LBjriQsItZggI+fPCP02nVs
         saqv+Tx6PvuF2eIdBi6lIYbC9qfhv9mdEistq5NI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 367Hom3s018521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jul 2023 12:50:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jul 2023 12:50:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jul 2023 12:50:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 367HomuQ095914;
        Fri, 7 Jul 2023 12:50:48 -0500
Date:   Fri, 7 Jul 2023 12:50:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 15/18] soc: ti: Mover power-domain drivers to the genpd
 dir
Message-ID: <20230707175048.6yees6d3evcomyux@vacation>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-16-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230707140434.723349-16-ulf.hansson@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:04-20230707, Ulf Hansson wrote:
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS                                   | 3 ++-
>  drivers/genpd/Makefile                        | 1 +
>  drivers/genpd/ti/Makefile                     | 3 +++
>  drivers/{soc => genpd}/ti/omap_prm.c          | 0
>  drivers/{soc => genpd}/ti/ti_sci_pm_domains.c | 0
>  drivers/soc/ti/Makefile                       | 2 --
>  6 files changed, 6 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/genpd/ti/Makefile
>  rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
>  rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e580df3e5db..3cf16ffac892 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21101,7 +21101,7 @@ F:	drivers/irqchip/irq-ti-sci-inta.c
>  F:	drivers/irqchip/irq-ti-sci-intr.c
>  F:	drivers/reset/reset-ti-sci.c
>  F:	drivers/soc/ti/ti_sci_inta_msi.c
> -F:	drivers/soc/ti/ti_sci_pm_domains.c
> +F:	drivers/genpd/ti/ti_sci_pm_domains.c
>  F:	include/dt-bindings/soc/ti,sci_pm_domain.h
>  F:	include/linux/soc/ti/ti_sci_inta_msi.h
>  F:	include/linux/soc/ti/ti_sci_protocol.h
> @@ -21335,6 +21335,7 @@ L:	linux-kernel@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> +F:	drivers/genpd/ti/omap_prm.c

Probably the wrong place for this as omap_prm is'nt a keystone navigator
driver set. Maybe Tony has a suggestion?

>  F:	drivers/soc/ti/*
>  
>  TI LM49xxx FAMILY ASoC CODEC DRIVERS
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index e6f34d82e6a8..193892189f0d 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -11,3 +11,4 @@ obj-y					+= samsung/
>  obj-y					+= starfive/
>  obj-y					+= sunxi/
>  obj-y					+= tegra/
> +obj-y					+= ti/
> diff --git a/drivers/genpd/ti/Makefile b/drivers/genpd/ti/Makefile
> new file mode 100644
> index 000000000000..69580afbb436
> --- /dev/null
> +++ b/drivers/genpd/ti/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
> +obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/genpd/ti/omap_prm.c
> similarity index 100%
> rename from drivers/soc/ti/omap_prm.c
> rename to drivers/genpd/ti/omap_prm.c
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
> similarity index 100%
> rename from drivers/soc/ti/ti_sci_pm_domains.c
> rename to drivers/genpd/ti/ti_sci_pm_domains.c
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index cc3c972fad2e..cb800a745e66 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -6,9 +6,7 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss.o
>  knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
>  obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
>  obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
> -obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
> -obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>  obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
>  obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
>  obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
