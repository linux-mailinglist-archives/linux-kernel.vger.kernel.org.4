Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE076DE8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDLBGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDLBGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:06:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B03ABB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:06:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t20so12640157lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681261609; x=1683853609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/gZ6cj/6Omli4sjrZld+bXqKW2xcaRiN8ew1uF6z4Q=;
        b=qg/wgnV2eqb3f3qQ00x6+C/wLebXtdwYd60rDUlRcu0B87vzIOf+Xu/PPuWjxfhOl/
         /RZKj2IE4PiUFEKdIVr4Zd19MTDnpzLVNkD7OCJ2YEZLGr3a2CCsGr4c57IEr3NXeyZn
         3Ohj60QVPeGofBqYQTB74rITk+TTv6Kkh/DpLSpTTIEjIz6auBkcU1TcRwhnd1EpPdJz
         0chkGhO9nWNZDcKABqTQ8qhonjZilzuAUZGjCOTxUXPJaA3A2K5rPqLhS29LOQ8S5vxM
         Iq0keKRq5+xe+VbJXK8f3fYpMPoO/Bla/y2Waa51VfXG1TRqcyoPJzlHXfzaSZHPtTrc
         z+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681261609; x=1683853609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/gZ6cj/6Omli4sjrZld+bXqKW2xcaRiN8ew1uF6z4Q=;
        b=5WjQlV096Oo/ZzIVxrQJ/kGcpYQm8AVtVRzqdN9Bkau/Ge8Js2nkcBHfcWOPDglbZp
         Y0dfmelEOiHUt/cxrZxJ9pcSU9jiJDXD9Clf3iDc8eOd4+WtlBSPhpsdPtfKKFFdmJ5u
         sgSTJuHqCH0i4fUZOVaoDwFr3LJuj1u6GvNEfU1G+hlB13w4ZJ0N8iXbSVYasEQtfdce
         +caaWgNe6YH0hex7n0iahmX5jTRTLjGgtkV4se3o6kXGB3LxIFoQpZndl0Z6Q6vIrVRR
         7fhy+IooCMLL0Ukzz3tLjZlNmp8bvZ6OO0rnTRwNoiS5oOKtF0BR1XuSNQvB5h8/gBAo
         Np2w==
X-Gm-Message-State: AAQBX9d4w71a1gukn2jc3Ybx1RSTYaIGE5DItAOly09X9cuaOLO6Rrcw
        ne2w05595z4oRsHASoF5ORmHJg==
X-Google-Smtp-Source: AKy350bo4WvmONxNFFnQIrtl/U3MsUQ1AvPbCr7NIx57Gv8KxdTGkpb0fgFvDk5kBTujWXmxM1wm0Q==
X-Received: by 2002:a19:c504:0:b0:4b5:8298:5867 with SMTP id w4-20020a19c504000000b004b582985867mr115362lfe.66.1681261609629;
        Tue, 11 Apr 2023 18:06:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u11-20020ac2518b000000b004d5a6dcb94fsm2781793lfi.33.2023.04.11.18.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:06:49 -0700 (PDT)
Message-ID: <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
Date:   Wed, 12 Apr 2023 04:06:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        airlied@gmail.com, andersson@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        vkoul@kernel.org, agross@kernel.org, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        sean@poorly.run, linux-kernel@vger.kernel.org
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 01:32, Abhinav Kumar wrote:
> Hi Marijn
> 
> On 4/11/2023 3:24 PM, Marijn Suijten wrote:
>> Again, don't forget to include previous reviewers in cc, please :)
>>
>> On 2023-04-11 14:09:40, Kuogee Hsieh wrote:
>>> Perform DSC range checking to make sure correct DSC is requested before
>>> reserve resource for it.

nit: reserving

>>
>> This isn't performing any range checking for resource reservations /
>> requests: this is only validating the constants written in our catalog
>> and seems rather useless.  It isn't fixing any real bug either, so the
>> Fixes: tag below seems extraneous.
>>
>> Given prior comments from Abhinav that "the kernel should be trusted",
>> we should remove this validation for all the other blocks instead.
>>
> 
> The purpose of this check is that today all our blocks in RM use the 
> DSC_* enum as the size.
> 
> struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
> 
> If the device tree ends up with more DSC blocks than the DSC_* enum, how 
> can we avoid this issue today? Not because its a bug in device tree but 
> how many static number of DSCs are hard-coded in RM.

We don't have these blocks in device tree. And dpu_hw_catalog shouldn't 
use indices outside of enum dpu_dsc.

Marijn proposed to pass struct dpu_foo_cfg directly to 
dpu_hw_foo_init(). This will allow us to drop these checks completely.

For the time being, I think it might be better to add these checks for 
DSC for the sake of uniformity.

> 
> And like you said, this is not specific to DSC. Such checks are present 
> for other blocks too.
> 
>>> Fixes: c985d7bb64ff ("drm/msm/disp/dpu1: Add DSC support in RM")
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>> index f4dda88..95e58f1 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>> @@ -1,6 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /*
>>>    * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>>    */
>>>   #define pr_fmt(fmt)    "[drm:%s] " fmt, __func__
>>> @@ -250,6 +251,11 @@ int dpu_rm_init(struct dpu_rm *rm,
>>>           struct dpu_hw_dsc *hw;
>>>           const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
>>> +        if (dsc->id < DSC_0 || dsc->id >= DSC_MAX) {
>>> +            DPU_ERROR("skip dsc %d with invalid id\n", dsc->id);
>>> +            continue;
>>> +        }
>>> +
>>>           hw = dpu_hw_dsc_init(dsc->id, mmio, cat);
>>>           if (IS_ERR_OR_NULL(hw)) {
>>>               rc = PTR_ERR(hw);
>>> @@ -557,8 +563,10 @@ static int _dpu_rm_make_reservation(
>>>       }
>>>       ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, 
>>> &reqs->topology);
>>> -    if (ret)
>>> +    if (ret) {
>>> +        DPU_ERROR("unable to find appropriate DSC\n");
>>
>> This, while a nice addition, should go in a different patch.

I'd agree here, a separate patch.

>>
>> Thanks!
>>
>> - Marijn
>>
>>>           return ret;
>>> +    }
>>>       return ret;
>>>   }
>>> -- 
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>> Forum,
>>> a Linux Foundation Collaborative Project
>>>

-- 
With best wishes
Dmitry

