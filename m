Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0A64CD23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiLNPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiLNPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:34:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2115A06
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:34:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x28so11077387lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfLGc8H0I57r8ivKkghHG64oFuRf3tw+vOp/DqNecyU=;
        b=ghuliCB4AOFHBgRCgYCpYXDD4aY74iucshLj6KoTgMZgN4kgui0MZZcsHIwcZnnMTc
         lcaKVgruEn6Ehy8wLDIT7TraZRJAMEzrIwECsvoENj/yM7gzwGw5Azex0AIKGe5GauMj
         IEtzJ1rCjIwcgm2d0MmrbcKzrqxYH6IlFZhF0JMXAy/RuoWBqPdUHHo2MGZNB+jdUX5r
         K1SSS74hDc6a+rfyzCgUD/ZzZx/uc5s8Gneee7d6NWb/miw4s5r1wDWwaeiR+G1Uj44E
         2FdgzX6qNYtkcvnii3LnIg5jE8ZNV+C1kssYtmFFlNSFOnijnrccVzAO90+tjC0RMgg2
         x5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfLGc8H0I57r8ivKkghHG64oFuRf3tw+vOp/DqNecyU=;
        b=O8gjPr9xkxBpzbCR0QH7IwufwPBK+7eBLyz3/7XEbFPasfBJNwYepX400FCkujxmaD
         H3+pLdCfVFHbXDO69FV5EAdKx5kk7ii2nrLyV6XXlIoVhrXC9I9NzI5m9XKHEB72Ax6O
         deDuVVuBFGPyFwdmHqnfRuKiBaGpfb6KgiH5L215pevRP8+gXrVyVAnrbCZrzQGpNVKO
         zzpae0/c50AdrXCGyhaJhMzxcX64oWFiLMZSOHyoTBruyy2LYK+R4UP7oiQULMPkKNJe
         YXqsO5DeJjifyhJT/uUOz4fiRvbjyyngzsnggbXs4QlMzHEk+tSUuXx4k5RFGB3je8B3
         iwNg==
X-Gm-Message-State: ANoB5pmGZDwEeTRcuw+Ng7kBK271cgsY0Ib2EZ85JJXOzTFZRTYVW4fE
        HEuRMEbxrUSxTP1dxD8Tq64Tdg==
X-Google-Smtp-Source: AA0mqf7C/AuVssYspK9k2X1NXWgvrBfv3+9IsvXuCSjd3FHzSDdH3ELko+juNZ8p7CwXPr4P65JVNg==
X-Received: by 2002:ac2:4bd6:0:b0:4a4:68b9:60b0 with SMTP id o22-20020ac24bd6000000b004a468b960b0mr7377213lfq.59.1671032091319;
        Wed, 14 Dec 2022 07:34:51 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o8-20020a05651205c800b00494978b0caesm835069lfo.276.2022.12.14.07.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 07:34:50 -0800 (PST)
Message-ID: <7ad7654a-b0a0-c08a-d111-cd34d38c36e0@linaro.org>
Date:   Wed, 14 Dec 2022 17:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v9 01/15] drm/msm/disp/dpu: clear dpu_assign_crtc and get
 crtc from connector state instead of dpu_enc
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_aravindh@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1671012352-1825-1-git-send-email-quic_vpolimer@quicinc.com>
 <1671012352-1825-2-git-send-email-quic_vpolimer@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1671012352-1825-2-git-send-email-quic_vpolimer@quicinc.com>
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

On 14/12/2022 12:05, Vinod Polimera wrote:
> Update crtc retrieval from dpu_enc to dpu_enc connector state,
> since new links get set as part of the dpu enc virt mode set.
> The dpu_enc->crtc cache is no more needed, hence cleaning it as
> part of this change.
> 
> This patch is dependent on the series:
> https://patchwork.freedesktop.org/series/110969/
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 42 +++++++++--------------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 ------
>   3 files changed, 13 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 3f72d38..289d51e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1029,7 +1029,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   		 */
>   		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>   			release_bandwidth = true;
> -		dpu_encoder_assign_crtc(encoder, NULL);
>   	}
>   
>   	/* wait for frame_event_done completion */
> @@ -1099,9 +1098,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>   	dpu_crtc->enabled = true;
>   
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -		dpu_encoder_assign_crtc(encoder, crtc);
> -
>   	/* Enable/restore vblank irq handling */
>   	drm_crtc_vblank_on(crtc);
>   }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index a585036..b9b254d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -132,11 +132,6 @@ enum dpu_enc_rc_states {
>    * @intfs_swapped:	Whether or not the phys_enc interfaces have been swapped
>    *			for partial update right-only cases, such as pingpong
>    *			split where virtual pingpong does not generate IRQs
> - * @crtc:		Pointer to the currently assigned crtc. Normally you
> - *			would use crtc->state->encoder_mask to determine the
> - *			link between encoder/crtc. However in this case we need
> - *			to track crtc in the disable() hook which is called
> - *			_after_ encoder_mask is cleared.
>    * @connector:		If a mode is set, cached pointer to the active connector
>    * @crtc_kickoff_cb:		Callback into CRTC that will flush & start
>    *				all CTL paths
> @@ -181,7 +176,6 @@ struct dpu_encoder_virt {
>   
>   	bool intfs_swapped;
>   
> -	struct drm_crtc *crtc;
>   	struct drm_connector *connector;
>   
>   	struct dentry *debugfs_root;
> @@ -1317,7 +1311,7 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>   		struct dpu_encoder_phys *phy_enc)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
> -	unsigned long lock_flags;
> +	struct drm_crtc *crtc;
>   
>   	if (!drm_enc || !phy_enc)
>   		return;
> @@ -1325,12 +1319,13 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>   	DPU_ATRACE_BEGIN("encoder_vblank_callback");
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
>   
> -	atomic_inc(&phy_enc->vsync_cnt);
> +	if (!dpu_enc->connector || !dpu_enc->connector->state ||
> +	    !dpu_enc->connector->state->crtc)
> +		return;
>   
> -	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	if (dpu_enc->crtc)
> -		dpu_crtc_vblank_callback(dpu_enc->crtc);
> -	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> +	atomic_inc(&phy_enc->vsync_cnt);
> +	crtc = dpu_enc->connector->state->crtc;
> +	dpu_crtc_vblank_callback(crtc);
>   
>   	DPU_ATRACE_END("encoder_vblank_callback");
>   }
> @@ -1353,33 +1348,22 @@ static void dpu_encoder_underrun_callback(struct drm_encoder *drm_enc,
>   	DPU_ATRACE_END("encoder_underrun_callback");
>   }
>   
> -void dpu_encoder_assign_crtc(struct drm_encoder *drm_enc, struct drm_crtc *crtc)
> -{
> -	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> -	unsigned long lock_flags;
> -
> -	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	/* crtc should always be cleared before re-assigning */
> -	WARN_ON(crtc && dpu_enc->crtc);
> -	dpu_enc->crtc = crtc;
> -	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> -}
> -
>   void dpu_encoder_toggle_vblank_for_crtc(struct drm_encoder *drm_enc,
>   					struct drm_crtc *crtc, bool enable)
>   {
>   	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> -	unsigned long lock_flags;
> +	struct drm_crtc *new_crtc;
>   	int i;
>   
>   	trace_dpu_enc_vblank_cb(DRMID(drm_enc), enable);
>   
> -	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	if (dpu_enc->crtc != crtc) {
> -		spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> +	if (!dpu_enc->connector || !dpu_enc->connector->state)
> +		return;
> +
> +	new_crtc = dpu_enc->connector->state->crtc;
> +	if (!new_crtc || new_crtc != crtc) {

I don't like going through all the pointers and states without locks. 
The connector->state can potentially check. So, I'd propose even simpler 
solution: just store the crtc in the dpu_enc at the creation time. Then 
you can use the rest of the current dpu_enc->crtc as expected.

>   		return;
>   	}
> -	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
>   
>   	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
>   		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 7f3d823..eb9fc7c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -40,14 +40,6 @@ struct msm_display_info {
>   };
>   
>   /**
> - * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
> - * @encoder:	encoder pointer
> - * @crtc:	crtc pointer
> - */
> -void dpu_encoder_assign_crtc(struct drm_encoder *encoder,
> -			     struct drm_crtc *crtc);
> -
> -/**
>    * dpu_encoder_toggle_vblank_for_crtc - Toggles vblank interrupts on or off if
>    *	the encoder is assigned to the given crtc
>    * @encoder:	encoder pointer

-- 
With best wishes
Dmitry

