Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68665D066
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjADKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjADKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:08:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543081648E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:08:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso22815066wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qWVpoQHblmDwFl1sBCobe3EL1RtatjgZTaxQDVY+onE=;
        b=ZeVEphlwDCu2OKKQwSIylb81iKaUYqLHC2OaOx5XWZ5KsDkI/M55LIqWkRhMCzngJu
         RAiJuAXSl1C3Ke7OzI+PEU8fJgAW8GycgTgSY/xYJVGgnh/mX9sV+xPV6nbRAutQfLcJ
         UXjMqYHbV62rM+L4wM6JD0BuUqwOV4HjcLcK5bNbt099XTklfejMJSLMA4lbHuY9/GqS
         60zr9ost44CL3S79xYyA/hUExW1rKdjEKXEC2S3QMMd9J7QbGcy+e2V2fz3XLi7inCqD
         mlIM23cnFO6H/8bJ0GCCgSHM2bHSBV3WVwNHRnV37YVSvnJhBRgN5xEg6dDFqVU4m0fZ
         fK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWVpoQHblmDwFl1sBCobe3EL1RtatjgZTaxQDVY+onE=;
        b=OrqOFleYtZT8TkaftrQ2Rm+9qmGerYuerPNcQYID8QshK4vK3v3pFey1zOxcYwBT52
         +SW/N9pnLLvHltnEP5pfMBsd6WdK3lQkaAe/0APuu3g418KXoFfRW6gpWjN/CLycZ2W5
         dJHKeKel4XGkEYOALYHvCaSO6DznVIJtWN8NnDS0PU8n2aOyRp4+GBvpWZN0Xdqx92sM
         tKcYgxlFmKYHH2YVp9saiS94bBuY/BC7Av1nK6ipvoeFd9qzFEAuNhg/9twktQhbI2VQ
         AVI1Qr+LFuzga8MGpFbE5ZlNF6R0jBSo6iQhcFPaaRnHK7TkJ4QTe9vRl0au5MLncp4i
         4RzQ==
X-Gm-Message-State: AFqh2kpjqR4gbX8Wrgbt/IdY6UcMkfY7yqTPaiyAKW8HIa07hmYNmUXx
        8puemO3y9GvBK1eMhxgoGIq0ow==
X-Google-Smtp-Source: AMrXdXtPRTRJrapRYcjS0g4PAGHwCub3tO5l2N4viWO3LyullBOoY5kSV31s6n8XAbIUP5KmHcMObw==
X-Received: by 2002:a7b:cb59:0:b0:3d3:5709:68e8 with SMTP id v25-20020a7bcb59000000b003d3570968e8mr33358155wmj.36.1672826907903;
        Wed, 04 Jan 2023 02:08:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:102f:89e:4a9f:68c? ([2a01:e0a:982:cbb0:102f:89e:4a9f:68c])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c6c182bef9sm58991052wmb.36.2023.01.04.02.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 02:08:27 -0800 (PST)
Message-ID: <de3860ba-40f9-cdd5-097c-e015f6b19255@linaro.org>
Date:   Wed, 4 Jan 2023 11:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] drm/msm/dpu: add support for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-3-9ccd7e652fcd@linaro.org>
 <96ccae6f-3788-e030-480f-7aa2478ca560@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <96ccae6f-3788-e030-480f-7aa2478ca560@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 10:45, Dmitry Baryshkov wrote:
> On 04/01/2023 11:08, Neil Armstrong wrote:
>> Add definitions for the display hardware used on Qualcomm SM8550
>> platform.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 197 +++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |   1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h    |   2 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |   1 +
>>   4 files changed, 201 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index b4ca123d8e69..adf5e25269dc 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c

<snip>

>> @@ -776,6 +821,45 @@ static const struct dpu_ctl_cfg sm8450_ctl[] = {
>>       },
>>   };
>> +static const struct dpu_ctl_cfg sm8550_ctl[] = {
>> +    {
>> +    .name = "ctl_0", .id = CTL_0,
>> +    .base = 0x15000, .len = 0x290,?
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_SPLIT_DISPLAY) | BIT(DPU_CTL_FETCH_ACTIVE),
> 
> CTL_SC7280_MASK | BIT(DPU_CTL_SPLIT_DISPLAY) ?

Indeed DPU_CTL_VM_CFG is missing, will switch to that.

> 
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
>> +    },
>> +    {
>> +    .name = "ctl_1", .id = CTL_1,
>> +    .base = 0x16000, .len = 0x290,
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_SPLIT_DISPLAY) | BIT(DPU_CTL_FETCH_ACTIVE),
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
>> +    },
>> +    {
>> +    .name = "ctl_2", .id = CTL_2,
>> +    .base = 0x17000, .len = 0x290,
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
> 
> CTL_SC7280_MASK?

Ack

> 
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
>> +    },
>> +    {
>> +    .name = "ctl_3", .id = CTL_3,
>> +    .base = 0x18000, .len = 0x290,
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
>> +    },
>> +    {
>> +    .name = "ctl_4", .id = CTL_4,
>> +    .base = 0x19000, .len = 0x290,
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
>> +    },
>> +    {
>> +    .name = "ctl_5", .id = CTL_5,
>> +    .base = 0x1a000, .len = 0x290,
>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 23),
>> +    },
>> +};
>> +
>>   static const struct dpu_ctl_cfg sc7280_ctl[] = {
>>       {
>>       .name = "ctl_0", .id = CTL_0,

<snip>

>> @@ -1268,6 +1386,16 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>>       .len = 0x20, .version = 0x20000},
>>   };
>> +#define PP_BLK_DIPHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>> +    {\
>> +    .name = _name, .id = _id, \
>> +    .base = _base, .len = 0, \
> 
> len = 0 looks incorrect. Any particular reason why can't we use plain PP_BLK here?

The TE block has been moved to the DSI INTF blocks since SM8350 I think, or earlier.

This removes the DPU_PINGPONG_DITHER feature used downstream to enable the PP TE callbacks.

Since there's only the DIPHER sub-block remaining, this is why I set len to 0.

> 
>> +    .features = BIT(DPU_PINGPONG_DITHER), \
>> +    .merge_3d = _merge_3d, \
>> +    .sblk = &_sblk, \
>> +    .intr_done = _done, \
>> +    .intr_rdptr = _rdptr, \
>> +    }
>>   #define PP_BLK_TE(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>>       {\
>>       .name = _name, .id = _id, \

<snip>

