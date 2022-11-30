Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27963DC35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiK3Rix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK3Rip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:38:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C137207;
        Wed, 30 Nov 2022 09:38:44 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id be13so28093833lfb.4;
        Wed, 30 Nov 2022 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0gEAiCJn5AZTB/dbyoiOBb5ffbCZ/uTpNxONaIFz18=;
        b=J6lajX9tsiXHJgLqUZmFEdmfv8FS7/kTgRDuyv3WpZ9m356pQUikwQFj6dyzjaXg+3
         eRzomTMaXqyduXqVuOsfGcCXNdASB+ZwCvQ0C8EyVAFfJJ/x4mECaX3/aFdrNdAgp/pP
         qHbqevifRuwME/A120twFedHKLujnU2x8vS1Y1ppNxC7DWageO+sABHjFPEhpAmx66s1
         QirPTa7MI/ThrAvOsLhVB077uchnByY/i+E4H9k06NwgIA99Txn43y34NzN+ArqPNyoW
         C+pCnNbUMioQixEdIYqehipknwx4KKQBdU4jr8ciHeTKy/VIPJbPqQ25ZA1Z2pskbgol
         +aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0gEAiCJn5AZTB/dbyoiOBb5ffbCZ/uTpNxONaIFz18=;
        b=5aVgL3m4zhrsjdlqn0kxP05MNp0vCLV0OQ5SvecVi++G0HBCOk1T77QM1G8clFFh1j
         3wh0Yr8kMXxWJcz3VUuLRQw9fdx3gc+Fco2mP7BaXZcx9Z3BjzRfQITHukHc47DJ0FJG
         3fKc1qvYRU5lLI/lcMcb05+c6M6jaXDML0HKAd8KZiqzFpA5fLHXWs3rFV3S7cPpfNzr
         zRzuHkrxw1nR4AqmhgqCdkfagtraqCB31BDxgoXDaRJkCeDDMS4bBWbZC0zvRci6yrpU
         Tl6CDzIGFCjNKvj+mCsUtpjfq4mXZ2NVZ5qk1CATz6w5xaP1Sz7v0AEHjJPC747747Vf
         thjQ==
X-Gm-Message-State: ANoB5pk2/PbRuvLassrGkAiy2GWebehLZY9u/teL5IoGoh3zsMgo/nmu
        kjkbtHiQh8CCWPU3sO2rGAkU2CXImTajbigsBLA=
X-Google-Smtp-Source: AA0mqf5XNPSQLLaBiO+sG8KHhpSX8MC9f7lmnJ8wppxw1A/GfGBYg6y6BYtlmpiC5sF7yKk+w1aUe71oRPcq0S/Ubtw=
X-Received: by 2002:a05:6512:2116:b0:4b4:b904:a310 with SMTP id
 q22-20020a056512211600b004b4b904a310mr20296491lfr.576.1669829922436; Wed, 30
 Nov 2022 09:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20221130150857.67113-1-tmaimon77@gmail.com> <20221130150857.67113-3-tmaimon77@gmail.com>
 <CAHp75Vf-EKa9rdpmO54h0rgMcN4TLk8GcYfrjb-2Cy-GRVgEKA@mail.gmail.com>
In-Reply-To: <CAHp75Vf-EKa9rdpmO54h0rgMcN4TLk8GcYfrjb-2Cy-GRVgEKA@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 30 Nov 2022 19:38:30 +0200
Message-ID: <CAP6Zq1iqFmOWCZJa+qg=trw0M3jgJRoqX9CJDHqJovoFt9=24Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
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

On Wed, 30 Nov 2022 at 17:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 30, 2022 at 5:09 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
>
> ...
>
> >  obj-$(CONFIG_MMC_S3C)          += s3cmci.o
> >  obj-$(CONFIG_MMC_SDRICOH_CS)   += sdricoh_cs.o
> >  obj-$(CONFIG_MMC_TMIO)         += tmio_mmc.o
>
> > +obj-$(CONFIG_MMC_SDHCI_NPCM)   += sdhci-npcm.o
>
> Keep it ordered by module name.
>
> >  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
> >  obj-$(CONFIG_MMC_SDHI)         += renesas_sdhi_core.o
> >  obj-$(CONFIG_MMC_SDHI_SYS_DMAC)                += renesas_sdhi_sys_dmac.o
>
> ...
>
> > +/*
> > + * NPCM SDHC MMC host controller driver.
> > + *
> > + */
>
> Too many lines for seems to be oneliner comment.
>
> ...
>
> > +#include <linux/of.h>
>
> I don't see how it's being used.
> But it seems the mod_devicetable.h is missing.
>
> ...
>
> > +static const struct sdhci_pltfm_data npcm_sdhci_pdata = {
> > +       .quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
> > +       .quirks2 = SDHCI_QUIRK2_STOP_WITH_TC |
> > +                  SDHCI_QUIRK2_NO_1_8_V,
> > +};
>
> Why? Can't you use the sdhci as a library?
Can you explain what you mean by using sdhci as a library?
is it not to use the pltfm_data structure and only to set the quirks
directly through the host?
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
> > +       pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> > +
>
> Blank line in a wrong position, should be before devm_clk_get().
>
> > +       if (!IS_ERR(pltfm_host->clk))
> > +               clk_prepare_enable(pltfm_host->clk);
>
> Why not use a specific helper that gets the clock enabled?
which specific helper? can you give me more specific details?
>
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
> > +
> > +       return 0;
> > +
> > +err_sdhci_add:
> > +       clk_disable_unprepare(pltfm_host->clk);
> > +       sdhci_pltfm_free(pdev);
> > +       return ret;
> > +}
>
> ...
>
> > +
>
> Redundant blank line.
>
> > +module_platform_driver(npcm_sdhci_driver);
>
> --
> With Best Regards,
> Andy Shevchenko

Best regards,

Tomer
