Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277F608E91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJVQfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJVQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:35:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A715A8C1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:35:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q19so16608883edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Hdv1mbqowF6vh5DNfkIUiQ0n9553kuzhvWlhKpDxJY=;
        b=VGWwodF9ZFY1oMM0Pfgp/Er92v3OynuJgIUMeiAiyJB9bviBTVwD/1vCOpu/Ki+2K+
         3f3S87RfL69pdGNm8gVWNMXEX4EEZ7LVgzw0N0Tqfd4DiVr2eXYgEsJVWy9UfxvfaGpL
         1hhtKxW6FTiu/yxkTKYFGOVzYSwL5072Nlcks+cYyTrVJDJIXac3qnkr8Tv/UHf95xUy
         AZYLklyFTDg9v5mfujOSUSCVqyjisPz/613exmZk+rJISsPy8282utFFZfoluY7vWW2o
         VSAFuRk6tDaVUbp4J68GIcEINulIgIkTyVvuFM3JyiW9nXx9llyssfJ7J5lfCn8J6S9h
         uTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hdv1mbqowF6vh5DNfkIUiQ0n9553kuzhvWlhKpDxJY=;
        b=IhMy0ORkGzBLIywRGO29zQQ5KDVGJw+ckBU2xBo1GIeYdiNoCka38aqy4A3Mv/iv9E
         S3YJ96EgISVIdlNFRMwL4iXzp2BD8BBGWdNSF+NIEiqF9mlBx8GeeL11exJKu3dhKpMY
         CMIj0ZJaCDpWXsK49P6ImUMAL5f1EU4lwksUx4BRYH7Ig2+nD5rggc1446ImqRKhMzFS
         eqD2ojOcm/IiInUrxihTpvvfNHL/QPGLvBHvpFw5CZ1IO3Yj6HWHBInKHVQznMHRYbXZ
         D0kK9P5+BgQIjwRoFKPVFMFJ+OhlKXeg6E/L/D/ZqpT8DF67fimVxxnHuX0DyukJNanB
         Kb4A==
X-Gm-Message-State: ACrzQf18G9/6jrwhlOsZJ4/vHYa1WQly6e0KDGFXRNlRm9lydD/czUKu
        Onx9MX/CInIDlxp6n0/fu4tAXA==
X-Google-Smtp-Source: AMsMyM6a5QLh2viiSelQ6l4YiBUdev8Gs5f5CFAE5EQY1dkRpELZdjzz3gkewypVCIBffYz7C+R1Lw==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr23343739eda.214.1666456539409;
        Sat, 22 Oct 2022 09:35:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7b1d:c5f2:c85:8976? ([2a05:6e02:1041:c10:7b1d:c5f2:c85:8976])
        by smtp.googlemail.com with ESMTPSA id da3-20020a056402176300b004615bea1d5bsm2014878edb.35.2022.10.22.09.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:35:38 -0700 (PDT)
Message-ID: <d5cda762-63d0-ac89-e826-52b3bc6fad84@linaro.org>
Date:   Sat, 22 Oct 2022 18:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, krzk@kernel.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com
References: <cover.1665990345.git.lhjeff911@gmail.com>
 <076585e120b64832dcb81e39f3e59d719148816b.1665990345.git.lhjeff911@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <076585e120b64832dcb81e39f3e59d719148816b.1665990345.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 09:32, Li-hao Kuo wrote:
> Add thermal driver for Sunplus.
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v11:
>   - Remove the remove function of the platform_driver
>   - Fix error reported-by: kernel test robot.
> 
>   MAINTAINERS                       |   6 ++
>   drivers/thermal/Kconfig           |  10 +++
>   drivers/thermal/Makefile          |   1 +
>   drivers/thermal/sunplus_thermal.c | 130 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 147 insertions(+)
>   create mode 100644 drivers/thermal/sunplus_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f185..bf22c53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19753,6 +19753,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>   F:	drivers/spi/spi-sunplus-sp7021.c
>   
> +SUNPLUS THERMAL DRIVER
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/sunplus_thermal.c
> +
>   SUNPLUS UART DRIVER
>   M:	Hammer Hsieh <hammerh0314@gmail.com>
>   S:	Maintained
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae..405b788 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config SUNPLUS_THERMAL
> +	tristate "Sunplus thermal drivers"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	help
> +	  This enable the Sunplus SP7021 thermal driver, which supports the primitive
> +	  temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +	  If you have a Sunplus SP7021 platform say Y here and enable this option
> +	  to have support for thermal management.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 2506c6c..4512193 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
> \ No newline at end of file
> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
> new file mode 100644
> index 0000000..20ea7d9
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#define ENABLE_THERMAL		BIT(31)
> +#define SP_THERMAL_MASK		GENMASK(10, 0)
> +
> +#define TEMP_RATE		608
> +#define TEMP_BASE		3500
> +#define TEMP_OTP_BASE		1518
> +
> +#define SP_THERMAL_CTL0_REG	0x0000
> +#define SP_THERMAL_STS0_REG	0x0030
> +
> +/* common data structures */
> +struct sp_thermal_data {
> +	struct thermal_zone_device *pcb_tz;
> +	void __iomem *regs;
> +	int *otp_temp0;
> +};
> +
> +static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
> +{
> +	struct nvmem_cell *cell;
> +	ssize_t otp_l;
> +
> +	cell = nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);
> +
> +	if (*sp_data->otp_temp0 == 0)
> +		*sp_data->otp_temp0 = TEMP_OTP_BASE;
> +
> +	return 0;
> +}
> +
> +/*
> + * There is a thermal sensor instance for Sunplus Soc
> + * T_CODE is the ADC of the thermal sensor
> + * T_CODE : 11 digits in total
> + * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
> + * otp_temp0 is the 35 degree T_CODE obtained from nvcell
> + * The function will get 35 degree T_CODE for thermal calibration.
> + * TEMP_RATE is the Sunplus thermal temperature slope.
> + */
> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +	struct sp_thermal_data *sp_data = data;
> +	int t_code;
> +
> +	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
> +	*temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
> +	*temp *= 10;
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {

struct thermal_zone_device_ops ...

 
https://lore.kernel.org/r/20220804224349.1926752-1-daniel.lezcano@linexp.org





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
