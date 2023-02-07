Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF2368DCE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBGPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBGPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:22:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5BA247
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:22:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so43884210ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmKreYHl45MP4CU2KzjwVDdBhFwg72ubrDPfs/uyokA=;
        b=IweP5CWPri1PXMNSLhrYrkaBE7WKdv+buUB6plO6mbOkgod7RRXub/aD5gmOU85LpM
         jEZ2KwiNW2+gnKt6FLE5RVyuap1ue2SjTGvzseIKVkkkFsH0F9dQzJbPwmi71TDszz+s
         WmU6Xg4E9AjufROLCGsjlpV8ZJlx/lpom0AXSIxsFo7SNu1M0lyDyWDQVZrsNX2H+wUn
         WBiCU8I7QGJrDvekvo+EN7ZgWhFiPHhWuLXC6sG8IZeFPH9qcZwOfUZbejDyLSJ/llSx
         Ff12kpV0XIpb3n0pGa46MdPnBQf+4z2kv31NrhXcd84xm8OqmEBR7gk/zSKcmzs5slfW
         mnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmKreYHl45MP4CU2KzjwVDdBhFwg72ubrDPfs/uyokA=;
        b=JH5soJA/i/mk13GSgEGao/HUIbTW7L/TTkJD/t0Nzsdz2lDj7Rluf2fM9p1FKySqJ3
         YvEBVp2+anSNCuMWNZ3TtHl8gsyDR7dNWc4ukPZH9HZOhGoZfdIqqCF8BCOseiPnJ29v
         ec75u0cyxG4eDFnl3F4zZDjuV6HMl8oF4KwsYk4q9a6rL/NW3oEmP/jXWwNMnLJJxg9Z
         DqfAnwZIz/9/8KplZchhaQb6vk1wNwYB8utvVk+/AejiB1w6pwVLlahqjNSP8b/eGzFC
         cnRloLGROf3Kgr+04KijrQknAA248dW/uka7amYYTbFwhRNTMc6BXmkbV+Ve6hcykX5a
         VDtA==
X-Gm-Message-State: AO0yUKWqeLl9xdVYjJ4DZ1IKHq+JaYV07Iov3U645BsK9X3GhWCviywC
        NggLjd5WDNv17dWOjIWAQB/PKQ==
X-Google-Smtp-Source: AK7set/jtYcWngVyUZ46lI8iUJ3ztOzCruwjq9oAGDSXgFwNqZ9bJGwM4/lk3+8vd6X951gIRWBipQ==
X-Received: by 2002:a17:907:96a2:b0:89f:1a76:e2dc with SMTP id hd34-20020a17090796a200b0089f1a76e2dcmr5460112ejc.0.1675783366547;
        Tue, 07 Feb 2023 07:22:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906038900b008aa0305dbe8sm795012eja.80.2023.02.07.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:22:46 -0800 (PST)
Message-ID: <1501a9da-e567-aea4-70ef-70d4c7cbf021@linaro.org>
Date:   Tue, 7 Feb 2023 17:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: reserve the resources on topology
 change
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
References: <1675780196-3076-1-git-send-email-quic_kalyant@quicinc.com>
 <1675780196-3076-5-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1675780196-3076-5-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 16:29, Kalyan Thota wrote:
> Some features like CTM can be enabled dynamically. Release
> and reserve the DPU resources whenever a topology change
> occurs such that required hw blocks are allocated appropriately.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
> Changes in v1:
> - Avoid mode_set call directly (Dmitry)
> 
> Changes in v2:
> - Minor nits (Dmitry)
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 ++++++++++++++++++++++-----
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> index 539b68b..85bd5645 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> @@ -204,6 +204,7 @@ struct dpu_crtc {
>    * @hw_ctls       : List of active ctl paths
>    * @crc_source    : CRC source
>    * @crc_frame_skip_count: Number of frames skipped before getting CRC
> + * @ctm_enabled   : Cached color management enablement state
>    */
>   struct dpu_crtc_state {
>   	struct drm_crtc_state base;
> @@ -225,6 +226,7 @@ struct dpu_crtc_state {
>   
>   	enum dpu_crtc_crc_source crc_source;
>   	int crc_frame_skip_count;
> +	bool ctm_enabled;
>   };
>   
>   #define to_dpu_crtc_state(x) \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3920efd..7bb4840 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -217,6 +217,22 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>   	15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>   };
>   
> +static bool _dpu_enc_is_dspp_changed(struct drm_crtc_state *crtc_state,
> +	struct msm_display_topology topology)
> +{
> +	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
> +
> +	if (drm_atomic_crtc_needs_modeset(crtc_state))
> +		return true;

I think this check doesn't belong to the is_dspp_changed() function.

> +
> +	if ((cstate->ctm_enabled && !topology.num_dspp) ||
> +	    (!cstate->ctm_enabled && topology.num_dspp)) {
> +		crtc_state->mode_changed = true;
> +		return true;
> +	}
> +
> +	return false;
> +}
>   
>   bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>   {
> @@ -642,14 +658,15 @@ static int dpu_encoder_virt_atomic_check(
>   
>   	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>   
> +	_dpu_enc_is_dspp_changed(crtc_state, topology);
> +
>   	/*
>   	 * Release and Allocate resources on every modeset
> -	 * Dont allocate when active is false.
>   	 */
>   	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>   		dpu_rm_release(global_state, drm_enc);
>   
> -		if (!crtc_state->active_changed || crtc_state->active)
> +		if (crtc_state->enable)
>   			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
>   					drm_enc, crtc_state, topology);
>   	}
> @@ -1022,7 +1039,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
>   	struct dpu_hw_blk *hw_dspp[MAX_CHANNELS_PER_ENC] = { NULL };
>   	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
> -	int num_lm, num_ctl, num_pp, num_dsc;
> +	int num_lm, num_ctl, num_pp, num_dsc, num_dspp;
>   	unsigned int dsc_mask = 0;
>   	int i;
>   
> @@ -1053,7 +1070,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   		drm_enc->base.id, DPU_HW_BLK_CTL, hw_ctl, ARRAY_SIZE(hw_ctl));
>   	num_lm = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
>   		drm_enc->base.id, DPU_HW_BLK_LM, hw_lm, ARRAY_SIZE(hw_lm));
> -	dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> +	num_dspp = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
>   		drm_enc->base.id, DPU_HW_BLK_DSPP, hw_dspp,
>   		ARRAY_SIZE(hw_dspp));
>   
> @@ -1084,7 +1101,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   	}
>   
>   	cstate->num_mixers = num_lm;
> -
> +	cstate->ctm_enabled = !!num_dspp;
>   	dpu_enc->connector = conn_state->connector;
>   
>   	for (i = 0; i < dpu_enc->num_phys_encs; i++) {

-- 
With best wishes
Dmitry

