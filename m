Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328785F41F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJDL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJDL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:26:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D62BE1A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:26:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o7so13396946lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZhVRfFH23C/LznboYMt5fc2Gvx4ICYtzPKZJgRBBWU4=;
        b=hdkm7nnklp1Weq95FaKDQ1EOypYeYugXsi5FnFPtBSlXcYcoubiu5wL/Yw2iy7LKtF
         2QOADXm5WbHZubvde7pgknsXhYqN3FYVBW2sC5qdILceU8Z9FLJCIzG/BY6TBJfhTMZ+
         uaY/L0v+LAGXUesPGiF/nqRxWN5Kh8rHAO3mMRCxRv2KJGn6i6sOKCPyh7KK5tiy9XOy
         cjzhj2rWwUKudXPdQIEfO37+DJ+4jRiDKWFD3AfnwDwGqXVOCFIek5ZCWwImboWxO7rc
         Vn4IC2Au+EH3cn+UljlfYMXo/DmG3mjEhi/dHgRFH1AOfY7qZVK2NjN6HCD1FVmgCeG4
         X5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZhVRfFH23C/LznboYMt5fc2Gvx4ICYtzPKZJgRBBWU4=;
        b=ygJxMB7mbJcM842wW2qmQnJ5AmbCNqhoW+/TUQQtQrztPEP1o5sXyuCt243a7exRXd
         JCwKDQz2BgZT1oiad0DdhMxhoXccj4pS/qOtQtu1E9pR0JPZYQ9CV8C36e0aJZlFLz0k
         EOAmDI/VvcMaV9Qi41MoS4W4M3PMeLrCBkSMiLdU8akXiBFGD77AUdw8Ssiw6Ln56rxN
         riWtNfpxqP35DkDqOpkkcFBVM+JX6Wubqr9hgMlKAqzTZ0/q9mayXzdWWSGmCa5XdJlY
         bAHrax2fe2J3oYjEi+XbOCSzmdsTMM7qqIVIJg/U0dluTVs4R7ZU4mnVX3cEalF1yZZ6
         rGkw==
X-Gm-Message-State: ACrzQf0B8HCEjuIY5NEl/NBqTCoRCZupov9QPOe8OTNXY2BOsir7g8CO
        hyrRbinkeWsRhQR2csgWsD9bMQ==
X-Google-Smtp-Source: AMsMyM4AA8ZOGrO+IpoA/fBl5QjSIMGIfFm7HOVqse6dq5W1Yi1kXxt2GE4itfzCP9xvgK8Ice2FFg==
X-Received: by 2002:a05:6512:34c9:b0:4a2:2b33:5358 with SMTP id w9-20020a05651234c900b004a22b335358mr4177958lfr.106.1664882768587;
        Tue, 04 Oct 2022 04:26:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24461000000b0048fdb3efa20sm1868609lfl.185.2022.10.04.04.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 04:26:08 -0700 (PDT)
Message-ID: <de5197c7-5b68-8bb6-cb3f-0278e1112d86@linaro.org>
Date:   Tue, 4 Oct 2022 13:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20221004071825.791307-1-ciprian.regus@analog.com>
 <20221004071825.791307-2-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004071825.791307-2-ciprian.regus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 09:18, Ciprian Regus wrote:
> Add devicetree bindings documentation for the AD5754 DAC driver.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5754.yaml          | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> new file mode 100644
> index 000000000000..e96112bc15d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5754.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5754 DAC device driver

Drop "device driver" unless "driver" and "device" are description of
hardware of some sort. Then please tell me what is this hardware? A
motor driver?

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
> +      - adi,ad5722r
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
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-3])$":
> +    type: object
> +    description: Configurations for the DAC channels
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        maxItems: 1
> +
> +      output-range-microvolt:

Other such properties have vendor prefix. Did you receive feedback to
make it generic (without vendor prefix)?

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
> +      - output-range-microvolt
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
> +          type: object
> +          properties:
> +            reg:
> +              description: Channel number
> +              enum: [0, 1, 2, 3]
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +          status = "okay";
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          dac@0 {

Messed up indentation. Use 4 spaces for entire example DTS.

> +              compatible = "adi,ad5754r";
> +              reg = <0>;
> +              spi-max-frequency = <1000000>;
> +              spi-cpol;
> +


Best regards,
Krzysztof

