Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEE72EBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjFMTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjFMTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:22:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5C19F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:22:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec9bso8578295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686684157; x=1689276157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q6ZJ4YwuYdiVlTTDOcN/GewMOV+YksBLvFuDv2yp6M=;
        b=jOG2xFSFVeoxdQyl6rax367fC200qG9A2Cua+3w31KP+UlYZsAKItY0+7Ntctzmvym
         eFWzlpq1MsGmtXOcPhtzOrAAfRopACuWKN+LkoFa6z9ARFBPR6/i5rCV937ipGLJYAoQ
         DAHK3ZUtqQ/QvBQ+UX6J2/lPEH2rXknGhaEo1/J3HWeqAgYHYKPRnZ8oLfsddV9zNiPL
         /QvTk/LzHISSHeKN80+ktYizG8plfJCjKZByw3eOZOP0lthJxt8+s+po45TbARaPEEWe
         vhlpQNiec1A8pHOxK33Xkh9gUAHgq8KayK3OjWu4zt1esWzmRXLZxicDmsQiZwmpqKjE
         4RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684157; x=1689276157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q6ZJ4YwuYdiVlTTDOcN/GewMOV+YksBLvFuDv2yp6M=;
        b=dOL+EGAeP0Is+7Emj/HaCq9hPLP8R7JFpTlWaoGk9HYht16Z7s1Lodg0dkTXF5INL8
         U5lM7uWyfrtxQuQt3pNkKN4GzQ9PM55Nlnk4ucqNq25bK3jsBdeb8HQ6J0uSsosjYR0o
         gJ3XE3PNDSewbGeSvSVXQwOS4j/FdvJ61LVwfBFiuMdZtBqNw9PUhBquBmH98pK7TMVC
         Hsc8rAahrncP5oPwgO95oTv9gDX1MJ1Y6YvCWqshcnGFK844DLSy+QbIL79HrxSAvtTn
         2KX8BHve9jydPTIHZHUsNwyiBRmFzx7neA9liRDAXSNTEv19iHUGtrua7OtEa/FIR4it
         JHHQ==
X-Gm-Message-State: AC+VfDx3iUEAL6BvyyX7kIRkZmVUHakzY1JH2RNpklxToq+e41uJxCD7
        YAc6jaTJjvASJRYQOyhoMDFjAA==
X-Google-Smtp-Source: ACHHUZ6WqveBV2TZ0dT/zYs3HVfaTg3rs/xSRmHw22tiyHtgMOHbxtzSiihuCLDwR9ILvcbmyzgcUw==
X-Received: by 2002:a05:600c:2204:b0:3f7:35a9:dfdf with SMTP id z4-20020a05600c220400b003f735a9dfdfmr10073958wml.24.1686684157017;
        Tue, 13 Jun 2023 12:22:37 -0700 (PDT)
Received: from [192.168.0.16] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm15300443wmz.6.2023.06.13.12.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:22:36 -0700 (PDT)
Message-ID: <5fded01b-087a-48e1-6b38-2f52ddb190ea@sifive.com>
Date:   Tue, 13 Jun 2023 20:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 06/10] pwm: dwc: split pci out of core driver
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
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-7-ben.dooks@sifive.com>
 <20230216213054.lge6ugeay3uxh2ye@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20230216213054.lge6ugeay3uxh2ye@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 21:30, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Dec 23, 2022 at 03:38:16PM +0000, Ben Dooks wrote:
>> Moving towards adding non-pci support for the driver, move the pci
>> parts out of the core into their own module. This is partly due to
>> the module_driver() code only being allowed once in a module and also
>> to avoid a number of #ifdef if we build a single file in a system
>> without pci support.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v7:
>>   - re-order kconfig to make dwc core be selected by PCI driver
>> v6:
>>   - put DWC_PERIOD_NS back to avoid bisect issues
>> v4:
>>   - removed DWC_PERIOD_NS as not needed
>> ---
>>   drivers/pwm/Kconfig       |  17 +++-
>>   drivers/pwm/Makefile      |   1 +
>>   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
>>   drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
>>   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
>>   5 files changed, 209 insertions(+), 158 deletions(-)
>>   create mode 100644 drivers/pwm/pwm-dwc-pci.c
>>   create mode 100644 drivers/pwm/pwm-dwc.h
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 3f3c53af4a56..8c5ef388a981 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -174,16 +174,25 @@ config PWM_CROS_EC
>>   	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>>   	  Controller.
>>   
>> -config PWM_DWC
>> -	tristate "DesignWare PWM Controller"
>> -	depends on PCI || COMPILE_TEST
> 
> You're loosing COMPILE_TEST here, as it's not present for the new
> PWM_DWC.
> 
>> +config PWM_DWC_CORE
>> +	tristate
>>   	depends on HAS_IOMEM
>>   	help
>> -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>> +	  PWM driver for Synopsys DWC PWM Controller.
>>   
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-dwc.
>>   
>> +config PWM_DWC
>> +	tristate "DesignWare PWM Controller (PCI bus)"
>> +	depends on HAS_IOMEM && PCI
>> +	select PWM_DWC_CORE
>> +	help
>> +	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-dwc-pci.
>> +
>>   config PWM_EP93XX
>>   	tristate "Cirrus Logic EP93xx PWM support"
>>   	depends on ARCH_EP93XX || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 7bf1a29f02b8..a70d36623129 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>>   obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>>   obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>>   obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
>> +obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
>>   obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>>   obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>>   obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>> diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
>> new file mode 100644
>> index 000000000000..2213d0e7f3c8
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc-pci.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DesignWare PWM Controller driver (PCI part)
>> + *
>> + * Copyright (C) 2018-2020 Intel Corporation
>> + *
>> + * Author: Felipe Balbi (Intel)
>> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> + * Author: Raymond Tan <raymond.tan@intel.com>
>> + *
>> + * Limitations:
>> + * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
>> + *   periods are one or more input clock periods long.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/export.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/pwm.h>
>> +
>> +#include "pwm-dwc.h"
>> +
>> +static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
>> +{
>> +	struct device *dev = &pci->dev;
>> +	struct dwc_pwm *dwc;
>> +	int ret;
>> +
>> +	dwc = dwc_pwm_alloc(dev);
>> +	if (!dwc)
>> +		return -ENOMEM;
>> +
>> +	ret = pcim_enable_device(pci);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pci);
>> +
>> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
>> +	if (ret) {
>> +		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	dwc->base = pcim_iomap_table(pci)[0];
>> +	if (!dwc->base) {
>> +		dev_err(dev, "Base address missing\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = devm_pwmchip_add(dev, &dwc->chip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_put(dev);
>> +	pm_runtime_allow(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dwc_pwm_remove(struct pci_dev *pci)
>> +{
>> +	pm_runtime_forbid(&pci->dev);
>> +	pm_runtime_get_noresume(&pci->dev);
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dwc_pwm_suspend(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
>> +		if (dwc->chip.pwms[i].state.enabled) {
>> +			dev_err(dev, "PWM %u in use by consumer (%s)\n",
>> +				i, dwc->chip.pwms[i].label);
>> +			return -EBUSY;
>> +		}
>> +		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
>> +		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
>> +		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc_pwm_resume(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
>> +		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
>> +		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
>> +		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
>> +
>> +static const struct pci_device_id dwc_pwm_id_table[] = {
>> +	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
>> +	{  }	/* Terminating Entry */
>> +};
>> +MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
>> +
>> +static struct pci_driver dwc_pwm_driver = {
>> +	.name = "pwm-dwc",
>> +	.probe = dwc_pwm_probe,
>> +	.remove = dwc_pwm_remove,
>> +	.id_table = dwc_pwm_id_table,
>> +	.driver = {
>> +		.pm = &dwc_pwm_pm_ops,
>> +	},
>> +};
>> +
>> +module_pci_driver(dwc_pwm_driver);
>> +
>> +MODULE_AUTHOR("Felipe Balbi (Intel)");
>> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
>> +MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
>> +MODULE_DESCRIPTION("DesignWare PWM Controller");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
>> index 56cde9da2c0e..90a8ae1252a1 100644
>> --- a/drivers/pwm/pwm-dwc.c
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -1,16 +1,12 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * DesignWare PWM Controller driver
>> + * DesignWare PWM Controller driver core
>>    *
>>    * Copyright (C) 2018-2020 Intel Corporation
>>    *
>>    * Author: Felipe Balbi (Intel)
>>    * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>    * Author: Raymond Tan <raymond.tan@intel.com>
>> - *
>> - * Limitations:
>> - * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
>> - *   periods are one or more input clock periods long.
>>    */
>>   
>>   #include <linux/bitops.h>
>> @@ -21,51 +17,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pwm.h>
>>   
>> -#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
>> -#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
>> -#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
>> -#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
>> -#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
>> -#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
>> -
>> -#define DWC_TIMERS_INT_STS	0xa0
>> -#define DWC_TIMERS_EOI		0xa4
>> -#define DWC_TIMERS_RAW_INT_STS	0xa8
>> -#define DWC_TIMERS_COMP_VERSION	0xac
>> -
>> -#define DWC_TIMERS_TOTAL	8
>> -#define DWC_CLK_PERIOD_NS	10
>> -
>> -/* Timer Control Register */
>> -#define DWC_TIM_CTRL_EN		BIT(0)
>> -#define DWC_TIM_CTRL_MODE	BIT(1)
>> -#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
>> -#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
>> -#define DWC_TIM_CTRL_INT_MASK	BIT(2)
>> -#define DWC_TIM_CTRL_PWM	BIT(3)
>> -
>> -struct dwc_pwm_ctx {
>> -	u32 cnt;
>> -	u32 cnt2;
>> -	u32 ctrl;
>> -};
>> -
>> -struct dwc_pwm {
>> -	struct pwm_chip chip;
>> -	void __iomem *base;
>> -	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>> -};
>> -#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
>> -
>> -static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
>> -{
>> -	return readl(dwc->base + offset);
>> -}
>> -
>> -static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
>> -{
>> -	writel(value, dwc->base + offset);
>> -}
>> +#include "pwm-dwc.h"
>>   
>>   static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
>>   {
>> @@ -196,7 +148,7 @@ static const struct pwm_ops dwc_pwm_ops = {
>>   	.owner = THIS_MODULE,
>>   };
>>   
>> -static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>> +struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>>   {
>>   	struct dwc_pwm *dwc;
>>   
>> @@ -211,109 +163,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>>   	dev_set_drvdata(dev, dwc);
>>   	return dwc;
>>   }
>> -
>> -static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
>> -{
>> -	struct device *dev = &pci->dev;
>> -	struct dwc_pwm *dwc;
>> -	int ret;
>> -
>> -	dwc = dwc_pwm_alloc(dev);
>> -	if (!dwc)
>> -		return -ENOMEM;
>> -
>> -	ret = pcim_enable_device(pci);
>> -	if (ret) {
>> -		dev_err(dev, "Failed to enable device (%pe)\n", ERR_PTR(ret));
>> -		return ret;
>> -	}
>> -
>> -	pci_set_master(pci);
>> -
>> -	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
>> -	if (ret) {
>> -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
>> -		return ret;
>> -	}
>> -
>> -	dwc->base = pcim_iomap_table(pci)[0];
>> -	if (!dwc->base) {
>> -		dev_err(dev, "Base address missing\n");
>> -		return -ENOMEM;
>> -	}
>> -
>> -	ret = devm_pwmchip_add(dev, &dwc->chip);
>> -	if (ret)
>> -		return ret;
>> -
>> -	pm_runtime_put(dev);
>> -	pm_runtime_allow(dev);
>> -
>> -	return 0;
>> -}
>> -
>> -static void dwc_pwm_remove(struct pci_dev *pci)
>> -{
>> -	pm_runtime_forbid(&pci->dev);
>> -	pm_runtime_get_noresume(&pci->dev);
>> -}
>> -
>> -#ifdef CONFIG_PM_SLEEP
>> -static int dwc_pwm_suspend(struct device *dev)
>> -{
>> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> -	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> -	int i;
>> -
>> -	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
>> -		if (dwc->chip.pwms[i].state.enabled) {
>> -			dev_err(dev, "PWM %u in use by consumer (%s)\n",
>> -				i, dwc->chip.pwms[i].label);
>> -			return -EBUSY;
>> -		}
>> -		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
>> -		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
>> -		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int dwc_pwm_resume(struct device *dev)
>> -{
>> -	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> -	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> -	int i;
>> -
>> -	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
>> -		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
>> -		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
>> -		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
>> -	}
>> -
>> -	return 0;
>> -}
>> -#endif
>> -
>> -static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
>> -
>> -static const struct pci_device_id dwc_pwm_id_table[] = {
>> -	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
>> -	{  }	/* Terminating Entry */
>> -};
>> -MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
>> -
>> -static struct pci_driver dwc_pwm_driver = {
>> -	.name = "pwm-dwc",
>> -	.probe = dwc_pwm_probe,
>> -	.remove = dwc_pwm_remove,
>> -	.id_table = dwc_pwm_id_table,
>> -	.driver = {
>> -		.pm = &dwc_pwm_pm_ops,
>> -	},
>> -};
>> -
>> -module_pci_driver(dwc_pwm_driver);
>> +EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
>>   
>>   MODULE_AUTHOR("Felipe Balbi (Intel)");
>>   MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
>> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
>> new file mode 100644
>> index 000000000000..68f98eb76152
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc.h
>> @@ -0,0 +1,58 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DesignWare PWM Controller driver
>> + *
>> + * Copyright (C) 2018-2020 Intel Corporation
>> + *
>> + * Author: Felipe Balbi (Intel)
>> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> + * Author: Raymond Tan <raymond.tan@intel.com>
>> + */
>> +
>> +#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
>> +#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
>> +#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
>> +#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
>> +#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
>> +#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
>> +
>> +#define DWC_TIMERS_INT_STS	0xa0
>> +#define DWC_TIMERS_EOI		0xa4
>> +#define DWC_TIMERS_RAW_INT_STS	0xa8
>> +#define DWC_TIMERS_COMP_VERSION	0xac
>> +
>> +#define DWC_TIMERS_TOTAL	8
>> +#define DWC_CLK_PERIOD_NS	10
>> +
>> +/* Timer Control Register */
>> +#define DWC_TIM_CTRL_EN		BIT(0)
>> +#define DWC_TIM_CTRL_MODE	BIT(1)
>> +#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
>> +#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
>> +#define DWC_TIM_CTRL_INT_MASK	BIT(2)
>> +#define DWC_TIM_CTRL_PWM	BIT(3)
>> +
>> +struct dwc_pwm_ctx {
>> +	u32 cnt;
>> +	u32 cnt2;
>> +	u32 ctrl;
>> +};
>> +
>> +struct dwc_pwm {
>> +	struct pwm_chip chip;
>> +	void __iomem *base;
>> +	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>> +};
>> +#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
>> +
>> +static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
>> +{
>> +	return readl(dwc->base + offset);
>> +}
>> +
>> +static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
>> +{
>> +	writel(value, dwc->base + offset);
>> +}
>> +
>> +extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
> 
> If you respin this patch for the COMPILE_TEST issue I pointed out above,
> would you mind using a module namespace?
> 
> That would work by adding e.g.
> 
> 	#define DEFAULT_SYMBOL_NAMESPACE dwc-pwm
> 
> to drivers/pwm/pwm-dwc.c (before the includes) and
> 
> 	MODULE_IMPORT_NS(dwc-pwm)
> 
> to drivers/pwm/pwm-dwc.h.
> 
> Best regards
> Uwe
> 

I tried adding these, but all I get is a bunch of compile errors.


