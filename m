Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3E69FE37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjBVWNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBVWN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDC1D938
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:12:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s22so11854875lfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGZr4GB37okt9ns/7m+dFk/oY3FVz2qC1daXRw1yuJ0=;
        b=p0OnXRAlhWxfboCKRQVVAEGT0BLMcjKThuGG4IznwRspSxUpT5OS/qbA6o3bccRBlH
         MGs2a1Ev1Ob/eFQJ6TXPG26A2nZDYaWPL99/XG3HM+Ndbf5YOW3Ow0S75H69HMpiYjO7
         h5tfm8UzlrDMi9I7+My8MIo9V4SrLTw14eKlaeZ+sewiUiezM9dcymUKcCjlaKiYbvht
         k1SHx/T+uajghDgRuvS3CD1i+Og9LlBbLbYDkKZWmPqdkaWUl0nUf6fS7Ha7XFOaGF1Q
         vXJkr4IZ3wbslNp1SH8H80Ckivs2xqlCQMZfY47FCSI+BO4+5T/GVHDPHZ09j13WdjYR
         hPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGZr4GB37okt9ns/7m+dFk/oY3FVz2qC1daXRw1yuJ0=;
        b=yuQ6V446Pf58sSBGs/5/7tErqo2Ek5FGEBHuiXncSu5bAg59oQiufuL9+cpFEL6308
         dRUCqwfn/UhosSPYcTTYaMnJVJPIeKFBgWerhc6gHwAzRljFmRq1ynv+B/pgLzpxb61e
         c3kc2OXtzOR2+l5o3jNenyFpcBKTJKgrQsfTlZJIImLTqge3ite/so+3U0EwENHv4bWj
         KEEJIkhKJGT21d4+5pmyqlNb2VFe4D3RrTlz8o8Hhnc/TPYepaH8jTaahssRWD28vzaS
         STGnD6OiVNBCSyssNY2r5S7k6BPnW1c92gESgXilKjqzEiAFKe9UsLivxkyZA/mcpFCO
         n7VQ==
X-Gm-Message-State: AO0yUKUKZIxfo7aQlBm5zuHmcphDnurKKJWEXTflF+1JrRh59cIAymxi
        WbkI43InYkspMp8jeByQxgkdeA==
X-Google-Smtp-Source: AK7set9TRNdjF5tyidrvhYqKAA784Ti8Hwk1puhQzfAnq9RFgTuW55KmHTiMvXqomFgwEPzc96xTyw==
X-Received: by 2002:ac2:5615:0:b0:4a4:68b8:f4bd with SMTP id v21-20020ac25615000000b004a468b8f4bdmr3282585lfd.3.1677103974194;
        Wed, 22 Feb 2023 14:12:54 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u20-20020ac243d4000000b004d575f56227sm837784lfl.114.2023.02.22.14.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:12:53 -0800 (PST)
Message-ID: <4b9145e0-0526-dd08-2d92-05a49e50e3bc@linaro.org>
Date:   Thu, 23 Feb 2023 00:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 5/5] drm/msm/a5xx: Enable optional icc voting from OPP
 tables
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
 <20230222-konrad-longbois-next-v1-5-01021425781b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230222-konrad-longbois-next-v1-5-01021425781b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 23:47, Konrad Dybcio wrote:
> Add the dev_pm_opp_of_find_icc_paths() call to let the OPP framework
> handle bus voting as part of power level setting.

This can probably go to the generic code path rather than sticking it 
into a5xx only.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index d09221f97f71..a33af0cc27b6 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1775,5 +1775,9 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>   	/* Set up the preemption specific bits and pieces for each ringbuffer */
>   	a5xx_preempt_init(gpu);
>   
> +	ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>   	return gpu;
>   }
> 

-- 
With best wishes
Dmitry

