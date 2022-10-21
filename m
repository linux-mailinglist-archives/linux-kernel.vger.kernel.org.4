Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB6606D22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJUBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJUBoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:44:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B759137382
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:44:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g16so826287qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0RwNquik7YFvngOKcLrYEB6m/8xigMSuDQJeMA7mF8=;
        b=ppWV2uPw8Rtohubpp2o324NIpe7xDAdGlX7pCO1C2+vtoFU4mMAUWvCFHKywt3bEDG
         O0JJsCxJrvvEiDknv0pKa+/nKO5oAdGUF9QZ8x5Wb7hT9B1haOiXl86igwaXK+ZKzGaa
         bcMeBSKAbVvT1N++iC3IC/jcv/DAvS6gCl1ULFULtFTHiFqUoD9OUcErUWzELWqDTQaQ
         vwQtOyGnx70BOPzWABN2NXbYlIGOTlHW0Gey2VIlAZFhFLHDNQA7Shw4uPJQmV4JrKBM
         2inxfxGJo5Impvqst7Gui15dalkB14wyKXrhhMeU4eri16//I2XItl98BCrG1iF7/I4+
         7Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0RwNquik7YFvngOKcLrYEB6m/8xigMSuDQJeMA7mF8=;
        b=wVkD3KY1/VDwAjZ4ODJxSJmjVioTzMmOMPAJlQiAjF1LHI794S+skwBEzBsayI5PLU
         omeQdJcxFR2FTbmGLZqL8IgykCDDusL2LT/rG8eLelcyF1Jxu44SW8mkqFJIPBtXqqH5
         rDRtM0Ywt+TMpwi0ZWdhihDPTVF9lIpqBff0es3Lm/U9JVEd8IBBasKyqxIei+Ei14GN
         V/EEHnITYo5sbnRHbPVk4xbKZYAYFiXA8w7v6yXjBtEND4MpjZ4USIcpzlnQwaePWWTo
         JyhP/tyCttFBs0h//VWBHxHAKtS6vmpJBspIFfQjXJyhXhPoKEc7++AxwTLYRihlj4Yd
         SguQ==
X-Gm-Message-State: ACrzQf3llscBUXsUJm4jWVVYMepkcESEFFqxj4cchOEaomZ+8qSVDprK
        IaBtX2tFbxdL/wXvzhwy22V2SgRzDxifzQ==
X-Google-Smtp-Source: AMsMyM5CHwym7SV6F8VoEiEVFNfnVbEPoEfPGG65XG+6Kv6/pJCyIsbnefba9g+T8p9B7U49fvvnsQ==
X-Received: by 2002:ac8:6f09:0:b0:39c:d3ab:eb84 with SMTP id bs9-20020ac86f09000000b0039cd3abeb84mr14092890qtb.267.1666316645113;
        Thu, 20 Oct 2022 18:44:05 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a0e0200b006ee8874f5d8sm8386118qkm.28.2022.10.20.18.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 18:44:04 -0700 (PDT)
Message-ID: <adb9d5ff-bc66-df11-c93c-70f6e11c66aa@linaro.org>
Date:   Thu, 20 Oct 2022 21:44:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221021012728.22373-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021012728.22373-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 21:27, Yinbo Zhu wrote:
> The loongson2 SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing.
> 
> There is currently no support for GPIO pin pull-up and pull-down.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/pinctrl/Kconfig             |  10 +
>  drivers/pinctrl/Makefile            |   1 +
>  drivers/pinctrl/pinctrl-loongson2.c | 330 ++++++++++++++++++++++++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-loongson2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cc541ce89b8..c9883f145acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11922,6 +11922,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
>  F:	drivers/clocksource/loongson2_hpet.c
>  
> +LOONGSON2 SOC SERIES PINCTRL DRIVER
> +M:	zhanghongchen <zhanghongchen@loongson.cn>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/pinctrl-loongson2.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 1cf74b0c42e5..8e43cea0277c 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -507,6 +507,16 @@ config PINCTRL_ZYNQMP
>  	  This driver can also be built as a module. If so, the module
>  	  will be called pinctrl-zynqmp.
>  
> +config PINCTRL_LOONGSON2
> +	tristate "Pinctrl driver for the Loongson2 SoC"

depends on-your-arch || COMPILE_TEST

> +        select PINMUX
> +        select GENERIC_PINCONF

There is something odd with this indentation. Please check if it matches
coding style.


> +        help
> +	  This selects pin control driver for the Loongson2 SoC. It
> +	  provides pin config functions multiplexing.  GPIO pin pull-up
> +	  , pull-down functions are not supported. Say yes to enable

coma goes to previous line.

> +	  pinctrl for Loongson2 SoC.
> +
>  source "drivers/pinctrl/actions/Kconfig"
>  source "drivers/pinctrl/aspeed/Kconfig"
>  source "drivers/pinctrl/bcm/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e76f5cdc64b0..d8b8c5f9e2fd 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
>  obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
> +obj-$(CONFIG_PINCTRL_LOONGSON2) += pinctrl-loongson2.o

Add items in alphabetical order.

>  
>  obj-y				+= actions/
>  obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
> diff --git a/drivers/pinctrl/pinctrl-loongson2.c b/drivers/pinctrl/pinctrl-loongson2.c
> new file mode 100644
> index 000000000000..e4bb3e33e9db
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-loongson2.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: zhanghongchen <zhanghongchen@loongson.cn>
> + *         Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include "core.h"
> +#include "pinctrl-utils.h"
> +
> +#define PMX_GROUP(grp, offset, bitv)					\
> +	{								\
> +		.name = #grp,						\
> +		.pins = grp ## _pins,					\
> +		.num_pins = ARRAY_SIZE(grp ## _pins),			\
> +		.reg = offset,						\
> +		.bit = bitv,						\
> +	}
> +
> +#define SPECIFIC_GROUP(group)						\
> +	static const char * const group##_groups[] = {			\
> +		#group							\
> +	}
> +
> +#define FUNCTION(fn)							\
> +	{								\
> +		.name = #fn,						\
> +		.groups = fn ## _groups,				\
> +		.num_groups = ARRAY_SIZE(fn ## _groups),		\
> +	}
> +
> +struct loongson2_pinctrl {
> +	struct device *dev;
> +	struct pinctrl_dev *pcdev;
> +	struct pinctrl_desc desc;
> +	struct device_node *of_node;
> +	raw_spinlock_t lock;
> +	void * __iomem reg_base;
> +};
> +
> +struct loongson2_pmx_group {
> +	const char *name;
> +	const unsigned int *pins;
> +	unsigned int num_pins;
> +	unsigned int reg;
> +	unsigned int bit;
> +};
> +
> +struct loongson2_pmx_func {
> +	const char *name;
> +	const char * const *groups;
> +	unsigned int num_groups;
> +};
> +
> +#define LOONGSON2_PIN(x) PINCTRL_PIN(x, "gpio"#x)
> +static const struct pinctrl_pin_desc loongson2_pctrl_pins[] = {
> +	LOONGSON2_PIN(0),  LOONGSON2_PIN(1),  LOONGSON2_PIN(2),  LOONGSON2_PIN(3),
> +	LOONGSON2_PIN(4),  LOONGSON2_PIN(5),  LOONGSON2_PIN(6),  LOONGSON2_PIN(7),
> +	LOONGSON2_PIN(8),  LOONGSON2_PIN(9),  LOONGSON2_PIN(10), LOONGSON2_PIN(11),
> +	LOONGSON2_PIN(12), LOONGSON2_PIN(13), LOONGSON2_PIN(14),
> +	LOONGSON2_PIN(16), LOONGSON2_PIN(17), LOONGSON2_PIN(18), LOONGSON2_PIN(19),
> +	LOONGSON2_PIN(20), LOONGSON2_PIN(21), LOONGSON2_PIN(22), LOONGSON2_PIN(23),
> +	LOONGSON2_PIN(24), LOONGSON2_PIN(25), LOONGSON2_PIN(26), LOONGSON2_PIN(27),
> +	LOONGSON2_PIN(28), LOONGSON2_PIN(29), LOONGSON2_PIN(30),
> +	LOONGSON2_PIN(32), LOONGSON2_PIN(33), LOONGSON2_PIN(34), LOONGSON2_PIN(35),
> +	LOONGSON2_PIN(36), LOONGSON2_PIN(37), LOONGSON2_PIN(38), LOONGSON2_PIN(39),
> +	LOONGSON2_PIN(40), LOONGSON2_PIN(41),
> +	LOONGSON2_PIN(44), LOONGSON2_PIN(45), LOONGSON2_PIN(46), LOONGSON2_PIN(47),
> +	LOONGSON2_PIN(48), LOONGSON2_PIN(49), LOONGSON2_PIN(50), LOONGSON2_PIN(51),
> +	LOONGSON2_PIN(52), LOONGSON2_PIN(53), LOONGSON2_PIN(54), LOONGSON2_PIN(55),
> +	LOONGSON2_PIN(56), LOONGSON2_PIN(57), LOONGSON2_PIN(58), LOONGSON2_PIN(59),
> +	LOONGSON2_PIN(60), LOONGSON2_PIN(61), LOONGSON2_PIN(62), LOONGSON2_PIN(63),
> +};
> +
> +static const unsigned int gpio_pins[] = {0, 1, 2, 3, 4, 5, 6, 7,
> +					 8, 9, 10, 11, 12, 13, 14,
> +					 16, 17, 18, 19, 20, 21, 22, 23,
> +					 24, 25, 26, 27, 28, 29, 30,
> +					 32, 33, 34, 35, 36, 37, 38, 39,
> +					 40,         43, 44, 45, 46, 47,
> +					 48, 49, 50, 51, 52, 53, 46, 55,
> +					 56, 57, 58, 59, 60, 61, 62, 63};
> +static const unsigned int sdio_pins[] = {36, 37, 38, 39, 40, 41};
> +static const unsigned int can1_pins[] = {34, 35};
> +static const unsigned int can0_pins[] = {32, 33};
> +static const unsigned int pwm3_pins[] = {23};
> +static const unsigned int pwm2_pins[] = {22};
> +static const unsigned int pwm1_pins[] = {21};
> +static const unsigned int pwm0_pins[] = {20};
> +static const unsigned int i2c1_pins[] = {18, 19};
> +static const unsigned int i2c0_pins[] = {16, 17};
> +static const unsigned int nand_pins[] = {44, 45, 46, 47, 48, 49, 50, 51,
> +					 52, 53, 54, 55, 56, 57, 58, 59, 60,
> +					 61, 62, 63};
> +static const unsigned int sata_led_pins[] = {14};
> +static const unsigned int lio_pins[]    = {};
> +static const unsigned int i2s_pins[]    = {24, 25, 26, 27, 28};
> +static const unsigned int hda_pins[]    = {24, 25, 26, 27, 28, 29, 30};
> +static const unsigned int uart2_pins[]  = {};
> +static const unsigned int uart1_pins[]  = {};
> +static const unsigned int camera_pins[] = {};
> +static const unsigned int dvo1_pins[]   = {};
> +static const unsigned int dvo0_pins[]   = {};
> +
> +static struct loongson2_pmx_group loongson2_pmx_groups[] = {
> +	PMX_GROUP(gpio, 0x0, 64),
> +	PMX_GROUP(sdio, 0x0, 20),
> +	PMX_GROUP(can1, 0x0, 17),
> +	PMX_GROUP(can0, 0x0, 16),
> +	PMX_GROUP(pwm3, 0x0, 15),
> +	PMX_GROUP(pwm2, 0x0, 14),
> +	PMX_GROUP(pwm1, 0x0, 13),
> +	PMX_GROUP(pwm0, 0x0, 12),
> +	PMX_GROUP(i2c1, 0x0, 11),
> +	PMX_GROUP(i2c0, 0x0, 10),
> +	PMX_GROUP(nand, 0x0, 9),
> +	PMX_GROUP(sata_led, 0x0, 8),
> +	PMX_GROUP(lio, 0x0, 7),
> +	PMX_GROUP(i2s, 0x0, 6),
> +	PMX_GROUP(hda, 0x0, 4),
> +	PMX_GROUP(uart2, 0x8, 13),
> +	PMX_GROUP(uart1, 0x8, 12),
> +	PMX_GROUP(camera, 0x10, 5),
> +	PMX_GROUP(dvo1, 0x10, 4),
> +	PMX_GROUP(dvo0, 0x10, 1),
> +
> +};
> +
> +SPECIFIC_GROUP(sdio);
> +SPECIFIC_GROUP(can1);
> +SPECIFIC_GROUP(can0);
> +SPECIFIC_GROUP(pwm3);
> +SPECIFIC_GROUP(pwm2);
> +SPECIFIC_GROUP(pwm1);
> +SPECIFIC_GROUP(pwm0);
> +SPECIFIC_GROUP(i2c1);
> +SPECIFIC_GROUP(i2c0);
> +SPECIFIC_GROUP(nand);
> +SPECIFIC_GROUP(sata_led);
> +SPECIFIC_GROUP(lio);
> +SPECIFIC_GROUP(i2s);
> +SPECIFIC_GROUP(hda);
> +SPECIFIC_GROUP(uart2);
> +SPECIFIC_GROUP(uart1);
> +SPECIFIC_GROUP(camera);
> +SPECIFIC_GROUP(dvo1);
> +SPECIFIC_GROUP(dvo0);
> +
> +static const char * const gpio_groups[] = {
> +	"sdio", "can1", "can0", "pwm3", "pwm2", "pwm1", "pwm0", "i2c1",
> +	"i2c0", "nand", "sata_led", "lio", "i2s", "hda", "uart2", "uart1",
> +	"camera", "dvo1", "dvo0"
> +};
> +
> +static struct loongson2_pmx_func loongson2_pmx_functions[] = {

Why this is not const?

> +	FUNCTION(gpio),
> +	FUNCTION(sdio),
> +	FUNCTION(can1),
> +	FUNCTION(can0),
> +	FUNCTION(pwm3),
> +	FUNCTION(pwm2),
> +	FUNCTION(pwm1),
> +	FUNCTION(pwm0),
> +	FUNCTION(i2c1),
> +	FUNCTION(i2c0),
> +	FUNCTION(nand),
> +	FUNCTION(sata_led),
> +	FUNCTION(lio),
> +	FUNCTION(i2s),
> +	FUNCTION(hda),
> +	FUNCTION(uart2),
> +	FUNCTION(uart1),
> +	FUNCTION(camera),
> +	FUNCTION(dvo1),
> +	FUNCTION(dvo0),
> +};
> +
> +static int loongson2_get_groups_count(struct pinctrl_dev *pcdev)
> +{
> +	return ARRAY_SIZE(loongson2_pmx_groups);
> +}
> +
> +static const char *loongson2_get_group_name(struct pinctrl_dev *pcdev,
> +					unsigned int selector)
> +{
> +	return loongson2_pmx_groups[selector].name;
> +}
> +
> +static int loongson2_get_group_pins(struct pinctrl_dev *pcdev, unsigned int selector,
> +			const unsigned int **pins, unsigned int *num_pins)
> +{
> +	*pins = loongson2_pmx_groups[selector].pins;
> +	*num_pins = loongson2_pmx_groups[selector].num_pins;
> +
> +	return 0;
> +}
> +
> +static void loongson2_pin_dbg_show(struct pinctrl_dev *pcdev, struct seq_file *s,
> +			       unsigned int offset)
> +{
> +	seq_printf(s, " %s", dev_name(pcdev->dev));
> +}
> +
> +static const struct pinctrl_ops loongson2_pctrl_ops = {
> +	.get_groups_count	= loongson2_get_groups_count,
> +	.get_group_name		= loongson2_get_group_name,
> +	.get_group_pins		= loongson2_get_group_pins,
> +	.dt_node_to_map		= pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map		= pinctrl_utils_free_map,
> +	.pin_dbg_show		= loongson2_pin_dbg_show,
> +};
> +
> +static int loongson2_pmx_set_mux(struct pinctrl_dev *pcdev, unsigned int func_num,
> +			      unsigned int group_num)
> +{
> +	struct loongson2_pinctrl *pctrl = pinctrl_dev_get_drvdata(pcdev);
> +	unsigned long reg = (unsigned long)pctrl->reg_base +
> +				loongson2_pmx_groups[group_num].reg;
> +	unsigned int mux_bit = loongson2_pmx_groups[group_num].bit;
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +	val = readl((void *)reg);
> +	if (func_num == 0)
> +		val &= ~(1<<mux_bit);
> +	else
> +		val |= (1<<mux_bit);
> +	writel(val, (void *)reg);
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int loongson2_pmx_get_funcs_count(struct pinctrl_dev *pcdev)
> +{
> +	return ARRAY_SIZE(loongson2_pmx_functions);
> +}
> +
> +static const char *loongson2_pmx_get_func_name(struct pinctrl_dev *pcdev,
> +				    unsigned int selector)
> +{
> +	return loongson2_pmx_functions[selector].name;
> +}
> +
> +static int loongson2_pmx_get_groups(struct pinctrl_dev *pcdev,
> +			 unsigned int selector,
> +			 const char * const **groups,
> +			 unsigned int * const num_groups)
> +{
> +	*groups = loongson2_pmx_functions[selector].groups;
> +	*num_groups = loongson2_pmx_functions[selector].num_groups;
> +
> +	return 0;
> +}
> +
> +const struct pinmux_ops loongson2_pmx_ops = {

Missing static.

Did you compile your code with W=1?

> +	.set_mux = loongson2_pmx_set_mux,
> +	.get_functions_count = loongson2_pmx_get_funcs_count,
> +	.get_function_name = loongson2_pmx_get_func_name,
> +	.get_function_groups = loongson2_pmx_get_groups,
> +};
> +
> +static int loongson2_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct loongson2_pinctrl *pctrl;
> +	struct resource *res;
> +
> +	pctrl = devm_kzalloc(dev, sizeof(struct loongson2_pinctrl), GFP_KERNEL);

sizeof(*pctrl)

> +	if (!pctrl)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pctrl->reg_base = devm_ioremap_resource(dev, res);

Use combined helper for this.

> +	if (IS_ERR(pctrl->reg_base))
> +		return PTR_ERR(pctrl->reg_base);
> +
> +	raw_spin_lock_init(&pctrl->lock);
> +
> +	pctrl->dev = dev;
> +	pctrl->desc.name	= "pinctrl-loongson2";
> +	pctrl->desc.owner	= THIS_MODULE;
> +	pctrl->desc.pctlops	= &loongson2_pctrl_ops;
> +	pctrl->desc.pmxops	= &loongson2_pmx_ops;
> +	pctrl->desc.confops	= NULL;
> +	pctrl->desc.pins	= loongson2_pctrl_pins;
> +	pctrl->desc.npins	= ARRAY_SIZE(loongson2_pctrl_pins);
> +
> +	pctrl->pcdev = devm_pinctrl_register(pctrl->dev, &pctrl->desc, pctrl);
> +	if (IS_ERR(pctrl->pcdev)) {
> +		dev_err(pctrl->dev, "can't register pinctrl device");
> +		return PTR_ERR(pctrl->pcdev);

return dev_err_probe()

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id loongson2_pinctrl_dt_match[] = {
> +	{
> +		.compatible = "loongson,ls2k-pinctrl",
> +	},
> +	{ },
> +};
> +
> +static struct platform_driver loongson2_pinctrl_driver = {
> +	.probe		= loongson2_pinctrl_probe,
> +	.driver = {
> +		.name	= "loongson2-pinctrl",
> +		.of_match_table = loongson2_pinctrl_dt_match,
> +	},
> +};
> +
> +static int __init loongson2_pinctrl_init(void)
> +{
> +	return platform_driver_register(&loongson2_pinctrl_driver);
> +}
> +arch_initcall(loongson2_pinctrl_init);
> +
> +static void __exit loongson2_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&loongson2_pinctrl_driver);
> +}
> +module_exit(loongson2_pinctrl_exit);

Best regards,
Krzysztof

