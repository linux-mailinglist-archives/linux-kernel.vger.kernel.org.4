Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCBD6477BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLHVJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLHVJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:09:56 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F2934D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:09:54 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3f15a6f72d0so28935057b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ6E6svhr3Q9wlTRWWrDf/qx2NsbOqycebzI7mskdFw=;
        b=Z8pJ9F1fNoTt6wr2R3agJ1j8IoMsavCjIm8FuFUB9qW8/TbA8qwb10IAhyIJrjlP87
         85og4tS9dZHzpaS7/bmhX2G67S6Y9biDCYSIjosf43ZlJzGlsdJNJNR5X4PKP+Plxpw9
         vqlPpZ9zxFMdnLI6IRCGTkWrtKhKneRxpBDOiZhNpPG9EOt4O+YSPdRVZegE2alo6ykJ
         G9Y7SoKFg+3g7XZalmm/EPxfqpzvtTvwuV+lNn10PgDfVFCzEf3n7cxG9jNyu8Bg2WDb
         t6Hsc7ZgG4M75xvfNns0tBi/PeN93xKZ+lCw+UUl6NcoJMDRztdwQQrr6vlyRIqZjDgc
         Tojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ6E6svhr3Q9wlTRWWrDf/qx2NsbOqycebzI7mskdFw=;
        b=cU7mgSYbcxTSpyTqQWHeolsm+790ysSLDTBz4rL5u8ttvI2mt4dvXN+nn+z6CI3Np7
         fzSrugichBneJnC3fgfmk8PYws4toOEIqNRU9fP73CbdQTXZg3JUS9ji1exsCJYmpCV5
         WHaEV17lWPcrOtFMBAFXwfQynCHpIUyGGdrDUt44lFE2omDoYWh+rtxsmVFy2HCVI4pk
         nsbcpa1JT3SVCKazqsZSmLgnGkcvy2iFmEYnSFPsNFAw0lfpEyUBAqiDWz/k4f3WB4c9
         QlXtJGKvV5TK1iMbg8FfTG1Cu0YMDaNX27rHUj4qu+N69FrfSgKy+L8DGU+mnWOY0uUP
         QrHQ==
X-Gm-Message-State: ANoB5pmXdZyo9OtG5wkjaR2kvGvk5m7woOcAhMOqcAiAqGUmCItVkoeg
        s8vJ0yHnMOXCK00Ye5Z7UKCZeWNOIjQaEnk86RY6Zw==
X-Google-Smtp-Source: AA0mqf7wM+vhfNUXF2apxC1BoRxFZo/2/n5ITP7l/6K6fqs2HZ/zDYG89M4aSLZQVOeczE40uEyiE1EM+Uc6bc615LQ=
X-Received: by 2002:a81:7853:0:b0:392:b19b:47e9 with SMTP id
 t80-20020a817853000000b00392b19b47e9mr9753950ywc.252.1670533793365; Thu, 08
 Dec 2022 13:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <20221207131731.1291517-3-william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-3-william.qiu@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:09:38 +0100
Message-ID: <CACRpkdYP7MokLdRtxX9w7p80c=wHDHsoTYWrU53CnpsZ7o6aGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

thanks for your patch!

On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:

> Add sdio/emmc driver support for StarFive JH7110 soc.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

(...)
> +#include <linux/gpio.h>

Never include this legacy header in new code. Also: you don't use it.

> +#include <linux/mfd/syscon.h>
> +#include <linux/mmc/host.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

You're not using this include either.

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

Or this.

> +#define ALL_INT_CLR            0x1ffff
> +#define MAX_DELAY_CHAIN                32
> +
> +struct starfive_priv {
> +       struct device *dev;
> +       struct regmap *reg_syscon;
> +       u32 syscon_offset;
> +       u32 syscon_shift;
> +       u32 syscon_mask;
> +};
> +
> +static unsigned long dw_mci_starfive_caps[] = {
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23
> +};
> +
> +static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +       int ret;
> +       unsigned int clock;
> +
> +       if (ios->timing == MMC_TIMING_MMC_DDR52 || ios->timing == MMC_TIMING_UHS_DDR50) {
> +               clock = (ios->clock > 50000000 && ios->clock <= 52000000) ? 100000000 : ios->clock;
> +               ret = clk_set_rate(host->ciu_clk, clock);
> +               if (ret)
> +                       dev_dbg(host->dev, "Use an external frequency divider %uHz\n", ios->clock);
> +               host->bus_hz = clk_get_rate(host->ciu_clk);
> +       } else {
> +               dev_dbg(host->dev, "Using the internal divider\n");
> +       }
> +}
> +
> +static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
> +                                            u32 opcode)
> +{
> +       static const int grade  = MAX_DELAY_CHAIN;
> +       struct dw_mci *host = slot->host;
> +       struct starfive_priv *priv = host->priv;
> +       int raise_point = -1, fall_point = -1;
> +       int err, prev_err = -1;

I don't like these default-init to -1. Can you just skip it and assign it
where it makes most sense instead?

> +       int found = 0;

This looks like a bool.

> +       int i;
> +       u32 regval;
> +
> +       for (i = 0; i < grade; i++) {
> +               regval = i << priv->syscon_shift;
> +               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> +                                               priv->syscon_mask, regval);
> +               if (err)
> +                       return err;
> +               mci_writel(host, RINTSTS, ALL_INT_CLR);
> +
> +               err = mmc_send_tuning(slot->mmc, opcode, NULL);
> +               if (!err)
> +                       found = 1;
> +
> +               if (i > 0) {
> +                       if (err && !prev_err)
> +                               fall_point = i - 1;
> +                       if (!err && prev_err)
> +                               raise_point = i;
> +               }
> +
> +               if (raise_point != -1 && fall_point != -1)
> +                       goto tuning_out;

There are just these raise point (shouldn't this be "rise_point" in proper
english?) and fall point, this misses some comments explaining what is
going on, the code is not intuitively eviden. Rise and fall of *what* for
example.

> +
> +               prev_err = err;
> +               err = 0;
> +       }
> +
> +tuning_out:
> +       if (found) {
> +               if (raise_point == -1)
> +                       raise_point = 0;
> +               if (fall_point == -1)
> +                       fall_point = grade - 1;
> +               if (fall_point < raise_point) {
> +                       if ((raise_point + fall_point) >
> +                           (grade - 1))
> +                               i = fall_point / 2;
> +                       else
> +                               i = (raise_point + grade - 1) / 2;
> +               } else {
> +                       i = (raise_point + fall_point) / 2;
> +               }

Likewise here, explain what grade is, refer to the eMMC spec if necessary.

(...)
> +       ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
> +                                               "starfive,sys-syscon", 3, 0, &args);
> +       if (ret) {
> +               dev_err(host->dev, "Failed to parse starfive,sys-syscon\n");
> +               return -EINVAL;
> +       }
> +
> +       priv->reg_syscon = syscon_node_to_regmap(args.np);
> +       of_node_put(args.np);
> +       if (IS_ERR(priv->reg_syscon))
> +               return PTR_ERR(priv->reg_syscon);
> +
> +       priv->syscon_offset = args.args[0];
> +       priv->syscon_shift  = args.args[1];
> +       priv->syscon_mask   = args.args[2];

Why should these three things be in the device tree instead of being derived
from the compatible-string or just plain hard-coded as #defines?
I don't get it.

> +static int dw_mci_starfive_probe(struct platform_device *pdev)
> +{
> +       return dw_mci_pltfm_register(pdev, &starfive_data);
> +}
> +
> +static int dw_mci_starfive_remove(struct platform_device *pdev)
> +{
> +       return dw_mci_pltfm_remove(pdev);
> +}

Can't you just assign dw_mci_pltfm_remove() to .remove?

Other than these things, the driver looks good!

Yours,
Linus Walleij
