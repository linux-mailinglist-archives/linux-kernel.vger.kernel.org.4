Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92238700F13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbjELSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbjELSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:50:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A259D4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:50:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso12030035e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683917439; x=1686509439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuPelm9ba0Xh/ndmXQX20gIsRhFbM+3g133ZmY3Lhg0=;
        b=Enlk2Rc5iR/dP1dGoqIKkBy+snUvph8LfeT51DEJjZCkVK6SgBwrGYQCBWsfN0HLGH
         InAIsrU6w/aapZvB4TfpWicXIptFQBGYu/ZjGQaz2nhV0z4n5MB0vlEWd3beRXKFvrcY
         idTyVZBw+qZ+tD8o8H4iHPWBRG6ct+nXUuH6MDLUJ52c+zhrmmFCZgYTJmtByVJOwDzR
         aPyGcL7sYbvFmPeyvN3i++wmoPl7XWOqFPhkRYByT/E4i60YihnAY65+Rbrbj4nx2znU
         queQS6wqW+StPSiMbKo2NdhxQ0pCwFCHBiSkj2vWyoMyIMfkWCM61T27F9bGCHQ/s8kw
         dHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683917439; x=1686509439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuPelm9ba0Xh/ndmXQX20gIsRhFbM+3g133ZmY3Lhg0=;
        b=G1YmUtnervuehw0mAqcJq6ayISk7k1114SGZsAAbq8J3Ycldf99/9sJYx6Nw1d++3A
         PO35wcuGJcYLbX7wZds8Vhih2JrN3FdD2GetbKtB60awWJ5U31I8touAt8qVn5DdUHv4
         ipsZYNb8QyO7E0Jacj5rNnZ2Lxr107q3LfDAmxf0+/WAft5j8uGfOuECDL6ruBwxZHM9
         cMh+RwiISmT+2si133TUQdcG7B9T/LeToXNqwexS+4NCVJne1b7kC0LjNIPkDO8fjMSZ
         PM7sUJiNM0b8n4Uc/ozgpk1dJGLzm8wqi/kubI5O73MflzoLQzC4WgpnEFBld/fsngWs
         7S/A==
X-Gm-Message-State: AC+VfDwSD8u74GLHrAZGBbkQ0Cttf+ywwt+tbTYII39cd68F+oe5pM0v
        pnMa0DxydFb70cNzEXdeVpS/lQ==
X-Google-Smtp-Source: ACHHUZ5qix+AfKeOoptSwy0yXk92l+wgnvqFCSAy7TIzE2g53L4ZMCweRzU6C81TkLkrlVytUw2Jzw==
X-Received: by 2002:a05:6512:390f:b0:4ed:b048:b98a with SMTP id a15-20020a056512390f00b004edb048b98amr4280477lfu.6.1683917438922;
        Fri, 12 May 2023 11:50:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651204d000b004d8580b2470sm1559005lfq.225.2023.05.12.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 11:50:38 -0700 (PDT)
Message-ID: <e3579cea-1764-26ff-ba9d-6eb23a0aaef0@linaro.org>
Date:   Fri, 12 May 2023 21:50:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 6/8] drm/msm/dpu: separate DSC flush update out of
 interface
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-7-git-send-email-quic_khsieh@quicinc.com>
 <91f63678-aade-2f42-1311-1bc706ebdc91@linaro.org>
 <5319b87a-9a4c-1786-9ea9-b9015ee56357@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5319b87a-9a4c-1786-9ea9-b9015ee56357@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 21:47, Abhinav Kumar wrote:
> 
> 
> On 5/12/2023 11:21 AM, Dmitry Baryshkov wrote:
>> On 12/05/2023 21:00, Kuogee Hsieh wrote:
>>> Current DSC flush update is piggyback inside dpu_hw_ctl_intf_cfg_v1().
>>> This patch separates DSC flush away from dpu_hw_ctl_intf_cfg_v1() by
>>> adding dpu_hw_ctl_update_pending_flush_dsc_v1() to handle both per
>>> DSC engine and DSC flush bits at same time to make it consistent with
>>> the location of flush programming of other dpu sub blocks.
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 14 ++++++++++++--
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  | 22 
>>> ++++++++++++++++------
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  | 10 ++++++++++
>>>   3 files changed, 38 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index ffa6f04..5cae70e 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -1834,12 +1834,18 @@ dpu_encoder_dsc_initial_line_calc(struct 
>>> drm_dsc_config *dsc,
>>>       return DIV_ROUND_UP(total_pixels, dsc->slice_width);
>>>   }
>>> -static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
>>> +static void dpu_encoder_dsc_pipe_cfg(struct dpu_encoder_virt *dpu_enc,
>>> +                     struct dpu_hw_dsc *hw_dsc,
>>>                        struct dpu_hw_pingpong *hw_pp,
>>>                        struct drm_dsc_config *dsc,
>>>                        u32 common_mode,
>>>                        u32 initial_lines)
>>>   {
>>> +    struct dpu_encoder_phys *cur_master = dpu_enc->cur_master;
>>> +    struct dpu_hw_ctl *ctl;
>>> +
>>> +    ctl = cur_master->hw_ctl;
>>
>> Just for my understanding: if we have a bonded DSI @ sdm845, should 
>> both flashes go to the master CTL or each flush should go to the 
>> corresponding CTL?
>>
> 
> Is this question for DSC or just general question about flush?
> 
> I dont see an explicit DSC flush needed in sdm845 at the ctl level.
> 
> If the question is about general flush involving two control paths, we 
> need to combine the flushes and they goto the master only. Please refer 
> to below part in sde_encoder.c
And this is because we have a single CTL to flush on sm8150+, isn't it?

> 
> 4243     /* for split flush, combine pending flush masks and send to 
> master */
> 4244     if (pending_flush.pending_flush_mask && sde_enc->cur_master) {
> 4245         ctl = sde_enc->cur_master->hw_ctl;
> 4246         if (config_changed && ctl->ops.reg_dma_flush)
> 4247             ctl->ops.reg_dma_flush(ctl, is_regdma_blocking);
> 4248         _sde_encoder_trigger_flush(&sde_enc->base, 
> sde_enc->cur_master,
> 4249                         &pending_flush,
> 4250                         config_changed);
> 4251     }


-- 
With best wishes
Dmitry

