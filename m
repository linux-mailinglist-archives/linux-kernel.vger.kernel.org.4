Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A976ED24F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjDXQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:21:35 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395E7682;
        Mon, 24 Apr 2023 09:21:33 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6a5f765d595so3300907a34.0;
        Mon, 24 Apr 2023 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353293; x=1684945293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoT+kdyxnJujAisWNJ4HLdKkUTicQoCAJbKRfR/et9E=;
        b=e5pWJToy4oiqief6b+urLZMGAYFBpUFwkmZ1Ce+ug2aN129UAGXIHic3EiNn4DWkj6
         KzGe403X5kGvsfRY3M1or+JTyq0DVWnR81OAYAL9gVb1CWYFvYxGWypxMnjffG1SIJi2
         wYGSOm8hxVyvR0dGDSob+TWlZzle9hORCyAd0VR1Cp3PdjzMpzqDZZYa27We1SXn3Kpn
         43x5YeH+NLXXVXbUCtEAbeIVXj1Q+1Cc4J0aDpUJsjgoCgKSG1jK7DDveoFNnD/x2Q+E
         GVnLtVGdMPxIbD9jlPvnpXa8jNNmHmzGMtEcMp0fRAhsKUsJ9JxV2qNGYoXPtYg08cAM
         lyBg==
X-Gm-Message-State: AAQBX9ewOe/7UnovGan1yt7WQxJvb76V5XNVnxnQ7mn7wYBaj93fi99J
        3p/Trb00suWqFKp4vWpYug==
X-Google-Smtp-Source: AKy350Zgr9J+Hf+LrRv/fgTxmvbesbR5Y1r2uqr28g8Z6oSndGrMIrhWU783HCCTuEr1qv0aWly3Xg==
X-Received: by 2002:a05:6808:310:b0:38c:5c1e:48f5 with SMTP id i16-20020a056808031000b0038c5c1e48f5mr7628321oie.2.1682353292400;
        Mon, 24 Apr 2023 09:21:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v19-20020a4ac913000000b005255e556399sm1403946ooq.43.2023.04.24.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:21:32 -0700 (PDT)
Received: (nullmailer pid 2772491 invoked by uid 1000);
        Mon, 24 Apr 2023 16:21:31 -0000
Date:   Mon, 24 Apr 2023 11:21:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/43] dt-bindings: input: Add DT bindings ep93xx keypad
Message-ID: <20230424162131.GH2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-27-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-27-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:42PM +0300, Nikita Shubin wrote:
> Add YAML bindings ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     Linus Walleij:
>     - replaced hex with proper <KEY_UP>, etc
> 
>  .../bindings/input/cirrus,ep93xx-keypad.yaml  | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml
> new file mode 100644
> index 000000000000..0310114de22e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cirrus,ep93xx-keypad.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cirrus,ep93xx-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus ep93xx keypad
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +allOf:
> +  - $ref: "/schemas/input/matrix-keymap.yaml#"

Drop quotes.

> +
> +description: |
> +  The KPP is designed to interface with a keypad matrix with 2-point contact
> +  or 3-point contact keys. The KPP is designed to simplify the software task
> +  of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
> +  and decoding one or multiple keys pressed simultaneously on a keypad.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,ep9301-keypad
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
> +  clock-names:
> +    enum:
> +      - ep93xx-keypad
> +
> +  debounce:

I think we have a common property for this.

> +    description: |
> +          Time in microseconds that key must be pressed or
> +          released for state change interrupt to trigger.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  prescale:
> +    description: row/column counter pre-scaler load value
> +    $ref: /schemas/types.yaml#/definitions/uint32

constraints? Or 0-2^32 is valid?

> +
> +  clk-rate:

No, have standard bindings for this.

> +    description: clock rate setting
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  disable-3-key:

Needs a vendor prefix.

> +    type: boolean
> +    description:
> +      Disable 3 Key reset. Setting this disables the three key reset
> +      output to the watchdog reset block.
> +
> +  diag-mode:

Why do we need this in DT. Shouldn't this be a runtime setting.

> +    type: boolean
> +    description:
> +      Key scan diagnostic mode. Setting this allows key scanning to be
> +      directly controlled through the key register by writes from the
> +      ARM Core.
> +
> +  back-drive:

Needs a vendor prefix.

> +    type: boolean
> +    description:
> +      Key scan back driving enable. Setting this enables the key
> +      scanning logic to back drive the row and column pins of the
> +      chip high during the first two column counts in the
> +      row/column counter.
> +
> +  test-mode:

Why do we need this in DT. Shouldn't this be a runtime setting.

> +    type: boolean
> +    description:
> +      Test mode. When this is set, the counter RC_COUNT is advanced
> +      by 8 counts when EN is active. The effect is that only column 0
> +      is checked in each row. This test mode allows a faster test
> +      of the ROW pins.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - linux,keymap
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    #include <dt-bindings/input/input.h>
> +    keypad@800f0000 {
> +        compatible = "cirrus,ep9301-keypad";
> +        reg = <0x800f0000 0x0c>;
> +        interrupt-parent = <&vic0>;
> +        interrupts = <29>;
> +        clocks = <&syscon EP93XX_CLK_KEYPAD>;
> +        clock-names = "ep93xx-keypad";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&keypad_default_pins>;
> +        linux,keymap = <KEY_UP>,
> +                       <KEY_DOWN>,
> +                       <KEY_VOLUMEDOWN>,
> +                       <KEY_HOME>,
> +                       <KEY_RIGHT>,
> +                       <KEY_LEFT>,
> +                       <KEY_ENTER>,
> +                       <KEY_VOLUMEUP>,
> +                       <KEY_F6>,
> +                       <KEY_F8>,
> +                       <KEY_F9>,
> +                       <KEY_F10>,
> +                       <KEY_F1>,
> +                       <KEY_F2>,
> +                       <KEY_F3>,
> +                       <KEY_POWER>;
> +    };
> +
> -- 
> 2.39.2
> 
