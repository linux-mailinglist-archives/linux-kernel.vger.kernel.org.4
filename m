Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53798652323
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiLTOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiLTOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:51:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6A1C939
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:51:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so18938824lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ6KaHi75k7hslKEczPE6jdSSbathFtT5N/f9Qh43gc=;
        b=EirFstawQ56PafvHL5iiKrXMsDk7lOs85HjxV2+AKKUbCLYDX+d4c63yPDhIYLfHJ6
         yHacJjWmeJeF7pQ+gPkYvCJVfletFtjUhQEMnUoWKtThcwaW5SnK/Qlro+lskODaN8CQ
         bHUciNP9PdTjk0R7GsBDkeqjoR94XmPkXwX7mZWu6wFbvLaDaobB5kKuGYxSjlOxJmyF
         KTiV3jrsAqL4bxWgs1wi0MsMUjjbXPIVhKI8fgLBtWHd1M79yq+JWI4xkx3iCDM9WRQ+
         +6Oad0CNTdGbY8LgalEN3zy186DyS/AWZS0fHEU7AH3FWSVhr7teMkw8bnGkslOLHvn8
         jKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ6KaHi75k7hslKEczPE6jdSSbathFtT5N/f9Qh43gc=;
        b=wLlvjtq5t2CJnpgDi3zuqdXceaJ/z/eVrHW9xRl3zahWMvMZKr7ZIOb57Z872dF7IW
         bNr18ljAMTVom2xX5aVR8wjDLZkp0wpmVFysn2KhfvZr2ant+GOs5UN5LGC9nJYEelpK
         LKaGnONISMcPKZfV7elOx02wfelL/D96oYNm+nnEUQvz4vATfYMiAbOB/yPiCttT+vsT
         V0Dqzwkgq9W/YFK/DpmPpkCyiivRHKLQCdApbHYOB/PEqYEAXl4oSZYLBjJGRexdUeSZ
         l+TPYUNa3keEfbggJofKRBs0x6T0JoKNYcSHOkV8cIRECKaqGO2x4j/DRqGSOvcwPKn3
         wjoQ==
X-Gm-Message-State: ANoB5pnSnMLr1NYzZP3VV7DKiqmPcTM11sbsbz69GKdDhZN/VDIDlHmL
        G2sVSjkWCKY+hpaSb3mk8lnUSQ==
X-Google-Smtp-Source: AA0mqf4PWbYbwlovhkrxJhk++9dCpoEZdBjRBmjafBDAvr/8gvq1q9PeSInVSC6L2lVp/QuHxCFWVg==
X-Received: by 2002:ac2:4f8e:0:b0:4b3:e164:a635 with SMTP id z14-20020ac24f8e000000b004b3e164a635mr10481237lfs.17.1671547878148;
        Tue, 20 Dec 2022 06:51:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512074700b004b5a4cf69dfsm1490664lfs.261.2022.12.20.06.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:51:17 -0800 (PST)
Message-ID: <9915e079-c6b5-a8f4-734e-f0325809efd0@linaro.org>
Date:   Tue, 20 Dec 2022 15:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] drivers: power: supply: add MAX77659 charger support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-4-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220132250.19383-4-Zeynep.Arslanbenzer@analog.com>
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
> This patch adds battery charger driver for MAX77659.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  MAINTAINERS                             |   1 +
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77659-charger.c | 547 ++++++++++++++++++++++++
>  4 files changed, 556 insertions(+)
>  create mode 100644 drivers/power/supply/max77659-charger.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7a9cadf0ff2..b3e307163063 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12647,6 +12647,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/adi,max77659.yaml
>  F:	drivers/mfd/max77659.c
> +F:	drivers/power/supply/max77659-charger.c
>  F:	include/linux/mfd/max77659.h
>  
>  MAXIM MAX77714 PMIC MFD DRIVER
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 0bbfe6a7ce4d..d38ef40ae9ee 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -565,6 +565,13 @@ config CHARGER_MAX77650
>  	  Say Y to enable support for the battery charger control of MAX77650
>  	  PMICs.
>  
> +config CHARGER_MAX77659
> +	tristate "Analog Devices MAX77659 battery charger driver"
> +	depends on MFD_MAX77659
> +	help
> +	  Say Y to enable support for the battery charger control of MAX77659
> +	  PMICs.
> +
>  config CHARGER_MAX77693
>  	tristate "Maxim MAX77693 battery charger driver"
>  	depends on MFD_MAX77693
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 0ee8653e882e..e8646896bcd2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_CHARGER_LTC4162L)	+= ltc4162-l-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
> +obj-$(CONFIG_CHARGER_MAX77659)	+= max77659-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
> diff --git a/drivers/power/supply/max77659-charger.c b/drivers/power/supply/max77659-charger.c
> new file mode 100644
> index 000000000000..dfdbd484f7cd
> --- /dev/null
> +++ b/drivers/power/supply/max77659-charger.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77659.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77659_IRQ_WORK_DELAY 0
> +#define MAX77659_CHARGER_CURRENT_MAX 300000
> +#define MAX77659_CHARGER_CURRENT_MIN 7500
> +#define MAX77659_CHARGER_CURRENT_STEP 7500
> +#define MAX77659_CHARGER_TOPOFF_TIMER_STEP 5
> +
> +#define MAX77659_REG_STAT_CHG_A 0x02

Same problems as your other patch - unreadable code. Two different
coding styles...

> +#define MAX77659_REG_STAT_CHG_B 0x03
> +#define MAX77659_REG_CNFG_CHG_A 0x20
> +#define MAX77659_REG_CNFG_CHG_B 0x21
> +#define MAX77659_REG_CNFG_CHG_C 0x22
> +#define MAX77659_REG_CNFG_CHG_D 0x23
> +#define MAX77659_REG_CNFG_CHG_E 0x24
> +#define MAX77659_REG_CNFG_CHG_F 0x25
> +#define MAX77659_REG_CNFG_CHG_G 0x26
> +#define MAX77659_REG_CNFG_CHG_H 0x27
> +#define MAX77659_REG_CNFG_CHG_I 0x28
> +
> +#define MAX77659_BIT_STAT_A_VSYSY_MIN_STAT	BIT(4)
> +#define MAX77659_BIT_STAT_A_TJ_REG_STAT		BIT(3)
> +#define MAX77659_BIT_STAT_A_THM_DTLS		GENMASK(2, 0)
> +#define MAX77659_BIT_STAT_B_CHG_DTLS		GENMASK(7, 4)
> +#define MAX77659_BIT_STAT_B_CHGIN_DTSL		GENMASK(3, 2)
> +#define MAX77659_BIT_STAT_B_CHG			BIT(1)
> +#define MAX77659_BIT_CNFG_B_CHG_EN		BIT(0)
> +#define MAX77659_BIT_CNFG_C_TOPOFFTIMER		GENMASK(2, 0)
> +#define MAX77659_BIT_CNFG_E_CC			GENMASK(7, 2)
> +#define MAX77659_BIT_CNFG_E_TFASTCHG		GENMASK(1, 0)
> +#define MAX77659_BIT_CNFG_G_CHG_CV		GENMASK(7, 2)
> +

(...)

> +
> +	charger->psy_chg_d.name = MAX77659_CHARGER_NAME;
> +	charger->psy_chg_d.type = POWER_SUPPLY_TYPE_UNKNOWN;
> +	charger->psy_chg_d.get_property	= max77659_charger_get_property;
> +	charger->psy_chg_d.set_property	= max77659_charger_set_property;
> +	charger->psy_chg_d.properties = max77659_charger_props;
> +	charger->psy_chg_d.property_is_writeable = max77659_property_is_writeable;
> +	charger->psy_chg_d.num_properties = ARRAY_SIZE(max77659_charger_props);
> +	charger_cfg.drv_data = charger;
> +	charger_cfg.supplied_to = chg_supplied_to;
> +	charger_cfg.of_node = dev->of_node;
> +	charger_cfg.num_supplicants = ARRAY_SIZE(chg_supplied_to);
> +
> +	ret = max77659_charger_initialize(charger);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize charger\n");
> +
> +	for (i = 0; i < MAX77659_CHG_IRQ_MAX; i++) {
> +		charger->irq_arr[i] = regmap_irq_get_virq(max77659->irqc_chg, i);
> +
> +		if (charger->irq_arr[i] < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid IRQ for MAX77659_CHG_IRQ %d\n", i);
> +
> +		ret = devm_request_threaded_irq(dev, charger->irq_arr[i],
> +						NULL, max77659_charger_isr, IRQF_TRIGGER_FALLING,

This does not look like wrapped to Linux coding style (which is
explicitly set at 80).

> +						max77659_irq_descs[i], charger);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq: %d\n",
> +					     charger->irq_arr[i]);
> +	}
> +
> +	charger->psy_chg = devm_power_supply_register(dev, &charger->psy_chg_d, &charger_cfg);
> +	if (IS_ERR(charger->psy_chg))
> +		return dev_err_probe(dev, PTR_ERR(charger->psy_chg),
> +				     "Failed to register power supply\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77659_charger_of_id[] = {
> +	{ .compatible = "adi,max77659-charger" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max77659_charger_of_id);
> +
> +static const struct platform_device_id max77659_charger_id[] = {
> +	{ MAX77659_CHARGER_NAME, 0, },

Same comment.

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, max77659_charger_id);
> +
> +static struct platform_driver max77659_charger_driver = {
> +	.driver = {
> +		.name = MAX77659_CHARGER_NAME,
> +		.of_match_table = of_match_ptr(max77659_charger_of_id),

Same problem.

> +	},
> +	.probe = max77659_charger_probe,
> +	.id_table = max77659_charger_id,
> +};
> +
> +module_platform_driver(max77659_charger_driver);
> +
> +MODULE_DESCRIPTION("MAX77659 Charger Driver");
> +MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.com");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");

Drop version. From all possible places.

Best regards,
Krzysztof

