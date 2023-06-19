Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC50735AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFSPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjFSPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:17:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F19B;
        Mon, 19 Jun 2023 08:17:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so22548995e9.3;
        Mon, 19 Jun 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187842; x=1689779842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2BCqWZdnOgJLi1yS8YB0jgtq7UEXjCvPUI8CflkrIM=;
        b=fcoarEbtF5e7jxTOdi2dHyVdAjhYmhluM3IFzimhgMrW9R2daBbBYONDuB/o0J7YOr
         bYoFkt5eSY/Qihi9kxiUYuqaZKwp6C/9xXf69fScIaGVS4gjGSSOvIOa3jTRTzaSwqgo
         2gaZezk7u5fR7Kg509bBrm6W/dGDLiGwmt92XSnrUpruNV7ERRTZMtx4PpTBz5mWAvXH
         E6WXnT/ZBDfu65fZkld2fRZj1Frr4AmlNFoCLHOgMTJ+7yEUexlom1z70/90A4OAA2Yh
         NSvi3RBD5Ebu0ss9+0SIJSPmMzhVizmHebLSUqHuIeomQXmB+2xsS8oMi2Q6cDaymSv0
         1KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187842; x=1689779842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2BCqWZdnOgJLi1yS8YB0jgtq7UEXjCvPUI8CflkrIM=;
        b=HNHd7Kkiocvr21u+1yNLnqWjWEYf8XVohoCLKytBrq++6Alo1CgHAGP98o7nsagNq6
         YlKuMtlI5O0bm7aM1xr1UOHQKNTtFBsNdDsdd8AZbNnUV4G4GxEILr+Oc9ub3+wXCGNs
         7xKIIpyiP5zT5lxIindNWqwv/JX6OtYwG3lTqP4qzdNsJ6xexl68YtBWcRPk8/b1fOxC
         U6OFAnxn+ZDgorYYZuLWKhVP/lJS1j/+WeH8cfNtX5QUCLB3j4HjrLIdDvCmRzK4Z5Vz
         EfLulR7NAiozpZBvnSjm/Tjg1goNGmuDBhKkEXkSSYaQEHsZOW0m/jzJwfWzqP7vfKIs
         TDOQ==
X-Gm-Message-State: AC+VfDwRXdEt4VZK+k1Pod1JhPbo1wh+NJu68P5j5oePwenzXqRNf2E6
        wnVXSPUFURp5kltN31jX+hQ=
X-Google-Smtp-Source: ACHHUZ7K5Wzb9tlqACcOU9KMrL7nII5/kQ/ZHVCVs95ZpIEDFwh9jxtGKtIzb9hQmQ6Nf+bJZPS2NA==
X-Received: by 2002:a7b:ce14:0:b0:3f9:7a15:1716 with SMTP id m20-20020a7bce14000000b003f97a151716mr3720485wmc.5.1687187842081;
        Mon, 19 Jun 2023 08:17:22 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0030ae93bd196sm31712456wrr.21.2023.06.19.08.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:17:21 -0700 (PDT)
Message-ID: <91db8e7b-29fb-3c43-ac38-008ebc9b1f6b@gmail.com>
Date:   Mon, 19 Jun 2023 17:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 11/12] thermal/drivers/generic-adc: Register thermal
 zones as hwmon sensors
Content-Language: en-US, ca-ES, es-ES
To:     Yangtao Li <frank.li@vivo.com>, glaroque@baylibre.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230613114904.15749-1-frank.li@vivo.com>
 <20230613114904.15749-11-frank.li@vivo.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230613114904.15749-11-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/2023 13:49, Yangtao Li wrote:
> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> [Yangtao change to use dev_warn and remove return]
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/thermal-generic-adc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index 017b0ce52122..9531bc2f2ce7 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -13,6 +13,8 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> +#include "thermal_hwmon.h"
> +
>   struct gadc_thermal_info {
>   	struct device *dev;
>   	struct thermal_zone_device *tz_dev;
> @@ -153,6 +155,9 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev))
> +		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");

Isn't that already done by patch 1/12?

Regards,
Matthias

> +
>   	return 0;
>   }
>   
