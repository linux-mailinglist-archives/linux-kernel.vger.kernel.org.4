Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C6665753
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjAKJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAKJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:23:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941025FBD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:23:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso13853975wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCHQ33qmTPBoL9vCuW97RQR7YPeZg23yIQSrtsZ57nY=;
        b=N9QhRW4dBka0TDujevzLX+HeWiponZl/IUCLOq9qO1MiME7qVRhtjOGPPwaM2Qw+QP
         UL4qg37RINhnS3gTlNYXiz+aCbEETqRjN7PhGpMnDKAD8Z3p8LoPNNkcp5De41BODRqz
         bvs4QiQqNO5FvvF9+5+iqOQmQJxBHNhINWtrc8ZrjKOi5CfpRu6q+37FWtij0Hs4eXZP
         eMvCbr6alagBF7hetw+7Qv/pdOvwk+58BH4WrdRo90kqpYEkCKMsWWq8U2wISQlY6jMw
         UU40tS1yRh7XCOGOnzbmNppczW85yX1Uyp4XZN3/clcDUtY3LLCVsa/IJeV+vPzW+6qD
         mCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCHQ33qmTPBoL9vCuW97RQR7YPeZg23yIQSrtsZ57nY=;
        b=zrHRO3ASkCHk3TDjsHOxv9Kx10dsA5Sqy27ir6jgu0oyXh646SR0PD/HtmwrEscYj9
         WUdyDQUmWK3v8/2amD4/LR3R6ueCxUc2pJt96oH12Tw0lpUJjXvxIlnULA1osvp19M9q
         A5vuyxONzDSjSIhv0QIcCJoUePKXA0tNv+ng8FcPgKwMz5M+4CbtQ2gDN9ubZY5rVeKJ
         LuZHCWXHWWUQ9VsqcQ+gMF+y79CtxH+N1mzW+IBpg8CN2O0+TBMTSht+9U289+o+Qi5w
         wDpcTXCV7beDHRYDa3zWlo6ajMvkpYw9QJWjlr5oiG8F9NYAODf7JsOZ/DoLyUyd8nja
         2dJg==
X-Gm-Message-State: AFqh2kr6PbQNMSqi1wpnwCbADyxPezmFd34ENpHxXNDJBLiTkrxz4DVa
        X6aanc1Oh8Y6LxDToIccnK1pfQ==
X-Google-Smtp-Source: AMrXdXtigiQmPVFGTglR+qRQyd8ks4S9fkpqM62Z5sgB9z/r2a1LtwsflCamS478OXUukaBYId+UCw==
X-Received: by 2002:a05:600c:154b:b0:3cf:674a:aefe with SMTP id f11-20020a05600c154b00b003cf674aaefemr51820927wmg.22.1673429003135;
        Wed, 11 Jan 2023 01:23:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003d96efd09b7sm26023635wmp.19.2023.01.11.01.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:23:22 -0800 (PST)
Message-ID: <714ec9f7-486b-b06f-f070-27c6db19ba3e@linaro.org>
Date:   Wed, 11 Jan 2023 10:23:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230110160124.3853593-1-hugo@hugovil.com>
 <20230110160124.3853593-3-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110160124.3853593-3-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/01/2023 17:01, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Please test the bindings before sending. It's better to use tools for
review than humans... we are all quite busy.

> ---
>  .../bindings/iio/adc/ti,ads7924.yaml          | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> new file mode 100644
> index 000000000000..a9d3e8778d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +description: |
> +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +  Specifications:
> +    https://www.ti.com/lit/gpn/ads7924
> +
> +properties:
> +  compatible:
> +    const: ti,ads7924
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage (AVDD)
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:

Put it before "required:" block.

> +  "^channel@[0-3]+$":
> +    $ref: "adc.yaml"

Drop quotes.

> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> +        items:
> +          - minimum: 0
> +            maximum: 3

Test your bindings, so you will see error here of missing label: true.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +

Missing additionalProperties: false.

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@48 {
> +            compatible = "ti,ads7924";
> +            reg = <0x48>;
> +            vref-supply = <&ads7924_reg>;
> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                label = "CH0";
> +            };
> +            channel@1 {
> +                reg = <1>;
> +                label = "CH1";
> +            };
> +            channel@2 {
> +                reg = <2>;
> +                label = "CH2";
> +            };
> +            channel@3 {
> +                reg = <3>;
> +                label = "CH3";
> +            };
> +        };
> +    };
> +...

Best regards,
Krzysztof

