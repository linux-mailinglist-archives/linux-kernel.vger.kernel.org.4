Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DA66362D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjAJAWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjAJAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:22:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372C3AA8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:22:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu8so15723754lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3J9XKLlpP5X6CvDBX/lWRDKKuy8Kaqsk+6ZWrT2IkL8=;
        b=n4hvHMSGn2WfGgJh4rRLEBOydN/+sVZM3Pydyit8JakkdzKCfnzvOtZ3IBmxnJKqgi
         /rkYLJWADxt6NxW5sexSZ1jsXaAc0e38GsfIvxUXy0sUQbOVvJxal0rxxrfOT9RC1kLo
         /ZWGtQT4HR5vjMZepAEQhlkCCjgZBe9hFwsgCE7CpQU08lwN35FXul4KJmIqbW8WP6Js
         GqpBncUdW4spd/Depy8HbN/MCoeSNmI3RCssxgxa2HPfHWlEU/PKv6VnssmyYhsiUqd7
         zX3E9W/6yghIu72crNK5RIjt1if6mLkkDAKLkftANHN7bt6UasgziE0v5A9BWnXtzDgE
         b1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3J9XKLlpP5X6CvDBX/lWRDKKuy8Kaqsk+6ZWrT2IkL8=;
        b=dBrlj3CAZ63JmYfDnYrgFzM+2yXYEjAkGjiaWKJVpau0EueBlhT1ZjA7b7tb4Gvj/f
         4icgnhCTifJd/JUZ2VVQb8hSVrJ3a4bUdVnFlfEracXsAwGiEse6RPngLsgWRIKtk/VA
         iZPzz8Hl1S3ffZZMlmjBh+vQd90eNyybhht6f9dQu9xro+6DY/bBal9nMOkGMJiiBcxl
         TVG6Kxv3waZE3Wr8LOuHAagr+PaQYaEdI141fOEp7mRUUWek/vogN8Xm1dOGwvqeJCMG
         z1N2uoRFDyT7BWcdjkv8iX0F1D5fNZ4pjSs4fGtRn4KF4D3dweRHZHy82ZzyL9KWdIRN
         KPHQ==
X-Gm-Message-State: AFqh2kp8LRVItR0UFq/bAWqDMk7Qgfv5B5JvuX0BxQg+SsV6OMMClYzJ
        9q3CmO53nMzbJ//ZtzY1E1gqQg==
X-Google-Smtp-Source: AMrXdXtXj53XSAEDy43S/dF+TH9B4KyRf+Qy1PibWEaXMJ+81JeOqRnE5ih/iFdtK8mqkDEeOuwx4g==
X-Received: by 2002:a05:6512:e89:b0:4b5:b7be:136b with SMTP id bi9-20020a0565120e8900b004b5b7be136bmr19919799lfb.69.1673310147359;
        Mon, 09 Jan 2023 16:22:27 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x3-20020a0565123f8300b004949a8df775sm1854041lfa.33.2023.01.09.16.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:22:26 -0800 (PST)
Message-ID: <eeafb291-9da7-da21-8425-c651066f7379@linaro.org>
Date:   Tue, 10 Jan 2023 02:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/3] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
 <1669021695-4397-2-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1669021695-4397-2-git-send-email-quic_kalyant@quicinc.com>
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

On 21/11/2022 11:08, Kalyan Thota wrote:
> Pin each crtc with one encoder. This arrangement will
> disallow crtc switching between encoders and also will
> facilitate to advertise certain features on crtc based
> on encoder type.
> 
> Changes in v1:
> - use drm_for_each_encoder macro while iterating through
>    encoder list (Dmitry)
> 
> Changes in v2:
> - make sure no encoder miss to have a crtc (Dmitry)
> - revisit various factors in deciding the crtc count
>    such as num_mixers, num_sspp (Dmitry)
> 
> Changes in v3:
> - none
> 
> Changes in v4:
> - use max_crtc_count instead of num_encoders in WARN (Dmitry)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7a5fabc..d967eef 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -795,22 +796,25 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   			primary_planes[primary_planes_idx++] = plane;
>   	}
>   
> -	max_crtc_count = min(max_crtc_count, primary_planes_idx);
> +	/*
> +	 * All the platforms should have at least 1 primary plane for a
> +	 * crtc. The below warn should help in setting up the catalog
> +	 */
> +	WARN_ON(max_crtc_count > primary_planes_idx);

This change broke sc7180 support, see 
https://gitlab.freedesktop.org/drm/msm/-/jobs/34395875

I suggest a quick fix of either disabling WB2 or switching one of cursor 
SSPPs to a generic one.

>   
>   	/* Create one CRTC per encoder */
> -	for (i = 0; i < max_crtc_count; i++) {
> +	i = 0;
> +	drm_for_each_encoder(encoder, dev) {
>   		crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
>   		if (IS_ERR(crtc)) {
>   			ret = PTR_ERR(crtc);
>   			return ret;
>   		}
>   		priv->crtcs[priv->num_crtcs++] = crtc;
> +		encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
> +		i++;
>   	}
>   
> -	/* All CRTCs are compatible with all encoders */
> -	drm_for_each_encoder(encoder, dev)
> -		encoder->possible_crtcs = (1 << priv->num_crtcs) - 1;
> -
>   	return 0;
>   }
>   

-- 
With best wishes
Dmitry

