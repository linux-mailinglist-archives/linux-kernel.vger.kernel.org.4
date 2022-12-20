Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C90652302
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiLTOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLTOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:47:47 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768B5F4B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:47:46 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f20so12618878lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kU00r8HmTWZJQm/Mx8OuL4ym3gMAG1jmhI/rjAXh8YA=;
        b=J2g1rtmOAGLjZAsVVsoAsaw+NO1QTiBaSVp5aII+UjygYrwqMUlJvLvQi2RKXVGG/L
         YyL0JuovvIOHfU3toyJ42j2UEa5WBddAis5mBWkSOB+HzeQrY6wRTxHyAN0GlJa+FtcQ
         vCZ/dp02KfiQhXls8N6hxy3X5OB9dBGGn23ROJAP2XKQIMHROcXrTVTo801WCCnULJN1
         5tSTvilbeFYEaZrg9UW9olJPvpZXsB+XhNVO20KJU6DjzRD0i49zUPJtX6ZoQkFq1oLZ
         HYm5NS/bZfWBdzRP2ZAbP4SFjepqsPlPRRj7KZ9tHwkFSzPDWdLsiszg+3WmsMKzbTm4
         n8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU00r8HmTWZJQm/Mx8OuL4ym3gMAG1jmhI/rjAXh8YA=;
        b=z8NvDRQe9ZCykWgpJHdx828y3g7K3v5J4niWX8zkg+mg36iA2yI4TefD8WwSqV70q/
         VHrSbHgOi9NZ9I5Q5LkTggV2T0pKV4He+SOep9H0FafLlwC2URxBeuVBI9plprfPFeez
         mPWx1HcyGeKFSKcRZjQAytMEP4r/tcTuqUQgJAmMXUZONsU2DNw45J3JUHsC0WwaKspg
         jlnPmcDCyFB0xYTwCo10QLj4XbUNgsVq+/BvIRAi0iHkYgKUqxbYGoQ35LbUKdKnDCFz
         5EtVfTeGQ/dcmVlik4pC7tR6KrN3a59aBnDpkeAz8+/uONXIzYE4woEHRq8lpcPNAsYZ
         t2xQ==
X-Gm-Message-State: AFqh2krxf4CYp0NpNB+f+c6SqOcYHeaExnK2P3h7e1noM9kNd4rIXF4A
        +SVgHDWG1auc6E6eAz1i+a7WDg==
X-Google-Smtp-Source: AMrXdXs4KTuvzMqk9vONZLoHrCk8DmY001sv+Fs7gJ1IOd39xo22dkvBhz7WDXQP40qHXho+i12tQg==
X-Received: by 2002:a05:651c:1111:b0:27f:93a0:45e with SMTP id e17-20020a05651c111100b0027f93a0045emr748341ljo.17.1671547664337;
        Tue, 20 Dec 2022 06:47:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u24-20020a2e9b18000000b00279ff5d5e10sm1031144lji.38.2022.12.20.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:47:43 -0800 (PST)
Message-ID: <cc54d945-9530-8918-c9fd-4c048be83bd9@linaro.org>
Date:   Tue, 20 Dec 2022 15:47:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/6] drivers: mfd: add MAX77659 PMIC support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-2-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220132250.19383-2-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 14:22, Zeynep Arslanbenzer wrote:
> This patch adds MFD driver for MAX77659 to enable its sub
> devices.
> 
> The MAX77659 is a multi-function devices. It includes
> charger and regulator
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  MAINTAINERS                  |   8 ++
>  drivers/mfd/Kconfig          |  14 +++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77659.c       | 188 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77659.h |  60 +++++++++++
>  5 files changed, 271 insertions(+)
>  create mode 100644 drivers/mfd/max77659.c
>  create mode 100644 include/linux/mfd/max77659.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a608f19da3a9..45a8a471c7c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12640,6 +12640,14 @@ F:	drivers/power/supply/max77650-charger.c
>  F:	drivers/regulator/max77650-regulator.c
>  F:	include/linux/mfd/max77650.h


> +	ret = regmap_read(me->regmap, MAX77659_REG_INT_CHG, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to read Charger Interrupt Status register\n");
> +	ret = device_init_wakeup(dev, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
> +
> +	ret = devm_mfd_add_devices(dev, -1, max77659_devs, ARRAY_SIZE(max77659_devs),
> +				   NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add sub-devices\n");
> +
> +	enable_irq_wake(me->irq);

You do not allow a wakeup-source in DT, do you?

> +
> +	return 0;
> +}
> +
> +static int max77659_i2c_probe(struct i2c_client *client)
> +{
> +	struct max77659_dev *me;

Do you see other MFD driver calling this "me"? Please submit code which
is consistent with Linux style, not with your own.

> +
> +	me = devm_kzalloc(&client->dev, sizeof(*me), GFP_KERNEL);
> +	if (!me)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, me);
> +	me->dev = &client->dev;
> +	me->irq = client->irq;
> +
> +	me->regmap = devm_regmap_init_i2c(client, &max77659_regmap_config);
> +
> +	if (IS_ERR(me->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(me->regmap),
> +				     "Failed to allocate register map\n");
> +
> +	return max77659_pmic_setup(me);
> +}
> +
> +static const struct of_device_id max77659_of_id[] = {
> +	{ .compatible = "adi,max77659" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max77659_of_id);
> +
> +static const struct i2c_device_id max77659_i2c_id[] = {
> +	{ MAX77659_NAME, 0 },

Nope. Use proper string.

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max77659_i2c_id);
> +
> +static struct i2c_driver max77659_i2c_driver = {
> +	.driver = {
> +		.name = MAX77659_NAME,
> +		.of_match_table = of_match_ptr(max77659_of_id),

You will have warnings here, so the patch was not really compile tested.
Drop of_match_ptr() and check your code before sending (W=1, smatch,
sparse, coccinelle)

> +	},
> +	.probe_new = max77659_i2c_probe,
> +	.id_table = max77659_i2c_id,
> +};
> +
> +module_i2c_driver(max77659_i2c_driver);
> +
> +MODULE_DESCRIPTION("max77659 MFD Driver");
> +MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");
> diff --git a/include/linux/mfd/max77659.h b/include/linux/mfd/max77659.h
> new file mode 100644
> index 000000000000..ef781e6e54c2
> --- /dev/null
> +++ b/include/linux/mfd/max77659.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MAX77659_MFD_H__
> +#define __MAX77659_MFD_H__

Header guard should be more descriptive (with pieces of path)

> +
> +#include <linux/bits.h>
> +
> +#define MAX77659_NAME "max77659"

Not really for include.

> +
> +#define MAX77659_REGULATOR_NAME MAX77659_NAME "-regulator"
> +#define MAX77659_CHARGER_NAME MAX77659_NAME "-charger"

Neither these.

> +
> +#define MAX77659_REG_INT_GLBL0 0x00
> +#define MAX77659_REG_INT_CHG 0x01
> +#define MAX77659_REG_INT_GLBL1 0x04
> +#define MAX77659_REG_INT_M_CHG 0x07
> +#define MAX77659_REG_INTM_GLBL1 0x08
> +#define MAX77659_REG_INTM_GLBL0 0x09

That's absolutely unreadable code.

> +
> +#define MAX77659_INT_GLBL0_MASK 0xFF
> +#define MAX77659_INT_GLBL1_MASK 0x33
> +
> +#define MAX77659_BIT_INT_GLBL0_GPIO0_F BIT(0)
> +#define MAX77659_BIT_INT_GLBL0_GPIO0_R BIT(1)
> +#define MAX77659_BIT_INT_GLBL0_EN_F BIT(2)
> +#define MAX77659_BIT_INT_GLBL0_EN_R BIT(3)
> +#define MAX77659_BIT_INT_GLBL0_TJAL1_R BIT(4)
> +#define MAX77659_BIT_INT_GLBL0_TJAL2_R BIT(5)
> +#define MAX77659_BIT_INT_GLBL0_DOD0_R BIT(7)
> +
> +#define MAX77659_BIT_INT_GLBL1_GPI1_F BIT(0)
> +#define MAX77659_BIT_INT_GLBL1_GPI1_R BIT(1)
> +#define MAX77659_BIT_INT_GLBL1_SBB_TO BIT(4)
> +#define MAX77659_BIT_INT_GLBL1_LDO0_F BIT(5)
> +
> +#define MAX77659_BIT_INT_THM BIT(0)
> +#define MAX77659_BIT_INT_CHG BIT(1)
> +#define MAX77659_BIT_INT_CHGIN BIT(2)
> +#define MAX77659_BIT_INT_TJ_REG BIT(3)
> +#define MAX77659_BIT_INT_SYS_CTRL BIT(4)
> +
> +enum {
> +	MAX77659_DEV_PMIC,
> +	MAX77659_DEV_CHARGER,
> +	MAX77659_DEV_REGULATOR,
> +	MAX77659_NUM_DEVS,
> +};
> +
> +struct max77659_dev {
> +	struct device *dev;
> +
> +	int irq;
> +	struct regmap_irq_chip_data *irqc_glbl0;
> +	struct regmap_irq_chip_data *irqc_glbl1;
> +	struct regmap_irq_chip_data	*irqc_chg;

Keep your code consistent.

> +
> +	struct regmap *regmap;
> +};
> +
> +#endif /* __MAX77659_MFD_H__ */

Best regards,
Krzysztof

