Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBA622B76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKIMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKIMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:23:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75513E96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:23:37 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k19so25512781lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBaghFCNLCn53Zo0ESykylrMeqC7VBs3SaG0Oah8iBU=;
        b=K4f2Tkz0IdNrCtCn+w15VBUcN0WUOBldpK7GtWpm9EJ3B6hz/HMTwR5xgLmvc1hFlb
         aqthXrfpzJahaCPc+JdQshbKg7YS+NdzLIoVejxPlg/RVwAEcXlIvy8gyYZqAvZ1rbys
         9zuSlthowI2MXjF8NTVx54Yl+m2rFOR299V04GeD1WGOJRnJcMrcacQ9GzfeLa+bN0Fk
         Zu0+f6ovEGQZEouwd9F2DQL0VqhJJFKZTXxc4CMc7IzqtM8rV5t3g08HmDqLwjzwAhSc
         vCwQxsygv/XO0GQi5nj9cW4ndHsxDpkxjsNbccxvwSV4C7CLPHQJkiMo2jH1HeSo9UAf
         gRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBaghFCNLCn53Zo0ESykylrMeqC7VBs3SaG0Oah8iBU=;
        b=M5vVt1H+xVmPkJKqixl/wN7ura5trRHsjr9AvL2rHHeljdEIUC4zlMxmbjHOmbLqAq
         0ZHh77/+FTiPN6dJa0GuAgxVPs8+RDMMoz7qkOAJH28ZPaSO7YkynU6R8ATE99HkGGFX
         FhcZvMqOiPwpbvD+DfgT3fUulH+gCJaV3zMMflHqTdzQWRNXmlxEZgLUnA/fqlBD/KpO
         SJzaomhBYwEwbyPHvJ2y0A7ay0naIGVr2gsp97kGU2Oc5fJwHVtQQVws5TgkD21k3Dyn
         Gx6Qt5EVhXGR/FTXUt1uMXx9jTHus9zKhjoQtnY7uFl/KyMBH1IKqL+uY3ozMJWCcNcQ
         +r+w==
X-Gm-Message-State: ACrzQf0K5p6HEiXdnpbjF48cjx/fypHsbfts/1UCEe2X4qkb7teKpPoA
        aMcSaz1MNnmfnTSRvAYJv7unyQ==
X-Google-Smtp-Source: AMsMyM5Tb4oJvE2LEWjw2h4YUxtu3A8jk9pEJTwt1NJBdxpLQRsCwMnfYNsGyhbK0CJ1a0UvbBQsPg==
X-Received: by 2002:a05:651c:2009:b0:277:5992:b532 with SMTP id s9-20020a05651c200900b002775992b532mr16484963ljo.506.1667996615402;
        Wed, 09 Nov 2022 04:23:35 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s26-20020a2eb63a000000b0026dcf238c50sm2135233ljn.127.2022.11.09.04.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 04:23:35 -0800 (PST)
Message-ID: <3f054ff6-3868-d0c0-a8ad-66b87489714f@linaro.org>
Date:   Wed, 9 Nov 2022 15:23:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] drm/msm/disp/dpu1: helper function to determine if
 encoder is virtual
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1667996206-4153-1-git-send-email-quic_kalyant@quicinc.com>
 <1667996206-4153-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1667996206-4153-3-git-send-email-quic_kalyant@quicinc.com>
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
> Add a helper function to determine if an encoder is of type
> virtual.

Please use commit messages to describe why you are doing something, not 
what you are doing. In this case I can predict, why do you need this API 
without going to patch 4.

> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 +++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 5d6ad1f..4c56a16 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2469,6 +2469,17 @@ bool dpu_encoder_is_external(struct drm_encoder *drm_enc)
>   	return dpu_enc->disp_info.is_external;
>   }
>   
> +bool dpu_encoder_is_virtual(struct drm_encoder *drm_enc)
> +{
> +	struct dpu_encoder_virt *dpu_enc;
> +
> +	if (!drm_enc)
> +		return false;
> +
> +	dpu_enc = to_dpu_encoder_virt(drm_enc);
> +	return (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_VIRTUAL);
> +}
> +
>   struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
>   		int drm_enc_mode)
>   {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 43f0d8b..6ae3c62 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -136,6 +136,12 @@ void dpu_encoder_virt_runtime_resume(struct drm_encoder *encoder);
>   bool dpu_encoder_is_external(struct drm_encoder *drm_enc);
>   
>   /**
> + * dpu_encoder_is_virtual - find if the encoder is of type virtual.
> + * @drm_enc:    Pointer to previously created drm encoder structure
> + */
> +bool dpu_encoder_is_virtual(struct drm_encoder *drm_enc);
> +
> +/**
>    * dpu_encoder_init - initialize virtual encoder object
>    * @dev:        Pointer to drm device structure
>    * @disp_info:  Pointer to display information structure

-- 
With best wishes
Dmitry

