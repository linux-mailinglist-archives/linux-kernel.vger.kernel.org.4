Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2F6F21AB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347112AbjD2Aft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjD2Afs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:35:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8A3A88
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:35:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f178da21afso1697365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682728545; x=1685320545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fpnw8uCoA0rAU9jGGCChf1SspXtAy92aBylAg/xLWrA=;
        b=J9vpW640rwizfC16AbNY5KLct+P2fghMblD0PVAhbr7tYpxYZlUU3Fsc3H2bELDtNe
         hLMNo9i245c58lEiX6q1Su5kHr4hte5EJdb5h7P/ltbWWuEmBEPHcD6TQh7gfyuofQJQ
         KK5bZexJRA+u1b2WZ4gbo9KwgzVEPrxz20oGK6+Wp+IAH66UAKyOBlKwOApW3FF4eC8h
         kw3lXv1WL2ADM9KMVIsE5zQJE1pNshBiKgbuyzurRtXTu3gEXmWaxRCFB2Ppdjjo/G28
         Z73pKDfBnOhRI8mhs/LVPDXlR4qNjYUaBi8X2zQ7oydv1TinLPGrNKRxgN2S3uV8f1vS
         YEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682728545; x=1685320545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpnw8uCoA0rAU9jGGCChf1SspXtAy92aBylAg/xLWrA=;
        b=QTiaqg5yLRgrEpND9admgZzVukPVRE2TmOHpW3Kw5EiLBFDVbHT7DB7KOVbzltedY7
         /g0R7T/+eZ9fm5EjqdO3+OXQBKHrJCIoi0I6OI1WhGL3+PHfpXcbfNulQ5eAFBNTxDX+
         VFFqVYRzn3m2pc7C9jPHNckIa/6JuV5tsSbH83K6jvR96HCBHAt4pQ/T6dzIqTZc3pOE
         40dXTE37vV4Zrenn8GYc/e6/naVTkSr3DmJpJV90aTWE6uqC5XPOiqc5g29SBv0vbuxN
         ZyecNPHEOjUbT/JyqjJaeEQif/HJs351BbDqnLOMewcE2opb/bM+d2k+8Ncxt+585G39
         JiKg==
X-Gm-Message-State: AC+VfDzA4Gid4HoJfUex0DJnLpaivxQaexJ9AKb3e1KD+qouonBoc2Ax
        n2tsiOcHi07r9YwqAWw7MVKAMw==
X-Google-Smtp-Source: ACHHUZ7/jqjJIRn24DHZbfcAZXD2Uo91hORwXNXDt5EK21EEcveNY1zcl9GGy8OrcfzV2J6iV5SfLQ==
X-Received: by 2002:a7b:c7d0:0:b0:3f1:81c6:f59a with SMTP id z16-20020a7bc7d0000000b003f181c6f59amr5016076wmk.4.1682728545321;
        Fri, 28 Apr 2023 17:35:45 -0700 (PDT)
Received: from [10.6.147.212] ([212.140.138.218])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm25640347wmj.12.2023.04.28.17.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 17:35:44 -0700 (PDT)
Message-ID: <1ef1388d-4dc3-273d-3ba6-10614ce6426c@linaro.org>
Date:   Sat, 29 Apr 2023 03:35:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/7] drm/msm/dpu: add dsc blocks for remaining chipsets
 in catalog
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
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <1682725511-18185-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682725511-18185-5-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 02:45, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> In preparation of calling ping-pong DSC related functions only
> for chipsets which have such a design add the dsc blocks for the
> chipsets for which DSC is present but was not added in the catalog.

Why/how is it prearing us for such calling?

The change itself LGTM.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 2b3ae84..17f821c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -126,6 +126,11 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>   };
>   
> +static const struct dpu_dsc_cfg msm8998_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000, 0),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400, 0),
> +};
> +
>   static const struct dpu_dspp_cfg msm8998_dspp[] = {
>   	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_MSM8998_MASK,
>   		 &msm8998_dspp_sblk),
> @@ -191,6 +196,8 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
>   	.dspp = msm8998_dspp,
>   	.pingpong_count = ARRAY_SIZE(msm8998_pp),
>   	.pingpong = msm8998_pp,
> +	.dsc_count = ARRAY_SIZE(msm8998_dsc),
> +	.dsc = msm8998_dsc,
>   	.intf_count = ARRAY_SIZE(msm8998_intf),
>   	.intf = msm8998_intf,
>   	.vbif_count = ARRAY_SIZE(msm8998_vbif),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> index e3bdfe7..5bb9882 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> @@ -142,6 +142,15 @@ static const struct dpu_merge_3d_cfg sc8180x_merge_3d[] = {
>   	MERGE_3D_BLK("merge_3d_2", MERGE_3D_2, 0x83200),
>   };
>   
> +static const struct dpu_dsc_cfg sc8180x_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_2", DSC_2, 0x80800, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_3", DSC_3, 0x80c00, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_4", DSC_4, 0x81000, BIT(DPU_DSC_OUTPUT_CTRL)),
> +	DSC_BLK("dsc_5", DSC_5, 0x81400, BIT(DPU_DSC_OUTPUT_CTRL)),
> +};
> +
>   static const struct dpu_intf_cfg sc8180x_intf[] = {
>   	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>   	INTF_BLK("intf_1", INTF_1, 0x6a800, 0x2bc, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
> @@ -192,6 +201,8 @@ const struct dpu_mdss_cfg dpu_sc8180x_cfg = {
>   	.mixer = sc8180x_lm,
>   	.pingpong_count = ARRAY_SIZE(sc8180x_pp),
>   	.pingpong = sc8180x_pp,
> +	.dsc_count = ARRAY_SIZE(sc8180x_dsc),
> +	.dsc = sc8180x_dsc,
>   	.merge_3d_count = ARRAY_SIZE(sc8180x_merge_3d),
>   	.merge_3d = sc8180x_merge_3d,
>   	.intf_count = ARRAY_SIZE(sc8180x_intf),

-- 
With best wishes
Dmitry

