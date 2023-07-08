Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698874BA78
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGHALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGHAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:11:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FEA11B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:11:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3832232e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688775086; x=1691367086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pEhdouabvxAp9TSL2fUp0unC0H1pT0amjcsbTlGqwQ=;
        b=oZhptRdax944AXF9E0srAwlBDKjtKLq+rWSOk6PCMNmNq7heJG1eJXmKuGUwXN9fJw
         hQiEbnpKV+TBCW0ilQZtCFPojb+BnSWlFzmjYtDrijeZQ+x+ZhLcEWqwETFbPpYpm4F2
         7TufzC0ckJrPTrKLHMTIwX2P3qxycrJBXIGW/K/DIyTDig4EVeAl/NGPoY2jZm9+S2VF
         iQdbWb6V4yqxlJl4LesaU41ltCCBlWhgLqw1dHSTDaVrd5Hr/P8ch2jgX9/KT56exoJj
         nN/c/WMHdPR6dU46q58oMrLWy+DNw3SAkiPBA003ELiQgajXOWj4yqmD3XnqdhYnDgMu
         TyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688775086; x=1691367086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pEhdouabvxAp9TSL2fUp0unC0H1pT0amjcsbTlGqwQ=;
        b=AQ14o2Ga4HAMon+TZ50UU4IwEj/ycF2E7uL38kjWr252sl4U96hYWr3SFsD7SlTpEv
         ArmCDPJJlW8vYa3j4A4sTFOEmZz2Uo3pwgIfukTzlaqOHLTHnqFPo85oxQYctYcMIg54
         legTbc3n6KN4RbpYZhEqb7RO6jHbTgI1zOw0rkHvWtU9RAyM+Hek4BvOvmLM/iramC5h
         oP3VHMj8tkr+aaVPtv7bTurtEL5niQVJEO0t7iZC9kRjONQOiG41MMstUWo5JoFcKM24
         H24XVih2N7qvGHuvG/Qof7++aLsBEgUrbkVFyimWv5rHLkuYfjp4ovOSxMqjaa2ebZzO
         nRFw==
X-Gm-Message-State: ABy/qLan+B9v2U9VVd3lPGhfOeNneoGoDgfl5lt6PXgmXDWOxHbljOI7
        iynaav1UVMMN7WnBJnYoZbwMpQ==
X-Google-Smtp-Source: APBJJlENIbTi154YqUJ/mp+/+dX6U/m13Fpue2Y2OnxjpG0g6UDbMbW4IkaDNJ3qqPoXI3Pc+MI4Lg==
X-Received: by 2002:a05:6512:1088:b0:4fb:8c27:4def with SMTP id j8-20020a056512108800b004fb8c274defmr5508992lfg.8.1688775086410;
        Fri, 07 Jul 2023 17:11:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l8-20020ac24a88000000b004fbb094cba1sm851623lfp.43.2023.07.07.17.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:11:25 -0700 (PDT)
Message-ID: <121f82ad-9d5d-6d7f-b4ae-9a371ab49ef7@linaro.org>
Date:   Sat, 8 Jul 2023 03:11:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 4/5] drm/msm/dp: move relevant dp initialization code
 from bind() to probe()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1688773943-3887-5-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 02:52, Kuogee Hsieh wrote:
> In preparation of moving edp of_dp_aux_populate_bus() to
> dp_display_probe(), move dp_display_request_irq(),
> dp->parser->parse() and dp_power_client_init() to dp_display_probe()
> too.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++--------------------
>   drivers/gpu/drm/msm/dp/dp_display.h |  1 -
>   2 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 44580c2..185f1eb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -290,12 +290,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   		goto end;
>   	}
>   
> -	rc = dp_power_client_init(dp->power);
> -	if (rc) {
> -		DRM_ERROR("Power client create failed\n");
> -		goto end;
> -	}
> -
>   	rc = dp_register_audio_driver(dev, dp->audio);
>   	if (rc) {
>   		DRM_ERROR("Audio registration Dp failed\n");
> @@ -752,6 +746,12 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
>   		goto error;
>   	}
>   
> +	rc = dp->parser->parse(dp->parser);
> +	if (rc) {
> +		DRM_ERROR("device tree parsing failed\n");
> +		goto error;
> +	}
> +
>   	dp->catalog = dp_catalog_get(dev, &dp->parser->io);
>   	if (IS_ERR(dp->catalog)) {
>   		rc = PTR_ERR(dp->catalog);
> @@ -768,6 +768,12 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
>   		goto error;
>   	}
>   
> +	rc = dp_power_client_init(dp->power);
> +	if (rc) {
> +		DRM_ERROR("Power client create failed\n");
> +		goto error;
> +	}
> +
>   	dp->aux = dp_aux_get(dev, dp->catalog, dp->dp_display.is_edp);
>   	if (IS_ERR(dp->aux)) {
>   		rc = PTR_ERR(dp->aux);
> @@ -1196,26 +1202,20 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
>   	return ret;
>   }
>   
> -int dp_display_request_irq(struct msm_dp *dp_display)
> +static int dp_display_request_irq(struct dp_display_private *dp)
>   {
>   	int rc = 0;
> -	struct dp_display_private *dp;
> -
> -	if (!dp_display) {
> -		DRM_ERROR("invalid input\n");
> -		return -EINVAL;
> -	}
> -
> -	dp = container_of(dp_display, struct dp_display_private, dp_display);
> +	struct device *dev = &dp->pdev->dev;
>   
> -	dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
>   	if (!dp->irq) {
> -		DRM_ERROR("failed to get irq\n");
> -		return -EINVAL;
> +		dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
> +		if (!dp->irq) {
> +			DRM_ERROR("failed to get irq\n");
> +			return -EINVAL;
> +		}
>   	}

Use platform_get_irq() from probe() function.

>   
> -	rc = devm_request_irq(dp_display->drm_dev->dev, dp->irq,
> -			dp_display_irq_handler,
> +	rc = devm_request_irq(dev, dp->irq, dp_display_irq_handler,
>   			IRQF_TRIGGER_HIGH, "dp_display_isr", dp);


>   	if (rc < 0) {
>   		DRM_ERROR("failed to request IRQ%u: %d\n",
> @@ -1290,6 +1290,8 @@ static int dp_display_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, &dp->dp_display);
>   
> +	dp_display_request_irq(dp);
> +

Error checking?
Are we completely ready to handle interrupts at this point?

>   	rc = component_add(&pdev->dev, &dp_display_comp_ops);
>   	if (rc) {
>   		DRM_ERROR("component add failed, rc=%d\n", rc);
> @@ -1574,12 +1576,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>   
>   	dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
>   
> -	ret = dp_display_request_irq(dp_display);
> -	if (ret) {
> -		DRM_ERROR("request_irq failed, ret=%d\n", ret);
> -		return ret;
> -	}
> -
>   	ret = dp_display_get_next_bridge(dp_display);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 1e9415a..b3c08de 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -35,7 +35,6 @@ struct msm_dp {
>   int dp_display_set_plugged_cb(struct msm_dp *dp_display,
>   		hdmi_codec_plugged_cb fn, struct device *codec_dev);
>   int dp_display_get_modes(struct msm_dp *dp_display);
> -int dp_display_request_irq(struct msm_dp *dp_display);
>   bool dp_display_check_video_test(struct msm_dp *dp_display);
>   int dp_display_get_test_bpp(struct msm_dp *dp_display);
>   void dp_display_signal_audio_start(struct msm_dp *dp_display);

-- 
With best wishes
Dmitry

