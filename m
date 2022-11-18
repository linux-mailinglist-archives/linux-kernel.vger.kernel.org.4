Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD062F50E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiKRMit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:38:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B38E264AB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:38:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so7993114lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92k8zjWPhsfe0rApEXv+Yvs9hh9Iy6qzDin6ZXpogUs=;
        b=CYZJTHEEpam0SbQB1ZDnEb6CoKT+8J/fPyXH2+Ukx13k540BvXB1FvjaCggI0r1c9q
         nwGXjhFdlbqDBcphCtPCoPUaW2Bh04qaB2Gj5Vbjb73NG7LM39wQGY2QOc1gtLsSMxW3
         PvzMocDatvQolTvCQBKAdaoKsl7WpMY0ImZzMw6PwFKm+WkaYgKQ3ERGeq/n/SODKypb
         qUlgEVbqetnZPxXZbyuCsQOAiZflayJduC0l8B/q6KAsqMSlDcqQUv520SnT0ioMelJf
         L4CX16wis8wgvVFFKQrShVHPHN1riKUN8ikVy1N9gb6EIl/NPrYHjN5MPZasuPdLcaXt
         8fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92k8zjWPhsfe0rApEXv+Yvs9hh9Iy6qzDin6ZXpogUs=;
        b=kwPk7szaHqWquQClvFC2xR8KosZ64KNF57ea0XAnglTCCf5BfUQ3BlfS5+Ym6j64PY
         Jl5oONWkNlcfpbnRzm6Gc9KEfHVNqo+UUHf1GPyTuXR++JRWSZzeLtRHRqKYf86u+OY8
         81G/q0WnZbbD1luwIDDiOHjoWlmBYO38nKE0VAZP7+1Uis4vNjGN7zr/WRqWGcVWi9f9
         UuQCNeohjXaCuNDYUrVROcMH7mA1VWZR3JU3oMh5aeG4+t4Z5hBAjA2nK4qJVudLEVV3
         2eNypOSEsd9cjggltex3yj1+wGAuSXulk2fZun2wvf25fcTpJC0+Pcnz5hkWn25foVVJ
         o3kQ==
X-Gm-Message-State: ANoB5pmA9L7s6yHLD1KZi/BirX251NFNwg5Eo5Q2Kb+UCKtcxb0nixmE
        2NnKT940aip2qg3/qetzJXdUBA==
X-Google-Smtp-Source: AA0mqf6hFqZTKEPYIQUeAu5R4Lj5+myz5gX+auuNUFHZ4OrOcQPaAjX0A8pMeU4WXvxk5m03gCtozw==
X-Received: by 2002:a05:6512:2096:b0:498:ec56:8311 with SMTP id t22-20020a056512209600b00498ec568311mr2504959lfr.153.1668775118174;
        Fri, 18 Nov 2022 04:38:38 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f26-20020a05651c02da00b0026dee5476d5sm630307ljo.113.2022.11.18.04.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:38:37 -0800 (PST)
Message-ID: <5dddeaa9-aab1-e437-a3ed-8ad242d50171@linaro.org>
Date:   Fri, 18 Nov 2022 14:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/3] drm/msm/disp/dpu1: add helper to know if display
 is builtin
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1668773807-19598-1-git-send-email-quic_kalyant@quicinc.com>
 <1668773807-19598-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668773807-19598-3-git-send-email-quic_kalyant@quicinc.com>
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

On 18/11/2022 15:16, Kalyan Thota wrote:
> Since DRM encoder type for few encoders can be similar
> (like eDP and DP) find out if the interface supports HPD
> from encoder bridge to differentiate between builtin
> and pluggable displays.
> 
> Changes in v1:
> - add connector type in the disp_info (Dmitry)
> - add helper functions to know encoder type
> - update commit text reflecting the change
> 
> Changes in v2:
> - avoid hardcode of connector type for DSI as it may not be true (Dmitry)
> - get the HPD information from encoder bridge
> 
> Changes in v3:
> - use bridge type instead of bridge ops in determining connector (Dmitry)
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 +++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 9c6817b..574f2b0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -15,6 +15,7 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_probe_helper.h>
> +#include <drm/drm_bridge.h>
>   
>   #include "msm_drv.h"
>   #include "dpu_kms.h"
> @@ -217,6 +218,32 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>   	15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>   };
>   
> +bool dpu_encoder_is_builtin(struct drm_encoder *encoder)
> +{
> +	struct drm_bridge *bridge;
> +	int ops = 0;
> +
> +	if (!encoder)
> +		return false;
> +
> +	/* Get last bridge in the chain to determine connector type */
> +	drm_for_each_bridge_in_chain(encoder, bridge)
> +		if (!drm_bridge_get_next_bridge(bridge))
> +			ops = bridge->type;

Why don't we check the connector type directly? You should not assume 
that connector's type is equal to the latest bridge's type.

> +
> +	switch (ops) {
> +	case DRM_MODE_CONNECTOR_Unknown:
> +	case DRM_MODE_CONNECTOR_LVDS:
> +	case DRM_MODE_CONNECTOR_eDP:
> +	case DRM_MODE_CONNECTOR_DSI:
> +	case DRM_MODE_CONNECTOR_DPI:
> +	case DRM_MODE_CONNECTOR_WRITEBACK:
> +	case DRM_MODE_CONNECTOR_VIRTUAL:

Unknown, WRITEBACK and VIRTUAL are not builtin (for the point of CTM at 
least).

> +		return true;
> +	default:
> +		return false;
> +	}
> +}
>   
>   bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>   {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 9e7236e..7f3d823 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -224,4 +224,10 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
>    */
>   bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
>   
> +/**
> + * dpu_encoder_is_builtin - find if the encoder is of type builtin
> + * @drm_enc:    Pointer to previously created drm encoder structure
> + */
> +bool dpu_encoder_is_builtin(struct drm_encoder *drm_enc);
> +
>   #endif /* __DPU_ENCODER_H__ */

-- 
With best wishes
Dmitry

