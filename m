Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAC69B43F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBQUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:54:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF965FC7B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:54:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o3so3161554lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4WIlW107+t+DszwrTyAc22lGzyIotvHYh3Xdegh8P4=;
        b=ijLbDznXSh8NzgQqTx231xT93GZkx4MeSRAeCsBUz44OLjpMEVla3bA3NYQPlNLlZp
         IQsDkMoFer3vwJxvfOBxV/ruqX0qpfnIZ0wGQNyWXNNMZ4UWqaOzRDa3SkHXAKwU9MMF
         bdvsq/G2lI6g1C51+IF8GLKFUS0yIJPX8oKvsMwM5p22utkwhC1jV4B9BaizWxCBEbQS
         Jhl0ACH/gko8v118lIIS/AH7nVRk6BMtERZ3NBQShAQ5HVyOyZiYhQbwK+eZwCUbuvdY
         rYt7r1dz1nDh9fj2G6a50W62RAUIUCOjqt90QzI1KcDp9BtBI4TDXRcm2j98yB7VGiHI
         hM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4WIlW107+t+DszwrTyAc22lGzyIotvHYh3Xdegh8P4=;
        b=bEWXRlWlNfaBfvy3+v29cJJ8LuP3FUJU+J/lm7KOBOm95YHC2vqUGbXCBYKakzLVmB
         Hiq48gkD3OeC7sR6XMIkzsHdmksJufiexpJxJGWus4IhnbLv3QmU0PyofFKrv/Bk6R8Y
         a4zNZELJi3luRclDuO+xdOjQSZj6l5214SA6ThDDBRaJ6JmsC/pjB0IRowBOOzpAhMci
         cpaLjo7f75SkEmpwdFn47u5RIsXSE+J57OV5U3tfZkcswa6+2zNHeTmNr4XavyqpbVoA
         QrV6SD7AjKfuEvED0jX/4cSQz40u7rGpwQuzkR1JgiSypssK/PYs6qkojEzjsGWrEHHc
         8ogg==
X-Gm-Message-State: AO0yUKV2TrJzWOwUj5Z2XB02t9Qx9FdUVHU62bVjKl3mdtLQK8UOrBgA
        vaRjQzFgBaP3JM37yC4dMlK+Dw==
X-Google-Smtp-Source: AK7set8gglBiYkWUbLE8SQ94BBjgD+VurWdIpC2JdjGiHA8slABEmoxIJMuENRApu8yYjKrVP71O3w==
X-Received: by 2002:ac2:4142:0:b0:4d5:7923:c4c0 with SMTP id c2-20020ac24142000000b004d57923c4c0mr132849lfi.27.1676667255203;
        Fri, 17 Feb 2023 12:54:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id h12-20020a19700c000000b004d8729d4150sm771293lfc.145.2023.02.17.12.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:54:14 -0800 (PST)
Message-ID: <70f298cb-92a3-0bda-2192-51531a4b4f55@linaro.org>
Date:   Fri, 17 Feb 2023 22:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 05/14] drm/msm/adreno: Disable has_cached_coherent for
 A610/A619_holi
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-6-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230214173145.2482651-6-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19:31, Konrad Dybcio wrote:
> These SKUs don't support the feature. Disable it to make the GPU stop
> crashing after almost each and every submission - the received data on
> the GPU end was simply incomplete in garbled, resulting in almost nothing
> being executed properly.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 36f062c7582f..82757f005a1a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -540,7 +540,13 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>   		config.rev.minor, config.rev.patchid);
>   
>   	priv->is_a2xx = config.rev.core == 2;
> -	priv->has_cached_coherent = config.rev.core >= 6;
> +
> +	if (config.rev.core >= 6) {
> +		/* Exclude A610 and A619_holi */
> +		if (!(adreno_cmp_rev(ADRENO_REV(6, 1, 0, ANY_ID), config.rev) ||
> +		      adreno_cmp_rev(ADRENO_REV(6, 1, 9, 1), config.rev)))
> +			priv->has_cached_coherent = true;
> +	}

I'd suggest something like:

if (config.rev.core >= 6 &&
     !(info.quirks & ADRENO_QUIRK_NO_CACHE_COHERENT))
         priv->has_cache_coherent = true;

Let's keep all the information and quirks in a single place.

>   
>   	gpu = info->init(drm);
>   	if (IS_ERR(gpu)) {

-- 
With best wishes
Dmitry

