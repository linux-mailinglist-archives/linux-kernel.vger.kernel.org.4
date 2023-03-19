Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A546C01F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCSNKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCSNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:10:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544E132F2;
        Sun, 19 Mar 2023 06:10:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so13757006pjg.4;
        Sun, 19 Mar 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679231442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLV/C9BVV9L3gz7SqQlBG1nu7+PDr0QAoiDS9XAhY5U=;
        b=LsfW3r0gzx4zRDoPDqtP0R3Sju8Gt6D0O3U2LngFKEGGU7bMKLkuU2FgMyIoEWCM7t
         33il/GKgZq6r9Gfskln7u/MEpUknDV5HdBaQOtpnKilpV/2MDNMJFq5XhH14Yp6RuL62
         TdLYuqt09q3DUQ5+GujMC9z4VNkDyQ8leGl1GgI/m3/ueGeiqZeCYhcPON+haLV4HTfk
         v+EJsz7QRmZulpGZwxcJOS7GFVQ+g/HK0i6P+uKMsKGus94RVFGAzR7mnu3oG06cICv1
         YXygtBKjCXWGtHH13L+Nn8DiW6IKClSbTnYMJ3iCkkb9Lc/3YgnUvCs4oGEd0mlNuc2y
         +jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679231442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLV/C9BVV9L3gz7SqQlBG1nu7+PDr0QAoiDS9XAhY5U=;
        b=XJoT8/0VpYpZLnary79eVBZ5PDR7M6AVKm1zTa+ZWmQmEdnxaNi3SBZvFcluqv6pgF
         nlUZbxIXuTwDoIF8qHIe5NO1mtscKL9s9RSXc+qY5IUsg5+FFbj6W6SaCi1QzqHrSYhj
         Y+B2CeDuODmu8mDW+2GPzBAz/Z4nQWPnUTa1foHxw6ym9V2RBZFzeFxd2X4LQ69Z40U5
         hBzZ8e7RL2mrQPWy5qD9oMwTma7h15pN8pL+CP5DEJCZ77gJtGOikX2BKgkmGGMIRXic
         m3+VVpxTZ15SyQKMlJJ4Q2IBSgbXcmqmQXgRVUubuF+f9o9SjZYD44IvvgaAMVjTAOJa
         wU2Q==
X-Gm-Message-State: AO0yUKXwgG4XTz8duEotpYJW2pZSRe/bYLM6pNDwSeKBiTCQMQ1qmC0r
        oiR7o2/+u+5kGuCpCf/RLA4=
X-Google-Smtp-Source: AK7set/8pDZJ92hFuJsI+mImmxHdpop3JmOCGM9I7cygbpyUBtGYZ5oYM2qUt8HsVoUlP2WXrObAdw==
X-Received: by 2002:a17:902:f94f:b0:1a1:8d80:e0b9 with SMTP id kx15-20020a170902f94f00b001a18d80e0b9mr12346086plb.52.1679231442138;
        Sun, 19 Mar 2023 06:10:42 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0019edd34dac9sm4732208plp.60.2023.03.19.06.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 06:10:41 -0700 (PDT)
Message-ID: <7ea61a55-936c-659f-79b3-9ccdf9c3db46@gmail.com>
Date:   Sun, 19 Mar 2023 21:10:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/15] reset: Add Nuvoton ma35d1 reset driver support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-14-ychuang570808@gmail.com>
 <1c943355-e9c0-3b23-4437-4040fa18b9fa@linux.intel.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <1c943355-e9c0-3b23-4437-4040fa18b9fa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilpo,


On 2023/3/16 下午 11:05, Ilpo Järvinen wrote:
> On Wed, 15 Mar 2023, Jacky Huang wrote:
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This driver supports individual IP reset for ma35d1. The reset
>> control registers is a subset of system control registers.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   drivers/reset/Kconfig        |   6 ++
>>   drivers/reset/Makefile       |   1 +
>>   drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 159 insertions(+)
>>   create mode 100644 drivers/reset/reset-ma35d1.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 2a52c990d4fe..47671060d259 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -143,6 +143,12 @@ config RESET_NPCM
>>   	  This enables the reset controller driver for Nuvoton NPCM
>>   	  BMC SoCs.
>>   
>> +config RESET_NUVOTON_MA35D1
>> +	bool "Nuvton MA35D1 Reset Driver"
>> +	default ARCH_NUVOTON
>> +	help
>> +	  This enables the reset controller driver for Nuvoton MA35D1 SoC.
>> +
>>   config RESET_OXNAS
>>   	bool
>>   
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 3e7e5fd633a8..fd52dcf66a99 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>>   obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>   obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>>   obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
>> +obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
>>   obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>>   obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>>   obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
>> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
>> new file mode 100644
>> index 000000000000..bdd39483ca4e
>> --- /dev/null
>> +++ b/drivers/reset/reset-ma35d1.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/mfd/ma35d1-sys.h>
>> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reboot.h>
>> +
>> +#define RST_PRE_REG	32
>> +
>> +struct ma35d1_reset_data {
>> +	struct reset_controller_dev rcdev;
>> +	struct regmap *regmap;
>> +};
>> +
>> +struct ma35d1_reboot_data {
>> +	struct notifier_block restart_handler;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static int ma35d1_restart_handler(struct notifier_block *this,
>> +				  unsigned long mode, void *cmd)
>> +{
>> +	struct ma35d1_reboot_data *data =
>> +			container_of(this, struct ma35d1_reboot_data,
>> +				     restart_handler);
>> +	regmap_write(data->regmap, REG_SYS_IPRST0, 1 << MA35D1_RESET_CHIP);
>> +	return -EAGAIN;
> This results -EAGAIN always???


The chip will reset immediately after the write to REG_SYS_IPRST0.

The return line should never be executed. If yes, it must be failed to 
reset.

Anyway, I will modify it as

return regmap_write(data->regmap, REG_SYS_IPRST0, 1 << MA35D1_RESET_CHIP);

>
>> +}
>> +
>> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
>> +			      unsigned long id, bool assert)
>> +{
>> +	int reg;
>> +	int offset = (id / RST_PRE_REG) * 4;
>> +	struct ma35d1_reset_data *data =
>> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
>> +
>> +	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
>> +	if (assert)
>> +		reg |= 1 << (id % RST_PRE_REG);
>> +	else
>> +		reg &= ~(1 << (id % RST_PRE_REG));
>> +
>> +	regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);
>> +	return 0;
> This returns always 0. What about regmap_read/write() errors, should the
> be returned?


I will modify it as

return regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);

And add return value check to the regmap_read().


>> +}
>> +
>> +static int ma35d1_reset_assert(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +	return ma35d1_reset_update(rcdev, id, true);
>> +}
>> +
>> +static int ma35d1_reset_deassert(struct reset_controller_dev *rcdev,
>> +				 unsigned long id)
>> +{
>> +	return ma35d1_reset_update(rcdev, id, false);
>> +}
>> +
>> +static int ma35d1_reset_status(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	int reg;
>> +	int offset = id / RST_PRE_REG;
>> +	struct ma35d1_reset_data *data =
>> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
>> +
>> +	regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
> Error handling?

I will modify it as

     ret = regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
     if (ret < 0)
         return ret;

>
>> +	return !!(reg & BIT(id % RST_PRE_REG));
>> +}
>> +
>> +static const struct reset_control_ops ma35d1_reset_ops = {
>> +	.assert = ma35d1_reset_assert,
>> +	.deassert = ma35d1_reset_deassert,
>> +	.status = ma35d1_reset_status,
>> +};
>> +
>> +static const struct of_device_id ma35d1_reset_dt_ids[] = {
>> +	{ .compatible = "nuvoton,ma35d1-reset" },
>> +	{ },
>> +};
>> +
>> +static int ma35d1_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ma35d1_reset_data *reset_data;
>> +	struct ma35d1_reboot_data *reboot_data;
>> +	int err;
>> +
>> +	if (!pdev->dev.of_node) {
>> +		dev_err(&pdev->dev, "Device tree node not found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
>> +	if (!reset_data)
>> +		return -ENOMEM;
>> +
>> +	reboot_data = devm_kzalloc(dev, sizeof(*reboot_data), GFP_KERNEL);
>> +	if (!reboot_data) {
>> +		devm_kfree(dev, reset_data);
> Unnecessary.


OK, I will remove this devm_kfree().


>> +		return -ENOMEM;
>> +	}
>> +
>> +	reset_data->regmap  = syscon_regmap_lookup_by_phandle(
>> +			      pdev->dev.of_node, "regmap");
>> +	if (IS_ERR(reset_data->regmap)) {
>> +		dev_err(&pdev->dev, "Failed to get SYS register base\n");
>> +		err = PTR_ERR(reset_data->regmap);
>> +		goto err_out;
>> +	}
>> +	reset_data->rcdev.owner = THIS_MODULE;
>> +	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
>> +	reset_data->rcdev.ops = &ma35d1_reset_ops;
>> +	reset_data->rcdev.of_node = dev->of_node;
>> +
>> +	reboot_data->regmap = reset_data->regmap;
>> +	reboot_data->restart_handler.notifier_call = ma35d1_restart_handler;
>> +	reboot_data->restart_handler.priority = 192;
>> +
>> +	err = register_restart_handler(&reboot_data->restart_handler);
>> +	if (err)
>> +		dev_warn(&pdev->dev, "failed to register restart handler\n");
>> +
>> +	return devm_reset_controller_register(dev, &reset_data->rcdev);
>> +
>> +err_out:
>> +	devm_kfree(dev, reset_data);
>> +	devm_kfree(dev, reboot_data);
> These are unnecessary since the probe is failing.


OK, I will make it just return err.

>
>> +	return err;
>> +}
>> +
>> +static struct platform_driver ma35d1_reset_driver = {
>> +	.probe = ma35d1_reset_probe,
>> +	.driver = {
>> +		.name = "ma35d1-reset",
>> +		.of_match_table	= ma35d1_reset_dt_ids,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(ma35d1_reset_driver);
>>
Best regards,

Jacky Huang

