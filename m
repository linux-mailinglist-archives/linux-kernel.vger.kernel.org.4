Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01586AA5AC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCCXi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCCXi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:38:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247912056
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:38:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f13so16567058edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LLtkB9zupaYh5rgoCp+HsmbCqOkT9V71XK4gPn/Zv0=;
        b=fXY87L3z7pvWHDt5jrjglBEMi1dWN7cB8/FD3oaWIRsQWkJLRcffaDgqhdzTOMw2Fi
         P/FG8i+g3+V85D5loyDNsOLbu/qRWUCz/aBkHoyOA5/zUcpmY+NE9/zaH4ETy4eFYWIz
         dA7D0PDfzx67yKE56UfAAKilqHZTvckjWaERdj7/Xr1I4VLe0d2FLJj6T6GERsixBxv6
         SQ/dhQOimlC9h/PL2TyljvZNbQkFB5Nfz13bJNch0ff7N3bnifRZi+dlB+190/HUggd0
         Qrb7/8SQLUO/zd7uRQeM8EVyGFkS0xuLjIfrdKWPlewWabhQF0oxxa8s5dbVBY+o7Fy8
         x4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LLtkB9zupaYh5rgoCp+HsmbCqOkT9V71XK4gPn/Zv0=;
        b=Iq+w5GCtlaJbxWRFmlXp3AraZqFchMonO5dJr/PjWRG4v7b1Ohfk3A5D2EUieY1L94
         1KCy1F9cFaSA/R1RhijDiThLtHffhcVVsULMYKnm7SGlVMnYLSD29wq8oLcp0MTls+QG
         zlQ9oR+EHmCtpZeAK4Hrek2sEGME4YehyfnQHCoyxi2jqjzxJPToTas09+6fSNYVliOm
         mj19Z1R8t4t4vbsZuFtquGhDd4px8JRdDDT0xRrfxJJbAFvtzAsoQLFeicGv96e86KBn
         Fa2xUX6riZEQ4YXAfN8Z6f8cldZbzsOvnY87Py+D1hHvqnvndd4LKAFZe7QUd5xTIkc9
         vl7Q==
X-Gm-Message-State: AO0yUKX+gCenTcjJKbqsLBkx4mwYLBYKmojpxqAP9TCUbghbm4AHItre
        Ra0BawxERAIX9H3zOnrcHPJXcQ==
X-Google-Smtp-Source: AK7set9YVONZzpeptt378DAlbJC0RMTuPUN7n9aPVHlpFPl395rEyMndcKIv959wGka31f9cx1Nv7A==
X-Received: by 2002:a17:906:b08c:b0:8af:3b78:315d with SMTP id x12-20020a170906b08c00b008af3b78315dmr3519597ejy.23.1677886704009;
        Fri, 03 Mar 2023 15:38:24 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b008b17de9d1f2sm1493442ejb.15.2023.03.03.15.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:38:23 -0800 (PST)
Message-ID: <358262c3-e501-3c7f-7502-f0323cdcc634@linaro.org>
Date:   Sat, 4 Mar 2023 01:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] drm/msm/dp: check core_initialized flag at both
 host_init() and host_deinit()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677629817-18891-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpquZAhn+HswNxardN1fE8Zu1CKrCU5EiX=B8mGWuxfWnQ@mail.gmail.com>
 <38bf75b4-799a-9758-aae3-69a7e0fc3f58@quicinc.com>
 <86787af0-aa95-a2d8-d68c-555be54a3784@linaro.org>
 <dddd3f2f-28e7-2188-5498-399cdb75adb4@quicinc.com>
 <CAA8EJpokgWnRZ6rvNtsY4=WVcQv-5bCPYRE+dTqcWjbgzO-bxw@mail.gmail.com>
 <4c733721-855a-85fd-82a9-9af0f80fc02e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <4c733721-855a-85fd-82a9-9af0f80fc02e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 00:45, Kuogee Hsieh wrote:
> 
> On 3/2/2023 11:04 AM, Dmitry Baryshkov wrote:
>> On Thu, 2 Mar 2023 at 20:41, Kuogee Hsieh <quic_khsieh@quicinc.com> 
>> wrote:
>>>
>>> On 3/1/2023 1:15 PM, Dmitry Baryshkov wrote:
>>>> On 01/03/2023 18:57, Kuogee Hsieh wrote:
>>>>> On 2/28/2023 6:16 PM, Dmitry Baryshkov wrote:
>>>>>> On Wed, 1 Mar 2023 at 02:17, Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>>> wrote:
>>>>>>> There is a reboot/suspend test case where system suspend is forced
>>>>>>> during system booting up. Since dp_display_host_init() of external
>>>>>>> DP is executed at hpd thread context, this test case may created a
>>>>>>> scenario that dp_display_host_deinit() from pm_suspend() run before
>>>>>>> dp_display_host_init() if hpd thread has no chance to run during
>>>>>>> booting up while suspend request command was issued. At this 
>>>>>>> scenario
>>>>>>> system will crash at aux register access at dp_display_host_deinit()
>>>>>>> since aux clock had not yet been enabled by dp_display_host_init().
>>>>>>> Therefore we have to ensure aux clock enabled by checking
>>>>>>> core_initialized flag before access aux registers at pm_suspend.
>>>>>> Can a call to dp_display_host_init() be moved from
>>>>>> dp_display_config_hpd() to dp_display_bind()?
>>>>> yes,  Sankeerth's  "drm/msm/dp: enable pm_runtime support for dp
>>>>> driver" patch is doing that which is under review.
>>>>>
>>>>> https://patchwork.freedesktop.org/patch/523879/?series=114297&rev=1
>>>> No, he is doing another thing. He is moving these calls to pm_runtime
>>>> callbacks, not to the dp_display_bind().
>>>>
>>>>>> Related question: what is the primary reason for having
>>>>>> EV_HPD_INIT_SETUP and calling dp_display_config_hpd() via the event
>>>>>> thread? Does DP driver really depend on DPU irqs being installed? As
>>>>>> far as I understand, DP device uses MDSS interrupts and those IRQs 
>>>>>> are
>>>>>> available and working at the time of dp_display_probe() /
>>>>>> dp_display_bind().
>>>>> HDP gpio pin has to run through DP aux module 100ms denouncing logic
>>>>> and have its mask bits.
>>>>>
>>>>> Therefore DP irq has to be enabled to receive DP isr with mask bits 
>>>>> set.
>>>> So... DP irq is enabled by the MDSS, not by the DPU. Again, why does
>>>> DP driver depend on DPU irqs being installed?
>>> sorry, previously i mis understand your question -- why does DP driver
>>> depend on DPU irqs being installed?
>>>
>>> now, I think you are asking why  dpu_irq_postinstall() ==>
>>> msm_dp_irq_postinstall() ==> event_thread ==> dp_display_config_hdp()
>>> ==> enable_irq(dp->irq)
>>>
>>> With the below test i had run, i think the reason is to make sure
>>> dp->irq be requested before enable it.
>>>
>>> I just run the execution timing order test and collect execution order
>>> as descending order at below,
>>>
>>> 1) dp_display_probe() -- start
>>>
>>> 2) dp_display_bind()
>>>
>>> 3) msm_dp_modeset_init()  ==> dp_display_request_irq() ==>
>>> dp_display_get_next_bridge()
>>>
>>> 4) dpu_irq_postinstall() ==> msm_dp_irq_postinstall() ==>
>>> enable_irq(dp->irq)
>>>
>>> 5) dp_display_probe() -- end
>>>
>>> dp->irq is request at msm_dp_modeset_init() and enabled after.
>> Should be moved to probe.
>>
>>> That bring up the issue to move DP's dp_display_host_init() executed at
>>> dp_display_bind().
>>>
>>> Since eDP have dp_dispaly_host_init() executed at
>>> dp_display_get_next_bridge() which executed after dp_display_bind().
>>>
>>> If moved DP's dp_display_host_init() to dp_dispaly_bind() which means DP
>>> will be ready to receive HPD irq before eDP ready.
>> And the AUX bus population should also be moved to probe(), which
>> means we should call dp_display_host_init() from probe() too.
>> Having aux_bus_populate in probe would allow moving component_add() to
>> the done_probing() callback, making probe/defer case more robust
>>
>>> This may create some uncertainties at execution flow and complicate
>>> things up.
>> Hopefully the changes suggested above will make it simpler.
> 
> ok, I will create another patch to

patchset

> 
> 1) move dp_display_host_init() to probe()
> 
> 2) move component_add() to done_probing() for eDP
> 
> 3) keep DP as simple platform device (component_add() still executed in 
> probe())

4) move devm_request_irq() to probe, add IRQF_NO_AUTOEN instead of 
calling disable_irq() right after request_irq()

5) drop DP_HPD_INIT_SETUP and related code

> 
> Meanwhile, can you approve this patch so that it will not block our 
> internal daily testing?

Quoting your commit message: "Since dp_display_host_init() of external
DP is executed at hpd thread context...". After these changes the 
mentioned function will no longer be executed from the hpd thread. So, 
let's rework the probe/init sequence first, then we can see if this 
patch is still necessary and how should it look.

-- 
With best wishes
Dmitry

