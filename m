Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD36FF68E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjEKP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEKP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:58:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5330CA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:58:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f13c577e36so9822042e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683820681; x=1686412681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbhZtlVai7wr83LzKQ1eGCXn7JSzciFoYP4tNZG0DA4=;
        b=DOlCMASuzkfvYH4fUucemmk3tXBvlaW3SgG5o8g5SJ/uKy3HaUs0+H3o0NxaJEosNJ
         tXX2Veo0Jd1axcG5vm+KGwcvzWDpT/R8IZaXu4kWmi7dJqkNTY0FHQfV/u21ULH4utQW
         lEv5UJH/VHUuORXNHUQOK44fkpl8z4xAMdePJUmueW39SENeEQ5x8KpcZBc/yrqtqBAK
         o17/PD0ltClYxFCcIS9x9g3sLNRHKMaYO748eaJsLlVNUsWKbrFKdEMCsBoXSdwHyA4C
         XlfK3q77Te740ca95/ov5C4c8g4Eu4yhevMhgvzyZEkrWAp/yhQW0+PjyQ6Qbm0VT0FF
         8ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820681; x=1686412681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbhZtlVai7wr83LzKQ1eGCXn7JSzciFoYP4tNZG0DA4=;
        b=Y+YKCKr8h7ur6vf6CGZ4o5U0bUKj7CBONGfiiOzwAf9qFn2dzeEk2ZZFRRj8BubGL3
         J6jJRnfrX5NBr7rEdPN67M/W+pHocdXsx61o7AZ7B6p+JKfFox7s2XYqpvj/l6i9IqOu
         RZ8WXeg0OXIriKFUtfOJWyvdoIwYLrBPaEA3S9lDSgqj9o3O9q8VtI6FtbmC0ptsrlAF
         fa3XLlk79TOKBdEwYu6s44RWeiwEgB1Jpa0DbElGTyRhoFUfMaiAtKkTs9V6sQ9arU8Z
         UjOS+Fyr/U3obCLvPR0Q8vJwXzPAryOwgwesoL55CDz4hDr0Mb5yOcrulyfu4VZXsVGT
         im0g==
X-Gm-Message-State: AC+VfDx3g1uG9eVXTacARf9R/DaKqOSVtELmxoHYm381ZfuSJ9j+NMwU
        VpLrG2J11GCrzcEy1QLBMre8xQ==
X-Google-Smtp-Source: ACHHUZ7lBR9dNuJdEtzeLo7Fpf4LEun3w5ZMNkek8HBIN8WN1+JlMrEGR/SETuFsaiUzfZ5lu/YDUg==
X-Received: by 2002:ac2:4828:0:b0:4f1:2ebf:537a with SMTP id 8-20020ac24828000000b004f12ebf537amr2734509lft.1.1683820681086;
        Thu, 11 May 2023 08:58:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d3-20020ac244c3000000b004f021a4e5f6sm1151283lfm.52.2023.05.11.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:58:00 -0700 (PDT)
Message-ID: <5ef83699-01de-d062-6239-9bb834c70458@linaro.org>
Date:   Thu, 11 May 2023 18:57:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts
 to hpd_enable/disable
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprtQF0x_LCOTrt5bvRnJ+xRz6QxLF6QAP-4Pff6V5TJ2g@mail.gmail.com>
 <20230511155331.2jmfe7xcs5tihdgb@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230511155331.2jmfe7xcs5tihdgb@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 18:53, Bjorn Andersson wrote:
> On Thu, May 11, 2023 at 07:24:46AM +0300, Dmitry Baryshkov wrote:
>> On Wed, 10 May 2023 at 23:31, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>>
>>> The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
>>> pinmuxed into DP controller. HPD plug/unplug interrupts cannot be enabled until
>>> internal_hpd flag is set to true.
>>> At both bootup and resume time, the DP driver will enable external DP
>>> plugin interrupts and handle plugin interrupt accordingly. Unfortunately
>>> dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
>>> flag to true later than where DP driver expected during bootup time.
>>>
>>> This causes external DP plugin event to not get detected and display stays blank.
>>> Move enabling HDP plugin/unplugged interrupts to dp_bridge_hpd_enable()/disable() to
>>> set internal_hpd to true along with enabling HPD plugin/unplugged interrupts
>>> simultaneously to avoid timing issue during bootup and resume.
>>>
>>> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>
>> Thanks for debugging this!
>>
>> However after looking at the driver I think there is more than this.
>>
>> We have several other places gated on internal_hpd flag, where we do
>> not have a strict ordering of events.
>> I see that dp_hpd_plug_handle() and dp_hpd_unplug_handle() also toggle
>> DP_DP_IRQ_HPD_INT_MASK and DP_DP_HPD_REPLUG_INT_MASK depending on
>> internal_hpd. Can we toggle all 4 interrupts from the
>> hpd_enable/hpd_disable functions? If we can do it, then I think we can
>> drop the internal_hpd flag completely.
>>
> 
> Yes, that's what I believe the DRM framework intend us to do.
> 
> The problem, and reason why I didn't do tat in my series, was that in
> order to update the INT_MASKs you need to clock the IP-block and that's
> done elsewhere.
> 
> So, for the internal_hpd case, it seems appropriate to pm_runtime_get()
> in hpd_enable() and unmask the HPD interrupts, and mask the interrupts
> and pm_runtime_put() in hpd_disable().
> 
> 
> But for edp and external HPD-signal we also need to make sure power is
> on while something is connected...

I think this is already handled by the existing code, see calls to the 
dp_display_host_init().

> 
>> I went on and checked other places where it is used:
>> - dp_hpd_unplug_handle(), guarding DP_DP_HPD_PLUG_INT_MASK toggling. I
>> think we can drop these two calls completely. The function is under
>> the event_mutex protection, so other events can not interfere.
>> - dp_bridge_hpd_notify(). What is the point of this check? If some
>> other party informs us of the HPD event, we'd better handle it instead
>> of dropping it. Correct?  In other words, I'd prefer seeing the
>> hpd_event_thread removal. Instead of that I think that on
>> HPD/plug/unplug/etc. IRQ the driver should call into the drm stack,
>> then the hpd_notify call should process those events.
>>
> 
> I agree, that seems to be what's expected of us from the DRM framework.
> 
> Regards,
> Bjorn
> 
>>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
>>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>> index 3e13acdf..71aa944 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>> @@ -1088,13 +1088,6 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
>>>          dp_display_host_init(dp);
>>>          dp_catalog_ctrl_hpd_config(dp->catalog);
>>>
>>> -       /* Enable plug and unplug interrupts only if requested */
>>> -       if (dp->dp_display.internal_hpd)
>>> -               dp_catalog_hpd_config_intr(dp->catalog,
>>> -                               DP_DP_HPD_PLUG_INT_MASK |
>>> -                               DP_DP_HPD_UNPLUG_INT_MASK,
>>> -                               true);
>>> -
>>>          /* Enable interrupt first time
>>>           * we are leaving dp clocks on during disconnect
>>>           * and never disable interrupt
>>> @@ -1396,12 +1389,6 @@ static int dp_pm_resume(struct device *dev)
>>>
>>>          dp_catalog_ctrl_hpd_config(dp->catalog);
>>>
>>> -       if (dp->dp_display.internal_hpd)
>>> -               dp_catalog_hpd_config_intr(dp->catalog,
>>> -                               DP_DP_HPD_PLUG_INT_MASK |
>>> -                               DP_DP_HPD_UNPLUG_INT_MASK,
>>> -                               true);
>>> -
>>>          if (dp_catalog_link_is_connected(dp->catalog)) {
>>>                  /*
>>>                   * set sink to normal operation mode -- D0
>>> @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>>>   {
>>>          struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>>>          struct msm_dp *dp_display = dp_bridge->dp_display;
>>> +       struct dp_display_private *dp;
>>> +
>>> +       dp = container_of(dp_display, struct dp_display_private, dp_display);
>>>
>>>          dp_display->internal_hpd = true;
>>> +       dp_catalog_hpd_config_intr(dp->catalog,
>>> +                               DP_DP_HPD_PLUG_INT_MASK |
>>> +                               DP_DP_HPD_UNPLUG_INT_MASK,
>>> +                               true);
>>>   }
>>>
>>>   void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>>>   {
>>>          struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>>>          struct msm_dp *dp_display = dp_bridge->dp_display;
>>> +       struct dp_display_private *dp;
>>> +
>>> +       dp = container_of(dp_display, struct dp_display_private, dp_display);
>>>
>>> +       dp_catalog_hpd_config_intr(dp->catalog,
>>> +                               DP_DP_HPD_PLUG_INT_MASK |
>>> +                               DP_DP_HPD_UNPLUG_INT_MASK,
>>> +                               false);
>>>          dp_display->internal_hpd = false;
>>>   }
>>
>> --
>> With best wishes
>> Dmitry

-- 
With best wishes
Dmitry

