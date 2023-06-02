Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AFA71FC82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjFBItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjFBIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:48:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740351B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:48:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so17412245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685695713; x=1688287713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hy7ZWgwvbQw0vF/j44DrE+pxcxlkHmF/+G3M51v+f2Y=;
        b=UvECccFHPDOZZjOqEWbW35gXhOHqQaqYC8jpmi8noSSduan5Ls0a9rI2ViSkjq5IdO
         F7qf/DcGydpfz1XSvpU3XFjDS8QyPRahRVrLV4jgk/jKPZWbo25hETwcJhe/AidT9fFq
         fYvMIvLP8PlKnd5KEmYoiKXJv464N1oayK0otffMCh2hSapCl0leD9ISOAOHggzwDMdJ
         mqOytqN8lC7fhpvRZelksmgCaftQHwhCSzVk/rTENPiYseUjOppiER9l4rFNKA1DEuDq
         nXZ7CXU+JwZSI3ol9LNDxuIO3lJf93V/AvIwDzSh0Kt9c4f//1K1wrqQ5j2yJGttZJeR
         s/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695713; x=1688287713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy7ZWgwvbQw0vF/j44DrE+pxcxlkHmF/+G3M51v+f2Y=;
        b=f4GzVYyMdFbwVfm+DZG4iyXRi0xjxyjIetOMEbEEUztRzPCS+Q+ti3L8GsK05NckFm
         JZZcncJ1GBi09Q3t8U89TvPn6s2eM11r2eLDy5aLKlM29O6lTJWf71D2lOVfJRQ0GQjK
         AkDqaIG/UaDZp3Ooic6Bz/JvHJrDWuz6uT+7vlFKOmiU6PkzVUOpI5nB1lbdIzkglwRv
         Hc1zt82Lpu/ZltS0EjSjJvWpRBTubibm9hP1513YaZtdBxhypom2zZsy2YVvQrUP6uTe
         qbIe+jRwryDzjMf5NXoUEht5JqsZu6sDDSmocNMJmABCQM3YEHIt9C+/jCi68Q/BDK9F
         MjVQ==
X-Gm-Message-State: AC+VfDymKNYdJW2b6CM07nmJeGHYEmG+yJR3RLRJFcpkBbRKEHIZsk2a
        cQDr12aK765c5mmgo7E8J3Q+NA==
X-Google-Smtp-Source: ACHHUZ4D84wQyp47giQRpl65CGko8rey1F9ShVN6NGtUak9BS4hDjYgHB3xL2Np6FnsSeXDKWbtBGQ==
X-Received: by 2002:a05:600c:2045:b0:3f6:c7b:d3b7 with SMTP id p5-20020a05600c204500b003f60c7bd3b7mr1377479wmg.37.1685695712781;
        Fri, 02 Jun 2023 01:48:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:548f:8f7e:a3c2:888a? ([2a05:6e02:1041:c10:548f:8f7e:a3c2:888a])
        by smtp.googlemail.com with ESMTPSA id l4-20020a1c7904000000b003f5ffba9ae1sm1234932wme.24.2023.06.02.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:48:32 -0700 (PDT)
Message-ID: <b0576c2c-9249-1759-642f-b0accabfc773@linaro.org>
Date:   Fri, 2 Jun 2023 10:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/6] thermal/drivers/mediatek/lvts_thermal: Honor
 sensors in immediate mode
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230504004852.627049-1-nfraprado@collabora.com>
 <20230504004852.627049-3-nfraprado@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230504004852.627049-3-nfraprado@collabora.com>
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

On 04/05/2023 02:48, Nícolas F. R. A. Prado wrote:
> Each controller can be configured to operate on immediate or filtered
> mode. On filtered mode, the sensors are enabled by setting the
> corresponding bits in MONCTL0, while on immediate mode, by setting
> MSRCTL1.
> 
> Previously, the code would set MSRCTL1 for all four sensors when
> configured to immediate mode, but given that the controller might not
> have all four sensors connected, this would cause interrupts to trigger
> for non-existent sensors. Fix this by handling the MSRCTL1 register
> analogously to the MONCTL0: only enable the sensors that were declared.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/thermal/mediatek/lvts_thermal.c | 50 +++++++++++++------------
>   1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 2988f201633a..f7d998a45ea0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -922,24 +922,6 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   			LVTS_HW_FILTER << 3 | LVTS_HW_FILTER;
>   	writel(value, LVTS_MSRCTL0(lvts_ctrl->base));
>   
> -	/*
> -	 * LVTS_MSRCTL1 : Measurement control
> -	 *
> -	 * Bits:
> -	 *
> -	 * 9: Ignore MSRCTL0 config and do immediate measurement on sensor3
> -	 * 6: Ignore MSRCTL0 config and do immediate measurement on sensor2
> -	 * 5: Ignore MSRCTL0 config and do immediate measurement on sensor1
> -	 * 4: Ignore MSRCTL0 config and do immediate measurement on sensor0
> -	 *
> -	 * That configuration will ignore the filtering and the delays
> -	 * introduced below in MONCTL1 and MONCTL2
> -	 */
> -	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE) {
> -		value = BIT(9) | BIT(6) | BIT(5) | BIT(4);
> -		writel(value, LVTS_MSRCTL1(lvts_ctrl->base));
> -	}
> -
>   	/*
>   	 * LVTS_MONCTL1 : Period unit and group interval configuration
>   	 *
> @@ -1004,6 +986,8 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   	struct lvts_sensor *lvts_sensors = lvts_ctrl->sensors;
>   	struct thermal_zone_device *tz;
>   	u32 sensor_map = 0;
> +	u32 sensor_map_bits[][4] = {{BIT(4), BIT(5), BIT(6), BIT(9)},
> +				    {BIT(0), BIT(1), BIT(2), BIT(3)}};

Even correct, this initialization sounds prone to error and a bit 
obfuscating (eg. it assumes LVTS_MSR_IMMEDIATE_MODE is 1).

What about?

	/*
	 * A description
	 */
	u32 sensor_imm_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
	u32 sensor_filt_bitmap[] = { BIT(4), BIT(5), BIT(6), BIT(9) };

	u32 *sensor_bitmap = lvts_ctrl->mode ? LVTS_MSR_IMMEDIATE_MODE : 
sensor_imm_bitmap : sensor_filt_bitmap;

>   	int i;
>   
>   	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++) {
> @@ -1040,20 +1024,38 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   		 * map, so we can enable the temperature monitoring in
>   		 * the hardware thermal controller.
>   		 */
> -		sensor_map |= BIT(i);
> +		sensor_map |= sensor_map_bits[lvts_ctrl->mode][i];

		sensor_map |= sensor_bitmap[i];
>   	}
>   
>   	/*
> -	 * Bits:
> -	 *      9: Single point access flow
> -	 *    0-3: Enable sensing point 0-3
> -	 *
>   	 * The initialization of the thermal zones give us
>   	 * which sensor point to enable. If any thermal zone
>   	 * was not described in the device tree, it won't be
>   	 * enabled here in the sensor map.
>   	 */
> -	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> +	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE) {
> +		/*
> +		 * LVTS_MSRCTL1 : Measurement control
> +		 *
> +		 * Bits:
> +		 *
> +		 * 9: Ignore MSRCTL0 config and do immediate measurement on sensor3
> +		 * 6: Ignore MSRCTL0 config and do immediate measurement on sensor2
> +		 * 5: Ignore MSRCTL0 config and do immediate measurement on sensor1
> +		 * 4: Ignore MSRCTL0 config and do immediate measurement on sensor0
> +		 *
> +		 * That configuration will ignore the filtering and the delays
> +		 * introduced in MONCTL1 and MONCTL2
> +		 */
> +		writel(sensor_map, LVTS_MSRCTL1(lvts_ctrl->base));
> +	} else {
> +		/*
> +		 * Bits:
> +		 *      9: Single point access flow
> +		 *    0-3: Enable sensing point 0-3
> +		 */
> +		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> +	}
>   
>   	return 0;
>   }

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

