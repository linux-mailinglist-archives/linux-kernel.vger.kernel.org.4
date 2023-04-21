Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F856EA072
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjDUAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjDUAHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:07:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398F4217
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:07:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8149907aso1041697e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682035653; x=1684627653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLFXBTiLwMvaw8fy77PEa4Rr8nVXq3s6Busf4NAaQdk=;
        b=yrZDLELc1gqcOYTTzXMhdoTTRq0nU+ntXeER+fEQerHoNQfzf+kZ7usuJs7Qs8ScWs
         Ues22fDNrYj1hizTtV+oAGU8o/kQWS3DLzzln7kcdadLuSiYdAKNSta4lMSoR0ZgJ0W4
         7j1zysrCpIdvpTYU+ea+j/KUGxFRtddP173Nc7uxMyK2m1YFQksNE7U30p17p2obZi4Q
         XIQC+PiPYyg/CCgqG43PPbO3Gyy6Lxr0IYgzRjR52Dk/XfJalvcs3qyPkYFIaK4MVerQ
         XVyaLjo8S4sGRe3AEEWD9gD27XcK4+C3A3AS9mPxpAU9MS8Nnw5c8hurbdfldmlykoLQ
         K8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035653; x=1684627653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLFXBTiLwMvaw8fy77PEa4Rr8nVXq3s6Busf4NAaQdk=;
        b=KlKYI9FeCQbPNBcks0CzKcD+AcdnwOwkPksjWPyyolxgWWHSf5nVcq5TvEiwAEa5SY
         OJHYE4egTO6t5UcLPyCwf/ToGYMFAFzZdykKjRu0k2OwfBmiHSgAZvWzFMwliyIQXMBg
         XJ2xSYaL8N8zSJwBJ8QCMRutRdn5KbdiU3MiLAcgVBT7dsTSCrD+1TRBZbKA6vRCJmfG
         DeMIMuE0Xl5W+aqaZyB2asYwasRX57YFvx+Mknw+18Hk3Z5miEbtDo2Tc2m0FXRpFwIL
         A53sR5aqtU84K904+XzdVWt5NMhT10ZzXCOJlkFsa1GQ4oD6c/2KcI0psDPpyeXcxuQ/
         Yy5A==
X-Gm-Message-State: AAQBX9duQbDpdqO/jhEPHk0/tQTbOfLow87TuSOGfnPGRR++x4Ad6PPB
        zS/4dHWIJJUaOALC0O28ZuXi6g==
X-Google-Smtp-Source: AKy350anHEOXvktSuJ20WISPKkbmPhBf8HkSslFqb7f0lANUI6JSvjgax7jzs5LOxFBwdwvcW6GRNg==
X-Received: by 2002:a2e:9e02:0:b0:2a8:ae13:cc31 with SMTP id e2-20020a2e9e02000000b002a8ae13cc31mr105168ljk.47.1682035653203;
        Thu, 20 Apr 2023 17:07:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id i14-20020a2e864e000000b002a9f9c358d4sm195909ljj.111.2023.04.20.17.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 17:07:32 -0700 (PDT)
Message-ID: <b26dfb22-bf97-b65e-ef06-62098c4eafec@linaro.org>
Date:   Fri, 21 Apr 2023 03:07:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 5/5] drm/msm/dpu: add DSC 1.2 hw blocks for relevant
 chipsets
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1682033114-28483-1-git-send-email-quic_khsieh@quicinc.com>
 <1682033114-28483-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682033114-28483-6-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 02:25, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add DSC 1.2 hardware blocks to the catalog with necessary
> sub-block and feature flag information.
> Each display compression engine (DCE) contains dual hard
> slice DSC encoders so both share same base address but with
> its own different sub block address.

Please correct line wrapping. 72-75 is usually the preferred width

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h  | 19 +++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  | 11 +++++++++++
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h    | 21 +++++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h  | 19 +++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h  | 19 +++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c      | 12 ++++++++++--
>   6 files changed, 99 insertions(+), 2 deletions(-)
> 


[I commented on sm8550, it applies to all the rest of platforms]

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index 9e40303..72a7bcf 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -165,6 +165,23 @@ static const struct dpu_merge_3d_cfg sm8550_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_3", MERGE_3D_3, 0x66700),
>   };
>   
> +static const struct dpu_dsc_sub_blks sm8550_dsc_sblk_0 = {
> +	.enc = {.base = 0x100, .len = 0x100},
> +	.ctl = {.base = 0xF00, .len = 0x10},
> +};
> +
> +static const struct dpu_dsc_sub_blks sm8550_dsc_sblk_1 = {
> +	.enc = {.base = 0x200, .len = 0x100},
> +	.ctl = {.base = 0xF80, .len = 0x10},
> +};

Please keep sblk in dpu_hw_catalog for now.

> +
> +static const struct dpu_dsc_cfg sm8550_dsc[] = {
> +	DSC_BLK_1_2("dsc_0", DSC_0, 0x80000, 0x100, 0, sm8550_dsc_sblk_0),
> +	DSC_BLK_1_2("dsc_0", DSC_1, 0x80000, 0x100, 0, sm8550_dsc_sblk_1),

Is there a reason why index in "dsc_N" doesn't match the DSC_n which 
comes next to it?

> +	DSC_BLK_1_2("dsc_1", DSC_2, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), sm8550_dsc_sblk_0),
> +	DSC_BLK_1_2("dsc_1", DSC_3, 0x81000, 0x100, BIT(DPU_DSC_NATIVE_422_EN), sm8550_dsc_sblk_1),
> +};
> +
>   static const struct dpu_intf_cfg sm8550_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	/* TODO TE sub-blocks for intf1 & intf2 */
> @@ -218,6 +235,8 @@ const struct dpu_mdss_cfg dpu_sm8550_cfg = {
>   	.dspp = sm8550_dspp,
>   	.pingpong_count = ARRAY_SIZE(sm8550_pp),
>   	.pingpong = sm8550_pp,
> +	.dsc = sm8550_dsc,
> +	.dsc_count = ARRAY_SIZE(sm8550_dsc),
>   	.merge_3d_count = ARRAY_SIZE(sm8550_merge_3d),
>   	.merge_3d = sm8550_merge_3d,
>   	.intf_count = ARRAY_SIZE(sm8550_intf),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 03f162a..be08158 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
> @@ -540,7 +540,15 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>   	{\
>   	.name = _name, .id = _id, \
>   	.base = _base, .len = 0x140, \
> -	.features = _features, \
> +	.features = BIT(DPU_DSC_HW_REV_1_1) | _features, \
> +	}
> +
> +#define DSC_BLK_1_2(_name, _id, _base, _len, _features, _sblk) \
> +	{\
> +	.name = _name, .id = _id, \
> +	.base = _base, .len = _len, \
> +	.features = BIT(DPU_DSC_HW_REV_1_2) | _features, \
> +	.sblk = &_sblk, \
>   	}
>   
>   /*************************************************************

-- 
With best wishes
Dmitry

