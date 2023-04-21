Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE26EB58C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDUXJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjDUXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:09:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730F26A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:09:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec81773d50so2296183e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682118557; x=1684710557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+huuKa+3v0k2tRGIzkWAd9TvVwbi6xql2nym7kQgbj8=;
        b=fClxCHFOKMFUpXxe4XKTu9aykUMnbPzm0edppGSnBWAF0Juf22SUD7mNdXCTttB/QA
         uFgbVBcjfAYRy+zFT3Ah9DTgWqJXCN/P4mu6imWRTDrPvbR5wctAHMDsEQ4RzfFLWN8G
         TG+c6i5jqEo2/Wberuit6IT21iG49cdpVlEKmQpVzBKHxDKemBYIHzYPLMR8UGNKmtG6
         5Dm+EE8JxgJbS4jwWzCYB4F56JmwucNIB2+XOdJZ+P68+2oFY5LuXon27tPR4putTtuo
         w52DwjOhU228jpSOHM9t/vbBS2Nrw296WKkg0qno/6pas6gk8atshbv1Vq+NYUEnnPmk
         oK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682118557; x=1684710557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+huuKa+3v0k2tRGIzkWAd9TvVwbi6xql2nym7kQgbj8=;
        b=I2szF8Mam/GISIU/UfRf8kDophj0MsSVPoO8eKVEc72XDkRWqGUGcXuO4AKPm/3c8m
         O4vAJrvV45qc6DSywKcc2OamM9BMCTOTC6VRKM4RAfD8nwqhaI0AMM769tNvfCZBJFD3
         JQw/YJVgMPN5x0+0W3+4NCwpQJ4Yo5Ebn9l6vZhmzszLSSEolvURhw9h2LcQYRZ3Ilws
         DlFtHdf+P4Jb/QrfIhBGl37kkVpUXwvCH2Ptt+8bo4IvKsjXZTDh/H0NQupmzlHyX5iH
         qViY1fW5NdXIMRH6vbuTKB2ewXiOPZyi/xvH7J8D/aM7aTOoBXIycO7qjQWEqaw2EBdw
         6bDg==
X-Gm-Message-State: AAQBX9dQ6f51tnfCS/5KI8JfAdDNHBWuQ/6S9wUoC+/6ntUpw+EWAK3+
        7WjAxZWNtFb68SKdYe/BL28oOw==
X-Google-Smtp-Source: AKy350b67nOG2SbVU9dXeSGgpROgpu1qRY+JGqM6azpDsExv3KfPPZ6yk5fxzb7yG0/Ec6eDrqInLg==
X-Received: by 2002:a05:6512:145:b0:4ed:c6d5:bdc with SMTP id m5-20020a056512014500b004edc6d50bdcmr1777429lfo.24.1682118556680;
        Fri, 21 Apr 2023 16:09:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b24-20020ac247f8000000b004edd4d1e55dsm697027lfp.284.2023.04.21.16.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 16:09:16 -0700 (PDT)
Message-ID: <f400c714-8bee-895a-5bf7-bbaf9cbc0619@linaro.org>
Date:   Sat, 22 Apr 2023 02:09:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] drm/msm/dpu: remove GC related code from dpu catalog
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421224721.12738-1-quic_abhinavk@quicinc.com>
 <20230421224721.12738-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230421224721.12738-2-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 01:47, Abhinav Kumar wrote:
> Since Gamma Correction (GC) block is currently unused, drop
> related code from the dpu hardware catalog otherwise this
> becomes a burden to carry across chipsets in the catalog.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
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

At this point we can merge these two masks.

Could you please extend this for v2 with the following patches:
- merge of two DSPP_foo_MASKs
- dropping of DPU_DSPP_IGC?

For this patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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

