Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327426B9F04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCNStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCNStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:49:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94CB7DA4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:48:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so14391764edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZtUeNifEsShVGXcUZj8HUIQHk3f4c3CGvde/vja6vM=;
        b=cdpwU+nj2+qqq5a7xEsjypQv4X40tt6xtXN2FRrFQ7SUj+/qKnAdDljrUx42bK2qJU
         CPxs8Qa5mnOtLLIaxkTi8I9nGOFj+k9auQMGHp7CzvzDok7NcfU6IoGCzt1x3YObye9M
         dwAKAk982bpUnqtWkV6wtHKY/gqjcugQezGA5X0Kfgad3a6bAzG+c8WUojRKZMoRIQCf
         nDgNhaNlI97IQ9KHsOsfyt5Xcp5SLNW+iB28meKn64cEmmNOO/piXsV5EvIUmQ7MLkdw
         8UEL631pqzNrXFdYM4tHFQkQJISLsVB1m7PdwUrPGmsRdZV7iTC1gIueuLMsrEjGLRIi
         thww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZtUeNifEsShVGXcUZj8HUIQHk3f4c3CGvde/vja6vM=;
        b=bMt2aoJjSeeQFR/mfqBnGelp3NuSS6lKwrDGE7wCbr304aXKwRFugC44VDfnHtEHo6
         QiWy98+FsU+zB5a6rIaKjrxwDVzm2wNLP+xzHawdHJSDf88SVjh0VdKGSgC0entjIqMO
         VnhVjwd10wgABz1dYDfIqTDY2KjOSZSbwlrQ0MOGxL/aKKeoHBLAH8iJGorpkgCq9X25
         f4yKUgbRUn666MhCv2vyV03cHYYrNfZNZS1clnbLrQR2jfvVHm+qEu39oxb7v2dW9nxO
         r+mwjVpfuhUty1uKW2zmIbIO9i+akNYm97InLlQ+R9aODBtJ8pFUI06CC6nvixBtMTUA
         UJcw==
X-Gm-Message-State: AO0yUKU6iXTGYdbNo2Mj7nwhq9B9BUBW8phhATLlUdZne7L21pU3Xx+P
        aIVxnSH09WXSa5bWw2sjKLx2d6kJ7YkJSGMOC28=
X-Google-Smtp-Source: AK7set9+DjG/kQaa5hXlAtBBvUnw+2gy0DI7AE7CENSX2wrJmX1iIi+nV13X7dL7W2d9uYp6Ets1dw==
X-Received: by 2002:a17:906:f1d2:b0:8b1:7fe9:162e with SMTP id gx18-20020a170906f1d200b008b17fe9162emr3594640ejb.47.1678819723160;
        Tue, 14 Mar 2023 11:48:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906409500b00928de86245fsm1461068ejj.135.2023.03.14.11.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:48:42 -0700 (PDT)
Message-ID: <83de8add-b15e-8578-7bf9-56c3f26df836@linaro.org>
Date:   Tue, 14 Mar 2023 19:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230314092311.8924-1-jim.t90615@gmail.com>
 <20230314092311.8924-2-jim.t90615@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314092311.8924-2-jim.t90615@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 10:23, Jim Liu wrote:
> Add Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver support.
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>

(...)

> +	gpio->nin_sgpio = nin_gpios;
> +	gpio->nout_sgpio = nout_gpios;
> +	if (gpio->nin_sgpio > MAX_NR_HW_SGPIO || gpio->nout_sgpio > MAX_NR_HW_SGPIO) {
> +		dev_err(&pdev->dev, "Number of GPIOs exceeds the maximum of %d: input: %d output: %d\n",
> +			MAX_NR_HW_SGPIO, nin_gpios, nout_gpios);
> +		return -EINVAL;
> +	}
> +
> +	rc = device_property_read_u32(&pdev->dev, "bus-frequency", &sgpio_freq);

NAK. I don't understand that approach - you dropped it from the binding
so the binding will pass review?

> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "Could not read bus-frequency property\n");
> +		return -EINVAL;
> +	}


Best regards,
Krzysztof

