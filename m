Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E106F21B9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347119AbjD2Ape (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjD2Apb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:45:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE340DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:45:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso2812685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682729127; x=1685321127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ags4kFanft3zczT1KH8Lnr7z5gkaGNszmndn1s0U9g=;
        b=WKN8f6SVacxOaadMWqKdJv5e2I9MwP4ubrE7GeT4TQYhmgIrBbfkfdwCp7evaeRU6i
         9OFXpH35XQv/9CEKgOSVZH2glP8+FwU4M7CymViBah7mollUBPKuslDy0+mfQBrKhcYW
         HqlifHwXliiNJd8jBDyC6fqDYFfH3JtwAdKY0Mcx4ceD2P5laMK0e8ZaFNzp7aEyblFd
         D1T4dZmFb4Fe6Xb3lNsxS6vQFv+0sAISzNeMumWRgtaA7dIK5ZRu4+ckuhqpfiFu+pAN
         7KJaYiKmK+b1HruG7d9VPiX7P/jAuzKz5xL+wGViKYwoyO6dK6tIGnj+mtxseK5FD7ZI
         Y++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682729127; x=1685321127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ags4kFanft3zczT1KH8Lnr7z5gkaGNszmndn1s0U9g=;
        b=WTdQeGJKEInXjf5ZwvI6quMdm7Y/ktfQLEL9AoffIHJ4aUDYlSTvNnBJtSuniMdnms
         BPExZYrd/DGqLVikg0D9DpghyyzZYnEAqy1eWqVUePp3b7lFc842zxhEE1zpPmdV9mim
         VkvlqUJdSpReKM2Ba2uAHeqCVMSZStC/kdJyzW5FqssbDOAoaJzWS3qGgU/ER/65YN2d
         XfX+RTQbnuLnspJ3Y+8xkdyAy97wA9V7fzvNnSGwpdE7OD8auvOWxzI+T2P8sB2quIVX
         R9Uzjd1jxBCHok1Y2N3bJuk5kZRPf9qvBL3Zg1CZp9HjVRdOgWn3K+qFqX6zqg7N0TaX
         MPVw==
X-Gm-Message-State: AC+VfDwT+gK5wtMyMmdL4rTp9PJhKDNGdW3ijPBg+mDZTQVfPOZd+cMi
        JBzRACrXuFSuBsIO3nSMnVIx5A==
X-Google-Smtp-Source: ACHHUZ6CRhCuDSkjD9+TsR/d5pIinwTpyaB6EZzhlx22eg6nS8V0xlcyMP3Eo0fEy+oOaYxMZAYRGA==
X-Received: by 2002:a05:600c:24cd:b0:3ef:561d:255d with SMTP id 13-20020a05600c24cd00b003ef561d255dmr5019045wmu.41.1682729127070;
        Fri, 28 Apr 2023 17:45:27 -0700 (PDT)
Received: from [10.5.40.110] ([212.140.138.206])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm29576069wmq.38.2023.04.28.17.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 17:45:26 -0700 (PDT)
Message-ID: <ad672cff-3355-97af-24b4-3626efebc284@linaro.org>
Date:   Sat, 29 Apr 2023 03:45:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/7] drm/msm/dpu: add DPU_PINGPONG_DSC feature PP_BLK
 and PP_BLK_TE
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <1682725511-18185-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682725511-18185-6-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 02:45, Kuogee Hsieh wrote:
> Legacy DPU requires PP hardware block involved into setting up DSC

Nit: to be envolved

> data path. This patch add DDPU_PINGPONG_DSC feature bit to both

adds

> PP_BLK and PP_BLK_TE so that both dpu_hw_pp_setup_dsc() and
> dpu_hw_pp_dsc_enable() will be executed during DSC path setup.

Would it be easier to add PP_BLK_NO_DSC instead and make DSC enabled by 
default for PP_BLK / PP_BLK_TE?

> 
> Reported-by : Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    | 12 +++++-----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  8 +++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 26 ++++++++++------------
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 24 ++++++++++----------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 26 ++++++++++------------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  4 ++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  2 +-
>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  8 +++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |  9 +++++---
>   11 files changed, 62 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 17f821c..b7cd746 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -112,16 +112,16 @@ static const struct dpu_lm_cfg msm8998_lm[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg msm8998_pp[] = {
> -	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, BIT(DPU_PINGPONG_DSC), 0,
> +			sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, BIT(DPU_PINGPONG_DSC), 0,
> +			sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, 0, sdm845_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, 0, sdm845_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> index ceca741..8888bd9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> @@ -110,16 +110,16 @@ static const struct dpu_lm_cfg sdm845_lm[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sdm845_pp[] = {
> -	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk_te,
> +	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000, BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk_te,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, 0, sdm845_pp_sblk_te,
> +	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800, BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk_te,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, BIT(DPU_PINGPONG_DSC), 0, sdm845_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> index 42b0e58..3a7dffa 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> @@ -128,24 +128,22 @@ static const struct dpu_dspp_cfg sm8150_dspp[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sm8150_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> -			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> -			-1),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30), -1),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31), -1),
>   };
>   
>   static const struct dpu_merge_3d_cfg sm8150_merge_3d[] = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> index 5bb9882..e766a2d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> @@ -116,23 +116,23 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sc8180x_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>   			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>   			-1),
>   };
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> index ed130582..137b151 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> @@ -129,24 +129,22 @@ static const struct dpu_dspp_cfg sm8250_dspp[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sm8250_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, BIT(DPU_PINGPONG_DSC), MERGE_3D_0,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, BIT(DPU_PINGPONG_DSC), MERGE_3D_1,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> -			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> -			-1),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30), -1),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, BIT(DPU_PINGPONG_DSC), MERGE_3D_2,
> +			sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31), -1),
>   };
>   
>   static const struct dpu_merge_3d_cfg sm8250_merge_3d[] = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> index a46b117..e5631a2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> @@ -80,8 +80,8 @@ static const struct dpu_dspp_cfg sc7180_dspp[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sc7180_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk, -1, -1),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, 0, sdm845_pp_sblk, -1, -1),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, 0, sdm845_pp_sblk, -1, -1),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, 0, 0, sdm845_pp_sblk, -1, -1),
>   };
>   
>   static const struct dpu_intf_cfg sc7180_intf[] = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> index 988d820..7b4ad0f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
> @@ -60,7 +60,7 @@ static const struct dpu_dspp_cfg sm6115_dspp[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg sm6115_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, 0, sdm845_pp_sblk,
>   		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> index c9003dc..20d4d14 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
> @@ -57,7 +57,7 @@ static const struct dpu_dspp_cfg qcm2290_dspp[] = {
>   };
>   
>   static const struct dpu_pingpong_cfg qcm2290_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, sdm845_pp_sblk,
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, 0, 0, sdm845_pp_sblk,
>   		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   		DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 91bfc8a..83c0cd9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -501,21 +501,21 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>   	.intr_done = _done, \
>   	.intr_rdptr = _rdptr, \
>   	}
> -#define PP_BLK_TE(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
> +#define PP_BLK_TE(_name, _id, _base, _features, _merge_3d, _sblk, _done, _rdptr) \
>   	{\
>   	.name = _name, .id = _id, \
>   	.base = _base, .len = 0xd4, \
> -	.features = PINGPONG_SDM845_SPLIT_MASK, \
> +	.features = PINGPONG_SDM845_SPLIT_MASK | _features, \
>   	.merge_3d = _merge_3d, \
>   	.sblk = &_sblk, \
>   	.intr_done = _done, \
>   	.intr_rdptr = _rdptr, \
>   	}
> -#define PP_BLK(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
> +#define PP_BLK(_name, _id, _base, _features, _merge_3d, _sblk, _done, _rdptr) \
>   	{\
>   	.name = _name, .id = _id, \
>   	.base = _base, .len = 0xd4, \
> -	.features = PINGPONG_SDM845_MASK, \
> +	.features = PINGPONG_SDM845_MASK | _features, \
>   	.merge_3d = _merge_3d, \
>   	.sblk = &_sblk, \
>   	.intr_done = _done, \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index fc87db1..6b49171 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -144,6 +144,7 @@ enum {
>    * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>    * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
>    * @DPU_PINGPONG_DITHER,    Dither blocks
> + * @DPU_PINGPONG_DSC,	    PP block binding to DSC
>    * @DPU_PINGPONG_MAX
>    */
>   enum {
> @@ -152,6 +153,7 @@ enum {
>   	DPU_PINGPONG_SPLIT,
>   	DPU_PINGPONG_SLAVE,
>   	DPU_PINGPONG_DITHER,
> +	DPU_PINGPONG_DSC,
>   	DPU_PINGPONG_MAX
>   };
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 3822e06..f255a04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -264,9 +264,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
>   	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
>   	c->ops.get_line_count = dpu_hw_pp_get_line_count;
> -	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> -	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> -	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +
> +	if (features & BIT(DPU_PINGPONG_DSC)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
>   
>   	if (test_bit(DPU_PINGPONG_DITHER, &features))
>   		c->ops.setup_dither = dpu_hw_pp_setup_dither;

-- 
With best wishes
Dmitry

