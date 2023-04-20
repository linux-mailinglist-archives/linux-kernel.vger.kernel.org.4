Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D26E99BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjDTQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDTQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:41:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F6106
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:41:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8db10a5d4so6642811fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682008891; x=1684600891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Xkt+7x4DFMfvlPFqBYddaezWfldLilzaYhMnOd3cnc=;
        b=HNoBEubiUabYTEV5IbhUNgFP/QYUAxyxCXIYxRqt9x3bhsx3/xyqVFCJ7ztx4MLOTl
         yXGKrlw5QSjgXWJLBd0rAju6w2nvtNr8xQUhOws/B8i2KElfMW+U2H4e/Q9rOTWlGQmc
         xsahAWRuUj0jft37XWpsGiUtXMfH73cR7RthCNlwgncmgmFjRpg/5iuaaDmUo4DWVZvU
         YZgij8z/YgRL0FVewGxekO8y6Mgmphw03MGSKxBmxfErszSnHIkHwICFKk+iHaDXKCBh
         Y5+g7jbU+IGlXyZzjsbB0QRyuLvc4o9q3EG5ANq8/tmBO3ACfl7NVfevnWJT02qKP2n/
         nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682008891; x=1684600891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xkt+7x4DFMfvlPFqBYddaezWfldLilzaYhMnOd3cnc=;
        b=Yp8YGhnc0QOmtayw4hi9fjonukpVmrv/svWwj2m9jEr14R/YWiia/K2DOvms3OMW1S
         ZCOX8VEJRHvMlubgNbIOsF2Ax12A1Qc3T3utwoWOWnKVhZ5ogNZjVmAaOwMnZE1MbR85
         /+gWKuNG0oRkG4/nn7kZuaa6xfdZ3JVP4GRdSiRk/8Dwf5laZmWaViUe1VE0I/crakg7
         b1oYDX9N/2j/Q+PUPvN+jIXHpKw/LAs8IiJXkNCav2Mk0T1IS1ax1arDFQgujV7LE/Sh
         Rhw0vEXdQfIDZ4Zx83kutY/MnNPj3H6UOf9USHCoynQNWSKs8HgM7sJEr1SN7g6KQbZA
         W93Q==
X-Gm-Message-State: AAQBX9dw6UF6yAaU3nvBu1AhIeiuZ3V7PiOdz/OhNcEKOdGf8EJSfP6o
        wZlNC9pjhzcUotYmb+TuQBpgeQ==
X-Google-Smtp-Source: AKy350ZJGvpZGpqqpI0D88XA/fQx1PlTZaDZlGYh6HhRDuOG2CimDS/aMEswoaYw5U9GRNT31Zg2bQ==
X-Received: by 2002:ac2:5d25:0:b0:4d5:a689:7580 with SMTP id i5-20020ac25d25000000b004d5a6897580mr589859lfb.47.1682008891187;
        Thu, 20 Apr 2023 09:41:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004edb2cb3500sm261298lfh.279.2023.04.20.09.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 09:41:30 -0700 (PDT)
Message-ID: <51d953d0-bd7f-1154-0241-89a2f62967e4@linaro.org>
Date:   Thu, 20 Apr 2023 19:41:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH v3] drm/msm/dpu: always program DSC active
 bits
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
References: <1681490777-15351-1-git-send-email-quic_khsieh@quicinc.com>
 <zs762prrzv2geulwa7ztlolmxgldiyynk22m5ak4ejbyzbctrp@jprtanslko7c>
 <c2c0567a-8205-510d-bc0d-35b28dd64f70@linaro.org>
 <29df3564-ade2-fda2-1843-8438e7d01669@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <29df3564-ade2-fda2-1843-8438e7d01669@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 19:40, Abhinav Kumar wrote:
> Hi Dmitry / Marijn
> 
> On 4/20/2023 7:03 AM, Dmitry Baryshkov wrote:
>> On 15/04/2023 02:02, Marijn Suijten wrote:
>>> On 2023-04-14 09:46:17, Kuogee Hsieh wrote:
>>>> In current code, the dsc active bits are set only if the cfg->dsc is 
>>>> set.
>>>
>>> This is the old sentence from v1 again, did you accidentally send the
>>> wrong patch as the improvements from v2 are missing?
>>>
>>>> However, for displays which are hot-pluggable, there can be a use-case
>>>> of disconnecting a DSC supported sink and connecting a non-DSC sink.
>>>>
>>>> For those cases we need to clear DSC active bits during teardown.
>>>
>>> At least teardown is one word again, v2 had "tear down" which is wrong.
>>>
>>>> As discuss at [1], clear DSC active bit will handled at 
>>>> reset_intf_cfg()
>>>
>>> discussed* as pointed out by Dmitry, and make it clear that this is
>>> about clearing CTL_DSC_ACTIVE (and CTL_DSC_FLUSH?) specifically.  Once
>>> that is moved to reset_intf_cfg(), this patch should be reverted as
>>> there is no need to write the registers once again when cfg->dsc equals
>>> 0.
>>
>> Kuogee, can we please get a proper v4? With all the relevant changes 
>> from v2, with the changelog, etc.
>>
>> Otherwise the present Reviewed-by tags are just incorrect.
>>
> 
> After looking into the DPU DSC changes internally which will be posted 
> today/tomm, that piece of code is again touching this block, so I am now 
> also not convinced this change should be made right now because it was 
> again touching flush programming, so that again leaves only the active 
> bits which as Marijn mentioned will be applicable for a use-case only 
> with hot-pluggable display which we dont have till we land DP DSC.
> 
> I think this is what we will do:
> 
> -> post DPU DSC changes
> -> post the patch to improve reset_intf_cfg() to handle DSC
> -> post rest of DP DSC changes
> -> post rest of DSI DSC changes
> 
> I think that way, we all are aligned.
> 
> Apologies for posting this patch a bit ahead of time but if i had 
> foreseen that DPU DSC changes will again touch the flush code, i would 
> have held this patch back too.

Ack, sounds good. Thank you.

> 
>>>
>>> - Marijn
>>>
>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
>>>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/linux-arm-msm/ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com/
>>>> ---
>>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c 
>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>>> index bbdc95c..88e4efe 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>>> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
>>>> dpu_hw_ctl *ctx,
>>>>       if (cfg->merge_3d)
>>>>           DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>>>>                     BIT(cfg->merge_3d - MERGE_3D_0));
>>>> -    if (cfg->dsc) {
>>>> -        DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>>>> -        DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>>> -    }
>>>> +
>>>> +    DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>>>> +    DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>>>   }
>>>>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
>>>> -- 
>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>>> Forum,
>>>> a Linux Foundation Collaborative Project
>>>>
>>

-- 
With best wishes
Dmitry

