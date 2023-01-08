Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8E661A37
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjAHV4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAHV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:56:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169927664
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:56:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v25so10216006lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e8O8V82C5N5Vb0KJCfa+OtRNISoBAeakdYZbJjo70I=;
        b=raLWVm7qNmusfNaKZbuYvMr1H/R2jjVHDWBRtsuze6qnSAFV2T75dP0NSoc0b6/5Ad
         RfL+3pA28APIv55CCUkBN5AGuddLKduXNZ7kmbO0e9WQYgxbtEcsjHrv2QmG8wEtJ/GT
         MwCsH7tUzrPPSQ6mfqxOaEkKy2+6pGKbL/CR3tYOvEoM/xZ6JgEpn7X/L3dSS8UV9y+N
         zIh9hwxCorIIP9WXULKAkpj9uuZF0+0bWY+kDfHvEfROOgo+Z0uC3Nl/ytWUP0YGeaw9
         lkn4KykT94f5I/xRRFrJBW5qKoyNiDmXDYTxv6d1uCRmA6/tokgPPToci5a4WisrlunN
         +mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8O8V82C5N5Vb0KJCfa+OtRNISoBAeakdYZbJjo70I=;
        b=nqWSTte3L6Pimo1hwqdH62cT1c85xs1k6XXn3SCiWWZOPJgXgc4LTuF1Ax42IkNrb9
         vOwiZb8R+kKeC08kbpGuDnvSRAd3ali4N7xPetxibdJHZW5r1yZ/V4IT3e7MO0H9yVhj
         sOwDZ4xRlMQydkXYLrgyFYd8paFt2X4MlFM1pEuTe/boG/FiOBrxL3bpN9OtcDF+2rKo
         SkRCXRkBq6vFBqWJY1lOnWta/28D9ckTyj8YS6qxDH90WuDeregXpNZ2KywULHY9e8bM
         0UNKJ4bNWmvIErOvRuEev4ScvLA5VT9YDTscauNoF+QSREmnf4530mGPiFV1Oox8Q+Si
         +UwQ==
X-Gm-Message-State: AFqh2kq51ZQZHbWL+u7tLGbXzJrq8qkofxxfFpXXpZGI3tIWJfo5z+Jh
        kp4/TgHzuZspplQSe6dwG4flMA==
X-Google-Smtp-Source: AMrXdXvKo2BtT7e7Uk53Mqd4oozSlCHiPGbx4Ag+iv04st1VBFMwsT1AQnDkXGlmcDc76falNTAJ7w==
X-Received: by 2002:ac2:482d:0:b0:4ba:555f:4799 with SMTP id 13-20020ac2482d000000b004ba555f4799mr11450200lft.16.1673214968460;
        Sun, 08 Jan 2023 13:56:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512075300b004b15bc0ff63sm1239096lfs.277.2023.01.08.13.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 13:56:08 -0800 (PST)
Message-ID: <e56c48c2-8439-c9c8-c735-95adece3c68d@linaro.org>
Date:   Sun, 8 Jan 2023 23:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm/msm/dpu: Add check for cstate
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, quic_jesszhan@quicinc.com,
        ville.syrjala@linux.intel.com, yang.lee@linux.alibaba.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221206080517.43786-1-jiasheng@iscas.ac.cn>
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

On 06/12/2022 10:05, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check cstate
> in order to avoid the NULL pointer dereference
> in __drm_atomic_helper_crtc_reset.
> 
> Fixes: 1cff7440a86e ("drm/msm: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 13ce321283ff..22c2787b7b38 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -968,7 +968,10 @@ static void dpu_crtc_reset(struct drm_crtc *crtc)
>   	if (crtc->state)
>   		dpu_crtc_destroy_state(crtc, crtc->state);
>   
> -	__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
> +	if (cstate)
> +		__drm_atomic_helper_crtc_reset(crtc, &cstate->base);
> +	else
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);

NAK.

The proper fix is to add the if() but to skip the else clause. We should 
not reset the crtc's state if memory allocation failed.

>   }
>   
>   /**

-- 
With best wishes
Dmitry

