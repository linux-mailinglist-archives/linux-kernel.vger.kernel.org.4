Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF06DC7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDJOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:43:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925C40EE;
        Mon, 10 Apr 2023 07:43:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ik20so4707415plb.3;
        Mon, 10 Apr 2023 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681137819; x=1683729819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fwIV7DuVm1nOlVnpkF6lWlboVFSGaVPDbKwvxQCbryk=;
        b=EK0ZvlDGwoB+kh/3aP4KlIpOrLeN6TBfbIRQVXWSef2kmde3Q+g7bIh/gnteP6bY2n
         DgvMDWaiwE+NjtxwBHAZco3cSbggf7w0FvbsO5Ch5Xmhdacs15H9o4NeiS54wVBw3Xo8
         JG7t/itqF0ZxglJUhXDovga0G1SLMQ97Z2+ZZupIOTPKWNfe+8MrDBvy5TYoD+nE+MS+
         a8vK2bZuaBge78hJWIpT5tdHE+whzujJnEX6QBn4CA31RZRzl+XdgHyqEjcQdwVDQaQH
         fDmDbEWQEBf2UMA69NRERtVp0bMYOzh3uTMOP6TfKInkU8Sbf1uDowsm0onI7Y86MxHj
         Lo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681137819; x=1683729819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwIV7DuVm1nOlVnpkF6lWlboVFSGaVPDbKwvxQCbryk=;
        b=tdmpryzvjQtvT4DHDQw6EQL/hVLdvgz8HWKwbSPJtr3dDMZL0j2CoVQO6rx5lDLus5
         YcIu0eOd6m2E3I9NuUAzqiQL5o/AC2WRGuAervZdePl5aXcWQGjQ6QUiD4wkytAMokc+
         fc9sjGRCXQ0TeKWLl3+Q/6/6bwKcf+HkmnLeUSSe3dLTC/JDve54iNWgHzPAGUpBa8GT
         cZLDjmG8nAiZz8iIZR1u+g57z4FbQj+zBlGep4xi7aaOybaaKHCwqWncrstuQyDfuuO6
         ZkbOY6GLGjtgKotgXLJkhb5jBd1YkCyZgWJnP0Wxr1aBb3cRzsLFdyUdCqHNxBfPFvY1
         q7Bw==
X-Gm-Message-State: AAQBX9c4/Mm0Ri1YHZfWEcRUAKXMB7/UewpdIVpoRgyxFVVUdhCwDUZX
        mYm8TTxJuooMTKV08ug7BWU=
X-Google-Smtp-Source: AKy350bGfOZhGowj90WK6W3E2MOxomPFmqUenXUkfU0445gKmqwjIkYQrvdUPiymiYkuKBJCIPWbsQ==
X-Received: by 2002:a05:6a20:1d62:b0:c7:6f26:ca0 with SMTP id cs34-20020a056a201d6200b000c76f260ca0mr11590556pzb.54.1681137819255;
        Mon, 10 Apr 2023 07:43:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fe27-20020a056a002f1b00b00637ca3eada8sm2070223pfb.6.2023.04.10.07.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:43:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7b0fbd06-73d0-7fa9-3f03-e788f1df4631@roeck-us.net>
Date:   Mon, 10 Apr 2023 07:43:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Remove support
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>
References: <20230410143101.182563-1-william.gray@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230410143101.182563-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 07:31, William Breathitt Gray wrote:
> The current maintainer no longer has access to the device for testing,
> the original user of this driver indicates that they have moved on to
> another device, and the manufacturer WINSYSTEMS does not appear
> interested in taking over support for this code.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

A bit harsh, maybe. Just mark it as orphan for the time being.

I see there are other Winsystems drivers. What are you going to do
with those ?

Guenter

> ---
>   MAINTAINERS                     |   6 --
>   drivers/watchdog/Kconfig        |  10 ---
>   drivers/watchdog/Makefile       |   1 -
>   drivers/watchdog/ebc-c384_wdt.c | 142 --------------------------------
>   4 files changed, 159 deletions(-)
>   delete mode 100644 drivers/watchdog/ebc-c384_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..3b30b502de93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22511,12 +22511,6 @@ M:	David Härdeman <david@hardeman.nu>
>   S:	Maintained
>   F:	drivers/media/rc/winbond-cir.c
>   
> -WINSYSTEMS EBC-C384 WATCHDOG DRIVER
> -M:	William Breathitt Gray <william.gray@linaro.org>
> -L:	linux-watchdog@vger.kernel.org
> -S:	Maintained
> -F:	drivers/watchdog/ebc-c384_wdt.c
> -
>   WINSYSTEMS WS16C48 GPIO DRIVER
>   M:	William Breathitt Gray <william.gray@linaro.org>
>   L:	linux-gpio@vger.kernel.org
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..7c443d71b01f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1085,16 +1085,6 @@ config ALIM7101_WDT
>   
>   	  Most people will say N.
>   
> -config EBC_C384_WDT
> -	tristate "WinSystems EBC-C384 Watchdog Timer"
> -	depends on X86
> -	select ISA_BUS_API
> -	select WATCHDOG_CORE
> -	help
> -	  Enables watchdog timer support for the watchdog timer on the
> -	  WinSystems EBC-C384 motherboard. The timeout may be configured via
> -	  the timeout module parameter.
> -
>   config EXAR_WDT
>   	tristate "Exar Watchdog Timer"
>   	depends on X86
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9cbf6580f16c..3d12d4ddd5ea 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -105,7 +105,6 @@ obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
>   obj-$(CONFIG_ADVANTECH_EC_WDT) += advantech_ec_wdt.o
>   obj-$(CONFIG_ALIM1535_WDT) += alim1535_wdt.o
>   obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
> -obj-$(CONFIG_EBC_C384_WDT) += ebc-c384_wdt.o
>   obj-$(CONFIG_EXAR_WDT) += exar_wdt.o
>   obj-$(CONFIG_F71808E_WDT) += f71808e_wdt.o
>   obj-$(CONFIG_SP5100_TCO) += sp5100_tco.o
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> deleted file mode 100644
> index 8ef4b0df3855..000000000000
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Watchdog timer driver for the WinSystems EBC-C384
> - * Copyright (C) 2016 William Breathitt Gray
> - */
> -#include <linux/device.h>
> -#include <linux/dmi.h>
> -#include <linux/errno.h>
> -#include <linux/io.h>
> -#include <linux/ioport.h>
> -#include <linux/isa.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -#include <linux/watchdog.h>
> -
> -#define MODULE_NAME		"ebc-c384_wdt"
> -#define WATCHDOG_TIMEOUT	60
> -/*
> - * The timeout value in minutes must fit in a single byte when sent to the
> - * watchdog timer; the maximum timeout possible is 15300 (255 * 60) seconds.
> - */
> -#define WATCHDOG_MAX_TIMEOUT	15300
> -#define BASE_ADDR		0x564
> -#define ADDR_EXTENT		5
> -#define CFG_ADDR		(BASE_ADDR + 1)
> -#define PET_ADDR		(BASE_ADDR + 2)
> -
> -static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> -	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -
> -static unsigned timeout;
> -module_param(timeout, uint, 0);
> -MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> -	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
> -
> -static int ebc_c384_wdt_start(struct watchdog_device *wdev)
> -{
> -	unsigned t = wdev->timeout;
> -
> -	/* resolution is in minutes for timeouts greater than 255 seconds */
> -	if (t > 255)
> -		t = DIV_ROUND_UP(t, 60);
> -
> -	outb(t, PET_ADDR);
> -
> -	return 0;
> -}
> -
> -static int ebc_c384_wdt_stop(struct watchdog_device *wdev)
> -{
> -	outb(0x00, PET_ADDR);
> -
> -	return 0;
> -}
> -
> -static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
> -{
> -	/* resolution is in minutes for timeouts greater than 255 seconds */
> -	if (t > 255) {
> -		/* round second resolution up to minute granularity */
> -		wdev->timeout = roundup(t, 60);
> -
> -		/* set watchdog timer for minutes */
> -		outb(0x00, CFG_ADDR);
> -	} else {
> -		wdev->timeout = t;
> -
> -		/* set watchdog timer for seconds */
> -		outb(0x80, CFG_ADDR);
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct watchdog_ops ebc_c384_wdt_ops = {
> -	.start = ebc_c384_wdt_start,
> -	.stop = ebc_c384_wdt_stop,
> -	.set_timeout = ebc_c384_wdt_set_timeout
> -};
> -
> -static const struct watchdog_info ebc_c384_wdt_info = {
> -	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT,
> -	.identity = MODULE_NAME
> -};
> -
> -static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
> -{
> -	struct watchdog_device *wdd;
> -
> -	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
> -		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> -			BASE_ADDR, BASE_ADDR + ADDR_EXTENT);
> -		return -EBUSY;
> -	}
> -
> -	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
> -	if (!wdd)
> -		return -ENOMEM;
> -
> -	wdd->info = &ebc_c384_wdt_info;
> -	wdd->ops = &ebc_c384_wdt_ops;
> -	wdd->timeout = WATCHDOG_TIMEOUT;
> -	wdd->min_timeout = 1;
> -	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
> -
> -	watchdog_set_nowayout(wdd, nowayout);
> -	watchdog_init_timeout(wdd, timeout, dev);
> -
> -	return devm_watchdog_register_device(dev, wdd);
> -}
> -
> -static struct isa_driver ebc_c384_wdt_driver = {
> -	.probe = ebc_c384_wdt_probe,
> -	.driver = {
> -		.name = MODULE_NAME
> -	},
> -};
> -
> -static int __init ebc_c384_wdt_init(void)
> -{
> -	if (!dmi_match(DMI_BOARD_NAME, "EBC-C384 SBC"))
> -		return -ENODEV;
> -
> -	return isa_register_driver(&ebc_c384_wdt_driver, 1);
> -}
> -
> -static void __exit ebc_c384_wdt_exit(void)
> -{
> -	isa_unregister_driver(&ebc_c384_wdt_driver);
> -}
> -
> -module_init(ebc_c384_wdt_init);
> -module_exit(ebc_c384_wdt_exit);
> -
> -MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> -MODULE_DESCRIPTION("WinSystems EBC-C384 watchdog timer driver");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("isa:" MODULE_NAME);
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

