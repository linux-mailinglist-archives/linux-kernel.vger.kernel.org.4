Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5B6A7606
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCAVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:15:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1014989A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:15:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r27so19446340lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+t7bN+vbdlsmpnEw6FpJggio/ds3KE+IlPtPNhbSz/o=;
        b=nD27E+SFsfYfEeC8tmYtQURee5bxHTpoMTHVmzm2iTC/QXVWbfZ0SRlGhFBKGO/92f
         4nhRlj/KOGB0Z9nTKXZ6kNS7v6n+0c7KxWG47260iAyLI/kHhBGBJFe7WLAPyzpTDap0
         pUywfMkZ+ABCf+naW7JeULWamWERHrGhZ2jm4aMoLXm+2gdvTI/Atmoc/XVyYZ3t0gBb
         hyKE7wIDNmhiDiYa2Q85l1VL93I8/uZrLA+rFYEUiT/2UVrPWwq2qXEGB5QwkJ/cDiU+
         kYzmC4exPauuQdsqQ6hBNh1Znwx3wCG7qC+f1b9oMM8gLUbShpAsvaWzk3c/pVrRvHBE
         1ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t7bN+vbdlsmpnEw6FpJggio/ds3KE+IlPtPNhbSz/o=;
        b=5X4xaq6kiO6e1dGB4oV75UUzCxQadVIKbnYZwkXBo7bAqeDfx89exuh5fNuPIjC8cc
         xjDExaXGI2ZBs53xxjEm2kqwwx2vhv3qG8gL/z0vZV5hpDYlfYG/K2YmM/WIoULIZTap
         B4O2gVGglE0vJhOjW1dqRrLIK1j0SNqQMr9cobG5tvZlO+xodE1J9UGqvT5bmvRh3hxG
         CfoBgSLDFI+HT9HHsS8kXbhItvR3YfbMM6kLSKk3IWODpQ1T9Z+x3RGGDxjqQNNsO59t
         cYa2R7oBfAdlguUch/5QDe/d0Bg4HNkhxBTGdeMGJaIY271KohmV9ncweW22YilpPdwa
         y7bw==
X-Gm-Message-State: AO0yUKXktHBKAjPBkKzHShHpgH19Y1H1lgpUjk69q+O67RwA65IkxSM/
        AAY+duc5Ne4lVShr5mgFZWhWkw==
X-Google-Smtp-Source: AK7set+pESwKWGqIuTj2Okqk+XOkiFg8hXqVZ2jA6DNWK+iXJy98GtUDRWaPrgd5gt1fyN6PK94J+g==
X-Received: by 2002:ac2:483a:0:b0:4db:43b6:77b9 with SMTP id 26-20020ac2483a000000b004db43b677b9mr2057689lft.11.1677705324570;
        Wed, 01 Mar 2023 13:15:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d13-20020ac25ecd000000b004dd7f2854efsm1859065lfq.251.2023.03.01.13.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:15:23 -0800 (PST)
Message-ID: <86787af0-aa95-a2d8-d68c-555be54a3784@linaro.org>
Date:   Wed, 1 Mar 2023 23:15:22 +0200
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <38bf75b4-799a-9758-aae3-69a7e0fc3f58@quicinc.com>
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

On 01/03/2023 18:57, Kuogee Hsieh wrote:
> 
> On 2/28/2023 6:16 PM, Dmitry Baryshkov wrote:
>> On Wed, 1 Mar 2023 at 02:17, Kuogee Hsieh <quic_khsieh@quicinc.com> 
>> wrote:
>>> There is a reboot/suspend test case where system suspend is forced
>>> during system booting up. Since dp_display_host_init() of external
>>> DP is executed at hpd thread context, this test case may created a
>>> scenario that dp_display_host_deinit() from pm_suspend() run before
>>> dp_display_host_init() if hpd thread has no chance to run during
>>> booting up while suspend request command was issued. At this scenario
>>> system will crash at aux register access at dp_display_host_deinit()
>>> since aux clock had not yet been enabled by dp_display_host_init().
>>> Therefore we have to ensure aux clock enabled by checking
>>> core_initialized flag before access aux registers at pm_suspend.
>> Can a call to dp_display_host_init() be moved from
>> dp_display_config_hpd() to dp_display_bind()?
> 
> yes,  Sankeerth's  "drm/msm/dp: enable pm_runtime support for dp driver" 
> patch is doing that which is under review.
> 
> https://patchwork.freedesktop.org/patch/523879/?series=114297&rev=1

No, he is doing another thing. He is moving these calls to pm_runtime 
callbacks, not to the dp_display_bind().

>> Related question: what is the primary reason for having
>> EV_HPD_INIT_SETUP and calling dp_display_config_hpd() via the event
>> thread? Does DP driver really depend on DPU irqs being installed? As
>> far as I understand, DP device uses MDSS interrupts and those IRQs are
>> available and working at the time of dp_display_probe() /
>> dp_display_bind().
> 
> HDP gpio pin has to run through DP aux module 100ms denouncing logic and 
> have its mask bits.
> 
> Therefore DP irq has to be enabled to receive DP isr with mask bits set.

So... DP irq is enabled by the MDSS, not by the DPU. Again, why does DP 
driver depend on DPU irqs being installed?

> Similar mechanism is used for mdp, dsi, etc.

And none of them uses irq_postinstall callback.

> 
> 
>>> Changes in v2:
>>> -- at commit text, dp_display_host_init() instead of host_init()
>>> -- at commit text, dp_display_host_deinit() instead of host_deinit()
>>>
>>> Changes in v3:
>>> -- re arrange to avoid commit text line over 75 chars
>>>
>>> Fixes: 989ebe7bc446 ("drm/msm/dp: do not initialize phy until plugin 
>>> interrupt received")
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_display.c | 20 ++++++++++++--------
>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index bde1a7c..1850738 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -460,10 +460,12 @@ static void dp_display_host_init(struct 
>>> dp_display_private *dp)
>>>                  dp->dp_display.connector_type, dp->core_initialized,
>>>                  dp->phy_initialized);
>>>
>>> -       dp_power_init(dp->power, false);
>>> -       dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>>> -       dp_aux_init(dp->aux);
>>> -       dp->core_initialized = true;
>>> +       if (!dp->core_initialized) {
>>> +               dp_power_init(dp->power, false);
>>> +               dp_ctrl_reset_irq_ctrl(dp->ctrl, true);
>>> +               dp_aux_init(dp->aux);
>>> +               dp->core_initialized = true;
>>> +       }
>>>   }
>>>
>>>   static void dp_display_host_deinit(struct dp_display_private *dp)
>>> @@ -472,10 +474,12 @@ static void dp_display_host_deinit(struct 
>>> dp_display_private *dp)
>>>                  dp->dp_display.connector_type, dp->core_initialized,
>>>                  dp->phy_initialized);
>>>
>>> -       dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
>>> -       dp_aux_deinit(dp->aux);
>>> -       dp_power_deinit(dp->power);
>>> -       dp->core_initialized = false;
>>> +       if (dp->core_initialized) {
>>> +               dp_ctrl_reset_irq_ctrl(dp->ctrl, false);
>>> +               dp_aux_deinit(dp->aux);
>>> +               dp_power_deinit(dp->power);
>>> +               dp->core_initialized = false;
>>> +       }
>>>   }
>>>
>>>   static int dp_display_usbpd_configure_cb(struct device *dev)
>>> -- 
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>> Forum,
>>> a Linux Foundation Collaborative Project
>>>
>>

-- 
With best wishes
Dmitry

