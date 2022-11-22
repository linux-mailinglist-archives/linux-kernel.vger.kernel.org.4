Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C112634B63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiKVXyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiKVXyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:54:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B7BEB58
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:54:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d20so19619261ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSQxsfoYnD2A3tH+O3pkstLuZIwU+jkrLdSB14gdhug=;
        b=vBWoS7NGEmZ4M8NUTF4f50mMJ+CyxMmbJWmVfdhdi/wQYco0DXDHWbkO+kq5K7tbfl
         dSpgdY1eGcCZ3wmETUxnjEVWKJsvzMefqQktCpYXzKBshcAUdKPXNSeinyxRWjyLtb37
         elrtpxMEA88/Sp5Oh64GPVBahbh4PsS0mmS68O/krFQhSTIXOrq/pSfWjwi29l8r2fpI
         kkngvioKMztgCcyDN1NStajFyOmsnh3r/mGcNKaPR4mUqMe+vZnqVLaeyHJtbrHQGiVK
         7CIx6R0Grk/B7CkoxN25PHIonDDP6SYQDunqvK/4damSUlCizO2yQV5xaS+TRcPDn0r8
         dCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSQxsfoYnD2A3tH+O3pkstLuZIwU+jkrLdSB14gdhug=;
        b=GlvfIZxSGLnth4PU7GzqFgokYSdjjg+h+ZQN1MjbKS2c44hI31pbCO7KRChHLbO5iw
         cNc1FOkF3ZIOC31mzwuRpz5c/XDk253oEMEYJia6E3XSmWbRCkSqbFB08STtvaDwuQxR
         N3ju+Dai//8xzqpaI2sDmBBLkoKIXaQkuxnHbI6Nre4kYIQopV2LNs0URVDvL5CTc2bL
         8yOdX4skj0xTC3+auOsrYcYP1n5A2P/YL75zgq4HWs0ddS6L9NZ8gjdGkCQpSdQFcw+j
         Tf3nPwyMNDvLywZ1WBTB4c4REjFGPClJ5wdMIQxGHjijnsDrZ6hewh9F7B4/Lcw2wOqc
         rqWA==
X-Gm-Message-State: ANoB5plfSQVCmgFqI23GNdxfNUcOAuwHrgA2BHaqahMm+s3/otu0SEDz
        DRAtlhyZZ4+DtgnfkIOSroIzT3AP6SBlaQ==
X-Google-Smtp-Source: AA0mqf6qg6QL8mtw0Y4ZgkbmPG9ZL4mch+rv29n4tkp7iw2Xw+a/UuSczczoRzzpOUoRBvOKd8bU1w==
X-Received: by 2002:a05:651c:158c:b0:26c:90f:f8fe with SMTP id h12-20020a05651c158c00b0026c090ff8femr8807484ljq.2.1669161247954;
        Tue, 22 Nov 2022 15:54:07 -0800 (PST)
Received: from ?IPV6:2001:14ba:a302:8a1a::1? (dzpbkzhtyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:a302:8a1a::1])
        by smtp.gmail.com with ESMTPSA id o19-20020ac24e93000000b004acd6e441cesm2663361lfr.205.2022.11.22.15.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 15:54:07 -0800 (PST)
Message-ID: <f39ae6c3-e156-7366-6802-c392f1b1246e@linaro.org>
Date:   Wed, 23 Nov 2022 01:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] drm/msm/disp/dpu1: add support for display on SM6115
Content-Language: en-GB
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jason Wang <wangborong@cdjrlc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221120133744.24808-1-a39.skl@gmail.com>
 <20221120133744.24808-3-a39.skl@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221120133744.24808-3-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2022 15:37, Adam Skladowski wrote:
> Add required display hw catalog changes for SM6115.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 87 +++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  1 +
>   drivers/gpu/drm/msm/msm_mdss.c                |  5 ++
>   4 files changed, 94 insertions(+)
> 

[skipped]

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 6a4549ef34d4..86b28add1fff 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -280,6 +280,10 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
>   		/* UBWC_2_0 */
>   		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x1e);
>   		break;
> +	case DPU_HW_VER_630:
> +		/* UBWC_2_0 */
> +		msm_mdss_setup_ubwc_dec_20(msm_mdss, 0x11f);
> +		break;

According to the vendor dtsi the sm6115 is UBWC 1.0, not 2.0

Could you please doublecheck?

Looks good to me otherwise.

>   	case DPU_HW_VER_720:
>   		msm_mdss_setup_ubwc_dec_40(msm_mdss, UBWC_3_0, 6, 1, 1, 1);
>   		break;
> @@ -509,6 +513,7 @@ static const struct of_device_id mdss_dt_match[] = {
>   	{ .compatible = "qcom,sc7180-mdss" },
>   	{ .compatible = "qcom,sc7280-mdss" },
>   	{ .compatible = "qcom,sc8180x-mdss" },
> +	{ .compatible = "qcom,sm6115-mdss" },
>   	{ .compatible = "qcom,sm8150-mdss" },
>   	{ .compatible = "qcom,sm8250-mdss" },
>   	{}

-- 
With best wishes
Dmitry

