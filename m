Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC986C6818
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCWMVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCWMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:21:38 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0026C3B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:20:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-544f7c176easo247141987b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679574033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dsiewv1O2k8V1HgYXshp7MCoXkAGG/2ljcLy5V0fCAY=;
        b=mD4LZLSVxLGUwCVQRPyUG/E+HpMJnL0y2QOvXPP7296TXuYBgqjoZFwnQxvfwLeBCt
         nipNWIH5s9pTqZSUc2HrXRr+5vgSriF5mP8Pgjyz7Z9AnPsTQx0t5HrW5GcmlVUk0nxu
         UPsLyOw5yk2zI1vJKb7KZ27uR7303Zd2XCF31W5zt7XpQE0R4vcMCVf6dGgSsplSOyxO
         uzPO0CWwqZ+2+o89pRajm3cJ+i348IPgSezo9uHcJaPw4o8n22tcqOk7g+pbWPIxqPOn
         WSgL7zwTIh8MS77uAU2BSh6YAH80f4aFhD6shByuuW0AVqE++cGc6qvwxhDl/OO/Ixoy
         v6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsiewv1O2k8V1HgYXshp7MCoXkAGG/2ljcLy5V0fCAY=;
        b=iyTHvdDLr/hlZ7shyFZyX/kyvNG34HJpdu2rCyXZclJKMiQzM3Aezrhi02lArILq89
         m1YIj8wRhbE9iHl9dkJDRHaOpbgInOqX24OZ9fFH8/DPBziSRI5U6DCjlAQMSXS2hOsr
         oI8vj77dksMjKy7UOR/NigkHKIijt0HOE1731JCTNteHyyk+3d8+IDjI3gEd7uSG5uy2
         UKwJgZ7uq+jBUNMGC2vMC1zhoNVRdIZfV2zghpeL9sGXtpMUsK+vVBTKmO60Q6DKTDVX
         D3N7agQlVz5LnfU2bB28hh9JDDFRy+8r8dxABokodEEm1lIkHYpAmJ8dzl6RwltvlGjv
         ce8g==
X-Gm-Message-State: AAQBX9cveXHIwhdxpqLUW4ya+sN7QK9/qxBHsh34wZ8hFFjLx+sHNCrs
        m+6hxqOjXMKafdVlKj35+gmNXQSw3RPGHStKr6wo2A==
X-Google-Smtp-Source: AKy350a9PgdqZyyRieSlRzFLQRJHBuDE7c080j8qkbym2YY5zeGq+1tmxcWFgg7px0mx8p5mR45XOCSaDat0z6T/8Ms=
X-Received: by 2002:a81:b345:0:b0:53c:6fda:835f with SMTP id
 r66-20020a81b345000000b0053c6fda835fmr1699102ywh.0.1679574033577; Thu, 23 Mar
 2023 05:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
In-Reply-To: <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:19:57 +0100
Message-ID: <CAPDyKFo0d9Vz_8p_SEVznT2hzBZqnZsUnrp4T3mtRSnZZBEfFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        adrian.hunter@intel.com, skhan@linuxfoundation.org,
        davidgow@google.com, pbrobinson@gmail.com, gsomlo@gmail.com,
        briannorris@chromium.org, arnd@arndb.de, krakoczy@antmicro.com,
        andy.shevchenko@gmail.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 15:16, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Dec 05, 2022 at 10:53:51AM +0200, Tomer Maimon wrote:
> > Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> I still don't see this driver in the upstream kernel, or in linux-next.

Tomer, Guenter,

Looks like I may have missed picking it up, probably because I thought
the review was still ongoing.

Please re-submit and include the reviewed-by tags, etc.

Kind regards
Uffe

>
> Couple of comments:
>
> - devm ordering does not really matter here. The devm resource
>   is the clock, it does not depend on local data, and it will be
>   released last, so that is ok.
> - sdhci_pltfm_unregister() calls clk_disable_unprepare(),
>   so there is no enabled clock floating around on driver removal.
>   Unfortunately, that also means that the more convenient
>   devm_clk_get_optional_enabled() can not be used.
>
> Real problem inline below.
>
> Guenter
>
> > ---
> >  drivers/mmc/host/Kconfig      |  8 ++++
> >  drivers/mmc/host/Makefile     |  1 +
> >  drivers/mmc/host/sdhci-npcm.c | 84 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-npcm.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index fb1062a6394c..82ab6fc25dca 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -415,6 +415,14 @@ config MMC_SDHCI_MILBEAUT
> >
> >         If unsure, say N.
> >
> > +config MMC_SDHCI_NPCM
> > +     tristate "Secure Digital Host Controller Interface support for NPCM"
> > +     depends on ARCH_NPCM || COMPILE_TEST
> > +     depends on MMC_SDHCI_PLTFM
> > +     help
> > +       This provides support for the SD/eMMC controller found in
> > +       NPCM BMC family SoCs.
> > +
> >  config MMC_SDHCI_IPROC
> >       tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
> >       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || ARCH_BRCMSTB || COMPILE_TEST
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 4e4ceb32c4b4..a101f87a5f19 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)     += sdhci-pic32.o
> >  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)              += sdhci-brcmstb.o
> >  obj-$(CONFIG_MMC_SDHCI_OMAP)         += sdhci-omap.o
> >  obj-$(CONFIG_MMC_SDHCI_SPRD)         += sdhci-sprd.o
> > +obj-$(CONFIG_MMC_SDHCI_NPCM)         += sdhci-npcm.o
> >  obj-$(CONFIG_MMC_CQHCI)                      += cqhci.o
> >  cqhci-y                                      += cqhci-core.o
> >  cqhci-$(CONFIG_MMC_CRYPTO)           += cqhci-crypto.o
> > diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.c
> > new file mode 100644
> > index 000000000000..beace15b6c00
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-npcm.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * NPCM SDHC MMC host controller driver.
> > + *
> > + * Copyright (c) 2020 Nuvoton Technology corporation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/module.h>
> > +
> > +#include "sdhci-pltfm.h"
> > +
> > +static const struct sdhci_pltfm_data npcm_sdhci_pdata = {
> > +     .quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
> > +     .quirks2 = SDHCI_QUIRK2_STOP_WITH_TC |
> > +                SDHCI_QUIRK2_NO_1_8_V,
> > +};
> > +
> > +static int npcm_sdhci_probe(struct platform_device *pdev)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host;
> > +     struct sdhci_host *host;
> > +     u32 caps;
> > +     int ret;
> > +
> > +     host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
> > +     if (IS_ERR(host))
> > +             return PTR_ERR(host);
> > +
> > +     pltfm_host = sdhci_priv(host);
> > +
> > +     pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> > +     if (IS_ERR(pltfm_host->clk))
> > +             return PTR_ERR(pltfm_host->clk);
> > +
> > +     ret = clk_prepare_enable(pltfm_host->clk);
> > +     if (ret)
> > +             return ret;
> > +
>
> The two functions above should not return but goto the call
> to sdhci_pltfm_free() to avoid a memory leak on error.
>
> > +     caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> > +     if (caps & SDHCI_CAN_DO_8BIT)
> > +             host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> > +
> > +     ret = mmc_of_parse(host->mmc);
> > +     if (ret)
> > +             goto err_sdhci_add;
> > +
> > +     ret = sdhci_add_host(host);
> > +     if (ret)
> > +             goto err_sdhci_add;
> > +
> > +     return 0;
> > +
> > +err_sdhci_add:
> > +     clk_disable_unprepare(pltfm_host->clk);
> > +     sdhci_pltfm_free(pdev);
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id npcm_sdhci_of_match[] = {
> > +     { .compatible = "nuvoton,npcm750-sdhci" },
> > +     { .compatible = "nuvoton,npcm845-sdhci" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, npcm_sdhci_of_match);
> > +
> > +static struct platform_driver npcm_sdhci_driver = {
> > +     .driver = {
> > +             .name   = "npcm-sdhci",
> > +             .of_match_table = npcm_sdhci_of_match,
> > +             .pm     = &sdhci_pltfm_pmops,
> > +     },
> > +     .probe          = npcm_sdhci_probe,
> > +     .remove         = sdhci_pltfm_unregister,
> > +};
> > +module_platform_driver(npcm_sdhci_driver);
> > +
> > +MODULE_DESCRIPTION("NPCM Secure Digital Host Controller Interface driver");
> > +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.33.0
> >
