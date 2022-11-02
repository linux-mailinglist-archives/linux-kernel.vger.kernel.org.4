Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD262616A76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiKBRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKBRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:19:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D6192
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:19:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cg5so2988910qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuNZiwTspOvveszR9vgomjaKTTLMN+99lIN1mFkCiBk=;
        b=JKARcNSCMLwZ7IU/UL9MiWjQPoJ1cRFxFHD0tzYYittrMegNLvmLBMCXjfNV+klloL
         EVPH7OjB4uVsMg/M3ewL/q5JVH+U/LyolRAJ/B18LewR6Ws8mhRCFPNGHfh7FPh/36es
         XwqAcIRedFJ2wTHYUfcAr2vc8V6mXuIEABm5tSHK9XXLVItKPLkJqKUiqvAKYGWmnvYe
         xqkh1OHxRhN7Jk5gVDgwtoIuQ8uW9ABuHw0cYCwk2/1Wm4DSJ6x8QSZswpcZtBPocuDX
         M6ZkS74X2VXIUBSjK8dr5IEKcnKcB4uJ1ELcdPlHTEKCh/VWetfVJQjViqDzw/LezmGJ
         BGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuNZiwTspOvveszR9vgomjaKTTLMN+99lIN1mFkCiBk=;
        b=pWzhs23gLjdLeLwmiTqGSn+eOSRUrjVU/sYxhy8wqIY4O5QYkpwyjhFcoPnruwwGx8
         SaICuhNbfCHrt+pZLEkBc6blCMQGInAEEMZWe7TaLxItFuBZ5Ql5vlWcplNr+WB8vwaU
         YDeJJo/Ap484yymdTk1s/VAsb2dq/t51FZkypE7bQ6Kc1QvdOHO7ZP3932OG82h8xN2M
         HoosGGMud+iJ7dl7RNJLyRO2/mGGm55MPollHLcMy8fpmpsdoR3RfguSvfwbqSEK3r1d
         P7d/0QmX8ORjkUx4MPhsJ7cMLVEGg+cK+29xLXry33lFMHp0MtMczptXg7YvuIeqxZMR
         8cYA==
X-Gm-Message-State: ACrzQf1gBo5rHmZERR8/YinRPOA1bmZC0AIrrrdLLwgK4TNjiksunbzj
        65Md1LznxQ84UtvYdEzl4hpYoQ==
X-Google-Smtp-Source: AMsMyM7AJKiOMK2DSsRIhiRMmUb/A9J9eolD1EuQgjzs2RDIUygjrtKgEnHrLWIQ6AEKqnpqd1IKRw==
X-Received: by 2002:ac8:7216:0:b0:3a5:3cb0:958 with SMTP id a22-20020ac87216000000b003a53cb00958mr7172235qtp.113.1667409557232;
        Wed, 02 Nov 2022 10:19:17 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id y24-20020a37f618000000b006cf19068261sm8637547qkj.116.2022.11.02.10.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:19:16 -0700 (PDT)
Message-ID: <fdac2b61-4cfc-b673-1cd8-8e7ad19476b7@linaro.org>
Date:   Wed, 2 Nov 2022 13:19:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221101165344.3455723-1-Naresh.Solanki@9elements.com>
 <20221101165344.3455723-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221101165344.3455723-2-Naresh.Solanki@9elements.com>
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

On 01/11/2022 12:53, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max5970.yaml b/Documentation/devicetree/bindings/mfd/max5970.yaml
> new file mode 100644
> index 000000000000..a0cc6a7543b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max5970.yaml

Filename: missing vendor prefix.

> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/max5970.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator driver for MAX5970 smart switch from Maxim Integrated.

Drop "driver"

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
> +      Properties for single channel.
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +
> +    additionalProperties: true

This should be rather: false

> +
> +  vss1-supply:
> +    description: Supply of the first channel.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      Properties for single channel.
> +
> +    patternProperties:
> +      "^(sw[0-1])$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +      shunt-resistor-micro-ohms:
> +        description: |
> +          The value of curent sense resistor in microohms.
> +          Must be specified for each channel.
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +  - vss1-supply
> +
> +allOf:
> +  - $ref: /schemas/regulator/regulator.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - maxim,max5970
> +    then:
> +      properties:
> +        vss2-supply:
> +          description: Supply of the second channel.
> +
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
> +
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
> +            #address-cells = <1>;
> +            #size-cells = <0>;

Use 4 spaces for example indentation.

> +            leds {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                led@0 {
> +                        reg = <0>;
> +                        label = "led0";
> +                        default-state = "on";
> +                };
> +                led@1 {
> +                        reg = <1>;
> +                        label = "led1";
> +                        default-state = "on";
> +                };
> +            };

What is this example about? It does not match your bindings.

> +            regulator@3a {
> +                    reg = <0x3a>;
> +                    vss1-supply = <&p3v3>;
> +                    compatible = "maxim,max5978";
> +
> +                    regulators {
> +                            sw0_ref_0: SW0 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +                                   regulator-compatible = "SW0";
> +                                   shunt-resistor-micro-ohms = <12000>;
> +                            };
> +                    };
> +            };
> +    };
> +
> +  - |
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            regulator@3a {
> +                    reg = <0x3a>;
> +                    vss1-supply = <&p3v3>;
> +                    vss2-supply = <&p5v>;
> +                    compatible = "maxim,max5970";

Compatible is first, then reg, then the rest.
> +
> +                    regulators {
> +                            sw0_ref_1: SW0 {
> +                                   regulator-compatible = "SW0";
> +                                   shunt-resistor-micro-ohms = <12000>;
> +                            };
> +                            sw1_ref_1: SW1 {
> +                                   regulator-compatible = "SW1";
> +                                   shunt-resistor-micro-ohms = <10000>;
> +                            };
> +                    };
> +            };
> +    };
> +...

Best regards,
Krzysztof

