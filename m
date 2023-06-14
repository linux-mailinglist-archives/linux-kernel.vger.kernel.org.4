Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D6730AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjFNWgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFNWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:36:45 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24F1715;
        Wed, 14 Jun 2023 15:36:44 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33dae9244a1so554985ab.0;
        Wed, 14 Jun 2023 15:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686782203; x=1689374203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8Zf94E7WQ/9wcsLl9Q+QIwfy+59Ul0REJcdYnckuKU=;
        b=LKSRwJHFNOgKNBLdmm73cfTAN9FPD7FFI9hTl1mew1ZcgrXR6W6GWcefVTSUNzCSHO
         NVMPj6vWJk/ytRC1uKLbXoq0KQQt0U01rLZJouLZNfniWcBz5SySU/l+4shsYyb9Ivh0
         LigYNZW2CVgmnwmLnEDnmeDThEvpNLA/O/0OepMpxFPXQ9jUe/oInj3vL/I4ZsO0gSdB
         JyzpbTFuBlPj3qP/40xGzlvnx+uQLnkomXCoBNSjq80L2ZZIb+wetxSqpcyYxUb8t2OQ
         byAp8VPBY8GD34HckaikPaAF4XpDKY7AN4KqOBgInyPzijkX7HXijYCWrv6FhQPPI4Xh
         K6CQ==
X-Gm-Message-State: AC+VfDxDKpeXh3w5X1hD28p0tVizyNc2Qr1rOECGyax3G+GE3V+Y5lWX
        yfTTT9QoPmD7c4vuUnW/hhzMH1GkKw==
X-Google-Smtp-Source: ACHHUZ6JU7DCDYGAQ8/JWSyyuSrxrSNxeLDGbGaZcPHrcCorHY6KxNRpZMeRV9tKTmRrIK4JA7KNIg==
X-Received: by 2002:a92:d6c8:0:b0:33f:c2f8:e503 with SMTP id z8-20020a92d6c8000000b0033fc2f8e503mr2224864ilp.5.1686782203533;
        Wed, 14 Jun 2023 15:36:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o27-20020a02c6bb000000b004186badba5esm5136264jan.36.2023.06.14.15.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 15:36:42 -0700 (PDT)
Received: (nullmailer pid 2990560 invoked by uid 1000);
        Wed, 14 Jun 2023 22:36:40 -0000
Date:   Wed, 14 Jun 2023 16:36:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Message-ID: <20230614223640.GA2980828-robh@kernel.org>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <a2be28c0aec04fdc3684f56801c78bcc498c3471.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2be28c0aec04fdc3684f56801c78bcc498c3471.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:28PM +0000, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..a19aa184bbd1 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -233,6 +233,39 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@19:
> +    $ref: '#/$defs/protocol-node'

       unevaluatedProperties: false

> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':
> +        const: 0
> +
> +    allOf:
> +      - $ref: /schemas/pinctrl/pinctrl.yaml#

Group this and the '#/$defs/protocol-node' $ref under allOf.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties:
> +      anyOf:

Don't need anyOf with only 1 entry.

But the use of additionalProperties is usually for existing cases where 
the pin config nodes had no naming convention. For new bindings, define 
a node name pattern (under patternProperties). I'd suggest '-pins$' as 
used elsewhere.

> +        - type: object
> +          allOf:
> +            - $ref: /schemas/pinctrl/pincfg-node.yaml#
> +            - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +
> +          description:
> +            A pin multiplexing sub-node describe how to configure a
> +            set of pins is some desired function.
> +            A single sub-node may define several pin configurations.
> +            This sub-node is using default pinctrl bindings to configure
> +            pin multiplexing and using SCMI protocol to apply specified
> +            configuration using SCMI protocol.
> +
> +          unevaluatedProperties: false
> +
>  additionalProperties: false
>  
>  $defs:
> @@ -384,6 +417,26 @@ examples:
>              scmi_powercap: protocol@18 {
>                  reg = <0x18>;
>              };
> +
> +            scmi_pinctrl: protocol@19 {
> +                reg = <0x19>;
> +                #pinctrl-cells = <0>;
> +
> +                i2c2 {
> +                    groups = "i2c2_a", "i2c2_b";
> +                    function = "i2c2";
> +                };
> +
> +                pins_mdio {
> +                    groups = "avb_mdio";
> +                    drive-strength = <24>;
> +                };
> +
> +                keys_pins: keys {
> +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> +                    bias-pull-up;
> +                };
> +            };
>          };
>      };
>  
> -- 
> 2.25.1
