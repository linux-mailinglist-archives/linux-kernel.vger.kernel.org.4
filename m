Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98EF616B17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiKBRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKBRmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:42:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90968140EC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:42:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a15so26003734ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rM4/zDWnrP1JlS87NcnSps8mvH/BPBoF3XFA7KWQYag=;
        b=R0QJvoUyTBqDa7/tsVAbtZlt7gwPXAyzRc27HvtU4qZ/4OazlMjIXVp8009FH3TfxD
         UNtlE6ZCgxXFOds9UEktIunzf+GbIi+Q5p0Ot15OHhQUFB6u1h9cgIBcag6xDNlE7BZx
         KIJxmxngUPQbK+bh0CoJEX/HsMhzf2G21GNkyF7qlyf/VgjEOWkQ8JLsCxtt67JAonbs
         vXWZjV1FSlFwnbC99yjE428q8BAWupfrdQwnXmpU2Lp7KZQe48dpPasy6cVWWJ3vNGH0
         bibstKcVk7qifej8+aL2a5U97HLkZtBi4SQ5ulNOunJhsHJollAOT1Uu//Ru2CAdY5Rz
         PfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rM4/zDWnrP1JlS87NcnSps8mvH/BPBoF3XFA7KWQYag=;
        b=d4mm6/XokvVv/gp0pfDTx3XvEYMGL8o5x3WIB5WUSJqvv8cg4nZ48pytciCwIK4T31
         I8187prZqTXFIBpIhXaHIpLjloZaZGspBvDAmfDyx7Hr7+FqXXE/0uFD+sh6dnTGMVfp
         gv449gT8PdcRZHAATv2/lS87ecOY9a5gYmGk9za+KNdBSbWdWwImS4oTS7WmZ3jr6JHJ
         6yqSQLEJ+qn2BHPrVKdPcsW/BoJbvnTQnRdzJz2EWIKZHQdDq7ppKQrU+/C+1eCFTOA1
         XrzcYrMxbEDPosz97dGNbUAzrRXEW6dJp8kaTJ5M/qITT5i47htd9C4OoBmz2bf+Qsmr
         xHgQ==
X-Gm-Message-State: ACrzQf3uOpVD1wch6E0/kIk2IzTCu/tCItP1Yj/Lff82hkZW8rbwkrQ9
        JHposxKEphxtVvHC9tdZMEojdQ==
X-Google-Smtp-Source: AMsMyM6fPaTDx5FqLlQ7a03XS8Xkfw+eo+mLL6RI5R56mLh1lGsiI8/EUTz8YTin2qmDGHqqiGUKoQ==
X-Received: by 2002:a05:651c:1786:b0:26d:aaec:1487 with SMTP id bn6-20020a05651c178600b0026daaec1487mr9860074ljb.287.1667410968808;
        Wed, 02 Nov 2022 10:42:48 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h12-20020a2ea48c000000b00277041268absm2251848lji.78.2022.11.02.10.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:42:48 -0700 (PDT)
Message-ID: <c97bbdc2-6487-32a2-bf16-a08803fa20b3@linaro.org>
Date:   Wed, 2 Nov 2022 20:42:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
 <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org>
 <deb60200-5a37-ec77-9515-0c0c89022174@quicinc.com>
 <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
 <155e4171-187c-4ecf-5a9b-12f0c2207524@linaro.org>
 <CAD=FV=Wk5rBSq9Mx1GCO0QFYckKV9KUFKL36Ld7dQX1ypHVcYw@mail.gmail.com>
 <da9720c2-ddc7-1a00-2608-0ef64c072cdd@linaro.org>
 <CAD=FV=V+ZgKaKbg5iX0i15ZfDO3MfBuHF8BGT3r8ZPmhTiNWDw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=V+ZgKaKbg5iX0i15ZfDO3MfBuHF8BGT3r8ZPmhTiNWDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 20:25, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 2, 2022 at 10:15 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 01/11/2022 17:37, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Oct 31, 2022 at 5:15 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On 01/11/2022 03:08, Doug Anderson wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Oct 31, 2022 at 2:11 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>>
>>>>>> Link rate is advertised by sink, but adjusted (reduced the link rate)
>>>>>> by host during link training.
>>>>>>
>>>>>> Therefore should be fine if host did not support HBR3 rate.
>>>>>>
>>>>>> It will reduce to lower link rate during link training procedures.
>>>>>>
>>>>>> kuogee
>>>>>>
>>>>>> On 10/31/2022 11:46 AM, Dmitry Baryshkov wrote:
>>>>>>> On 31/10/2022 20:27, Kuogee Hsieh wrote:
>>>>>>>> An HBR3-capable device shall also support TPS4. Since TPS4 feature
>>>>>>>> had been implemented already, it is not necessary to limit link
>>>>>>>> rate at HBR2 (5.4G). This patch remove this limitation to support
>>>>>>>> HBR3 (8.1G) link rate.
>>>>>>>
>>>>>>> The DP driver supports several platforms including sdm845 and can
>>>>>>> support, if I'm not mistaken, platforms up to msm8998/sdm630/660.
>>>>>>> Could you please confirm that all these SoCs have support for HBR3?
>>>>>>>
>>>>>>> With that fact being confirmed:
>>>>>>>
>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/msm/dp/dp_panel.c | 4 ----
>>>>>>>>      1 file changed, 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>>> b/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>>> index 5149ceb..3344f5a 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>>> @@ -78,10 +78,6 @@ static int dp_panel_read_dpcd(struct dp_panel
>>>>>>>> *dp_panel)
>>>>>>>>          if (link_info->num_lanes > dp_panel->max_dp_lanes)
>>>>>>>>              link_info->num_lanes = dp_panel->max_dp_lanes;
>>>>>>>>      -    /* Limit support upto HBR2 until HBR3 support is added */
>>>>>>>> -    if (link_info->rate >=
>>>>>>>> (drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)))
>>>>>>>> -        link_info->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
>>>>>>>> -
>>>>>>>>          drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
>>>>>>>>          drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
>>>>>>>>          drm_dbg_dp(panel->drm_dev, "lane_count=%d\n",
>>>>>>>> link_info->num_lanes);
>>>>>
>>>>> Stephen might remember better, but I could have sworn that the problem
>>>>> was that there might be something in the middle that couldn't support
>>>>> the higher link rate. In other words, I think we have:
>>>>>
>>>>> SoC <--> TypeC Port Controller <--> Display
>>>>>
>>>>> The SoC might support HBR3 and the display might support HBR3, but the
>>>>> TCPC (Type C Port Controller) might not. I think that the TCPC is a
>>>>> silent/passive component so it can't really let anyone know about its
>>>>> limitations.
>>>>>
>>>>> In theory I guess you could rely on link training to just happen to
>>>>> fail if you drive the link too fast for the TCPC to handle. Does this
>>>>> actually work reliably?
>>>>>
>>>>> I think the other option that was discussed in the past was to add
>>>>> something in the device tree for this. Either you could somehow model
>>>>> the TCPC in DRM and thus know that a given model of TCPC limits the
>>>>> link rate or you could hack in a property in the DP controller to
>>>>> limit it.
>>>>
>>>> Latest pmic_glink proposal from Bjorn include adding the drm_bridge for
>>>> the TCPC. Such bridge can in theory limit supported modes and rates.
>>>
>>> Excellent! Even so, I think this isn't totally a solved problem,
>>> right? Even though a bridge seems like a good place for this, last I
>>> remember checking the bridge API wasn't expressive enough to solve
>>> this problem. A bridge could limit pixel clocks just fine, but here we
>>> need to take into account other considerations to know if a given
>>> pixel clock can work at 5.4 GHz or not. For instance, if we're at 4
>>> lanes we could maybe make a given pixel clock at 5.4 GHz but not if we
>>> only have 2 lanes. I don't think that the DP controller passes the
>>> number of lanes to other parts of the bridge chain, though maybe
>>> there's some trick for it?
>>
>> I hope that somebody would fix MSM DP's data-lanes property usage to
>> follow the usual way (a part of DT graph). Then it would be possible to
>> query the amount of the lanes from the bridge.
> 
> Sorry, can you explain how exactly this works?

This was related to your point regarding communicating number of data 
lanes. Currently DP nodes have data-lanes in the device node itself. 
This contradicts with the typical definition and usage of the property - 
to be used in the graph endpoint. Then the 
drm_of_get_data_lanes_count() and drm_of_get_data_lanes_count_ep() 
functions can be used to query data-lanes value.

> I suspect that _somehow_ we need to get info from the TCPC to the DP
> controller driver about the maximum link rate. I think anything where
> the TCPC uses mode_valid() to reject modes and tries to make decisions
> based on "pixel clock" is going to be bad. If nothing else, I think
> that during link training that DP controller can try many different
> things to see what works. It may try varying the number of lanes, the
> BPC, the link rate, etc. I don't think mode_valid() is called each
> time through here.

In the worst case this can become the new max-data-rate propery. Or the 
existing link-frequencies property. But this needs to defined in the 
board file (or in the TCPC driver if that's the hardware limitation).

Granted the existing dp_panel code I think that the fix can be to check 
for the link-frequencies property and to limit the link_info->rate based 
on the value.


>>> ...I guess the other problem is that all existing users aren't
>>> currently modeling their TCPC in this way. What happens to them?
>>
>> There are no existing users. Bryan implemented TCPM support at some
>> point, but we never pushed this upstream.
> 
> I mean existing DP users, like sc7180-trogdor devices. If the TCPC
> isn't modeled, then these need to continue defaulting to HBR2 since at
> least some of the boards have HBR2-only TCPCs.

Ack. I think somebody has to describe the DP links properly on those 
platforms. E.g. by adding the usb-connector nodes, etc (I assume that 
existing sc7180/7280 platforms use USB-C connectors mixed with USB 
rather than normal DP/uDP connectors). Let's see how Bjorn's proposal goes.


-- 
With best wishes
Dmitry

