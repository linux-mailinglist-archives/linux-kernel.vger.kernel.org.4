Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAA720A90
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjFBUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjFBUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:52:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE653E43;
        Fri,  2 Jun 2023 13:52:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso29998611fa.2;
        Fri, 02 Jun 2023 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685739166; x=1688331166;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7HA5PHTw9F2n8V3VLqOSLter+XfMCtTqmZlHwN6Bdg=;
        b=gj6sXhQvonQVSdIiSB1BGk/IiVLQXeTWM9CwNIhNChBvOUPISH6oe2FYdUdH1rtu4p
         eisBvFgaXNDsikXAef+m2M79c/JDeUd3X1BjhXjvaOcX+Cw5G1mShS8a/JVnTK+/iuNr
         s4mInvlhGV4fa1scX3oBJ6JbjkADzxdw8g3Bxcrd2AlH/YGRFWHNXEmf86a6toDfRAQD
         zn9/6yLyuoTA3ZrmovLT3dANQftYZxwBibb0/CiFMEYGATaLZTgS3ZHsexjHyEZB0W9j
         f77xDJ0QokPXIiysXTfGGxuIeo8X01ggBSTvcqmztL5DkgGcvNskXDiq7m8kSMRQCNln
         /+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739166; x=1688331166;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7HA5PHTw9F2n8V3VLqOSLter+XfMCtTqmZlHwN6Bdg=;
        b=KCPblEw2u/Mn9FYWtxupTlDjEQDcKm+68NudOe0I36+1a7jpeqUl7ileCFAeywq1I6
         gzgw+KrSd5cZccc85rYbeB1nvTI0xiP6Qylfh82ycOhfmAylMffJjOCQpiooX+p+hwkR
         JInRuXg5b2t8bDHD0TcDJgKSFQl0R7Y0IqriVC+jor0yvu7VHfcbXL/0LbRJdINgVAEF
         7pb/bKAhSdvK7l89W++0cIyg0n6pPAWUX7w/evICPoKCEKB6mp1oiH6PG4GeOsE9YheW
         RSExhK5LUn4TTn9+HTXZuvHftZXRXzfw5/Z+0JC3GsQ30/Q9sXrEUx0RrhZDHuyaFfAu
         9dHQ==
X-Gm-Message-State: AC+VfDwbOXAQZBkBLHMx46vV5rNnTHNSJiPaZ9Iq9c7dSS2svbszEAVp
        qDPqgCa7LOC06NDcXNG+Hg9x1Il2HTs=
X-Google-Smtp-Source: ACHHUZ6jE2Tl+nrC/l+BVPHNQQ+KXhOBAzQWqPmUuv4iEGF6bf9bbtEa/5m9+UDFagoHm4icoJnWCw==
X-Received: by 2002:a2e:934f:0:b0:2a9:9e99:a508 with SMTP id m15-20020a2e934f000000b002a99e99a508mr651818ljh.53.1685739165706;
        Fri, 02 Jun 2023 13:52:45 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c15b:cc00:2863:962e:5942:4889? (dynamic-2a01-0c23-c15b-cc00-2863-962e-5942-4889.c23.pool.telefonica.de. [2a01:c23:c15b:cc00:2863:962e:5942:4889])
        by smtp.googlemail.com with ESMTPSA id u21-20020aa7d995000000b00514a3c04646sm1042851eds.73.2023.06.02.13.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:52:45 -0700 (PDT)
Message-ID: <bf2d2814-5881-0f42-8b62-89c043b66e22@gmail.com>
Date:   Fri, 2 Jun 2023 22:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     George Stark <gnstark@sberdevices.ru>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru, Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <20230602103211.2199283-1-gnstark@sberdevices.ru>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: compute cnt register value in proper way
In-Reply-To: <20230602103211.2199283-1-gnstark@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.2023 12:32, George Stark wrote:
> According to the datasheet, the PWM high and low clock count values
> should be set to at least one. Therefore, setting the clock count
> register to 0 actually means 1 clock count.
> 
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
> This patch is based on currently unmerged patch by Heiner Kallweit
> https://lore.kernel.org/linux-amlogic/23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com
> ---
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 834acd7..57e7d9c 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -206,6 +206,11 @@
>  		channel->pre_div = pre_div;
>  		channel->hi = duty_cnt;
>  		channel->lo = cnt - duty_cnt;
> +
> +		if (channel->hi)
> +			channel->hi--;
> +		if (channel->lo)
> +			channel->lo--;

I'm not sure whether we should do this. duty_cnt and cnt are results
of an integer division and therefore potentially rounded down.
The chip-internal increment may help to compensate such rounding
errors, so to say. With the proposed change we may end up with the
effective period being shorter than the requested one.
And IIRC this should not happen.

>  	}
>  
>  	return 0;
> @@ -340,7 +345,8 @@
>  	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>  	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>  
> -	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
> +	state->period = meson_pwm_cnt_to_ns(chip, pwm,
> +					    channel->lo + 1 + channel->hi + 1);
>  	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>  
Doesn't channel->hi have to be incremented here too?

>  	return 0;

