Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516926A6083
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjB1Ukc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjB1Uk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:40:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BD34F5F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:40:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi9so14913490lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677616819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLIa+SLDzFv4qAPTVCVsuQOCNXSAjx9BK8vZGNs3laI=;
        b=LUUVFY/tA6VSrTAel6MQ+Jw/Hot3EIAzLSbn2oRg1wYfgRA/7J4ydbZiUN2Y1cTomz
         2W2Nw8ss1GkQEIrOS1btzNDiCO2m06aLxiM1k25ObxGQBAFyWiZLLsFNB+At7xDEqKMY
         fOR7IukcfZJAwUgF39BwMMbTby3JqaXH0XxYUxWCAr/pwD4Ulfh3UJ6PTZzWyCK1u3rc
         huu0jK6k66znwvhyNIoQHl42FoqG1pTl9uKH4pO8dxPVRzvhsGuSx9M8gyqD0zXmn8/L
         LxsUtAr6+3iNfL4mrJ6K2C0+m1SvC5RWrMsvsX0fKaHj3vcBi5UfRkTDdiDb8DWY3SHR
         U0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLIa+SLDzFv4qAPTVCVsuQOCNXSAjx9BK8vZGNs3laI=;
        b=DAcXWRJbsOeewi3zl/QQBHU7NsMegpXdYP+xroDV4rv6h72DqsVVyz3LF5Cj6Ykk6M
         YL4OKSOjZqXqYGVvBowSmVfgg8SOSHVEvZvvxlqVDiMrMqChri0sxlaXMVQ7uZ181yqH
         2UFB4DT7JvtIlNeWnNXTf/WrS8jREiXbHiNJYWgMKdz84A3nvZwJJAqaBoCART33+3SD
         UYJ52D0BvSoTfmkiRRR4ixw22uHrf9gTBBSot7HugUrRqZopY/YvVzKbaHxP0wvqH6lS
         kFUpDUpAiYfn31KO8sN2ToZKMpS8MYdovpng02KBq6/0rsRF6u59C3mvF2lEPMrG/7nu
         XQjQ==
X-Gm-Message-State: AO0yUKUvplI+J71jGgemxIppI/pLPkFQM6W2gnBBfQBzfgLVKIcpLK8N
        EyjU7xlfgvZUx23cVO6zvZOeqQ==
X-Google-Smtp-Source: AK7set+FKTIAiVv1ahQJeaUrgS2lDw/OWJBXpzMyPD1gx6ukpnzJJTaOHAdMm36tlT4eV8Mufznu7g==
X-Received: by 2002:ac2:4241:0:b0:4d8:8273:ec with SMTP id m1-20020ac24241000000b004d8827300ecmr1161495lfl.20.1677616819094;
        Tue, 28 Feb 2023 12:40:19 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id w16-20020ac25990000000b004a9b9ccfbe6sm1467427lfn.51.2023.02.28.12.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:40:18 -0800 (PST)
Message-ID: <487a6890-4b8f-d541-e074-5d3ab7424678@linaro.org>
Date:   Tue, 28 Feb 2023 21:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 04/15] drm/msm/a6xx: Extend and explain UBWC config
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-4-5be55a336819@linaro.org>
 <e19b5cd7-9125-a285-accc-ecf530804cfc@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e19b5cd7-9125-a285-accc-ecf530804cfc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 21:23, Akhil P Oommen wrote:
> On 2/23/2023 5:36 PM, Konrad Dybcio wrote:
>> Rename lower_bit to hbb_lo and explain what it signifies.
>> Add explanations (wherever possible to other tunables).
>>
>> Sort the variable definition and assignment alphabetically.
> Sorting based on decreasing order of line length is more readable, isn't it?
I can do that.

>>
>> Port setting min_access_length, ubwc_mode and hbb_hi from downstream.
>> Set default values for all of the tunables to zero, as they should be.
>>
>> Values were validated against downstream and will be fixed up in
>> separate commits so as not to make this one even more messy.
>>
>> A618 remains untouched (left at hw defaults) in this patch.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 ++++++++++++++++++++++++++++-------
>>  1 file changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index c5f5d0bb3fdc..bdae341e0a7c 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -786,39 +786,74 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>  {
>>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> -	u32 lower_bit = 2;
>> +	/* Unknown, introduced with A640/680 */
>>  	u32 amsbc = 0;
>> +	/*
>> +	 * The Highest Bank Bit value represents the bit of the highest DDR bank.
>> +	 * We then subtract 13 from it (13 is the minimum value allowed by hw) and
>> +	 * write the lowest two bits of the remaining value as hbb_lo and the
>> +	 * one above it as hbb_hi to the hardware. The default values (when HBB is
>> +	 * not specified) are 0, 0.
>> +	 */
>> +	u32 hbb_hi = 0;
>> +	u32 hbb_lo = 0;
>> +	/* Whether the minimum access length is 64 bits */
>> +	u32 min_acc_len = 0;
>> +	/* Unknown, introduced with A650 family, related to UBWC mode/ver 4 */
>>  	u32 rgb565_predicator = 0;
>> +	/* Unknown, introduced with A650 family */
>>  	u32 uavflagprd_inv = 0;
>> +	/* Entirely magic, per-GPU-gen value */
>> +	u32 ubwc_mode = 0;
>>  
>>  	/* a618 is using the hw default values */
>>  	if (adreno_is_a618(adreno_gpu))
>>  		return;
>>  
>> -	if (adreno_is_a640_family(adreno_gpu))
>> +	if (adreno_is_a619(adreno_gpu)) {
>> +		/* HBB = 14 */
>> +		hbb_lo = 1;
>> +	}
>> +
>> +	if (adreno_is_a630(adreno_gpu)) {
>> +		/* HBB = 15 */
>> +		hbb_lo = 2;
>> +	}
>> +
>> +	if (adreno_is_a640_family(adreno_gpu)) {
>>  		amsbc = 1;
>> +		/* HBB = 15 */
>> +		hbb_lo = 2;
>> +	}
>>  
>>  	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>> -		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>> -		lower_bit = 3;
>>  		amsbc = 1;
>> +		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>> +		/* HBB = 16 */
>> +		hbb_lo = 3;
>>  		rgb565_predicator = 1;
>>  		uavflagprd_inv = 2;
>>  	}
>>  
>>  	if (adreno_is_7c3(adreno_gpu)) {
>> -		lower_bit = 1;
>>  		amsbc = 1;
>> +		/* HBB is unset in downstream DTS, defaulting to 0 */
> This is incorrect. For 7c3 hbb value is 14. So hbb_lo should be 1. FYI, hbb configurations were moved to the driver from DT in recent downstream kernels.
Right, seems to have happened with msm-5.10. Though a random kernel I
grabbed seems to suggest it's 15 and not 14?

https://github.com/sonyxperiadev/kernel/blob/aosp/K.P.1.0.r1/drivers/gpu/msm/adreno-gpulist.h#L1710

Konrad
> 
> -Akhil.
>>  		rgb565_predicator = 1;
>>  		uavflagprd_inv = 2;
>>  	}
>>  
>>  	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
>> -		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
>> -	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
>> -	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
>> -		uavflagprd_inv << 4 | lower_bit << 1);
>> -	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
>> +		  rgb565_predicator << 11 | hbb_hi << 10 | amsbc << 4 |
>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>> +
>> +	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, hbb_hi << 4 |
>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>> +
>> +	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, hbb_hi << 10 |
>> +		  uavflagprd_inv << 4 | min_acc_len << 3 |
>> +		  hbb_lo << 1 | ubwc_mode);
>> +
>> +	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | hbb_lo << 21);
>>  }
>>  
>>  static int a6xx_cp_init(struct msm_gpu *gpu)
>>
> 
