Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317D67F016
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjA0VD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjA0VD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:03:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1FE87165
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:03:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so6203820wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkMgIg4fQzJfYGBpNPz1PQWebK98PEAd/0J55gUrVm0=;
        b=pIeiRMg6iet/r1JbKwx+ppFEX7mnWDj3z/GmW+2pjB7E/EPYLGB29PrD+iixK8ht10
         7+/4l7qeZbTNIsFkNx0//SaoK4Jzz0NlNTUWSc/kgdMPrmxA0f70DLOtHtn4OOKr63dB
         wW8ATi21Iw94Q35XHHSBWGOlMjPKy7dHbtSO7ELAzdQrsfbBIcePZc6bbd11ET0eBR10
         ruipHy9HN9JSul9GQv28PDQAMHaqpr6rYvAa//IqivLeKP3sRJZAwIyY5TeMmPcaWNoW
         e4ZBYUkZNyU6+yAPNlJCv+yOXHSqWJn1jccigMdVoiMtORSen/RiUs1PDGRKTjsbne1h
         tXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkMgIg4fQzJfYGBpNPz1PQWebK98PEAd/0J55gUrVm0=;
        b=HctUwY4/kQ+vbK6HYZprbpGwt07cJZ29HNfdCKnA3oSmWtqifzvqi740tlJBwRinKP
         ZFiDHxJ+foQhA47+yd6+PLzpeRpBrKxEjzQLPSY9ZTXrg+XUBYZy/ewqxjLde0Iotj9z
         ZxA1Xm7CozT7OInFagAhODOS8mSMMlM2m5s+pkj5CAEFmVgy9+n77vG1TqrJvpxIhjEs
         6A/iRmkd9pIjhsfSAyHt8Laf0eksglEhOtVPJKLR7iiMQm/dOGm2XOiSzRI3qcBgx6Dw
         JQ9JlZcdDTZOqu7eqiXxx86EsavR+rD+H5se1dPkEHE0iIH4pL5hh1ZDTNqJETcRQ7wT
         MEoQ==
X-Gm-Message-State: AFqh2kqKc7uneDP+UNYSC4Jem8r0Rh5f68V/+45OtxIDgLXTwbt5AdJZ
        9NoY78Mf6ye/ZMX9/RrvNBDxEw==
X-Google-Smtp-Source: AMrXdXsl90rZ6ZM9bYIrrvDZZ3ypzuTE9VNVL3N0wOe3smxl6WFD5ugsqSaWPbOjg6ZDMt5BvOe9tA==
X-Received: by 2002:a05:600c:5d1:b0:3d0:761b:f86 with SMTP id p17-20020a05600c05d100b003d0761b0f86mr41605947wmd.28.1674853433500;
        Fri, 27 Jan 2023 13:03:53 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x10-20020a05600c420a00b003c6b70a4d69sm5078137wmh.42.2023.01.27.13.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 13:03:53 -0800 (PST)
Message-ID: <7a01c3f6-3800-472e-e18f-82af1b3f8d9e@linaro.org>
Date:   Fri, 27 Jan 2023 22:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 5/5] thermal: mediatek: add delay after thermal banks
 initialization
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
 <20221018-up-i350-thermal-bringup-v9-5-55a1ae14af74@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-5-55a1ae14af74@baylibre.com>
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
> Thermal sensor reads performed immediately after thermal bank
> initialization returns bogus values. This is currently tackled by returning
> 0 if the temperature is bogus (exceeding 200000).
> 
> Instead, add a delay between the bank init and the thermal zone device
> register to properly fix this.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/thermal/mtk_thermal.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index b8e06f6c7c42..ab7db385afb3 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -730,14 +730,6 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   
>   		temp = mt->raw_to_mcelsius(mt, i, raw);
>   
> -		/*
> -		 * The first read of a sensor often contains very high bogus
> -		 * temperature value. Filter these out so that the system does
> -		 * not immediately shut down.
> -		 */
> -		if (temp > 200000)
> -			temp = 0;
> -
>   		if (temp > max)
>   			max = temp;
>   	}
> @@ -1160,6 +1152,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, mt);
>   
> +	// Delay for thermal banks to be ready

Coding style for comments is : /* */

No need to resend, I'll take care of changing the comment format.

> +	msleep(30);
> +
>   	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>   					      &mtk_thermal_ops);
>   	if (IS_ERR(tzdev)) {
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

