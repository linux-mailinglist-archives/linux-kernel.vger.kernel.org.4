Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBD74BA63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjGHAGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjGHAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:06:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFD3126
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:06:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6c5ede714so45559141fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688774773; x=1691366773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOm6ONPFmI/dV+4chdGjJVecrD5MmlD4Ahx6W6/8yEc=;
        b=sFzALzpLbJoMKAhx/sceY4MghcwmclKzQE27quEyVSGyYGdsbRROO24OlDOhvq9hq8
         8sxzqii+IY7IHuS2vEbXUn6uCeIbOUFte0tXGKEFfHGU8wPVu7wADNRanEG+o6drAds3
         Q4/Uy/J/Bo1tbDWvdqi+2n5Y5ww91fvi6sKyt5qEQZ2SOylx5TzIHXQ5BWmi1FaZ3Rrl
         IIwdu/LTc53jbRwVlk9DB8w7prWdm4cYFcKk/ipoZjGMzLFnfe+iEUqDIkaIV032/8/D
         L+mMiXtsJQsD8YYmVnJl6lKZhOJg/teks6r7P+gVVoY+S+/Nb4O6HLy8nFinbWagjAWL
         vH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774773; x=1691366773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOm6ONPFmI/dV+4chdGjJVecrD5MmlD4Ahx6W6/8yEc=;
        b=TcJkrkGLqvKo6u/4XG2uX1MC7CeRRrzS3ZtAVyZRHzWXKJn/ry+qnmBjzMrKLEY2+Q
         03d9vlxQHI+52hJECVZEjEp+LgRt/mYPyq4a0ki8GYS6O+h8pNQ6NaZ1fZ+E1aS/SP6z
         bQAN6eBf7DFLdNmsKgNr9q+oy+SCKT9gulHdzBLInbZkZFJ7VyM+sQBO4nrSKihzMqot
         yI/FF4NK5dGIt1TtKMB28AoLUR9ZEC/71imjpsLH/SUDNyLxcEQD2/cep8ResaCnWeVj
         3tqD4Z7SqZybzI6RayPBh1RQIMH9IN3wm543KfddN6VeVzEXgFsz0CbBaATxbXbYzQ65
         LshQ==
X-Gm-Message-State: ABy/qLaLkxSG0r93+0uIaXu8Df07T+KAkIbOpWaUIKrC8LDwrWeoPR07
        4Pe+x5e3BCLsGdL2dIPSxgatkw==
X-Google-Smtp-Source: APBJJlHOik++wv/6w70KRSrv0bT3G7Snk21fU2xY9sNvvffzWq/fv3vPH6Vbrndhf8+kCMQIlNUieA==
X-Received: by 2002:a2e:2e17:0:b0:2b6:cd70:2781 with SMTP id u23-20020a2e2e17000000b002b6cd702781mr2298551lju.12.1688774773242;
        Fri, 07 Jul 2023 17:06:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u20-20020a2e2e14000000b002b6c61bac2esm988436lju.92.2023.07.07.17.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 17:06:12 -0700 (PDT)
Message-ID: <fc5501cf-c335-81f7-1ad7-26fdc1b6922d@linaro.org>
Date:   Sat, 8 Jul 2023 03:06:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] drm/msm/dp: remove pm_runtime_xxx() from
 dp_power.c
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
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1688773943-3887-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 02:52, Kuogee Hsieh wrote:
> Since both pm_runtime_resume() and pm_runtime_suspend() are not
> populated at dp_pm_ops. Those pm_runtime_get/put() functions within
> dp_power.c will not have any effects in addition to increase/decrease
> power counter.

Lie.

> Also pm_runtime_xxx() should be executed at top
> layer.

Why?

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_power.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
> index 5cb84ca..ed2f62a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_power.c
> +++ b/drivers/gpu/drm/msm/dp/dp_power.c
> @@ -152,8 +152,6 @@ int dp_power_client_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_enable(power->dev);
> -
>   	return dp_power_clk_init(power);
>   }
>   
> @@ -162,8 +160,6 @@ void dp_power_client_deinit(struct dp_power *dp_power)
>   	struct dp_power_private *power;
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
> -
> -	pm_runtime_disable(power->dev);
>   }
>   
>   int dp_power_init(struct dp_power *dp_power)
> @@ -173,11 +169,7 @@ int dp_power_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_get_sync(power->dev);
> -
>   	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
> -	if (rc)
> -		pm_runtime_put_sync(power->dev);
>   
>   	return rc;
>   }
> @@ -189,7 +181,6 @@ int dp_power_deinit(struct dp_power *dp_power)
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
>   	dp_power_clk_enable(dp_power, DP_CORE_PM, false);
> -	pm_runtime_put_sync(power->dev);
>   	return 0;
>   }
>   

-- 
With best wishes
Dmitry

