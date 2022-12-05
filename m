Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315636426FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiLEKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:54:43 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF61901F;
        Mon,  5 Dec 2022 02:54:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id e18so7954278qvs.1;
        Mon, 05 Dec 2022 02:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=376Rf5lOnQYpjC3Bdbpg8sAgKZ9HnP55y45osaN1xAw=;
        b=jI05zDjDXz8WOsRO6+EygcraOuxNP/UFpu1yCcb8DaPN4TLISmWw38eb/686phBWJR
         oyhxwEQuPio++YYdi1qe7iGGeuMU6/0HWY3XVmHvPVuC/QFxAE8fpRONQztwP4DqIoxs
         j5/i8mlK6OeNNdNri/MBJN+C5033I0yH8UxDC40SZkXVTr4tlE8q7eOHP4B3W6aV34P4
         Ozqd1RRZG/nJolVgmeO6mBdfA7CuQQa6I0je44z5wf3DfD/03n+6uXpQzn/84yOdMXHx
         /cOjxREPves/Wm93csQAgDRp0R1/YM+VrKycOlu/rnmQd8egCO9pkJxFoHbuE0UZKWuX
         MUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=376Rf5lOnQYpjC3Bdbpg8sAgKZ9HnP55y45osaN1xAw=;
        b=1YdIQYUz4zVF8aiwoxagWER1OvP73QdkKlRRjVScpVd5sDlsxThFamewr4+9ThgDkO
         u3JqfnlDAz3sy2xgygc5gbD/Mm0sQ937E2G1FuFaBLauYleWM8JQZsFyEB55Aijlv9kB
         yy7ZggngK4+Na5DuN8X1fBh3QPTegTzoAJQye4vP4dvLiQ4U/iuJfw8sCN4a/dQrkV1+
         SAhwSw9Vxe9DUOEbAyY+vYvbjvWdBUar2Ls/dqEkMiRN2cwluL9PyayVeeyDLa9rKm9+
         pIwbwyvdUrfuzwQ3HoKl7BEj2mBlYskOkSVk+Efe7vLrChPjwtkvpDONH5eqwhwq6zjy
         Vyhg==
X-Gm-Message-State: ANoB5pmvHy+QwQot/l3ZMOj1XDT8p4exvlXi+yEl7pW0X2Z3J8CWGNLx
        OAPhBO68qXKwcebkvOWmhIKomYqcQYY8XSAOFBI=
X-Google-Smtp-Source: AA0mqf6qZlIlNCoF0kFZl+6/LSGwg+JDHxFcd3brbj4h6Z3NDyzJ2hUYU0ZHCICJrrf1w/EbGCP7H6au6mM/kzQt+Vs=
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id
 g10-20020ad457aa000000b004c6f83c4741mr36107545qvx.11.1670237681973; Mon, 05
 Dec 2022 02:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
In-Reply-To: <20221205085351.27566-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Dec 2022 12:54:05 +0200
Message-ID: <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
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

On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton NPCM BMC sdhci-pltfm controller driver.

Thank you for an update, my comments below.

...

> +config MMC_SDHCI_NPCM

>  config MMC_SDHCI_IPROC

Perhaps after IPROC?

...

> @@ -97,6 +97,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)       += sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)                += sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)           += sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)           += sdhci-sprd.o
> +obj-$(CONFIG_MMC_SDHCI_NPCM)           += sdhci-npcm.o

Perhaps after IPROC? (There is a group of platform drivers slightly
below than here)

>  obj-$(CONFIG_MMC_CQHCI)                        += cqhci.o

...

> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>

I guess platform_device.h is missing here.

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

> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);

You can't mix devm with non-devm in this way.

> +       if (IS_ERR(pltfm_host->clk))
> +               return PTR_ERR(pltfm_host->clk);
> +
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               return ret;
> +
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

Why can't you use sdhci_pltfm_register()?

> +       return 0;
> +
> +err_sdhci_add:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       sdhci_pltfm_free(pdev);
> +       return ret;
> +}

Missing ->remove() due to above.

Have you tried to compile as a module and then remove and insert it
several times?

-- 
With Best Regards,
Andy Shevchenko
