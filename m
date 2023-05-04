Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF46F78ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEDWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:19:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5A9EE8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:19:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so1198186e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683238756; x=1685830756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pMBsKF7+1qDWEXm4/g+4pDlJgA+ge7d77ifZ1er6FE=;
        b=FlW1CsPqkW+bofsqNkG4s5QCNPp+hbyfoAcgyEIY3T1jL2ZsvjBxhtlFmsu9fGLtX9
         Ck1zgZeiO4EKJqtEHZeUqNMlTLr6wwW4HcKOLrlk6aAKLtSQzsBxYN7b2t0DWiEoMw+a
         oDOIhajdv10P6+IdI0izn751w2Xd8MKm0TWqI3cQvfnUp4qYFzawyerAlhbO4ehAFNLa
         yyJE5nRap3d6q/W7eJHhvPx7hlksci2DP4NadqgdBjJPLT4Y+UWeBqLL+seUBtlfoS3j
         6aoPs5Pi2Tqt8gvisnVTnTq1ioh05YcN7X5pjhaVZwFOkRrqjVIVW2Y6VslzvwA0DQrr
         EbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238756; x=1685830756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pMBsKF7+1qDWEXm4/g+4pDlJgA+ge7d77ifZ1er6FE=;
        b=WkrpGy0GcADHhzK0bbvDAL60R9OYdXZMntciCqOlCg+u9QCwXNueiBj2+hZdWltAv+
         Ef8kJLi3dR362vEyJnmv+Lz13c+M6b2zL8Z08wb0ligQK/p0L2I+K7jY/fJVZzgngr7h
         9wnjMNHH9jgvfLXUpYHsg930Gz6gdsnzP7uU89vRJXNL0shfbSDS5bS8OQBPSQj28qKP
         Gn2uTi2aHzm+VcPwCegP3zUEk2urbFrHnkGbA55DI1db6PWH6bqRVeKS0b0oPUR++IUf
         xuSv7mP+CGHngYTrMVdikSqWPKzQRvySMJrxCUMOnMwnSyn4fZIY8H5weAMA/TPYzpeM
         sI+g==
X-Gm-Message-State: AC+VfDyAq2t0VXsv/aGb2ZyzBvRcjFY/BpJhT+UkCZHMGdlTeD/p9HWJ
        M1ZsCXTNQKuzuAJx555VAr+TcA==
X-Google-Smtp-Source: ACHHUZ7yjLJ8IJk0PCCQmH5C+JgCohVLT8or89Obt8YICVGFdLjT6gjIbROv/OWxF5S4HKDadr+Avg==
X-Received: by 2002:ac2:5975:0:b0:4ea:f7be:e071 with SMTP id h21-20020ac25975000000b004eaf7bee071mr2093436lfp.46.1683238756532;
        Thu, 04 May 2023 15:19:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h12-20020a19700c000000b004f13ef9b360sm37135lfc.142.2023.05.04.15.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:19:15 -0700 (PDT)
Message-ID: <5d45e541-ceb7-4931-a46f-cd55da33a525@linaro.org>
Date:   Fri, 5 May 2023 01:19:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into PP_BLK
 and PP_BLK_TE marcos
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
 <ljt5mp4ew5lcrrrdd7xyof3jv3friafbmr3im35ddwxjc42ekh@toez7xfdreg2>
 <CAA8EJpreM9i3DUp+93K7p14f_tNMy-m+C-WdyN5_drmmkGV66g@mail.gmail.com>
 <u7hlzltevx675gfg4w6emmeceo6nj76taqeecsor6iqsi3hmki@lg43y65m6chz>
 <11ef769a-5089-57d4-db87-4c5766d98206@quicinc.com>
 <6qg25ffuq6xcfz3vuqm5lguspihjospctjclxmwyu2ifau4p7b@txywjmir7lg5>
 <9011a078-9962-b3de-6427-b9114fcd0cf4@quicinc.com>
 <55aa25pdeaqbuc2x2v3xkmcatlzmn2c5pn2py5qnqz7bnrp6s4@3vkwwnn4uasi>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <55aa25pdeaqbuc2x2v3xkmcatlzmn2c5pn2py5qnqz7bnrp6s4@3vkwwnn4uasi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 00:39, Marijn Suijten wrote:
> On 2023-05-04 12:50:57, Abhinav Kumar wrote:
>>
>>
>> On 5/4/2023 12:36 PM, Marijn Suijten wrote:
>>> On 2023-05-04 11:25:44, Abhinav Kumar wrote:
>>> <snip>
>>>>> Sure, if you really prefer a split I'd go for two patches:
>>>>> 1. Add the flag to the enum and catalog;
>>>>> 2. Add the ops guard (functional change).
>>>>>
>>>>> Then don't forget to reword the commit message, following the guidelines
>>>>> below and the suggestion for 2/7.
>>>>>
>>>>> - Marijn
>>>>
>>>> Plan sounds good to me.
>>>>
>>>> Marijn, we will wait for a couple of days to post the next rev but would
>>>> be hard more than that as we need to pick up other things which are
>>>> pending on top of this. Hence would appreciate if you can finish reviews
>>>> by then.
>>>
>>> It depends on how many more revisions are needed after that, and not all
>>> patches in this series have an r-b just yet.  Given the amount of review
>>> comments that are still trickling in (also on patches that already have
>>> maintainer r-b) I don't think we're quite there to start thinging about
>>> picking this up in drm-msm just yet.  I doubt anyone wants a repeat of
>>> the original DSC series, which went through many review rounds yet still
>>> required multiple series of bugfixes (some of which were pointed out and
>>> ignored in review) to be brought to a working state.  But the split
>>> across topics per series already makes this a lot less likely, many
>>> thanks for that.
>>>
>>
>> I think the outstanding comments shouldnt last more than 1-2 revs more
>> on this one as its mostly due to multiple patches on the list touching
>> catalog at the same time. I have been monitoring the comments closely
>> even though I dont respond to all of them.
>>
>> One of the major reasons of the number of issues with DSC 1.1 was QC
>> didn't really have the devices or panels to support it. Thats why I
>> changed that this time around to take more control of validation of DSC
>> 1.2 and ofcourse decided to break up of series into the least amount of
>> functionality needed to keep the DPU driver intact.
> 
> Really glad that you are able to test and validate it now, that goes a
> long way.  Does that also mean you can post the panel patches quickly,
> so that everyone has a point of reference?  As you said that is one of
> the main points where DSC 1.1 "went wrong" (a misunderstanding of
> drm_dsc_config).
> 
>> All that being said, we still value your comments and would gladly wait
>> for a couple of days like I already wrote. But there are more
>> incremental series on top of this:
>>
>> -> DSI changes for DSC 1.2
>> -> proper teardown for DSC
>> -> DSC pair allocation support
>> -> DSC 1.2 over DP
> 
> Yeah, I'm familiar with the concept of having many dependent series, and
> now DSC series are even rebasing on DPU (catalog) cleanups to preempt
> conflicts, which is really hard to follow.
> Dmitry just pushed v5 of "drm/i915/dsc: change DSC param tables to
> follow the DSC model" [1] and seems to have dropped some patches that
> some of these series are depending on, resulting in compilation
> failures.  Other series don't seem to fully mention all their
> dependencies.

We'd have to pick them into our code or submit directly to drm-misc. I 
removed the patches which we can get in w/o Intel review.

> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230504153511.4007320-1-dmitry.baryshkov@linaro.org/T/#u
> 
> So, for this to go as convenient as possible, do you have a list of
> series, in a desired order that they should be reviewed and tested?
> That way I can direct my priorities and help achieve the goal of picking
> base dependencies as early as possible.
> 
> For example, one of the many series regresses DSC on the Xperia XZ3
> (SDM845), but I have yet to bisect and understand which patch it is.
> Will let you know as soon as I get my tree in order.
> 
> - Marijn

-- 
With best wishes
Dmitry

