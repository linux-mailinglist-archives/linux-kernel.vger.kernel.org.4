Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03C6F267F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjD2VMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:12:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B61BC9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:11:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4edc114c716so1534311e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682802718; x=1685394718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U7MzaS7aw+EsZYAqTDDyCfg+saVyoYnFZA66Bc8C/w=;
        b=iif0QCwcvBkDoY0VuWQG8nKl+rCPM+ua54p31wcSq5AY4+Obr0QuyctrhJbup9Xg9Z
         f4AbHWcIC7a4Vx0QkaDseKcUnY5d4nGJZjr3WyYLOaDcWfDIl/LjRnOj8zqd45+KDp5h
         BbU4Jlu+2bdioORvhtx9LDWmJcfGhg9b1U2TD7PYVd5Y9GnZ09p+dLn3QspMr2IXBJLK
         dUlvfyo2kNeCIpjb4wMSjZITlywxa7OM2vSBSUbB+SUFZHnpjxUlSOG7lJEQtx1IBQiN
         GfUT/kX4bfDB/wrbss6DPvdoTXVH9h7g91PY3+ctLasUjmq+6sciZsOEIlAu6gRyjMsb
         qIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682802718; x=1685394718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U7MzaS7aw+EsZYAqTDDyCfg+saVyoYnFZA66Bc8C/w=;
        b=aHh6PL7bbKB/p7IpPz5mqSyINfCNzCZzbSVyAveAwIcyjx1ibtc+WcgPVA+9kwVJkn
         5eKjqz6eDQKYmRlVspranZAyhi1WQ8OlOEEObhkHdjpxute+tVg4xSwFfvt1u0lRrX+J
         OA3DvQB45lpAK5we2vXm9iRV0H712jjhFvGWGmtb0BKkOweDb9XWplF7HcNCWm1D2KBs
         AQbJW0QoAA9c/jaf26v40MxLjQkre5gBWR8FYyW5QkfFmKCooxGMsC/4g4+bHHaIkwRh
         HkwqphrbEUe3hM2P/y1EmHn0Ho/R7HZ4YDpHbPQJXAPmQRSq17HU0MZTSYouHfGOaTK9
         xYsQ==
X-Gm-Message-State: AC+VfDyXChRljSQUCcZptkc1Hv3elX3w1OAmMEaeSkdohCAMBFpSUgrd
        BBD5Nn03IihP58V3mqGf9vFHBQ==
X-Google-Smtp-Source: ACHHUZ7ooWjyMH7Ci+c7zCG0qzziHIjMb5gsW4/l2PjA4+3lYRlsr0+9PPPEp09qZkn3DjuwV76UhA==
X-Received: by 2002:a19:f508:0:b0:4ed:befc:9b4e with SMTP id j8-20020a19f508000000b004edbefc9b4emr2365105lfb.3.1682802717914;
        Sat, 29 Apr 2023 14:11:57 -0700 (PDT)
Received: from [192.168.1.212] (78-27-120-86.bb.dnainternet.fi. [78.27.120.86])
        by smtp.gmail.com with ESMTPSA id u24-20020ac25198000000b004eca2b1c5b4sm3910548lfi.229.2023.04.29.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 14:11:57 -0700 (PDT)
Message-ID: <1bf7b399-bbf3-c6d5-6d13-dc50ec670137@linaro.org>
Date:   Sun, 30 Apr 2023 00:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Freedreno] [PATCH v2 5/7] drm/msm/dpu: add DPU_PINGPONG_DSC
 feature PP_BLK and PP_BLK_TE
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     vkoul@kernel.org, quic_sbillaka@quicinc.com, airlied@gmail.com,
        andersson@kernel.org, freedreno@lists.freedesktop.org,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, robdclark@gmail.com, agross@kernel.org,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        marijn.suijten@somainline.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, sean@poorly.run,
        linux-kernel@vger.kernel.org
References: <1682725511-18185-1-git-send-email-quic_khsieh@quicinc.com>
 <1682725511-18185-6-git-send-email-quic_khsieh@quicinc.com>
 <ad672cff-3355-97af-24b4-3626efebc284@linaro.org>
 <e9f493fa-77f2-0a5b-5e09-bd1baae8a8d0@quicinc.com>
 <772a63ca-9b88-3c98-e769-7e614968c127@linaro.org>
 <09d34749-d571-ed04-9681-4abf48c7f053@quicinc.com>
 <CAA8EJpo-+UYv2Roctu=7U09V3u6kJ_q64M1i_R7DBGCGCK=U7A@mail.gmail.com>
 <7e40f51b-693e-d42f-b99e-695cb6478e2d@quicinc.com>
 <d42e39ed-4bbf-f197-1f31-04576dd639fd@linaro.org>
 <0a8e99cb-8635-aaa1-aaf4-842c86ffd6ff@quicinc.com>
 <CAA8EJpqsxrv18xH=GREm75EXD62bDS7d0diMtbNOHuEX-4hD6A@mail.gmail.com>
 <1ff73e92-92a4-f686-a478-04f2727751ce@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1ff73e92-92a4-f686-a478-04f2727751ce@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 23:23, Abhinav Kumar wrote:
> 
> 
> On 4/29/2023 12:45 PM, Dmitry Baryshkov wrote:
>> On Sat, 29 Apr 2023 at 11:43, Abhinav Kumar 
>> <quic_abhinavk@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 4/28/2023 9:35 PM, Dmitry Baryshkov wrote:
>>>> On 29/04/2023 07:04, Abhinav Kumar wrote:
>>>>>
>>>>>
>>>>> On 4/28/2023 8:21 PM, Dmitry Baryshkov wrote:
>>>>>> On Sat, 29 Apr 2023 at 05:50, Abhinav Kumar
>>>>>> <quic_abhinavk@quicinc.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 4/28/2023 6:41 PM, Dmitry Baryshkov wrote:
>>>>>>>> On 29/04/2023 04:08, Abhinav Kumar wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/28/2023 5:45 PM, Dmitry Baryshkov wrote:
>>>>>>>>>> On 29/04/2023 02:45, Kuogee Hsieh wrote:
>>>>>>>>>>> Legacy DPU requires PP hardware block involved into setting 
>>>>>>>>>>> up DSC
>>>>>>>>>>
>>>>>>>>>> Nit: to be envolved
>>>>>>>>>>
>>>>>>>>>>> data path. This patch add DDPU_PINGPONG_DSC feature bit to both
>>>>>>>>>>
>>>>>>>>>> adds
>>>>>>>>>>
>>>>>>>>>>> PP_BLK and PP_BLK_TE so that both dpu_hw_pp_setup_dsc() and
>>>>>>>>>>> dpu_hw_pp_dsc_enable() will be executed during DSC path setup.
>>>>>>>>>>
>>>>>>>>>> Would it be easier to add PP_BLK_NO_DSC instead and make DSC 
>>>>>>>>>> enabled
>>>>>>>>>> by default for PP_BLK / PP_BLK_TE?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> No because for some chipsets like qcm2290, it has a ping pong 
>>>>>>>>> block
>>>>>>>>> but no DSC.
>>>>>>>>
>>>>>>>> And so it will use PP_BLK_NO_DSC (like msm8998 for PP_2/_3). But 
>>>>>>>> this
>>>>>>>
>>>>>>> Ok so you meant adding another PP_BLK_* macro. I mistook it for a
>>>>>>> feature flag.
>>>>>>>
>>>>>>> This is getting a bit confusing with many PP_BLK_* variations.
>>>>>>
>>>>>> Yes. As I wrote it might be not the optimal solution.
>>>>>>
>>>>>>>
>>>>>>>> might be not the optimal solution. Let's check all possible cases:
>>>>>>>>
>>>>>>>> - PP (or PP_TE?) with no DSC support,
>>>>>>>
>>>>>>> Yes correct for chipsets like qcm2290.
>>>>>>>
>>>>>>>> - PP/PP_TE tightly bound to the particular DSC instance, should be
>>>>>>>> allocated together,
>>>>>>>
>>>>>>> I need to check which exact chipset does this (I recall one does) 
>>>>>>> but
>>>>>>> perhaps msm8998 fits here.
>>>>>>
>>>>>> All targets earlier than sm8150. SDE driver sets SDE_DSC_OUTPUT_CTRL
>>>>>> if for v1 CTL blocks (sm8150+).
>>>>>>
>>>>>>>
>>>>>>>> - PP/PP_TE which can use any DSC block.
>>>>>>>
>>>>>>> This is what DPU_PINGPONG_DSC feature flag should mean today and 
>>>>>>> should
>>>>>>> cover most of the DSC 1.1 chipsets present in upstream today.
>>>>>>
>>>>>> Then it should probably be renamed to DPU_PINGPONG_ANY_DSC
>>>>>>
>>>>>
>>>>> Actually that "any" is incorrect. As part of the DSC pairing logic
>>>>> change it will become clear but not all ping-pongs can pair with all
>>>>> DSCs. So any is not right.
>>>>>
>>>>> This is why I think we should go with this feature flag first. Lets
>>>>> identify a pattern and then work on unifying or cleaning up the
>>>>> PP_BLK_* masks.
>>>>
>>>> Then I'd like to see the series sent together so that we don't have to
>>>> be wondering in the myst. At least the RM changes might better go into
>>>> this series (together with the topology changes. I think RM will depend
>>>> on 1 DSC topology support).
>>>
>>> Topology changes depend on which way the virtual planes series is going
>>> to do and since we are going with fixed topology you preferred it to be
>>> dropped right?
>>
>> It was not about the topology changes (e.g. supporting 1:1:1), but
>> about storying the topology in the encoder.
>>
> 
> So you are suggesting drop patch 6 of this series and keep 7 OR drop 6 
> and 7 both?
> 
> It looks like if 6 is dropped, then 7 has to be as well because we need 
> to store topology somewhere cannot keep passing locally.

Yes, 6/7 should be split from this series. For #7 we have all the 
information necessary (num_dsc and num_intf), so it is not strictly 
dependent on #6, but is anyway a separate change, not related to DSC 1.2.

Are there any actual changes in #7 for 2:1:1 case? If not, it should go 
together with 1:1:1 topology support.

> 
> Thats why I was okay to drop 6 and 7 together.
> 
>>>
>>> Now that you have seen the DSC to PP mapping code downstream you know
>>> that every DSC cannot goto every ping-pong. So which way do you want to
>>> go with this patch. If we are going to post a next revision, need some
>>> conclusion here and I do not think PP_BLK_* was agreed as a clean
>>> solution anyway.
>>
>> No, it was not agreed. That's why I tried listing all possible cases
>> (in an attempt to understand the limitations and/or possible
>> usecases).
>>
>>>
>>> Thats why I suggested:
>>>
>>> 1) Lets go with feature flag
>>> 2) When DP lands, thats the one which uses 1-1-1 topology so we can hit
>>> some corner cases of lets say DP uses one DSC and then DSI uses merge we
>>> should go with the right DSC pair. With only DSI, this will not arise.
>>> 3) With (1) and (2) done, we can take up PP_BLK_* cleanup if we feel its
>>> necessary.
>>>
>>> I dont see any conclusion or plan suggested by you so far on which way
>>> you want to go.
>>
>> I'd propose the following plan:
> 
> Thanks for summarizing what you had in mind, that makes it clear.
> 
>> - Drop all the topology and PP changes from this series. Make it add
>> just DSC 1.2 support.
>>
>> Then for the DSI DSC 1.2 we should be able to continue using existing
>> RM/PP code with known limitations.
>>
> 
> 
> So just keep patches 1-3 right? The issue with that is 
> _setup_pingpong_ops will still get called even for DSC 1.2 with those 
> changes. This was actually noted by Marijn during the catalog cleanup we 
> recently merged to -fixes. Thats why we included that in this so that we 
> dont call DSC 1.1 related functions for 1.2

I thought about 1-4 initially. I didn't notice that this flag was not 
set for newer PP blocks.

Please split patch #5 into two: generic code + definition and catalog 
changes actually enabling this feature.

Also please note that 'PP block binding to DSC' isn't probably a good 
enough description of this feature bit. It doesn't control PP/DSC 
binding, it shows if DCE is controlled from PP block or not.

> 
> Any specific reason why you dont want to go with patches 1-5 now and 
> drop 6,7 as that depends on storing topology.
> 
>> Next:
>> - Split DPU_PINGPONG_DSC feature flag to a separate patch series. It
>> looks like it should have some Fixes tag, as it prevents one from
>> calling *dsc functions for PPs which do not support them
> 
> We can still add the fixes tag and keep it here and move it to the front?

Yes! Even w/o DSC 1.2 we should not be calling dsc functions for PP 
which have no DCE support.

>> - Extend the series with the RM fix which skips non-DSC-enabled PPs
>> when DSC is required.
>> - As this series is touching RM, it is a good place to handle DSC
>> allocation issues, which includes:
>>    * tight coupling of PP/DSC blocks on sdm845 and msm8998
>>    * limitations for 1:1:1 or co-allocation of DSC blocks for both DSI
>> and DP DSC (might be split to a separate patchset, up to you)
> 
> I am a bit confused about this. This patch is not touching RM at all 
> from what I can see. So the issue of DSC pair allocation is there even 
> today with or without DSC 1.2 about which DSCs pair with which ones and 
> which DSCs go with which PP.

I was also confused here, as you see. What I meant here was to add a new 
patch touching RM code to the new, separate series.

> I feel that once DSC 1.2, that is just patches 1-5 land, I agree this 
> can be and should be a series on its own to prepare for DP DSC.

Yes, please.

> What use-case gets broken for DSI if we land 1-5?

None. As I wrote, "Then for the DSI DSC 1.2 we should be able to 
continue using existing RM/PP code with known limitations."

> 
> We are trying to expand this series for a condition which wont hit till 
> DP DSC lands due to the fixed topology and only one client for DSC which 
> is DSI.

Please don't. Let it be just DSC 1.2 (e.g. as required for DSI DSC 1.2). 
The 1:1:1 and multi-client can be a separate series fixing RM/dpu_encoder.

> 
>>
>> DP DSC depends either on this series or on a separate patchset
>>
>>>
>>>>
>>>> I went on and checked the SDE. It has condition that pp % 2 == dsc % 2.
>>>> Does this condition apply only to "newest" DSC/PP combo (DITHER + 1.2)
>>>> or to the older ones too? Are there any other conditionals?
>>>>
>>>
>>> It was there even for older DSCs and looks like wasnt implemented in the
>>> current upstream code.
>>
>> Thanks for the info.


-- 
With best wishes
Dmitry

