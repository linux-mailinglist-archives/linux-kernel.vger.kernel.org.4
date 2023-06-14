Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56479730A91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjFNW2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjFNW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:28:08 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B51A268B;
        Wed, 14 Jun 2023 15:28:06 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-340a05c22deso4175085ab.1;
        Wed, 14 Jun 2023 15:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686781685; x=1689373685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yajQGWba7cBbv2yEGLzVuT0yMU8/vEnbzI0aW4uhFjs=;
        b=U1uKIJucVTm+UDz1cFWgSNn2bnRV1gQ9LUB1Z0bMurhVIfe3WrpTga5ewJB8UnRdNX
         rv3yCRe+kLWzxBXJIX+dUG9kO8xGYH/rPh5vA6p19iJ3osPNLnU8J7r+dND4rxTC+QJf
         JfRTTExoJtK+TRJ0k04V0HUzfR2uQWVm5FvrpHTaK31rH06RYq0fFpE8eDBJJChEvDMy
         ykS8pCYpysTAvWLFgFOHmgZg2ZpvYGUi7zJFytUT/TpH/FKASnZ2L/NUKNovw6xwmtOS
         hMsEdd/n/GExj7RkcPCe3aLy3Vh3JUtM0La8GcSZYkH78U8PIDMPZGWRom/Mh1/Ypqa/
         jgeg==
X-Gm-Message-State: AC+VfDxtLpt1zckeeRdvBc9likQHSwOHArZzsYlOhav+W8ON0TNJqexU
        ZBADIjFOZNABR9C4b6jdpQ==
X-Google-Smtp-Source: ACHHUZ5YM/cTrc06AeRT+CeT2VeoTeDKlGPOdZ8xCjU5GY97ctXm6YigYxsxbe9HTrdCeC1hWwXauw==
X-Received: by 2002:a92:cd0e:0:b0:340:a3b4:1bda with SMTP id z14-20020a92cd0e000000b00340a3b41bdamr2685802iln.2.1686781685590;
        Wed, 14 Jun 2023 15:28:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d13-20020a92d78d000000b0033b3348519bsm5668384iln.69.2023.06.14.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 15:28:04 -0700 (PDT)
Received: (nullmailer pid 2979093 invoked by uid 1000);
        Wed, 14 Jun 2023 22:28:03 -0000
Date:   Wed, 14 Jun 2023 16:28:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
Message-ID: <20230614222803.GA2974729-robh@kernel.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-1-4a0741b8aefd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-1-4a0741b8aefd@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:31:56PM +0200, Neil Armstrong wrote:
> Document the Goodix GT9916 wich is part of the "Berlin" serie

series

> of Touchscreen controllers IC from Goodix.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/input/touchscreen/goodix-berlin.yaml  | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
> new file mode 100644
> index 000000000000..4c24a541e919
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/goodix-berlin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Goodix Belin series touchscreen controller

Berlin?

> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>

Would be nice to have a description which includes that the device has 
both I2C and SPI interfaces.

> +
> +allOf:
> +  - $ref: touchscreen.yaml#

SPI devices should include spi-peripheral-props.yaml

> +
> +properties:
> +  compatible:
> +    enum:
> +      - goodix,gt9916
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply regulator on AVDD pin
> +
> +  vddio-supply:
> +    description: GPIO power supply regulator on VDDIO pin
> +
> +  spi-max-frequency: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-swapped-x-y: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      gt9916@5d {
> +        compatible = "goodix,gt9916";
> +        reg = <0x5d>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      num-cs = <1>;
> +      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +      gt9916@0 {
> +        compatible = "goodix,gt9916";
> +        reg = <0>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
> +        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> +
> +...
> 
> -- 
> 2.34.1
> 
