Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102B6C301B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCULSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCULSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:18:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838BA12849;
        Tue, 21 Mar 2023 04:18:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxldhykhlk4GEPAA--.27963S3;
        Tue, 21 Mar 2023 19:18:10 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxur1xkhlkv4YIAA--.314S3;
        Tue, 21 Mar 2023 19:18:09 +0800 (CST)
Subject: Re: [PATCH v14 2/2] clk: clk-loongson2: add clock controller driver
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230318075340.22770-1-zhuyinbo@loongson.cn>
 <20230318075340.22770-2-zhuyinbo@loongson.cn>
 <1bac2baccd4de561944c4a3f8454f7d3.sboyd@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <92b39474-f79b-74b2-0844-46c7b849d666@loongson.cn>
Date:   Tue, 21 Mar 2023 19:18:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1bac2baccd4de561944c4a3f8454f7d3.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxur1xkhlkv4YIAA--.314S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF15uF4DCryfWryUXw17GFg_yoW7KFWkpF
        Z7AayjkFW7Jr4UWw40qryDJFn5Zw4fK3W7CFW3Ja4DAr9Fvr18u39rGFWfCFn3ZrWkCay2
        vFWq9w4fCFsIgaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bTAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwI
        xGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
        wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxU7J3vUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/21 上午4:17, Stephen Boyd 写道:
> Quoting Yinbo Zhu (2023-03-18 00:53:40)
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 1eef05bb1f99..c0f32d9c1cc4 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -325,6 +325,15 @@ config COMMON_CLK_LOCHNAGAR
>>            This driver supports the clocking features of the Cirrus Logic
>>            Lochnagar audio development board.
>>   
>> +config COMMON_CLK_LOONGSON2
>> +       bool "Clock driver for Loongson-2 SoC"
>> +       depends on COMMON_CLK && OF
> It doesn't depend on OF to build, right? If so, remove it. Also, this is
> within the 'if COMMON_CLK' section of this file, so the 'depends on
> COMMON_CLK' is redundant and should be removed.

I find some function ask OF was enabled otherwise return NULL, but if OF 
not enable that shouldn't be caused compile error,

I will remove the depends on COMMON_CLK  && OF and add depend on 
LOONGARCH || COMPILE_TEST

>
>> +       help
>> +          This driver provides support for clock controller on Loongson-2 SoC.
>> +          The clock controller can generates and supplies clock to various
>> +          peripherals within the SoC.
>> +          Say Y here to support Loongson-2 SoC clock driver.
>> +
>>   config COMMON_CLK_NXP
>>          def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
>>          select REGMAP_MMIO if ARCH_LPC32XX
>> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
>> new file mode 100644
>> index 000000000000..c423932b626d
>> --- /dev/null
>> +++ b/drivers/clk/clk-loongson2.c
>> @@ -0,0 +1,356 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
> Don't think this include will be needed.
okay, I will remove it.
>
>> +#include <linux/of_address.h>
> Don't include this.
okay, I got it.
>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
> Drop this include. This isn't a clk consumer.
okay I got it.
>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +
>> +#define LOONGSON2_PLL_MULT_SHIFT               32
>> +#define LOONGSON2_PLL_MULT_WIDTH               10
>> +#define LOONGSON2_PLL_DIV_SHIFT                        26
>> +#define LOONGSON2_PLL_DIV_WIDTH                        6
>> +#define LOONGSON2_APB_FREQSCALE_SHIFT          20
>> +#define LOONGSON2_APB_FREQSCALE_WIDTH          3
>> +#define LOONGSON2_USB_FREQSCALE_SHIFT          16
>> +#define LOONGSON2_USB_FREQSCALE_WIDTH          3
>> +#define LOONGSON2_SATA_FREQSCALE_SHIFT         12
>> +#define LOONGSON2_SATA_FREQSCALE_WIDTH         3
>> +#define LOONGSON2_BOOT_FREQSCALE_SHIFT         8
>> +#define LOONGSON2_BOOT_FREQSCALE_WIDTH         3
>> +
>> +static void __iomem *loongson2_pll_base;
>> +
>> +static const struct clk_parent_data pdata[] = {
>> +       { .fw_name = "ref_100m", .name = "ref_clk", },
> Are you mainintain backwards compatibility? If not, which I believe is
> the case, drop .name assignment.
okay, I will remove .name
>> +};
>> +
>> +static struct clk_hw *loongson2_clk_register(struct device_node *np,
> Take a struct device instead.
okay, I will do it.
>
>> +                                         const char *name,
>> +                                         const char *parent_name,
>> +                                         const struct clk_ops *ops,
>> +                                         unsigned long flags)
>> +{
>> +       int ret;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init;
>> +
>> +       /* allocate the divider */
>> +       hw = kzalloc(sizeof(*hw), GFP_KERNEL);
>> +       if (!hw)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = name;
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.num_parents = 1;
>> +
>> +       if (!parent_name)
>> +               init.parent_data = pdata;
>> +       else
>> +               init.parent_names = &parent_name;
>> +
>> +       hw->init = &init;
>> +
>> +       /* register the clock */
>> +       ret = of_clk_hw_register(np, hw);
> Use devm_clk_hw_register()
okay, I got it.
>
>> +       if (ret) {
>> +               kfree(hw);
>> +               hw = ERR_PTR(ret);
>> +       }
>> +
>> +       return hw;
>> +}
>> +
>> +static unsigned long loongson2_calc_pll_rate(int offset, unsigned long rate)
>> +{
>> +       u64 val;
>> +       u32 mult = 1, div = 1;
> Why are these initialized?
I will remove the initialized operaion.
>
>> +
>> +       val = readq(loongson2_pll_base + offset);
>> +
>> +       mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
>> +       div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
> They're overwritten here.
okay, I got it.
>
>> +
>> +       return div_u64((u64)rate * mult, div);
>> +}
>> +
>> +static unsigned long loongson2_node_recalc_rate(struct clk_hw *hw,
>> +                                         unsigned long parent_rate)
>> +{
>> +       return loongson2_calc_pll_rate(0x0, parent_rate);
>> +}
> [...]
>> +
>> +static inline void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int count)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < count; i++)
>> +               if (IS_ERR(clks[i]))
>> +                       pr_err("Loongson2 clk %u: register failed with %ld\n",
>> +                               i, PTR_ERR(clks[i]));
>> +}
>> +
>> +static void loongson2_clocks_init(struct device_node *np)
> Inline this function at the caller.
okay, I got it.
>
>> +{
>> +       struct clk_hw **hws;
>> +       struct clk_hw_onecell_data *clk_hw_data;
>> +       spinlock_t loongson2_clk_lock;
>> +
>> +       loongson2_pll_base = of_iomap(np, 0);
> Use platform device APIs.
I will use devm_platform_ioremap_resource.
>
>> +
>> +       if (!loongson2_pll_base) {
>> +               pr_err("clk: unable to map loongson2 clk registers\n");
> Drop error messages when mapping.
okay, I got it.
>
>> +               return;
>> +       }
>> +
>> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
> Use devm_kzalloc()
okay, I got it.
>
>> +                                       GFP_KERNEL);
>> +       if (WARN_ON(!clk_hw_data))
>> +               goto err;
>> +
> [...]
>> +
>> +static int loongson2_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       loongson2_clocks_init(np);
>> +
>> +       return 0;
>> +}
>> +

