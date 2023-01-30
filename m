Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3668076F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjA3Ibf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjA3Ibc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:31:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CB24134
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:31:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t7so1895793wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bigQDrQ/5/NkjvhOHWX8st4r93BNOKDn4v9DrfYJQJo=;
        b=ynvaNDQtSNFtorJe9hVYtkepolL0QEleDPvW/3Upke/rliVQAaNR3XUS6RVDvOojbc
         plWWupRFPUcnNySEWavfCSMhCLPfRdSBIze93nSK5vCq6drXY8MmGId/tVRr5+gjzpZ5
         PRBt3FyDcNT353v5ayjZnku0hCQgtAtwdFSr6aiMKgiNTU3tzQofOxTgL5mqhdh2xA2C
         o2pwPLnEFf8CJA/fNwXBb77izR6EgC4jtykX7qehKhu3fetuwBlgvy8VUmlM+zpbs56q
         s5zB4Vi1/4ymiEVAXq2UiCqlGBI2vDmSXy0DBlwZo8BwO4eg8wKyvQPZhq5F49ZzmyGF
         fwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bigQDrQ/5/NkjvhOHWX8st4r93BNOKDn4v9DrfYJQJo=;
        b=XWmGKyS7Zmbf3Nywt46CBoW41GWC0o0N8QcSD+foJ1aCiXY1tmE8z0k0bDtZztJj8v
         OF8v0RvCTB9IdhWGMp8RSc80mPO+P0sr0IepZV1xCa1Zm+Wv4kQv9mPbee5YDicQiOE/
         jpJ+8YjehCSwwrF8boVQMwk3i4UZemCmbpPf4xD4lCdU9kCuMOTgG15u0mfK0VAqRRc6
         uDvLCdQBRAg+PUqQllKtiLhzi2s+bBKqgkCyU7ubDzHSsoaKylzBbWJdDvJebKlBTSE7
         jMtbgNoSxt2hZHPQb4RF4eVsCFu70RRWCFZxMsIkhKLfMk/zbC8lNtrwu/uDrRqRvnjy
         7MJA==
X-Gm-Message-State: AO0yUKU9vigx56R1N3a1XE7RsZJesk1jSWlNn/2cWJNeGk/N+EIzHi7S
        Jr114B+SySiXyQPZ/qRKoO3bag==
X-Google-Smtp-Source: AK7set9v5OBcLmXVGardaGi9WIL53mteSOQtxeVjTIulDEZPObXjqhevvmIh5/ELSQl69i+PeaNWwg==
X-Received: by 2002:a5d:504f:0:b0:2bf:b036:ffe3 with SMTP id h15-20020a5d504f000000b002bfb036ffe3mr19144712wrt.45.1675067488090;
        Mon, 30 Jan 2023 00:31:28 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm12869981wrs.36.2023.01.30.00.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:31:27 -0800 (PST)
Message-ID: <4b4e8438-a1f6-221c-d4ea-0ef6bdd37dd9@linaro.org>
Date:   Mon, 30 Jan 2023 09:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] power: reset: add Odroid Go Ultra poweroff driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20230126-b4-odroid-go-ultra-poweroff-v2-1-a8c50866f4ac@linaro.org>
 <20230129234705.djmoir4wsshoptwo@mercury.elektranox.org>
Organization: Linaro Developer Services
In-Reply-To: <20230129234705.djmoir4wsshoptwo@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 00:47, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 26, 2023 at 06:11:21PM +0100, Neil Armstrong wrote:
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
>> Changes in v2:
>> - Switched to devm_register_sys_off_handler()
>> - Link to v1: https://lore.kernel.org/r/20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org
>> ---
>>   drivers/power/reset/Kconfig                    |   7 ++
>>   drivers/power/reset/Makefile                   |   1 +
>>   drivers/power/reset/odroid-go-ultra-poweroff.c | 151 +++++++++++++++++++++++++
>>   3 files changed, 159 insertions(+)
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index a8c46ba5878f..26860c2e05a9 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -141,6 +141,13 @@ config POWER_RESET_OCELOT_RESET
>>   	help
>>   	  This driver supports restart for Microsemi Ocelot SoC and similar.
>>   
>> +config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
>> +	bool "Odroid Go Ultra power-off driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on MFD_RK808
> 
> You are not accessing any symbols from the MFD driver, so you can
> append "|| COMPILE_TEST".
> 
> It will be fun to coordinate the merging, because of my series
> renaming it to MFD_RK8XX :/
> 
> https://lore.kernel.org/all/20230127181244.160887-1-sebastian.reichel@collabora.com/

If I do not depend anymore on `struct rk808`, so I don't depend anymore on it,
but if it doesn't probe I won't get the regmap from the i2c device.

So it will be a runtime dependency instead, so it's ok to drop.

But I'll need to add a depend to guard of_find_i2c_device_by_node()

> 
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
>> index 000000000000..51f54e65c927
>> --- /dev/null
>> +++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
>> @@ -0,0 +1,151 @@
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
>> +	struct rk808 *rk817;
>> +	struct rk808 *rk818;
>> +};
>> +
>> +static int odroid_go_ultra_poweroff_prepare(struct sys_off_data *data)
>> +{
>> +	struct odroid_go_ultra_poweroff_data *poweroff_data = data->cb_data;
>> +	int ret;
>> +
>> +	dev_info(poweroff_data->dev, "Setting PMICs for power off");
>> +
>> +	/* RK817 */
>> +	ret = regmap_update_bits(poweroff_data->rk817->regmap, RK817_SYS_CFG(3), DEV_OFF, DEV_OFF);
>> +	if (ret) {
>> +		dev_err(poweroff_data->dev, "failed to poweroff rk817\n");
>> +		return notifier_from_errno(ret);
>> +	}
>> +
>> +	/* RK818 */
>> +	ret = regmap_update_bits(poweroff_data->rk818->regmap, RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
>> +	if (ret) {
>> +		dev_err(poweroff_data->dev, "failed to poweroff rk818\n");
>> +		return notifier_from_errno(ret);
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static int odroid_go_ultra_poweroff_get_pmic_drvdata(const char *compatible, struct rk808 **pmic)
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
>> +	*pmic = i2c_get_clientdata(pmic_client);
> 
> You are only using the regmap, so you can skip the rk808 struct step
> and directly get and store the regmap: >
> *pmic = dev_get_regmap(&pmic_client->dev, NULL);

Indeed ti makes things much simpler.

> 
>> +	put_device(&pmic_client->dev);
> 
> Technically this allows releasing the PMIC device with the poweroff
> driver still probed. I guess it's mostly a theoretical thing in this
> case, but people tend to cargo copy. I suggest to store the struct
> device handle in odroid_go_ultra_poweroff_data and then use
> dev_get_regmap() in the poweroff handler. Finally add a put_device()
> via devm_add_action_or_reset().

Indeed, this makes it much cleaner.

> 
>> +	if (!*pmic)
>> +		return -EPROBE_DEFER;
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
>> +	/* RK818 */
>> +	ret = odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk818",
>> +							&poweroff_data->rk818);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk818 mfd data\n");
>> +
>> +	/* RK817 */
>> +	ret = odroid_go_ultra_poweroff_get_pmic_drvdata("rockchip,rk817",
>> +							&poweroff_data->rk817);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "failed to get rk817 mfd data\n");
>> +
>> +	/* Register as SYS_OFF_MODE_POWER_OFF_PREPARE because regmap_update_bits may sleep */
>> +	ret = devm_register_sys_off_handler(&pdev->dev,
>> +					    SYS_OFF_MODE_POWER_OFF_PREPARE,
>> +					    SYS_OFF_PRIO_DEFAULT,
>> +					    odroid_go_ultra_poweroff_prepare,
>> +					    poweroff_data);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "failed to register sys-off handler\n");
>> +
>> +	dev_info(&pdev->dev, "Registered Power-Off handler\n");
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
>> +	return PTR_ERR_OR_ZERO(pdev);
> 
> This is missing platform_driver_unregister() in the error path.

Ack

> 
>> +}
>> +
>> +static void __exit odroid_go_ultra_poweroff_exit(void)
>> +{
> 
> if (!of_device_is_compatible(of_root, "hardkernel,odroid-go-ultra"))
> 		return;

Ack

> 
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
> 
> Thanks,
> 
> -- Sebastian

Thanks,
Neil
