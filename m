Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D3B5F1D85
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJAQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJAQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:15:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5A901BA;
        Sat,  1 Oct 2022 09:15:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w2so4327838qtv.9;
        Sat, 01 Oct 2022 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ha6B3XmIQavZcAX8rwS3D2xw7x1dMSuhKPQxayTs/z0=;
        b=l8nmniL8Twky1uQgMGJf0eBv026RjD2l9MpLG7M1Dvw073Q9WV4cCYFcdGK/D9A0kr
         HAb4j4IVLmO+u7BgUdotltZlrxeOfm+7lTNbL6fz+ezMHc2gSdo1VeiyGtCoeJSuVrZw
         FvB/UmId/Sc+uICpzLRYCdTHwKJ1pTc3ZnG7JqD1I+QhNkxzwq9ktQj5gFELG4r1JSx/
         DvQosNIsIxUFBIQ53emEW87boejSInuoSm3m084vbIeniu+1Z/IJOiVRIc5Em6mpz70E
         RSNFy8cka4/oA3rkzKPMl6iovwGPWYeBPm6jMUoTdy2aRaBCfpyBGx8JqkW6NkiY3SV/
         36hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ha6B3XmIQavZcAX8rwS3D2xw7x1dMSuhKPQxayTs/z0=;
        b=jqzDl26Nr4O0ccnBwUm1X77G0CregnWJP/4kCdV//kFUfFtazv8G+NUSjMjNIE0wXb
         gZCv29dHK8PrXSM6JN1DUVVBTC0lV+aUkQTrRtN/z9j4eHjyv2+n/k7r9coE3YtQIBin
         YLQdem7jkj6WzyBTEhvFCXKM62l1QqXbODTK2IZuyh2RGu/fPs/g2Fsgm4ndz4g6XgqE
         r+pSsoW5Nnj9PlZDy58gL8wFR5JeIqd13RCOHUOne7mQUvrni/UDmialoe6BqUEl8AD5
         sHTrmYp4eu1WZEfFRXIUyjLcCzUqkvfiL+fYs++O2kv65e1tjeavFYFHIuNvaBUM6lx0
         D90A==
X-Gm-Message-State: ACrzQf2YhRJmXu3vEAN4k92AMGl+o7oR2hoCcKdQA2v75LSMzKmZfuRX
        T3ktABqiDQU4k8bONKRrgas=
X-Google-Smtp-Source: AMsMyM4mTsU2g9OQJZcy+BZdtO+tVtsLGnUG3upRe7XaVzNLzop7f7aoqzNmcPITGmoZqmOpZhBWnA==
X-Received: by 2002:a05:622a:48c:b0:35d:489c:1ef6 with SMTP id p12-20020a05622a048c00b0035d489c1ef6mr11026074qtx.150.1664640941875;
        Sat, 01 Oct 2022 09:15:41 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bm34-20020a05620a19a200b006cbd92ca141sm6000900qkb.133.2022.10.01.09.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 09:15:41 -0700 (PDT)
Message-ID: <663cdebe-755f-3a93-07f4-da662ccb5a43@gmail.com>
Date:   Sat, 1 Oct 2022 12:15:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 08/10] clk: imx: Add initial support for i.MXRT1170
 clock driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
 <20220901183343.3188903-9-Mr.Bossman075@gmail.com>
 <20220930202819.C4952C433D6@smtp.kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20220930202819.C4952C433D6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/22 16:28, Stephen Boyd wrote:
> Quoting Jesse Taube (2022-09-01 11:33:41)
>> Add clock driver support for i.MXRT1170.
>>
>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> ---
>> V1 -> V2:
>>   - Add slab.h and clock-provider.h
>>   - Add spaces in `root_clocks`
>>   - Expand and sort macro
>>   - Move `clk_hw` structs to `clocks_probe`
>>   - Remove of_irq.h
>>   - Remove unused code/comments
>> V2 -> V3:
>>   - Expand root_clocks names array
>>   - Remove root_clock_names enum
>> V3 -> V4:
>>   - Nothing done
>> V4 -> V5:
>>   - Use __imx_clk_hw_pllv3 to change power bit
>> V5 -> V6:
>>   - Nothing done
>> ---
>>   drivers/clk/imx/Kconfig         |   7 +
>>   drivers/clk/imx/Makefile        |   1 +
>>   drivers/clk/imx/clk-imxrt1170.c | 749 ++++++++++++++++++++++++++++++++
>>   3 files changed, 757 insertions(+)
>>   create mode 100644 drivers/clk/imx/clk-imxrt1170.c
>>
>> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
>> index 25785ec9c276..704a7777af4f 100644
>> --- a/drivers/clk/imx/Kconfig
>> +++ b/drivers/clk/imx/Kconfig
>> @@ -119,3 +119,10 @@ config CLK_IMXRT1050
>>          select MXC_CLK
>>          help
>>              Build the driver for i.MXRT1050 CCM Clock Driver
>> +
>> +config CLK_IMXRT1170
>> +       tristate "IMXRT1170 CCM Clock Driver"
>> +       depends on SOC_IMXRT
>> +       select MXC_CLK
>> +       help
>> +           Build the driver for i.MXRT1170 CCM Clock Driver
>> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
>> index 88b9b9285d22..d607a6d8138a 100644
>> --- a/drivers/clk/imx/Makefile
>> +++ b/drivers/clk/imx/Makefile
>> @@ -52,4 +52,5 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
>>   obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
>>   obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
>>   obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
>> +obj-$(CONFIG_CLK_IMXRT1170)  += clk-imxrt1170.o
>>   obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
>> diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
>> new file mode 100644
>> index 000000000000..71d9aacf9751
>> --- /dev/null
>> +++ b/drivers/clk/imx/clk-imxrt1170.c
>> @@ -0,0 +1,749 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) 2022
>> + * Author(s):
>> + * Jesse Taube <Mr.Bossman075@gmail.com>
>> + */
>> +#include <linux/clk.h>
> 
> Please don't include clk.h unless you use consumer clk APIs. Doesn't
> look like it is used here?
> 
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
> 
> Sorting alphabetically is nice.
Oh my bad, will fix.

>> +#include <dt-bindings/clock/imxrt1170-clock.h>
>> +
>> +#include "clk.h"
>> +
>> +#define CLOCK_MUX_DEFAULT "rcosc48M_div2", "osc", "rcosc400M", "rcosc16M"
> [...]
>> +
>> +static int imxrt1170_clocks_probe(struct platform_device *pdev)
>> +{
>> +       void __iomem *ccm_base;
>> +       void __iomem *pll_base;
>> +       struct clk_hw **hws;
>> +       struct clk_hw_onecell_data *clk_hw_data;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct device_node *anp;
>> +       int ret;
>> +
>> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
>> +                                         IMXRT1170_CLK_END), GFP_KERNEL);
>> +       if (WARN_ON(!clk_hw_data))
>> +               return -ENOMEM;
>> +
>> +       clk_hw_data->num = IMXRT1170_CLK_END;
>> +       hws = clk_hw_data->hws;
>> +
>> +       hws[IMXRT1170_CLK_OSC] = imx_obtain_fixed_clk_hw(np, "osc");
>> +       hws[IMXRT1170_CLK_RCOSC_16M] = imx_obtain_fixed_clk_hw(np, "rcosc16M");
>> +       hws[IMXRT1170_CLK_OSC_32K] = imx_obtain_fixed_clk_hw(np, "osc32k");
>> +
>> +       hws[IMXRT1170_CLK_RCOSC_48M] = imx_clk_hw_fixed_factor("rcosc48M",  "rcosc16M", 3, 1);
>> +       hws[IMXRT1170_CLK_RCOSC_400M] = imx_clk_hw_fixed_factor("rcosc400M",  "rcosc16M", 25, 1);
>> +       hws[IMXRT1170_CLK_RCOSC_48M_DIV2] = imx_clk_hw_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2);
>> +
>> +       anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
>> +       pll_base = of_iomap(anp, 0);
>> +       of_node_put(anp);
>> +       if (WARN_ON(!pll_base))
>> +               return -ENOMEM;
> 
> The kzalloc() leaked.
LOL `grep -r of_find_compatible_node drivers/clk/imx`...
Shall I send patches for the rest of IMX.

> 
>> +
>> +       /* Anatop clocks */
>> +       hws[IMXRT1170_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
>> +
>> +       hws[IMXRT1170_CLK_PLL_ARM_PRE] = __imx_clk_hw_pllv3(IMX_PLLV3_SYSV2, "pll_arm_pre", "osc",
>> +                                                           pll_base + 0x200, 0xff, 13);
>> +       hws[IMXRT1170_CLK_PLL_ARM_BYPASS] = imx_clk_hw_mux("pll_arm_bypass", pll_base + 0x200, 17,
>> +                                                          1, pll_arm_mux, 2);
>> +       hws[IMXRT1170_CLK_PLL_ARM_DIV] = clk_hw_register_divider_table(NULL, "pll_arm_div",
>> +               "pll_arm_bypass", CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>> +               pll_base + 0x200, 15, 2, 0, post_div_table, &imx_ccm_lock);
>> +       hws[IMXRT1170_CLK_PLL_ARM] = imx_clk_hw_gate("pll_arm", "pll_arm_div", pll_base + 0x200, 14);
>> +
>> +       hws[IMXRT1170_CLK_PLL3_PRE] = __imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll3_pre", "osc",
>> +                                                        pll_base + 0x210, 0x1, 21);
>> +       hws[IMXRT1170_CLK_PLL3_BYPASS] = imx_clk_hw_mux("pll3_bypass",
>> +                                                       pll_base + 0x210, 16, 1, pll3_mux, 2);
>> +       hws[IMXRT1170_CLK_PLL3] = imx_clk_hw_gate("pll3_sys", "pll3_bypass", pll_base + 0x210, 13);
>> +
>> +       hws[IMXRT1170_CLK_PLL2_PRE] = __imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll2_pre", "osc",
>> +                                                        pll_base + 0x240, 0x1, 23);
>> +       hws[IMXRT1170_CLK_PLL2_BYPASS] = imx_clk_hw_mux("pll2_bypass",
>> +                                                       pll_base + 0x240, 16, 1, pll2_mux, 2);
>> +       hws[IMXRT1170_CLK_PLL2] = imx_clk_hw_gate("pll2_sys", "pll2_bypass", pll_base + 0x240, 13);
>> +
>> +       hws[IMXRT1170_CLK_PLL3_PFD0] = imx_clk_hw_pfd("pll3_pfd0", "pll3_sys", pll_base + 0x230, 0);
>> +       hws[IMXRT1170_CLK_PLL3_PFD1] = imx_clk_hw_pfd("pll3_pfd1", "pll3_sys", pll_base + 0x230, 1);
>> +       hws[IMXRT1170_CLK_PLL3_PFD2] = imx_clk_hw_pfd("pll3_pfd2", "pll3_sys", pll_base + 0x230, 2);
>> +       hws[IMXRT1170_CLK_PLL3_PFD3] = imx_clk_hw_pfd("pll3_pfd3", "pll3_sys", pll_base + 0x230, 3);
>> +       hws[IMXRT1170_CLK_PLL3_DIV2_GATE] = imx_clk_hw_fixed_factor("pll3_div2_gate", "pll3_sys", 1, 2);
>> +       hws[IMXRT1170_CLK_PLL3_DIV2] = imx_clk_hw_gate("pll3_div2", "pll3_sys", pll_base + 0x210, 3);
>> +
>> +       hws[IMXRT1170_CLK_PLL2_PFD0] = imx_clk_hw_pfd("pll2_pfd0", "pll2_sys", pll_base + 0x270, 0);
>> +       hws[IMXRT1170_CLK_PLL2_PFD1] = imx_clk_hw_pfd("pll2_pfd1", "pll2_sys", pll_base + 0x270, 1);
>> +       hws[IMXRT1170_CLK_PLL2_PFD2] = imx_clk_hw_pfd("pll2_pfd2", "pll2_sys", pll_base + 0x270, 2);
>> +       hws[IMXRT1170_CLK_PLL2_PFD3] = imx_clk_hw_pfd("pll2_pfd3", "pll2_sys", pll_base + 0x270, 3);
>> +
>> +       /* CCM clocks */
>> +       ccm_base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (WARN_ON(IS_ERR(ccm_base)))
>> +               return PTR_ERR(ccm_base);
>> +
>> +       hws[IMXRT1170_CLK_M7_SEL] = imx_clk_hw_mux("m7_sel", ccm_base + (1 * 0x80),
> [....]
>> +       hws[IMXRT1170_CLK_CSI2_UI] = imx_clk_hw_divider("csi2_ui", "csi2_ui_gate", ccm_base +
>> +                                                       (76 * 0x80), 0, 8);
>> +       hws[IMXRT1170_CLK_CSI] = imx_clk_hw_divider("csi", "csi_gate", ccm_base + (77 * 0x80), 0, 8);
>> +       hws[IMXRT1170_CLK_CKO1] = imx_clk_hw_divider("cko1", "cko1_gate", ccm_base + (78 * 0x80), 0, 8);
>> +       hws[IMXRT1170_CLK_CKO2] = imx_clk_hw_divider("cko2", "cko2_gate", ccm_base + (79 * 0x80), 0, 8);
>> +
>> +       hws[IMXRT1170_CLK_USB] = imx_clk_hw_gate("usb", "bus", ccm_base + LPCG_GATE(115), 0);
>> +
>> +       imx_check_clk_hws(hws, IMXRT1170_CLK_END);
>> +
>> +       ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> 
> Use devm? Or implement a driver remove function?
Uh this is the same in the rest of imx could you explain a bit more?

Very sorry for the low quality code :(

Thanks,
Jesse Taube

>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to register clks for i.MXRT1170.\n");
>> +               imx_unregister_hw_clocks(hws, IMXRT1170_CLK_END);
>> +       }
>> +       return ret;
>> +}
>> +
>> +static const struct of_device_id imxrt1170_clk_of_match[] = {
>> +       { .compatible = "fsl,imxrt1170-ccm" },
>> +       { /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, imxrt1170_clk_of_match);
>> +
>> +static struct platform_driver imxrt1170_clk_driver = {
>> +       .probe = imxrt1170_clocks_probe,
>> +       .driver = {
>> +               .name = "imxrt1170-ccm",
>> +               .of_match_table = imxrt1170_clk_of_match,
>> +       },
