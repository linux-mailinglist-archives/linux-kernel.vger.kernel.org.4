Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA162F506
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiKRMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbiKRMgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:36:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6798CFD5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:36:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id be13so8011766lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdtOWroELQJIWa4ogi8rXDaEyRIp/3m317/ZVv8U8mI=;
        b=gcdoFMSgJ69cwq2ZZn7iEiz5VfeA5hEbmIiei5tverZWgEmex5v0nEGH4w5QL82HgN
         0zUyOxdTlgKG/0D0iSw9NO4CesjcZ7e1DvYZhHz9S/OctljK0udXzSyjDUjtHFpvzhjc
         XrWdCHoaj/0XL3I6YvuANwkQmPXt8Nx7aHBJlKUZks8j68RjT18aUUvRzN8VzLE28cOm
         1XjuzIT2hjpCnHFeBwJNs/lZAZRwFK0E7xuQCbCY+Dg4CEnnh5eEG86Dxuu5zzofIGYG
         v9WpMigTFH0ifC1Ln7Sig90LStYIf8T01OlfRcIuu19JhIS/HL5DdDDapyXk8I4xvJxG
         Hrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdtOWroELQJIWa4ogi8rXDaEyRIp/3m317/ZVv8U8mI=;
        b=IwNprRiTkmZ0gsRJvuzaTHM2IukffRFfxGYVOQsSjQ0L1FNbBLhfaGyaYgho+TjWHY
         aPzjZSgq3oPLRuDsubo2DYKgP6AtqREOCPfqHvDz/T6vbuDDTMXlC+jlqs0f21fUiQZe
         pVr0GGmArPVSeZtoqqyDi8mFGn9z0uc98qhIiFAafg2hFOQxS8JaQ4I9Ewozp3ZKjJcm
         ZIjvtlE9oUN9VyMkRXPZB3Z3Jz4nzNKRorGU1OFPcVSOdVAMRPJ0Adpy47zUY4AbFiLP
         n/UbJt3uUZ1QAMcQARCP6sZPtqbmkNVE2ajdypMhnqSlqda+ANSUdHLrY3omtOYimIa/
         m2hg==
X-Gm-Message-State: ANoB5pkI7xkNT8ZjnumJF/dvx55pTwk/XFeI6TzuDAonLvFH6PTfDgzw
        YnuORW5GJ6LhLmZqzAkNpJlClQ==
X-Google-Smtp-Source: AA0mqf7/qS3VtKs/HUHAaKu2eUfDph73XqMra7QwDqXGfo+Bj21zBYJduejC7cw7QFT0lBeGfUqiug==
X-Received: by 2002:a19:6558:0:b0:4ac:fbf2:12ab with SMTP id c24-20020a196558000000b004acfbf212abmr2272252lfj.384.1668774966434;
        Fri, 18 Nov 2022 04:36:06 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v8-20020ac25608000000b004afd23cf7eesm641128lfd.168.2022.11.18.04.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:36:05 -0800 (PST)
Message-ID: <5858e2ce-9b13-b694-a6d3-3f8553936dab@linaro.org>
Date:   Fri, 18 Nov 2022 14:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/3] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1668773807-19598-1-git-send-email-quic_kalyant@quicinc.com>
 <1668773807-19598-2-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668773807-19598-2-git-send-email-quic_kalyant@quicinc.com>
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
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7a5fabc..4784db8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -763,7 +763,7 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   	drm_for_each_encoder(encoder, dev)
>   		num_encoders++;
>   
> -	max_crtc_count = min(catalog->mixer_count, num_encoders);
> +	max_crtc_count = num_encoders;
>   
>   	/* Create the planes, keeping track of one primary/cursor per crtc */
>   	for (i = 0; i < catalog->sspp_count; i++) {
> @@ -795,22 +795,25 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   			primary_planes[primary_planes_idx++] = plane;
>   	}
>   
> -	max_crtc_count = min(max_crtc_count, primary_planes_idx);
> +	/*
> +	 * All the platforms should have at least 1 primary plane for an
> +	 * encoder. The below warn should help in setting up the catalog
> +	 */
> +	WARN_ON(num_encoders > primary_planes_idx);

WARN_ON(max_crtc_count > primary_planes_idx)

We do not care about encoders number, we care about CRTCs number here.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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

