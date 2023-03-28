Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563286CC653
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjC1PaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjC1P3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:29:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C752EB64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:28:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y15so16319559lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680017303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbYSQAdfBoY9srBzQ23DbeM27K11V67ptwoHKDjgyAc=;
        b=pM8We1qxb75pUNu0dH9pz/vq0cEy69uWGhSkBJE0Dx6a2F2YE5+1BDyJkNiFO3qbwx
         z6y5abDpn3yLZuCHldzouxKfzDhEBgkUy2jwO0qIlZdxjNfFlzh1he5HX+zKTciexrR7
         5kKYugQaN7u6aydiiwf7OVMmiCeIO/LrCCcshW4a4nE28X+WfUQUVti4ZbimDMPi3fcK
         oGyQJtVGzinps6YPx5Ugy2wF/3f8JsPXrU7nSRPy4eDnXnF/d2VB2jHf2BEpch+OyC8e
         oHIQiF+l/2En+jsD1qEMVE6lzPvSXJ3nuuZN3mBPo1iEjdyAcj8ST8OPDxGizbdb5aHq
         xKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbYSQAdfBoY9srBzQ23DbeM27K11V67ptwoHKDjgyAc=;
        b=EPta4yTorZaMuicJVfgj5Bzh/1Ku9onxw7dDTg43hFsYUKv0TY90LdIRam9sa58cjd
         1bwEEhsagmn5ocVVCxgNEMSYutjuIKyo7R9K67LzhdPs2X05Vj3kF29wI0fSN2lmcoBi
         LkFKJankXBCKI3M2TJhtijqV/ApTd0LysgrvQEQGM1//HtI9pFRj90dtbnNyN/f4gJE7
         3BQpWt4HFYm1PswzE/WOXwOZmn2iJAteIg4dccN4jByRz4wwunQx+JmgOXBXWsrGnqdq
         SuA3qA+7HL7u6j2yZA06UfvicRBc+hTt9EWsAx3dLKZj2ELMraed6Iw1h5bpXZHrJ7Ap
         mpQQ==
X-Gm-Message-State: AAQBX9dFsYGWXgUJAzZFTIMidtLT5NM9CJo/2g9LkGL1R62GQGCg+KtL
        oZUxIuFKAIVwwrVyVpLDfIBnOQ==
X-Google-Smtp-Source: AKy350Z28cG2TgRFvAR8TDgA1LLOhqMkUBnSkIbNOBlA1oA7/iIwsV3nfpf0NfNrSfb8T4j+ZDNzKg==
X-Received: by 2002:ac2:4145:0:b0:4dd:ce0b:7692 with SMTP id c5-20020ac24145000000b004ddce0b7692mr4407966lfi.46.1680017302863;
        Tue, 28 Mar 2023 08:28:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id h1-20020ac250c1000000b004e83f386878sm5083801lfm.153.2023.03.28.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:28:22 -0700 (PDT)
Message-ID: <af31e11c-6c70-a358-1198-3cddc3ee2f89@linaro.org>
Date:   Tue, 28 Mar 2023 18:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm: Avoid rounding down to zero jiffies
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20230324220013.191795-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230324220013.191795-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 00:00, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> If userspace asked for a timeout greater than zero, but less than a
> jiffy, they clearly weren't planning on spinning.  So it is better
> to round up to one.
> 
> This fixes an issue with supertuxkart that was (for some reason)
> spinning on a gl sync with 1ms timeout.  CPU time for a demo lap
> drops from:
> 
>    15.83user 20.98system 0:47.46elapsed 77%CPU
> 
> to:
> 
>    8.84user 2.30system 0:46.67elapsed 23%CPU

Interesting. We potentially increased the timeout, but the overall 
(elapsed) time has decreased. Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_drv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 9f0c184b02a0..7936aa6cad03 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -548,7 +548,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
>   		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
>   	}
>   
> -	return clamp(remaining_jiffies, 0LL, (s64)INT_MAX);
> +	return clamp(remaining_jiffies, 1LL, (s64)INT_MAX);
>   }
>   
>   /* Driver helpers */

-- 
With best wishes
Dmitry

