Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826BA6EB994
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDVOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDVOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:11:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721361713
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:11:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8bb726210so25638421fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682172704; x=1684764704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVzMoHDCPKdA8c+qm7t09KRZISQuD28wZ46s+1flyuo=;
        b=CZs0+M5/CXjdTdCgtYjuWQkvrWI6pcKdBW99oJ00YXSMO4IDNxf7O9wNllvtHL7J36
         D7H6NphUZ5Ewsx0Q8JYTgrHc+8bSTveplsjfyfT1fw5c7QzKxcCpbyWra5LgqVTVB1BN
         zUM/JrWk9irRdxtNlwhVSz5NLwTLoIKbQsuA1FlAXkDzrXiqUx2Fy08Gy2c/lfnzxTOJ
         SIwgxh7Wk3bkj7bRXIpCEQWdIFsWrhaGcobpsbVScQfFCLCPCGgNU7Kg05Jm10Dh4rBu
         lqCqxkhQ/tQFWbVYDBAR6UvEIXUMAi6NR977lwYpax92OpST59qSbAS3CeZgdkRFrogx
         u/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682172704; x=1684764704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVzMoHDCPKdA8c+qm7t09KRZISQuD28wZ46s+1flyuo=;
        b=Lqx1DnanxvGCt60aVjCn8KUiVj8TUmlGjI66WVFh5gfAZqutJ64/4fo76IX8nT/E6W
         Stxg7lESL+gDl250Kf5z/PWZVQh80SNQvu33i0B5UwOYDQY3iXoUS4RZ6sdqKvcS9NCL
         bdomAV1VFocdeqsJJ3b7vpZr7bP0EneZnF7vf6dP3rmCdRi9sc4Kuo1oPcVUQm+zccQJ
         YzEillbOiJnCOpHOJ8FTN07WwYhc8nuL1HWX3q9x/naIaq+Yx8oIV0qH100eeVL9Mklj
         Dbv5PXSrBBO4GtebKQRnJT7MRYD/RvW8QqhxJAfOWN/RUhl49k4dAJZfoQIgX7l5psE7
         JOPw==
X-Gm-Message-State: AAQBX9dld3ZWL2VrSJYVqeBB9z8KaaiH1QqAL6CDLIAuzm3dLaPJC06z
        fUSVU18E/nrTpqvMSwqyCcauow==
X-Google-Smtp-Source: AKy350az0MqvV35uwDiuH4FjkN0a0QdKHDiRn8GNEfDHf3tQovewXr7SwP8aUZwt+F4RQtaVw0dfgA==
X-Received: by 2002:a2e:9b93:0:b0:2a8:a8f1:f6b5 with SMTP id z19-20020a2e9b93000000b002a8a8f1f6b5mr1369288lji.14.1682172703665;
        Sat, 22 Apr 2023 07:11:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id k19-20020a2e2413000000b002a8c4a26960sm984106ljk.75.2023.04.22.07.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 07:11:43 -0700 (PDT)
Message-ID: <01f04f1f-12a9-8137-bf89-5bf6c1bbca77@linaro.org>
Date:   Sat, 22 Apr 2023 17:11:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
 <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
 <3f3b3637-ed85-09a1-22b7-3ccd4bc929bb@quicinc.com>
 <2dff9d62-cffe-c66f-9e50-3ecd64e44d37@linaro.org>
 <6a335df7-ff0b-098a-feec-45714159df04@linaro.org>
 <b134d09c-55fa-7879-80ff-900e39c20c3d@quicinc.com>
 <0f469b3c-5f0f-e027-8a9f-d1233169c04a@linaro.org>
 <57pxyxwluu33z4lpij5gx7biwfo5pbhdalhhxflw7esi5n3vts@qhjb7ldnz3wb>
 <0bba90c1-01be-a76e-df12-2328b84f7298@linaro.org>
 <b6d56e50-fb5b-1d59-7b39-a3ca2a0a8d83@quicinc.com>
 <1f7bb81a-d38c-725a-9ee1-89efe2950b1d@linaro.org>
 <cbafc6fd-58db-91f5-b453-4b45ba80ee4d@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <cbafc6fd-58db-91f5-b453-4b45ba80ee4d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 15:08, Konrad Dybcio wrote:
> 
> 
> On 22.04.2023 00:35, Dmitry Baryshkov wrote:
>> On 22/04/2023 01:34, Abhinav Kumar wrote:
>>>
>>>
>>> On 4/20/2023 3:52 PM, Dmitry Baryshkov wrote:
>>>> On 20/04/2023 22:56, Marijn Suijten wrote:
>>>>> On 2023-04-20 22:51:22, Dmitry Baryshkov wrote:
>>>>>> On 20/04/2023 22:47, Abhinav Kumar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/20/2023 11:01 AM, Dmitry Baryshkov wrote:
>>>>>>>> On 20/04/2023 04:36, Konrad Dybcio wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 20.04.2023 03:28, Abhinav Kumar wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 4/19/2023 6:26 PM, Konrad Dybcio wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 20.04.2023 03:25, Dmitry Baryshkov wrote:
>>>>>>>>>>>> On 20/04/2023 04:14, Konrad Dybcio wrote:
>>>>>>>>>>>>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
>>>>>>>>>>>>> dspp sub-block in addition to PCCv4. The other block differ a bit
>>>>>>>>>>>>> more, but none of them are supported upstream.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This series adds configures the GCv1.8 on all the relevant SoCs.
>>>>>>>>>>>>
>>>>>>>>>>>> Does this mean that we will see gamma_lut support soon?
>>>>>>>>>>> No promises, my plate is not even full, it's beyond overflowing! :P
>>>>>>>>>>>
>>>>>>>>>>> Konrad
>>>>>>>>>>
>>>>>>>>>> So I think I wrote about this before during the catalog rework/fixes
>>>>>>>>>> that the gc registers are not written to / programmed.
>>>>>>>>>>
>>>>>>>>>> If thats not done, is there any benefit to this series?
>>>>>>>>> Completeness and preparation for the code itself, if nothing else?
>>>>>>>>
>>>>>>>> The usual problem is that if something is not put to use, it quickly
>>>>>>>> rots or becomes misused for newer platforms. We have seen this with
>>>>>>>> the some of DPU features.
>>>>>>>>
>>>>>>>> In case of GC (and the freshly defined DPU_DSPP_IGC, but not used) we
>>>>>>>> have three options:
>>>>>>>> - drop the unused GC from msm8998_sblk.
>>>>>>>> - keep things as is, single unused GC entry
>>>>>>>> - fill all the sblk with the correct information in hope that it stays
>>>>>>>> correct
>>>>>>>>
>>>>>>>> Each of these options has its own drawbacks. I have slight bias
>>>>>>>> towards the last option, to have the information in place (as long as
>>>>>>>> it is accurate).
>>>>>>>>
>>>>>>>
>>>>>>> My vote is for (1) . Today, GC is unused and from the discussion here,
>>>>>>> there is no concrete plan to add it. If we keep extending an unused
>>>>>>> bitmask for all the chipsets including the ones which will get added in
>>>>>>> the future in the hope that someday the feature comes, it doesnt sound
>>>>>>> like a good idea.
>>>>>>>
>>>>>>> I would rather do (1), if someone has time.
>>>>>>
>>>>>> Agree, this was the second item on my preference list. Could you please
>>>>>> send this oneliner?
>>>>>
>>>>> Nit (to make sure we're on the same thought here): I think it's a
>>>>> 3-liner: remove it from DSPP_MSM8998_MASK as well as msm8998_dspp_sblk.
>>>>>
>>>>>>> OR lets stay at (2) till
>>>>>>> someone does (1).
>>>>>
>>>>> I'm personally okay leaving it in place too, with an eye on implementing
>>>>> this, IGC, and other blocks at some point if there's a use for it via
>>>>> standard DRM properties.
>>>>
>>>> I took a quick glance. I think it is possible, but not straightforward. But I must admit here, I don't have a full picture regarding different color encodings, ranges and the rest of gamma/degamma API and usage.
>>>>
>>>
>>> I think its easier to remove this now and then add it when we add the support. As discussed, will post this shortly.
>>>
>>> Otherwise, whenever any new chipset gets added, we will run into the same question of whether to add GC or not.
>>
>> Yes, I absolutely agree here.
> Sorry for the useless patches, though I guess they were a good
> discussion starter..

If they started the discussion, they were not useless.

> 
> Konrad
>>
>>>
>>>>>
>>>>>>> When someone implements GC, we can re-use this patch and that time keep
>>>>>>> konrad's author rights or co-developed by.
>>>>>
>>>>> Good to at least know all these SoCs have the same offset and revision.
>>>>>
>>>>> - Marijn
>>>>
>>

-- 
With best wishes
Dmitry

