Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7669B439
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBQUvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:51:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D35D3C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:51:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z18so3340637lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaUH39wIG4Hkyo8bl9FqmB9fhuOy8PoEQdyCTVMoWM8=;
        b=H2PHVIoEg7Q+mpHbPQ3C5IuP32zgfr4MsGuFdUJeVetNkWlguMapD0q/UNlU1Qo2NS
         fYaEjI0MCk7BFGJEX1G/Hr3LzqTVjvWjnCUHByRS8rEhpT+SNeO7+eWJcqXdVOXzUMVZ
         46nV0KopHivtGIi0G3LNCvoOu0WTHxIw9zCHjL5IOu+wH+znuM61SiG4eWGDNbI08sHL
         Nn5SiyVQBswoFT6mnS5RhPSFJ7Qah5VRdRDvg8Rfc7KM40nZDMiWKDiXow8h1RhfXb2I
         Tb+o5blmedrCJFzsADmMcpl94MDd7uu/aPD7/zbm8ndnbC4txMyKrwU1E4CyBMoHlsnW
         D62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaUH39wIG4Hkyo8bl9FqmB9fhuOy8PoEQdyCTVMoWM8=;
        b=fPQUEL+9vfqpu9axT1t4TB9QWcqAib70xdZp36j3OukI1hDxSgygO+/mwND5z/yn0I
         CKvqHsGHjTtzfaUby2o3JqCL+vTuDBp67Lq2KtFomWG2iEyRwCxfWuxmfm1037KCk9/5
         FvD0g3gJE2TiIQetNlko6vCnUvSS9AdRwRPoQzkFjoxCMyKSs70G8IcH5asxe2Oyclmz
         dl/VRDFWelbkix13zYNLBcmFc6iSUdHgov5FdPpc3AK1jUskJnfR57cEUMYF2tm4XmFs
         QYxl/nGvqmMUdJMMfaeB6tG1Rxb74Uygy1OQe10/OAstmKZa8Pa2vC3uGU2zZvSmhhP1
         7L7g==
X-Gm-Message-State: AO0yUKWgoo0odzAWkLuWU4RzDt+RAM1/83FRIrYr4QLh1GSo0423LcXU
        revkNb9ehfiY0T7k7Ag9RC47Tg==
X-Google-Smtp-Source: AK7set9hyN2bUTZrJmbKC0oSG02HDrQK9DivB+FyC4+cNf9POowtCVs0iR3CjM2KeH3dF3jZimVQ2Q==
X-Received: by 2002:ac2:51b8:0:b0:4cb:4571:9efe with SMTP id f24-20020ac251b8000000b004cb45719efemr453495lfk.35.1676667097887;
        Fri, 17 Feb 2023 12:51:37 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id c25-20020ac244b9000000b004d85789cef1sm780379lfm.49.2023.02.17.12.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:51:37 -0800 (PST)
Message-ID: <69f4a50b-9566-f892-f1b2-831cf20c6938@linaro.org>
Date:   Fri, 17 Feb 2023 21:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 02/14] drm/msm/a6xx: Extend UBWC config
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <a611e63b-034d-afbd-f194-c789a9071878@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a611e63b-034d-afbd-f194-c789a9071878@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.2023 21:46, Dmitry Baryshkov wrote:
> On 14/02/2023 19:31, Konrad Dybcio wrote:
>> Port setting min_access_length, ubwc_mode and upper_bit from downstream.
>> Values were validated using downstream device trees for SM8[123]50 and
>> left default (as per downstream) elsewhere.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 29 +++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index c5f5d0bb3fdc..8855d798bbb3 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -786,17 +786,25 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>   static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>   {
>>       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>> -    u32 lower_bit = 2;
>> +    u32 lower_bit = 1;
> 
> Any reason to change the default value here?
> If it is to match chipsets you are adding, it might be worth splitting this change to that patch.
Not really now that I think about it, especially since the
correct default value should be zero:

-- part of msm-4.19 --
bit = adreno_dev->highest_bank_bit ? adreno_dev->highest_bank_bit - 13 : 0;
lower_bit = bit & 0x3;
upper_bit = (bit >> 0x2) & 1;

where adreno_dev->highest_bank_bit is read from the dt property
"qcom,highest-bank-bit"

Anyway, I should be able to verify it for all the SoCs which
we support.

Konrad
> 
>> +    u32 upper_bit = 0;
>>       u32 amsbc = 0;
>>       u32 rgb565_predicator = 0;
>>       u32 uavflagprd_inv = 0;
>> +    u32 min_acc_len = 0;
>> +    u32 ubwc_mode = 0;
>>         /* a618 is using the hw default values */
>>       if (adreno_is_a618(adreno_gpu))
>>           return;
>>   -    if (adreno_is_a640_family(adreno_gpu))
>> +    if (adreno_is_a630(adreno_gpu))
>> +        lower_bit = 2;
>> +
>> +    if (adreno_is_a640_family(adreno_gpu)) {
>>           amsbc = 1;
>> +        lower_bit = 2;
>> +    }
>>         if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>>           /* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>> @@ -807,18 +815,23 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>       }
>>         if (adreno_is_7c3(adreno_gpu)) {
>> -        lower_bit = 1;
>>           amsbc = 1;
>>           rgb565_predicator = 1;
>>           uavflagprd_inv = 2;
>>       }
>>         gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
>> -        rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
>> -    gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
>> -    gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
>> -        uavflagprd_inv << 4 | lower_bit << 1);
>> -    gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
>> +          rgb565_predicator << 11 | upper_bit << 10 | amsbc << 4 |
>> +          min_acc_len << 3 | lower_bit << 1 | ubwc_mode);
>> +
>> +    gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, upper_bit << 4 |
>> +          min_acc_len << 3 | lower_bit << 1 | ubwc_mode);
>> +
>> +    gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, upper_bit << 10 |
>> +          uavflagprd_inv << 4 | min_acc_len << 3 |
>> +          lower_bit << 1 | ubwc_mode);
>> +
>> +    gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | lower_bit << 21);
>>   }
>>     static int a6xx_cp_init(struct msm_gpu *gpu)
> 
