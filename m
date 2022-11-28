Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592A963B4EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiK1Wll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiK1Wli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:41:38 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452727B0D;
        Mon, 28 Nov 2022 14:41:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso7976828otb.2;
        Mon, 28 Nov 2022 14:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga2AFPqf+gTDBYqsAVJkXfVAY13WZXbPsy5HJCs9BCM=;
        b=DuHXtFZ5/JSWlTV2FmPPeGDXGNAul/RqH5GkQfyvIELEFPiZeQAeeI1pA3Kkag+EnP
         cinzX5AJ26WDlEz26hHmZVOiN2ma9DTaVtShatmA+Jld2oEql/33tFKQf389zz3kP7j6
         VTS34QGwSJdkjn8S/VpZ21f08d6NnL3s8CDhDfaBDwy6bc2Dp13qVEyk0lEViHSMQJI8
         YH55QuYGztrgGSdDU0VPllqcNedqEWjae6tI4cln7wy6kWTzVddiLQohxAUPQLPOasaa
         +TDGBY5ke5J8fkgkJ7La+AgV/fEh7dXUdR+AP1LUaOjZwIb8tFWR3Oi28IivLNL26e66
         tTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga2AFPqf+gTDBYqsAVJkXfVAY13WZXbPsy5HJCs9BCM=;
        b=7YgRznci4Ey1+0MHiFI1cSJVCfPvUaqWyjp7Rt3MVaznXABOfTncbsfk8qQ/pPZ52d
         hCMrcu6zZDqD1twQL73Zyeo6zvJRvdyh/J9zITq+m9NySwUrAIHImeyhPGeRWzlZBCdW
         wZEJUPdh9QOm2LSZLciP2JNtYNcT5+TpFsd8a9ZFi44Z/WJLzWHIy5h8YFLK7Pt/y9p3
         z02+LWex+BMqiJA8i9aBPGirXZt6PY/lxIL91BxRvK9x+W3gHrMMAqdc5g84745ZZUKu
         /HBO2TrthUdTKDqXonGHEtsVK3Ktk8txcl/FTDUFZ25EvZeu00FXdvDN04FENcyrgroC
         CkMg==
X-Gm-Message-State: ANoB5pm160SmqV7hvgYrrnTHAl2hyblxem0K77tjdnFPTn2GWx6vtRhl
        LrcY4sDwPCQeIiMXe8BBBw+YJZc8Yis=
X-Google-Smtp-Source: AA0mqf5drTj3QQbMC/lKkn72aMWXQ9uySToimtMI7BoD5FyY9Y7V5m7+dZNYpo7ogWeICF4ccOs/Bw==
X-Received: by 2002:a9d:6d93:0:b0:66c:7306:1d57 with SMTP id x19-20020a9d6d93000000b0066c73061d57mr27182652otp.134.1669675296300;
        Mon, 28 Nov 2022 14:41:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9-20020a4a4309000000b004956ee06cadsm4799000ooj.43.2022.11.28.14.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:41:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bbba5774-b886-df08-1263-7e3489b84a8e@roeck-us.net>
Date:   Mon, 28 Nov 2022 14:41:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/core): Update regulator flag map
In-Reply-To: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 09:47, Naresh Solanki wrote:
> Add regulator flag map for PMBUS status byte & status input.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

You are adding a lot of input errors here. The regulator documentation
only covers output errors. I am not sure if this set of changes is
really appropriate. You'll have to make a much better case for those changes;
from what I can see they are all controversial and were originally left out
on purpose.

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..f5caceaaef2a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>   
>   static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>   	{
> +		.func = -1,

This would need a comment. I don't really see the benefit over the original
code.

> +		.reg = PMBUS_STATUS_BYTE,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ },
> +		},
> +	}, {
>   		.func = PMBUS_HAVE_STATUS_VOUT,
>   		.reg = PMBUS_STATUS_VOUT,
>   		.bits = (const struct pmbus_regulator_status_assoc[]) {
> @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>   			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
>   			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>   			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },

OP_FAULT (power fault) and over current are really not the same thing.

>   			{ },
>   		},
>   	}, {
> @@ -2778,6 +2788,18 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>   			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>   			{ },
>   		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_INPUT,
> +		.reg = PMBUS_STATUS_INPUT,
> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> +			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_OVER_VOLTAGE_WARN },

fault -> warning ? Shouldn't this be REGULATOR_ERROR_FAIL (Regulator
output has failed) ?

> +			{ },
> +		},
>   	},
>   };
>   
> @@ -2834,14 +2856,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>   		if (status & PB_STATUS_POWER_GOOD_N)
>   			*flags |= REGULATOR_ERROR_REGULATION_OUT;
>   	}
> -	/*
> -	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
> -	 * defined strictly as fault indicators (not warnings).
> -	 */
> -	if (status & PB_STATUS_IOUT_OC)
> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> -	if (status & PB_STATUS_VOUT_OV)
> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>   
>   	/*
>   	 * If we haven't discovered any thermal faults or warnings via
> 
> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c

