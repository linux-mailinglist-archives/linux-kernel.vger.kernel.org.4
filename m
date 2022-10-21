Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF8607F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:00:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BED83F19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:00:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e18so9872066edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CXA7NBKJhbyQ+EdenvYp8r+3f9JP5q2a9GVA7vCeN8=;
        b=CBC2/GXXnbZUWAZDzfhTnLAZLySL7rkXoxEVMQIqWu1o4bzRmM/DYnMda0cWuU3V69
         wt3ICkwALLMbYGUpW2VfSq6h9oGSTrMiHC+PIWn3GBM8vzWPAtiQ+iloXCO35/W3ulwE
         UVa1JojnMhWItSh7yjBFDEF7l4YtlJjYeN30g0kcPD89kfV6opaEd4+XunU8bTt6m2k5
         1jyj0STO8/1Gqkoz78W468jBB3QFfODj2BXl0Rsl2kSUMasij2f2ZBO044mD6ll8MmJc
         7gI4qrLqHhNAjec8KkSdPtVaXqgalhvUkCGatZL+3S15x9TvmnewGxN2sYoy0fOIVT7D
         BOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CXA7NBKJhbyQ+EdenvYp8r+3f9JP5q2a9GVA7vCeN8=;
        b=ULBqsx6dKYeZDaab4tg0fnKY+2aWzZf1YtlQT5jLTQ74fdWFEt05F07KdSpijhR2+B
         mTjhvtoei8kr7ueGvKUJtG9qBv7mEAvge16N/DDtFI6XkXqLC7g36ST/cbvlwpmTyB1D
         jNbAtv5SPt6XBENt5L/aoE5trWk9crIzkBl87yEDVNDxwm1qwaKj06eYLIz5GF2LH1uP
         Q2tYB1DdTA7X13xNNXZlm1TAdbtL8WxuDNoafHCMkkh1FwEWzbbBz53c+u0EQQ7FuM8S
         F3hfdGGnudPHcvP8m7Qceg4Qkq9Jv5IIFUMViQBvMuJE4ywY0zLxPRjCCCialGx1+JnL
         k39A==
X-Gm-Message-State: ACrzQf16vZrtr4S5zTfJTcTSjozlYm2L+iOnEcdL6nnd3oYwjqovYUk5
        uoG6GZ5OxVyjOqJFREC6cwMBJQ==
X-Google-Smtp-Source: AMsMyM6LOnPBaF7JJYo+fdBZOd0FXvFw8Gl+i1fVjwAKoeAuRTuRewXVTXiZkvH+Oc7Yu9gnyQB2WA==
X-Received: by 2002:a17:907:1ded:b0:78d:4606:268 with SMTP id og45-20020a1709071ded00b0078d46060268mr17235732ejc.163.1666382398525;
        Fri, 21 Oct 2022 12:59:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id g13-20020a170906538d00b0073d638a7a89sm12134425ejo.99.2022.10.21.12.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 12:59:58 -0700 (PDT)
Message-ID: <2aafa6cc-a7de-0b7a-571f-04593ad53787@linaro.org>
Date:   Fri, 21 Oct 2022 21:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] thermal: rockchip: Support RK3588 SoC in the thermal
 driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
 <20221021174721.92468-2-sebastian.reichel@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221021174721.92468-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 19:47, Sebastian Reichel wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> The RK3588 SoC has seven channels TS-ADC(TOP, BIG_CORE0, BIG_CORE1,
> LITTEL_CORE, CENTER, GPU, and NPU).

Is possible to give a more elaborate description of those sensors?

What is TOP and CENTER ?

There are 4 Bigs on this platform but two sensors ?


> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> [rebase, squash fixes]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/thermal/rockchip_thermal.c | 182 ++++++++++++++++++++++++++++-
>   1 file changed, 179 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 819e059cde71..82f475a6448f 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -61,10 +61,9 @@ enum adc_sort_mode {
>   #include "thermal_hwmon.h"
>   
>   /**
> - * The max sensors is two in rockchip SoCs.
> - * Two sensors: CPU and GPU sensor.
> + * The max sensors is seven in rockchip SoCs.
>    */
> -#define SOC_MAX_SENSORS	2
> +#define SOC_MAX_SENSORS	7

You may get rid of this and replace the sensors array to an dyn 
allocation based on chn_num

[ ... ]

> +static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
> +	/* top, big_core0, big_core1, little_core, center, gpu, npu */
> +	.chn_id = {0, 1, 2, 3, 4, 5, 6},

You may want to revisit that. Actually, chn_id is not useful and can be 
removed everywhere as there is no hole. Otherwise a bit mask could be 
used. By removing it, SENSOR_CPU and SENSOR_GPU can be removed too.

> +	.chn_num = 7, /* seven channels for tsadc
> +	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
> +	.tshut_temp = 95000,
> +	.initialize = rk_tsadcv8_initialize,
> +	.irq_ack = rk_tsadcv4_irq_ack,
> +	.control = rk_tsadcv4_control,
> +	.get_temp = rk_tsadcv4_get_temp,
> +	.set_alarm_temp = rk_tsadcv3_alarm_temp,
> +	.set_tshut_temp = rk_tsadcv3_tshut_temp,
> +	.set_tshut_mode = rk_tsadcv3_tshut_mode,
> +	.table = {
> +		.id = rk3588_code_table,
> +		.length = ARRAY_SIZE(rk3588_code_table),
> +		.data_mask = TSADCV4_DATA_MASK,
> +		.mode = ADC_INCREMENT,
> +	},
> +};
> +
>   static const struct of_device_id of_rockchip_thermal_match[] = {
>   	{	.compatible = "rockchip,px30-tsadc",
>   		.data = (void *)&px30_tsadc_data,
> @@ -1180,6 +1352,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
>   		.compatible = "rockchip,rk3568-tsadc",
>   		.data = (void *)&rk3568_tsadc_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3588-tsadc",
> +		.data = (void *)&rk3588_tsadc_data,
> +	},
>   	{ /* end */ },
>   };
>   MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
