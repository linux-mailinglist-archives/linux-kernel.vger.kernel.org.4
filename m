Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27596E8594
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjDSXAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjDSXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:00:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAA1706
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:00:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z38so688454ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681945198; x=1684537198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCawUKvbpyJ/O3QCtYIFnEkGoYOHSsivpE+P/NmOeR0=;
        b=NmQej+fM9HNh8EOvTI7YBZ9ds3cqJEoVgnV8JZAgbG3h1PhjB7DTPWq/J//U1N4l3L
         7Tjt5h1BIAnwfFkd57uEby1pC3ZBnG8OrW2y9zJ0FbPi3mB0uSo3zD8Dm7n/iiH94gBL
         Q5J3N/QbvLi7rnHK/+f1djuaznavAsQzu2BAvePgDQ8nEI+rzfnuPNODmQu7uedR4ZEB
         aoYC+f0fYYi4rR0qXBYPkjaAMDbYPaXsRQHgq2PjrvnF9mnweWK+nCyh5KAMSUAvCxwK
         /+rKZvrfSqoucxWFJMO87JE3dzcMrJfPrRvJPMPyDh32ieZe7to2sGysqaxy0C0925V6
         pBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945198; x=1684537198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCawUKvbpyJ/O3QCtYIFnEkGoYOHSsivpE+P/NmOeR0=;
        b=CBuSy32ks0GMTLC//Jq55yWF9g5WhFH/uIE6s/sjyPprkDrb4sEgJuSQrz9jeVN0Z9
         trzyZLASlq4knLnJO0A212J9dVtaF0kxkgozxqnRiTNesALsNqgBEyeTEAi8f+zJZIO8
         8KVj/MKdocahmbfO0l6GRYTtHW2ZedY7pW+dmdCqBl5c4DK7qOa/wlbJJKwjIU+GK5+3
         EFjeZ1ii3UcccAOtXy/6pp43TA0IUY670FnrPsOCO0uBsx3goMrtIGWkv9kjoq4n9ONc
         xobNHMjy032RUlSc75BPF6yGRfbHhRAb9Q8ojHBZaoOq/gO2SRRb4T/Kg5kSc2eRkMC/
         aQ8w==
X-Gm-Message-State: AAQBX9fxfuhc2NXeyt/KI1BXy7QKZHo/jKA90q8/ESVPKp0XtcUnOTVK
        elvjpTEO8Iuj7Qh02anZ8x4UMh08BrcaYPDH1uA=
X-Google-Smtp-Source: AKy350bMNNErl7bByeTgmpgjdePtabkJ+a2Vh6JpDEnLxmjvPvyv7daUPysh6Z+4C1DKcf7pk3Ip0A==
X-Received: by 2002:a2e:b0fc:0:b0:2a7:763e:f158 with SMTP id h28-20020a2eb0fc000000b002a7763ef158mr2213119ljl.19.1681943034546;
        Wed, 19 Apr 2023 15:23:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e26-20020a2e985a000000b00294692d8645sm3068589ljj.17.2023.04.19.15.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:23:53 -0700 (PDT)
Message-ID: <6e807c05-a990-5692-3f84-2e4153c8c278@linaro.org>
Date:   Thu, 20 Apr 2023 01:23:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/11] drm/msm/dpu: use the actual lm maximum width
 instead of a hardcoded value
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-2-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-2-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> This avoids using two LMs instead of one when the display width is lower
> than the maximum supported value. For example on MSM8996/MSM8998, the
> actual maxwidth is 2560, so we would use two LMs for 1280x720 or
> 1920x1080 resolutions, while one is enough.
> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>

While this looks correct (and following what we have in 4.4), later 
vendor kernels specify the topology explicitly. Probably we should check 
this with the hw guys, because it might be the following case: even 
though a single LM can supply the mode, it will spend more power 
compared to two LMs.


> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1dc5dbe585723..dd2914726c4f6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -53,8 +53,6 @@
>   
>   #define IDLE_SHORT_TIMEOUT	1
>   
> -#define MAX_HDISPLAY_SPLIT 1080
> -
>   /* timeout in frames waiting for frame done */
>   #define DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES 5
>   
> @@ -568,10 +566,12 @@ static struct msm_display_topology dpu_encoder_get_topology(
>   	 */
>   	if (intf_count == 2)
>   		topology.num_lm = 2;
> -	else if (!dpu_kms->catalog->caps->has_3d_merge)
> -		topology.num_lm = 1;
> +	else if (dpu_kms->catalog->caps->has_3d_merge &&
> +		 dpu_kms->catalog->mixer_count > 0 &&
> +		 mode->hdisplay > dpu_kms->catalog->mixer[0].sblk->maxwidth)
> +		topology.num_lm = 2;
>   	else
> -		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> +		topology.num_lm = 1;
>   
>   	if (crtc_state->ctm)
>   		topology.num_dspp = topology.num_lm;
> 

-- 
With best wishes
Dmitry

