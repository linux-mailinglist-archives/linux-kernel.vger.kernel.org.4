Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A86FB831
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEHUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEHUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:15:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296671BD5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:15:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ddb2093bso632434866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683576920; x=1686168920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Fp0lSNEvHbBfUsd7/thKvbF7+DN0vBYq4suwmKpz0s=;
        b=fQ7RYvPAfMSJUAbnPH7fbxrYfTWWtigb67IP/v3cLddi+ev+BlaziqfBFYqGy/W2Kc
         FCa2x3BwjQv0cYoS26x1BaiFaWojHD3Tpo7rUFZrQiHoBTQlKib2AULAkckbj6bcfkvb
         ycO5x+JqChLv9gzpWQl1qVQdEM+vT1DO6WcPY6dU5TT8dnGm7Wip6K1LNC5nd+hynAk3
         wS6yvucNHz6VxtUom0fZZ+cuWJ++n5sBr63ToaFQoVSNTHRLc2tHSfmFep6N3rEhqtcv
         p2Xmrt2TXFUPQouTh9bxNtsuPUOBuveUgHOKw+m9qPIIQR37u5XaUCgbzxBEj6Bmvgy9
         EvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683576920; x=1686168920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fp0lSNEvHbBfUsd7/thKvbF7+DN0vBYq4suwmKpz0s=;
        b=cZjuXJfkSFDuxP5w/b2bKYkGCtrF2ZZt+OH5LIeK2h+2KY8CLG9YxNAwbNFyA9xwO8
         Fd4ShjT2IF1Qa5f3+V32AV7lUiWahJmRf2uYHo+nVuJqArXHpK0C1Af8V7zrBMhT/dGF
         Lt6NXjXKkRtQI3irW+J5PFHE61EuqwYSuHfl5pq/L4pTe5Hwd1dXKg5ULoJ0xE/HZI8G
         ELTs+rt+Db85P9D6cZdqskwhDYr2MEjq3XqCF0NDtVdXQIWBiprFp7sWsOx2fCmxBIqh
         noq7G33qK4pXQbjyvuWLTd18eqLcoSaQjmuQRxtkceZWsYfy6X6KVAmnszMf33xIRSDu
         prrQ==
X-Gm-Message-State: AC+VfDyKQBYoVgoUWvipWIbpILf88nQJEnecMzha4yfO6McTEJXVrSWT
        9MxZVmUWoEnJow3bIiydZVxUBw==
X-Google-Smtp-Source: ACHHUZ5R6ysml0hd5vtloBaetd6BnppKyn20LpxcrNkZ2bjYr+tMGScPnPJhJrH7S9Jmou0hgwxpqg==
X-Received: by 2002:a17:907:86a3:b0:966:187:ce40 with SMTP id qa35-20020a17090786a300b009660187ce40mr9132438ejc.4.1683576920531;
        Mon, 08 May 2023 13:15:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b008f89953b761sm401299ejc.3.2023.05.08.13.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:15:14 -0700 (PDT)
Message-ID: <a718233d-1389-93c2-fba2-c6051310febe@linaro.org>
Date:   Mon, 8 May 2023 22:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/7] power: supply: max77658: Add ADI MAX77658 Battery
 Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-6-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-6-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Battery driver for ADI MAX77658.
> 
> The MAX77658 is an ultra-low power fuel gauge which implements the Maxim ModelGauge m5 EZ algorithm.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77658-battery.c | 633 ++++++++++++++++++++++++
>  3 files changed, 641 insertions(+)
>  create mode 100644 drivers/power/supply/max77658-battery.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 4b68bbb1e2a8..f9556f4b9e35 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -572,6 +572,13 @@ config CHARGER_MAX77658
>  	  Say Y to enable support for the battery charger control of
>  	  MAX77654/58/59 PMIC.
>  
> +config BATTERY_MAX77658
> +	tristate "Analog Devices MAX77658 battery driver"
> +	depends on MFD_MAX77658
> +	help
> +	  Say Y to enable support for the battery control of
> +	  MAX77658 PMIC.
> +
>  config CHARGER_MAX77693
>  	tristate "Maxim MAX77693 battery charger driver"
>  	depends on MFD_MAX77693
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index af4bd6e5969f..e5a425d333a7 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77658)	+= max77658-charger.o
> +obj-$(CONFIG_BATTERY_MAX77658)	+= max77658-battery.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
> diff --git a/drivers/power/supply/max77658-battery.c b/drivers/power/supply/max77658-battery.c
> new file mode 100644
> index 000000000000..4948ef227db1
> --- /dev/null
> +++ b/drivers/power/supply/max77658-battery.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Analog Devices, Inc.
> + * ADI battery driver for the MAX77658
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/max77658.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +/* Default value for SALRT min threshold, in percent */
> +#define MAX77658_SALRT_MIN_DEFAULT	1
> +/* Default value for SALRT max threshold, in percent */
> +#define MAX77658_SALRT_MAX_DEFAULT	99
> +
> +#define MAX77658_IALRTTH_RESOLUTION	8567
> +#define MAX77658_CURRENT_RESOLUTION	33487
> +#define MAX77658_VOLTAGE_RESOLUTION	78125
> +#define MAX77658_FG_DELAY		1000
> +#define MAX77658_BATTERY_FULL		100
> +#define MAX77658_BATTERY_LOW		40
> +#define MAX77658_BATTERY_CRITICAL	10
> +#define MAX77658_MAXMINVOLT_STEP	20000
> +#define MAX77658_VALRTTH_STEP		20000
> +#define MAX77658_VEMPTY_VE_STEP		10000
> +#define MAX77658_POWER_STEP		17100
> +
> +#define MAX77658_REG_STATUS		0x00
> +#define MAX77658_REG_VALRTTH		0x01
> +#define MAX77658_REG_TALRTTH		0x02
> +#define MAX77658_REG_SALRTTH		0x03
> +#define MAX77658_REG_CONFIG		0x1D
> +#define MAX77658_REG_DEVNAME		0x21
> +#define MAX77658_REG_VEMPTY		0x3A
> +#define MAX77658_REG_AVGPOWER		0xB3
> +#define MAX77658_REG_IALRTTH		0xB4
> +#define MAX77658_REG_CONFIG2		0xBB
> +#define MAX77658_REG_TEMP		0x08
> +#define MAX77658_REG_VCELL		0x09
> +#define MAX77658_REG_CURRENT		0x0A
> +#define MAX77658_REG_AVGCURRENT		0x0B
> +#define MAX77658_REG_AVGVCELL		0x19
> +#define MAX77658_REG_MAXMINTEMP		0x1A
> +#define MAX77658_REG_MAXMINVOLT		0x1B
> +#define MAX77658_REG_MAXMINCURR		0x1C
> +#define MAX77658_REG_REPSOC		0x06
> +#define MAX77658_REG_TTE		0x11
> +#define MAX77658_REG_TTF		0x20

This is max17055 or very close one. Don't duplicate drivers. Entire
driver should be merged to existing one, e.g. max17042.

Best regards,
Krzysztof

