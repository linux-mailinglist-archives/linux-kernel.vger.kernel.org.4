Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC3629B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiKOOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiKOOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:05:01 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F022C12F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:04:50 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d3so17660298ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUNMs9VUAYdzsYfZj27O2GLpDUkgxaYUW8ObUFHeds0=;
        b=u+QFzxo8dFM9n5LLms3vKX6AtCaWd9OUiB7ag8+KWKx1CJUazR4DjCML3W1oZb91kc
         j3mSyC5JgKEPhMjJ0ny11pXN9q0MGzqOqea72A4Ziu8gxD4wfaRRTcJ7P/HcBLGU7Ivo
         pGvjLZ8yFAeBfpoixuMWYEFN0aGCxWdnHb0aVDb7moBqo9j7RMtt3+6+5A9DYerreadD
         7PxuRTaB5is6gL0yqGbJfHBpo6v09b0iFuSKyWg6sukt+Lz7tgdKiB6XyE95E5s6/xCY
         u90JEPg7X14bdlqR7Rbusxvo6DYLXCYbOlJ407ALJxDnAj9OIYzcTPxy8vCoqYvmzOJf
         zQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUNMs9VUAYdzsYfZj27O2GLpDUkgxaYUW8ObUFHeds0=;
        b=6u0GoPXJeB3GAosmRny1hvkPiAFgBUcxVKiT9et6Y69lRtDSnUSr+cOD6q55t3FCYs
         y7sArMZJ6RJHQl6mUXL8bpsiNnt4ExwsReMsOzboACISlT/vcC4QI6E49GAVrpFfm8Pz
         9T/1icRY0cBGFGGtzb3pqfPHbf5/LdeDYQPVAwqk5D/hjw8v5CkcoaXBustBI4cIAtao
         gAywR7esjftk5U6Ex/8vZo3wXy8tipdY+f9JE/CwDlVJHjVm8C/IPIW7O9UaLXCL62wD
         Fh4aQJ9Qc9jX0liP2zw4rrqBZd3RDvuR41vQjE1b4qVRGu/CtmrVHaH1GF4OPLWbZQmp
         3+QA==
X-Gm-Message-State: ANoB5pkPrE2S3InuCNsi3o8d76Sql6a1vZtpbs4LB033D+8yPn/9CQBT
        630U8S0Je+GvdgN2Jcp53cZhiA==
X-Google-Smtp-Source: AA0mqf7tUo+4QoipSM45XImyjkR2A/it5s5rIMCeuLa9TU6VpMwLpU2oNRM6yJWAb9NGweATnPCL+w==
X-Received: by 2002:a2e:9904:0:b0:277:8d3:4298 with SMTP id v4-20020a2e9904000000b0027708d34298mr5475696lji.302.1668521089181;
        Tue, 15 Nov 2022 06:04:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512314700b004946b549a19sm2203167lfi.45.2022.11.15.06.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:04:48 -0800 (PST)
Message-ID: <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
Date:   Tue, 15 Nov 2022 15:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
 <20221115110932.637091-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115110932.637091-2-Naresh.Solanki@9elements.com>
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

On 15/11/2022 12:09, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..edf0c23db4ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
> +
> +maintainers:
> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> +
> +description: |
> +  The smart switch provides no output regulation, but independent fault protection
> +  and voltage and current sensing.
> +  Programming is done through I2C bus.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max5970
> +      - maxim,max5978
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  leds:
> +    type: object
> +    description:
> +      Properties for four LEDS.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +
> +    additionalProperties: false
> +
> +  vss1-supply:
> +    description: Supply of the first channel.
> +
> +  vss2-supply:
> +    description: Supply of the second channel.
> +
> +  regulators:
> +    type: object
> +    description:
> +      Properties for both regulators. Also set value for shunt resistor used.

You should explain not the syntax,  but what part of hardware this nodes
represents. Therefore "Also set value" does not fit at all. Hardware
sets value?

I looked at datasheets to figure it out but they do not refer to any
configurable regulator, LDO nor "sw0/sw1/sw2". Therefore I have no clue
what to expect here...

> +
> +    patternProperties:
> +      "^sw[0-1]$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        properties:
> +          shunt-resistor-micro-ohms:
> +            description: |
> +              The value of current sense resistor in microohms.
> +
> +        required:
> +          - shunt-resistor-micro-ohms
> +
> +      unevaluatedProperties: false

I don't think it has proper indentation. Did you test the binding?

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +  - vss1-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - maxim,max5970
> +    then:
> +      required:
> +        - vss2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        regulator@3a {
> +            compatible = "maxim,max5978";
> +            reg = <0x3a>;
> +            vss1-supply = <&p3v3>;
> +
> +            regulators {
> +                sw0_ref_0: sw0 {
> +                    regulator-compatible = "SW0";
> +                    shunt-resistor-micro-ohms = <12000>;
> +                };
> +            };
> +
> +            leds {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                led@0 {
> +                    reg = <0>;
> +                    label = "led0";
> +                    default-state = "on";
> +                };
> +                led@1 {
> +                    reg = <1>;
> +                    label = "led1";
> +                    default-state = "on";
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        regulator@3a {
> +            compatible = "maxim,max5970";
> +            reg = <0x3a>;
> +            vss1-supply = <&p3v3>;
> +            vss2-supply = <&p5v>;
> +
> +            regulators {
> +                sw0_ref_1: sw0 {
> +                    regulator-compatible = "SW0";

This property is deprecated, isn't it? Again - did you test this?

Best regards,
Krzysztof

