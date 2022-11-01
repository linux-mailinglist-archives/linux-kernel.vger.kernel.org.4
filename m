Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F561422E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiKAAP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKAAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:15:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357515FC0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:15:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u11so18770033ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38cDXdi0r69fdE/BUKO80R1kI/zw2O2sBzCV4ZqhUwg=;
        b=J9E40lntmHOrjoy9Xcdik21H9sYudcve10nrz642t/oMhyvmL9VFzyufdi3szUwjBV
         m/p5FEnviTesKG2W7OtG7jBD+iMM+10VyyFiueKZLk8IlllJ61r+A9sFe1BC38dtweGP
         23GUL1AqAFIhJ/cVI2cCFPse2JsR0XwPIh16/MNKJFKZnrmjDBquRlbwwYzweTQj2nXw
         C3/KLMl81IzZP3sRWy8In1aoOzLESHfQYwXhdSs4xrh9W5c5tJhKuuvtsfRqKeCNiydH
         BpprdULh+xbph4gtavi+z08szpmE7RLQ6ICzMZc1ZXnzEZf9UCfhjzTcFroAfmbE1H1b
         b7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38cDXdi0r69fdE/BUKO80R1kI/zw2O2sBzCV4ZqhUwg=;
        b=rVngh3iu3OcyG8PZ5zt/SsuJbiNtbkN/uzxrhQD2fE7YgGvBeXOSewbmAFfNARUBam
         X3YQ8+RSZbjrt/Cc/0h1b1AnACTK5vl1SffoTVgvAvrxAvEZvjN+A9IKrS79sOERE33p
         ZYIeBeQJXG+ZNG6eurqw4vYbeP4He++dh1DxicWoWr5WbJPngCSVANBVL/l5V21W+59t
         SzNAO06Cw6bdC9w4wUnmyiFcuK5f4hRgTfw6VSivxZeOb+OnxZ03OYpeTFqHf+EBYFAz
         sXhil1wP9iWJeMbJALrjzCXjxYr75JyCt1kHefakDqypqHRflQt25yVTqKemHYq0P+C7
         QCGw==
X-Gm-Message-State: ACrzQf00wQ2chaqXnqfLIXBGs2DOCozPWCN/o5FnxOyFSH7nKgU6oz/x
        nzr6J3mE2gYEU7nZSs4YATX3pQ==
X-Google-Smtp-Source: AMsMyM4nWjJC7qQLq2CsQhuNIRUwJ8W7P86DduyVfrSh1xY70OZRwrvx9QT6G38gI6top2m9YGZSUA==
X-Received: by 2002:a2e:9c89:0:b0:277:138c:9fd9 with SMTP id x9-20020a2e9c89000000b00277138c9fd9mr174812lji.119.1667261753008;
        Mon, 31 Oct 2022 17:15:53 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651220d200b004a1e7216131sm1491028lfr.116.2022.10.31.17.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 17:15:52 -0700 (PDT)
Message-ID: <155e4171-187c-4ecf-5a9b-12f0c2207524@linaro.org>
Date:   Tue, 1 Nov 2022 03:15:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
 <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org>
 <deb60200-5a37-ec77-9515-0c0c89022174@quicinc.com>
 <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 03:08, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 31, 2022 at 2:11 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>
>> Hi Dmitry,
>>
>>
>> Link rate is advertised by sink, but adjusted (reduced the link rate)
>> by host during link training.
>>
>> Therefore should be fine if host did not support HBR3 rate.
>>
>> It will reduce to lower link rate during link training procedures.
>>
>> kuogee
>>
>> On 10/31/2022 11:46 AM, Dmitry Baryshkov wrote:
>>> On 31/10/2022 20:27, Kuogee Hsieh wrote:
>>>> An HBR3-capable device shall also support TPS4. Since TPS4 feature
>>>> had been implemented already, it is not necessary to limit link
>>>> rate at HBR2 (5.4G). This patch remove this limitation to support
>>>> HBR3 (8.1G) link rate.
>>>
>>> The DP driver supports several platforms including sdm845 and can
>>> support, if I'm not mistaken, platforms up to msm8998/sdm630/660.
>>> Could you please confirm that all these SoCs have support for HBR3?
>>>
>>> With that fact being confirmed:
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>>
>>>>
>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_panel.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c
>>>> b/drivers/gpu/drm/msm/dp/dp_panel.c
>>>> index 5149ceb..3344f5a 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>>>> @@ -78,10 +78,6 @@ static int dp_panel_read_dpcd(struct dp_panel
>>>> *dp_panel)
>>>>        if (link_info->num_lanes > dp_panel->max_dp_lanes)
>>>>            link_info->num_lanes = dp_panel->max_dp_lanes;
>>>>    -    /* Limit support upto HBR2 until HBR3 support is added */
>>>> -    if (link_info->rate >=
>>>> (drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)))
>>>> -        link_info->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
>>>> -
>>>>        drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
>>>>        drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
>>>>        drm_dbg_dp(panel->drm_dev, "lane_count=%d\n",
>>>> link_info->num_lanes);
> 
> Stephen might remember better, but I could have sworn that the problem
> was that there might be something in the middle that couldn't support
> the higher link rate. In other words, I think we have:
> 
> SoC <--> TypeC Port Controller <--> Display
> 
> The SoC might support HBR3 and the display might support HBR3, but the
> TCPC (Type C Port Controller) might not. I think that the TCPC is a
> silent/passive component so it can't really let anyone know about its
> limitations.
> 
> In theory I guess you could rely on link training to just happen to
> fail if you drive the link too fast for the TCPC to handle. Does this
> actually work reliably?
> 
> I think the other option that was discussed in the past was to add
> something in the device tree for this. Either you could somehow model
> the TCPC in DRM and thus know that a given model of TCPC limits the
> link rate or you could hack in a property in the DP controller to
> limit it.

Latest pmic_glink proposal from Bjorn include adding the drm_bridge for 
the TCPC. Such bridge can in theory limit supported modes and rates.

-- 
With best wishes
Dmitry

