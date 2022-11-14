Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F42627720
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiKNIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiKNIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:10:06 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0BF594
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:10:05 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b9so12136492ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCeNiv0uBYzpZqxZWRhSbtsBMoxOYzYOiK5Rx6GVk50=;
        b=P83PberwhZDcYiwg50+dvxuXIHmkTFYaiKENJXvfkW9B4aiKgyy7unYjqgtaOOIsWE
         cceJfo52C6TAlLiPOQjlDwAa3miiUwSZYFtl6v1mhOaRSd7bk4W1bZ6H4z7iWkHnOBDd
         z/fXAzweX9jHUSL643YEczhVOukXPtifbln2NidZMNVbIqXbqw7myitIS+4V7NyB3pf1
         x3lc1QWpr/KSpasQbr/IBkYfKa5UxtQ14zeCafS3B2EoNdXzX8fqkOFMDBaAAB6so193
         WtYdnXOkAXw2PknsnU8rvd+dMjoQQ9E8VJFKzLdKdgpY9FO47XJNs9T/QcLMU4VY04Q+
         vRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCeNiv0uBYzpZqxZWRhSbtsBMoxOYzYOiK5Rx6GVk50=;
        b=dhbS8Et8RPxtKDMz9Z0X6jrgzNQztXhibEwUN8WbKIYWOURAkFc8P78BBXfeeJZ4vY
         8urUQLa39DNgWXmt2hkQ2L0iBHgdIieJ3GlucMJmukv+LJGy5KS6YPxyhAXS4THh8lHQ
         CiXIXA6iaVfP3N1IkYWJVBcIr46mMJsR0WY4pVMqqiwUAma0sLQYS0LTEtJ93xHC88Sx
         8/6qk00csEjMTkk7CR34jkmJznYZumL14siXhq+3bLNX4PCVNALY+q6VfuvaoIHLl7lM
         QAqGhOg/IBPHlOBHsXhL+E1SpKuFgGGvny4hCryd1r3jafjqS9ExHp0iJoAMh2JUElA6
         +OKQ==
X-Gm-Message-State: ANoB5pm6K7QkbY40nehkIN+4YieOQju68tJzhPpnFS5VDV/R7+aiPElu
        YhH4yyVxXJRsT+0kvRvQy46erw==
X-Google-Smtp-Source: AA0mqf57zW1Vcw6Dbd8QjVYMtxFXFERlH805TdYAg7t+5ZaHRrpZJZTCmTVmB2ouqzO0OdFeVLJ8nw==
X-Received: by 2002:a05:651c:54c:b0:278:f1a5:a361 with SMTP id q12-20020a05651c054c00b00278f1a5a361mr2628295ljp.124.1668413403835;
        Mon, 14 Nov 2022 00:10:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a27-20020a2eb55b000000b0026e8b82eba6sm1901237ljn.34.2022.11.14.00.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:10:03 -0800 (PST)
Message-ID: <3fd5b40f-25eb-7ce3-0e23-84c35962e6e1@linaro.org>
Date:   Mon, 14 Nov 2022 09:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 1/2] dt-bindings: mfd: Add dt-schema MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221114075739.4117439-1-Naresh.Solanki@9elements.com>
 <20221114075739.4117439-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114075739.4117439-2-Naresh.Solanki@9elements.com>
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

On 14/11/2022 08:57, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>

Subject: I asked to drop the redundant words, but you re-added now in
different form. So again, drop "dt-schema".

> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..a93b6e009b9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,172 @@
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
> +  "#io-channel-cells":
> +    const: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      Properties for regulator.

That's not correct description. This is not one regulator.

> +
> +    patternProperties:
> +      "^sw[0-1]$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object

unevaluatedProperties: false

> +        properties:
> +          shunt-resistor-micro-ohms:
> +            description: |
> +              The value of curent sense resistor in microohms.

Typo: current

> +
> +        required:
> +          - shunt-resistor-micro-ohms
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
> +      properties:
> +        io-channels:
> +          items:
> +            - description: voltage first channel
> +            - description: current first channel
> +            - description: voltage second channel
> +            - description: current second channel
> +          description: |
> +            Voltage and current for first and second channel.
> +      required:
> +        - vss2-supply

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Comment was:
"Also, add it in the existing example."

> +    else:
> +      properties:
> +        io-channels:
> +          items:
> +            - description: voltage first channel
> +            - description: current first channel
> +          description: |
> +            Voltage and current for first channel.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        regulator@3a {
> +           compatible = "maxim,max5978";
> +           reg = <0x3a>;
> +           vss1-supply = <&p3v3>;
> +
> +           regulators {
> +               sw0_ref_0: sw0 {
> +                      regulator-compatible = "SW0";

Use 4 spaces for example indentation.

> +                      shunt-resistor-micro-ohms = <12000>;
> +               };
> +           };
> +
> +           leds {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               led@0 {
> +                   reg = <0>;
> +                   label = "led0";
> +                   default-state = "on";
> +               };
> +               led@1 {
> +                   reg = <1>;
> +                   label = "led1";
> +                   default-state = "on";
> +               };
> +           };
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
> +                    shunt-resistor-micro-ohms = <12000>;
> +                };
> +                sw1_ref_1: sw1 {
> +                    regulator-compatible = "SW1";
> +                    shunt-resistor-micro-ohms = <10000>;
> +                };
> +            };
> +        };
> +    };
> +...

Best regards,
Krzysztof

