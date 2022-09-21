Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD55E53A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIUTL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIUTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:11:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F5754B8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:11:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j16so10860164lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DsL/1QAW5Bz74NZ7JK4PQf/yeBCXaXFI7fLPgzIIgJ4=;
        b=QTCIWf1sf8YYJTHRUCzPsvcipWx3NlPq4la99JrxuUSJ6+dCeA1P9nVQtc/kmAHl7Y
         DM9So4VlJzfCgzpKxBSGKyQPEZJyDkAgL1++XZY3kDeYKTJQCvVZl9TvlsqBZmvVhmb9
         JLVBswq48TeMuQRgDGiiSiPGYeJ0jY7TkuAsNfZsqwjrn1eed2dr2ny0+VQIb78q9ie6
         ANrQpu6eG1QRDEiC5tPQMyFgOBrZAa+ofcrIPPiSPo7N+Am4U+cc78FVwCBOBw1b3bqD
         b2r9+3mw4L0fe6hlSUyrxV4e0A670NyLbcuPfNh1menjQTxQ0xtOzRsV6yDB9j5A2Ce6
         5v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DsL/1QAW5Bz74NZ7JK4PQf/yeBCXaXFI7fLPgzIIgJ4=;
        b=YJ3YCugaV1pdHD30xUvWDSToBkqmQxokW8ERGNwPkBsq29W23EOs/ZCntGPLYnPrer
         B2zkV9MtIPtMrxKjjYPUyYOMijnjP0nKxokBYzcazehMkt1hQLhj2TGWpac1X4/O8PsR
         IbZ7hSyjXpUtd+wDWBS5DGMDN78qS+0m1Q4U7S/cuxudefg5sxqLk8Ivgz2qcDmbcS5R
         b/ZWHWmVAkK2iQJrPd8DATMzpkJN9kMbd852V9ktuDMA6xrOE4o8B2L9kZvrkF8Ffdhn
         n8oMLkHnoBCCWR/gwWPccdOcukGdoEn4lX24uwAdRfKYsf6/gGpLB83moy+eVrTFIP+T
         o7jQ==
X-Gm-Message-State: ACrzQf09enw3j6nvAQ3YSmEshneXGPDEk594mpPky1eIlnYvUUkEl+5E
        xybLmrHNpEFteerp4IHbl6Gv0g==
X-Google-Smtp-Source: AMsMyM5JtXoqCMkS9rVMqv5o56OnDmtdacZs1FE4sReyzPtkUfqOz9nwTvu+zeti+lCGbtRNZmO3vQ==
X-Received: by 2002:a05:6512:2006:b0:49f:6087:124a with SMTP id a6-20020a056512200600b0049f6087124amr9099091lfb.163.1663787513970;
        Wed, 21 Sep 2022 12:11:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b004998d9ccb62sm557803lfo.99.2022.09.21.12.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:11:53 -0700 (PDT)
Message-ID: <482c5a54-3d53-5760-fc8e-8aa3b9341707@linaro.org>
Date:   Wed, 21 Sep 2022 21:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 3/5] dt-bindings: iio: Add KX022A accelerometer
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <eb3edbb63c117f93e8ec534f50d8e3cf91ab3041.1663760018.git.mazziesaccount@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eb3edbb63c117f93e8ec534f50d8e3cf91ab3041.1663760018.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 13:45, Matti Vaittinen wrote:
> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The senor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,

Thank you for your patch. There is something to discuss/improve.

> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g) and probably some other cool fatures.

s/fatures/features/

> +$id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM/Kionix KX022A Accelerometer bindings

Drop "bindings"

> +
> +maintainers:
> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +
> +description: |
> +  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
> +  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
> +  KX022A can be accessed either via I2C or SPI.
> +
> +properties:
> +  compatible: kionix,kx022a

Missing const. I wonder how did it pass testing...

> +
> +  reg:
> +    description:
> +      I2C slave address or SPI chip-select.

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  io_vdd-supply: true

No underscores, so io-vdd-supply

> +
> +  mount-matrix:
> +    description: |
> +      an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +          accel@1f {

Messed up indentation.

> +            compatible = "kionix,kx022a";
> +            reg = <0x1f>;

Best regards,
Krzysztof

