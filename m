Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA2662304
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjAIKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjAIKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:18:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82961AA2D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:17:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w1so7621201wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QO4Gj1e5UeqF5ymzTkto2ant13Qz/wNOziFjfJJ5vzg=;
        b=pVfYlYO+VKGJORYYls3vGabFulZawg5dqFnJtBHR8uTVv5JChtzCdQMgKRrETBXTM4
         v4CWRvXW1eytdJBxmasZ7Sl5z5keYMhl1Ud6Xo6tj97RK1aTBYzn4FvNcfwK9rw8oKYW
         b/PmVC1Xs69AV59kl2eqZluYTehyxp2305OkXNmhkVER2FxUvd3G+um7sjnZ5+4PWjc7
         fakhgs5AW3elM0/ox99LQogDiTVSiUr0avClhh3F40Jgb3f2oE6qCCSn/3kv/Y2nB1sj
         qZvX3MMByPOmImfbNrYOqa8veVtN4nhPbVJlI4IvGdwgcRreeUBSuM3RvysYSmPanlV6
         k8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO4Gj1e5UeqF5ymzTkto2ant13Qz/wNOziFjfJJ5vzg=;
        b=yfs68fURUOzi7GRfgktT3UCx6fs21V8Vevs4ZIHBlfKuxojkrpE+deo60V1Z/SGbdc
         nYkps71IzRWSLq9dUCdCyGYVatsHmC6BT2HyJ9IWH+ys6GHJqckCkQZj0JP6+dXgLea+
         u9I8cZukqqYs+kbLUqyaP2h3pLYWNOPk4lqTwrW66GVzKJshnzY5eZSrk3eZnuAoq8eV
         4MmMkzrZR/sTJahcP37qwa4cPnAmAQcBnRgixHPCprLzahNFL+dS6fbEPMGu4ZDslpyC
         6C8UHquCz3pb4fmzZafi5+8VuKIUNjz/+6vvMivLSXtzBTK6Yj/K8/6qTzZrARQfCxqq
         PcTg==
X-Gm-Message-State: AFqh2kpjEjNycTnoIiUi5ErK/gHZJ004tJ6CgPZW2ZHzKJIsY8acoblR
        jbzszlmYvDXw1aE9ApIAFLyfkQ==
X-Google-Smtp-Source: AMrXdXuLrABAqxvVUWFQdhUFNB2PSrOZj5r257i10/nxLYiRTkQE09v8CTUZ9sd+uDTOJvTVOWeOcw==
X-Received: by 2002:a5d:618a:0:b0:2bc:5115:f072 with SMTP id j10-20020a5d618a000000b002bc5115f072mr1498743wru.50.1673259471158;
        Mon, 09 Jan 2023 02:17:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d5408000000b0027973315213sm8156308wrv.89.2023.01.09.02.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:17:50 -0800 (PST)
Message-ID: <69cd735c-e9b6-7cc7-65d9-c02697797a73@linaro.org>
Date:   Mon, 9 Jan 2023 11:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S tcpci
 driver
Content-Language: en-US
To:     gene_chen@richtek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
 <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 10:31, gene_chen@richtek.com wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Richtek RT1718S is highly integrated TCPC and Power Delivery (PD)
> controller with IEC-ESD Protection on SBU/CC/DP/DM, USB2.0 Switch,
> Charging Port Controller and Power-Path Control.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/usb/typec/tcpm/Kconfig         |   9 +
>  drivers/usb/typec/tcpm/Makefile        |   1 +
>  drivers/usb/typec/tcpm/tcpci_rt1718s.c | 349 +++++++++++++++++++++++++++++++++
>  3 files changed, 359 insertions(+)
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_rt1718s.c
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index e6b88ca..f0efb34 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -27,6 +27,15 @@ config TYPEC_RT1711H
>  	  Type-C Port Controller Manager to provide USB PD and USB
>  	  Type-C functionalities.
>  
> +config TYPEC_RT1718S
> +	tristate "Richtek RT1718S Type-C chip driver"
> +	depends on I2C
> +	help
> +	  Richtek RT1718S Type-C chip driver that works with
> +	  Type-C Port Controller Manager to provide USB PD and USB
> +	  Type-C functionalities.
> +	  Additionally, it supports BC1.2 and power-path control.
> +
>  config TYPEC_MT6360
>  	tristate "Mediatek MT6360 Type-C driver"
>  	depends on MFD_MT6360
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index 906d9dc..db33ffc 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC_WCOVE)		+= typec_wcove.o
>  typec_wcove-y				:= wcove.o
>  obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
>  obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
> +obj-$(CONFIG_TYPEC_RT1718S)		+= tcpci_rt1718s.o
>  obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
>  obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
>  obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1718s.c b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
> new file mode 100644
> index 00000000..305b39c
> --- /dev/null
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 richtek Inc.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/tcpci.h>
> +#include <linux/usb/tcpm.h>
> +#include <linux/usb/pd_vdo.h>
> +
> +#define RT1718S_VID	0x29CF
> +#define RT1718S_PID	0x1718
> +
> +#define RT1718S_P1PREFIX	0x00
> +#define RT1718S_P1START		(RT1718S_P1PREFIX << 8)
> +#define RT1718S_P1END		((RT1718S_P1PREFIX << 8) + 0xFF)
> +#define RT1718S_P2PREFIX	0xF2
> +#define RT1718S_P2START		(RT1718S_P2PREFIX << 8)
> +#define RT1718S_P2END		((RT1718S_P2PREFIX << 8) + 0xFF)
> +
> +#define RT1718S_SYS_CTRL3	0xB0
> +#define RT1718S_SWRESET_MASK	BIT(0)
> +
> +struct rt1718s_chip {
> +	struct tcpci_data tdata;
> +	struct tcpci *tcpci;
> +	struct device *dev;
> +	struct regulator *vbus;
> +	bool src_en;
> +};
> +
> +static bool rt1718s_is_readwrite_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case RT1718S_P1START ... RT1718S_P1END:
> +	fallthrough;
> +	case RT1718S_P2START ... RT1718S_P2END:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config rt1718s_regmap_config = {
> +	.reg_bits		= 16,
> +	.val_bits		= 8,
> +
> +	.reg_format_endian	= REGMAP_ENDIAN_BIG,
> +
> +	/* page 1(TCPC) : 0x00 ~ 0xff, page 2 : 0xf200 ~0xf2ff */
> +	.max_register		= RT1718S_P2END,
> +	.writeable_reg		= rt1718s_is_readwrite_reg,
> +	.readable_reg		= rt1718s_is_readwrite_reg,
> +};
> +
> +static int rt1718s_regmap_read(void *context, const void *reg, size_t reg_size,
> +			      void *val, size_t val_size)

This is not a regmap read... Use true regmap or explain why you cannot
use it.


> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct i2c_msg xfer[2];
> +	int ret;
> +
> +	xfer[0].addr = i2c->addr;
> +	xfer[0].flags = 0;
> +	xfer[0].len = reg_size;
> +	xfer[0].buf = (u8 *)reg;
> +
> +	if (*(u8 *)reg == RT1718S_P1PREFIX) {
> +		xfer[0].len = 1,
> +		xfer[0].buf = (u8 *)(reg + 1);
> +	}
> +
> +	xfer[1].addr = i2c->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = val_size;
> +	xfer[1].buf = (u8 *)val;
> +
> +	ret = i2c_transfer(i2c->adapter, xfer, 2);
> +	//pr_info("wtf i2c_read [0x%04x]:0x%02x\n", *(u16 *)(reg), *(u8 *)val);

That's not a code suitable for mainline submission.

> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 2)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int rt1718s_regmap_write(void *context, const void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct i2c_msg xfer;
> +	int ret;
> +
> +	xfer.addr = i2c->addr;
> +	xfer.flags = 0;
> +	xfer.len = val_size;
> +	xfer.buf = (u8 *)val;
> +
> +	if (*(u8 *)val == RT1718S_P1PREFIX) {
> +		xfer.len = val_size - 1;
> +		xfer.buf = (u8 *)(val + 1);
> +	}
> +
> +	ret = i2c_transfer(i2c->adapter, &xfer, 1);
> +	//pr_info("wtf i2c_write [0x%04x]:0x%02x\n", *(u16 *)(val), *(u8 *)(val+2));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_bus rt1718s_regmap_bus = {
> +	.read	= rt1718s_regmap_read,
> +	.write	= rt1718s_regmap_write,
> +};
> +
> +static const struct reg_sequence rt1718s_init_settings[] = {
> +	/* config I2C timeout reset enable , and timeout to 200ms */
> +	{ 0xBF, 0x8F, 0 },
> +	/* config CC Detect Debounce : 250us (25*val us) */
> +	{ 0xB1, 0x0A, 0 },
> +	/* DRP Toggle Cycle : 76.8ms (51.2 + 6.4*val ms) */
> +	{ 0xB2, 0x04, 0 },
> +	/* DRP Duyt Ctrl : dcSRC: 331/1024 ((val+1)/1024) */
> +	{ 0xB3, 0x4A, 0 },
> +	{ 0xB4, 0x01, 0 },
> +	/* Enable VCONN Current Limit function */
> +	{ 0x8C, 0x41, 0 },
> +	/* Enable cc open 40ms when pmic send vsysuv signal */
> +	{ 0xCA, 0xB3, 0 },
> +	/* Set GPIO2 push-pull, output-low */
> +	{ 0xEE, 0x0C, 0},
> +	/* bg en, low power en, vbus valid detect off, vbus present on, osc off */
> +	{ 0xB8, 0x1A, 0},
> +	/* Link GPIO2 source default vbus to TCPC command */
> +	{ 0xEB, 0x08, 0},
> +	/* Set GPIO2 vbus path */
> +	{ 0xEC, 0x8E, 0 },
> +	/* auto low power timer 2.5s, auto low power en, auto low power mode */
> +	{ 0xF210, 0x35, 0 },
> +	/* Set shipping mode off, AUTOIDLE on with timeout 96ms */
> +	{ 0x8F, 0x7F, 0 },
> +};
> +
> +static int rt1718s_init(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	int ret;
> +
> +	ret = regmap_register_patch(tdata->regmap, rt1718s_init_settings,
> +				    ARRAY_SIZE(rt1718s_init_settings));
> +	pr_info("%s: [TCPC-] ret=%d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static int rt1718s_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			    bool src, bool snk)
> +{
> +	struct rt1718s_chip *chip = container_of(tdata, struct rt1718s_chip, tdata);
> +	int ret;
> +
> +	if (chip->src_en == src)
> +		return 0;
> +
> +	if (src)
> +		ret = regulator_enable(chip->vbus);
> +	else
> +		ret = regulator_disable(chip->vbus);
> +
> +	if (!ret)
> +		chip->src_en = src;
> +	return ret;
> +}
> +
> +static irqreturn_t rt1718s_irq(int irq, void *dev_id)
> +{
> +	struct rt1718s_chip *chip = dev_id;
> +
> +	return tcpci_irq(chip->tcpci);
> +}
> +
> +static int rt1718s_sw_reset(struct rt1718s_chip *chip)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->tdata.regmap, RT1718S_SYS_CTRL3,
> +				 RT1718S_SWRESET_MASK, RT1718S_SWRESET_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait for IC to reset done*/
> +	usleep_range(1000, 2000);
> +

This entire code is so close to rt1711, that it does not make much sense
to keep two drivers. Please work on existing driver to improve it -
clean it up, add regmap patch maybe also regmap fields. Then add rt1718
support to it.


Best regards,
Krzysztof

