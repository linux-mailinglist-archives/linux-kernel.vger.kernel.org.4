Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3706E6AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjDRRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjDRRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:10:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819311BF4;
        Tue, 18 Apr 2023 10:10:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx14so7742182pjb.1;
        Tue, 18 Apr 2023 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837841; x=1684429841;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v9/GW8QVbxE1ZdYlGz5z9o7uoIPAXojSN9r8NIsUNqc=;
        b=fLLVxY/YrjGl+Npho8mVrk/4stUY0RGx8UwtBU0h+y1OZ9TZZ+AJUHVbAp8QuUp2T5
         EGdmJ2vGScz7Cr4e4vqG7pXqiQCmvcxUUk9zlEub5qHxhCfvHhW32LfQrT/41e0/bfcl
         L4vzNiH4t3VJ/frrUlbeTl7IL3KQXhBsdhwUJzFMrCWE1+ycHur5eyNzTS1J9RG8y5/r
         ovrjSkhCJ21BtQynhDKJEPTlOtC4InB8jmzyqOxd0wHHz6eEpggmH6g1Sz/ah8fa/ZiL
         Yh2tDqNfENNR27Wwo8NE2nMDekt5pXK5JDBjrVJTOxeZutim/koGxBTyq9fM8FIT3QnZ
         iRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837841; x=1684429841;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9/GW8QVbxE1ZdYlGz5z9o7uoIPAXojSN9r8NIsUNqc=;
        b=YEn829NWmR8Habsd5MuJR5KBMNhb24uW0s3r5y3Uu819F+pf14P2OGU3HmukhReK7v
         zvYQXv8eFPNZQt6AOIGRQiCe75NhtVbgqvOSBLLo80BoG3vS3bTVHsv3XC+62OnMeJ2I
         EnV2RhqjEgIcvhFssRzmMf133xLp96UTfZ3C3CaodpLMR75AmPHRFsDsaHzWzpQGdl0C
         5YL4BoN+1ugDaRZAlvSs0iWFrxZ1JqsLwwfi286bWULhWn1O/Yw4crugQ/l3Txl2N/Tv
         RxFXEF/d38dQyNNNIlaYUMoBnG1sdLa6PBuz2/hJrg6qTJKwkFGLCf9wf2IDogc5HmTm
         +OIQ==
X-Gm-Message-State: AAQBX9dhKJxV+9mdzdd6PS5tWOYYa5nIz/UPG6LqLxZT0vwTAHdMsQ08
        pnZ+aGf1LsFw36m5UCU2f1k=
X-Google-Smtp-Source: AKy350Ycu1s3uqKXnMl43/XjRD1ndQuVF+x5YIet3HK+mZJ4eRekYphF/TLrfybfZ3Z9fIooA/J+VA==
X-Received: by 2002:a05:6a20:2d13:b0:ec:60b9:c724 with SMTP id g19-20020a056a202d1300b000ec60b9c724mr366151pzl.33.1681837840849;
        Tue, 18 Apr 2023 10:10:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78689000000b0063d24fcc2b7sm3399901pfo.1.2023.04.18.10.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:10:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56ed0256-c287-cf96-ddff-ba1bd5923814@roeck-us.net>
Date:   Tue, 18 Apr 2023 10:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/9] hwmon: (gxp_fan_ctrl) Give GPIO access to fan data
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@armlinux.org.uk, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-3-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230418152824.110823-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 08:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The fan driver has access to the IO that reports fan presence.
> Add the ability for other drivers such as GPIO to call in
> to get fan information. Also remove the system power check as
> the GPIO driver needs it to report power state.
> 

Sorry, I am lost right here. Why would "gpio" want to know about
or report fan information ?

Guenter

> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>   drivers/hwmon/gxp-fan-ctrl.c | 58 +++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
> index 0014b8b0fd41..a8fcea98cc55 100644
> --- a/drivers/hwmon/gxp-fan-ctrl.c
> +++ b/drivers/hwmon/gxp-fan-ctrl.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
>   
>   #include <linux/bits.h>
>   #include <linux/err.h>
> @@ -11,15 +11,14 @@
>   
>   #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
>   #define OFS_FAN_FAIL	2 /* Is 2 bytes after base */
> -#define OFS_SEVSTAT	0 /* Is 0 because fn2 base will be set at SEVSTAT */
> -#define POWER_BIT	24
>   
>   struct gxp_fan_ctrl_drvdata {
>   	void __iomem	*base;
>   	void __iomem	*plreg;
> -	void __iomem	*fn2;
>   };
>   
> +struct gxp_fan_ctrl_drvdata *drvdata;
> +
>   static bool fan_installed(struct device *dev, int fan)
>   {
>   	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> @@ -30,6 +29,16 @@ static bool fan_installed(struct device *dev, int fan)
>   	return !!(val & BIT(fan));
>   }
>   
> +u8 get_fans_installed(void)
> +{
> +	static u8 val;
> +
> +	val = readb(drvdata->plreg + OFS_FAN_INST);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(get_fans_installed);
> +
>   static long fan_failed(struct device *dev, int fan)
>   {
>   	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> @@ -40,19 +49,19 @@ static long fan_failed(struct device *dev, int fan)
>   	return !!(val & BIT(fan));
>   }
>   
> -static long fan_enabled(struct device *dev, int fan)
> +u8 get_fans_failed(void)
>   {
> -	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u32 val;
> +	static u8 val;
>   
> -	/*
> -	 * Check the power status as if the platform is off the value
> -	 * reported for the PWM will be incorrect. Report fan as
> -	 * disabled.
> -	 */
> -	val = readl(drvdata->fn2 + OFS_SEVSTAT);
> +	val = readb(drvdata->plreg + OFS_FAN_FAIL);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(get_fans_failed);
>   
> -	return !!((val & BIT(POWER_BIT)) && fan_installed(dev, fan));
> +static long fan_enabled(struct device *dev, int fan)
> +{
> +	return !!(fan_installed(dev, fan));
>   }
>   
>   static int gxp_pwm_write(struct device *dev, u32 attr, int channel, long val)
> @@ -98,20 +107,8 @@ static int gxp_fan_read(struct device *dev, u32 attr, int channel, long *val)
>   static int gxp_pwm_read(struct device *dev, u32 attr, int channel, long *val)
>   {
>   	struct gxp_fan_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> -	u32 reg;
> -
> -	/*
> -	 * Check the power status of the platform. If the platform is off
> -	 * the value reported for the PWM will be incorrect. In this case
> -	 * report a PWM of zero.
> -	 */
>   
> -	reg = readl(drvdata->fn2 + OFS_SEVSTAT);
> -
> -	if (reg & BIT(POWER_BIT))
> -		*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
> -	else
> -		*val = 0;
> +	*val = fan_installed(dev, channel) ? readb(drvdata->base + channel) : 0;
>   
>   	return 0;
>   }
> @@ -198,7 +195,6 @@ static const struct hwmon_chip_info gxp_fan_ctrl_chip_info = {
>   
>   static int gxp_fan_ctrl_probe(struct platform_device *pdev)
>   {
> -	struct gxp_fan_ctrl_drvdata *drvdata;
>   	struct device *dev = &pdev->dev;
>   	struct device *hwmon_dev;
>   
> @@ -218,12 +214,6 @@ static int gxp_fan_ctrl_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(drvdata->plreg),
>   				     "failed to map plreg\n");
>   
> -	drvdata->fn2 = devm_platform_ioremap_resource_byname(pdev,
> -							     "fn2");
> -	if (IS_ERR(drvdata->fn2))
> -		return dev_err_probe(dev, PTR_ERR(drvdata->fn2),
> -				     "failed to map fn2\n");
> -
>   	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>   							 "hpe_gxp_fan_ctrl",
>   							 drvdata,

