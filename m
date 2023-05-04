Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8F6F68D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEDKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:05:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F75344AB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:05:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52c30fa5271so107489a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1683194753; x=1685786753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnxT4ZRfFkOUgeGJFUL3pKXqZajlKUzn/VUzJye8n9Q=;
        b=Q/rXGMOPaspZzINpzYaopzplP9V5WajKFCwnQfQuE2XGUeZUJI7Z6cPPHKwDPnybiD
         RXtChs+jOWAfQGwrqD/IiJpk2AbW7zhT5MG3AiBvpYO66CS5On5aC5zAMkvLSGhNoSpo
         82MKrHOXWFCMc8gDwBKVu5B24dvVBjBYK9kzkh0QE+0icK6OlbnZuhhgTbwDMrZS4Z9a
         RfU1GOP2GBsm92MsvvV76N5tkYEb3WLS2BbdBmm46MVvDcHxVfsgnRm6wYVcApi/Ums+
         geFty5NL72vzE78RCmKZ2Nx1naEQmphh3r0Lj4sTkHMgk6zW85moSFrEKeIplkU/ACd5
         Ru4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194753; x=1685786753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnxT4ZRfFkOUgeGJFUL3pKXqZajlKUzn/VUzJye8n9Q=;
        b=Agjs70KbjX/j8klP5yRYy6ibeKwy5FLmskV3B2A3BUhOKK8HrwkgGMxJbx5Aljx3bs
         8/AA0kDbV08gj8kurATmSaPZdjUYm8Dnxbsqf9hmQl6OJvtYYOKaT9N/y1xarvknp0pU
         +T/dD3y5/Rz0Wq0vD7XFuqhc9Pn6Q3BvX4ruClnIxUaKk92ni9R14ipUEAlDwV7Nxcjg
         on9Uq1k3NO2RJI5NRb6QEjUWZKasTeYNpbBJX4qyng863nQKofa2YQucEZ+oAQPoLNzA
         2Sxk6qAFdpYblVJ4xH9M+lIBwBTVPQMmo05Ib7kbqReNxncE4WuCVGWs7M1SACLiRJOs
         du8w==
X-Gm-Message-State: AC+VfDxr0tFu3b/TNWzRbmmdM0AOgnCv2R/7HVbesEqcTrxnss+OS1/P
        KkKAPQ/U/8T/3WdrDVeHP1p8pw==
X-Google-Smtp-Source: ACHHUZ43nZ8efs30+jc0/x6aqhrhRR1Fmabm7CAbhK2duPrOfTnsJbA/rEn1D9NdB9UedUoTqcC9LA==
X-Received: by 2002:a17:90b:4f44:b0:24e:277a:c02c with SMTP id pj4-20020a17090b4f4400b0024e277ac02cmr1638066pjb.23.1683194752930;
        Thu, 04 May 2023 03:05:52 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b001a95f632340sm19901878plo.46.2023.05.04.03.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:05:52 -0700 (PDT)
Message-ID: <27b26cb4-14b2-57c2-7b57-167ca17b6a15@9elements.com>
Date:   Thu, 4 May 2023 15:35:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I hope this email finds you well. I am writing to inquire about the 
status of my patch.

The purpose of this patch set was to rename the driver to remove the 
wildcard and make it specific to avoid confusion with different similar 
devices. I want to emphasize that this patch set does not include any 
functional changes.

I would appreciate it if you could kindly provide an update on the 
status. Please let me know if there is anything else you need from my 
end to help move things forward.

Thank you for your time and attention.

Best regards,
Naresh Solanki

On 27-04-2023 05:00 pm, Naresh Solanki wrote:
> The previous version of this driver included wildcards in file names
> and descriptions. This patch renames the driver to only support MAX5970
> and MAX5978, which are the only chips that the driver actually supports.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/mfd/Kconfig                        |  4 ++--
>   drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
>   include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
>   3 files changed, 19 insertions(+), 19 deletions(-)
>   rename include/linux/mfd/{max597x.h => max5970.h} (92%)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e90463c4441c..71231388e03c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -266,8 +266,8 @@ config MFD_MADERA_SPI
>   	  Support for the Cirrus Logic Madera platform audio SoC
>   	  core functionality controlled via SPI.
>   
> -config MFD_MAX597X
> -	tristate "Maxim 597x power switch and monitor"
> +config MFD_MAX5970
> +	tristate "Maxim 5970/5978 power switch and monitor"
>   	depends on (I2C && OF)
>   	select MFD_SIMPLE_MFD_I2C
>   	help
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 20782b4dd172..1f1c007560d8 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -72,22 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
>   	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
>   };
>   
> -static const struct mfd_cell max597x_cells[] = {
> -	{ .name = "max597x-regulator", },
> -	{ .name = "max597x-iio", },
> -	{ .name = "max597x-led", },
> +static const struct mfd_cell max5970_cells[] = {
> +	{ .name = "max5970-regulator", },
> +	{ .name = "max5970-iio", },
> +	{ .name = "max5970-led", },
>   };
>   
> -static const struct simple_mfd_data maxim_max597x = {
> -	.mfd_cell = max597x_cells,
> -	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
> +static const struct simple_mfd_data maxim_max5970 = {
> +	.mfd_cell = max5970_cells,
> +	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
>   };
>   
>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
>   	{ .compatible = "kontron,sl28cpld" },
>   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> -	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
> -	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
> +	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
> +	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max5970.h
> similarity index 92%
> rename from include/linux/mfd/max597x.h
> rename to include/linux/mfd/max5970.h
> index a850b2e02e6a..762a7d40c843 100644
> --- a/include/linux/mfd/max597x.h
> +++ b/include/linux/mfd/max5970.h
> @@ -7,25 +7,25 @@
>    * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>    */
>   
> -#ifndef _MFD_MAX597X_H
> -#define _MFD_MAX597X_H
> +#ifndef _MFD_MAX5970_H
> +#define _MFD_MAX5970_H
>   
>   #include <linux/regmap.h>
>   
>   #define MAX5970_NUM_SWITCHES 2
>   #define MAX5978_NUM_SWITCHES 1
> -#define MAX597X_NUM_LEDS     4
> +#define MAX5970_NUM_LEDS     4
>   
> -struct max597x_data {
> +struct max5970_data {
>   	int num_switches;
>   	u32 irng[MAX5970_NUM_SWITCHES];
>   	u32 mon_rng[MAX5970_NUM_SWITCHES];
>   	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>   };
>   
> -enum max597x_chip_type {
> -	MAX597x_TYPE_MAX5978 = 1,
> -	MAX597x_TYPE_MAX5970,
> +enum max5970_chip_type {
> +	TYPE_MAX5978 = 1,
> +	TYPE_MAX5970,
>   };
>   
>   #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> @@ -93,4 +93,4 @@ enum max597x_chip_type {
>   #define MAX_REGISTERS			0x49
>   #define ADC_MASK			0x3FF
>   
> -#endif				/* _MFD_MAX597X_H */
> +#endif				/* _MFD_MAX5970_H */
> 
> base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b
