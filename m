Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45216632079
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKULZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKULZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:25:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0180BF59E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:20:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so18355012lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3vCypYaYr/TUPlMCYQCNuevnxo4BkRRu9uJ6R1YomE=;
        b=ihzaGM+s1Uksutb4VOVRIhkp+qJkngVVC0C/YX8sX30ITMnjAu/3kxHeDPAg+yBkaJ
         TZvetSao+F3wHQgNsXgGNdVUAYRux1OcXsbHFxKeujqL22TV3Z1KbytltmPfyAjMIsmP
         RTL3IS5E2sXrdojuOWYBAAQGwdTq82SQ1F3EEooMK8IGCYAd+yxqwxeCcwG80nV/EgqE
         7ilifju39YShXhTXLIpyAey2K0qx5Ylzv2T5yfG0wt0IfqFZCZzkNPrDFII2eEzuqKe3
         wrrXXfWm8cuSBoxtgdIaC1c7roWc1cLdIwUX5crW5RPWyWHn3Uoc4hVTyJ8rL27vn1a5
         GIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3vCypYaYr/TUPlMCYQCNuevnxo4BkRRu9uJ6R1YomE=;
        b=y9uuXyzEd3gWClL7IcYXqba1WLUa3FERsMg32+w05s8DbgB97088K8JZRnVxa28O8n
         uM1VE69h3iawNsfkNfUFqX4p+mXyJstT8VXTc9MBkI8CxJtB3iizbVvXAZ6egEkAlPFK
         OUrvX7rgBg/j6WdE4o/GpRHnzxRBLJgo48lKSKF5JNxNWu1kUigli7SJikIIZuCUVlHE
         L5mYKm/OMabyhI9QJ3S4CmxapDIbXxWf2BkFli79Tq8LnTEvMKnLwJ7vTZsS6KBiTK/U
         EAWuBI1xFxT3cJm+y4H4Sj+xZFgVSwPhEn2q1GeUjCM/i16gRaLsXV/Rr77c2tz31KKb
         efOw==
X-Gm-Message-State: ANoB5pk1DkgO/6pPsKgRhH+uZdFTV7HI6GehCeLD8UB/yxayJ2+75DDd
        MmsTQXWprLdviM5a/0FIwwaBaQ==
X-Google-Smtp-Source: AA0mqf56103VfC3Nsvwa7VxN2CuKqx5jWIBpZ1lo+VbE2w+udfSJyiYIfG10fc6I1FiZroPco52Q0g==
X-Received: by 2002:ac2:4843:0:b0:4a2:1169:3934 with SMTP id 3-20020ac24843000000b004a211693934mr6044024lfy.279.1669029641176;
        Mon, 21 Nov 2022 03:20:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g6-20020a05651222c600b00494942bec60sm1981896lfu.17.2022.11.21.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:20:40 -0800 (PST)
Message-ID: <24e8464a-923d-cd0f-c681-fc6ca3a5ad59@linaro.org>
Date:   Mon, 21 Nov 2022 12:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118172407.765423-1-ciprian.regus@analog.com>
 <20221118172407.765423-2-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118172407.765423-2-ciprian.regus@analog.com>
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

On 18/11/2022 18:24, Ciprian Regus wrote:
> Add devicetree bindings documentation for the AD5754 DAC driver.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  changes in v3:
>   - added additionalProperties: false to patternProperties
>   - dropped status in the example.
>   - added different values for adi,output-range-microvolt in the example.
>     Negative values cannot be set since that will create a dt_bindings_check error.
>  .../bindings/iio/dac/adi,ad5754.yaml          | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> new file mode 100644
> index 000000000000..de0f6fab82b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> @@ -0,0 +1,181 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5754.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5754 DAC
> +
> +maintainers:
> +  - Ciprian Regus <ciprian.regus@analog.com>
> +
> +description: |
> +  Bindings for the AD5754 and other chip variants digital-to-analog
> +  converters.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5724_5734_5754.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5722_5732_5752.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5724r_5734r_5754r.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722R_5732R_5752R.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5722
> +      - adi,ad5732
> +      - adi,ad5752
> +      - adi,ad5724
> +      - adi,ad5734
> +      - adi,ad5754

Keep the list sorted.

> +      - adi,ad5722r

I would even suggest sorted entirely, so 5722r follows 5722, but I don't
mind some combo-sorting (logical + alphabetical).

> +      - adi,ad5732r
> +      - adi,ad5752r
> +      - adi,ad5724r
> +      - adi,ad5734r
> +      - adi,ad5754r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +  spi-cpol: true
> +
> +  vref-supply:
> +    description:
> +      The regulator to use as an external reference. If this is not provided,
> +      the internal reference will be used for chips that have this feature.
> +      The external reference must be 2.5V.
> +
> +  clr-gpios:
> +    description: DAC output clear GPIO (CLR pin). If specified, it will be set
> +      to high during probe, thus allowing the DAC output to be updated.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-3])$":

No need for ().

> +    type: object
> +    additionalProperties: false
> +    description: Configurations for the DAC channels
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        maxItems: 1
> +
> +      adi,output-range-microvolt:
> +        description: |
> +          Voltage range of a channel as <minimum, maximum>.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 10800000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -10800000
> +              - const: 10800000
> +
> +    required:
> +      - reg
> +      - adi,output-range-microvolt
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad5722
> +              - adi,ad5732
> +              - adi,ad5752
> +              - adi,ad5722r
> +              - adi,ad5732r
> +              - adi,ad5752r
> +    then:
> +      patternProperties:
> +        "^channel@([0-3])$":

No need for ().

> +          type: object
> +          properties:
> +            reg:
> +              description: Channel number
> +              enum: [0, 1]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad5724
> +              - adi,ad5734
> +              - adi,ad5754
> +              - adi,ad5724r
> +              - adi,ad5734r
> +              - adi,ad5754r
> +    then:
> +      patternProperties:
> +        "^channel@([0-3])$":

No need for ().

> +          type: object
> +          properties:
> +            reg:
> +              description: Channel number
> +              enum: [0, 1, 2, 3]
> +


Best regards,
Krzysztof

