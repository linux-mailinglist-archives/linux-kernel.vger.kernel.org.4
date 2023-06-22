Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179773AD86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFVX6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFVX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:58:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AE2121
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:58:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b477e9d396so1700671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687478281; x=1690070281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOJ4sVltsZ9M5KDCRJdau/4lLhZni1wjJWsBxXT5u74=;
        b=ASIuRumXYDkQltGgNoHtUsA/rJteJwjOqzHnZajaEFZxUOGDi8DanNXp/S80k4kKAn
         nbIrf5YTD7MFjT3f/qJJmDQHn+EbMfZDD9JE8npXjRrl7IBy9hJSkUcvgs3GgDOAhZ+4
         oC+1Bi4zLSU89T+pNMXLmR0qNeQughJl6dZ/KOJAuU68u/zvSosseNSohl1mJJfYAYJT
         ufN9n6SNBM8MrAGCttO+9VqB86VngPoES5DuVDx0cWDAj43ohuuu6GvWtW5JvHdJQDte
         sz/5SnHDmdKDcrNd1n+azGyu9Rf5Pb7CzkJfJalY+w/PL/CC6EcYxSWgJ4HdanepD4t/
         X4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478281; x=1690070281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOJ4sVltsZ9M5KDCRJdau/4lLhZni1wjJWsBxXT5u74=;
        b=FuGNRyeNLX0qj5xXdRBkq+TlhKSY8QsqJyFEZRvtUIbNLW0OE8PfpHydgWlEBToVmL
         nls8j69jdQUgTKkqvwTdhH9LcOFqFgKsJoxeBvVmwV7m7YEVdN5hOLnaV6266P99PTOL
         dCKLyUlh5GYy15LQWuyPzJYlM6gknoaAM+A1XauB5u3EeQe0GO/j8Pv00xkREpLqL3ck
         oPfnqB4Rb6PMAhQn2x8zC3gcIgOdodPJnRKjqdNNIcpp6lsznwF1NYGaB7dR4NNQTPU5
         hKm4QlNeaWr0A1JG5HUJ3dILx24TKPZBIvR3HMmW34N9qYf5HgvrCItLYcixo8haDuKB
         uQbQ==
X-Gm-Message-State: AC+VfDyeZkvUzedpm4rH7Xs8j44Yn2OCsWbYZ0EwVk528zwiDxk8RckX
        9Op3EOHqWrK6s2XI1svbSPJ7tw==
X-Google-Smtp-Source: ACHHUZ6fZOd207OPP7+oSgoFVH/x7Q9MUNkNe/C3uYdNnlB5Kivf3drLdrRwQJOHhBZ0wIaDI8w0FA==
X-Received: by 2002:a2e:8848:0:b0:2b5:8335:a51f with SMTP id z8-20020a2e8848000000b002b58335a51fmr5961013ljj.11.1687478280833;
        Thu, 22 Jun 2023 16:58:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9611000000b002adb98fdf81sm1507687ljh.7.2023.06.22.16.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 16:58:00 -0700 (PDT)
Message-ID: <0d702a8d-c9fa-1fd4-1c2b-a1a10abca22f@linaro.org>
Date:   Fri, 23 Jun 2023 02:57:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] drm/msm/dpu: Drop unused num argument from relevant
 macros
Content-Language: en-GB
To:     Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
 <20230622-devcoredump_patch-v1-2-3b2cdcc6a576@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v1-2-3b2cdcc6a576@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 02:48, Ryan McCann wrote:
> Drop unused parameter "num" from VIG_SBLK_NOSCALE and DMA sub block
> macros. Update calls to relevant macros to reflect change.

This is not relevant for this patchset.

With https://patchwork.freedesktop.org/patch/534745/?series=116851&rev=2 
in place, VIG_SBLK and VIG_SBLK_ROT should also stop using num. But 
let's probably take another step forward and drop both arguments and use 
just a single instance of sblk per platform. I'll send a patch for it.

> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 0de507d4d7b7..69200b4cf210 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -288,7 +288,7 @@ static const uint32_t wb2_formats[] = {
>   	.rotation_cfg = rot_cfg, \
>   	}
>   
> -#define _DMA_SBLK(num, sdma_pri) \
> +#define _DMA_SBLK(sdma_pri) \
>   	{ \
>   	.maxdwnscale = SSPP_UNITY_SCALE, \
>   	.maxupscale = SSPP_UNITY_SCALE, \
> @@ -323,10 +323,10 @@ static const struct dpu_sspp_sub_blks sdm845_vig_sblk_2 =
>   static const struct dpu_sspp_sub_blks sdm845_vig_sblk_3 =
>   				_VIG_SBLK("3", 8, DPU_SSPP_SCALER_QSEED3);
>   
> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_0 = _DMA_SBLK("8", 1);
> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_1 = _DMA_SBLK("9", 2);
> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_2 = _DMA_SBLK("10", 3);
> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK("11", 4);
> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_0 = _DMA_SBLK(1);
> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_1 = _DMA_SBLK(2);
> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_2 = _DMA_SBLK(3);
> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK(4);
>   
>   #define SSPP_BLK(_name, _id, _base, _len, _features, \
>   		_sblk, _xinid, _type, _clkctrl) \
> @@ -365,11 +365,11 @@ static const struct dpu_sspp_sub_blks sm8550_vig_sblk_1 =
>   static const struct dpu_sspp_sub_blks sm8550_vig_sblk_2 =
>   				_VIG_SBLK("2", 9, DPU_SSPP_SCALER_QSEED4);
>   static const struct dpu_sspp_sub_blks sm8550_vig_sblk_3 =
> -				_VIG_SBLK("3", 10, DPU_SSPP_SCALER_QSEED4);
> -static const struct dpu_sspp_sub_blks sm8550_dma_sblk_4 = _DMA_SBLK("12", 5);
> -static const struct dpu_sspp_sub_blks sm8550_dma_sblk_5 = _DMA_SBLK("13", 6);
> +				_VIG_SBLK(10, DPU_SSPP_SCALER_QSEED4);
> +static const struct dpu_sspp_sub_blks sm8550_dma_sblk_4 = _DMA_SBLK(5);
> +static const struct dpu_sspp_sub_blks sm8550_dma_sblk_5 = _DMA_SBLK(6);
>   
> -#define _VIG_SBLK_NOSCALE(num, sdma_pri) \
> +#define _VIG_SBLK_NOSCALE(sdma_pri) \
>   	{ \
>   	.maxdwnscale = SSPP_UNITY_SCALE, \
>   	.maxupscale = SSPP_UNITY_SCALE, \
> @@ -380,8 +380,8 @@ static const struct dpu_sspp_sub_blks sm8550_dma_sblk_5 = _DMA_SBLK("13", 6);
>   	.virt_num_formats = ARRAY_SIZE(plane_formats), \
>   	}
>   
> -static const struct dpu_sspp_sub_blks qcm2290_vig_sblk_0 = _VIG_SBLK_NOSCALE("0", 2);
> -static const struct dpu_sspp_sub_blks qcm2290_dma_sblk_0 = _DMA_SBLK("8", 1);
> +static const struct dpu_sspp_sub_blks qcm2290_vig_sblk_0 = _VIG_SBLK_NOSCALE(2);
> +static const struct dpu_sspp_sub_blks qcm2290_dma_sblk_0 = _DMA_SBLK(1);
>   
>   /*************************************************************
>    * MIXER sub blocks config
> 

-- 
With best wishes
Dmitry

