Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DD62C1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiKPPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiKPPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:08:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1B450A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:08:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so30025792lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adyqmGjM2/t88ETfaCdsoHxVWXhSjmQ/Vu2VudXPCUc=;
        b=c8VfFr4bwKX5GqribNfHQoZpMGRMbhtwz0/3nHn25OW7yTWV2y1hbIRp7ej30MKYEI
         B+EDI/dHDMS4GrpH2uiNdrlgvVWp0m9dwnQi6URa6cinXq9cgobrHeic3m8kVnFncLQX
         2ATypZjLaeMjPagjxdDbFnNKjv/tbAbfnrvq2mE+Od4SMmOemsvzJMGUbhNYp47WSh8U
         SQge65+D9h0WUnKgNB/QCdwh+EbJIXMJiWAKWPLhKvMQ8q96JbKmO7K61YxmKaXKmoiy
         Qq+kKcxfoN/nhm5Wx2Ei39iagnnr45S5pWe7qohShl0phcp+OmaDRt5oNqfDDcQznIM6
         yhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adyqmGjM2/t88ETfaCdsoHxVWXhSjmQ/Vu2VudXPCUc=;
        b=QC0kuLJwiXRS6eeeWU9i+Hqk+tCVr2Yc/jktJ1zZhTM4fH9ig4NqM48exf8XqKR+su
         P30h9Z3tgKxquAv1XAmubmt182mpWF5pkbzr+uqPCSLCK0H7/oxImYSzjNdUfIG8iTlw
         pXkiHSeYmx5vr0j1qC/QeCdsh2YHHAT1wyVRwUva06isxYkEDUp1Kx3tsHA7lb1uSjQf
         LBm62VHQY4C9neQbvNo54DNttkM/uqo3bEA6C9Etd5wMvX5LVyaLXOpR7wThdxDJw7LM
         NKnluKhBG+wlU8wOTX4mPVkCgAXTTgh/DoX2PiDZEJQiqG4RyU33awOHVPe6n+/dgEoc
         Lw3Q==
X-Gm-Message-State: ANoB5pne/zdruLdBDEPIPoJvR43tBdPeMeoZkrXCRRnj8Y/VP+2dxKue
        AxDNROAfb+w8tIjCWcNkMcKo0A==
X-Google-Smtp-Source: AA0mqf62VyZdW4auUMnIXeVYdnC6S01JYtnXZYf5j6edhD/d7LSZvVxnROe6RVTCDX1scp9U+j/H8g==
X-Received: by 2002:a05:6512:1308:b0:4b2:1e88:41bb with SMTP id x8-20020a056512130800b004b21e8841bbmr8370954lfu.117.1668611319711;
        Wed, 16 Nov 2022 07:08:39 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b24-20020a056512071800b004b15bc0ff63sm2621645lfs.277.2022.11.16.07.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:08:39 -0800 (PST)
Message-ID: <e049f5b1-da41-6854-4731-b6697770ffde@linaro.org>
Date:   Wed, 16 Nov 2022 18:08:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/3] drm/msm/disp/dpu1: add helper to know if display
 is pluggable
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1668609040-2549-1-git-send-email-quic_kalyant@quicinc.com>
 <1668609040-2549-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668609040-2549-3-git-send-email-quic_kalyant@quicinc.com>
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

On 16/11/2022 17:30, Kalyan Thota wrote:
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
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 16 ++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 9c6817b..be93269 100644
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
> @@ -217,6 +218,21 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>   	15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>   };
>   
> +bool dpu_encoder_is_pluggable(struct drm_encoder *encoder)
> +{
> +	struct drm_bridge *bridge;
> +	int ops = 0;
> +
> +	if (!encoder)
> +		return false;
> +
> +	/* Get last bridge in the chain to determine pluggable state */
> +	drm_for_each_bridge_in_chain(encoder, bridge)
> +		if (!drm_bridge_get_next_bridge(bridge))
> +			ops = bridge->ops;
> +
> +	return ops & DRM_BRIDGE_OP_HPD;

No. This is not what you should be checking (hint: polled connectors 
also can be pluggable).

Please check the type of the actual connector connected to this encoder.

> +}
>   
>   bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>   {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 9e7236e..691ab57 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -224,4 +224,10 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
>    */
>   bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
>   
> +/**
> + * dpu_encoder_is_pluggable - find if the encoder is of type pluggable
> + * @drm_enc:    Pointer to previously created drm encoder structure
> + */
> +bool dpu_encoder_is_pluggable(struct drm_encoder *drm_enc);
> +
>   #endif /* __DPU_ENCODER_H__ */

-- 
With best wishes
Dmitry

