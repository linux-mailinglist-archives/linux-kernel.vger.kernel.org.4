Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3716FC1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjEIIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEIIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:23:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916397ED2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:23:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso1820035e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683620588; x=1686212588;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j9JYCKCf1vXfiWnciejpaoAckqnOG85wqGdoyhe4Y6g=;
        b=a/kSkitMC1bsP3pwDE+s05+7P5ZumP5gM3wQUb1kFeg1m6KY2HyeIn2ADTpXMf6SnQ
         4vDa3njYrxESupeKPSN8v5QOWoTFu2oo2N1IJ0sELwcpo3N3NojCfjPH8oALMonKTep5
         w7qRq5CJFmZK93k453qDCQ3h+QKcKqLp0QGJMDqhxVsCjuZ+Pr9dNRl6/gpSM8HPUMVw
         ivdA+hgL0B+FI/xXOemTY3Lp8Fd4rI7vYacRnDJnGwtElycBwYRQxhp1/mhxZs7CD0Xq
         HllSICr0ukwg/e9A9K3JxVpz7buDVIvq0s+l4YgtHJmAYfoGcY03KJBWJUy70I9jkG7C
         oLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620588; x=1686212588;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9JYCKCf1vXfiWnciejpaoAckqnOG85wqGdoyhe4Y6g=;
        b=brR52qLj8/0TYiKN5T9fGeioSPnS5ji4822CW6VlBlPT8qQdYGHxacgp3JAEFptcfo
         1P6DKEUgqG0e6e0hpacgW5VZ4mbLZyO4oobtHc5dq0zzqAmQOUfX2pntdL5L0o6EHM+g
         NkazXSr8VeEFWdDZoa2Fm/tS0Xrx5DbXMw2UezzXQM9rV2CUT7GmCN1ESB/oNlFA3eHC
         og5XJOK2mRmauFPDaG0Tc+B+jFTURJ9jZOi0K0TqNtS9j2R0lJLTDibsfSmN+d0SWptm
         Ih7oitGLeUxI3xqC0rgAxzBvwHYW7e4y2DJpOgyY1gTtq/zR3i/J18CVqABfVQjrd5dO
         2/4w==
X-Gm-Message-State: AC+VfDwNMb6AzDfCXfYcO5oHki78NOfzRRhkkxhHJ2UDh5cpYb8FPoQr
        LB38V/aFm6Glq6CEUKES9a4T7g==
X-Google-Smtp-Source: ACHHUZ54f2i9McLhYrAjMcUVxDpqqTAmjHfyYouggBiIHlZFhtc+t/XPoQYc8FODcWIsZ0xzURMJ8g==
X-Received: by 2002:a1c:f615:0:b0:3f1:952c:3c70 with SMTP id w21-20020a1cf615000000b003f1952c3c70mr8125203wmc.40.1683620587575;
        Tue, 09 May 2023 01:23:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79ab:8da0:d16d:9990? ([2a01:e0a:982:cbb0:79ab:8da0:d16d:9990])
        by smtp.gmail.com with ESMTPSA id r9-20020a5d4e49000000b003047ea78b42sm13401361wrt.43.2023.05.09.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:23:07 -0700 (PDT)
Message-ID: <44c47800-0913-b122-77ae-5ce0e5d4b443@linaro.org>
Date:   Tue, 9 May 2023 10:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] drm/msm/dsi: Fix compressed word count calculation
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-2-6bc6f03ae735@quicinc.com>
 <a60a9f37-bb43-6e2b-2535-995e9fae250a@linaro.org>
 <32d473a6-f7a5-9aa6-85cf-0f77f1c071ce@quicinc.com>
 <4cf2e9ab-7e08-fb26-d924-8ea8141d9f58@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4cf2e9ab-7e08-fb26-d924-8ea8141d9f58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 01:27, Dmitry Baryshkov wrote:
> On 08/05/2023 23:09, Abhinav Kumar wrote:
>>
>>
>> On 5/3/2023 1:26 AM, Dmitry Baryshkov wrote:
>>> On 03/05/2023 04:19, Jessica Zhang wrote:
>>>> Currently, word count is calculated using slice_count. This is incorrect
>>>> as downstream uses slice per packet, which is different from
>>>> slice_count.
>>>>
>>>> Slice count represents the number of soft slices per interface, and its
>>>> value will not always match that of slice per packet. For example, it is
>>>> possible to have cases where there are multiple soft slices per interface
>>>> but the panel specifies only one slice per packet.
>>>>
>>>> Thus, use the default value of one slice per packet and remove slice_count
>>>> from the word count calculation.
>>>>
>>>> Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>> index 35c69dbe5f6f..b0d448ffb078 100644
>>>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>>> @@ -996,7 +996,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>>>           if (!msm_host->dsc)
>>>>               wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
>>>>           else
>>>> -            wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
>>>> +            /*
>>>> +             * When DSC is enabled, WC = slice_chunk_size * slice_per_packet + 1.
>>>> +             * Currently, the driver only supports default value of slice_per_packet = 1
>>>> +             *
>>>> +             * TODO: Expand drm_panel struct to hold slice_per_packet info
>>>> +             *       and adjust DSC math to account for slice_per_packet.
>>>
>>> slice_per_packet is not a part of the standard DSC, so I'm not sure how that can be implemented. And definitely we should not care about the drm_panel here. It should be either a part of drm_dsc_config, or mipi_dsi_device.
>>>
>>
>> This is not correct.
>>
>> It is part of the DSI standard (not DSC standard). Please refer to Figure 40 "One Line Containing One Packet with Data from One or More Compressed Slices" and Figure 41 "One Line Containing More than One Compressed Pixel Stream Packet".
> 
> I have reviewed section 8.8.24 and Annex D of the DSI standard.
> 
> It is not clear to me, if we can get away with always using slice_per_packet = 1. What is the DSI sink's difference between Fig. 40.(b) and Fig 41?
> 
> Are there are known panels that require slice_per_packet != 1? If so, we will have to implement support for such configurations.
> 
>> This has details about this. So I still stand by my point that this should be in the drm_panel.
> 
> Note, the driver doesn't use drm_panel directly. So slices_per_packet should go to mipi_dsi_device instead (which in turn can be filled from e.g. drm_panel or from any other source).

This is a big question, where should we set those parameters ?

It's an even bigger questions for panels optionally supporting DSC in Video or Command mode (like the vtdr6130),
how to select DSC or not ? DT is not an option.

Those should tied to a panel+controller tuple.

Neil

> 
>>
>>>> +             */
>>>> +            wc = msm_host->dsc->slice_chunk_size + 1;
>>>>           dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>>>>               DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
>>>>
>>>
> 

