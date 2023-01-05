Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291B65E886
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAEKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjAEKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:00:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3458FA4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:59:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso900478wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TzUHuJF+1GtjKbGnuP0VxWAofVGSsonV8HAjRWPNYtE=;
        b=vuI5XC/ElzTz0lZgBI1+7M7TkLcYdoazvJmSS7s/KySvZKg8Xqo/F0UKxcKCsnqvKk
         hQ+bN+pWIJt0ozmieFOEO+AqGHLbZq2AKjcUZ4DAKfuAiyvTEmgd/+QN+d+LUfy8xqOW
         pdyUt70nhyPPiToCRx/FwjsjeciPCvGJadPS9KZH0i2omvLfRXZduVybqTmclWzoSBgV
         9JcElXb9LClrjpqomBtinyS5eHmmE1D7ctf5rt0GNa1SKClf+jKx3YFUTSdClpTpb0Vu
         c0klsP4V3JNpqIZ7UGy7wEd6zIABAZPZy1XGY788ZsVOA7Gg6cFuL8+uP9d5wKbGFvbj
         l49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzUHuJF+1GtjKbGnuP0VxWAofVGSsonV8HAjRWPNYtE=;
        b=ZtjAf7zKPX/ui4DhEFEI78zJR6HHyVTvNmZUnN+I7O+NNtquWV/QPATvUts+9zxZkg
         kro3UyVwByypSogpHJDY+JzyMMqiVTGxa5qsD1ycMfM7HkNj9/7Cg0zR70AOYU/iBlYT
         UDrW8/uCU3H7RSE1+/QceBqlc5r8f6rfKAm0yJN2SA51UQfWkETvIoRCGWiofG0npMYL
         iZfrqc2WP/xwF3n8pr32iNvXzYdK07IxzxLZXYW1yvgOQc1vBG3CU+EWvHA0ZYFC2qOr
         YqNbFTt6IgcVyQlElsUpyR8YYidu53KvqRI2d+jJ0Gcf5io5hNK0+itQsUrdoNebAWtu
         ysXQ==
X-Gm-Message-State: AFqh2kpeAMG00OZ2xL2Uq/Q3XYY9Cxt7f2y4UkzYy7S/lS1eSJs+88Q3
        6ga8SiVZEIDt8oCja/AHc6y2QA==
X-Google-Smtp-Source: AMrXdXsQZ0DK0v9sW/V/Gfm1iQioAHO/VQix/Tw5Y8roIvVtwON8/NprodDB8Q5coTZo2iLhNB4AVw==
X-Received: by 2002:a05:600c:1d89:b0:3d3:5cd6:781 with SMTP id p9-20020a05600c1d8900b003d35cd60781mr35095929wms.37.1672912771401;
        Thu, 05 Jan 2023 01:59:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1e12:c16d:1898:607c? ([2a01:e0a:982:cbb0:1e12:c16d:1898:607c])
        by smtp.gmail.com with ESMTPSA id g41-20020a05600c4ca900b003cfd0bd8c0asm1652910wmp.30.2023.01.05.01.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:59:30 -0800 (PST)
Message-ID: <342119d7-87fb-2880-2729-4c173ce60d4d@linaro.org>
Date:   Thu, 5 Jan 2023 10:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] drm/msm/dpu: add support for SM8550
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-3-9ccd7e652fcd@linaro.org>
 <96ccae6f-3788-e030-480f-7aa2478ca560@linaro.org>
 <de3860ba-40f9-cdd5-097c-e015f6b19255@linaro.org>
 <CAA8EJpoi8QFpvR0qWpNpenZKzEZAQpwp3gNpGd3RwHovgC+Odw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAA8EJpoi8QFpvR0qWpNpenZKzEZAQpwp3gNpGd3RwHovgC+Odw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 18:48, Dmitry Baryshkov wrote:
> On Wed, 4 Jan 2023 at 12:08, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 04/01/2023 10:45, Dmitry Baryshkov wrote:
>>> On 04/01/2023 11:08, Neil Armstrong wrote:
>>>> Add definitions for the display hardware used on Qualcomm SM8550
>>>> platform.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 197 +++++++++++++++++++++++++
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |   1 +
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h    |   2 +
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |   1 +
>>>>    4 files changed, 201 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>> index b4ca123d8e69..adf5e25269dc 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>
>> <snip>
>>
>>>> @@ -776,6 +821,45 @@ static const struct dpu_ctl_cfg sm8450_ctl[] = {
>>>>        },
>>>>    };
>>>> +static const struct dpu_ctl_cfg sm8550_ctl[] = {
>>>> +    {
>>>> +    .name = "ctl_0", .id = CTL_0,
>>>> +    .base = 0x15000, .len = 0x290,?
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_SPLIT_DISPLAY) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>
>>> CTL_SC7280_MASK | BIT(DPU_CTL_SPLIT_DISPLAY) ?
>>
>> Indeed DPU_CTL_VM_CFG is missing, will switch to that.
>>
>>>
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
>>>> +    },
>>>> +    {
>>>> +    .name = "ctl_1", .id = CTL_1,
>>>> +    .base = 0x16000, .len = 0x290,
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_SPLIT_DISPLAY) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
>>>> +    },
>>>> +    {
>>>> +    .name = "ctl_2", .id = CTL_2,
>>>> +    .base = 0x17000, .len = 0x290,
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>
>>> CTL_SC7280_MASK?
>>
>> Ack
>>
>>>
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
>>>> +    },
>>>> +    {
>>>> +    .name = "ctl_3", .id = CTL_3,
>>>> +    .base = 0x18000, .len = 0x290,
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
>>>> +    },
>>>> +    {
>>>> +    .name = "ctl_4", .id = CTL_4,
>>>> +    .base = 0x19000, .len = 0x290,
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
>>>> +    },
>>>> +    {
>>>> +    .name = "ctl_5", .id = CTL_5,
>>>> +    .base = 0x1a000, .len = 0x290,
>>>> +    .features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE),
>>>> +    .intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 23),
>>>> +    },
>>>> +};
>>>> +
>>>>    static const struct dpu_ctl_cfg sc7280_ctl[] = {
>>>>        {
>>>>        .name = "ctl_0", .id = CTL_0,
>>
>> <snip>
>>
>>>> @@ -1268,6 +1386,16 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>>>>        .len = 0x20, .version = 0x20000},
>>>>    };
>>>> +#define PP_BLK_DIPHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>>>> +    {\
>>>> +    .name = _name, .id = _id, \
>>>> +    .base = _base, .len = 0, \
>>>
>>> len = 0 looks incorrect. Any particular reason why can't we use plain PP_BLK here?
>>
>> The TE block has been moved to the DSI INTF blocks since SM8350 I think, or earlier.
> 
> I think, 8150. Marijn has been working on adding support for INTF-based TE.
> 
>> This removes the DPU_PINGPONG_DITHER feature used downstream to enable the PP TE callbacks.
>> Since there's only the DIPHER sub-block remaining, this is why I set len to 0.
> 
> I went on with some research. Usually PP len is 0xd4. However it seems
> since 8350 (since the change of DSC block) the PP size should be 0x0),
> despite dowsnstream DTs having sde-pp-size=0xd4 for sm8350 and sm8450
> (or 0x4 for neo, DPU 9.1.0).

Perhaps neo has a single register at PP base address, on 8550 there's none.

> So, it looks like you are correct here (and we should fix 8350/8450
> patches instead).

Yes it must be because with the new DSC block, the PP DCE_DATA_XX_SWAP/DSC_MODE registers were removed,
so I expect they are still present in 8150 & 8250.

Neil

> 
>>
>>>
>>>> +    .features = BIT(DPU_PINGPONG_DITHER), \
>>>> +    .merge_3d = _merge_3d, \
>>>> +    .sblk = &_sblk, \
>>>> +    .intr_done = _done, \
>>>> +    .intr_rdptr = _rdptr, \
>>>> +    }
>>>>    #define PP_BLK_TE(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>>>>        {\
>>>>        .name = _name, .id = _id, \
>>
>> <snip>
>>
> 
> 

