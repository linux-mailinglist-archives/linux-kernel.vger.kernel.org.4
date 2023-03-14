Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779296B9D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCNRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCNRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:47:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F0B04A7;
        Tue, 14 Mar 2023 10:47:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id o12so762147iow.6;
        Tue, 14 Mar 2023 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678816051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nh0cTcQRpEReTRq9tA/U9ZmiFjEH4n3ecr8tBmF9AsM=;
        b=IcYCzBQbdqXKiW5OqOFDOJruRlVNuB4PCB3Ti1qWnE48h7k2s0lgzqZ9jrrmnIYUjG
         6IJhDDPILR+UtVfr2rcPS3UYXzpAq9WxfmOK4A1YnK2EsxX+QaJVu6InmoG4qu+yzF2Q
         4mOV3x+r++lsCjE0O+ljGWiGDtawuStrJi3TdgYCk5xWexhqmJx/YxV38gm79JDVkCqz
         sTosxwXxzB4fKIkFC/hc6vRB1zZ3/L2uyRovzy0ijNcTv8wMaxj+H4i4hyS7qcOcRLdi
         0zTK8YNy3rfa3iB1NzHNiDDKUqiEMDPWMorZ90UKmsffXcNvtTymfj9E24WmrtHziWEg
         ayNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh0cTcQRpEReTRq9tA/U9ZmiFjEH4n3ecr8tBmF9AsM=;
        b=M87uTbn2hL70lpQNmlEEphGwYsYRcI1MDb11cyi+NgoH/PR0YhMe2mO4UmaQ2GPcYD
         6Yh3U45nj/G0rjicpdecVCWRT6+9r7qrmInk5Ih2fmbYQN1Gc2Y7PYs+lcFdjfL+tPjP
         CROh/Bx9fNe2VfnQ/Eew2uyQz5tC5oHTVCsgMBP2QfbL5XYmulvHTtY9ClqEB+9VOtOV
         fZBQhZ4fZdSarWRFPDt30PO0bgz6yAVjo24DMeiQ7ctcUfo3puxuKvYC9g2WhztgeluT
         gF/a91scy+fG6EYtWRcckOlhsqTXxelU1t8noRn4W24oLFVb10hLCNKTgh5uWy8rXv/8
         IFkg==
X-Gm-Message-State: AO0yUKXgGxhSyU5wjaq0AUe03DFbCgLDwPVFbku4UKPfmqAYO/05hwna
        Ww4/PAHEeQwyahwBFcLJqaI=
X-Google-Smtp-Source: AK7set9OLArw5DXhOo715+j0pTmoUAa5Z9/C4+yCiRmcG3lh/wYWcDl4SrsiWLcHTYgimEryBffpDQ==
X-Received: by 2002:a6b:7c09:0:b0:74e:3b0f:4498 with SMTP id m9-20020a6b7c09000000b0074e3b0f4498mr21390006iok.7.1678816050812;
        Tue, 14 Mar 2023 10:47:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20-20020a5d9ad4000000b0074ce0b89a37sm984876ion.1.2023.03.14.10.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 10:47:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <87df4524-5a64-c285-238d-ac1ae0c31249@roeck-us.net>
Date:   Tue, 14 Mar 2023 10:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230314152916.185939-1-william.gray@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230314152916.185939-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 08:29, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

The changes are too invasive to accept without testing.
I hope we can get a Tested-by: tag from someone. Other than
that, we are good to go from my perspective.

Thanks,
Guenter

> ---
> Changes in v2:
>   - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()
>   - Map watchdog control registers based on offset 0x1 and adjust regmap
>     configurations accordingly; offset 0x0 is unused in this driver so we
>     should avoid unnecessary exposure of it
> 
>   drivers/watchdog/Kconfig        |  1 +
>   drivers/watchdog/ebc-c384_wdt.c | 67 +++++++++++++++++++++++----------
>   2 files changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..301cfe79263c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1089,6 +1089,7 @@ config EBC_C384_WDT
>   	tristate "WinSystems EBC-C384 Watchdog Timer"
>   	depends on X86
>   	select ISA_BUS_API
> +	select REGMAP_MMIO
>   	select WATCHDOG_CORE
>   	help
>   	  Enables watchdog timer support for the watchdog timer on the
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 8ef4b0df3855..2f9fec5073b3 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -3,15 +3,15 @@
>    * Watchdog timer driver for the WinSystems EBC-C384
>    * Copyright (C) 2016 William Breathitt Gray
>    */
> +#include <linux/bits.h>
>   #include <linux/device.h>
>   #include <linux/dmi.h>
> -#include <linux/errno.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> +#include <linux/err.h>
>   #include <linux/isa.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/regmap.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
>   
> @@ -24,8 +24,14 @@
>   #define WATCHDOG_MAX_TIMEOUT	15300
>   #define BASE_ADDR		0x564
>   #define ADDR_EXTENT		5
> -#define CFG_ADDR		(BASE_ADDR + 1)
> -#define PET_ADDR		(BASE_ADDR + 2)
> +#define CTRL_BASE_ADDR		(BASE_ADDR + 0x1)
> +#define CTRL_ADDR_EXTENT	2
> +#define CTRL_MAX_REGISTER	(CTRL_ADDR_EXTENT - 1)
> +#define CFG_REG			0x0
> +#define PET_REG			0x1
> +#define CFG_MINUTES		0x00
> +#define CFG_SECONDS		BIT(7)
> +#define PET_DISABLED		0x00
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
> @@ -37,43 +43,54 @@ module_param(timeout, uint, 0);
>   MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
>   	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
>   
> +static const struct regmap_range ebc_c384_wdt_wr_ranges[] = {
> +	regmap_reg_range(0x0, 0x1),
> +};
> +static const struct regmap_access_table ebc_c384_wdt_wr_table = {
> +	.yes_ranges = ebc_c384_wdt_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ebc_c384_wdt_wr_ranges),
> +};
> +static const struct regmap_config ebc_c384_wdt_regmap_config = {
> +	.reg_bits = 8,
> +	.reg_stride = 1,
> +	.val_bits = 8,
> +	.io_port = true,
> +	.max_register = CTRL_MAX_REGISTER,
> +	.wr_table = &ebc_c384_wdt_wr_table,
> +};
> +
>   static int ebc_c384_wdt_start(struct watchdog_device *wdev)
>   {
> +	struct regmap *const map = watchdog_get_drvdata(wdev);
>   	unsigned t = wdev->timeout;
>   
>   	/* resolution is in minutes for timeouts greater than 255 seconds */
>   	if (t > 255)
>   		t = DIV_ROUND_UP(t, 60);
>   
> -	outb(t, PET_ADDR);
> -
> -	return 0;
> +	return regmap_write(map, PET_REG, t);
>   }
>   
>   static int ebc_c384_wdt_stop(struct watchdog_device *wdev)
>   {
> -	outb(0x00, PET_ADDR);
> +	struct regmap *const map = watchdog_get_drvdata(wdev);
>   
> -	return 0;
> +	return regmap_write(map, PET_REG, PET_DISABLED);
>   }
>   
>   static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
>   {
> +	struct regmap *const map = watchdog_get_drvdata(wdev);
> +
>   	/* resolution is in minutes for timeouts greater than 255 seconds */
>   	if (t > 255) {
>   		/* round second resolution up to minute granularity */
>   		wdev->timeout = roundup(t, 60);
> -
> -		/* set watchdog timer for minutes */
> -		outb(0x00, CFG_ADDR);
> -	} else {
> -		wdev->timeout = t;
> -
> -		/* set watchdog timer for seconds */
> -		outb(0x80, CFG_ADDR);
> +		return regmap_write(map, CFG_REG, CFG_MINUTES);
>   	}
>   
> -	return 0;
> +	wdev->timeout = t;
> +	return regmap_write(map, CFG_REG, CFG_SECONDS);
>   }
>   
>   static const struct watchdog_ops ebc_c384_wdt_ops = {
> @@ -89,6 +106,8 @@ static const struct watchdog_info ebc_c384_wdt_info = {
>   
>   static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>   {
> +	void __iomem *regs;
> +	struct regmap *map;
>   	struct watchdog_device *wdd;
>   
>   	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
> @@ -97,6 +116,15 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>   		return -EBUSY;
>   	}
>   
> +	regs = devm_ioport_map(dev, CTRL_BASE_ADDR, CTRL_ADDR_EXTENT);
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	map = devm_regmap_init_mmio(dev, regs, &ebc_c384_wdt_regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "Unable to initialize register map\n");
> +
>   	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
>   	if (!wdd)
>   		return -ENOMEM;
> @@ -107,6 +135,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
>   	wdd->min_timeout = 1;
>   	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
>   
> +	watchdog_set_drvdata(wdd, map);
>   	watchdog_set_nowayout(wdd, nowayout);
>   	watchdog_init_timeout(wdd, timeout, dev);
>   
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

