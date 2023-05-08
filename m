Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D36FB7E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjEHUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:02:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6D1996
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:02:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965fc25f009so606636966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683576133; x=1686168133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAtYseLpXxuBkVxFlbQ8laerKtW1IS2FwFjnYIf67Ew=;
        b=HrbuCNqRpGjYUk98SN1qVGL7DcEPo8uLKF7tJOUQYAXRJIlclZT2/8zUA81YeCGZGa
         5lxcnMX6CYataSzjiwHpRvFjYHExxSYyn/lREd4L26wJxN4Qo9a8XWbASAIVakgCtGzf
         ZAaEdfLnknO5gnH4p2gbmxstXjJI5+IlpUYmivhhvawZsVBXCks8ZU4PgnDkmwpc7JeT
         Ih/bSh/PsDGTzH0dW9w71qKAzE1YiBzgMXFHPrlF9DFhmb31mqmz1D06HVPk17l28KwP
         I4r+iF6OPnnXSGIOTEMUsRZAS2At06NP8qQGH95CzT6WprAGbzNHotDv4RB7cjimEdV9
         3fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683576133; x=1686168133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAtYseLpXxuBkVxFlbQ8laerKtW1IS2FwFjnYIf67Ew=;
        b=k5GYG8Ahv2vcTIVyGkeJIEhs6YEC52mahuzL7yvHrg3OECHcYtyJiw+fXh77dQFqpV
         LunGM5ffv5qGuhoLqCInux8omm1JdAyA8z23tQT4ZE3G0sQgLctCR5lB9sJ6iBiDkOHW
         IaB8DLT70Qpqnhq1VBZ62cGPWnW7jt40EfJG3ho3nAwHjCY3eR6Xi4YCvI1OMSZUTjf/
         F4i+QzvYgyXc5dLtJ4mdBKwE3TcZUGcRyScAPrA6lx04tuirnPf1zXmSXP0pt6XEd+0F
         vLZXZ6smySsU00dM89yaB3PEEvdZhaUzEQP1sQD8+HzL91WVgJc8IyEPVPIsTdmL2FAZ
         IHQw==
X-Gm-Message-State: AC+VfDxu45+01t2Sy1h38NlEb/iKGTb6AQ9T+GgTQ/t181e+J7lo7uS0
        DibBSG9g2Sj5HwZtSHvtsyF47w==
X-Google-Smtp-Source: ACHHUZ6VNPRKEgr7OuCdHtimURoftvfdyzlJfcJSBfAQGPgaV7H8oz4a1Kp6taoPOYmL7Bq/1nOfiQ==
X-Received: by 2002:a17:907:97ce:b0:94e:4523:b0d8 with SMTP id js14-20020a17090797ce00b0094e4523b0d8mr9960088ejc.73.1683576132774;
        Mon, 08 May 2023 13:02:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id ca21-20020a170906a3d500b00965a52d2bf6sm373253ejb.88.2023.05.08.13.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:02:12 -0700 (PDT)
Message-ID: <9b629b5e-9d49-98a0-abca-75e68abf425b@linaro.org>
Date:   Mon, 8 May 2023 22:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/7] dt-bindings: mfd: max77658: Add ADI MAX77658
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-7-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-7-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Add ADI MAX77658 devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77658.yaml | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,max77658.yaml b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> new file mode 100644
> index 000000000000..4d6d87cd4b52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,max77658.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,max77658.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77643/54/58/59 PMIC from ADI
> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  MAX77643, MAX77654, MAX77658 and MAX77659 devices are a family of ADI PMICs
> +  providing battery charging and power supply solutions for
> +  low-power applications.
> +
> +  MAX77643 is a Power Management IC with 1 LDO regulator.
> +
> +  MAX77654 is a Power Management IC with 2 LDO regulators and 1 charger.
> +
> +  MAX77658 is a Power Management IC with 2 LDO regulators, 1 charger
> +  and 1 fuel gauge.
> +
> +  MAX77659 is a Power Management IC with 1 LDO regulator and 1 charger.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77643
> +      - adi,max77654
> +      - adi,max77658
> +      - adi,max77659
> +
> +  reg:
> +    items:
> +      - enum: [0x40, 0x48]
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charger:
> +    $ref: /schemas/power/supply/adi,max77658-charger.yaml
> +
> +  fuel-gauge:
> +    $ref: /schemas/power/supply/adi,max77658-battery.yaml
> +
> +  regulators:
> +    type: object
> +
> +    description:
> +      The regulators is represented as a sub-node of the PMIC node on the device tree.
> +
> +    patternProperties:
> +      "^LDO[01]$":

lowercase

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml
> +        additionalProperties: false
> +        description:
> +          LDO regulator
> +
> +        properties:
> +          regulator-always-on: true
> +          regulator-boot-on: true

Why nothing else is allowed? You have different voltages, so how can you
configure their constraints if you do not allow them to be configured?
Drop all properties and use unevaluatedProperties..

> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max77643
> +              - adi,max77654
> +              - adi,max77658
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x48
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - const: 0x40

 - if:
    ...

    then:
      properties:
        regulators:
          properties:
            LDO1: false


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Put required before allOf.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    battery: battery-cell {
> +      compatible = "simple-battery";
> +      alert-celsius = <0 100>;
> +      constant-charge-current-max-microamp = <15000>;
> +    };
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@48 {
> +        compatible = "adi,max77658";
> +        reg = <0x48>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +        charger {
> +          compatible = "adi,max77658-charger";
> +          monitored-battery = <&battery>;
> +          adi,input-current-limit-microamp = <475000>;
> +        };
> +        regulators {
> +          LDO0 {
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +          LDO1 {
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +        };
> +        fuel-gauge {
> +          compatible = "adi,max77658-battery";
> +          monitored-battery = <&battery>;
> +          adi,valrt-min-microvolt = <0>;
> +          adi,valrt-max-microvolt = <5100000>;
> +          adi,ialrt-min-microamp = <(-5000)>;
> +          adi,ialrt-max-microamp = <5000>;
> +        };
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@40 {
> +        compatible = "adi,max77659";
> +        reg = <0x40>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +        charger {
> +          compatible = "adi,max77659-charger";
> +          monitored-battery = <&battery>;
> +        };
> +        regulators {
> +          LDO0 {
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +        };
> +      };
> +    };

Best regards,
Krzysztof

