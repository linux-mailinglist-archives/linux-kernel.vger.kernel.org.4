Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC06FC288
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjEIJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjEIJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:18:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F680D851
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:18:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso8481400a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683623909; x=1686215909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7FYzpXB4JAY8REQ6N17vUTvC/w9zteq+juJjffaEPw=;
        b=UUacsfduaEDjEk0zUYDO7xJxrrsNgrmVWgnHsIaXTBKhdhoRSBOS29z6L/WVyViKWg
         eiO3U10ZPG9+TqsanbULhqMK6vWctoMsZipmmyPjNq4567fWWceEq1idjIQ1AnqqGdkJ
         ctmHwgityKDDvjP6CrnN1kHU7GIELc+tykk0gQh17QoXeaSh0JMgVDPX2Sogi8RrS7yE
         ogR9ctz+11I568K64CbVxvB+hBwSeoVr/+dgSU8zceo/Bd0jidxAaKbFwA76vhQLshby
         DsZe9k1oUEGoWXyZ39gNpZfNVa1RCReUv6TYsRRIK9yY27+5uGfv5hgVJgtf+fv8NnF1
         kGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683623909; x=1686215909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7FYzpXB4JAY8REQ6N17vUTvC/w9zteq+juJjffaEPw=;
        b=YN2YpPbHGWqxWF/HDqvz5u+rQ15+DplbOzDlnQuEhHhBUqrxX0V6o59e63EsHNB03E
         mN4lG0iygAgduSU52uGJs0DfxkQq+7qfireaR5aHSNBaHe2onpKLkrtXLKI/1fVAkVNF
         WsLZ3EIABgGXQ2VeOcF1pa735Mg3sFnK1NibDVVtTOR1fbJEongVrCdRYmLAayh/bJtO
         A8WyndKRF8ZTEvWkVwqRhOu2+Owdv+UnW4qs3Q3If7F+rprRvVndA42W7bOJbwwzr74r
         4d8cx/JCRIyYFfXXjFmXqPKJD39j1n56tK+5/dm0hhSNIWWzIGbbMNcSC5HcOFsinSIF
         +LcQ==
X-Gm-Message-State: AC+VfDwGUJ7FS7Uv1/EZukNHHuaJGf0nXC5fp+IGMkujysfXljt21rVx
        eUere0Prq+6sFTRER4aPFLM89w==
X-Google-Smtp-Source: ACHHUZ4EVVEITh4T8aJgcY8S930Dxi8YCadGVtavtGcs/hxxLvRYRvnzqhUfz+9hiFzzvr259Kr4Pw==
X-Received: by 2002:a17:907:6d20:b0:969:e304:441d with SMTP id sa32-20020a1709076d2000b00969e304441dmr2095523ejc.4.1683623909486;
        Tue, 09 May 2023 02:18:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906220700b0096792b56c47sm1048546ejs.167.2023.05.09.02.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:18:28 -0700 (PDT)
Message-ID: <fbfd02d5-183a-118c-5743-dee6c9367bf6@linaro.org>
Date:   Tue, 9 May 2023 11:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-9-jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506155435.3005-9-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 17:54, Jakob Hauser wrote:
> Add device tree binding documentation for rt5033 multifunction device, voltage
> regulator and battery charger.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> The patch is based on next-20230505.
> 
> The drivers for rt5033 (mfd) and rt5033-regulator are existing. Whereas the
> the driver rt5033-charger is new in this patchset.
> 
>  .../bindings/mfd/richtek,rt5033.yaml          | 113 ++++++++++++++++++
>  .../power/supply/richtek,rt5033-charger.yaml  |  64 ++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> new file mode 100644
> index 000000000000..0aa0a556b50f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/richtek,rt5033.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description:
> +  RT5033 is a multifunction device which includes battery charger, fuel gauge,
> +  flash LED current source, LDO and synchronous Buck converter for portable
> +  applications. It is interfaced to host controller using I2C interface. The
> +  battery fuel gauge uses a separate I2C bus.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    description:
> +      The regulators of RT5033 have to be instantiated under a sub-node named
> +      "regulators". For SAFE_LDO voltage there is only one value of 4.9 V. LDO
> +      voltage ranges from 1.2 V to 3.0 V in 0.1 V steps. BUCK voltage ranges
> +      from 1.0 V to 3.0 V in 0.1 V steps.
> +    type: object
> +    patternProperties:
> +      "^(SAFE_LDO|LDO|BUCK)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +    additionalProperties: false
> +
> +  charger:
> +    type: object
> +    $ref: /schemas/power/supply/richtek,rt5033-charger.yaml#
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
> +
> +    battery: battery {
> +        compatible = "simple-battery";
> +        precharge-current-microamp = <450000>;
> +        constant-charge-current-max-microamp = <1000000>;
> +        charge-term-current-microamp = <150000>;
> +        precharge-upper-limit-microvolt = <3500000>;
> +        constant-charge-voltage-max-microvolt = <4350000>;
> +    };
> +
> +    extcon {
> +        usb_con: connector {
> +            compatible = "usb-b-connector";
> +            label = "micro-USB";
> +            type = "micro";
> +        };
> +    };
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@34 {
> +            compatible = "richtek,rt5033";
> +            reg = <0x34>;
> +
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <62 IRQ_TYPE_EDGE_FALLING>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pmic_int_default>;
> +
> +            regulators {
> +                safe_ldo_reg: SAFE_LDO {
> +                    regulator-name = "SAFE_LDO";
> +                    regulator-min-microvolt = <4900000>;
> +                    regulator-max-microvolt = <4900000>;
> +                    regulator-always-on;
> +                };
> +                ldo_reg: LDO {
> +                    regulator-name = "LDO";
> +                    regulator-min-microvolt = <2800000>;
> +                    regulator-max-microvolt = <2800000>;
> +                };
> +                buck_reg: BUCK {
> +                    regulator-name = "BUCK";
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <1200000>;
> +                };
> +            };
> +
> +            charger {
> +                compatible = "richtek,rt5033-charger";
> +                monitored-battery = <&battery>;
> +                connector = <&usb_con>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> new file mode 100644
> index 000000000000..b8607cc6ec63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5033 PIMC Battery Charger

PMIC

> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +description:
> +  The battery charger of the multifunction device RT5033 has to be instantiated
> +  under sub-node named "charger" using the following format.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt5033-charger
> +
> +  monitored-battery:
> +    description: |
> +      Phandle to the monitored battery according to battery.yaml. The battery
> +      node needs to contain five parameters.
> +
> +      precharge-current-microamp:
> +      Current of pre-charge mode. The pre-charge current levels are 350 mA
> +      to 650 mA programmed by I2C per 100 mA.
> +
> +      constant-charge-current-max-microamp:
> +      Current of fast-charge mode. The fast-charge current levels are 700 mA
> +      to 2000 mA programmed by I2C per 100 mA.
> +
> +      charge-term-current-microamp:
> +      This property is end of charge current. Its level ranges from 150 mA
> +      to 600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and
> +      600 mA in 100 mA steps.
> +
> +      precharge-upper-limit-microvolt:
> +      Voltage of pre-charge mode. If the battery voltage is below the pre-charge
> +      threshold voltage, the charger is in pre-charge mode with pre-charge
> +      current. Its levels are 2.3 V to 3.8 V programmed by I2C per 0.1 V.
> +
> +      constant-charge-voltage-max-microvolt:
> +      Battery regulation voltage of constant voltage mode. This voltage levels
> +      from 3.65 V to 4.4 V by I2C per 0.025 V.
> +
> +  connector:
> +    description:
> +      Phandle to a USB connector according to usb-connector.yaml. The connector
> +      should be a child of the extcon device.
> +    maxItems: 1

Missing type/ref... but then you will notice you have conflicting ref
with existing connector. connector is usb-connector.yaml, not phandle. I
am not sure if we need generic property, so let's go with device
specific - richtek,usb-connector


> +
> +required:
> +  - monitored-battery
Best regards,
Krzysztof

