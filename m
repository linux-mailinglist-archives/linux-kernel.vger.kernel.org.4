Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5904F717D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjEaLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjEaLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:03:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B71BD
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:03:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso42758515e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685531007; x=1688123007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v93ZbMKO58LL5vx+lV1GwU1ith43BPnZGFvn1Vgq9JY=;
        b=gA6eSKfAXVZeF/bSM1j+FFTKIrF9mv8nws7Bkg2cIcl1M5XdJR4HX0W1CvRVJaA/BY
         5KC3lh7ljtXldnJMAdz3J729wyQgZg/D1TLvzg+hQ5nwItQPrHxjnm+ST8sU+LfD4yeU
         6hMWz3fV9FDAQJ8d3yMgMdIOHyhjC9o9J7y3J1TrBG6R6gPL+DBe5plWdLSc3KMxacPb
         8/NleXZqL4El8YSb8IZc0+JZ+lUkXDEIHPB1qOqd4cQNkVVQin4dwXfmrFiC1Y4vQZCp
         lBIR69wOLclu00fppcZGayFzddtimoJNHlCWaLyjZflj3PiORYcdqxdc8XurdRepgcNX
         srZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531007; x=1688123007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v93ZbMKO58LL5vx+lV1GwU1ith43BPnZGFvn1Vgq9JY=;
        b=Xm519FNSG7sZ5CqXK3IaB2RM28cwwR02BCXE5mi400MJYE70dT/NJolLiWRenQI8AW
         Sf79LDBD3CDXgy4E7WGbB+rHTVS8Lnq12Qefq50yJu/AXI141rHw/MfvLHlABNezZjH0
         He/5Be99iGr5ro+h+TzFpvSXONA5Wqu56TW2/XuxlPAHuYCO1Y7b0ms2aolVBG0JcNuq
         2GstQoGcLNHhidK5u0alifNFkY5OiUsDOwOvL/jznst16Hd8adqVvU2S05dTtxXGqmYK
         rBCxjh+nR9wQ/crso9dN3aer73GEzcLSpjob8aYR2HzgBnaZ8BDbAZN7MC8/9rCMS+cQ
         H/6A==
X-Gm-Message-State: AC+VfDx+EBhYTYKAvx6bU+3sfU+sTZezoxcmbIivaAfAcxaRWKN1B6Sd
        dGfbJWfNnXjVRKVRkO0glONifA==
X-Google-Smtp-Source: ACHHUZ6w3ErE/r1efRAcM36QXY4A1eDCS0M1Vw7N280WK6sMLULfBLmH/G99jw51yimukua45hHOjw==
X-Received: by 2002:a7b:ca59:0:b0:3f6:a81:eb52 with SMTP id m25-20020a7bca59000000b003f60a81eb52mr3410263wml.21.1685531007049;
        Wed, 31 May 2023 04:03:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7a1b:d710:7226:da18? ([2a05:6e02:1041:c10:7a1b:d710:7226:da18])
        by smtp.googlemail.com with ESMTPSA id n14-20020a1c720e000000b003f4b6bcbd8bsm20527638wmc.31.2023.05.31.04.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 04:03:26 -0700 (PDT)
Message-ID: <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
Date:   Wed, 31 May 2023 13:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, rafael@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <20230516083746.63436-3-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230516083746.63436-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There are MAX 16 sensors, but not all of them supported. Such as
> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
> touch reserved bits from i.MX8MQ reference mannual, and TMU will stuck,
> temperature will not update anymore.
> 
> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before registering them")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index b806a0929459..53748c4a5be1 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -31,7 +31,6 @@
>   #define TMR_DISABLE	0x0
>   #define TMR_ME		0x80000000
>   #define TMR_ALPF	0x0c000000
> -#define TMR_MSITE_ALL	GENMASK(15, 0)
>   
>   #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
>   #define TMTMIR_DEFAULT	0x0000000f
> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>   	 * within sensor range. TEMP is an 9 bit value representing
>   	 * temperature in KelVin.
>   	 */
> +
> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> +	if (!(val & TMR_ME))
> +		return -EAGAIN;

How is this change related to what is described in the changelog?

>   	if (regmap_read_poll_timeout(qdata->regmap,
>   				     REGS_TRITSR(qsensor->id),
>   				     val,
> @@ -128,15 +132,7 @@ static const struct thermal_zone_device_ops tmu_tz_ops = {
>   static int qoriq_tmu_register_tmu_zone(struct device *dev,
>   				       struct qoriq_tmu_data *qdata)
>   {
> -	int id;
> -
> -	if (qdata->ver == TMU_VER1) {
> -		regmap_write(qdata->regmap, REGS_TMR,
> -			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> -	} else {
> -		regmap_write(qdata->regmap, REGS_V2_TMSR, TMR_MSITE_ALL);
> -		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
> -	}
> +	int id, sites = 0;
>   
>   	for (id = 0; id < SITES_MAX; id++) {
>   		struct thermal_zone_device *tzd;
> @@ -153,14 +149,26 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>   			if (ret == -ENODEV)
>   				continue;
>   
> -			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
>   			return ret;
>   		}
>   
> +		if (qdata->ver == TMU_VER1)
> +			sites |= 0x1 << (15 - id);
> +		else
> +			sites |= 0x1 << id;
> +
>   		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
>   			dev_warn(dev,
>   				 "Failed to add hwmon sysfs attributes\n");
> +	}
>   
> +	if (sites) {
> +		if (qdata->ver == TMU_VER1) {
> +			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF | sites);
> +		} else {
> +			regmap_write(qdata->regmap, REGS_V2_TMSR, sites);
> +			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
> +		}
>   	}
>   
>   	return 0;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

