Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F97700E84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjELSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjELSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:17:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5ACEB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:17:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so110276791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683915442; x=1686507442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8LjK4ZemVtaeznMyMIjTyfuWDgeRicQP0JV6f2MQjA=;
        b=ZsgX14HdZNUYY5EXlI9ncQqhjLmQvtPy2jmPMxVkmmJw8LNvnEO7iHtFtV1Bwmb1Yy
         6UDRDix+mPm03ryv0SACodMr8watklVxv9180YcYCWLZ7K/2KcDxSGhi0O2qU10fcTBn
         PfP4c79Ahhqan/sd47iWZqpvLzyLrF1QKzyyq24j7hcZwoI0zbopmDkwvGe08ug2XBrv
         +NtxgXtpIY3wQ5OBMqFsbBXJzTmO/xKU0Xn+hleDGxQwlYX9r7Aly+0BxgKk07lxWKOu
         dGE9aHk/w1j1oU+IJMcIUBuNE6WhPglt1HKUPfFTjIJcfHFiyYsx0jcWdjvMvldQ7qyC
         mXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915442; x=1686507442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8LjK4ZemVtaeznMyMIjTyfuWDgeRicQP0JV6f2MQjA=;
        b=IbPek0lF8TdDNRGpYwFCYLt8A1ot3gQ5u5gwwapTEs+7TOzlMzrO9UB4SP1fDZiLJs
         clJuFF0DPJz0CQ/NBmcyoW4A7xJFwfuxQqIS95XuEPHfVKedqOYjcvfkBuu4j1cX14Z8
         m0Sk4kpB7q9nUr2imJNHDupLRRh8olblc97vqy7OhmEzeUjL3muy0in4cluGjHF3uQ6S
         +2aSkLex/iqqKW6hUzKyZIyKnUma6gllDK22+4rgCK3WpIR0WWEdYY5AVvSzw6lT54ai
         ZcNvcpFWR0MRxor5R8yJhcvASzJZPyYmbn4y7Su1eu5T+tPGds85MxCRW/wt53h05U8D
         Aj3g==
X-Gm-Message-State: AC+VfDwD62Rkd96IOoKIFPFcCL1WHz1iVffhRgrETYLHflT3VxE26n2r
        VrNbWLeuz+MCorw4Zhgije8Jxg==
X-Google-Smtp-Source: ACHHUZ56KzPHcvyVXISoCDT+BjPuF8ObSV6drs7BIb1OVrKaHr38w2ZoACWKPgKAHJ2TLDMqp0aFUg==
X-Received: by 2002:a2e:94c7:0:b0:2aa:41a1:cd6c with SMTP id r7-20020a2e94c7000000b002aa41a1cd6cmr4049471ljh.23.1683915441876;
        Fri, 12 May 2023 11:17:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u12-20020a2e9b0c000000b002ab397f1b0bsm2876929lji.3.2023.05.12.11.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 11:17:21 -0700 (PDT)
Message-ID: <bbdef42d-1458-9acc-9233-d9a63d92d7bc@linaro.org>
Date:   Fri, 12 May 2023 21:17:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
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
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683914423-17612-3-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 21:00, Kuogee Hsieh wrote:
> DPU < 7.0.0 requires the PINGPONG block to be involved during
> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
> encoder engine was moved to INTF with the help of the flush mechanism.
> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
> Add DPU_PINGPONG_DSC to PINGPONG_SDM845_MASK, PINGPONG_SDM845_TE2_MASK
> and PINGPONG_SM8150_MASK which is used for all DPU < 7.0 chipsets.
> 
> changes in v6:
> -- split patches and rearrange to keep catalog related files at this patch
> 
> changes in v7:
> -- rewording commit text as suggested at review comments
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Single nit below

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 6 +++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 4 +++-
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 82b58c6..78e4bf6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -76,13 +76,13 @@
>   	(BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
>   
>   #define PINGPONG_SDM845_MASK \
> -	(BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE))
> +	(BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_TE) | BIT(DPU_PINGPONG_DSC))
>   
>   #define PINGPONG_SDM845_TE2_MASK \
> -	(PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
> +	(PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2) | BIT(DPU_PINGPONG_DSC))
>   
>   #define PINGPONG_SM8150_MASK \
> -	(BIT(DPU_PINGPONG_DITHER))
> +	(BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_DSC))
>   
>   #define CTL_SC7280_MASK \
>   	(BIT(DPU_CTL_ACTIVE_CFG) | \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 6ee48f0..dc0a4da 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -144,7 +144,8 @@ enum {
>    * @DPU_PINGPONG_TE2        Additional tear check block for split pipes
>    * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>    * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
> - * @DPU_PINGPONG_DITHER,    Dither blocks
> + * @DPU_PINGPONG_DITHER     Dither blocks

Ideally this should be a separate commit. It is irrelevant to 
DPU_PINGPONG_DSC

> + * @DPU_PINGPONG_DSC        PP ops functions required for DSC
>    * @DPU_PINGPONG_MAX
>    */
>   enum {
> @@ -153,6 +154,7 @@ enum {
>   	DPU_PINGPONG_SPLIT,
>   	DPU_PINGPONG_SLAVE,
>   	DPU_PINGPONG_DITHER,
> +	DPU_PINGPONG_DSC,
>   	DPU_PINGPONG_MAX
>   };
>   

-- 
With best wishes
Dmitry

