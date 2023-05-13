Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E937701604
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEMKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjEMKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:09:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16DF40DA
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:09:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f475366522so27649205e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683972590; x=1686564590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnNuv5X1Xlzm3gO020ajBoMpKarekBaQdbE/morep5c=;
        b=Uc4tsFxuG3QbwEqQOlwJOdMRX0Ifkb10723gyQPdR5bEtUCtHoXT4ysHtaThnpXict
         kI44BkXoOhlH+dzmq9XGEPaJwqMjpyx+Wzgx1U2RAnEHGkDuafuWu0ehpyyW7f/76E97
         ngbMUTWKzpHT/9ekaoxKFnOuWuyxjLz9Z8VPwZWXKomsuhJSQUtVtE7/cIJ3M4THNuQE
         ZbQyZuVXt2t9w2zbt0FscK8kKxHFmgUfUPs6Y0+dPKv/f98T2Tt/rUEDwIMirmBm2vB1
         kLTMigLAK9BAFiAuwieRuPgqvLlFp12sh8+vA19KJM9SVGXILB/m9AHcaTqaifYWVwh5
         4aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683972590; x=1686564590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnNuv5X1Xlzm3gO020ajBoMpKarekBaQdbE/morep5c=;
        b=A0I+9iQaHavTIekANBPI8FMgCYhg+ZQDwVYgGNHf9FEM6Ul1SScY6stlnL2PVN3cqL
         FDXoKhHzEAVpILjVx94apwCYjoh0xf9NHRqiJ8hH6MPUf7N6Q+g+NInZ/EUb9uMlL5jA
         K/wz3TaSLAdDDi4wUtIr34dij8WCO7LSc4l5qa8/y8W9pQxvZhZI9qNMtKlx1L4rjkIr
         EypmwLlmYNSOdUlKIMgqr7HajNewrrR1ZVYE37vJnVhPRwfG4KBgTxTlUYbQRoGk/tj5
         2HsN9IiPj8oLrpbKQ+sAXt8DzfvuNrrbLhfBnjRdGqThbKPYG61wEIN2xZrXzii0VCtB
         3FOg==
X-Gm-Message-State: AC+VfDyCkOHd7dfS+DGFOPY6FNs8qf0ez24ZfrzOwCszsdJdPNirIYzh
        DoqqTgHmb5MYI63fFkWt5iJdsO1T9pE2iMCXID7zTg==
X-Google-Smtp-Source: ACHHUZ6pg3lMzOl23CuN3vSy3QKwi3t/pwwYvvLBajLERWjCCkjYwS0kKxupdcdFGgwNdBO7acIEtw==
X-Received: by 2002:a1c:e908:0:b0:3f4:2b1a:553b with SMTP id q8-20020a1ce908000000b003f42b1a553bmr10905660wmc.28.1683972590359;
        Sat, 13 May 2023 03:09:50 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id l15-20020a7bc44f000000b003f4e3ed98ffsm9259138wmi.35.2023.05.13.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 03:09:49 -0700 (PDT)
Message-ID: <cab829ec-5763-1352-618a-adad8c01227d@linaro.org>
Date:   Sat, 13 May 2023 10:09:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] leds: qcom-lpg: Fix PWM period limits
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Luca Weiss <luca@z3ntu.xyz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2023 16:55, Bjorn Andersson wrote:
> The introduction of high resolution PWM support moved the parenthesis of
> the divisions in the calculation of min and max period. The result in
> both divisions is in most cases truncation to 0, which limits the period
> to the range of [0, 0].

Huh, TIL C gives multiplication and division the same precedence when
deciding order of operations.
> 
> Both numerators (and denominators) are within 64 bits, so the whole
> expression can be put directly into the div64_u64, instead of doing it
> partially.
> 
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> This fixes the regression in v6.4-rc1.
> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index c9cea797a697..7287fadc00df 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -312,14 +312,14 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
>  		max_res = LPG_RESOLUTION_9BIT;
>  	}
>  
> -	min_period = (u64)NSEC_PER_SEC *
> -			div64_u64((1 << pwm_resolution_arr[0]), clk_rate_arr[clk_len - 1]);
> +	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
> +			       clk_rate_arr[clk_len - 1]);
>  	if (period <= min_period)
>  		return -EINVAL;
>  
>  	/* Limit period to largest possible value, to avoid overflows */
> -	max_period = (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV *
> -			div64_u64((1 << LPG_MAX_M), 1024);
> +	max_period = div64_u64((u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV * (1 << LPG_MAX_M),
> +			       1024);
>  	if (period > max_period)
>  		period = max_period;
>  

-- 
Kind Regards,
Caleb (they/them)
