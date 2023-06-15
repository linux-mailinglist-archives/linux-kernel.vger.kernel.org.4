Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7A73150D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245533AbjFOKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjFOKRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:17:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F65AC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:17:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f642a24568so10277886e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686824239; x=1689416239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VrkMso6gSzSG+XS+vDDk4F97yS4RBvowjqFaI7E2vg=;
        b=lFCG8OVwrXZfc2r+DuTaZta5qrr5aKjP9qp3I7Af60jPV5Zs8aGyAg23iIIOtMX6em
         1oMsb6LnatM7muokbqrSQfJolYKeCFgrOCO0lgTzB7tgZftHc7Pk4Ef3LcG+vOtY8tVT
         jsBvY0Xxm/BeshihIC4/3VK5jtg6XOzZZY92SBlWi/FYMSgBVXZ+Xr/s7/HORWFL2oE9
         hZj2wQElM+PFbhLC+vk5s90Sj8EaGIRYhwgxn5sI+pES9xlg0WTKG3rcIvuyTTdBdh5w
         cS4sUzSH0klZ0ytYF5RByUn/HU6gH8+YQToyJI4r0wPO+n1s6mJtllsy1Yd4lV5PYLjq
         qlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824239; x=1689416239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VrkMso6gSzSG+XS+vDDk4F97yS4RBvowjqFaI7E2vg=;
        b=VjOZrFh7ELrG3tRI3dQdleAegrQz0hNfXXzLE6SisIZ/d4Ug3D36aJfEggE6Rx2fcp
         +K/SQ1r/gDwRK0+qhchpu2t+ILGBSQ36lZ9aUlVeKS2T/CYxzboKEgB6decL90+nh4ga
         xJXr6e08jPOZpBBBR+fNvMDf4m2SMlwao84i3wZoS1+KLwEXk/Qm2LF4mV9LoNVSkzIM
         qWDFXzDYq4tPPKGR0d8sTmGzykMUyL6v66SleKJZvkFGZvewJDGaWhpzSB89jtMGb8pL
         UMYbnQI1yBOvfqW/vtOBuxYr8Mw9XlowJfZSfvPvH+6RM2D+/4vdwk0vPSDTqvEexmOt
         2RUA==
X-Gm-Message-State: AC+VfDxRm0B/Aq9om8an/kRhdLeEchhplifxn7wAuKqrDRTOvg1sDfJA
        9EdLIgA3YnyMSw/a1xDVWapi8Q==
X-Google-Smtp-Source: ACHHUZ5lzsyAA1o0LiPPDL3xlSM2j3ov9rzuDZ//SwNmj5QBrOYfKbAmu+BpH8v0thDXRV9AvtQznw==
X-Received: by 2002:a19:da12:0:b0:4f7:4098:9905 with SMTP id r18-20020a19da12000000b004f740989905mr8220883lfg.65.1686824238738;
        Thu, 15 Jun 2023 03:17:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y12-20020a19750c000000b004ef92c6e645sm2100795lfe.263.2023.06.15.03.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:17:18 -0700 (PDT)
Message-ID: <c60a0278-dc45-3e6d-e925-902cafb68d0a@linaro.org>
Date:   Thu, 15 Jun 2023 13:17:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dp: Free resources after unregistering them
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230612220259.1884381-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230612220259.1884381-1-quic_bjorande@quicinc.com>
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

On 13/06/2023 01:02, Bjorn Andersson wrote:
> The DP component's unbind operation walks through the submodules to
> unregister and clean things up. But if the unbind happens because the DP
> controller itself is being removed, all the memory for those submodules
> has just been freed.
> 
> Change the order of these operations to avoid the many use-after-free
> that otherwise happens in this code path.
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bbb0550a022b..ebc84b8fddf8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1337,9 +1337,9 @@ static int dp_display_remove(struct platform_device *pdev)
>   {
>   	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
>   
> +	component_del(&pdev->dev, &dp_display_comp_ops);
>   	dp_display_deinit_sub_modules(dp);
>   
> -	component_del(&pdev->dev, &dp_display_comp_ops);
>   	platform_set_drvdata(pdev, NULL);

This matches more or less the order in dp_display_probe().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

A note for the possible followup: the driver initializes DP debugfs from 
dpu_kms (ugh) by calling msm_dp_debugfs_init() -> dp_debug_get(). I 
think that dp_debug_put() in dp_display_deinit_sub_modules() does not 
look correct.

>   
>   	return 0;

-- 
With best wishes
Dmitry

