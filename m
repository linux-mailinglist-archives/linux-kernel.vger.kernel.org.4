Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B64626982
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiKLM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKLM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 07:59:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284060D6;
        Sat, 12 Nov 2022 04:59:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f27so18257132eje.1;
        Sat, 12 Nov 2022 04:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxgZUhoZIdG7gFB84P/XyUiuXQ5Zy1yGT9mDuPve4q4=;
        b=g9LoZXUsJS6aWbanCCtLneDMm5qg8qFyIqmFfMOECW8GWEAbhT+gth5JyIAFzF/ZQS
         6wMuAypuITkpKGjG3skXvWP3LqHnwrPpMb+6Eax41OCKuBdq+GeXqVL9L1xvCyTKOoPt
         z+lTogAveyAwtRcEcGPr5QQ4Wrq1gNIX39aAkmAfoA62uQ87X2rLw+cPEuuoQmgVjgjX
         LNRPaCmzF7JZl6OGlpiD7WmoKzBt7qVuFOuOOxch2tlSn7ji+yGOCJykWxTsG3Dk6rL7
         udkVbzx8PCYY/h/U//acchHXYzcOzAQ7utUzhy26orl1kjBE2voH1fiwJx65222Ym3sB
         +QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxgZUhoZIdG7gFB84P/XyUiuXQ5Zy1yGT9mDuPve4q4=;
        b=zPWAyc9SMux445fFVn4WhA7/HmlnlvbWPR0zPVyuZer+qR7C+CLSum28pgZHw57oxq
         T8SlSc8DvYpdR03+8Fs+vAryqaz5G/Y/q555U3P9rE7sV+ygGE/+Mz/JkquVVWUwScR3
         bWthFetnj57S3/5Vb87KEvIRpquRwR3FVy7zjvdNb3BuJK7Af2zKkTO8o3YPD5BUH7wt
         PvE70P4QQBukZST3+8NzgNQ2Q2ZalcFnbICBIdMptzyoqoil2IhkLBxpAKSbtxzRpVfc
         lDRJrCzSvUPctWXsk+hb1foIL7RAvUF/tR6OafU5vS0QYPWE7gry4Q3gIFt5D9Vq4ks1
         g8/w==
X-Gm-Message-State: ANoB5pnsC3ToANS8UsiYfdjUJioZSVC1mgcJ8VhPj85gwvPDI86FBcOp
        vdnjDv4C2sMb7zK7J1dQ11YIx/u1pJU=
X-Google-Smtp-Source: AA0mqf46WbgZkGJXrH9oR/R47NByuem807cClU3zAYvEurttA2p9qcjTKFAeJJ7atFdwGl8RMsKp/w==
X-Received: by 2002:a17:906:2b57:b0:7ad:b45c:dbe7 with SMTP id b23-20020a1709062b5700b007adb45cdbe7mr4959707ejg.617.1668257986893;
        Sat, 12 Nov 2022 04:59:46 -0800 (PST)
Received: from [192.168.3.32] (dh207-99-143.xnet.hr. [88.207.99.143])
        by smtp.gmail.com with ESMTPSA id v19-20020aa7cd53000000b0045bd14e241csm2302900edw.76.2022.11.12.04.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 04:59:46 -0800 (PST)
Message-ID: <3d1f5b5e-b444-cd9f-e0fb-69f834b0d1d6@gmail.com>
Date:   Sat, 12 Nov 2022 13:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
To:     Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20221111113732.461881-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11. 11. 2022. 12:37, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The OF node store in chip->fwnode is used to explicitly override the FW
> node for a GPIO chip. For chips that use the default FW node (i.e. that
> of their parent device), this will be NULL and cause the chip not to be
> fully registered.
>
> Instead, use the GPIO device's FW node, which is set to either the node
> of the parent device or the explicit override in chip->fwnode.
>
> Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Hi, I can confirm this fixes the blamed commit on Qualcomm IPQ8074.

Tested-by: Robert Marko <robimarko@gmail.com>

> ---
>   drivers/gpio/gpiolib-of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..55c3712592db 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>   	struct device_node *np;
>   	int ret;
>   
> -	np = to_of_node(chip->fwnode);
> +	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
>   	if (!np)
>   		return 0;
>   
