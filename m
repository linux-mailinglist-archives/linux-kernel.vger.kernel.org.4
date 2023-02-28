Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5906A612C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB1VWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjB1VWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:22:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841BE32E73
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:22:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g17so15040738lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677619329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c00Qj/i0YsYnbVJ+ujO8bcgmf6XZfCPNhrLp78qJmoI=;
        b=beUsA/gpmi5dzol+71rvbxUW5hfb+7O6tGe/iuqkuGhhfGTFj0I0rOCerycqBftdCX
         w5qDCLXxvo0eSsgJxFzrRO2lr8hmlMg1kOcVMmd64/gTqaR7v83EvECPUcKf9UgJl+/8
         FnwlGWdkQJC/CZdXE/2d2yVrR+qDHNjnkC2ly6gJwwoDB4vgF05MbPPIw/JM9rJBrnHF
         LAvWWbcv3lz32IyqE1J0CzL0BE0bWIow31kGpN5TSOHBtWV2p4EpqhK1falFRFogb4hv
         TOYOQCxv/sn75YsSj8aJzXG7Ga2pP3WiZrO30jfyiHQB8AsvRHsoiONUWe1iZ5dDiKgY
         2m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c00Qj/i0YsYnbVJ+ujO8bcgmf6XZfCPNhrLp78qJmoI=;
        b=vGlInNPGgw2mA2CK3yYdy3aUFfN1TBJxQDFy68pVINyv5khSWMYyIFBncCpb/Fb430
         bmis3Bue44IsmnOmuMq/HVLaLuFb+J0q3LWM5TMDcSPzHEj1N5tTj8KgVTVe+bU3TeMg
         UhujkdtfYIyH/SW0MmyyAYGwVcSmH+lo/tLKEoAnw6oGCxYNYuP/7XR/I88hEaPZ/mh+
         Dq3oFXQpVpZQ/X6voicEjsI5JQIa6CgtnoQ73jfezTnBqC9bSQkmaDXdpY6chlL0hWVK
         7V6+mYVIZWBW6rYjSG298Rzf98ND5pCUZdAryyv4PWMQJ9jHiLAvs7aYm5n5FRYtHEvJ
         cFBQ==
X-Gm-Message-State: AO0yUKVQZ4K90uYUiWnSGvYkQgwCT/9yUDWrrI1gyXUE9YgVTWvXSh6y
        fY6NEo5dDgFqYpnvWk1rNq4U1g==
X-Google-Smtp-Source: AK7set8Eab20dptC+3fOTnjrjxgGq0+x7TgmW263JStUHtG7GQ7d8msWu6bwB+aaTP7lCHk7q4h+Jw==
X-Received: by 2002:a05:6512:50f:b0:4df:9ce8:300 with SMTP id o15-20020a056512050f00b004df9ce80300mr957904lfb.52.1677619328687;
        Tue, 28 Feb 2023 13:22:08 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id g28-20020a2eb5dc000000b00295b0a7d8e0sm1307811ljn.131.2023.02.28.13.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 13:22:08 -0800 (PST)
Message-ID: <c608fa1b-96dd-8d32-3d00-28d40c734b43@linaro.org>
Date:   Tue, 28 Feb 2023 22:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Freedreno] [PATCH v3 04/15] drm/msm/a6xx: Extend and explain
 UBWC config
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
Cc:     Rob Clark <robdclark@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-4-5be55a336819@linaro.org>
 <e19b5cd7-9125-a285-accc-ecf530804cfc@quicinc.com>
 <487a6890-4b8f-d541-e074-5d3ab7424678@linaro.org>
 <26953463-dae1-0f07-9e4e-0314ee8ea81a@quicinc.com>
 <5a8a7fa1-bba3-50a2-aa39-83d342ba70c1@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5a8a7fa1-bba3-50a2-aa39-83d342ba70c1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 21:48, Akhil P Oommen wrote:
> On 3/1/2023 2:14 AM, Akhil P Oommen wrote:
>> On 3/1/2023 2:10 AM, Konrad Dybcio wrote:
>>> On 28.02.2023 21:23, Akhil P Oommen wrote:
>>>> On 2/23/2023 5:36 PM, Konrad Dybcio wrote:
>>>>> Rename lower_bit to hbb_lo and explain what it signifies.
>>>>> Add explanations (wherever possible to other tunables).
>>>>>
>>>>> Sort the variable definition and assignment alphabetically.
>>>> Sorting based on decreasing order of line length is more readable, isn't it?
>>> I can do that.
>>>
>>>>> Port setting min_access_length, ubwc_mode and hbb_hi from downstream.
>>>>> Set default values for all of the tunables to zero, as they should be.
>>>>>
>>>>> Values were validated against downstream and will be fixed up in
>>>>> separate commits so as not to make this one even more messy.
>>>>>
>>>>> A618 remains untouched (left at hw defaults) in this patch.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 ++++++++++++++++++++++++++++-------
>>>>>  1 file changed, 45 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> index c5f5d0bb3fdc..bdae341e0a7c 100644
>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>> @@ -786,39 +786,74 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>>>>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>>>>  {
>>>>>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>>>> -	u32 lower_bit = 2;
>>>>> +	/* Unknown, introduced with A640/680 */
>>>>>  	u32 amsbc = 0;
>>>>> +	/*
>>>>> +	 * The Highest Bank Bit value represents the bit of the highest DDR bank.
>>>>> +	 * We then subtract 13 from it (13 is the minimum value allowed by hw) and
>>>>> +	 * write the lowest two bits of the remaining value as hbb_lo and the
>>>>> +	 * one above it as hbb_hi to the hardware. The default values (when HBB is
>>>>> +	 * not specified) are 0, 0.
>>>>> +	 */
>>>>> +	u32 hbb_hi = 0;
>>>>> +	u32 hbb_lo = 0;
>>>>> +	/* Whether the minimum access length is 64 bits */
>>>>> +	u32 min_acc_len = 0;
>>>>> +	/* Unknown, introduced with A650 family, related to UBWC mode/ver 4 */
>>>>>  	u32 rgb565_predicator = 0;
>>>>> +	/* Unknown, introduced with A650 family */
>>>>>  	u32 uavflagprd_inv = 0;
>>>>> +	/* Entirely magic, per-GPU-gen value */
>>>>> +	u32 ubwc_mode = 0;
>>>>>  
>>>>>  	/* a618 is using the hw default values */
>>>>>  	if (adreno_is_a618(adreno_gpu))
>>>>>  		return;
>>>>>  
>>>>> -	if (adreno_is_a640_family(adreno_gpu))
>>>>> +	if (adreno_is_a619(adreno_gpu)) {
>>>>> +		/* HBB = 14 */
>>>>> +		hbb_lo = 1;
>>>>> +	}
>>>>> +
>>>>> +	if (adreno_is_a630(adreno_gpu)) {
>>>>> +		/* HBB = 15 */
>>>>> +		hbb_lo = 2;
>>>>> +	}
>>>>> +
>>>>> +	if (adreno_is_a640_family(adreno_gpu)) {
>>>>>  		amsbc = 1;
>>>>> +		/* HBB = 15 */
>>>>> +		hbb_lo = 2;
>>>>> +	}
>>>>>  
>>>>>  	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>>>>> -		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>>> -		lower_bit = 3;
>>>>>  		amsbc = 1;
>>>>> +		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>>> +		/* HBB = 16 */
>>>>> +		hbb_lo = 3;
>>>>>  		rgb565_predicator = 1;
>>>>>  		uavflagprd_inv = 2;
>>>>>  	}
>>>>>  
>>>>>  	if (adreno_is_7c3(adreno_gpu)) {
>>>>> -		lower_bit = 1;
>>>>>  		amsbc = 1;
>>>>> +		/* HBB is unset in downstream DTS, defaulting to 0 */
>>>> This is incorrect. For 7c3 hbb value is 14. So hbb_lo should be 1. FYI, hbb configurations were moved to the driver from DT in recent downstream kernels.
>>> Right, seems to have happened with msm-5.10. Though a random kernel I
>>> grabbed seems to suggest it's 15 and not 14?
>>>
>>> https://github.com/sonyxperiadev/kernel/blob/aosp/K.P.1.0.r1/drivers/gpu/msm/adreno-gpulist.h#L1710
>> We override that with 14 in a6xx_init() for LP4 platforms dynamically. Since 7c3 is only supported on LP4, we can hardcode 14 here.
Okay, I see.

>> In the downstream kernel, there is an api (of_fdt_get_ddrtype()) to detect ddrtype. If we can get something like that in upstream, we should implement a similar logic here.
Yeah, I mentioned it here [1], but I doubt it'd be implemented,
given what Krzysztof pointed out.

>>
>> -Akhil.
> Also, I haven't closely reviewed other targets configuration you updated, but it is a good idea to leave the existing configurations here as it in this refactor patch. Any update should be a separate patch.
Sure, will do.

Konrad

[1] https://github.com/devicetree-org/devicetree-specification/issues/62
> 
> -Akhil.
>>> Konrad
>>>> -Akhil.
>>>>>  		rgb565_predicator = 1;
>>>>>  		uavflagprd_inv = 2;
>>>>>  	}
>>>>>  
>>>>>  	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
>>>>> -		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
>>>>> -	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
>>>>> -	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
>>>>> -		uavflagprd_inv << 4 | lower_bit << 1);
>>>>> -	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
>>>>> +		  rgb565_predicator << 11 | hbb_hi << 10 | amsbc << 4 |
>>>>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>>>>> +
>>>>> +	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, hbb_hi << 4 |
>>>>> +		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
>>>>> +
>>>>> +	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, hbb_hi << 10 |
>>>>> +		  uavflagprd_inv << 4 | min_acc_len << 3 |
>>>>> +		  hbb_lo << 1 | ubwc_mode);
>>>>> +
>>>>> +	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | hbb_lo << 21);
>>>>>  }
>>>>>  
>>>>>  static int a6xx_cp_init(struct msm_gpu *gpu)
>>>>>
> 
