Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE3675A71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjATQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjATQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:50:10 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021F702BE;
        Fri, 20 Jan 2023 08:50:08 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id kt14so15485904ejc.3;
        Fri, 20 Jan 2023 08:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvIZpB313CG1MKBxRZoJYWLQPwRKo0P3TYMo8tLh4o0=;
        b=gA9/njtQP2G9FClaGn7CF+b1w7XjkOxME8VcCbi3LtZSEAxYKpmxEyxa+HXo6Or6PI
         2c8nEFAq3QydUSzcSSIytZu/IvR0HVrs0d+DyEGiWUCUgISMNbWu1Too9388dg1KghF9
         bYUVHu+WbycdEnJ95CrWq19rNvhgEz2hZAYr0LCzrhtK/LmkslJHlU+9eNy5ZY3G5cNc
         zf2557sGBQm8ZVDa7f30j7TZWGrip9FBPJdIg9IyWXRZIQxTIpbFuMbnqy+l9irJsD47
         PYU78gCb53pNWz7K6RR+odKNsBQdjP2kXACTZQdKyPJszr0cspvW96CMd2dERP6OAtQt
         b5EA==
X-Gm-Message-State: AFqh2kpucHv6cztag8LiMqUv7m2FbLz5BjQtwR6jhC3xMKFrUVxlOrpz
        l0JSvWAq6Xgl5p/AgogMoOJLfBRfjH327qOnsqk=
X-Google-Smtp-Source: AMrXdXs1w2n7Br7F+A56A2kNnp7GeDfivjvquXNMT2S7jfnBBLylogIvLBSF9rAWWVwcK+uOCRb3oBaX9iH4GyS9WQo=
X-Received: by 2002:a17:906:940c:b0:86f:d628:e184 with SMTP id
 q12-20020a170906940c00b0086fd628e184mr1922708ejx.96.1674233407519; Fri, 20
 Jan 2023 08:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20230112135342.3927338-1-keguang.zhang@gmail.com>
In-Reply-To: <20230112135342.3927338-1-keguang.zhang@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:49:56 +0100
Message-ID: <CAJZ5v0jC33tYfjXRYcURNCW0q5R3cNc6HdgGnbvdJ-U0LsnVkA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: loongson1: Delete obsolete driver
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 2:54 PM Keguang Zhang <keguang.zhang@gmail.com> wrote:
>
> The generic DT based cpufreq driver works for Loongson-1,
> so delete the old custom driver.
>
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/Kconfig             |   9 --
>  drivers/cpufreq/Makefile            |   1 -
>  drivers/cpufreq/loongson1-cpufreq.c | 222 ----------------------------
>  3 files changed, 232 deletions(-)
>  delete mode 100644 drivers/cpufreq/loongson1-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2a84fc63371e..448b8ffb4ebd 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -270,15 +270,6 @@ config LOONGSON2_CPUFREQ
>
>           Loongson2F and its successors support this feature.
>
> -         If in doubt, say N.
> -
> -config LOONGSON1_CPUFREQ
> -       tristate "Loongson1 CPUFreq Driver"
> -       depends on LOONGSON1_LS1B
> -       help
> -         This option adds a CPUFreq driver for loongson1 processors which
> -         support software configurable cpu frequency.
> -
>           If in doubt, say N.
>  endif
>
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 32a7029e25ed..4a806cc5265b 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -111,7 +111,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)               += powernv-cpufreq.o
>  obj-$(CONFIG_BMIPS_CPUFREQ)            += bmips-cpufreq.o
>  obj-$(CONFIG_IA64_ACPI_CPUFREQ)                += ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)                += loongson2_cpufreq.o
> -obj-$(CONFIG_LOONGSON1_CPUFREQ)                += loongson1-cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)              += sh-cpufreq.o
>  obj-$(CONFIG_SPARC_US2E_CPUFREQ)       += sparc-us2e-cpufreq.o
>  obj-$(CONFIG_SPARC_US3_CPUFREQ)                += sparc-us3-cpufreq.o
> diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> deleted file mode 100644
> index fb72d709db56..000000000000
> --- a/drivers/cpufreq/loongson1-cpufreq.c
> +++ /dev/null
> @@ -1,222 +0,0 @@
> -/*
> - * CPU Frequency Scaling for Loongson 1 SoC
> - *
> - * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/clk-provider.h>
> -#include <linux/cpu.h>
> -#include <linux/cpufreq.h>
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -
> -#include <cpufreq.h>
> -#include <loongson1.h>
> -
> -struct ls1x_cpufreq {
> -       struct device *dev;
> -       struct clk *clk;        /* CPU clk */
> -       struct clk *mux_clk;    /* MUX of CPU clk */
> -       struct clk *pll_clk;    /* PLL clk */
> -       struct clk *osc_clk;    /* OSC clk */
> -       unsigned int max_freq;
> -       unsigned int min_freq;
> -};
> -
> -static struct ls1x_cpufreq *cpufreq;
> -
> -static int ls1x_cpufreq_notifier(struct notifier_block *nb,
> -                                unsigned long val, void *data)
> -{
> -       if (val == CPUFREQ_POSTCHANGE)
> -               current_cpu_data.udelay_val = loops_per_jiffy;
> -
> -       return NOTIFY_OK;
> -}
> -
> -static struct notifier_block ls1x_cpufreq_notifier_block = {
> -       .notifier_call = ls1x_cpufreq_notifier
> -};
> -
> -static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
> -                              unsigned int index)
> -{
> -       struct device *cpu_dev = get_cpu_device(policy->cpu);
> -       unsigned int old_freq, new_freq;
> -
> -       old_freq = policy->cur;
> -       new_freq = policy->freq_table[index].frequency;
> -
> -       /*
> -        * The procedure of reconfiguring CPU clk is as below.
> -        *
> -        *  - Reparent CPU clk to OSC clk
> -        *  - Reset CPU clock (very important)
> -        *  - Reconfigure CPU DIV
> -        *  - Reparent CPU clk back to CPU DIV clk
> -        */
> -
> -       clk_set_parent(policy->clk, cpufreq->osc_clk);
> -       __raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
> -                    LS1X_CLK_PLL_DIV);
> -       __raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
> -                    LS1X_CLK_PLL_DIV);
> -       clk_set_rate(cpufreq->mux_clk, new_freq * 1000);
> -       clk_set_parent(policy->clk, cpufreq->mux_clk);
> -       dev_dbg(cpu_dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
> -
> -       return 0;
> -}
> -
> -static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
> -{
> -       struct device *cpu_dev = get_cpu_device(policy->cpu);
> -       struct cpufreq_frequency_table *freq_tbl;
> -       unsigned int pll_freq, freq;
> -       int steps, i;
> -
> -       pll_freq = clk_get_rate(cpufreq->pll_clk) / 1000;
> -
> -       steps = 1 << DIV_CPU_WIDTH;
> -       freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
> -       if (!freq_tbl)
> -               return -ENOMEM;
> -
> -       for (i = 0; i < (steps - 1); i++) {
> -               freq = pll_freq / (i + 1);
> -               if ((freq < cpufreq->min_freq) || (freq > cpufreq->max_freq))
> -                       freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
> -               else
> -                       freq_tbl[i].frequency = freq;
> -               dev_dbg(cpu_dev,
> -                       "cpufreq table: index %d: frequency %d\n", i,
> -                       freq_tbl[i].frequency);
> -       }
> -       freq_tbl[i].frequency = CPUFREQ_TABLE_END;
> -
> -       policy->clk = cpufreq->clk;
> -       cpufreq_generic_init(policy, freq_tbl, 0);
> -
> -       return 0;
> -}
> -
> -static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
> -{
> -       kfree(policy->freq_table);
> -       return 0;
> -}
> -
> -static struct cpufreq_driver ls1x_cpufreq_driver = {
> -       .name           = "cpufreq-ls1x",
> -       .flags          = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> -       .verify         = cpufreq_generic_frequency_table_verify,
> -       .target_index   = ls1x_cpufreq_target,
> -       .get            = cpufreq_generic_get,
> -       .init           = ls1x_cpufreq_init,
> -       .exit           = ls1x_cpufreq_exit,
> -       .attr           = cpufreq_generic_attr,
> -};
> -
> -static int ls1x_cpufreq_remove(struct platform_device *pdev)
> -{
> -       cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
> -                                   CPUFREQ_TRANSITION_NOTIFIER);
> -       cpufreq_unregister_driver(&ls1x_cpufreq_driver);
> -
> -       return 0;
> -}
> -
> -static int ls1x_cpufreq_probe(struct platform_device *pdev)
> -{
> -       struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
> -       struct clk *clk;
> -       int ret;
> -
> -       if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
> -               dev_err(&pdev->dev, "platform data missing\n");
> -               return -EINVAL;
> -       }
> -
> -       cpufreq =
> -           devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
> -       if (!cpufreq)
> -               return -ENOMEM;
> -
> -       cpufreq->dev = &pdev->dev;
> -
> -       clk = devm_clk_get(&pdev->dev, pdata->clk_name);
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "unable to get %s clock\n",
> -                       pdata->clk_name);
> -               return PTR_ERR(clk);
> -       }
> -       cpufreq->clk = clk;
> -
> -       clk = clk_get_parent(clk);
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "unable to get parent of %s clock\n",
> -                       __clk_get_name(cpufreq->clk));
> -               return PTR_ERR(clk);
> -       }
> -       cpufreq->mux_clk = clk;
> -
> -       clk = clk_get_parent(clk);
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "unable to get parent of %s clock\n",
> -                       __clk_get_name(cpufreq->mux_clk));
> -               return PTR_ERR(clk);
> -       }
> -       cpufreq->pll_clk = clk;
> -
> -       clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "unable to get %s clock\n",
> -                       pdata->osc_clk_name);
> -               return PTR_ERR(clk);
> -       }
> -       cpufreq->osc_clk = clk;
> -
> -       cpufreq->max_freq = pdata->max_freq;
> -       cpufreq->min_freq = pdata->min_freq;
> -
> -       ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
> -       if (ret) {
> -               dev_err(&pdev->dev,
> -                       "failed to register CPUFreq driver: %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
> -                                       CPUFREQ_TRANSITION_NOTIFIER);
> -
> -       if (ret) {
> -               dev_err(&pdev->dev,
> -                       "failed to register CPUFreq notifier: %d\n",ret);
> -               cpufreq_unregister_driver(&ls1x_cpufreq_driver);
> -       }
> -
> -       return ret;
> -}
> -
> -static struct platform_driver ls1x_cpufreq_platdrv = {
> -       .probe  = ls1x_cpufreq_probe,
> -       .remove = ls1x_cpufreq_remove,
> -       .driver = {
> -               .name   = "ls1x-cpufreq",
> -       },
> -};
> -
> -module_platform_driver(ls1x_cpufreq_platdrv);
> -
> -MODULE_ALIAS("platform:ls1x-cpufreq");
> -MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> -MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
> -MODULE_LICENSE("GPL");
>
> base-commit: 837dc62247d5e50a0724af2001f070962300c87e
> --

Applied as 6.3 material, thanks!
