Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB153662F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjAISwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAISwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:52:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE1A449;
        Mon,  9 Jan 2023 10:52:30 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i127so7961580oif.8;
        Mon, 09 Jan 2023 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jd3Uu3Mu5rvlxt8hj7QGe0WuZLvN2KqmOkrvQkhOIDI=;
        b=GBvjzdLLe6Cao75ZsLyOLTw1IL8cOmoB/EvsSPWpocdRzgLa4940HwXjG6KBZv7CeV
         O+eS299NCG6jpkriSNf4c19wcYGL8sdIrOWzLV5IjS7XNz0FkU0r/9GRs0ss8EBZ1ud7
         SHsz5CbyJVZDKlklsAmgtqcbv2xnAJVfNs1XMu84Ot2BV2TfRYs4kuewcXXSIFBiwLlQ
         CnE9mioJbOzNoI9GP6xvpSUGuzo+tLxDVrsKtVAuAeIc4RtmbtZBs0HSJTX2Rn2NZIfN
         M4+Dkfz2LUVCvqiiseY2GS910CNj7DrFl2J7AUXok/8bFGVDEcqc7XYTzesMT1CwVQ7F
         3+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd3Uu3Mu5rvlxt8hj7QGe0WuZLvN2KqmOkrvQkhOIDI=;
        b=TJE7tnolIuVFpZOZx3WImbeTM9bfCC8ItaxnZBHg/lgD5C2kqPQChu+OrGBphCOqqg
         4EudEBAoVeqmVOq+gFT59QxSGU5g/y1WWmGLWfGUoEiH2kyU44rfDazEm+RfA9cwZjnZ
         qseKX0/bSgw0nRCtzwxEolDS/af81ZQSkHWNhG3TWPuzL7L4gKTA1VTpNxBr+igGAors
         WkAFxd50LtSh2QGk45S3msBglZsx/E+LjDLDzgwy/iKYKKx7IHSrvmRRyhxaBZtLZNPX
         0C1sOXJnY/9KrlHDdZoSp5Uasl+dJB+yc3JKoxsCP1waM1CIHC5SN7BOzUe36Dkuy8ju
         oppw==
X-Gm-Message-State: AFqh2kp62povFm1Zhb7F1YvISF+wx1M37SqRv5r3Tpna9iOAZ6equiqw
        uWpHACfSvE+9PRlGraWoXR4=
X-Google-Smtp-Source: AMrXdXtRwq3/9JK6jRIkfVXQYSvPsJXOuFwfWvtIaqy2hOvUfM1yAM2uvYNCgXM6B6dk1Vg/U/UfWw==
X-Received: by 2002:a05:6808:a06:b0:355:1de9:6524 with SMTP id n6-20020a0568080a0600b003551de96524mr36580010oij.6.1673290349222;
        Mon, 09 Jan 2023 10:52:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a0568080ab000b0035bce2a39c7sm4246812oij.21.2023.01.09.10.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:52:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46838aa3-9747-e2e9-a982-6a3b349f853d@roeck-us.net>
Date:   Mon, 9 Jan 2023 10:52:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     gene_chen@richtek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
 <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S tcpci
 driver
In-Reply-To: <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 01:31, gene_chen@richtek.com wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Richtek RT1718S is highly integrated TCPC and Power Delivery (PD)
> controller with IEC-ESD Protection on SBU/CC/DP/DM, USB2.0 Switch,
> Charging Port Controller and Power-Path Control.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/Kconfig         |   9 +
>   drivers/usb/typec/tcpm/Makefile        |   1 +
>   drivers/usb/typec/tcpm/tcpci_rt1718s.c | 349 +++++++++++++++++++++++++++++++++
>   3 files changed, 359 insertions(+)
>   create mode 100644 drivers/usb/typec/tcpm/tcpci_rt1718s.c
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index e6b88ca..f0efb34 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -27,6 +27,15 @@ config TYPEC_RT1711H
>   	  Type-C Port Controller Manager to provide USB PD and USB
>   	  Type-C functionalities.
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
>   config TYPEC_MT6360
>   	tristate "Mediatek MT6360 Type-C driver"
>   	depends on MFD_MT6360
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index 906d9dc..db33ffc 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC_WCOVE)		+= typec_wcove.o
>   typec_wcove-y				:= wcove.o
>   obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
>   obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
> +obj-$(CONFIG_TYPEC_RT1718S)		+= tcpci_rt1718s.o
>   obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
>   obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
>   obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
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

Unnecessary (and bad indentation).

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

Unnecessary typecast

> +
> +	if (*(u8 *)reg == RT1718S_P1PREFIX) {
> +		xfer[0].len = 1,
> +		xfer[0].buf = (u8 *)(reg + 1);

Pointer arithmetic on void * (see below).

> +	}

There is a lot of context here which needs explanation. The code extracts
the upper 8 bit of the register address and drops it if the value is 0.
So the address is either 8 bit or 16 bit depending on the register address.
Also, this only works because reg_format_endian is set to big endian.

This really needs to be documented.

Assigning the values to len and buf twice is really bad style.
Please use if/else.

> +
> +	xfer[1].addr = i2c->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = val_size;
> +	xfer[1].buf = (u8 *)val;

This typecast should be unnecessary.

> +
> +	ret = i2c_transfer(i2c->adapter, xfer, 2);
> +	//pr_info("wtf i2c_read [0x%04x]:0x%02x\n", *(u16 *)(reg), *(u8 *)val);

No code comments in release code.

> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 2)

else after return is unencessary.

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

That typecast should be unnecessary.

> +
> +	if (*(u8 *)val == RT1718S_P1PREFIX) {
> +		xfer.len = val_size - 1;
> +		xfer.buf = (u8 *)(val + 1);
> +	}
> +

Same comments as above. Also, typecast seems wrong. Shouldn't it be
((u8 *)val) + 1) ? My memory may defeat me, but I think that pointer
arithmetic on void * is undefined or even illegal.


> +	ret = i2c_transfer(i2c->adapter, &xfer, 1);
> +	//pr_info("wtf i2c_write [0x%04x]:0x%02x\n", *(u16 *)(val), *(u8 *)(val+2));

No comented out code.

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

This needs documentation: Why not use standard regmap functions ?
Yes, I know, it is because of the ubusual addressing format used by
the chip, but it still needs to be explained. Not everyone should
have to read the datasheet to understand the code.

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

Drop the noise. This is unacceptable in production code.

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

"RT1718S will not response to the I2C commands for 2ms after writing SOFT_RESET"

Timeout needs to be at least 2 ms.

> +	return 0;
> +}
> +
> +static int rt1718s_check_chip_exist(struct i2c_client *i2c)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != RT1718S_VID) {
> +		dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != RT1718S_PID) {
> +		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static int rt1718s_probe(struct i2c_client *i2c)
> +{
> +	struct rt1718s_chip *chip;
> +	struct gpio_desc *gpiod;
> +	int ret;
> +	u16 clr_events = 0;
> +
> +	ret = rt1718s_check_chip_exist(i2c);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "check vid/pid fail(%d)\n", ret);

Double error message.

> +		return ret;
> +	}
> +
> +	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &i2c->dev;
> +
> +	chip->tdata.regmap = devm_regmap_init(&i2c->dev,
> +					      &rt1718s_regmap_bus, &i2c->dev,
> +					      &rt1718s_regmap_config);
> +	if (IS_ERR(chip->tdata.regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(chip->tdata.regmap),
> +				     "Failed to init regmap\n");
> +
> +	chip->vbus = devm_regulator_get(&i2c->dev, "vbus");
> +	if (IS_ERR(chip->vbus))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(chip->vbus),
> +				     "Failed to get vbus regulator\n");
> +
> +	ret = rt1718s_sw_reset(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_raw_write(chip->tdata.regmap, TCPC_ALERT_MASK, &clr_events,
> +			       sizeof(clr_events));
> +
> +	chip->tdata.init = rt1718s_init;
> +	chip->tdata.set_vbus = rt1718s_set_vbus;
> +	chip->tcpci = tcpci_register_port(&i2c->dev, &chip->tdata);
> +	if (IS_ERR(chip->tcpci))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(chip->tcpci),
> +				     "Failed to register tcpci port\n");
> +
> +	/* for platform set gpio default inpull_high */
> +	gpiod = devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(gpiod),
> +				     "Failed to get gpio\n");
> +
> +	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
> +					rt1718s_irq, IRQF_ONESHOT,
> +					dev_name(&i2c->dev), chip);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to register irq\n");
> +		tcpci_unregister_port(chip->tcpci);
> +		return ret;
> +	}
> +
> +	device_init_wakeup(&i2c->dev, true);
> +	i2c_set_clientdata(i2c, chip);
> +
> +	dev_info(&i2c->dev, "%s:successfully\n", __func__);

Nore logging noise.

> +	return 0;
> +}
> +
> +static void rt1718s_remove(struct i2c_client *i2c)
> +{
> +	struct rt1718s_chip *chip = i2c_get_clientdata(i2c);
> +
> +	tcpci_unregister_port(chip->tcpci);
> +}
> +
> +static int __maybe_unused rt1718s_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(i2c->irq);
> +	disable_irq(i2c->irq);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rt1718s_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(i2c->irq);
> +	enable_irq(i2c->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rt1718s_pm_ops, rt1718s_suspend, rt1718s_resume);
> +
> +static const struct of_device_id __maybe_unused rt1718s_of_id[] = {
> +	{ .compatible = "richtek,rt1718s", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt1718s_of_id);
> +
> +static struct i2c_driver rt1718s_i2c_driver = {
> +	.driver = {
> +		.name = "rt1718s",
> +		.pm = &rt1718s_pm_ops,
> +		.of_match_table = rt1718s_of_id,
> +	},
> +	.probe_new = rt1718s_probe,
> +	.remove = rt1718s_remove,
> +};
> +module_i2c_driver(rt1718s_i2c_driver);
> +
> +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> +MODULE_DESCRIPTION("RT1718S USB Type-C Port Controller Interface Driver");
> +MODULE_LICENSE("GPL");

