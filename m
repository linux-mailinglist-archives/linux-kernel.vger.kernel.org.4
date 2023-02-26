Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB96A2FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBZNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:13:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573610272
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:13:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m7so5120196lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04CVCq5QDsSsRhbW4z4uIT/WR7uzqDfoUDjv5E0r+XE=;
        b=JlUAT2RIAAGcMUotOo7foENJSQNz0aAzLQ7JI7d1AKy3Abw+klLl4+VfxqIwgSzRmt
         OfbE4/H99S4/K3tIck2yrn+D/92rFPujJTVAh1Ns8t3OgjwI4Qn4zTUb2ubJU2dxHGCh
         QUErcfDj2MTrhutjbpRzRtkuzCmXHx/je51ZgjrIBgHWJ0ANPynzmVGGE8QuK/dSsiOv
         j6uSWLg9LI/UrdPY9sAiEI/FlZNnFQtjIJeRqSapY9MMkSX2bO9Y++9tQkp7ccr0dhC4
         B5B+06AoY7War6i+MGjQBcDr8dxS7XXUQ53XextXKODDQJsatY3uwhIBFxpUVEAjVGYU
         znJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04CVCq5QDsSsRhbW4z4uIT/WR7uzqDfoUDjv5E0r+XE=;
        b=37YZ4LR3gIVghLE0JqH2bKdt5EhZuwdKoJYMuGsuDPnu+juKjax/QviTWXaNmsO0OI
         obiIrJZllZA5MhsFHLVGeJxTJuxI3y/pbpS2VxswmWZr+9eK+8XPaxTB3/r58zZiEnDj
         0L31BspXt4tCqT3nl7KIcj4pjmDTl+zn/jiSgKbAbg3MZVnX9a6mwXtJJFdA4lWP6zMA
         3ZuZ1PMxbzZO6DxPvlcgRCVw08EB1wt7cQQBRpf2T3QeDcM+fj818RwT3VwrrItHR1Wg
         m0Pz6K+ndmOyN1fumsSQRM9WQS2HYKhHKwqGl6wuDP9mMswwMQfuD+RhQE8PSjT5TBhn
         D5cA==
X-Gm-Message-State: AO0yUKVWD0MK0y0IFcBlYYhz+9JGpWltE9jwyIBiV/scVFqjb/CQq5Mb
        QIsxcXN4fyYE31QHFdkwei2f2A==
X-Google-Smtp-Source: AK7set+BeKFRt03jsGvtd7WQ8AxrX4vGXFJalbx1uI46DSm15P8eB/PTAEtUpaG6Y2t21anZgAu8iQ==
X-Received: by 2002:a19:c20c:0:b0:4db:26b1:ec4b with SMTP id l12-20020a19c20c000000b004db26b1ec4bmr6795399lfc.49.1677417220417;
        Sun, 26 Feb 2023 05:13:40 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25146000000b004cc8196a308sm551952lfd.98.2023.02.26.05.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 05:13:40 -0800 (PST)
Message-ID: <11c43f8b-eb17-50c0-5158-6c485e5be423@linaro.org>
Date:   Sun, 26 Feb 2023 15:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFC PATCH 1/2] drm/msm/dpu: add dsc helper functions
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
 <1677267647-28672-2-git-send-email-quic_khsieh@quicinc.com>
 <42b3c193-8897-cfe9-1cae-2f9a66f7983a@linaro.org>
 <1b5afec9-454d-e1b9-0274-f0476edb4d21@quicinc.com>
 <CAA8EJprowFyBMdW5QC2zG0gYUtxJ-hHXqhPfYTct2GzYJKLSHg@mail.gmail.com>
 <7650f183-9860-9074-e5d5-539afdf41248@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <7650f183-9860-9074-e5d5-539afdf41248@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2023 02:16, Abhinav Kumar wrote:
> Hi Dmitry
> 
> On 2/24/2023 3:57 PM, Dmitry Baryshkov wrote:
>> On Sat, 25 Feb 2023 at 01:51, Kuogee Hsieh <quic_khsieh@quicinc.com> 
>> wrote:
>>>
>>>
>>> On 2/24/2023 1:13 PM, Dmitry Baryshkov wrote:
>>>> On 24/02/2023 21:40, Kuogee Hsieh wrote:
>>>>> Add DSC helper functions based on DSC configuration profiles to 
>>>>> produce
>>>>> DSC related runtime parameters through both table look up and runtime
>>>>> calculation to support DSC on DPU.
>>>>>
>>>>> There are 6 different DSC configuration profiles are supported
>>>>> currently.
>>>>> DSC configuration profiles are differiented by 5 keys, DSC version
>>>>> (V1.1),
>>>>> chroma (444/422/420), colorspace (RGB/YUV), bpc(8/10),
>>>>> bpp (6/7/7.5/8/9/10/12/15) and SCR (0/1).
>>>>>
>>>>> Only DSC version V1.1 added and V1.2 will be added later.
>>>>
>>>> These helpers should go to drivers/gpu/drm/display/drm_dsc_helper.c
>>>> Also please check that they can be used for i915 or for amdgpu
>>>> (ideally for both of them).
>>>>
>>>> I didn't check the tables against the standard (or against the current
>>>> source code), will do that later.
>>>>
>>>>>
>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>> ---
>>>>>    drivers/gpu/drm/msm/Makefile                   |   1 +
>>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209
>>>>> +++++++++++++++++++++++++
>>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  34 ++++
>>>>>    3 files changed, 244 insertions(+)
>>>>>    create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>>>>>    create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/Makefile 
>>>>> b/drivers/gpu/drm/msm/Makefile
>>>>> index 7274c412..28cf52b 100644
>>>>> --- a/drivers/gpu/drm/msm/Makefile
>>>>> +++ b/drivers/gpu/drm/msm/Makefile
>>>>> @@ -65,6 +65,7 @@ msm-$(CONFIG_DRM_MSM_DPU) += \
>>>>>        disp/dpu1/dpu_hw_catalog.o \
>>>>>        disp/dpu1/dpu_hw_ctl.o \
>>>>>        disp/dpu1/dpu_hw_dsc.o \
>>>>> +    disp/dpu1/dpu_dsc_helper.o \
>>>>>        disp/dpu1/dpu_hw_interrupts.o \
>>>>>        disp/dpu1/dpu_hw_intf.o \
>>>>>        disp/dpu1/dpu_hw_lm.o \
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>>>>> new file mode 100644
>>>>> index 00000000..88207e9
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>>>>> @@ -0,0 +1,209 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights
>>>>> reserved
>>>>> + */
>>>>> +
>>>>> +#include <drm/display/drm_dsc_helper.h>
>>>>> +#include "msm_drv.h"
>>>>> +#include "dpu_kms.h"
>>>>> +#include "dpu_hw_dsc.h"
>>>>> +#include "dpu_dsc_helper.h"
>>>>> +
>>>>> +
>>>>
>>>> Extra empty line
>>>>
>>>>> +#define DPU_DSC_PPS_SIZE       128
>>>>> +
>>>>> +enum dpu_dsc_ratio_type {
>>>>> +    DSC_V11_8BPC_8BPP,
>>>>> +    DSC_V11_10BPC_8BPP,
>>>>> +    DSC_V11_10BPC_10BPP,
>>>>> +    DSC_V11_SCR1_8BPC_8BPP,
>>>>> +    DSC_V11_SCR1_10BPC_8BPP,
>>>>> +    DSC_V11_SCR1_10BPC_10BPP,
>>>>> +    DSC_RATIO_TYPE_MAX
>>>>> +};
>>>>> +
>>>>> +
>>>>> +static u16 dpu_dsc_rc_buf_thresh[DSC_NUM_BUF_RANGES - 1] = {
>>>>> +        0x0e, 0x1c, 0x2a, 0x38, 0x46, 0x54,
>>>>> +        0x62, 0x69, 0x70, 0x77, 0x79, 0x7b, 0x7d, 0x7e
>>>>
>>>> Weird indentation
>>>>
>>>>> +};
>>>>> +
>>>>> +/*
>>>>> + * Rate control - Min QP values for each ratio type in
>>>>> dpu_dsc_ratio_type
>>>>> + */
>>>>> +static char
>>>>> dpu_dsc_rc_range_min_qp[DSC_RATIO_TYPE_MAX][DSC_NUM_BUF_RANGES] = {
>>>>> +    /* DSC v1.1 */
>>>>> +    {0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 7, 13},
>>>>> +    {0, 4, 5, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 17},
>>>>> +    {0, 4, 5, 6, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 15},
>>>>> +    /* DSC v1.1 SCR and DSC v1.2 RGB 444 */
>>>>
>>>> What is SCR? Is there any reason to use older min/max Qp params
>>>> instead of always using the ones from the VESA-DSC-1.1 standard?
>>>
>>> Standards change request, some vendors may use scr to work with their 
>>> panel.
>>>
>>> These table value are provided by system team.
>>
>> So, what will happen if we use values from 1.2 standard (aka 1.1 SCR
>> 1) with the older panel?
>>
> 
> Standards change request means fixing errors/errata for the given 
> standard. Those are typically released as a different spec.
> 
> So I referred the DSC 1.1 SCR spec, and it does have a few differences 
> in the table compared to DSC 1.1 which will get into DSC 1.2.
> 
> Hence the table entries are same between DSC 1.1 SCR and DSC 1.2
> 
> You are right, ideally DSC 1.2 should be backwards compatible with DSC 
> 1.1 in terms of the values (thats what the spec says too) but I am not 
> sure if we can expect every panel/DP monitor to be forward compatible 
> without any SW change because it might need some firmware update (for 
> the panel) or SW update to support that especially during transitions of 
> the spec revisions (SCR to be precise).
> 
> Typically we do below for DP monitors exactly for the same reason:
> 
> DSC_ver_to_use = min(what_we_support, what_DP_monitor_supports) and use 
> that table.
> 
> For DSI panels, typically in the panel spec it should say whether the 
> SCR version needs to be used because we have seen that for some panels ( 
> I dont remember exactly which one ) based on which panel and which 
> revision of the panel, it might not.

So, what happens if we use DSC 1.1 SCR (= DSC 1.2) values with older 
panel? Does it result in the broken image?

I'm asking here, because I think that these parameters tune the 
_encoder_. The decoder should be able to handle different compressed 
streams as long as values fit into the required 'profile'.

> 
> Thats why downstream started adding qcom,mdss-dsc-scr-version to the 
> devicetree.
> 
>>>>> +    {0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 9, 12},
>>>>> +    {0, 4, 5, 5, 7, 7, 7, 7, 7, 7, 9, 9, 9, 13, 16},
>>>>> +    {0, 4, 5, 6, 7, 7, 7, 7, 7, 7, 9, 9, 9, 11, 15},
>>
>>

-- 
With best wishes
Dmitry

