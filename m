Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB896FBB47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjEHXI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjEHXI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:08:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76849FE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:08:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so5902730e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683587334; x=1686179334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b48s8mcAPXAqywC5BMS6eAKj5imZxHgkpEOozlPTbFE=;
        b=vsiZxbslapGTm+ygq4pII2b5i0YjKhtHvSZzFAomQ5+okHqhOBo/okWenjB1uvO42W
         rM0irmVWK0ieIkW8r7x2suoHSe77DrQvQ0HEL4bX5q9PyPOKC/43v8U8cH+auDhoL0js
         LF1XWQf7qDv/Uyai7sJ0VZMYQtRWK3FU3Gr7LDiCQpYFyjcFF3EHILJnoZHGipZKLcTl
         jCF9T3zjbZnW7XNzg8mVfyOp/C0UOqbtM3c3z0XRvZIAfTOitbhjC70sPKLRrD+UjFqo
         jHKUy3mWba9bDy853PHOW5Bl9fA/H31yqcl5JjP0KM+FgV+po7OmYe+ZwZmEZF84+mQP
         RFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683587334; x=1686179334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b48s8mcAPXAqywC5BMS6eAKj5imZxHgkpEOozlPTbFE=;
        b=g3bd1Rxg+/1KDNkPJ4fTRiFVpP7/g/0sMsI+pMYHw9wQcRKzGk52Val2r5uNGI9gge
         cJQN4A+qGA5rlQk/pZ3otHtvru5mu5pmsLXpGFke6TGbZjt5F2QQYNIQsigI7c5RJPTA
         wejPs5RhZeaxCD+S3dVmSKydpQW3nIsFIoXy/7K2kQplCy8JSRreKPpTkQbx0h2WBlPJ
         su5IepQEZPHMn1UJv3XGS6bfe4av+HM0zjKWt5h7tr4nQXAkGVQuw3aGrb16yUTnFxbV
         pMXYcKORVPEcySXPLhwRXjIUpoI43lx0b7JWn0TxtkhN8RVY0AwPl2sp3tAHPNurc78C
         BYjg==
X-Gm-Message-State: AC+VfDyA+zZVeiQy+f1bwEiXRahVlT+/PvHrZstJ7yCwC09OWw/xHiH/
        /Xipdt5aZiOdAeJYoTYBOz5Cgw==
X-Google-Smtp-Source: ACHHUZ4ViOeyL+Un82hufdNmJAboZeTOF6Q6XeG29tPl179/V3Hgsg9bG2GD/UP0jWcWX/Eq8yto7g==
X-Received: by 2002:ac2:488c:0:b0:4f1:4086:9384 with SMTP id x12-20020ac2488c000000b004f140869384mr153611lfc.61.1683587333966;
        Mon, 08 May 2023 16:08:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w9-20020ac25989000000b004db3900da02sm125532lfn.73.2023.05.08.16.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 16:08:53 -0700 (PDT)
Message-ID: <0aa4130d-bb37-4743-10e5-fd518276f4a2@linaro.org>
Date:   Tue, 9 May 2023 02:08:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature
 flag
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-3-1072c70e9786@quicinc.com>
 <i6i2xj2tuy5mcxsj674d77kfdb3ne6immkmrzw5f6u4bfx2sth@ef7fzrhdyypx>
 <1d7ccb5f-55c2-3b3a-df97-2c17beffabfc@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1d7ccb5f-55c2-3b3a-df97-2c17beffabfc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 00:46, Jessica Zhang wrote:
> 
> 
> On 5/7/2023 9:00 AM, Marijn Suijten wrote:
>> On 2023-05-05 14:23:50, Jessica Zhang wrote:
>>> Add DATA_COMPRESS feature flag to DPU INTF block.
>>>
>>> In DPU 7.x and later, DSC/DCE enablement registers have been moved from
>>> PINGPONG to INTF.
>>>
>>> As core_rev (and related macros) was removed from the dpu_kms struct, 
>>> the
>>> most straightforward way to indicate the presence of this register 
>>> would be
>>> to have a feature flag.
>>
>> Irrelevant.  Even though core_rev was still in mainline until recently,
>> we always hardcoded the features in the catalog and only used core_rev
>> to select a dpu_mdss_cfg catalog entry.  There is no "if version >= X
>> then enable feature Y" logic, this manually-enabled feature flag is the
>> only, correct way to do it.
> 
> Hi Marijn,
> 
> Understood. FWIW, if we do find more register bit-level differences 
> between HW versions in the future, it might make more sense to keep the 
> HW catalog small and bring core_rev back, rather than keep adding these 
> kinds of small differences to caps.

Let's see how it goes. Abhinav suggested that there might be feature 
differences inside the DPU generations (and even inside the single DPU 
major/minor combo). So I'm not sure what core_rev will bring us.

Let's land the platforms which are ready (or if there is anything close 
to be submitted). I'll post the next proposal for the catalog cleanups 
close to -rc4, when the dust settles then we can have one or two weaks 
for the discussion and polishing.

I'd like to consider:
- inlining foo_BLK macros, if that makes adding new features easier
- reformat of clk_ctrls
- maybe reintroduction of per-generation feature masks instead of 
keeping them named after the random SoC
- maybe a rework of mdss_irqs / INTFn_INTR. We already have this info in 
hw catalog.

Comments are appreciated.


> 
> Thanks,
> 
> Jessica Zhang
> 
>>
>>> Changes in v2:
>>> - Changed has_data_compress dpu_cap to a DATA_COMPRESS INTF feature flag
>>>
>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>> index 7944481d0a33..c74051906d05 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>> @@ -104,7 +104,7 @@
>>>   #define INTF_SC7180_MASK \
>>>       (BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | 
>>> BIT(DPU_INTF_STATUS_SUPPORTED))
>>> -#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
>>> +#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN) | 
>>> BIT(DPU_INTF_DATA_COMPRESS)
>>
>> Konrad: Your SM6350/SM6375 series v3 [1] switched from INTF_SC7180_MASK
>> to INTF_SC7280_MASK to enable HCTL on SM6375, but that will now
>> erroneously also receive this feature flag and write the new
>> DATA_COMPESS mask even if it's DPU 6.9 (< 7.x where it got added).
>>
>> [1]: 
>> https://lore.kernel.org/linux-arm-msm/80b46fcb-d6d0-1998-c273-5401fa924c7d@linaro.org/T/#u
>>
>> Depending on who lands first, this flag should be split.
>>
>> I still see value in inlining and removing these defines, though that
>> brings a host of other complexity.
>>
>> - Marijn
>>
>>>   #define WB_SM8250_MASK (BIT(DPU_WB_LINE_MODE) | \
>>>                BIT(DPU_WB_UBWC) | \
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>>> index 4eda2cc847ef..01c65f940f2a 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>>> @@ -185,6 +185,7 @@ enum {
>>>    * @DPU_DATA_HCTL_EN                Allows data to be transferred 
>>> at different rate
>>>    *                                  than video timing
>>>    * @DPU_INTF_STATUS_SUPPORTED       INTF block has INTF_STATUS 
>>> register
>>> + * @DPU_INTF_DATA_COMPRESS          INTF block has DATA_COMPRESS 
>>> register
>>>    * @DPU_INTF_MAX
>>>    */
>>>   enum {
>>> @@ -192,6 +193,7 @@ enum {
>>>       DPU_INTF_TE,
>>>       DPU_DATA_HCTL_EN,
>>>       DPU_INTF_STATUS_SUPPORTED,
>>> +    DPU_INTF_DATA_COMPRESS,
>>>       DPU_INTF_MAX
>>>   };
>>>
>>> -- 
>>> 2.40.1
>>>

-- 
With best wishes
Dmitry

