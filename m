Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF5604998
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJSOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJSOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:43:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396EACF44
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:30:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so10771490qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEmIhwLP6JWJlQRt/3w8mhy6Yg1o3TLKHqQiOhMxy0U=;
        b=ilprgxZy/nxFTTz37DvZ1mP/ydqyP3gwcaRJpuxF1UGyotKOl1P0TiyF+qbRDXAVP+
         akYeivho+XgXIdhxz/1VcgkOGZfNaJDsQECdfdTkS6TTo2LVgrhTqAm6ZgwAdYEwfXlO
         zxfaDJfLj27/AjML/XccPnZwVbKFy9U6IkozVVN5YTtOkJUYLEgBeUy/uDP62/+Tw7lL
         tMpbux0+ueArUxiap5maUr7qhn1u6sU12qPulUMS8yLmn70JLDoPH+st0+0ZPCAaAHZ7
         Dcq0zZ6TK48SG9SefGqm3jvUjdISTD6ETlJmCPAzI73W3Io2vVKh/okOJTkgLCpE94Kt
         S4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEmIhwLP6JWJlQRt/3w8mhy6Yg1o3TLKHqQiOhMxy0U=;
        b=SCfkG6cZzXZlkn2XwtGU8hTnvHBuTekGnKul7+Kld5Fbss/ec19eVezU6MXbueJ4Va
         rUqatk7sU0W4fQj9KD/hBYGGbnAk6BQjEGCJAgfernpVQYLArWL42x2xsWg58U+tb6oz
         Ha9moReFe9j8OAsrR2kdn2EP3WBWgMM8le4zS81SAgHmMtSGRtwCFCY9BZOishbINwST
         v9AbBpuVVDfrSgrzEG9Tk44RBHdJFsbDucBdxY0MF3vGGFnywRALSQ+1RafOtIDT2kYN
         2N2oG5Q1IA84G/OhGorG/FYWpMcDrTiP6o5KurWE1CvBuXdAhVoa5ZtWArNMQ3/XPc9F
         0GcA==
X-Gm-Message-State: ACrzQf0A12S9I61i1Ih8bXsTPQXcNzW+irZ3QFteEKIb13lhKROhslVv
        8Gw6eEu8vx2V3nGZkxzNEpWhmA==
X-Google-Smtp-Source: AMsMyM49VXrZGh0Y6/lHBCG4YpU/HQkprtBYeSAxBKwVJI5YDUWZ81RHBa5iViI4NMMV2LjRZt4rPA==
X-Received: by 2002:a37:9ac4:0:b0:6ee:caa8:fe2f with SMTP id c187-20020a379ac4000000b006eecaa8fe2fmr5788394qke.638.1666189768362;
        Wed, 19 Oct 2022 07:29:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u24-20020a37ab18000000b006bb83c2be40sm4993247qke.59.2022.10.19.07.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 07:29:27 -0700 (PDT)
Message-ID: <d355ee40-5905-4d10-8300-81e9a63117ee@linaro.org>
Date:   Wed, 19 Oct 2022 10:29:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 10:01, Amjad Ouled-Ameur wrote:
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
>


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson-gx-spicc
> +
> +    then:
> +      properties:
> +        pinctrl-names:
> +          minItems: 1
> +          items:
> +            - const: default
> +            - const: idle-high
> +            - const: idle-low

You should also define in such case pinctrl-0 and others.

Best regards,
Krzysztof

