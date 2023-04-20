Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC46E934D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjDTLrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDTLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:47:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ECF10C2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:47:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so4393231fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681991241; x=1684583241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utfMEwjRtQb+equBbrKCD4/CcQSjoaSGMcoZ72gCVUA=;
        b=Z95rycXDwUNq2/dzSTQKDDcUK4tqkWc+YMELEldeqvDixA2V+Z+xNp330XqyOOBrmk
         v/wW41zMrD+3p1GrFUD/y6BSpPX7F33bjHFF9DDNEY6I6UfxTuB8Id8FRZ8lVCRepr0q
         h3+qxLEQskhrORnHK96uzUwSp9JUDljd3yidp7xqu2Z9DUjr9vHCPg+BxNbc6QDjl3q4
         eHwSd9ZRs5828Cm0iQF02/L4ayxfHlQSNuzpU9C0XG0vWQk0SekdxyOLw7r7leKxXYfC
         I+PdjXUuijJBxwx7+nm/1hIZZttX8IA91cVufFVvPa3xoUiTv31/YKCscw8oaUPXrNuJ
         5s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681991241; x=1684583241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utfMEwjRtQb+equBbrKCD4/CcQSjoaSGMcoZ72gCVUA=;
        b=FiaHXE9yNr5I3IQLgxkXHHUX/MUDKK1rbqeq9CfEVAF4i+A5s3LUM8VrD7K6vzajsM
         U1wSlfoIuRTYuXsw5u3Pns9UpJ6zpjv5LinhdgCp+nVM6XQ5eYPV1oWpLkVGTzBq6h7m
         LXMadYzz5Yh3G8mSF5hYePYBHqgAMbAQZAV0dQ0gDLzNExd9JTeI8tSwT/lKQBJh4M1F
         Za1nJB43hrj5dxNWYee3GVSBf0fGU4pdtYJTgy6OjJdMEN5HKdnbUz10xhEsc5oe9iX3
         W/MN5Y5XeEKn21drPfLkEUak3fB7qavV750hjCBGIUg2TWtfrnyBG7hW23FZmkEvKNgC
         lqnw==
X-Gm-Message-State: AAQBX9fDykIQlAFmpLZH7i1acIBI1usenxFFOVAEnDxdVkcz40cq6WOC
        l3oHP6nAJEAfealgk0On1rzokw==
X-Google-Smtp-Source: AKy350YpTdCf86eHSVO6lbjuxm9lf1D6AX1RTL02jKTJiTegbNyrqK4LLlNSpQqowFLuQZw9kxbxbA==
X-Received: by 2002:a05:6512:145:b0:4d7:44c9:9f4c with SMTP id m5-20020a056512014500b004d744c99f4cmr415139lfo.4.1681991240676;
        Thu, 20 Apr 2023 04:47:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m16-20020a195210000000b004eed6175e3fsm191457lfb.143.2023.04.20.04.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 04:47:20 -0700 (PDT)
Message-ID: <786cda44-cd82-4353-d195-35a987a80b3d@linaro.org>
Date:   Thu, 20 Apr 2023 14:47:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] drm/msm/dpu1: Rename sm8150_dspp_blk to
 sdm845_dspp_blk
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <20230420-topic-dpu_gc-v1-1-d9d1a5e40917@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230420-topic-dpu_gc-v1-1-d9d1a5e40917@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 04:14, Konrad Dybcio wrote:
> SDM845 was the first SoC to include both PCC v4 and GC v1.8.
> We don't currently support any other blocks but the common config
> for these two can be reused for a large amount of SoCs.
> 
> Rename it to indicate the origin of that combo.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h   | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h  | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 8 ++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           | 2 +-
>   9 files changed, 27 insertions(+), 27 deletions(-)

Please follow this by enabling DSPP on sdm845. Otherwise it is strange 
to have sdm845_dspp_sblk, but not to have it enabled on sdm845 itself. 
If necessary, I can test it on RB3.

-- 
With best wishes
Dmitry

