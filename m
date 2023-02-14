Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54D26969B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjBNQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBNQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:34:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884EA222CB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:34:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so16285732wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aHCLH0BCYlrl7bOEbDY1pAuE8eh72PmVR3nJT0nQgwA=;
        b=zDLVojkLYLUeqvXDyAEKunf5Z9Lbe4P84SBhZ8bMKfPfYbANsBangK5zJ27+jcJ+SH
         4nXzIsiN/sYXg8iJMJxVcGQulmeT0X+aNQqO/MKiusIgaBrXJsvM5J72n9SFys7mdt61
         Adk5mFO7ZVtROV3fgNo9m6t96I13J3U2oWbl8Ps4dQ1ZcXEsNUFr/pbvdlosgDh85iK6
         0QzP8K/BHIWr64pF73/cDHv/Kl5sCH4AKBXfvt6/DpWgjColsCOvLZg4M1q+K9DSXpL/
         V5hCYuIYcUJx3QVrCjMALp1wk2Lk4lo0dMkqCNzZUyRo58epZkOl6LC7H8FxAojt4WMw
         T8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHCLH0BCYlrl7bOEbDY1pAuE8eh72PmVR3nJT0nQgwA=;
        b=rXIgyliBNH+t+vWaA5ZqSawMrv0Cii1NIvBahXGaflDUP3JGYJfNxK2drM3zhYiguY
         oFogKBmrnpomDAvGE+Wt8NnERpCnfnxvnOYljW+JgcTjdueyUVvSdNsL2DKdDxI7vKoD
         2s/Ox9o8chJhCysr0m3gTLcvulIh2Yg1auNlZQ9wK2hekhAqtRdy63jJsl+WRu6ewkux
         bMfvQIDtSbUN3L3XKkuyhWqfQzuhK458cdF7tFnQQMh0b0YLroC9lC/yV2nWsTzYMeCm
         34llSh3AjMciVqohYRU516awwnh0gvwYhODofgScBEUBBlJb0NjQnsfga3iiNaJM74Ef
         hc5w==
X-Gm-Message-State: AO0yUKXA7Zc82NX+b1K3/VgBTB5ITEXaEcWVaF4Le7MNGdlCawPmRE0x
        urFAxbMfTA7SzcF8rBvQakBX3g==
X-Google-Smtp-Source: AK7set8BVXyabF5XV54Ry7iZuy+vqHXB4GdacOu290G1X0yyvSHNfmccuMjleImZLiN35w3E7xTZEQ==
X-Received: by 2002:a5d:674d:0:b0:2c5:5d15:4e25 with SMTP id l13-20020a5d674d000000b002c55d154e25mr2512559wrw.16.1676392439813;
        Tue, 14 Feb 2023 08:33:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4bc0:b2ae:1d81:afec? ([2a01:e0a:982:cbb0:4bc0:b2ae:1d81:afec])
        by smtp.gmail.com with ESMTPSA id z15-20020adfe54f000000b002c5694aef92sm1343282wrm.21.2023.02.14.08.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:33:59 -0800 (PST)
Message-ID: <21479d70-9749-0268-cd4b-921b7a2380f8@linaro.org>
Date:   Tue, 14 Feb 2023 17:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] power: reset: add Odroid Go Ultra poweroff driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20230126-b4-odroid-go-ultra-poweroff-v3-1-0a7fd3d5c4b3@linaro.org>
 <20230213204249.nj5snnoezwobquon@mercury.elektranox.org>
Organization: Linaro Developer Services
In-Reply-To: <20230213204249.nj5snnoezwobquon@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 21:42, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Feb 10, 2023 at 11:03:36AM +0100, Neil Armstrong wrote:
>> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
>> to its two PMICs in order, this represents the poweroff scheme needed to complete
>> a clean poweroff of the system.
>>
>> This implement this scheme by implementing a self registering driver to permit
>> using probe defer until both pmics are finally probed.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Previous submission was at [1], but I converted it to an independent
>> platform device with device auto registration to permit waiting for
>> both the PMICs drivers to probe.
>>
>> [1] https://lore.kernel.org/all/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org/
>> ---
>> Changes in v3:
>> - Removed dependency with rk08
>> - Switched to storing struct device of pmics
>> - Fixed module init/exit
>> - Link to v2: https://lore.kernel.org/r/20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org
>>
>> Changes in v2:
>> - Switched to devm_register_sys_off_handler()
>> - Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org
>> ---
>>   drivers/power/reset/Kconfig                    |   7 +
>>   drivers/power/reset/Makefile                   |   1 +
>>   drivers/power/reset/odroid-go-ultra-poweroff.c | 193 +++++++++++++++++++++++++
>>   3 files changed, 201 insertions(+)
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index a8c46ba5878f..a47ef7a9fc13 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
>>   	help
>>   	  This driver supports restart for Microsemi Ocelot SoC and similar.
>>   
>> +config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
>> +	bool "Odroid Go Ultra power-off driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on OF
>> +	help
>> +	  This driver supports Power off for Odroid Go Ultra device.
>> +
>>   config POWER_RESET_OXNAS
>>   	bool "OXNAS SoC restart driver"
>>   	depends on ARCH_OXNAS
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index 0a39424fc558..d763e6735ee3 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_OXNAS) += oxnas-restart.o
>>   obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
>>   obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
>> +obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
>> diff --git a/drivers/power/reset/odroid-go-ultra-poweroff.c b/drivers/power/reset/odroid-go-ultra-poweroff.c
>> new file mode 100644
>> index 000000000000..30a005088fbe
>> --- /dev/null
>> +++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
>> @@ -0,0 +1,193 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/mfd/rk808.h>
>> +#include <linux/regmap.h>
>> +#include <linux/module.h>
>> +#include <linux/reboot.h>
>> +#include <linux/i2c.h>
>> +
>> +/*
>> + * The Odroid Go Ultra has 2 PMICs:
>> + * - RK818 (manages the battery and USB-C power supply)
>> + * - RK817
>> + * Both PMICs feeds power to the S922X SoC, so they must be powered-off in sequence.
>> + * Vendor does power-off the RK817 first, then the RK818 so here we follow this sequence.
>> + */
>> +
>> +struct odroid_go_ultra_poweroff_data {
>> +	struct device *dev;
>> +	struct device *rk817;
>> +	struct device *rk818;
>> +};
>> +
>> +static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
>> +{
>> +	struct odroid_go_ultra_poweroff_data *poweroff_data = data->cb_data;
>> +	struct regmap *rk817, *rk818;
>> +	int ret;
>> +
>> +	/* RK817 Regmap */
>> +	rk817 = dev_get_regmap(poweroff_data->rk817, NULL);
>> +	if (!rk817) {
>> +		dev_err(poweroff_data->dev, "failed to get rk817 regmap\n");
>> +		return notifier_from_errno(-EINVAL);
>> +	}
>> +
>> +	/* RK818 Regmap */
>> +	rk818 = dev_get_regmap(poweroff_data->rk818, NULL);
>> +	if (!rk818) {
>> +		dev_err(poweroff_data->dev, "failed to get rk818 regmap\n");
>> +		return notifier_from_errno(-EINVAL);
>> +	}
>> +
>> +	dev_info(poweroff_data->dev, "Setting PMICs for power off");
>> +
>> +	/* RK817 */
>> +	ret = regmap_update_bits(rk817, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
>> +	if (ret) {
>> +		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
>> +		return notifier_from_errno(ret);
>> +	}
>> +
>> +	/* RK818 */
>> +	ret = regmap_update_bits(rk818, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
>> +	if (ret) {
>> +		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
>> +		return notifier_from_errno(ret);
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static int odroid_go_ultra_poweroff_get_pmic_device(const char *compatible, struct device **pmic)
>> +{
>> +	struct device_node *pmic_node;
>> +	struct i2c_client *pmic_client;
>> +
>> +	pmic_node = of_find_compatible_node(NULL, NULL, compatible);
>> +	if (!pmic_node)
>> +		return -ENODEV;
>> +
>> +	pmic_client = of_find_i2c_device_by_node(pmic_node);
>> +	of_node_put(pmic_node);
>> +	if (!pmic_client)
>> +		return -EPROBE_DEFER;
>> +
>> +	*pmic = &pmic_client->dev;
>> +
>> +	return 0;
>> +}
>> +
>> +static int odroid_go_ultra_poweroff_probe(struct platform_device *pdev)
>> +{
>> +	struct odroid_go_ultra_poweroff_data *poweroff_data;
>> +	int ret;
>> +
>> +	poweroff_data = devm_kzalloc(&pdev->dev, sizeof(*poweroff_data), GFP_KERNEL);
>> +	if (!poweroff_data)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(&pdev->dev, poweroff_data);
>> +
>> +	/* RK818 PMIC Device */
>> +	ret = odroid_go_ultra_poweroff_get_pmic_device("rockchip,rk818",
>> +						       &poweroff_data->rk818);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n");
>> +
>> +	/* RK817 PMIC Device */
>> +	ret = odroid_go_ultra_poweroff_get_pmic_device("rockchip,rk817",
>> +						       &poweroff_data->rk817);
>> +	if (ret) {
>> +		ret  = dev_err_probe(&pdev->dev, ret, "failed to get rk817 mfd data\n");
>> +		goto put_rk818_device;
>> +	}
>> +
>> +	/* Register as SYS_OFF_MODE_POWER_OFF_PREPARE because regmap_update_bits may sleep */
>> +	ret = devm_register_sys_off_handler(&pdev->dev,
>> +					    SYS_OFF_MODE_POWER_OFF_PREPARE,
>> +					    SYS_OFF_PRIO_DEFAULT,
>> +					    odroid_go_ultra_poweroff_prepare,
>> +					    poweroff_data);
>> +	if (ret) {
>> +		ret = dev_err_probe(&pdev->dev, ret, "failed to register sys-off handler\n");
>> +		goto put_rk817_device;
>> +	}
> 
> Allocating managed resources after a traditional allocation always
> rings an alarm bell. The problem is, that the order at removal time
> will not be the reverse of the allocation chain in this case.
> 
> You can fix this by handling the put_device for rk817 and rk818 via
> devm_add_action_or_reset() (preferred by me) or by switching
> devm_register_sys_off_handler() to register_sys_off_handler.

Good point, I've added a devm_add_action_or_reset() into odroid_go_ultra_poweroff_get_pmic_device()

Thanks,
Neil

> 
> Otherwise the driver LGTM.
> 
> -- Sebastian
> 
>> +
>> +	dev_info(&pdev->dev, "Registered Power-Off handler\n");
>> +
>> +	return 0;
>> +
>> +put_rk817_device:
>> +	put_device(poweroff_data->rk817);
>> +
>> +put_rk818_device:
>> +	put_device(poweroff_data->rk818);
>> +
>> +	return ret;
>> +}
>> +
>> +static int odroid_go_ultra_poweroff_remove(struct platform_device *pdev)
>> +{
>> +	struct odroid_go_ultra_poweroff_data *poweroff_data = dev_get_drvdata(&pdev->dev);
>> +
>> +	put_device(poweroff_data->rk818);
>> +	put_device(poweroff_data->rk817);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_device *pdev;
>> +
>> +static struct platform_driver odroid_go_ultra_poweroff_driver = {
>> +	.driver = {
>> +		.name	= "odroid-go-ultra-poweroff",
>> +	},
>> +	.probe = odroid_go_ultra_poweroff_probe,
>> +	.remove = odroid_go_ultra_poweroff_remove,
>> +};
>> +
>> +static int __init odroid_go_ultra_poweroff_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* Only create when running on the Odroid Go Ultra device */
>> +	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
>> +		return -ENODEV;
>> +
>> +	ret = platform_driver_register(&odroid_go_ultra_poweroff_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdev = platform_device_register_resndata(NULL, "odroid-go-ultra-poweroff", -1,
>> +						 NULL, 0, NULL, 0);
>> +
>> +	if (IS_ERR(pdev)) {
>> +		platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
>> +		return PTR_ERR(pdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit odroid_go_ultra_poweroff_exit(void)
>> +{
>> +	/* Only delete when running on the Odroid Go Ultra device */
>> +	if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
>> +		return;
>> +
>> +	platform_device_unregister(pdev);
>> +	platform_driver_unregister(&odroid_go_ultra_poweroff_driver);
>> +}
>> +
>> +module_init(odroid_go_ultra_poweroff_init);
>> +module_exit(odroid_go_ultra_poweroff_exit);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>> +MODULE_DESCRIPTION("Odroid Go Ultra poweroff driver");
>> +MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: 38d2b86a665b5e86371a1a30228bce259aa6c101
>> change-id: 20230126-b4-odroid-go-ultra-poweroff-c8fdca93f3eb
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

