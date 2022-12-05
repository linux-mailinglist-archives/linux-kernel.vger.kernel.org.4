Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB36642761
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiLELU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLELUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:20:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45917599;
        Mon,  5 Dec 2022 03:20:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so18013100lfv.2;
        Mon, 05 Dec 2022 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQZdWCk9TZHtIPbVJXmvMK2JUQWMNX+6lfb/3HP5Mec=;
        b=NIuTszuQPXA0nhI61iLhILZmwzinSYocmIz2ZTkRZvS7NNBpFdB6UHkI70CT+WLHqR
         V2ZgB7frGE9kT/UisM5KAQheA0htbZo4sRf8j8QymOHNBU8qE2qYqyVgR/fuUgoMUHNn
         qcv5JXz4WtgVQc8+5Ew27rx0SG1sceX14AxTk9rppkomD78CI+wAsE80YD/DmOsT3+Ar
         zGNF142b+8Nb/xZvolCO6kWuScBmLwmtcVXcF33+prvtXOUlX1m0u9RFJIkdT4BXx0iB
         c96PgwgR8aEH5v4pXZDjduHt9nFg8Nve4+pjxA8Vp1EwnbQj5CWyaSzJGjdHGb27v/K1
         MHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQZdWCk9TZHtIPbVJXmvMK2JUQWMNX+6lfb/3HP5Mec=;
        b=Z4SDhf2GtO0hfd2yBWytBgEiZThuSgTqudgmRCCBlYNPT6hlxZGF8CYSMtJ/5D8BJI
         zvUvKuGlrnHuvkry7GbfYn85/jTm8vs+U6wNl0Kl9DBhU5zj40ysy/AfBZ1FA59RFzeC
         6ndOpVOxTqRqW1u1K0aJeykADueCLVcbA0b3zkVI0RkKUF389wCoba9QriGaP9t+bn9L
         5ePviNLRnkhoftxDDIEGIGsZw54Dnp1gr00Uqcnm9RYMLy+MTGCfEatECk8UiVBiKje4
         MRPVsrsu5bZKeGO3HIre+EOu+XXoC/OV2Sq8gRSWSKaFnZbJRaktrlYfd6zbQWqC8y61
         D+cQ==
X-Gm-Message-State: ANoB5plhnBvyXiA8WNbDTKBL6FNyuZw6JAaSNM0Noa145TSu/Ro+Bvbi
        YMmcUC08AToRqlZSxEYCuWG8J2RGXDeXx9gM6xY=
X-Google-Smtp-Source: AA0mqf4xO4hYS4MNgipiw6LS5E03S+Whk3RNQT/CgUeZISIUHhNzH16pu5m2zRyEXR44992o+bBRV6L2seZoQ/fHU7U=
X-Received: by 2002:ac2:4e14:0:b0:4af:f5a0:8786 with SMTP id
 e20-20020ac24e14000000b004aff5a08786mr25478865lfr.265.1670239221420; Mon, 05
 Dec 2022 03:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
In-Reply-To: <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 5 Dec 2022 13:20:10 +0200
Message-ID: <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your comments.

On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
>
> Thank you for an update, my comments below.
>
> ...
>
> > +config MMC_SDHCI_NPCM
>
> >  config MMC_SDHCI_IPROC
>
> Perhaps after IPROC?
Will be done in the next version.
>
> ...
>
> > @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)       += sdhci-pic32.o
> >  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)                += sdhci-brcmstb.o
> >  obj-$(CONFIG_MMC_SDHCI_OMAP)           += sdhci-omap.o
> >  obj-$(CONFIG_MMC_SDHCI_SPRD)           += sdhci-sprd.o
> > +obj-$(CONFIG_MMC_SDHCI_NPCM)           += sdhci-npcm.o
>
> Perhaps after IPROC? (There is a group of platform drivers slightly
> below than here)
Will be done in the next version.
>
> >  obj-$(CONFIG_MMC_CQHCI)                        += cqhci.o
>
> ...
>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/module.h>
>
> I guess platform_device.h is missing here.
Build and work without platform_device.h, do I need it for module use?
>
> ...
>
> > +static int npcm_sdhci_probe(struct platform_device *pdev)
> > +{
> > +       struct sdhci_pltfm_host *pltfm_host;
> > +       struct sdhci_host *host;
> > +       u32 caps;
> > +       int ret;
> > +
> > +       host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
> > +       if (IS_ERR(host))
> > +               return PTR_ERR(host);
> > +
> > +       pltfm_host = sdhci_priv(host);
>
> > +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
>
> You can't mix devm with non-devm in this way.
Can you explain what you mean You can't mix devm with non-devm in this
way, where is the mix?
In version 1 used devm_clk_get, is it problematic?
>
> > +       if (IS_ERR(pltfm_host->clk))
> > +               return PTR_ERR(pltfm_host->clk);
> > +
> > +       ret = clk_prepare_enable(pltfm_host->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> > +       if (caps & SDHCI_CAN_DO_8BIT)
> > +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> > +
> > +       ret = mmc_of_parse(host->mmc);
> > +       if (ret)
> > +               goto err_sdhci_add;
> > +
> > +       ret = sdhci_add_host(host);
> > +       if (ret)
> > +               goto err_sdhci_add;
>
> Why can't you use sdhci_pltfm_register()?
two things are missing in sdhci_pltfm_register
1. clock.
2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
>
> > +       return 0;
> > +
> > +err_sdhci_add:
> > +       clk_disable_unprepare(pltfm_host->clk);
> > +       sdhci_pltfm_free(pdev);
> > +       return ret;
> > +}
>
> Missing ->remove() due to above.
Will check
>
> Have you tried to compile as a module and then remove and insert it
> several times?
will try
>
> --
> With Best Regards,
> Andy Shevchenko

Best regards,

Tomer
