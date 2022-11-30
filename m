Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4763D9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiK3Pus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiK3Puo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:50:44 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342A02791A;
        Wed, 30 Nov 2022 07:50:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id i9so12552645qkl.5;
        Wed, 30 Nov 2022 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=82QCZk50OHhyMDgvhzbOVvcIx76jYb6gR6aOF5F4KSk=;
        b=BWHb9s24KDdkAgujqN5R+CKe7Ztu9OKpL44TDgCg9B6FzSwsAFxaEJjPaoVuGJoqgP
         4FAXXx0/etvMoP3Di1D9Nl1ZExrLiZIWpCmcclJ1ZLk2YU+Gd9XlqEHZ+/5h2967AkGc
         H7h97MA3NEoxuvbb7RlNC9Tgu009b78+RNX6NxOwzQKFSTLJ5JHQnMRtTxkewTgoBss6
         +bB2RyZK4dUUPefJlDy3SHxfXZZHEUNPxNyc66dvpA3Jr79VpMjJVcU8TJ7Z5sCMHrpG
         2t1Yis/Cr+p+9nX+VMAft8PYJ0vYgGPkj1eDg1EuEnks53EoJ2QUSy+Z/TlqV2qZ6gfK
         owdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82QCZk50OHhyMDgvhzbOVvcIx76jYb6gR6aOF5F4KSk=;
        b=b/tkeqSgLqPc55nM87mTn2vidgr1BRlHcJkxTJDxoHsDCCOZN/Kuxxf5qtQQAr34kx
         XAaI8uw6EwCqkRkE8fdPJWucGoDs3xJ+ohWZUA0jii4icduYMzqZ1xrgDol80NXB0+/M
         iG8Ke8VhWCFucBHOAMgcpoabCV4llsvrxUUx//q6g3bRDHNs4fvD7MQh6Hm2jC1+qqpw
         HbZrGOP/g+qJzcXNJDau0fp50dvMMDnmaG5r1N4tiK1HJkE0ZVXoAzWgrG7ZiQTjaK4H
         gPBYnY0tyxZzwhNucJslK2biEv+N5u+tkxvk+buRd5v7T+to+Y+uf2WjntH34+VodF43
         AZMQ==
X-Gm-Message-State: ANoB5plvprmvKtGK+chzgSMjV8q6U+0LQMnj7qS30tASlzcrKqDfAaEt
        j/25MjV7ytgaLxWvy9Ry2IIWpkxap10KKEnq0/E=
X-Google-Smtp-Source: AA0mqf5kOZsnOEHPtDJ2/5QHse4qLyrS2H4vMNPxNFPJWJ4R6NiKajd7ShO0X6Lx+IavRjuWzZt1apcO/9r9gd7j/Wg=
X-Received: by 2002:a37:b404:0:b0:6fa:4a82:1152 with SMTP id
 d4-20020a37b404000000b006fa4a821152mr56822990qkf.504.1669823440294; Wed, 30
 Nov 2022 07:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20221130150857.67113-1-tmaimon77@gmail.com> <20221130150857.67113-3-tmaimon77@gmail.com>
In-Reply-To: <20221130150857.67113-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Nov 2022 17:50:04 +0200
Message-ID: <CAHp75Vf-EKa9rdpmO54h0rgMcN4TLk8GcYfrjb-2Cy-GRVgEKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 30, 2022 at 5:09 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.

...

>  obj-$(CONFIG_MMC_S3C)          += s3cmci.o
>  obj-$(CONFIG_MMC_SDRICOH_CS)   += sdricoh_cs.o
>  obj-$(CONFIG_MMC_TMIO)         += tmio_mmc.o

> +obj-$(CONFIG_MMC_SDHCI_NPCM)   += sdhci-npcm.o

Keep it ordered by module name.

>  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
>  obj-$(CONFIG_MMC_SDHI)         += renesas_sdhi_core.o
>  obj-$(CONFIG_MMC_SDHI_SYS_DMAC)                += renesas_sdhi_sys_dmac.o

...

> +/*
> + * NPCM SDHC MMC host controller driver.
> + *
> + */

Too many lines for seems to be oneliner comment.

...

> +#include <linux/of.h>

I don't see how it's being used.
But it seems the mod_devicetable.h is missing.

...

> +static const struct sdhci_pltfm_data npcm_sdhci_pdata = {
> +       .quirks  = SDHCI_QUIRK_DELAY_AFTER_POWER,
> +       .quirks2 = SDHCI_QUIRK2_STOP_WITH_TC |
> +                  SDHCI_QUIRK2_NO_1_8_V,
> +};

Why? Can't you use the sdhci as a library?

...

> +static int npcm_sdhci_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_host *host;
> +       u32 caps;
> +       int ret;
> +
> +       host = sdhci_pltfm_init(pdev, &npcm_sdhci_pdata, 0);
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       pltfm_host = sdhci_priv(host);

> +       pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> +

Blank line in a wrong position, should be before devm_clk_get().

> +       if (!IS_ERR(pltfm_host->clk))
> +               clk_prepare_enable(pltfm_host->clk);

Why not use a specific helper that gets the clock enabled?

> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +       if (caps & SDHCI_CAN_DO_8BIT)
> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err_sdhci_add;
> +
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto err_sdhci_add;
> +
> +       return 0;
> +
> +err_sdhci_add:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       sdhci_pltfm_free(pdev);
> +       return ret;
> +}

...

> +

Redundant blank line.

> +module_platform_driver(npcm_sdhci_driver);

-- 
With Best Regards,
Andy Shevchenko
