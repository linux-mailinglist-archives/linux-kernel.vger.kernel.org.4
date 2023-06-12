Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F672D495
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjFLWlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbjFLWlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:41:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39376198A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:40:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so58871031fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686609651; x=1689201651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJv3SYkb3/54C0GBq7q+cwJt2WQz+XK/nza61SWhb9I=;
        b=cCt9/utssvdNZaLZzNAWQ6y/DvDiM8GOgkCMWP0QBWJ/C72CmnAiEudYB6L+jQVNtD
         2E5kk1kw7ITjC2JUeg6HYh3QJlLXLAjS+lZ4xd++v2Z3j+fy7Ml6/HsNflXNWVDDf5Pd
         ruyl4sJBoEiy/rHMahVxr9comFf9IRDgp3r1yFjODpOPL2tgk92sxIos45QlHEMJuLOr
         qylShw/PvBj7zNQmW9J9YyERF0wen6HgdJPW79rUGQ+MDPCrqrHxK2MWT/BYfFSFRGsh
         kex18Ad7cEfSG+2yVY465Ks1tA6Zm/toA+loDJPLVYYgJ0UF47L/tccjeaUe+uN/r7yU
         Fd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609651; x=1689201651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJv3SYkb3/54C0GBq7q+cwJt2WQz+XK/nza61SWhb9I=;
        b=TMhGSjZS2mY73stW9p7WGBzb7fm3hxQzEa5+pxqPplFmKiyQvvjkpi4waWb6RkKJ4h
         zcB9Vf876stN11Bx0inffw1d2zeXkmDczIhVrSvG8XeKYTlNQ+XmMvztPNwPFTkgyTRU
         fKhojSuxEAwRAHWGDDCslTnwVSd8GQ/9da3vFLdT8SxFM6AY6wGD1Br9W29TmTUpzLjU
         +mmff7rThkK7XKV+XHKGQx7sOlsfdHGCS+SWKkjptcoDqcMGk9v9n4e+eIcKkf8ummU2
         JW+O1MKITIbY+6fyuIk9ox4LqAr5CHiMSuf9VUfftwVNn1N3o2JVLI5YU2kAJ/w5akiP
         osYA==
X-Gm-Message-State: AC+VfDwAuSXls1+Kf61CRKc/m2rmiY69NZp7DWBA44yR/xanEqFnRun4
        FRtl4N5y2RoegixqG7QRvFPuJQ==
X-Google-Smtp-Source: ACHHUZ7qZUkr8QULHI13GFQxQQksTABoqa3/KliVWWufTmgeQZCcLjdaM6GMdpfAhi6Uvior6iYHWA==
X-Received: by 2002:a2e:9c5a:0:b0:2b1:ae75:2781 with SMTP id t26-20020a2e9c5a000000b002b1ae752781mr3258215ljj.27.1686609651128;
        Mon, 12 Jun 2023 15:40:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y12-20020a2e978c000000b002ac7c9d2806sm1936982lji.50.2023.06.12.15.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:40:50 -0700 (PDT)
Message-ID: <c31ee9e4-1878-c0ae-70e6-42af5fd838c7@linaro.org>
Date:   Tue, 13 Jun 2023 01:40:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dp: Drop aux devices together with DP controller
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230612220106.1884039-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230612220106.1884039-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 01:01, Bjorn Andersson wrote:
> Using devres to depopulate the aux bus made sure that upon a probe
> deferral the EDP panel device would be destroyed and recreated upon next
> attempt.
> 
> But the struct device which the devres is tied to is the DPUs
> (drm_dev->dev), which may be happen after the DP controller is torn
> down.
> 
> Indications of this can be seen in the commonly seen EDID-hexdump full
> of zeros in the log, or the occasional/rare KASAN fault where the
> panel's attempt to read the EDID information causes a use after free on
> DP resources.
> 
> It's tempting to move the devres to the DP controller's struct device,
> but the resources used by the device(s) on the aux bus are explicitly
> torn down in the error path.

I hoped that proper usage of of_dp_aux_populate_bus(), with the callback 
function being non-NULL would have solved at least this part. But it 
seems I'll never see this patch.

> The KASAN-reported use-after-free also
> remains, as the DP aux "module" explicitly frees its devres-allocated
> memory in this code path.
> 
> As such, explicitly depopulate the aux bus in the error path, and in the
> component unbind path, to avoid these issues.
> 
> Fixes: 2b57f726611e ("drm/msm/dp: fix aux-bus EP lifetime")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3d8fa2e73583..bbb0550a022b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -322,6 +322,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   
>   	kthread_stop(dp->ev_tsk);
>   
> +	of_dp_aux_depopulate_bus(dp->aux);
> +
>   	dp_power_client_deinit(dp->power);
>   	dp_unregister_audio_driver(dev, dp->audio);
>   	dp_aux_unregister(dp->aux);
> @@ -1521,11 +1523,6 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>   	}
>   }
>   
> -static void of_dp_aux_depopulate_bus_void(void *data)
> -{
> -	of_dp_aux_depopulate_bus(data);
> -}
> -
>   static int dp_display_get_next_bridge(struct msm_dp *dp)
>   {
>   	int rc;
> @@ -1554,12 +1551,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   		of_node_put(aux_bus);
>   		if (rc)
>   			goto error;
> -
> -		rc = devm_add_action_or_reset(dp->drm_dev->dev,
> -						of_dp_aux_depopulate_bus_void,
> -						dp_priv->aux);
> -		if (rc)
> -			goto error;
>   	} else if (dp->is_edp) {
>   		DRM_ERROR("eDP aux_bus not found\n");
>   		return -ENODEV;
> @@ -1583,6 +1574,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   
>   error:
>   	if (dp->is_edp) {
> +		of_dp_aux_depopulate_bus(dp_priv->aux);
>   		disable_irq(dp_priv->irq);
>   		dp_display_host_phy_exit(dp_priv);
>   		dp_display_host_deinit(dp_priv);

-- 
With best wishes
Dmitry

