Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3413669B421
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBQUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AD56EDA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:46:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u22so3233363lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX6LMtgxWzl0HpAIUmDAdBT71Qg8jqovVsS10cR9zuw=;
        b=S1vNlmjor4Xn+dLV7bSsOJktaKJUvBJQh69BX+xsD338LswqnshVx0NU8/CXqUseuL
         NYG6NnTI8T9Qk+rVaKafZvahg+OsMYIdrFvS3P6BvXPB97YcNBfyZzSWp1aVHe8PRX4U
         c8tk6TBtYPLpoSEGP370cI7HSxj5ZOFfWZAJ6bNpZKsQkKPYP9oMz7nehEr5scuL1pEI
         q0qK9Gc8Sl2EuoDRdO/YUjsIeZY/k3cgeX+VBUxSHxNm0sMJKa+wZk5zX6BhevvMBaaA
         1I+iQmoipwSG6REo8n0D3A38U9ZNsT9Y9wkIpKlu8n27gbSxNj1gDb+6idpr6UlMDexB
         VfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX6LMtgxWzl0HpAIUmDAdBT71Qg8jqovVsS10cR9zuw=;
        b=eoam/s86O9qK1kmLrEdBXeDfhiIpjoP1M3URBARxM1D2rXXzvD/qb2gzlJemcr+O4c
         lYws2AqqsqY7ISdD0zZp/eqIOYG/fU/mDuNKPp8wXR6Njllcq+XptUPrhjs/udonkJwm
         jqvrMiqvqhDB9yTvoIdU0HihADY/nN4feNTWzuf3IbU3gykaJxq8XhfaXi6grCq8YIL1
         Ub+EWxh3ka14UzbR7PR2qV6nAPEoNqUL+OupkB8ip83YJY68xDrjGISeCieY0hKPyVc/
         3jx7dR6IfXqSANAci5UQezYZraHZLB4oS1eZ5K8C8PKG9noI/FbuXMo1zothdTSeNxIL
         TCzw==
X-Gm-Message-State: AO0yUKUmpd7JBWvPUq2QaBoq33635eL5IGx7saD2sT3xEGecm+BW87Xx
        HVe/3fq0wZ+GEosOyIE/Vu0azg==
X-Google-Smtp-Source: AK7set9iyqQ5WpL/zj7V3zXr3EoAobKRExN+vepIj9AkhXimGD7sLoQA1IodISpECWZ0p93RwZYpeQ==
X-Received: by 2002:ac2:5494:0:b0:4cc:53e3:771d with SMTP id t20-20020ac25494000000b004cc53e3771dmr167438lfk.64.1676666766372;
        Fri, 17 Feb 2023 12:46:06 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u3-20020ac24c23000000b004dc4c5149cfsm782687lfq.134.2023.02.17.12.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:46:05 -0800 (PST)
Message-ID: <a611e63b-034d-afbd-f194-c789a9071878@linaro.org>
Date:   Fri, 17 Feb 2023 22:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 02/14] drm/msm/a6xx: Extend UBWC config
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230214173145.2482651-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19:31, Konrad Dybcio wrote:
> Port setting min_access_length, ubwc_mode and upper_bit from downstream.
> Values were validated using downstream device trees for SM8[123]50 and
> left default (as per downstream) elsewhere.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 29 +++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index c5f5d0bb3fdc..8855d798bbb3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -786,17 +786,25 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>   static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>   {
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> -	u32 lower_bit = 2;
> +	u32 lower_bit = 1;

Any reason to change the default value here?
If it is to match chipsets you are adding, it might be worth splitting 
this change to that patch.

> +	u32 upper_bit = 0;
>   	u32 amsbc = 0;
>   	u32 rgb565_predicator = 0;
>   	u32 uavflagprd_inv = 0;
> +	u32 min_acc_len = 0;
> +	u32 ubwc_mode = 0;
>   
>   	/* a618 is using the hw default values */
>   	if (adreno_is_a618(adreno_gpu))
>   		return;
>   
> -	if (adreno_is_a640_family(adreno_gpu))
> +	if (adreno_is_a630(adreno_gpu))
> +		lower_bit = 2;
> +
> +	if (adreno_is_a640_family(adreno_gpu)) {
>   		amsbc = 1;
> +		lower_bit = 2;
> +	}
>   
>   	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>   		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
> @@ -807,18 +815,23 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>   	}
>   
>   	if (adreno_is_7c3(adreno_gpu)) {
> -		lower_bit = 1;
>   		amsbc = 1;
>   		rgb565_predicator = 1;
>   		uavflagprd_inv = 2;
>   	}
>   
>   	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
> -		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
> -	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
> -	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
> -		uavflagprd_inv << 4 | lower_bit << 1);
> -	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
> +		  rgb565_predicator << 11 | upper_bit << 10 | amsbc << 4 |
> +		  min_acc_len << 3 | lower_bit << 1 | ubwc_mode);
> +
> +	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, upper_bit << 4 |
> +		  min_acc_len << 3 | lower_bit << 1 | ubwc_mode);
> +
> +	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, upper_bit << 10 |
> +		  uavflagprd_inv << 4 | min_acc_len << 3 |
> +		  lower_bit << 1 | ubwc_mode);
> +
> +	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | lower_bit << 21);
>   }
>   
>   static int a6xx_cp_init(struct msm_gpu *gpu)

-- 
With best wishes
Dmitry

