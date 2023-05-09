Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC386FC53A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjEILmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjEILmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:42:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11A4209
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:42:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac785015d7so63810091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683632523; x=1686224523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pl1V+sF83nw4jwYsmPa2jKKW5gdsa5ODMEKYo1fFAM=;
        b=LQxNW0yHGaTmdH+eDy4hgR9cO7qNKTV4OXMOOT21I/r4dPd7cll2R5GHhECVI8Cnqv
         Kep71GiRBdga58oD2UxP/oTQhmHWlqzemABoLdVysD4DHXSnkQukzmxGb6f3FSqJXfkB
         rIeWeS6ogVfo168XH9A/q3ZE+DCBZmkNbQ++iKB05KwLVafAui8q0HYStT8G5ui3qMPf
         08On4KNSKQVQOGz26EXQvhiaQlq2/HaNNa3YnDSngLOfeHioQyh00o/jW9ohVjosYlsQ
         S0YoJCa7iizameoJR3FQtlUqPngVONeCxFjjEu2COFdE9rNuCEpoJyEBXXxu6dxmn1iY
         9s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632523; x=1686224523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pl1V+sF83nw4jwYsmPa2jKKW5gdsa5ODMEKYo1fFAM=;
        b=XxTxBPoGYsVMlcNjfnpVtUj1X30mEQHbfxratH4q530TOEEzAYXwkbwmtrbbvxCfsu
         p1/d0MPbNO023K+GIKEXuXEqYdNekhSVnrjyIOPc+9ZMaoegNABa06L+n+HseP5wpwjb
         +wwoML281DoafqTyT20s6uDTPa7907V72Hz5kSFsU/5e76tYBPwDNc2UmlVerTGqklX2
         NE161OZqhIEgeFWsSTCIFg5lZsyvttF/hgURZ1TqnKiHoffqh2CJd1r02b+4XrlCQzJS
         64h8Nd41gK34rtwpiQump5dbMRDnv/PE32kRjCNLIAD9EvLB9CNZejPl7UwbsUsGiT0+
         iyLA==
X-Gm-Message-State: AC+VfDx2WRiKILB7sA+5KU5ZXcJKUByDbZ7ZVXFWlzRsulPrkCKO5g5B
        cbCjo4mFYvqyT8aEXmd2M6j2oQ==
X-Google-Smtp-Source: ACHHUZ677yF0j6L9wDMCT+AqFIVJ8oMMpSOLMCU82Rxd1DFuJyXAtxGrYscgN90CzYZ8VSgI+lqctg==
X-Received: by 2002:ac2:5fa6:0:b0:4f2:520e:f865 with SMTP id s6-20020ac25fa6000000b004f2520ef865mr637666lfe.16.1683632522700;
        Tue, 09 May 2023 04:42:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004eb0c51780bsm322168lfm.29.2023.05.09.04.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 04:42:02 -0700 (PDT)
Message-ID: <5f069b2c-d1b1-e489-7494-67ef395437bc@linaro.org>
Date:   Tue, 9 May 2023 14:42:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] drm/msm/dsi: Fix compressed word count calculation
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        neil.armstrong@linaro.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-2-6bc6f03ae735@quicinc.com>
 <a60a9f37-bb43-6e2b-2535-995e9fae250a@linaro.org>
 <32d473a6-f7a5-9aa6-85cf-0f77f1c071ce@quicinc.com>
 <4cf2e9ab-7e08-fb26-d924-8ea8141d9f58@linaro.org>
 <44c47800-0913-b122-77ae-5ce0e5d4b443@linaro.org>
 <cd8cfbd5-1bde-08d8-dbb5-5489820d6a45@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cd8cfbd5-1bde-08d8-dbb5-5489820d6a45@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 11:54, Konrad Dybcio wrote:
> 
> 
> On 9.05.2023 10:23, Neil Armstrong wrote:
>> On 09/05/2023 01:27, Dmitry Baryshkov wrote:
>>> On 08/05/2023 23:09, Abhinav Kumar wrote:
>>>>
>>>>
>>>> On 5/3/2023 1:26 AM, Dmitry Baryshkov wrote:
>>>>> On 03/05/2023 04:19, Jessica Zhang wrote:
>>>>>> Currently, word count is calculated using slice_count. This is incorrect
>>>>>> as downstream uses slice per packet, which is different from
>>>>>> slice_count.
>>>>>>
>>>>>> Slice count represents the number of soft slices per interface, and its
>>>>>> value will not always match that of slice per packet. For example, it is
>>>>>> possible to have cases where there are multiple soft slices per interface
>>>>>> but the panel specifies only one slice per packet.
>>>>>>
>>>>>> Thus, use the default value of one slice per packet and remove slice_count
>>>>>> from the word count calculation.
>>>>>>
>>>>>> Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
>>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++++++++-
>>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>>>> index 35c69dbe5f6f..b0d448ffb078 100644
>>>>>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>>>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>>>> @@ -996,7 +996,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>>>>>            if (!msm_host->dsc)
>>>>>>                wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
>>>>>>            else
>>>>>> -            wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
>>>>>> +            /*
>>>>>> +             * When DSC is enabled, WC = slice_chunk_size * slice_per_packet + 1.
>>>>>> +             * Currently, the driver only supports default value of slice_per_packet = 1
>>>>>> +             *
>>>>>> +             * TODO: Expand drm_panel struct to hold slice_per_packet info
>>>>>> +             *       and adjust DSC math to account for slice_per_packet.
>>>>>
>>>>> slice_per_packet is not a part of the standard DSC, so I'm not sure how that can be implemented. And definitely we should not care about the drm_panel here. It should be either a part of drm_dsc_config, or mipi_dsi_device.
>>>>>
>>>>
>>>> This is not correct.
>>>>
>>>> It is part of the DSI standard (not DSC standard). Please refer to Figure 40 "One Line Containing One Packet with Data from One or More Compressed Slices" and Figure 41 "One Line Containing More than One Compressed Pixel Stream Packet".
>>>
>>> I have reviewed section 8.8.24 and Annex D of the DSI standard.
>>>
>>> It is not clear to me, if we can get away with always using slice_per_packet = 1. What is the DSI sink's difference between Fig. 40.(b) and Fig 41?
>>>
>>> Are there are known panels that require slice_per_packet != 1? If so, we will have to implement support for such configurations.
>>>
>>>> This has details about this. So I still stand by my point that this should be in the drm_panel.
>>>
>>> Note, the driver doesn't use drm_panel directly. So slices_per_packet should go to mipi_dsi_device instead (which in turn can be filled from e.g. drm_panel or from any other source).
>>
>> This is a big question, where should we set those parameters ?
>>
>> It's an even bigger questions for panels optionally supporting DSC in Video or Command mode (like the vtdr6130),
>> how to select DSC or not ? DT is not an option.
> Compressed vs uncompressed modes, maybe? Would be nice to make this
> togglable from userspace.. But then it may not scale for panels with e.g.
> 10 resolutions, all cmd/vid/dsc/nodsc

Currently the panel/panel-bridge make decision on command vs video mode. 
We have no way to influence that decision. If you want to make that 
negotiable, I'd start with adding 
'cmd_supported/video_supported/dsc_supported' flags to struct 
mipi_dsi_hosts.

> 
> 
> Konrad
>>
>> Those should tied to a panel+controller tuple.
>>
>> Neil
>>
>>>
>>>>
>>>>>> +             */
>>>>>> +            wc = msm_host->dsc->slice_chunk_size + 1;
>>>>>>            dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>>>>>>                DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
>>>>>>
>>>>>
>>>
>>

-- 
With best wishes
Dmitry

