Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87405BD754
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiISWaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiISWar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:30:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED74F694
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:30:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so410402wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=H64L7pxloe6ABjQPB6dOZxxjzAKfBLX2WzxDmXIAW9k=;
        b=h6hdPIuuXe/NvoMHtntpj69O9G+CzBzEIubkbH2eD3iogfL2/4jClFnCSNBob1GlbG
         1BLs4fDDqrW6KF18dFxr15CuEee6qnNOoO8z6rvHWf5e+1W2nHhYvZ/ka8AI+GfSK9hC
         QLmfZtPIogBXCS7MLwijj2Qq5LU9CmllsqYXIliveBUKwMisqFS83sCEm6yjvk2vZnI2
         d+BH9ApZUt04jn/7AVMFz38gfRupRSDRDuXuqxvX5HYFkSy/p/i5Zqqe6E6LpJeuxAA8
         HCHK5ae9CptsbVx/vTnWBPL1bQoxPDnSk6bjkXGYMrsHyOYRRLDgpaFw8kKhVPAOhUC3
         YR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H64L7pxloe6ABjQPB6dOZxxjzAKfBLX2WzxDmXIAW9k=;
        b=Y4vQ6R7LoBbohnjBW9QY5WI7DRrWzI9HHbI7GwvOGWb8izY5qTTnfQbwnwLTQCzjr6
         ghOGO+E0EYMnXDHRi2dqt7VP9tBqvkQIUFIGhuyA5GgCGpXjQrn7wCoJKrf9/GlP9J67
         Rx2mfra3TIKkak6TggET71pb7JwNE0ZwkDChq2lh/M+40M5Ztz+2NKpKhwO+deSWjwIz
         Tu/ufeCtmF6gqvJtSatQkhIYtDmWR+9l5pqkPdVMpDr9tN83hmVU7TozuEN7Me5NAvyB
         LYoHs1eUSaAvB4AE6vxlY/CTHGz6+TJBm4X3t3JqHJe0NTyI7AzKsq4JGS/BAIFe7xFP
         w3Ew==
X-Gm-Message-State: ACrzQf0Zulj+t0Zh+eSXffOQIrKW7YLkHFXuag1DFbgofDxE2lOOD6iv
        IqOfZgibZxxe+nx80H4ujk5nfw==
X-Google-Smtp-Source: AMsMyM4rhC/gFJIckxCkKzWYA+1S2wvnQLDFWaaAHKzLCWW53xSA/CpQVaBpxQp/saH/1X3R3XoI+g==
X-Received: by 2002:a05:600c:27d1:b0:3b4:5e9c:23ed with SMTP id l17-20020a05600c27d100b003b45e9c23edmr237361wmb.180.1663626642884;
        Mon, 19 Sep 2022 15:30:42 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003a601a1c2f7sm16407376wms.19.2022.09.19.15.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 15:30:42 -0700 (PDT)
Message-ID: <193bf7d7-ac7c-5bcd-1f2b-f95dc3621f61@sifive.com>
Date:   Mon, 19 Sep 2022 23:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v4 08/10] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-9-ben.dooks@sifive.com>
 <20220914164720.bjh6tqw6zb66vsyz@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220914164720.bjh6tqw6zb66vsyz@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 17:47, Uwe Kleine-König wrote:
> On Tue, Aug 16, 2022 at 10:14:52PM +0100, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v4:
>>   - split the of code out of the core
>>   - moved the compile test code earlier
>>   - fixed review comments
>>    - used NS_PER_SEC
>>    - use devm_clk_get_enabled
>> v3:
>>   - changed compatible name
>> ---
>>   drivers/pwm/Kconfig      |  9 +++++
>>   drivers/pwm/Makefile     |  1 +
>>   drivers/pwm/pwm-dwc-of.c | 78 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 88 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-dwc-of.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index a9f1c554db2b..f1735653365f 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -192,6 +192,15 @@ config PWM_DWC_PCI
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-dwc-pci.
>>   
>> +config PWM_DWC_OF
>> +	tristate "DesignWare PWM Controller (OF bus)
>> +	depends on PWM_DWC && OF
>> +	help
>> +	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-dwc-of.
>> +
>>   config PWM_EP93XX
>>   	tristate "Cirrus Logic EP93xx PWM support"
>>   	depends on ARCH_EP93XX || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index a70d36623129..d1fd1641f077 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>>   obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>>   obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>>   obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
>> +obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
>>   obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
>>   obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>>   obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
>> new file mode 100644
>> index 000000000000..d18fac287325
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc-of.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DesignWare PWM Controller driver OF
>> + *
>> + * Copyright (C) 2022 SiFive, Inc.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/export.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/clk.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/pwm.h>
>> +#include <linux/io.h>
>> +
>> +#include "pwm-dwc.h"
>> +
>> +static int dwc_pwm_plat_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct dwc_pwm *dwc;
>> +	int ret;
>> +
>> +	dwc = dwc_pwm_alloc(dev);
>> +	if (!dwc)
>> +		return -ENOMEM;
>> +
>> +	dwc->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(dwc->base))
>> +		return dev_err_probe(dev, PTR_ERR(dwc->base),
>> +				     "failed to map IO\n");
> 
> devm_platform_ioremap_resource() already emits an error message.

ok, fixed


>> +
>> +	dwc->clk = devm_clk_get_enabled(dev, "timer");
>> +	if (IS_ERR(dwc->clk))
>> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
>> +				     "failed to get timer clock\n");
>> +
>> +	clk_prepare_enable(dwc->clk);
> 
> You don't need clk_prepare_enable() as you used devm_clk_get_enabled().
> 
> (Otherwise, when keeping clk_prepare_enable() you need to check the
> return value.)

ok, fixed. I didn't notice that when changing to devm_

> 
>> +	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
> 
> I think I already pointed out this is non-optimal.
> 
> Later you use clk_ns in __dwc_pwm_configure_timer():
> 
> 	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
> 
> So what you really want here is:
> 
> 	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * clk_get_rate(dwc->clk), NSEC_PER_SEC);
> 
> With for example clk_get_rate(dwc->clk) = 201171875 and duty_cycle =
> 4096 you now get clk_ns = 4 (while the exact value is 4.97087..), tmp =
> 1024, while the exact value is 824.
> 
> So the idea is to add a clkrate member to the private driver struct, let
> it default to 100000000 for the pci case and use the line I suggested
> above.

ok, will consider keeping the rate in hz and modifiying the pci
version to use 10 * NSEC_PER_SEC for the rate.

I've been trying to avoid changing the pci case, but I think for
anything with a clk pointer we should be doing clk_get_rate in the
calc code

> 
>> +
>> +	ret = devm_pwmchip_add(dev, &dwc->chip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> This is equivalent to
> 
> 	return ret;

Will sort that out.


>> +}
>> +
>> +static int dwc_pwm_plat_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
>> +
>> +	clk_disable_unprepare(dwc->clk);
>> +	return 0;
>> +}
> 
> When dropping clk_prepare_enable() the .remove callback can go away,
> too.

thanks, spotted that one a while ago.

>> +
>> +static const struct of_device_id dwc_pwm_dt_ids[] = {
>> +	{ .compatible = "snps,dw-apb-timers-pwm2" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
>> +
>> +static struct platform_driver dwc_pwm_plat_driver = {
>> +	.driver = {
>> +		.name		= "dwc-pwm",
>> +		.of_match_table  = dwc_pwm_dt_ids,
>> +	},
>> +	.probe	= dwc_pwm_plat_probe,
>> +	.remove	= dwc_pwm_plat_remove,
>> +};
>> +
>> +module_platform_driver(dwc_pwm_plat_driver);
>> +
>> +MODULE_ALIAS("platform:dwc-pwm-of");
>> +MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
>> +MODULE_DESCRIPTION("DesignWare PWM Controller");
>> +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe
> 

