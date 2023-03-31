Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D485B6D143A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCaAjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCaAjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:39:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CC1BC0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:39:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c9so16439366lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680223150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGffWxiLWtEc/sDkXGzevKji1Y0bUIbGHyNyuOurZmg=;
        b=hw6P+cNJTYoVFUvkhbDLCLyr6hkV8w6DdP80DifpNo1tZPIrNXR4LvRxV1DOjkKREh
         +amDuT0QfAgO9fkwBXYUcFk/Sksxwa8YCiruNRuBTHwfuWVxd2HLmgwjrs2+DJpkuYZJ
         7d0WBXPuU574cvAX8TSPEPv/ZwjCMislILLMYgR7Kj5saimZqfizVHEQR6MXiXiT6XNB
         qe5moXa91McwwRoQKdEDzsPzXAz5yi8EX8m8AIoHJLU5BoJr4nH3LtefyJmgtyO32CM1
         pE69mICzXN16x5fkrLzHVmccjiBr51/87wPyCwvs9vy3KiYQjwilRPVUzAX7TvMPmo55
         USFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGffWxiLWtEc/sDkXGzevKji1Y0bUIbGHyNyuOurZmg=;
        b=OBa7plDBPVeGBvQxbhbIEfFuM8ofOEIwPl8wH8Xy4S78l2aL5EeA9eWVUppYN6ldQV
         ORimC9ShCyJ9o78hal9gMmofnYhl1vR/E4ODdOyR0lwTA04k7IkPoBYSbo9yW5/pC1Cb
         NfT4YOvIG4A3HDo3/tDrUBZD8MO4rWFDv+K+qfCJPzEiT5LlUGGkudYzLSSmU90N/lbB
         3LtTLRQusN2IzSsPlcGZZB9LAFMf96l0cGTjvqY0F3eWZFEntsNRIxodqAZPPgiCX1Ax
         G7xZgCd+zxOL98YdW+NPqvCnSHAeQZ0tbl2PuYQLaojwiL255dUCfbRqDFFCYBi9QH6H
         Adcg==
X-Gm-Message-State: AAQBX9cjQjvRKlAl8nwSofwrDTSXze5CF0XyB1sv/yn0l4vqUhi6Rx8r
        CRNYBlj7JbS58Yk66juuvxyxqg==
X-Google-Smtp-Source: AKy350YSStvzpj8ckN2dlm2ZDKPCmXkOO8MPKj1SGrOpVpVoFQCvkIaHGATguDKP7y44/9sGbxM2jQ==
X-Received: by 2002:ac2:5ec6:0:b0:4eb:20e:6aec with SMTP id d6-20020ac25ec6000000b004eb020e6aecmr7159970lfq.40.1680223149832;
        Thu, 30 Mar 2023 17:39:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2484a000000b004a2c447598fsm147065lfy.159.2023.03.30.17.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 17:39:09 -0700 (PDT)
Message-ID: <48ac39ed-cb14-a07a-447f-b1022c44737e@linaro.org>
Date:   Fri, 31 Mar 2023 03:39:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] drm/msm/a6xx: Add support for A650 speed binning
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
 <20230120172233.1905761-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120172233.1905761-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 19:22, Konrad Dybcio wrote:
> Add support for matching QFPROM fuse values to get the correct speed bin
> on A650 (SM8250) GPUs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thank you for the patch. It took me a while to dive into various ways 
vendor kernels handle GPU speed bins.

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 0ee8cb3e490c..c5f5d0bb3fdc 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1894,6 +1894,20 @@ static u32 a640_get_speed_bin(u32 fuse)
>   	return UINT_MAX;
>   }
>   
> +static u32 a650_get_speed_bin(u32 fuse)
> +{
> +	if (fuse == 0)
> +		return 0;
> +	else if (fuse == 1)
> +		return 1;
> +	else if (fuse == 2)
> +		return 2;
> +	else if (fuse == 3)
> +		return 3;
> +
> +	return UINT_MAX;
> +}
> +
>   static u32 adreno_7c3_get_speed_bin(u32 fuse)
>   {
>   	if (fuse == 0)
> @@ -1922,6 +1936,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
>   	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
>   		val = a640_get_speed_bin(fuse);
>   
> +	if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
> +		val = a650_get_speed_bin(fuse);
> +
>   	if (val == UINT_MAX) {
>   		DRM_DEV_ERROR(dev,
>   			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",

-- 
With best wishes
Dmitry

