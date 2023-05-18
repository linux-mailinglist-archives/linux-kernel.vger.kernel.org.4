Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531B3708BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjERWkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjERWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:40:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09533E61
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:40:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso2987712e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684449620; x=1687041620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2NH++c4VhC9XWEVE5uzOsg61iCKWgGKssQQYMJ5/Ww=;
        b=MR6PaJ7ZWCYV1Br5FE3pGCk+ymATp+bNfKKJfm8GGb6QbtwINtwtK1sMG2ugMa9UFm
         L4nqRg6spkN9FwU2dPSnv4LPqNDOp9+Rt4XAwKk5gq8gV76yfCv2zeNRwm0UkBHwTu0C
         u/PWDpMhQqNgRT9TrlB+CrPiA9zDxfVgyB8+hlrjM3GebRssjaVoZ1tqPqpeyrFm9s3D
         Wuxc7pDV58duw4BB6ZkU80vaBuo9d6wy/93i9Stm/s7eVKK5Gg14t/IwL2PqSkfQRjaB
         N1OSZ5W4Lnn6rbkXKs/gX7TfAr7TbStf4JDytS7eKMSH8WbZre06qpwJfPZd6V4z6JYJ
         wjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449620; x=1687041620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2NH++c4VhC9XWEVE5uzOsg61iCKWgGKssQQYMJ5/Ww=;
        b=awmT4c60deM8xWYdQ5FCWyitAb0cnxWNzkEHq0wdre4ujwsEPDPvQ3MSmKW6/06rcZ
         HZvwSqmWUplRfcD6cwHrhlhEsBgyWVjlLPAgw/zcBYFe2OCHpwx42ME9w7TSJGFiuBW+
         IxGxq+oRDlDtHQUb0GzrK0Hy0w/NaNtAuczZL6LeCPML3eJZJy+C1tzNos3niKlRkWPA
         OAesHfhIplG+oEkAfqNoPVKcqpVR19jp1LIGBEctE5mASWiMGXKvfWm/T+kM0Sgnhrfj
         YGAvGf1G9F93C/ZN/avYwRC2icuIVXK6nvlms8o5Y8uX+7joSbcSZn+b68Y19dwZbyIc
         WSKQ==
X-Gm-Message-State: AC+VfDxVPZh5h4Cb4vKi275nHeCIuYGMDOvtuOz8ILhlMmS7IOG7uw/z
        RlBzf0FaGJ0lS9QzG5bLODXUPA==
X-Google-Smtp-Source: ACHHUZ4rOh18fVzYdVv7xzcUnLRINIeOIj4YN1jogDWq7DlSgW85yFdMNrqXWQMZSN+vB2XLFFpJwg==
X-Received: by 2002:ac2:4315:0:b0:4d5:a689:7580 with SMTP id l21-20020ac24315000000b004d5a6897580mr140353lfh.47.1684449620186;
        Thu, 18 May 2023 15:40:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u9-20020ac248a9000000b004f00189e1dasm385760lfg.143.2023.05.18.15.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 15:40:19 -0700 (PDT)
Message-ID: <b2fcc9f5-ca11-ab87-e40b-9c6d2662325b@linaro.org>
Date:   Fri, 19 May 2023 01:40:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 6/8] drm/msm/dpu: separate DSC flush update out of
 interface
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
 <1684360919-28458-7-git-send-email-quic_khsieh@quicinc.com>
 <evkla3rkf4tge6gln4lgtulj7q5gt6vef3i2yqupc5lj2oszfx@7ttyxzlmvet5>
 <8e9feb23-a5f0-7cd8-ebff-8e9097ff0ca1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8e9feb23-a5f0-7cd8-ebff-8e9097ff0ca1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 01:09, Kuogee Hsieh wrote:
> 
> On 5/17/2023 3:31 PM, Marijn Suijten wrote:
>>
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>>> @@ -139,6 +139,11 @@ static inline void 
>>> dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
>>>                   CTL_DSPP_n_FLUSH(dspp - DSPP_0),
>>>                   ctx->pending_dspp_flush_mask[dspp - DSPP_0]);
>>>           }
>>> +
>>> +    if (ctx->pending_flush_mask & BIT(DSC_IDX))
>>> +        DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH,
>>> +                  ctx->pending_dsc_flush_mask);
>> Again, when do we reset this mask to 0?  (v8 review)
> 
> can not find it.
> 
> let me add a separate  patch to fix this.

The pending_dsc_flush_mask was added in this patch, so the reset should 
be a part of this patch too.

> 
>>
>>> +
>>>       DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, ctx->pending_flush_mask);
>>>   }
>>> @@ -285,6 +290,13 @@ static void 
>>> dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
>>>       ctx->pending_flush_mask |= BIT(MERGE_3D_IDX);
>>>   }
>>> +static void dpu_hw_ctl_update_pending_flush_dsc_v1(struct dpu_hw_ctl 
>>> *ctx,
>>> +                           enum dpu_dsc dsc_num)
>>> +{
>>> +    ctx->pending_dsc_flush_mask |= BIT(dsc_num - DSC_0);
>>> +    ctx->pending_flush_mask |= BIT(DSC_IDX);
>>> +}
>>> +
>>>   static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl 
>>> *ctx,
>>>       enum dpu_dspp dspp, u32 dspp_sub_blk)
>>>   {
>>> @@ -502,9 +514,6 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
>>> dpu_hw_ctl *ctx,
>>>       if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
>>>           mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
>>> -    if (cfg->dsc)
>>> -        DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH, cfg->dsc);
>>> -
>>>       if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
>>>           mode_sel |= BIT(17);
>>> @@ -524,10 +533,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
>>> dpu_hw_ctl *ctx,
>>>       if (cfg->merge_3d)
>>>           DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>>>                     BIT(cfg->merge_3d - MERGE_3D_0));
>>> -    if (cfg->dsc) {
>>> -        DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>> Again, this bugfix of now wrapping DSC_IDX in BIT() should go in a
>> separate Fixes: patch to have this semantic change documented.  (v8
>> review)
> That will be this patch. let me add Fixes at this patch

_separate_ patch.

>>
>>> +
>>> +    if (cfg->dsc)
>>>           DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>> -    }
>>>   }
>>>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
>>> @@ -630,6 +638,8 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops 
>>> *ops,
>>>           ops->update_pending_flush_merge_3d =
>>>               dpu_hw_ctl_update_pending_flush_merge_3d_v1;
>>>           ops->update_pending_flush_wb = 
>>> dpu_hw_ctl_update_pending_flush_wb_v1;
>>> +        ops->update_pending_flush_dsc =
>>> +            dpu_hw_ctl_update_pending_flush_dsc_v1;
>>>       } else {
>>>           ops->trigger_flush = dpu_hw_ctl_trigger_flush;
>>>           ops->setup_intf_cfg = dpu_hw_ctl_intf_cfg;
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
>>> index 6292002..d5f3ef8 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
>>> @@ -158,6 +158,15 @@ struct dpu_hw_ctl_ops {
>>>           enum dpu_dspp blk, u32 dspp_sub_blk);
>>>       /**
>>> +     * OR in the given flushbits to the cached pending_(dsc_)flush_mask
>>> +     * No effect on hardware
>>> +     * @ctx: ctl path ctx pointer
>>> +     * @blk: interface block index
>>> +     */
>>> +    void (*update_pending_flush_dsc)(struct dpu_hw_ctl *ctx,
>>> +        enum dpu_dsc blk);
>>> +
>>> +    /**
>>>        * Write the value of the pending_flush_mask to hardware
>>>        * @ctx       : ctl path ctx pointer
>>>        */
>>> @@ -229,6 +238,9 @@ struct dpu_hw_ctl_ops {
>>>    * @pending_flush_mask: storage for pending ctl_flush managed via ops
>>>    * @pending_intf_flush_mask: pending INTF flush
>>>    * @pending_wb_flush_mask: pending WB flush
>> The above is all capitalized, so...:
>>
>>> + * @pending_merge_3d_flush_mask: pending merge_3d flush
>> MERGE_3D?
>>
>>> + * @pending_dspp_flush_mask: pending dspp flush
>> DSPP
>>
>>> + * @pending_dsc_flush_mask: pending dsc flush
>> DSC
>>
>> - Marijn
>>
>>>    * @ops: operation list
>>>    */
>>>   struct dpu_hw_ctl {
>>> @@ -245,6 +257,7 @@ struct dpu_hw_ctl {
>>>       u32 pending_wb_flush_mask;
>>>       u32 pending_merge_3d_flush_mask;
>>>       u32 pending_dspp_flush_mask[DSPP_MAX - DSPP_0];
>>> +    u32 pending_dsc_flush_mask;
>>>       /* ops */
>>>       struct dpu_hw_ctl_ops ops;
>>> -- 
>>> 2.7.4
>>>

-- 
With best wishes
Dmitry

