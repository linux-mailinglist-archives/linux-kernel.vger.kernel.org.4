Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E767F0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjA0V4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjA0V4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:56:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A9303CD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:56:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so2067813wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqerTmqCpFsIa1KRiULFzNXiXHPUW2LZKvRlLneTfEQ=;
        b=H1Rk8VryoASg11PvNTDuM3J56d0mozernw4AtwgbYoJ7ZwsIPeyuMitK8grqsr67EX
         DfmazJbfDGjXUIjHoKI3avvpMUSqMdh1yi3dxMCDmbD19dCUMuv4bcrIVgRJjLI/8H9t
         XkVtziVt0NNICp6viBAM8mihP36nl5z4I7kW2l2Omf/SJ+LOQKMnGIEjQsbn9Bhb9V0E
         g9RoPw4fP29OPkGQ6NmP3hsBggLipBn3+ek2f7LEOrJn0swNTcHjwiuOpLMKOOXZK+Hc
         BTRhUfQVfCu+Dfjv0KjKrcMVoaygciwf63+E9Xr0YaGJsLxq/9JiLp4h7agpZV6bvui0
         W7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqerTmqCpFsIa1KRiULFzNXiXHPUW2LZKvRlLneTfEQ=;
        b=U9mu8NhA7JT5KI9lRq77Elylg6ql5E04oBHrD5YCO5W8v8gGO3sDjuh12ThXn4Z9zB
         cQROK2yX3tfuHT35dDdMqy/P44gj9J6GcDV06yOzxaXSk4jH2SDt+7yo/AzA4s+lApxk
         Ym1aruJAcb2Fjq+kNd7IVgA0lqM1UQc8bLJnHThY0QQBxMS70RafA31JyemgrK8vDoja
         JYNwqsyzozK6Qdrg5bAZjg428uWBF9Cm8P8wfvIJ8YGdmJCMPW1RUgKCyDNxv7wa8P/o
         QHYcGAPT5VXIWsIIJmNGQvKYOfAjCyX5doMV8m2NlXXdifwk/87Qd9FRgr8TufL0u3zk
         ObcQ==
X-Gm-Message-State: AO0yUKXKLlkhXl4cXQ0sKRLvgSJOHTdOs6t0AF24H9tuPxeJLnLR+Qdv
        3Yt9eHVOSbHaRaBblPuM9hXkHQ==
X-Google-Smtp-Source: AK7set8lhMsGxWKiTW9iwcGiaAKYO/4Li3ypSywT8chYJiXQdCLq5KfVH9nlyUMEAsyGxHXV+f9MaA==
X-Received: by 2002:a05:600c:3b02:b0:3dc:4296:6d56 with SMTP id m2-20020a05600c3b0200b003dc42966d56mr2330462wms.30.1674856566752;
        Fri, 27 Jan 2023 13:56:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h18-20020a05600c30d200b003c21ba7d7d6sm5298133wmn.44.2023.01.27.13.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 13:56:06 -0800 (PST)
Message-ID: <0cf41810-744c-9bbc-9a4d-abd686e14b9c@linaro.org>
Date:   Fri, 27 Jan 2023 22:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 4/5] thermal: mediatek: add callback for raw to
 mcelsius conversion
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
 <20221018-up-i350-thermal-bringup-v9-4-55a1ae14af74@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-4-55a1ae14af74@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
> Set a callback at probe time instead of checking the version at
> each get_sensor_temp().
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

This patch has been dropped because it is duplicate of patch:

https://lore.kernel.org/r/69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674055882.git.daniel@makrotopia.org



>   drivers/thermal/mtk_thermal.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 3a5df1440822..b8e06f6c7c42 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -307,6 +307,8 @@ struct mtk_thermal {
>   
>   	const struct mtk_thermal_data *conf;
>   	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> +
> +	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
>   };
>   
>   /* MT8183 thermal sensor data */
> @@ -726,13 +728,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>   		raw = readl(mt->thermal_base + conf->msr[i]);
>   
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> +		temp = mt->raw_to_mcelsius(mt, i, raw);
>   
>   		/*
>   		 * The first read of a sensor often contains very high bogus
> @@ -1150,6 +1146,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	mtk_thermal_turn_on_buffer(mt, apmixed_base);
>   
> +	mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
> +				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
> +
>   	if (mt->conf->version == MTK_THERMAL_V2) {
>   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>   	}
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

