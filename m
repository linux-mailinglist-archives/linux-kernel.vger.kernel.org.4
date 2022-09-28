Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFD5EE2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiI1RUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiI1RUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:20:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFB1A201
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:20:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so21342933lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8eMJUTEyG5utBjCyNWFkdCC301TtmrPPwOC3aj0cxjA=;
        b=B5bPli4nvhdtSju6yT+wzWBYTd3ibI9pBq0liBZhfuym7Tz9IgMcwqmAcgYQWSEKWU
         Jya+tO0MQ7Jw5qKEZgxTbe658Wua8dRgqqiWgaJ3aBe5MBSvhfg4JLHj2HZs99czoA/z
         jMp+2zujdLB1cAehZw/t8e6b71UMbGh0h2bnXccCtSW6KEKm4UxZEwRbdNZoNOvxifON
         t0M7h/9lhxgc9P/OGJkWIL0xSmbHOduRwrEdImQgtAjsdxn6cNLDitiCdmQZHHLDWIAC
         JlNQO0eWWpkNtEcOO2mTOPdXLadgONHWWvbZ7w9LoWJpD5wVd8q+xGqAmPsre0XNzBYG
         CZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8eMJUTEyG5utBjCyNWFkdCC301TtmrPPwOC3aj0cxjA=;
        b=yj5l1+uN8y/9U2FSA3aK+oFsV/Kw1BX7G1+QM3Bf07ArhcQBNSsVzjEN53ABb/LDcC
         WarICjHFO5iC5vuseAapReceb79E7HnjfgP5WcZAwwcOBj9ucqyGbHw48akTF3UCt7A7
         FpCv6Bd5F04VhYsVydM+wZc8+0l3E9q5fiuV098ALN6fAOQkzq3aYl065LM75EHpnhYs
         h65X11QW4RAgZeO62czzCfJyVJIWkSDWN9sSWnAP8lV0MeiOoIUxzJDEnBILNs9zOnA8
         ozLdwsW7WEb16Ew9ApiTxTUad9TnJMpbUOjUt+1qmCqkhhGAv3eVKIuqidvRdwyNoHhR
         1y0w==
X-Gm-Message-State: ACrzQf0t4+KUC0Y6PoWrlNyrcQZn+E0HVDIz5XFTnry4L4C0pBFIDiCg
        RUvbWc5Qv95Uvi0ysEiKk8XyfQ==
X-Google-Smtp-Source: AMsMyM7yUQbyVbNmwXtohF1R5vFYvSmJptclBTXUrwNEEDTTMx3ywESLwMyJK+XW9p06pljle7yXOw==
X-Received: by 2002:a05:6512:3989:b0:49f:480f:c9ae with SMTP id j9-20020a056512398900b0049f480fc9aemr13207234lfu.343.1664385642438;
        Wed, 28 Sep 2022 10:20:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004977e865220sm527751lfq.55.2022.09.28.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:20:41 -0700 (PDT)
Message-ID: <f67b9a1f-73a5-e03f-a935-9bfb55a6b845@linaro.org>
Date:   Wed, 28 Sep 2022 19:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [net-next][PATCH v3] dt-bindings: dsa: lan9303: Add lan9303 yaml
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928162128.802-1-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928162128.802-1-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:21, Jerry Ray wrote:
> Adding the dt binding yaml for the lan9303 3-port ethernet switch.
> The microchip lan9354 3-port ethernet switch will also use the
> same binding.
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v2->v3:
>  - removed cpu labels
>  - now patching against latest net-next
> v1->v2:
>  - fixed dt_binding_check warning
>  - added max-speed setting on the switches 10/100 ports.
> ---
>  .../devicetree/bindings/net/dsa/lan9303.txt   |  99 +-------------
>  .../bindings/net/dsa/microchip,lan9303.yaml   | 129 ++++++++++++++++++
>  MAINTAINERS                                   |   8 ++
>  3 files changed, 139 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/microchip,lan9303.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> index 46a732087f5c..8c8fedd1f00e 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> @@ -1,100 +1,5 @@
>  SMSC/MicroChip LAN9303 three port ethernet switch
>  -------------------------------------------------

Old file should be entirely removed.

>  
> -Required properties:
> -
> -- compatible: should be
> -  - "smsc,lan9303-i2c" for I2C managed mode
> -    or
> -  - "smsc,lan9303-mdio" for mdio managed mode
> -
> -Optional properties:
> -
> -- reset-gpios: GPIO to be used to reset the whole device
> -- reset-duration: reset duration in milliseconds, defaults to 200 ms
> -
> -Subnodes:
> -
> -The integrated switch subnode should be specified according to the binding
> -described in dsa/dsa.txt. The CPU port of this switch is always port 0.
> -
> -Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
> -configured to use 1/2/3 instead. This hardware configuration will be
> -auto-detected and mapped accordingly.
> -
> -Example:
> -
> -I2C managed mode:
> -
> -	master: masterdevice@X {
> -
> -		fixed-link { /* RMII fixed link to LAN9303 */
> -			speed = <100>;
> -			full-duplex;
> -		};
> -	};
> -
> -	switch: switch@a {
> -		compatible = "smsc,lan9303-i2c";
> -		reg = <0xa>;
> -		reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
> -		reset-duration = <200>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 { /* RMII fixed link to master */
> -				reg = <0>;
> -				ethernet = <&master>;
> -			};
> -
> -			port@1 { /* external port 1 */
> -				reg = <1>;
> -				label = "lan1";
> -			};
> -
> -			port@2 { /* external port 2 */
> -				reg = <2>;
> -				label = "lan2";
> -			};
> -		};
> -	};
> -
> -MDIO managed mode:
> -
> -	master: masterdevice@X {
> -		phy-handle = <&switch>;
> -
> -		mdio {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			switch: switch-phy@0 {
> -				compatible = "smsc,lan9303-mdio";
> -				reg = <0>;
> -				reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
> -				reset-duration = <100>;
> -
> -				ports {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					port@0 {
> -						reg = <0>;
> -						ethernet = <&master>;
> -					};
> -
> -					port@1 { /* external port 1 */
> -						reg = <1>;
> -						label = "lan1";
> -					};
> -
> -					port@2 { /* external port 2 */
> -						reg = <2>;
> -						label = "lan2";
> -					};
> -				};
> -			};
> -		};
> -	};
> +See Documentation/devicetree/bindings/net/dsa/microchip,lan9303.yaml for the
> +device tree documentation covering the LAN9303 and LAN9354 devices.

No, just remove it.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan9303.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan9303.yaml
> new file mode 100644
> index 000000000000..818770092a2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan9303.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/microchip,lan9303.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LAN9303 Ethernet Switch Series Tree Bindings

Drop "Tree Bindings"

> +
> +allOf:
> +  - $ref: "dsa.yaml#"

Drop quotes.

> +
> +maintainers:
> +  - UNGLinuxDriver@microchip.com
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - smsc,lan9303-mdio
> +          - microchip,lan9354-mdio
> +      - enum:
> +          - smsc,lan9303-i2c

oneOf does not make sense. It's just one enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: Optional gpio specifier for a reset line

Drop "gpio specifier for a"

> +    maxItems: 1
> +
> +  reset-duration:
> +    description: Reset duration in milliseconds, defaults to 200 ms

This does not look like standard type or unit suffix, so you need here
type. Don't you have warnings for this?

default: 200


> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    //Ethernet switch connected via mdio to the host

Missing space before comments. Use Linux style comments, not your own.

> +    ethernet0 {

Drop "0".

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        phy-handle = <&lan9303switch>;
> +        phy-mode = "rmii";
> +        fixed-link {
> +            speed = <100>;
> +            full-duplex;
> +        };
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            lan9303switch: switch@0 {
> +                compatible = "smsc,lan9303-mdio";
> +                dsa,member = <0 0>;
> +                reg = <0>;

reg goes after compatible.

> +                ethernet-ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                        port@0 {
> +                            reg = <0>;
> +                            phy-mode = "rmii";
> +                            ethernet = <&ethernet>;
> +                            fixed-link {
> +                                speed = <100>;
> +                                full-duplex;
> +                            };
> +                        };
> +                        port@1 {
> +                            reg = <1>;
> +                            max-speed = <100>;
> +                            label = "lan1";
> +                        };
> +                        port@2 {
> +                            reg = <2>;
> +                            max-speed = <100>;
> +                            label = "lan2";
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +
> +    //Ethernet switch connected via i2c to the host
> +    ethernet1 {

Just ethernet (and make it a second example)



Best regards,
Krzysztof

