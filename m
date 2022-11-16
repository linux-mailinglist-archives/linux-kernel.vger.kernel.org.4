Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52E62B616
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiKPJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiKPJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:10:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FB7248E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:10:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id cl5so28808292wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+EWQaz6AjRSmTYx1xAEW3ez1+waZqAXR8+3Ii5G6qKY=;
        b=Jd5kxV1FSvOV6K7/6NukSVogzsjR8X+lPT7Ct8DTbnvGDiUGxegx2yd/nsSNJ6uRpa
         2ew2U+0EN1+VHBkBlGKM0saoaLDKkDfIjFRheK/Hhp3HUh3wBCQ8q8l8Qcwa5I+yjARJ
         j/uS3wa3AyTIsFEzcSI30hJnGjIb5byhITw81TjyaOrXmPTvr5uAfj/Fci1VUbpbww3g
         TBwhUG6RgdOYsSVilN0zXmhvSwq8fBTDFO5pAb99PTrXn1ZCvFHDZMWoNGsebDBe1jWK
         m0gcXfhMO75ViKcPsCpYcWIf/BPPE5aBbLEHD3L16qnYikygymvhfTaVqJSueCXr8Xfa
         w+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EWQaz6AjRSmTYx1xAEW3ez1+waZqAXR8+3Ii5G6qKY=;
        b=maebRAoCl69lGtWpvSturwBbr7XtYIcX5BKYGJwhWhqdXUuuGsHVHYi+e3dwNXx7vj
         pvQZRkjfovzE/uLsYI+6rHAXIFOZ6wlrmHAVkg0aQTCR5FA89fEXrhbJHUQ2Po2Nm+AD
         2GA873SqmWIgEKpRhWjymwGHp6ox91odK1dRfZSrkSdHspTSZife56jlOQpMADxx9Mtc
         GNqNJARXQUAeCryJn7LcWNpDrWjqt2aAE6LRdi396kgnEG4bYW33MehgP9CEqbPGWdyM
         sOXj7TQohXfV5lD0PtQbF69eSbPzXUcjghhW2SLEToQ0ZRp5qbtu+49OoSfYs2I5DyI0
         qL6Q==
X-Gm-Message-State: ANoB5pmx3c1fU5M7HbKQcHpQzoNbFBqno/SymqsB4Rv6cg0ijeha7hNE
        xiea2EGWPiSuOK7XuZHu7SOemA==
X-Google-Smtp-Source: AA0mqf7qtmWKrvfnyLLlcsy5HreT4080D+PHLRUfJtM7qj9c/DZNd9kmcoIZPKtDRZVHFWldDUgkjQ==
X-Received: by 2002:a05:6000:22e:b0:236:6d6b:fb56 with SMTP id l14-20020a056000022e00b002366d6bfb56mr13467483wrz.198.1668589800269;
        Wed, 16 Nov 2022 01:10:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a03:71a6:7a9d:9c71? ([2a01:e0a:982:cbb0:2a03:71a6:7a9d:9c71])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b003cfa81e2eb4sm1493890wmq.38.2022.11.16.01.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:09:59 -0800 (PST)
Message-ID: <2ce5bc21-c4c5-ed61-3683-3288ed1057e2@linaro.org>
Date:   Wed, 16 Nov 2022 10:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org, 'Abel Vesa' <abel.vesa@linaro.org>
References: <20221114202943.2389489-1-bmasney@redhat.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
Reply-To: neil.armstrong@linaro.org
In-Reply-To: <20221114202943.2389489-1-bmasney@redhat.com>
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

On 14/11/2022 21:29, Brian Masney wrote:
> Note that this is a RFC patch and not meant to be merged. I looked into
> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> board (sc8280xp) where the UFS host controller would fail to probe due
> to repeated probe deferrals when trying to get reset-gpios via
> devm_gpiod_get_optional().
> 
> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> pinctrl driver doesn't define one, so of_gpiochip_add() should
> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> happen since the fwnode member on the struct gpiochip is set to null
> when of_gpiochip_add() is called. Let's work around this by ensuring
> that it's set if available.
> 
> Note that this broke sometime within the last few weeks within
> linux-next and I haven't bisected this. I'm posting this in the hopes
> that someone may know offhand which patch(es) may have broken this.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   drivers/gpio/gpiolib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..8bec66008869 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>   	 * Assign fwnode depending on the result of the previous calls,
>   	 * if none of them succeed, assign it to the parent's one.
>   	 */
> -	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> +	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>   
>   	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>   	if (gdev->id < 0) {

Fixes boot on 8550 on next-20221115

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
