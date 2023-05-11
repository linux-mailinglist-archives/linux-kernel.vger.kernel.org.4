Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91186FEAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjEKEcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjEKEcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:32:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05934C28
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:32:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso9203749e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683779521; x=1686371521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz+/Gk20g+rLGD9WBqQz3JvVt45c9RNumBRgkU0bdyw=;
        b=WZjnFRiWVZZFr4Fhgzci0fv4Vfo1EuRPrjyGec8/nwkoYRb2NwdX4NJOltvGDEu7Lg
         4AdQyw9UzrAhhHusFeH9qnnKxUp0ic7bX0jp8l8+uyO4evqCRZEMuSmrGaVNoh2FM7d2
         XEwGu7cccljywPdVVGbzrnpmdOCb0+xRtZ0fRni9nAMglIHDuyJfGI1ZCo0fKErLf3sl
         2LQa8Mj7L6JKStDNyFJhfvPrrgFeD6oif1JxdX1RfDUjK2qv9nddxKkyAYpPZTl6YSO4
         kf4Z6n9SiXgL/MC3HD2IVymSj77BBhRQd03rEd/v5GGQegEtuBqk+pEJxDD/XRRfhJg0
         9JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683779521; x=1686371521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz+/Gk20g+rLGD9WBqQz3JvVt45c9RNumBRgkU0bdyw=;
        b=ibiyvXWSeaYOnJ5+RBegUROy8PMlqzE0bzepH2hL6FKoMG499Xyl54uxvEUCtcYFNW
         pKVgg3LJ9uCaLfrhZHnpxhbTihTj6n2QU1TTjGVvz1BefcX59UKKN0XKhw6HjzYHMRh4
         /nOZPs14e27W6ss08qOnm3dn86mitUG8wG4534faJdnR7gD3Uj/xk51aZpJXNSdDGTjY
         1lHRkKPbaM7AvBOMoud9Z7Hv3Uliu2qP2klVztDhVhxpMi2Is3Lnh24onYu3I2765Qgt
         8jYQX02JrkmECBSFNe+tQQ78RcxkCVwYC27qHiVNQhhweK8/02mzdfchtEko+qSRI5Ch
         2HlQ==
X-Gm-Message-State: AC+VfDyM6o6lkLHcNrs32jEcL5Wuw0ROfRjlZxaJdCRraQ9A4GYBQwY0
        EbjzMozIMyzaLgTTC+HM1hZm8w==
X-Google-Smtp-Source: ACHHUZ7gmShjR3g56HV3TeLijQNuVXEg1vd+aF/vlRc2UFIDY5gqky/Jpf/uNjU1oWK+JIQC0IB9Mg==
X-Received: by 2002:ac2:54a8:0:b0:4ed:b842:3a99 with SMTP id w8-20020ac254a8000000b004edb8423a99mr2683287lfk.59.1683779513330;
        Wed, 10 May 2023 21:31:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24259000000b004f13ca69dc8sm962020lfl.72.2023.05.10.21.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 21:31:52 -0700 (PDT)
Message-ID: <02797bdd-a292-5891-ce73-8a174d62ac7d@linaro.org>
Date:   Thu, 11 May 2023 07:31:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/8] drm/msm/dpu: test DPU_PINGPONG_DSC bit before
 assign DSC ops to PINGPONG
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683756453-22050-4-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 01:07, Kuogee Hsieh wrote:
> DPU < 7.0.0 has DPU_PINGPONG_DSC feature bit set to indicate it requires
> both dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() to be
> executed to complete DSC configuration if DSC hardware block is present.
> Hence test DPU_PINGPONG_DSC feature bit and assign DSC related functions
> to the ops of PINGPONG block accordingly if DPU_PINGPONG_DSC bit is set.
> 
> changes in v6:
> -- split patches and keep the function file handles DPU_PINGPONG_DSC bit at this patch

Please correct me if I'm wrong, the overall suggestion was to have 
actual catalog changes before this patch. However I do not see this 
feature bit being enabled at all!

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 79e4576..e7f47a4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -295,6 +295,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>   	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
>   	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
>   
> +	if (test_bit(DPU_PINGPONG_DSC, &features)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
> +
>   	if (test_bit(DPU_PINGPONG_DITHER, &features))
>   		c->ops.setup_dither = dpu_hw_pp_setup_dither;
>   };

-- 
With best wishes
Dmitry

