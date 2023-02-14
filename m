Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9983F695CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBNIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjBNIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:31:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D13C29
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:31:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso13109209wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=os/Pu/ytp1Ibc8eJhaBf3RWMghtAOmFyabVWn60UWeE=;
        b=mn9sMGtSZU0HO8NAKb8Ow2EVR7hrQRUVGDYjifb+WyJ8p1TOaUueYUorNDlzasrt5e
         nIDDL4dOXkOIZgmbqyBHm1Digb4sY7DnRLcDCtqztcySZFNIjagFUwn75DrJc2OyBgHI
         XW0EJr41sz7biU98YQ7A3OBwRAMDuTx9ZZLVgKgSa+Bn3+lOlcXF7Po4mAmzcd6jteBW
         alKTLBugea5aSphDOlMFSH2+ZJc6aBfJUAJ4S56OEokpoyvVe+2Fv3LRMAZEw44HOhj1
         Jsg8O9qD1skBMkWypOCJTNjtRL9CxJDHLDkprEruV97iDBU50l2pGrqOAaFgAMbQFvC9
         3YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os/Pu/ytp1Ibc8eJhaBf3RWMghtAOmFyabVWn60UWeE=;
        b=LWa5TDn8ZM3hd4XrA00d3GP7/NdHRvVfXt2Skurrp5mqiiTCizsTHU571DVIgqKQOv
         H2IDs+6FScnTXmyEQxFEFzAaTwObNW3gCqWAwhXWPD2ctswE2SOj5bVcCIdWjhrCdXSM
         /FNmj4NgpVXhKy4nhy8UYEUYTjtDeOhcrmwVALIMjf4JibnRZMta7lI+0UNc4k6wtXEu
         edItoqx3TDC8EGpwfyZ+mrvW2zwQtFwA8TRX4yn+AB6jVoqc+jAeyMdL1SPj2rbVcmSs
         yYy4HuD9j8lSHWxhc1nm+aU/KCji9XkiHXCDrRBK/y/7iFZnJdOjPhzWj+cZYEzv4Wkx
         8c1w==
X-Gm-Message-State: AO0yUKXXXf2NchyTAU86bGMI7wECXCkEa4TEcmP0YtlrL4gLQ24p0CQM
        gXnDhL4ztWrj3jaumlbpgRXPPA==
X-Google-Smtp-Source: AK7set/1tDyZOmr9NeHyiA+DvIFIP6+HQ+LlDLNyXkj/u+3DXu9qyEFqG5yjJimmW874DmxSBGzAbg==
X-Received: by 2002:a05:600c:1695:b0:3dc:561a:79e7 with SMTP id k21-20020a05600c169500b003dc561a79e7mr1294842wmn.2.1676363476339;
        Tue, 14 Feb 2023 00:31:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003de8a1b06c0sm19380466wml.7.2023.02.14.00.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:31:15 -0800 (PST)
Message-ID: <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
Date:   Tue, 14 Feb 2023 09:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213200519.889503-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 21:05, Sergio Paracuellos wrote:
> MT7621 SoC has a system controller node. Watchdog need to access to reset
> status register. Ralink architecture and related driver are old and from
> the beggining they are using some architecture dependent operations for
> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
> header file. However this is not ideal from a driver perspective which can
> just access to the system controller registers in an arch independent way
> using regmap syscon APIs. Update Kconfig accordingly to select new added
> dependencies and allow driver to be compile tested.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/watchdog/Kconfig      |  4 +++-
>  drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b64bc49c7..cf752ad64 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>  config MT7621_WDT
>  	tristate "Mediatek SoC watchdog"
>  	select WATCHDOG_CORE
> -	depends on SOC_MT7620 || SOC_MT7621
> +	select REGMAP_MMIO
> +	select MFD_SYSCON
> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>  	help
>  	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>  
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 40fb2c9ba..22e979bdd 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -15,8 +15,8 @@
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
> -
> -#include <asm/mach-ralink/ralink_regs.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #define SYSC_RSTSTAT			0x38
>  #define WDT_RST_CAUSE			BIT(1)
> @@ -34,6 +34,7 @@
>  struct mt7621_wdt_data {
>  	void __iomem *base;
>  	struct reset_control *rst;
> +	struct regmap *sysc;
>  	struct watchdog_device wdt;
>  };
>  
> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>  	return 0;
>  }
>  
> -static int mt7621_wdt_bootcause(void)
> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>  {
> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> +	u32 val;
> +
> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
> +	if (val & WDT_RST_CAUSE)
>  		return WDIOF_CARDRESET;
>  
>  	return 0;
> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> +	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
> +	if (IS_ERR(drvdata->sysc))
> +		return PTR_ERR(drvdata->sysc);

This should be the backup/error path for original code using syscon
property. Looking up by compatible is really not portable/re-usable.

Best regards,
Krzysztof

