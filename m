Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7B70A44A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjETB1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjETB1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:27:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4722AF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:27:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af24ee004dso15354441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684546021; x=1687138021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpGiQfdC7CJAPSrG431oIQoQ1WsQQX/NbmDyOqUhpQ0=;
        b=H9QImVvElIGXwqFEEHYziU/1jR8cN1PEp8dORaPxetSx8G+yiK5qb0TpeLsLCVGViz
         Ze4lBNLrN0UTAzHJHvIEV2nNQ3WO3dyr3x6CT76CTgNhvs5Ff77XVuT0/bzrxdLEkViY
         /sKJ0iTBZ2ypPrLIOqrUZKVB+kdiCuNHh1Ekiw2HiaB+VhMJe0U6IbPRcCmLdqECYxBx
         bL0HbwawSHhv9oekPBPZpHxh/WuBfIXOfNUrLjsZ+D7ENavv1ELZ8yk/A+f+hZkyDwW5
         H+ukL8SnvrdTVo/TBtIFGAQ7U+1xHWTUflS3UnJGJKuvxrHJQbw2A/iuDBRP/uffd48C
         hKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684546021; x=1687138021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpGiQfdC7CJAPSrG431oIQoQ1WsQQX/NbmDyOqUhpQ0=;
        b=bzubjvhNy6NPed7mpGtgk3IhDnbuh/6vCNYuUN8GOzy9GTREEUWDNIh/zdSZur6le8
         vP/mzkjsGLtFgPzzuujSZs7+oNRs6NVP3qW5oSxrRx/qXtdSLsKJEX+/3/Dg/6+NeaPW
         XeKVJ7u3n7xnvqVLxnaTV4l1/mPlCj8nCv7GMZFMo4xtQmLcN4KqDzsjbmkPH5O7mVbL
         2xlIZytXUxJ6Xi19z4xMAsV/48ZrsT2YT+0F/VGMZunx30QJMUxwgaYUZwttp8Xqm4ZB
         uMfsODdjLqt0O8G+en5pJO2GKOrK+n0f80xYdHIAMb1E8MUtK8BNmfQvF3fiuHjONt6N
         PhLg==
X-Gm-Message-State: AC+VfDz7okrSNkFAzHI8IeNdDAgm9do6Epkf5P+g6/bvVPuDwTq8Ddya
        QrrUhV3c3gFwBwoMDHPiRDiKvw==
X-Google-Smtp-Source: ACHHUZ7gNJVfI5DJg9sjmVcTaD99mo2iri83qrRKQibTPnORDyEuVpzuKJuSj0TOF0yFNg8gzSYF8g==
X-Received: by 2002:a05:6512:2182:b0:4ef:f09c:c505 with SMTP id b2-20020a056512218200b004eff09cc505mr1009742lft.37.1684546020991;
        Fri, 19 May 2023 18:27:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v2-20020a197402000000b004e84d64ab51sm90897lfe.58.2023.05.19.18.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:27:00 -0700 (PDT)
Message-ID: <d7d27051-2853-c979-b965-3cad47f2b693@linaro.org>
Date:   Sat, 20 May 2023 04:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] drm/msm/dp: Clean up pdev/dev duplication in dp_power
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20230515030256.300104-1-quic_bjorande@quicinc.com>
 <20230515030256.300104-3-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230515030256.300104-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 06:02, Bjorn Andersson wrote:
> The dp_power module keeps track of both the DP controller's struct
> platform_device and struct device - with the prior pulled out of the
> dp_parser module.
> 
> Clean up the duplication by dropping the platform_device reference and
> just track the passed struct device.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_power.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
> index 031d2eefef07..9be645f91211 100644
> --- a/drivers/gpu/drm/msm/dp/dp_power.c
> +++ b/drivers/gpu/drm/msm/dp/dp_power.c
> @@ -14,7 +14,6 @@
>   
>   struct dp_power_private {
>   	struct dp_parser *parser;
> -	struct platform_device *pdev;
>   	struct device *dev;
>   	struct drm_device *drm_dev;
>   	struct clk *link_clk_src;
> @@ -28,7 +27,7 @@ static int dp_power_clk_init(struct dp_power_private *power)
>   {
>   	int rc = 0;
>   	struct dss_module_power *core, *ctrl, *stream;
> -	struct device *dev = &power->pdev->dev;
> +	struct device *dev = power->dev;
>   
>   	core = &power->parser->mp[DP_CORE_PM];
>   	ctrl = &power->parser->mp[DP_CTRL_PM];
> @@ -153,7 +152,7 @@ int dp_power_client_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_enable(&power->pdev->dev);
> +	pm_runtime_enable(power->dev);
>   
>   	return dp_power_clk_init(power);
>   }
> @@ -164,7 +163,7 @@ void dp_power_client_deinit(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_disable(&power->pdev->dev);
> +	pm_runtime_disable(power->dev);
>   }
>   
>   int dp_power_init(struct dp_power *dp_power, bool flip)
> @@ -174,11 +173,11 @@ int dp_power_init(struct dp_power *dp_power, bool flip)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_get_sync(&power->pdev->dev);
> +	pm_runtime_get_sync(power->dev);
>   
>   	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
>   	if (rc)
> -		pm_runtime_put_sync(&power->pdev->dev);
> +		pm_runtime_put_sync(power->dev);
>   
>   	return rc;
>   }
> @@ -190,7 +189,7 @@ int dp_power_deinit(struct dp_power *dp_power)
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
>   	dp_power_clk_enable(dp_power, DP_CORE_PM, false);
> -	pm_runtime_put_sync(&power->pdev->dev);
> +	pm_runtime_put_sync(power->dev);
>   	return 0;
>   }
>   
> @@ -199,12 +198,11 @@ struct dp_power *dp_power_get(struct device *dev, struct dp_parser *parser)

Technically we don't even need to pass struct device here, we can get it 
from parser->pdev->dev.

>   	struct dp_power_private *power;
>   	struct dp_power *dp_power;
>   
> -	power = devm_kzalloc(&parser->pdev->dev, sizeof(*power), GFP_KERNEL);
> +	power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
>   	if (!power)
>   		return ERR_PTR(-ENOMEM);
>   
>   	power->parser = parser;
> -	power->pdev = parser->pdev;
>   	power->dev = dev;
>   
>   	dp_power = &power->dp_power;

-- 
With best wishes
Dmitry

