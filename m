Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D25728332
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjFHPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:01:30 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0891FFE;
        Thu,  8 Jun 2023 08:01:29 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33c37f62e24so2283115ab.3;
        Thu, 08 Jun 2023 08:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686236488; x=1688828488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2HO+Cce6dz6N2YsSHeGk4YtxY8g0B2gxVxKGt9RYO8=;
        b=KuCMfxonJNTi5eg/6XuoqlZTX66r1A0BRY+89OyyIuoiRKTdtU4JhOrhwibLdf5os1
         YSXCGEuSkKzvxTYaprALs9qXSbw3Txl7FizQURId+gIBxqPMXLP8qj/3tx9INdGUi4V5
         M10lXoTG5ECBzImR52VKoSVjjgJTOETubn8/vKAfDRhFq+58kvEK9U4GdLDKGi/JknfA
         rBFV2pRtkAZ15dQZE4hvoXsRiwaq3KU/ZEccMsmFMO80stjN09yjdQjFqyjYfR5ZZ8RM
         mH1ND5IKvZR2g6+fMrNFOUPS7fnztHAnFV2kPYCeXvtg9l+9+Rj/gZNnvAgQIiCNX0s/
         lNqg==
X-Gm-Message-State: AC+VfDwyLW5T017+9Px5wOHfHqn979Hq1u2hcrwa8Koy73+sFRF0Vwf1
        xa0+/oQM6AaMnd0ey7Chyw==
X-Google-Smtp-Source: ACHHUZ4IwaHl69Kvs9PbKKXIEy+QH3g/M6NOgsYXS2bWPK+eqQDjoRUxG5TZVArsyYoo+4VtmV61tg==
X-Received: by 2002:a92:da8c:0:b0:339:f9d:9f6b with SMTP id u12-20020a92da8c000000b003390f9d9f6bmr8567944iln.1.1686236488619;
        Thu, 08 Jun 2023 08:01:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x9-20020a92dc49000000b0033d2b3928d1sm449911ilq.51.2023.06.08.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:01:27 -0700 (PDT)
Received: (nullmailer pid 2625861 invoked by uid 1000);
        Thu, 08 Jun 2023 15:01:26 -0000
Date:   Thu, 8 Jun 2023 09:01:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 27/43] dt-bindings: input: Add Cirrus EP93xx keypad
Message-ID: <20230608150126.GA2621694-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-9-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-9-nikita.shubin@maquefel.me>
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

On Thu, Jun 01, 2023 at 08:45:32AM +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC keypad.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - remove almost all but debounce-delay-ms and prescale
>     - s/ep9301-keypad/ep9307-keypad/ it's actually only for
>       ep9307, ep9312, ep9315
>     
>     Krzysztof Kozlowski:
>     - renamed file
>     - changed maintainers
>     - dropped quotes
>     - dropped clock-names
>     - use fallback compatible and list all possible compatibles
>     - fix ident
> 
>  .../bindings/input/cirrus,ep9307-keypad.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
> new file mode 100644
> index 000000000000..c7eb10a84a6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cirrus,ep9307-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus ep93xx keypad
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +
> +description: |

Don't need '|'.

> +  The KPP is designed to interface with a keypad matrix with 2-point contact
> +  or 3-point contact keys. The KPP is designed to simplify the software task
> +  of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
> +  and decoding one or multiple keys pressed simultaneously on a keypad.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9307-keypad
> +      - items:
> +          - enum:
> +              - cirrus,ep9312-keypad
> +              - cirrus,ep9315-keypad
> +          - const: cirrus,ep9307-keypad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cirrus,debounce-delay-ms:

Use the somewhat standard 'debounce-delay-ms'.

> +    description: |
> +          Time in microseconds that key must be pressed or
> +          released for state change interrupt to trigger.
> +
> +  cirrus,prescale:
> +    description: row/column counter pre-scaler load value
> +    $ref: /schemas/types.yaml#/definitions/uint32

Constraints?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - linux,keymap
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    #include <dt-bindings/input/input.h>
> +    keypad@800f0000 {
> +      compatible = "cirrus,ep9301-keypad";
> +      reg = <0x800f0000 0x0c>;
> +      interrupt-parent = <&vic0>;
> +      interrupts = <29>;
> +      clocks = <&syscon EP93XX_CLK_KEYPAD>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&keypad_default_pins>;
> +      linux,keymap = <KEY_UP>,
> +                     <KEY_DOWN>,
> +                     <KEY_VOLUMEDOWN>,
> +                     <KEY_HOME>,
> +                     <KEY_RIGHT>,
> +                     <KEY_LEFT>,
> +                     <KEY_ENTER>,
> +                     <KEY_VOLUMEUP>,
> +                     <KEY_F6>,
> +                     <KEY_F8>,
> +                     <KEY_F9>,
> +                     <KEY_F10>,
> +                     <KEY_F1>,
> +                     <KEY_F2>,
> +                     <KEY_F3>,
> +                     <KEY_POWER>;
> +    };
> -- 
> 2.37.4
> 
