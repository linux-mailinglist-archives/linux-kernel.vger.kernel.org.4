Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2BB6DE816
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDKXg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDKXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:36:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F6359A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:36:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o1so12493433lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681256211; x=1683848211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ag98VDnesjpE6B2VMaKVp7ad/hfCE90TCy19DFDfwkE=;
        b=kbGMG6dbKpVTDvyMyxAoTI0I+HcDn/bdbe/1sPPtRDDNd+KXWWXdQ1jwtSeIf9Cg1n
         /4tZDwU+/g0pMM7SrTadQItmj2L42pVyy+SfAo7hJTFykpIjxz2zyz0HZMEk5d+s0BL1
         qQIUe0OtM+TEum2SENwGGa0MlJkrjR3Xx9z/znHanyT457MNsd+UOR0jYK5cpPrmHnm8
         eR2ykjAylyuJNwvtL6V8Qk1jen4eroIMHuykDhtznfzAQdmZHDfTeKLinU6ZI3FlxllZ
         xLllS9dQit+MnNv6/qM5NhSkG7a7A3Q4HuPPaTc/emRHKSigfe+ayr+pNBErEcywlHFP
         WyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681256211; x=1683848211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag98VDnesjpE6B2VMaKVp7ad/hfCE90TCy19DFDfwkE=;
        b=M876DDsdT/wqicyYvfzY2FY5BRuy8o5qMRqbpmihwEKZV1HRC2WbgDAZOoR4MChhae
         BTi5Y6zdvXa7LBe0qcHZ2SKMw8pT9lSEe4kqkTNirxGyVCU52ZivHsSIxN6u4GHhvZiG
         ZogrxMVP0e7BKI5sJX6fbnf/+keBEU0qHnXbxkQSc9bli6Uz3WS/cVy5XQgQh4WVmOjK
         lVKjFYNSfH60yyJQdPZucK2Jz/2EzMf+T5/ihlrMXz6n+/C0dJvmg2VSZXbmMPUSsgIQ
         z8k+AoqkQZ393evh0XlZf+fWIGBKUPYXVxhMwy2xH2nIBtwOi2zHuVZ78Xzt/nD2N/9c
         Z2eA==
X-Gm-Message-State: AAQBX9fRlAtSAqH8iAHGQEv3TcKVLqgsLlc6rHTvrW+XzfsNQsrCtWrf
        LiD3yK4xo7YltwjaD1liDfxoDA==
X-Google-Smtp-Source: AKy350ZEQ4Aav596NSo121H1kTUDKoj9CskwA1FOrLea+Zo3UABdxx/BQnXIEZuqTOoK3Ve8a8v7LQ==
X-Received: by 2002:ac2:561b:0:b0:4ea:e628:356f with SMTP id v27-20020ac2561b000000b004eae628356fmr65661lfd.48.1681256211037;
        Tue, 11 Apr 2023 16:36:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l12-20020ac2430c000000b004eb0c51780bsm2742297lfh.29.2023.04.11.16.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 16:36:50 -0700 (PDT)
Message-ID: <c0161f2b-b8cb-4dd3-8cec-a2dba40ff924@linaro.org>
Date:   Wed, 12 Apr 2023 02:36:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/dpu: always program dsc active bits
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1681247095-1201-1-git-send-email-quic_khsieh@quicinc.com>
 <30585d08-88ca-e3a9-6f83-128d49d1d1fc@linaro.org>
 <ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 02:32, Abhinav Kumar wrote:
> 
> 
> On 4/11/2023 3:17 PM, Dmitry Baryshkov wrote:
>> On 12/04/2023 00:04, Kuogee Hsieh wrote:
>>> In current code, the dsc active bits are set only if the cfg->dsc is 
>>> set.
>>> However, for displays which are hot-pluggable, there can be a use-case
>>> of disconnecting a DSC supported sink and connecting a non-DSC sink.
>>>
>>> For those cases we need to clear DSC active bits during teardown.
>>
>> Please correct me if I'm wrong here, shouldn't we start using 
>> reset_intf_cfg() during teardown / unplug?
>>
> 
> This is actually a good point. Since PSR landed this cycle, we are doing 
> dpu_encoder_helper_phys_cleanup() even for video mode path,
> 
> 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine 
> disable")
> 
> I was doing it only for writeback path as I had not validated video mode 
> enough with the dpu_encoder_helper_phys_cleanup() API.
> 
> But looking closely, I think there is an issue with the flush logic in 
> that API for video mode.
> 
> The reset API, calls a ctl->ops.trigger_flush(ctl); but its getting 
> called after timing engine turns off today so this wont take any effect.
> 
> We need to improve that API and add the missing pieces for it to work 
> correctly with video mode and re-validate the issue for which PSR made 
> that change. So needs more work there.
> 
> This change works because the timing engine is enabled right after this 
> call and will trigger the flush with it.
> 
> The only drawback of this change is DSC_ACTIVE will always get written 
> to either with 0 or the right value but only once during enable.
> 
> I think this change is fine till we finish the rest of the pieces. We 
> can add the if (cfg->dsc) back to this when we fix the reset_intf_cfg() 
> to handle DSC and dpu_encoder_helper_phys_cleanup() to handle flush 
> correctly.

I'd agree here. Then a FIXME comment would be nice.

> 
> I will take up that work.
> 
>>>
>>> Fixes: ede3c6bb00c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>> index bbdc95c..88e4efe 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
>>> dpu_hw_ctl *ctx,
>>>       if (cfg->merge_3d)
>>>           DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>>>                     BIT(cfg->merge_3d - MERGE_3D_0));
>>> -    if (cfg->dsc) {
>>> -        DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>>> -        DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>> -    }
>>> +
>>> +    DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>>> +    DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>>   }
>>>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
>>

-- 
With best wishes
Dmitry

