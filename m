Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34E60FF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiJ0Rkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiJ0Rkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:40:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CE5F7C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:40:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b18so4296030ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dQ5iXYypgbJC6JVuTz64YgEiNayZPBEIXcuhjY1RiA=;
        b=MUdxN8jBJLvEPpz4xRlWyHx+U+2qnlG1s2vyNGymS4IA5POKPvoEx4n8I29061lwWR
         FOXns6ZJ9464gxWK9dYzFKPTmEAihozFtmpEUqe5jhpzMlkDKggwUaBJZjphPTzvrIGX
         sJWcGp9GYAe4GNTJXaE5hlQselL5I28H6+3CfuUvSJ43oMt6uf98C4nLNS5n0Y7Btse9
         h/K6ixcbTaJmDBBo+4ZcGrU3NWVzvi3YbN2mrkF8Wf6rKg25WGdVFdo1gC8IDaMt187N
         069vQ70kpRoLR5f/9QzZZ8jaxFnlXJ48RwD8BWYyqsd7GXpw8lzG7WeC/6eGYJZmkqKo
         8COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dQ5iXYypgbJC6JVuTz64YgEiNayZPBEIXcuhjY1RiA=;
        b=yi+1NUc1TlEA5faywKZkQIYfn0SBqEA1y/Ooq0mcR227ADrkjtpVsgeibVFZps5tWt
         nsWZxxRfAoxN8MFgh5TlTtenV/ZDYWkLYmhXRY/GMDb8cuYb0gO3/Ta63/afGGsuDf5M
         HmJvQa6DeBNuuUyUt/ndDqO16fy1Y02KFFRvOXE8RPTiY+86sC7Lc7J4EgXWj6Go7pc1
         xu6yQDD7+8Q52cyZ2QALxG+8blitZ/GnwAclJIM6J//KZeUj9uxR+IQDe/Chy079eF3Z
         qsF44JVifYNFyJw5CIq5s5i1MZzU46gAH4cg9Xz7LvfES+70pVx5NZ4zCPTRMbysi/az
         h78A==
X-Gm-Message-State: ACrzQf2/YP80LKh2ZJ9/jZ8DT31OJ2v8IOimOIH4Zf5UKwLbv/kGvlqj
        fPci/18Zqth5qBhQOxacly09xg==
X-Google-Smtp-Source: AMsMyM7il5IkwmWr4mwznK/xwHIcZqOrxqV6QhIQMw5WDa6TNpHUypqnTGu3qs9hDYuZTcnPGMVQtA==
X-Received: by 2002:a05:651c:b13:b0:277:2a88:6995 with SMTP id b19-20020a05651c0b1300b002772a886995mr1748143ljr.516.1666892437114;
        Thu, 27 Oct 2022 10:40:37 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id 142-20020a2e0994000000b0027706d22878sm306643ljj.94.2022.10.27.10.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 10:40:36 -0700 (PDT)
Message-ID: <780a3aeb-2e7f-b3ca-be58-ab24bd06d805@linaro.org>
Date:   Thu, 27 Oct 2022 20:40:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v8 01/15] drm/msm/disp/dpu: clear dpu_assign_crtc and get
 crtc from connector state instead of dpu_enc
Content-Language: en-GB
To:     Vinod Polimera <vpolimer@qti.qualcomm.com>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "Vishnuvardhan Prodduturi (QUIC)" <quic_vproddut@quicinc.com>,
        "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
References: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
 <1665576159-3749-2-git-send-email-quic_vpolimer@quicinc.com>
 <52e7a83b-bd83-ba63-55f9-a75cf549546d@linaro.org>
 <BN0PR02MB8173F084DD0DDAD2E312CA6DE4339@BN0PR02MB8173.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <BN0PR02MB8173F084DD0DDAD2E312CA6DE4339@BN0PR02MB8173.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 16:34, Vinod Polimera wrote:
>> -----Original Message-----
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Sent: Monday, October 24, 2022 8:52 PM
>> To: Vinod Polimera (QUIC) <quic_vpolimer@quicinc.com>; dri-
>> devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
>> freedreno@lists.freedesktop.org; devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; robdclark@gmail.com;
>> dianders@chromium.org; swboyd@chromium.org; Kalyan Thota (QUIC)
>> <quic_kalyant@quicinc.com>; Kuogee Hsieh (QUIC)
>> <quic_khsieh@quicinc.com>; Vishnuvardhan Prodduturi (QUIC)
>> <quic_vproddut@quicinc.com>; Bjorn Andersson (QUIC)
>> <quic_bjorande@quicinc.com>; Aravind Venkateswaran (QUIC)
>> <quic_aravindh@quicinc.com>; Abhinav Kumar (QUIC)
>> <quic_abhinavk@quicinc.com>; Sankeerth Billakanti (QUIC)
>> <quic_sbillaka@quicinc.com>
>> Subject: Re: [PATCH v8 01/15] drm/msm/disp/dpu: clear dpu_assign_crtc and
>> get crtc from connector state instead of dpu_enc
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>>
>> On 12/10/2022 15:02, Vinod Polimera wrote:
>>> Update crtc retrieval from dpu_enc to dpu_enc connector state,
>>> since new links get set as part of the dpu enc virt mode set.
>>> The dpu_enc->crtc cache is no more needed, hence cleaning it as
>>> part of this change.
>>>
>>> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 42 +++++++++---------
>> -----------
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 ------
>>>    3 files changed, 13 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> index 13ce321..8ec9a13 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> @@ -1029,7 +1029,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>>>                 */
>>>                if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>>>                        release_bandwidth = true;
>>> -             dpu_encoder_assign_crtc(encoder, NULL);
>>>        }
>>>
>>>        /* wait for frame_event_done completion */
>>> @@ -1099,9 +1098,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>>>        trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>>>        dpu_crtc->enabled = true;
>>>
>>> -     drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state-
>>> encoder_mask)
>>> -             dpu_encoder_assign_crtc(encoder, crtc);
>>> -
>>>        /* Enable/restore vblank irq handling */
>>>        drm_crtc_vblank_on(crtc);
>>>    }
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index 9c6817b..d05b353 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -132,11 +132,6 @@ enum dpu_enc_rc_states {
>>>     * @intfs_swapped:  Whether or not the phys_enc interfaces have been
>> swapped
>>>     *                  for partial update right-only cases, such as pingpong
>>>     *                  split where virtual pingpong does not generate IRQs
>>> - * @crtc:            Pointer to the currently assigned crtc. Normally you
>>> - *                   would use crtc->state->encoder_mask to determine the
>>> - *                   link between encoder/crtc. However in this case we need
>>> - *                   to track crtc in the disable() hook which is called
>>> - *                   _after_ encoder_mask is cleared.
>>>     * @connector:              If a mode is set, cached pointer to the active
>> connector
>>>     * @crtc_kickoff_cb:                Callback into CRTC that will flush & start
>>>     *                          all CTL paths
>>> @@ -181,7 +176,6 @@ struct dpu_encoder_virt {
>>>
>>>        bool intfs_swapped;
>>>
>>> -     struct drm_crtc *crtc;
>>>        struct drm_connector *connector;
>>>
>>>        struct dentry *debugfs_root;
>>> @@ -1288,7 +1282,7 @@ static void dpu_encoder_vblank_callback(struct
>> drm_encoder *drm_enc,
>>>                struct dpu_encoder_phys *phy_enc)
>>>    {
>>>        struct dpu_encoder_virt *dpu_enc = NULL;
>>> -     unsigned long lock_flags;
>>> +     struct drm_crtc *crtc;
>>>
>>>        if (!drm_enc || !phy_enc)
>>>                return;
>>> @@ -1296,12 +1290,13 @@ static void dpu_encoder_vblank_callback(struct
>> drm_encoder *drm_enc,
>>>        DPU_ATRACE_BEGIN("encoder_vblank_callback");
>>>        dpu_enc = to_dpu_encoder_virt(drm_enc);
>>>
>>> -     atomic_inc(&phy_enc->vsync_cnt);
>>> +     if (!dpu_enc->connector || !dpu_enc->connector->state ||
>>> +         !dpu_enc->connector->state->crtc)
>>> +             return;
>>>
>>> -     spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
>>> -     if (dpu_enc->crtc)
>>> -             dpu_crtc_vblank_callback(dpu_enc->crtc);
>>> -     spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
>>> +     atomic_inc(&phy_enc->vsync_cnt);
>>> +     crtc = dpu_enc->connector->state->crtc;
>>> +     dpu_crtc_vblank_callback(crtc);
>>
>> So, what if the user commits the mode setting change on another CPU,
>> while we are handling the vblank callback here? Can this happen?
>>
> If user issues a commit on another CPU, it will wait in the drm_atomic_helper_swap_state
> as drm_atomic_helper_commit_hw_done which does the complete_all(&commit->hw_done)
> for the current commit didn't finish yet.

Yes. But there is no interlock between commit->hw_done and vblank IRQ 
processing, isn't it? This call happens when DPU processes the vblank 
IRQ, so nobody stops other core from swapping the encode state on 
another core.

>>>
>>>        DPU_ATRACE_END("encoder_vblank_callback");
>>>    }
>> --
>> With best wishes
>> Dmitry
> 
> Thanks,
> Vinod P.

-- 
With best wishes
Dmitry

