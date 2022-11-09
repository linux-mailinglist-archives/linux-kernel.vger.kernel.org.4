Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68F6622BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKIMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKIMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:47:23 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368892CDC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:47:21 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d3so25603631ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaG7nxdQlrF0Gfd1lgG+gaQR/Ksch3wgDZc+ACCQybs=;
        b=CV/6BLccRRxz1fMV6d71Hqkm81Jl7O0wkIFeIsSEJeRo/EHa+8kjYzkNNwb4zNAmUJ
         4478NsYDUQy7czthe8MOb6jPcfE7+3Bbs6x7570GOxw9LWDFqFui/XJ6OdWsjAowYyh2
         SeocY93xVPpWmV31+275kvGB5UU25EiyAgkcw5dRKqd1jJ+ghJifQD7thdlhVFtN1mrv
         2a0uZLbU3632/MES59RnuEBi49aYVxnOJDbiTPX0bEvNkNw1uHet3wg/3/GQkJB99GXP
         kp14Olq41T8FSwMc4ptvZFkH4Y85HoEoIZJFPKtoRdtC/TICmTItdpOOr3GlHw7qGaE9
         ZjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaG7nxdQlrF0Gfd1lgG+gaQR/Ksch3wgDZc+ACCQybs=;
        b=J6S4G2DevSITs6/tBrzrAkNNAhfs0i5AHBxy0ylWrFUuSuKrTZUAfImm7Dwat4liJr
         j8yrdW47mKiJ0XZiYWXlM++tLkXas4XsLsbOf0CEyarTbhXkPrv0cqsfqP1A/0CN66gi
         xLDqykLZRiLLl12hSGb6E/KFHhL6UV60kL7hlR42if/e7P3VlRUeQNr/N2bIWTnWtkvK
         uUyYGxuhot4qqyMEGK8iTITxHVQ5Byqb/yO/kDEsjAiEf+cc4WHE0PXXOdu7nt9NclYQ
         x2NLEbqAA8MVpAUaC24DuY6yuWwTz9CvNTGLeIslgRMskR8L2mCxDaadtTqolHG0Ru5y
         PhsA==
X-Gm-Message-State: ACrzQf0+hFFQ8htuo27P/asn3Srd1Er0zyt+EXpDzzX3Q6dG1frZHYMe
        FkQHhcBkB9jSg9hICKorqPyjVZF/ynpZTaFJ
X-Google-Smtp-Source: AMsMyM6S/lmxxN+LmAUhn8rewJTmcVirJBnMPoiFJBu/8xfsWqSdmNqS+3DF5PsnXZbnW+5NTUMLxQ==
X-Received: by 2002:a05:651c:1c3:b0:26f:a855:c415 with SMTP id d3-20020a05651c01c300b0026fa855c415mr7623181ljn.443.1667998039560;
        Wed, 09 Nov 2022 04:47:19 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m6-20020a0565120a8600b004b373f61a60sm2101939lfu.96.2022.11.09.04.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 04:47:19 -0800 (PST)
Message-ID: <7fe94a47-83af-b362-47a5-6900a800c3cb@linaro.org>
Date:   Wed, 9 Nov 2022 15:47:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 4/4] drm/msm/disp/dpu1: add color management support for
 the crtc
Content-Language: en-GB
To:     Kalyan Thota <kalyant@qti.qualcomm.com>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robdclark@chromium.org" <robdclark@chromium.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
References: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
 <1667996206-4153-4-git-send-email-quic_kalyant@quicinc.com>
 <7dedd020-179d-ba40-f97e-6560326fc421@linaro.org>
 <BN0PR02MB81423107545EBE0D19213ACF963E9@BN0PR02MB8142.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <BN0PR02MB81423107545EBE0D19213ACF963E9@BN0PR02MB8142.namprd02.prod.outlook.com>
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

On 09/11/2022 15:39, Kalyan Thota wrote:
> 
> 
>> -----Original Message-----
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Sent: Wednesday, November 9, 2022 6:02 PM
>> To: Kalyan Thota (QUIC) <quic_kalyant@quicinc.com>; dri-
>> devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
>> freedreno@lists.freedesktop.org; devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; robdclark@chromium.org;
>> dianders@chromium.org; swboyd@chromium.org; Vinod Polimera (QUIC)
>> <quic_vpolimer@quicinc.com>; Abhinav Kumar (QUIC)
>> <quic_abhinavk@quicinc.com>
>> Subject: Re: [PATCH 4/4] drm/msm/disp/dpu1: add color management support
>> for the crtc
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>>
>> On 09/11/2022 15:16, Kalyan Thota wrote:
>>> Add color management support for the crtc provided there are enough
>>> dspps that can be allocated from the catalogue
>>>
>>> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 15 ++++++--
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  6 ++++
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 +++---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 53
>> +++++++++++++++++++++++++++++
>>>    4 files changed, 77 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> index 4170fbe..6bd3a64 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>> @@ -18,9 +18,11 @@
>>>    #include <drm/drm_flip_work.h>
>>>    #include <drm/drm_framebuffer.h>
>>>    #include <drm/drm_mode.h>
>>> +#include <drm/drm_mode_object.h>
>>>    #include <drm/drm_probe_helper.h>
>>>    #include <drm/drm_rect.h>
>>>    #include <drm/drm_vblank.h>
>>> +#include "../../../drm_crtc_internal.h"
>>
>> If it's internal, it is not supposed to be used by other parties, including the msm
>> drm. At least a comment why you are including this file would be helpful.
>>
> This header file was included to make use of " drm_mode_obj_find_prop_id" function from DRM framework.
> Should I add a comment near function definition ?

No, it would have been better to add a comment near the #include 
directive. However if this is the only user, you don't need it at all. 
You see, you know whether the CRTC has color management propreties at 
the time of creation. And this can not change. So, you just add a 
boolean to dpu_crtc (or dpu_crtc_state, whichever suits better).

>>>
>>>    #include "dpu_kms.h"
>>>    #include "dpu_hw_lm.h"
>>> @@ -553,6 +555,17 @@ static void _dpu_crtc_complete_flip(struct drm_crtc
>> *crtc)
>>>        spin_unlock_irqrestore(&dev->event_lock, flags);
>>>    }
>>>
>>> +bool dpu_crtc_has_color_enabled(struct drm_crtc *crtc) {
>>> +     u32 ctm_id = crtc->dev->mode_config.ctm_property->base.id;
>>> +     u32 gamma_id = crtc->dev->mode_config.gamma_lut_property->base.id;
>>> +     u32 degamma_id =
>>> +crtc->dev->mode_config.degamma_lut_property->base.id;
>>> +
>>> +     return !!(drm_mode_obj_find_prop_id(&crtc->base, ctm_id) ||
>>> +                drm_mode_obj_find_prop_id(&crtc->base, gamma_id) ||
>>> +                drm_mode_obj_find_prop_id(&crtc->base, degamma_id));
>>> +}
>>> +
>>>    enum dpu_intf_mode dpu_crtc_get_intf_mode(struct drm_crtc *crtc)
>>>    {
>>>        struct drm_encoder *encoder;
>>> @@ -1604,8 +1617,6 @@ struct drm_crtc *dpu_crtc_init(struct drm_device
>>> *dev, struct drm_plane *plane,
>>>
>>>        drm_crtc_helper_add(crtc, &dpu_crtc_helper_funcs);
>>>
>>> -     drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
>>> -
>>>        /* save user friendly CRTC name for later */
>>>        snprintf(dpu_crtc->name, DPU_CRTC_NAME_SIZE, "crtc%u",
>>> crtc->base.id);
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
>>> index 539b68b..8bac395 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
>>> @@ -300,4 +300,10 @@ static inline enum dpu_crtc_client_type
>> dpu_crtc_get_client_type(
>>>        return crtc && crtc->state ? RT_CLIENT : NRT_CLIENT;
>>>    }
>>>
>>> +/**
>>> + * dpu_crtc_has_color_enabled - check if the crtc has color
>>> +management enabled
>>> + * @crtc: Pointer to drm crtc object
>>> + */
>>> +bool dpu_crtc_has_color_enabled(struct drm_crtc *crtc);
>>> +
>>>    #endif /* _DPU_CRTC_H_ */
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> index 4c56a16..ebc3f25 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>> @@ -545,7 +545,8 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder
>> *drm_enc)
>>>    static struct msm_display_topology dpu_encoder_get_topology(
>>>                        struct dpu_encoder_virt *dpu_enc,
>>>                        struct dpu_kms *dpu_kms,
>>> -                     struct drm_display_mode *mode)
>>> +                     struct drm_display_mode *mode,
>>> +                     struct drm_crtc *crtc)
>>>    {
>>>        struct msm_display_topology topology = {0};
>>>        int i, intf_count = 0;
>>> @@ -573,11 +574,9 @@ static struct msm_display_topology
>> dpu_encoder_get_topology(
>>>        else
>>>                topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT)
>>> ? 2 : 1;
>>>
>>> -     if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
>>> -             if (dpu_kms->catalog->dspp &&
>>> -                     (dpu_kms->catalog->dspp_count >= topology.num_lm))
>>> +     if (dpu_crtc_has_color_enabled(crtc) &&
>>> +             (dpu_kms->catalog->dspp_count >= topology.num_lm))
>>
>> See the comment to the previous patch. It still applies here.
>>
>>>                        topology.num_dspp = topology.num_lm;
>>> -     }
>>>
>>>        topology.num_enc = 0;
>>>        topology.num_intf = intf_count;
>>> @@ -643,7 +642,7 @@ static int dpu_encoder_virt_atomic_check(
>>>                }
>>>        }
>>>
>>> -     topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode);
>>> +     topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode,
>>> + crtc_state->crtc);
>>>
>>>        /* Reserve dynamic resources now. */
>>>        if (!ret) {
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> index 552a89c..47a73fa 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/dma-buf.h>
>>>    #include <linux/of_irq.h>
>>>    #include <linux/pm_opp.h>
>>> +#include <linux/bitops.h>
>>>
>>>    #include <drm/drm_crtc.h>
>>>    #include <drm/drm_file.h>
>>> @@ -537,6 +538,44 @@ static void dpu_kms_wait_flush(struct msm_kms
>> *kms, unsigned crtc_mask)
>>>                dpu_kms_wait_for_commit_done(kms, crtc);
>>>    }
>>>
>>> +/**
>>> + * _dpu_kms_possible_dspps - Evaluate how many dspps pairs can be
>> facilitated
>>> +                             to enable color features for crtcs.
>>> + * @dpu_kms:    Pointer to dpu kms structure
>>> + * Returns:     count of dspp pairs
>>> + *
>>> + * Baring single entry, if atleast 2 dspps are available in the
>>> +catalogue,
>>> + * then color can be enabled for that crtc  */ static inline u32
>>> +_dpu_kms_possible_dspps(struct dpu_kms *dpu_kms) {
>>> +
>>> +     u32 num_dspps = dpu_kms->catalog->dspp_count;
>>> +
>>> +     if (num_dspps > 1)
>>> +             num_dspps =
>>> +                     !(num_dspps % 2) ? num_dspps / 2 : (num_dspps -
>>> + 1) / 2;
>>
>> Ugh. No. Please spell this clearly rather than using nice math and ternary
>> operators:
>>
>> if (num_dspps <= 1)
>>    return num_dspps;
>> else
>>    return num_dspps / 2;
>>
>> You see, if num_dspps %2 ! =0, then num_dspps / 2 == (num_dspps_2 - 1) / 2.
>>
>>
>>> +
>>> +     return num_dspps;
>>> +}
>>> +
>>> +static u32 _dpu_kms_attach_color(struct drm_device *dev, u32 enc_mask,
>>> +                                             u32 num_dspps) {
>>> +     struct drm_encoder *encoder;
>>> +     struct drm_crtc *crtc;
>>> +
>>> +     drm_for_each_encoder_mask(encoder, dev, enc_mask) {
>>> +             crtc = drm_crtc_from_index(dev, ffs(encoder->possible_crtcs) - 1);
>>> +             if (num_dspps && crtc) {
>>> +                     drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
>>> +                     num_dspps--;
>>
>> Please.  You can do this at the time you create the crtc. It would be much simpler.
>>
>>> +             }
>>> +     }
>>> +
>>> +     return num_dspps;
>>> +}
>>> +
>>>    static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>>>                                    struct msm_drm_private *priv,
>>>                                    struct dpu_kms *dpu_kms) @@ -747,6
>>> +786,8 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>>>
>>>        int primary_planes_idx = 0, cursor_planes_idx = 0, i, ret;
>>>        int max_crtc_count;
>>> +     u32 num_dspps, primary_enc_mask = 0, external_enc_mask = 0;
>>> +
>>>        dev = dpu_kms->dev;
>>>        priv = dev->dev_private;
>>>        catalog = dpu_kms->catalog;
>>> @@ -796,6 +837,7 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms
>> *dpu_kms)
>>>        }
>>>
>>>        max_crtc_count = min(max_crtc_count, primary_planes_idx);
>>> +     num_dspps = _dpu_kms_possible_dspps(dpu_kms);
>>>
>>>        /* Create one CRTC per encoder */
>>>        encoder = list_first_entry(&(dev)->mode_config.encoder_list,
>>> @@ -808,9 +850,20 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms
>> *dpu_kms)
>>>                }
>>>                priv->crtcs[priv->num_crtcs++] = crtc;
>>>                encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
>>> +
>>> +             if (!dpu_encoder_is_external(encoder) &&
>>> +                     !dpu_encoder_is_virtual(encoder))
>>
>> if (dpu_encoder_internal_output(encoder))
>>
>>> +                     primary_enc_mask |= drm_encoder_mask(encoder);
>>> +             else if (dpu_encoder_is_external(encoder))
>>> +                     external_enc_mask |= drm_encoder_mask(encoder);
>>> +
>>>                encoder = list_next_entry(encoder, head);
>>>        }
>>>
>>> +     /* Prefer Primary encoders in registering for color support */
>>> +     num_dspps = _dpu_kms_attach_color(dev, primary_enc_mask,
>> num_dspps);
>>> +     num_dspps = _dpu_kms_attach_color(dev, external_enc_mask,
>>> + num_dspps);
>>> +
>>>        return 0;
>>>    }
>>>
>>
>> --
>> With best wishes
>> Dmitry
> 

-- 
With best wishes
Dmitry

