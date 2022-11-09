Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C8622B65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKIMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKIMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:19:08 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699360E0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:19:07 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d20so25450842ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ye8sH1zl6sSv9DGDAjB1eEzXhmWboI2vsCHxYwdnJz0=;
        b=ZybYS6nV5FlcTXdHMLqh4gUjeCEABntLlbBDQEVcOAR1CZiPzbrwizoLaTkmEBRDoB
         nlxOmUVmwDcNHB9sx27cVU8h2xk0UuRyv8dTsTHL9ZhMRfRnb9jKGr0RuovM/JgfmAZl
         lxUPM4QzTpDcZJfxMpf8n0omxEYk42BKMKNGGmQufJ1+vfgNulurWPIvCC68Cx18q6FC
         T/9FEZngmNYLRa7CRlwPJF260cUIr5/s/iQbWzhjlPFaNHvracynMpdkxg60nTsk4pTw
         UOc2Ls4pdJy6SmAR/FlX0w9/udujOo3QWnowkPJB/m+iwAFzn6yvCl4FfqCRAi/j0vPp
         gpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ye8sH1zl6sSv9DGDAjB1eEzXhmWboI2vsCHxYwdnJz0=;
        b=kFQO4Hcr/ZEM8J3dygVayUld6LhCh6gh0zq3z7weOXKr+BXiO8jMlLXohCKT7rZ+Mz
         k3jQu3UU8MNhP3FIvjKrc+wxBedBplpAkdURYx/EfvrU+b4z+u1BF0Je4Tart48waT/f
         U+nZwOHi7puYMrHuX/RUigIq3mz44nvFtaqWdDAzZgrICKN00b3pfC+HQr02GI/fryzB
         ESOkbIcc9YP6Po/oPrlmiVHu/fNlywfRYSKrequp83GTGT7EEkm6ckkC/dsGZr5sfiHt
         RJHT6i8lXNxcT8viUINaeg9NrCym7ocRNXm2kaR9pavuctr0RiWD5o2+ns5WNvhoRn7l
         WApA==
X-Gm-Message-State: ANoB5pnzAtVPh0L80YeGaNDIHsJ7xS7GISlC9u8B86iqSdplK1ch8B+3
        tHrNy3Z9EHk3DW5ORX4UTAMqRw==
X-Google-Smtp-Source: AA0mqf6Qt3W69twHjBbljDgjSSNO7IveTjCXXa66ab4tN+ev2MwpKhm0I2pTcRY2KRSEbjJplOS3zQ==
X-Received: by 2002:a2e:544d:0:b0:278:ba60:d4f0 with SMTP id y13-20020a2e544d000000b00278ba60d4f0mr1986815ljd.351.1667996345347;
        Wed, 09 Nov 2022 04:19:05 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b004979da67114sm2192382lfv.255.2022.11.09.04.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 04:19:04 -0800 (PST)
Message-ID: <414280e3-6954-6832-10fa-66cdcdbfac18@linaro.org>
Date:   Wed, 9 Nov 2022 15:19:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
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

On 09/11/2022 15:16, Kalyan Thota wrote:
> Pin each crtc with one encoder. This arrangement will
> disallow crtc switching between encoders and also will
> facilitate to advertise certain features on crtc based
> on encoder type.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7a5fabc..552a89c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -798,19 +798,19 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   	max_crtc_count = min(max_crtc_count, primary_planes_idx);
>   
>   	/* Create one CRTC per encoder */
> +	encoder = list_first_entry(&(dev)->mode_config.encoder_list,
> +		struct drm_encoder, head);

Please use drm_for_each_encoder() here.

>   	for (i = 0; i < max_crtc_count; i++) {
>   		crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
> -		if (IS_ERR(crtc)) {
> +		if (IS_ERR(crtc) || IS_ERR_OR_NULL(encoder)) {

Why? Not to mention that the OR_NULL part is quite frequently a mistake.

>   			ret = PTR_ERR(crtc);
>   			return ret;
>   		}
>   		priv->crtcs[priv->num_crtcs++] = crtc;
> +		encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
> +		encoder = list_next_entry(encoder, head);
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

