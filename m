Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA16F08DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0P5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjD0P5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:57:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B249C4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:57:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-953343581a4so1330468366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682611049; x=1685203049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLGlH+T2fjU4T6lhxmZEwqY6pXWUkubYT9KEtdeRnhQ=;
        b=Lx2MO7hwEgubSt7jBh5opm5oY3swh/5Q91sn49Iron6Zd69KhSRgsiGUIb/T+wPvaK
         CK6gzr42knzX/C+lbqjRH9wtHa3Fcd1CkmuH+Cs48QavafuBCWfahn/INfnS34ed/W+W
         3Sq9m/aOshi+j/omm5uGlk+F4xnuJVkGiKDGRSGj8Z8D3jRmHHBAxUkAEvQdSOMpJFjN
         hx2R57sY+uOKP/NcU0+YepaXiVi4flygCZJ0eJXlUiMz5kX6KIsMyxNnBeDjc3KpBNfD
         IEoN6NJnosFX8vsfFJsiU3l+0B0r57agINmVGyzzXmgA4VhGUfO1FiNrvgHUJJFBVeol
         53Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611049; x=1685203049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLGlH+T2fjU4T6lhxmZEwqY6pXWUkubYT9KEtdeRnhQ=;
        b=h1aw5ZWwTAkWlq4yq7xdLSibRVzXnuC0Nyfl181sxrXgBOJclkUmJ7nqwAp3qcwC+r
         qy0gTQt1vUZDG2sjb5svPmog7GiLMJYr3MHjBrrLbULCAbyLucVOo/VO1h5cqju2Um6i
         bibdVbCkF0COXJTQINb0BKNfvpU8Xo8bupDc6TxNApWquQdl0DJGnBkAQbpjNqSzEKUZ
         dE8KN+WKj/wnx5ihUnnbKp5gcXDQW3myokfuJSsifJX46jYU2Vrf23cDBaDuExhlI/2B
         4r5SL7mZd5//dI+v2WVMNUxOSZnGcQsdJ7p9ySkJ0jNUWx34OfElbw/4OUPaU8Ovo9MN
         zi8Q==
X-Gm-Message-State: AC+VfDzd8Z37r6elNaQQLlhgZqAGUQuejR64MWewGwoTLVHBE99lxlUG
        g4nGuy8v70gy5jBdkLafu7Clzw==
X-Google-Smtp-Source: ACHHUZ5ng0m/bjG83RfQXfWcg608zuGJFMPzf7hkRgBQpApiE9pLag/zs0fHIXpFyYd0om4aXI6jmw==
X-Received: by 2002:a17:906:fd84:b0:94e:d72b:d10c with SMTP id xa4-20020a170906fd8400b0094ed72bd10cmr2276022ejb.40.1682611049258;
        Thu, 27 Apr 2023 08:57:29 -0700 (PDT)
Received: from [172.23.2.5] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b0094fa472a7c4sm9905981ejg.161.2023.04.27.08.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:57:28 -0700 (PDT)
Message-ID: <a1a4f31e-b591-498d-d99e-872661d154d1@linaro.org>
Date:   Thu, 27 Apr 2023 18:57:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: remove GC related code from dpu
 catalog
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
 <20230426192246.5517-3-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230426192246.5517-3-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 22:22, Abhinav Kumar wrote:
> Since Gamma Correction (GC) block is currently unused, drop
> related code from the dpu hardware catalog otherwise this
> becomes a burden to carry across chipsets in the catalog.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/r/20230421224721.12738-2-quic_abhinavk@quicinc.com
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 +---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 6 ------
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 03f162af1a50..badfc3680485 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -91,7 +91,7 @@
>   
>   #define MERGE_3D_SM8150_MASK (0)
>   
> -#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC) | BIT(DPU_DSPP_GC)
> +#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC)
>   
>   #define DSPP_SC7180_MASK BIT(DPU_DSPP_PCC)
>   
> @@ -449,8 +449,6 @@ static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
>   static const struct dpu_dspp_sub_blks msm8998_dspp_sblk = {
>   	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
>   		.len = 0x90, .version = 0x10007},
> -	.gc = { .id = DPU_DSPP_GC, .base = 0x17c0,
> -		.len = 0x90, .version = 0x10007},
>   };
>   
>   static const struct dpu_dspp_sub_blks sc7180_dspp_sblk = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 71584cd56fd7..e0dcef04bc61 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -127,12 +127,10 @@ enum {
>   /**
>    * DSPP sub-blocks
>    * @DPU_DSPP_PCC             Panel color correction block
> - * @DPU_DSPP_GC              Gamma correction block
>    * @DPU_DSPP_IGC             Inverse gamma correction block
>    */
>   enum {
>   	DPU_DSPP_PCC = 0x1,
> -	DPU_DSPP_GC,
>   	DPU_DSPP_IGC,

Don't we need to remove this one too (in the previous patch)?

>   	DPU_DSPP_MAX
>   };
> @@ -433,22 +431,18 @@ struct dpu_sspp_sub_blks {
>    * @maxwidth:               Max pixel width supported by this mixer
>    * @maxblendstages:         Max number of blend-stages supported
>    * @blendstage_base:        Blend-stage register base offset
> - * @gc: gamma correction block
>    */
>   struct dpu_lm_sub_blks {
>   	u32 maxwidth;
>   	u32 maxblendstages;
>   	u32 blendstage_base[MAX_BLOCKS];
> -	struct dpu_pp_blk gc;
>   };
>   
>   /**
>    * struct dpu_dspp_sub_blks: Information of DSPP block
> - * @gc : gamma correction block
>    * @pcc: pixel color correction block
>    */
>   struct dpu_dspp_sub_blks {
> -	struct dpu_pp_blk gc;
>   	struct dpu_pp_blk pcc;
>   };
>   

-- 
With best wishes
Dmitry

