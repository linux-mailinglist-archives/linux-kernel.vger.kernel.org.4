Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1474BA91
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjGHAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjGHAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:32:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EF2123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:32:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso40281981fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688776327; x=1691368327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q555pMz0ACCqnaYtRNQORDbdjk7uTFvrj+Ng60bWYPk=;
        b=qkWBZNQRZB8rUoWTi8a73uWJ/Le+X7qGCEHXnWJkmNBlAzLw0yuSCFcYa/SQeaiHQJ
         zlAcS8ezNGvLvtiV3zJW4Whcyi8PRouQau3qCp0K8qFSnWQo+7PSqZkED0Rxm4z6UYJB
         /GEjDeMVUOULxrK8ZgwjSfSQ/Nsw2SiKts18lI1T6WUj14T+GYrDS65Er9ATfS/awpnp
         qfWgrfQVeltP8DrvIj0uIbhu03P4+6iyNKYuTadWyZ+CtPW+fyVMDQ433Ui16OUlrebe
         r86udLnlSGm2dXepVx8bNBtnh+PP9j6TCzNTlz55EbS7XfdoO0VFEdVB8esmmRqqpF8c
         Mp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776327; x=1691368327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q555pMz0ACCqnaYtRNQORDbdjk7uTFvrj+Ng60bWYPk=;
        b=CQTqUgXXw058D1WGKpT7DklR69M7kcatggI1YkOpCHxSPoe8NDDoVbMWkOb4HLNHr2
         ilbXSwnr7Oqzi+v0ZTzaFnFYiAiNek3dHU+Qek/Mh3Jw4g7+/V4vHPcg8UIEjTde5nFe
         Iy2f5VjE38RTg+KLbL2cLUKaABn+G/jwMd7KcekdnGFlMycnoOKbriCI/6G+yxawgG/K
         k3fyokGkE6cIeKLyjIuCrPyRqkPjy3OqqrMno+bpXExh0sIivVau6SKyyaIg1OF3/xLD
         4hOb3ICUtOIxGI3D8714SS5DQtsY+NR+9tZufUXkeGFN5VF2oQXFMNJGeaUj39qTCuLU
         hfpw==
X-Gm-Message-State: ABy/qLYIH4D5wU1NkZflfbrNvYp6uw5+B9YsipkPMEHWTNXRs0Y30I8i
        KC6T1Oiw7nYNY3bl8+TwkmcxGg==
X-Google-Smtp-Source: APBJJlGRbsFJl71gvzciyjfeCmkrCZ6cjI2nr1P+7D8mkt62xSsu+cIlxy//u7ESzOtHihcmmVOknA==
X-Received: by 2002:a2e:8e8d:0:b0:2b6:df5d:8e08 with SMTP id z13-20020a2e8e8d000000b002b6df5d8e08mr4312289ljk.28.1688776327148;
        Fri, 07 Jul 2023 17:32:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e804f000000b002b6a32e21casm1001924ljg.40.2023.07.07.17.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:32:06 -0700 (PDT)
Message-ID: <0cac7c17-c822-927e-cc15-456b1423689c@linaro.org>
Date:   Sat, 8 Jul 2023 03:32:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 5/5] drm/msm/dp: move of_dp_aux_populate_bus() to probe
 for eDP
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
 <1688773943-3887-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1688773943-3887-6-git-send-email-quic_khsieh@quicinc.com>
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
> Move of_dp_aux_populate_bus() to dp_display_probe() for eDP
> from dp_display_bind() so that probe deferral cases can be
> handled effectively
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_aux.c     | 25 ++++++++++++
>   drivers/gpu/drm/msm/dp/dp_display.c | 79 +++++++++++++++++++------------------
>   2 files changed, 65 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index c592064..c1baffb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -505,6 +505,21 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
>   	drm_dp_aux_unregister(dp_aux);
>   }
>   
> +static int dp_wait_hpd_asserted(struct drm_dp_aux *dp_aux,
> +				 unsigned long wait_us)
> +{
> +	int ret;
> +	struct dp_aux_private *aux;
> +
> +	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> +
> +	pm_runtime_get_sync(aux->dev);
> +	ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
> +	pm_runtime_put_sync(aux->dev);
> +
> +	return ret;
> +}
> +
>   struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>   			      bool is_edp)
>   {
> @@ -528,6 +543,16 @@ struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>   	aux->catalog = catalog;
>   	aux->retry_cnt = 0;
>   
> +	/*
> +	 * Use the drm_dp_aux_init() to use the aux adapter
> +	 * before registering aux with the DRM device.
> +	 */
> +	aux->dp_aux.name = "dpu_dp_aux";
> +	aux->dp_aux.dev = dev;
> +	aux->dp_aux.transfer = dp_aux_transfer;
> +	aux->dp_aux.wait_hpd_asserted = dp_wait_hpd_asserted;
> +	drm_dp_aux_init(&aux->dp_aux);
> +
>   	return &aux->dp_aux;
>   }
>   
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 185f1eb..7ed4bea 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -302,10 +302,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>   		goto end;
>   	}
>   
> -	pm_runtime_enable(dev);
> -	pm_runtime_set_autosuspend_delay(dev, 1000);
> -	pm_runtime_use_autosuspend(dev);
> -
>   	return 0;
>   end:
>   	return rc;
> @@ -322,8 +318,6 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   
>   	kthread_stop(dp->ev_tsk);
>   
> -	of_dp_aux_depopulate_bus(dp->aux);
> -
>   	dp_power_client_deinit(dp->power);
>   	dp_unregister_audio_driver(dev, dp->audio);
>   	dp_aux_unregister(dp->aux);
> @@ -1245,6 +1239,29 @@ static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pde
>   	return NULL;
>   }
>   
> +static void of_dp_aux_depopulate_bus_void(void *data)
> +{
> +	of_dp_aux_depopulate_bus(data);
> +}
> +
> +static int dp_display_auxbus_emulation(struct dp_display_private *dp)

Why is it called emulation?

> +{
> +	struct device *dev = &dp->pdev->dev;
> +	struct device_node *aux_bus;
> +	int ret = 0;
> +
> +	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> +
> +	if (aux_bus) {
> +		ret = devm_of_dp_aux_populate_bus(dp->aux, NULL);

And here you missed the whole point of why we have been asking for. 
Please add a sensible `done_probing' callback, which will call 
component_add(). This way the DP component will only be registered when 
the panel has been probed. Keeping us from the component binding retries 
and corresponding side effects.

> +
> +		devm_add_action_or_reset(dev, of_dp_aux_depopulate_bus_void,
> +					 dp->aux);

Useless, it's already handled by the devm_ part of the 
devm_of_dp_aux_populate_bus().

> +	}
> +
> +	return ret;
> +}
> +
>   static int dp_display_probe(struct platform_device *pdev)
>   {
>   	int rc = 0;
> @@ -1290,8 +1307,18 @@ static int dp_display_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, &dp->dp_display);
>   
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> +	pm_runtime_use_autosuspend(&pdev->dev);

Can we have this in probe right from the patch #2?

> +
>   	dp_display_request_irq(dp);
>   
> +	if (dp->dp_display.is_edp) {
> +		rc = dp_display_auxbus_emulation(dp);
> +		if (rc)
> +			DRM_ERROR("eDP aux-bus emulation failed, rc=%d\n", rc);
> +	}
> +
>   	rc = component_add(&pdev->dev, &dp_display_comp_ops);
>   	if (rc) {
>   		DRM_ERROR("component add failed, rc=%d\n", rc);
> @@ -1306,11 +1333,14 @@ static int dp_display_remove(struct platform_device *pdev)
>   	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
>   
>   	component_del(&pdev->dev, &dp_display_comp_ops);
> -	dp_display_deinit_sub_modules(dp);
> -
>   	platform_set_drvdata(pdev, NULL);
> +
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>   	pm_runtime_put_sync_suspend(&pdev->dev);
>   
> +	dp_display_deinit_sub_modules(dp);
> +
>   	return 0;
>   }
>   
> @@ -1514,31 +1544,10 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>   
>   static int dp_display_get_next_bridge(struct msm_dp *dp)
>   {
> -	int rc;
> +	int rc = 0;
>   	struct dp_display_private *dp_priv;
> -	struct device_node *aux_bus;
> -	struct device *dev;
>   
>   	dp_priv = container_of(dp, struct dp_display_private, dp_display);
> -	dev = &dp_priv->pdev->dev;
> -	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> -
> -	if (aux_bus && dp->is_edp) {
> -		/*
> -		 * The code below assumes that the panel will finish probing
> -		 * by the time devm_of_dp_aux_populate_ep_devices() returns.
> -		 * This isn't a great assumption since it will fail if the
> -		 * panel driver is probed asynchronously but is the best we
> -		 * can do without a bigger driver reorganization.
> -		 */
> -		rc = of_dp_aux_populate_bus(dp_priv->aux, NULL);
> -		of_node_put(aux_bus);
> -		if (rc)
> -			goto error;
> -	} else if (dp->is_edp) {
> -		DRM_ERROR("eDP aux_bus not found\n");
> -		return -ENODEV;
> -	}
>   
>   	/*
>   	 * External bridges are mandatory for eDP interfaces: one has to
> @@ -1551,17 +1560,9 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   	if (!dp->is_edp && rc == -ENODEV)
>   		return 0;
>   
> -	if (!rc) {
> +	if (!rc)
>   		dp->next_bridge = dp_priv->parser->next_bridge;
> -		return 0;
> -	}
>   
> -error:
> -	if (dp->is_edp) {
> -		of_dp_aux_depopulate_bus(dp_priv->aux);
> -		dp_display_host_phy_exit(dp_priv);
> -		dp_display_host_deinit(dp_priv);
> -	}
>   	return rc;
>   }
>   

-- 
With best wishes
Dmitry

