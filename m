Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E416DE12F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDKQnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358749F6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:43:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q15so5538836ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681231387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+Yn3w4i6ERhJRbEalDkX81nXU5W6d0rrV0jXP7xE40=;
        b=QFgUdLSiBrEwNbHQ04X1boTAoorIGTiF6sCjmJuNEhDh5YRYplW2HFsR/8qPj/zRH6
         bFS+gA3Kcbkf5sO/PY5yrQ2o2ENpG6g4z5qxUGFRBvtZSFGdmi6K/UO+W6AEXlEjWD31
         Pr50qHaLDkwLcPVUVVGO/FK9xlZ+qAwk6dBMFFp5pmfikoC8gr1g29K6Didkx5KkdYsJ
         OEgBDmqZ1qAXNZ9EcusjJDJ1R9zA76y0Nngb0ZJtx7apwCfRD8zhizpFLAj5q31eZXl2
         qWAXXNYtMDXsNjdtbojR9WBVyRNxyw2y2pbxV3Sb2WrvPyD17LGjevDRBLeTLq0tDcp9
         c1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+Yn3w4i6ERhJRbEalDkX81nXU5W6d0rrV0jXP7xE40=;
        b=VGR4h5PwSf6oZ0npQe049qau7ii5UVnQjqUp6d4MbubpPsZyR1Byb6a/qC3gOmmN1b
         7BIu9ksw8ieKTnM7Vj7RPZSScGwaW6OHTAkJUX7YkcY04FGLqIm1O7XCEDfGNwYd/Byj
         mSatqwMdRZq1WrUsg/lJQAiBPIHI4duvuAh6KmYyRuJduPHRHmAQXkM9qQNDWxonbxYP
         oFuGKoBG62/m6AQcBXtUeTBz1+4WQbymw87KidtcjQ9dH8SLW3MJ9cOCCg267iCNbMYg
         QnAR6Z/qQTtTEvn79gaZ2YM3ts1nCbcgaszfdoxUTa02MUZI5BMH8dTJdE8XBxNDfuJY
         bUfg==
X-Gm-Message-State: AAQBX9cyi43gVsoB7w4oW78eaADpjyfWMTfos/VnUOvb4IJg2O6ZhHLs
        hAlaAuB+VfQVT2zetmVEEWWfdg==
X-Google-Smtp-Source: AKy350bMk4SkskVqv2ia31J+GxA0ArmyEzCNBnop1DJ9H7MWNk8XMD336eB/RYppFHgASDqtT8IemQ==
X-Received: by 2002:a2e:82ce:0:b0:2a2:ca91:a99e with SMTP id n14-20020a2e82ce000000b002a2ca91a99emr4943313ljh.39.1681231387322;
        Tue, 11 Apr 2023 09:43:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x28-20020ac25ddc000000b004e8017a2510sm2606561lfq.183.2023.04.11.09.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:43:06 -0700 (PDT)
Message-ID: <90f32378-fa1c-a23e-2db2-2e83a42fd45e@linaro.org>
Date:   Tue, 11 Apr 2023 19:43:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/dpu: Delete a variable initialisation before a
 null pointer check in two functions
Content-Language: en-GB
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Vinod Koul <vkoul@kernel.org>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 19:38, Markus Elfring wrote:
> Date: Tue, 11 Apr 2023 18:24:24 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> 
> Thus avoid the risk for undefined behaviour by removing extra
> initialisations for the variable “c” (also because it was already
> reassigned with the same value behind this pointer check).
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 25fdd5933e4c0f5fe2ea5cd59994f8ac5fbe90ef ("drm/msm: Add SDM845 DPU support")

Plese follow the format for the Fixes tags and limit the hash to 12 
chars. Proper tag:

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")

Other than that LGTM.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 0fcad9760b6f..870ab3ebbc94 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -176,7 +176,7 @@ static int dpu_hw_pp_enable_te(struct dpu_hw_pingpong *pp, bool enable)
>   static int dpu_hw_pp_connect_external_te(struct dpu_hw_pingpong *pp,
>   		bool enable_external_te)
>   {
> -	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +	struct dpu_hw_blk_reg_map *c;
>   	u32 cfg;
>   	int orig;
> 
> @@ -221,7 +221,7 @@ static int dpu_hw_pp_get_vsync_info(struct dpu_hw_pingpong *pp,
> 
>   static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
>   {
> -	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +	struct dpu_hw_blk_reg_map *c;
>   	u32 height, init;
>   	u32 line = 0xFFFF;
> 
> --
> 2.40.0
> 

-- 
With best wishes
Dmitry

