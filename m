Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4995B7911
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiIMSDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiIMSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:03:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01FAC241
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:05:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a14so13049022ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0bxp6hNrUjHVu4W7ufSFgy6cP2H5FskMpd1yOimiPWg=;
        b=dY79twjuPvugM7eWETA+EpE0kULwh0GFfCH1tdN4oQBrfyh6q+tgQwWNFsHgKofuT3
         EwaTPFY2ap/r0xWE2exiwLYKUrU0FJbWaE4I0UMBmqY+yTLGle2ht0P4/0DGH4bKxfnw
         F+RKiXGY3nq/jnbNzhME0Xs6tH4C6yyfnXNgaAdAFtXsVfKsES9Xs4FqOwdxtXA2fSUC
         xoxG7YVZiz0oTzbTJsbEpKKQ5AKetwnC8OLfTxCMFM/r6O6Zaj8VBrob6eqSaLekwI4+
         Su0zgaY96w3jEZPh9qX+h8EAy4sTpuhqGnLEnhr0fmk7R2DBGDt6bURFzDVncGbqwgjb
         EeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0bxp6hNrUjHVu4W7ufSFgy6cP2H5FskMpd1yOimiPWg=;
        b=v7Au91Ywh2C3uuWY8n6MdRoRCBF4HiwVTdgi62Nnfy9gyGuJBSzEqWZuddl/gg36X2
         Om7mqHthgCCeUg61GLa0i65KM2J0CwmqCeiFaWJRNSWbEIoe9C7EOlkVSei/7OlGTGhE
         dy+dvuSYIg++lqjQMK4ni74KDdR9+1WsnXMbbgQDQueXyHBv3FegnRXpXbb/d27aPEh9
         vkFezRfWmtE3uMPI9HJ2RSJv2JxSXZOqmxPMQZFQcc7kRTLtl1OtNUT9YLAxBmG/wCRc
         eS/sgNNLQDWKuXpxv6XSlQb8kA9CTyjuAa2MeusN1wzMlMRZus58sa0tytn0T1Atz3Eb
         k5eA==
X-Gm-Message-State: ACgBeo0iI/sHXU2PpRHkeimBsKtENRsg7IWviDa5xJb3lf+pUfpnDxo9
        Ti6TNnWcQeqJEemrlst9bqwJsxk2QJ3hzQ==
X-Google-Smtp-Source: AA6agR5HTAPr/LytqTSb2kEVLh8Bwkpebu6Hm6rMn+9W60ZtaWJkPyNijMNR1ajVbW5ZpkkrlVc0zA==
X-Received: by 2002:a2e:bba2:0:b0:26b:e4ba:851d with SMTP id y34-20020a2ebba2000000b0026be4ba851dmr6805818lje.45.1663088736707;
        Tue, 13 Sep 2022 10:05:36 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512358200b0049d0a98f73csm148035lfr.154.2022.09.13.10.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:05:36 -0700 (PDT)
Message-ID: <8fcfaf60-6886-bd6b-67a5-0f42b967a6fa@linaro.org>
Date:   Tue, 13 Sep 2022 20:05:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v7 01/15] drm/msm/disp/dpu: clear dpu_assign_crtc and get
 crtc from connector state instead of dpu_enc
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_aravindh@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1663080676-12936-1-git-send-email-quic_vpolimer@quicinc.com>
 <1663080676-12936-2-git-send-email-quic_vpolimer@quicinc.com>
 <fc45b986-99ae-b63d-9ed4-0ca622b16a8f@linaro.org>
In-Reply-To: <fc45b986-99ae-b63d-9ed4-0ca622b16a8f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 20:04, Dmitry Baryshkov wrote:
> On 13/09/2022 17:51, Vinod Polimera wrote:
>> Update crtc retrieval from dpu_enc to dpu_enc connector state,
>> since new links get set as part of the dpu enc virt mode set.
>> The dpu_enc->crtc cache is no more needed, hence cleaning it as
>> part of this change.
>>
>> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ----
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 35 
>> ++++++++++++-----------------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 -------
>>   3 files changed, 14 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> index 13ce321..8ec9a13 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>> @@ -1029,7 +1029,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>>            */
>>           if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>>               release_bandwidth = true;
>> -        dpu_encoder_assign_crtc(encoder, NULL);
>>       }
>>       /* wait for frame_event_done completion */
>> @@ -1099,9 +1098,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>>       trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>>       dpu_crtc->enabled = true;
>> -    drm_for_each_encoder_mask(encoder, crtc->dev, 
>> crtc->state->encoder_mask)
>> -        dpu_encoder_assign_crtc(encoder, crtc);
>> -
>>       /* Enable/restore vblank irq handling */
>>       drm_crtc_vblank_on(crtc);
>>   }
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 9c6817b..0c7d8b5 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -132,11 +132,6 @@ enum dpu_enc_rc_states {
>>    * @intfs_swapped:    Whether or not the phys_enc interfaces have 
>> been swapped
>>    *            for partial update right-only cases, such as pingpong
>>    *            split where virtual pingpong does not generate IRQs
>> - * @crtc:        Pointer to the currently assigned crtc. Normally you
>> - *            would use crtc->state->encoder_mask to determine the
>> - *            link between encoder/crtc. However in this case we need
>> - *            to track crtc in the disable() hook which is called
>> - *            _after_ encoder_mask is cleared.
>>    * @connector:        If a mode is set, cached pointer to the active 
>> connector
>>    * @crtc_kickoff_cb:        Callback into CRTC that will flush & start
>>    *                all CTL paths
>> @@ -181,7 +176,6 @@ struct dpu_encoder_virt {
>>       bool intfs_swapped;
>> -    struct drm_crtc *crtc;
>>       struct drm_connector *connector;
>>       struct dentry *debugfs_root;
>> @@ -1288,6 +1282,7 @@ static void dpu_encoder_vblank_callback(struct 
>> drm_encoder *drm_enc,
>>           struct dpu_encoder_phys *phy_enc)
>>   {
>>       struct dpu_encoder_virt *dpu_enc = NULL;
>> +    struct drm_crtc *crtc;
>>       unsigned long lock_flags;
>>       if (!drm_enc || !phy_enc)
>> @@ -1298,9 +1293,14 @@ static void dpu_encoder_vblank_callback(struct 
>> drm_encoder *drm_enc,
>>       atomic_inc(&phy_enc->vsync_cnt);
>> +    if (!dpu_enc->connector || !dpu_enc->connector->state)
>> +        return;
>> +
>> +    crtc = dpu_enc->connector->state->crtc;
>> +
>>       spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
>> -    if (dpu_enc->crtc)
>> -        dpu_crtc_vblank_callback(dpu_enc->crtc);
>> +    if (crtc)
>> +        dpu_crtc_vblank_callback(crtc);
>>       spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> 
> Stephen's comment about reading the state from outside of the lock and 
> then using local variable under spinlock is still valid. Moreover I'm 
> not sure that enc_spinlock protects connector's state. I'd say one has 
> to take the modesetting lock here.

s/Stephen's/Doug's/

-- 
With best wishes
Dmitry

