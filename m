Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3737626494
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKKWW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiKKWWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:22:08 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288015717
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:21:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c25so5959610ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o26oEY0qputXYTzAwwAYZekOHht/31yMfdtXZlzRR4=;
        b=CajQqRg+YwrZ8d/8ZoG3Wh0AIkat4euF0GVNVtQ74LDdgNz7DT/1Q1wuSW4ETzQL8w
         KTFpjw4yXwC+fGQrB9yb4smZx6azpYNXg39ep+Rs6MzVsnICsH7yNpZk5ZPmHACbCYMF
         c/XRpQczDvqzf3kfrnqA+KlGHwUwgdmyD64Giji18ng/E0aw+Npm02CEyA0U/btitstA
         fYFl2MIzfsOysmtuZPX/rR4V2E+T72sosVeTDfysVpnFsaS9W3tBhRfTsZZ8R1hidnIp
         LOWI6rI1eo5STfaIerMCHZmqgrOyKv1CzNtgayu/zd7Nf+l1XpQbALSadyMLQ8XMtOn9
         PQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o26oEY0qputXYTzAwwAYZekOHht/31yMfdtXZlzRR4=;
        b=jV4CQHcwmJCODsvCkiqjdR55/qsJU72i10pt1Be94ZO8vyR7F9BFNnb0T/ovDh6zoM
         rbRN7gJE9Bi6HjHWSg2c9skoEjpJSeogyE1VAX/6nrSovXsQLczIJMHgcYd9MedAjA8F
         vn5350AlFhVQvWzBaQOapS7QYLiQWyToeuAKXrMSMrpqVajSqU+zXuJZYq2CWDKS249n
         u+w8+sPG45+/mkzqmCHsnKO7fdxUvfOyKeENuLv+9LSvHOB/7uWpfuuhSeFD3G+kyrQK
         Wuxax0QgCWqS5YQ1mjQcE4OKBMxriWcXKFqG1lHYkd9cXDOK5NH1DXma8gKOtsEvbI75
         pSEA==
X-Gm-Message-State: ANoB5pmRTJpxzEFIRk0dYIATDYguYKJATPheR8GcjnB0DqlE4jeNQQ5n
        /W8xGw5V9yaxNrSaRw9tzQJzcA==
X-Google-Smtp-Source: AA0mqf4r5XbqiU+jo40QoGKWywM5FNSA1kzh7k6H0c/cblGIU+ngQUvecxuhzp5P1CVzN+gPQbc+LA==
X-Received: by 2002:a2e:97c4:0:b0:277:5ce7:3411 with SMTP id m4-20020a2e97c4000000b002775ce73411mr1258209ljj.37.1668205259498;
        Fri, 11 Nov 2022 14:20:59 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h31-20020a0565123c9f00b00498f00420e9sm528022lfv.194.2022.11.11.14.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 14:20:59 -0800 (PST)
Message-ID: <ed2050c9-3e5f-ef97-a399-c9dc0427f32d@linaro.org>
Date:   Sat, 12 Nov 2022 01:20:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [v1] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1668174978-10676-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1668174978-10676-1-git-send-email-quic_kalyant@quicinc.com>
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

On 11/11/2022 16:56, Kalyan Thota wrote:
> Pin each crtc with one encoder. This arrangement will
> disallow crtc switching between encoders and also will
> facilitate to advertise certain features on crtc based
> on encoder type.
> 
> Changes in v1:
> - use drm_for_each_encoder macro while iterating through
>    encoder list (Dmitry)

BTW: if these patches form a series, please send them so.

> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 7a5fabc..0d94eec0d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -798,19 +798,20 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   	max_crtc_count = min(max_crtc_count, primary_planes_idx);
>   
>   	/* Create one CRTC per encoder */
> -	for (i = 0; i < max_crtc_count; i++) {
> -		crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
> -		if (IS_ERR(crtc)) {
> -			ret = PTR_ERR(crtc);
> -			return ret;
> +	i = 0;
> +	drm_for_each_encoder(encoder, dev) {
> +		if (i < max_crtc_count) {

What if max_crtc_counter < num_encoders? I think we should disallow such 
configuration. Can it happen on any of relevant platforms?

> +			crtc = dpu_crtc_init(dev, primary_planes[i], cursor_planes[i]);
> +			if (IS_ERR(crtc)) {
> +				ret = PTR_ERR(crtc);
> +				return ret;
> +			}
> +			priv->crtcs[priv->num_crtcs++] = crtc;
> +			encoder->possible_crtcs = 1 << drm_crtc_index(crtc);
>   		}
> -		priv->crtcs[priv->num_crtcs++] = crtc;
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

