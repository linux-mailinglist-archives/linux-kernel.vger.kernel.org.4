Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0474BA5E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGHAEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjGHAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:04:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B14128
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:04:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69923a715so39659411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688774689; x=1691366689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XClRASt1zv03yzvIaQZBmR+RWsvbOBIF8lpLsum2GMU=;
        b=sUK94nXjRi8UeaQxFyNRIQ2VQlVTpCUd/1arC6zXu9ju/m8T3iYbc9d3Z+y8rN5qr0
         +QLbfww0veQubnbSyI7cBodWLU0yn6c+AFsSjuZyNzAgcSz6H93TzyqqaEI0zyKjD6P4
         uS4sK2LHWY8riZDN2W1p6beXZnSJA/hqi7F1kKfTEpZ1Pyy7d9ZLqLx6nd/QNiR9PEb7
         xo0SM9NL3tzEDdHRsfyUH87bKNXWrCrnaAsMgrz5H/PuooP7DgzFn3VtUI88HKkQDmF+
         i6O3UgG8J0ex9J3VC1KSpZWICmspnajuOpQedd4eDsFwRHpguSlJM6a2uDrNjxjJarXA
         89AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774689; x=1691366689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XClRASt1zv03yzvIaQZBmR+RWsvbOBIF8lpLsum2GMU=;
        b=FnzCq8uuE+ANeAngPjRL1JfxfMvWkKdmYMr6W1Vhzez+eHXc3VBhGW/P4EN3MnJhN9
         Hp61TI4WXLUiAZRDgzWwNSuwbI9Hzw+qhWLzfzHpkdNCUBzFwVnN73ccLrx766TgwKvm
         mvnZQV2GldHW4LW0lZznnqaddy08jhh8e/hl7b1hf+ZfpbuDS92q8ZzL7s+BVlV0Scj4
         WqkGY0zHCIimX+p/cxS0GVLjofY/Q2kPSiEBZZKvqicuQWaZoJQqOviUtKGAY9kPG/5I
         WVoI/2ICeh3zUL+G2J/rgfI19iPgqd+8WWNhyvilWfThzMuhlhkvopxVESZAdw0+VoRb
         wCKA==
X-Gm-Message-State: ABy/qLb6bG6cO/riOgq+jvcqIOEm9TmVBmtbGWGaTQeRQjLHFJaznvxx
        NRC6VKf6xpKLBidD1IPAOJWX7A==
X-Google-Smtp-Source: APBJJlGPJfECyWATXKXXWf7dqhtMuiSsz3pOFhG7XFNxy6ckQU5FThw+TTAtQR7npUOPdzeuQQlDXg==
X-Received: by 2002:a2e:9d99:0:b0:2b6:d57a:cf2e with SMTP id c25-20020a2e9d99000000b002b6d57acf2emr5841938ljj.42.1688774689117;
        Fri, 07 Jul 2023 17:04:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i2-20020a2e8082000000b002b6c80302bfsm978705ljg.98.2023.07.07.17.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:04:48 -0700 (PDT)
Message-ID: <c551f77f-804f-3e45-6b15-680c70b86d37@linaro.org>
Date:   Sat, 8 Jul 2023 03:04:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/5] drm/msm/dp: incorporate pm_runtime framework into
 DP driver
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
 <1688773943-3887-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1688773943-3887-3-git-send-email-quic_khsieh@quicinc.com>
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
> Incorporating pm runtime framework into DP driver so that power
> and clock resource handling can be centralized allowing easier
> control of these resources in preparation of registering aux bus
> uring probe.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_aux.c     |  3 ++
>   drivers/gpu/drm/msm/dp/dp_display.c | 75 +++++++++++++++++++++++++++++--------
>   2 files changed, 63 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 8e3b677..c592064 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -291,6 +291,7 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>   		return -EINVAL;
>   	}
>   
> +	pm_runtime_get_sync(dp_aux->dev);

Let me quote the function's documentation:
Consider using pm_runtime_resume_and_get() instead of it, especially if 
its return value is checked by the caller, as this is likely to result 
in cleaner code.

So two notes concerning the whole patch:
- error checking is missing
- please use pm_runtime_resume_and_get() instead.

>   	mutex_lock(&aux->mutex);
>   	if (!aux->initted) {
>   		ret = -EIO;
> @@ -364,6 +365,8 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>   
>   exit:
>   	mutex_unlock(&aux->mutex);
> +	pm_runtime_mark_last_busy(dp_aux->dev);
> +	pm_runtime_put_autosuspend(dp_aux->dev);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 76f1395..2c5706a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -309,6 +309,10 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   		goto end;
>   	}
>   
> +	pm_runtime_enable(dev);

devm_pm_runtime_enable() removes need for a cleanup.

> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);

Why do you want to use autosuspend here?

> +
>   	return 0;
>   end:
>   	return rc;
> @@ -320,9 +324,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   	struct msm_drm_private *priv = dev_get_drvdata(master);
>   
> -	/* disable all HPD interrupts */
> -	if (dp->core_initialized)
> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>   
>   	kthread_stop(dp->ev_tsk);
>   
> @@ -466,10 +469,12 @@ static void dp_display_host_init(struct dp_display_private *dp)
>   		dp->dp_display.connector_type, dp->core_initialized,
>   		dp->phy_initialized);
>   
> -	dp_power_init(dp->power);
> -	dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> -	dp_aux_init(dp->aux);
> -	dp->core_initialized = true;
> +	if (!dp->core_initialized) {
> +		dp_power_init(dp->power);
> +		dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
> +		dp_aux_init(dp->aux);
> +		dp->core_initialized = true;
> +	}

Is this relevant to PM runtime? I don't think so.

>   }
>   
>   static void dp_display_host_deinit(struct dp_display_private *dp)
> @@ -478,10 +483,12 @@ static void dp_display_host_deinit(struct dp_display_private *dp)
>   		dp->dp_display.connector_type, dp->core_initialized,
>   		dp->phy_initialized);
>   
> -	dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
> -	dp_aux_deinit(dp->aux);
> -	dp_power_deinit(dp->power);
> -	dp->core_initialized = false;
> +	if (dp->core_initialized) {
> +		dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
> +		dp_aux_deinit(dp->aux);
> +		dp_power_deinit(dp->power);
> +		dp->core_initialized = false;
> +	}
>   }
>   
>   static int dp_display_usbpd_configure_cb(struct device *dev)
> @@ -1304,6 +1311,39 @@ static int dp_display_remove(struct platform_device *pdev)
>   	dp_display_deinit_sub_modules(dp);
>   
>   	platform_set_drvdata(pdev, NULL);
> +	pm_runtime_put_sync_suspend(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int dp_pm_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct msm_dp *dp_display = platform_get_drvdata(pdev);
> +	struct dp_display_private *dp;
> +
> +	dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +	dp_display_host_phy_exit(dp);
> +	dp_catalog_ctrl_hpd_enable(dp->catalog);

What? NO!

> +	dp_display_host_deinit(dp);
> +
> +	return 0;
> +}
> +
> +static int dp_pm_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct msm_dp *dp_display = platform_get_drvdata(pdev);
> +	struct dp_display_private *dp;
> +
> +	dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +	dp_display_host_init(dp);
> +	if (dp_display->is_edp) {
> +		dp_catalog_ctrl_hpd_enable(dp->catalog);
> +		dp_display_host_phy_init(dp);
> +	}
>   
>   	return 0;
>   }
> @@ -1409,6 +1449,7 @@ static int dp_pm_suspend(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops dp_pm_ops = {
> +	SET_RUNTIME_PM_OPS(dp_pm_runtime_suspend, dp_pm_runtime_resume, NULL)
>   	.suspend = dp_pm_suspend,
>   	.resume =  dp_pm_resume,

With the runtime PM in place, can we change suspend/resume to use 
pm_runtime_force_suspend() and pm_runtime_force_resume() ?


>   };
> @@ -1493,10 +1534,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
>   
>   	if (aux_bus && dp->is_edp) {
> -		dp_display_host_init(dp_priv);
> -		dp_catalog_ctrl_hpd_enable(dp_priv->catalog);
> -		dp_display_host_phy_init(dp_priv);

Are you going to populate the AUX bus (which can cause AUX bus access) 
without waking up the device?

> -
>   		/*
>   		 * The code below assumes that the panel will finish probing
>   		 * by the time devm_of_dp_aux_populate_ep_devices() returns.
> @@ -1604,6 +1641,7 @@ void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   		dp_hpd_plug_handle(dp_display, 0);

Nearly the same question. Resume device before accessing registers.

>   
>   	mutex_lock(&dp_display->event_mutex);
> +	pm_runtime_get_sync(&dp_display->pdev->dev);
>   
>   	state = dp_display->hpd_state;
>   	if (state != ST_DISPLAY_OFF && state != ST_MAINLINK_READY) {
> @@ -1684,6 +1722,8 @@ void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>   	}
>   
>   	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
> +
> +	pm_runtime_put_sync(&dp_display->pdev->dev);
>   	mutex_unlock(&dp_display->event_mutex);
>   }
>   
> @@ -1723,6 +1763,8 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>   	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
>   
>   	mutex_lock(&dp->event_mutex);
> +	pm_runtime_get_sync(&dp->pdev->dev);
> +
>   	dp_catalog_ctrl_hpd_enable(dp->catalog);
>   
>   	/* enable HDP interrupts */
> @@ -1744,6 +1786,9 @@ void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>   	dp_catalog_ctrl_hpd_disable(dp->catalog);
>   
>   	dp_display->internal_hpd = false;
> +
> +	pm_runtime_mark_last_busy(&dp->pdev->dev);
> +	pm_runtime_put_autosuspend(&dp->pdev->dev);
>   	mutex_unlock(&dp->event_mutex);
>   }
>   

-- 
With best wishes
Dmitry

