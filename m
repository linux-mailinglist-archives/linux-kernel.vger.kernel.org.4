Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9467CAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjAZM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjAZM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:28:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1B4942F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:28:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n7so1605113wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUsFc75hI6TZHDszdvKDaz8iQW9fEFrZhZGH/dc9Zw4=;
        b=BN+d3LISu6a9WAmIRfCGEq3LV3ZEGBMmPnsj1ySWKY9C+nLw0I9WA7/FvQ6hMatZYM
         hKzU04mq0XhzCqwQ2Z4iYx0GUxKRU8vIYwl1FP29qDg3sF0oFZadjRHuB5stRBUVP+SP
         ZpM8annmXq+46AWqUDyH1RXcVZuPs7fX227vymzSjIA5eetbIxuIXsN61xDSskvobZap
         zXr2oEvXU5QiyweG+E+Nxpi67tzciHoPVxXuleq5hvbeQ/VTefilOfQvk18o+lzMEMFs
         kR26zPcNUWX5xNPMmHqxedVO5/ktHkc0JTu+P1972yyGwPFF1XM+jaWmP5J+WTPucOpm
         Xkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUsFc75hI6TZHDszdvKDaz8iQW9fEFrZhZGH/dc9Zw4=;
        b=4euy8bzbv45NK/gnY0w3M2xqMOGqb5yAO8sL5qlnFCeSW+Rv+V+Q0IKFBE3wRllvfW
         J9jYxn5J8gVJR474Zriz01uP0p8XwmvFulDS0a3IOs1GrXrWUcGIFLJv4gd8aOiF5Vfb
         NLz5ANSHHvhduC5B3PL/uR9T7tGjU6ATrpEBdMq6SF8pQq5WErY1M1ddg6zBMw6NvCjB
         OwW1TRYj0N11v1p/Vru7+pH7aWHz7fyz1cqgsiGtp9mZJbMN7EXz0533UWLwKr5pXC1j
         j0M33lrCDjIOayqnmaXmeJVrkUiAOemxC4qI6bdr7xrCActTmq47Pq504DX+lTGC86y7
         Dq2g==
X-Gm-Message-State: AFqh2ko6+UwRq3horZU1ON7sI6hw2UJ23IUbi/O6EYv2il2XkwXEzx9O
        275du94OC4+dXvNUA73Z9IgTAA==
X-Google-Smtp-Source: AMrXdXtQZiQtIGhUwqlUb6hRQYC42p3Tl0CsgkP1SwkHsrGvt1b6dzuRXRIRm5S+/M/Gst+sUSO5Jg==
X-Received: by 2002:adf:e30c:0:b0:2be:1fae:690e with SMTP id b12-20020adfe30c000000b002be1fae690emr29396197wrj.50.1674736130352;
        Thu, 26 Jan 2023 04:28:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm1222424wrp.53.2023.01.26.04.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:28:49 -0800 (PST)
Message-ID: <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
Date:   Thu, 26 Jan 2023 13:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Content-Language: en-US
To:     nl250060@ncr.com, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 11:17, Niall Leonard via B4 Submission Endpoint wrote:
> From: Niall Leonard <nl250060@ncr.com>

Subject: missing "wd,mbl-gpio:" prefix.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Added optional "no-input" property

Missing full stop.

> 
> Signed-off-by: Niall Leonard <nl250060@ncr.com>
> ---
>  Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> index 038c3a6a1f4d..9405f9dad522 100644
> --- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> @@ -18,6 +18,7 @@ Required properties:
>  
>  Optional properties:
>  	- no-output: GPIOs are read-only.
> +	- no-input: GPIOs are write-only. Read is via a shadow register.

Why this property is needed? Why driver cannot always use shadow register?

Anyway, please convert the bindings to DT schema first (see
writing-schema and example-schema).
Documentation/devicetree/bindings/writing-schema.rst

Best regards,
Krzysztof

