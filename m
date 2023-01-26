Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4467D8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjAZWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:51:07 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EA47ECD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:51:05 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y69so1189898iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zvY1NZIKVudFjIBW9E/G/NnVjL+16aZwag2juBW8hg=;
        b=PqSCzzSwgfPbeBwBYPYREBBLEW6iHqVw8wj07TiWAyIpMp1ebEGAwiMpW1VTodraYN
         G/HLMa/GIIQv3SdmPB2F3ZNSqZ5Sf+49w22fJhcdTi0z8irz26iikYm+6IEofGWo8thi
         2YqtStdW3bHgIrNJlxjR2vM3ovEo/CNbdlcv5xDjXdOuSEJNHxu5+eTQ5t1xI8m92mi7
         ZZOOXfJxa/3XE+4IDcpHSGGW936gOt8HIrYKQdKrqTP8oUCSf/WIVSSWohxZ4lJLO/tQ
         3EfEMckl85d67DhJ8hZzn2zrkJHTdVP/aYFlP3nNWj4MvdS2AGrh6meL/RhAlqq++l9i
         W3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zvY1NZIKVudFjIBW9E/G/NnVjL+16aZwag2juBW8hg=;
        b=QJMGB3Ji1KSc4v3SQ75beX/+hBGirEU5f0qUVYDRthfUj40V/UH8dyNt0gNVQksp4b
         1tLn2NX1jGhfa1gBlKygt2dMZMHl4CS/5w4mRH4qyD39NIeeCnU6BJbuJKUXwkT3sQPz
         FMSwHA1r0lWz3xVXAW6mXIjyd3db5YHC6YUSY5VDxWX66whXV9tCLGpieyBSZORwepbK
         J+mrX5nKCTuQQ5G5oboa/GlyrTCRUXKnz4Ik9NWsGN3Jz9aYImU+lSEB4K6ERar0DYnW
         XZ4Fkndh7p/4zDdx382c1oY72jyaBX4aCHrGZMUyZoap/M1lp4aWNiDSEmqhvhhUmVex
         3Iyw==
X-Gm-Message-State: AFqh2krJk1NtHZi6iT763qVmHJbnM/MFnd/wliIuvCWJql+QM2oXTpcK
        +uozx0G5R0hoeKVIM/LLNt1WUQ==
X-Google-Smtp-Source: AMrXdXs8V40PLbV/yhExX2kRHQCY1Yo9wbM7q84dlGOei7EhLtS3so+HtLLiv2VHa+z7t8Tv2X3jvg==
X-Received: by 2002:a6b:c8c3:0:b0:704:d3b0:3029 with SMTP id y186-20020a6bc8c3000000b00704d3b03029mr24381288iof.17.1674773465391;
        Thu, 26 Jan 2023 14:51:05 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id y18-20020a056638039200b003a20a8f6bd2sm853151jap.153.2023.01.26.14.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 14:51:04 -0800 (PST)
Message-ID: <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org>
Date:   Fri, 27 Jan 2023 00:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
 <20230125190926.GA2697290-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230125190926.GA2697290-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 21:09, Rob Herring wrote:
> On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
>> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
>>>
>>> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> Do not create device link for clock controllers. Some of the clocks
>>>> provided to the device via OF can be the clocks that are just parents to
>>>> the clocks provided by this clock controller. Clock subsystem already
>>>> has support for handling missing clock parents correctly (clock
>>>> orphans). Later when the parent clock is registered, clocks get
>>>> populated properly.
>>>>
>>>> An example of the system where this matters is the SDM8450 MTP board
>>>> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
>>>> clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
>>>> dispcc itself provides clocks to both PHYs, to the PHY parent device,
>>>> etc. With just dsi0_phy in place devlink is able to break the
>>>> dependency, but with two PHYs, dispcc doesn't get probed at all, thus
>>>> breaking display support.
>>>>
>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>>> Cc: Saravana Kannan <saravanak@google.com>
>>>> Cc: Abel Vesa <abel.vesa@linaro.org>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>
>>>> This patch has been posted a year ago in January 2022 ([1]). Since that time
>>>> Saravana failed to produce patches to assist in debugging the issue
>>>> ([2]) or to fix the issue ([3]). The issue we observe has been described
>>>> by Abel at ([4]). As we work on adding support for Dual DSI
>>>> configurations, the issue becomes more and more important, since binding
>>>> the whole display subsystem fails.
>>
>> I did send out a patch series[1] to try and fix this. Heck I even
>> talked about this in LPC 2022. So I don't think it's accurate to say I
>> didn't help debug this or fix this. There's some email thread in lore
>> where Abel gave more details and I figured out the issue and we didn't
>> need any more debugging. And then I sent out [1]. Sorry I missed you
>> in the cc lise for [1] -- I try to keep track of everyone to cc but
>> things slip through the cracks sometimes. But at the same time, it's
>> easy to check for emails from me before saying I didn't help or didn't
>> send out fixes :)
>>
>> If you do try to give [1] a shot, there are a bunch of bugs that
>> people pointed out for which I gave fixes on top of [1] in the
>> replies. I was supposed to work on v2 over the holidays, but that
>> didn't happen because of stuff outside my control.
>>
>>> That's ample time to fix this, so I intend to apply this. But I'll
>>> give it a few days for comments.
>>
>> Rob, I'd recommend not applying this because it'll fix it for Dmitry
>> but break someone else's use case. That's the whole reason it takes me
>> a while to send out patches -- it's easy to fix it for a subset of
>> devices, but fixing something without breaking someone else is harder
>> (I still believe it's doable) and it takes a while to test them on all
>> the devices I want to test before sending them out.

This case is really simple, I think. Clock controllers (and 
clock-core-framework) are prepared to handle clock orphans properly. 
Moreover they have been supposed to work in such way for quite a while. 
In other words, I don't think we should save them from this 
-EPROBE_DEFERRED.

Thus I think it is better to let them continue doing their job of 
handling probe deferrals on their own, at least for the time being. And 
then, when your patches are finished, we can think about reenabling 
current behaviour. As a reminder, currently, all Qualcomm platforms 
trying to use double DSI configuration are broken and have to use 
fw_devlink= kernel params.

Stephen, do you have any comments regarding this fw_devlink usage vs CCF?

> 
> Okay, will give it a bit longer.
> 
> Rob

-- 
With best wishes
Dmitry

