Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB56ED280
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjDXQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:32:09 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6312D8;
        Mon, 24 Apr 2023 09:32:05 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1879e28ab04so3760337fac.2;
        Mon, 24 Apr 2023 09:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353925; x=1684945925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG7DxdNxLzIFEHGVmsrA00fMrIOgxDvZjTpItYx9ioY=;
        b=VcgXDzoHTwjG+aZtpXkYW/mT45XkEbYfhyMbpcebb1mHS2gdnDwxidM3XdNFRev4VM
         tmwv9OCghKxy+DHpaK/tZSR9CeSUMBRY3dneXMHhxAamz6Kqhza7oX8OWYlUpCoaUhAK
         QmqJOmfblvQNIjJHggWXWMACkzNOwQhatNflsk2xmZH0xZh0sJ2W/nSLDLiE6pnZoJr5
         keFeoP4yMyYC7cBJ7D7Cf62xDqRmWVnP6AOd3vyLA/FEYzlS0JvatWcph23XCsgtQyYc
         i14CsQbDO2kYUQ+gKc+KGhE5r2o+WRFLaENXwFEW5ab8p6mYfAidToANZv9LUJFoHLOq
         AddQ==
X-Gm-Message-State: AAQBX9eY0Om30uXXhUbuGmSXK0f4xLxv/txo/uANVFoQKroMq5CtIGow
        JWhAiU9yjNt4SYk+9gQTWg==
X-Google-Smtp-Source: AKy350bRcDSJkif0zqdAZxRoHZWawPCThQ4pX2yWrI1Mg/6UVwRKyRCPAfwu7aPbLJbDc6Y4DbDWig==
X-Received: by 2002:a05:6871:b26:b0:180:3b6:82bd with SMTP id fq38-20020a0568710b2600b0018003b682bdmr9166635oab.33.1682353924833;
        Mon, 24 Apr 2023 09:32:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d6f93000000b006a62aac5736sm4359159otq.28.2023.04.24.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:32:04 -0700 (PDT)
Received: (nullmailer pid 2783952 invoked by uid 1000);
        Mon, 24 Apr 2023 16:32:03 -0000
Date:   Mon, 24 Apr 2023 11:32:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/43] dt-bindings: gpio: Add DT bindings ep93xx gpio
Message-ID: <20230424163203.GK2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-33-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-33-nikita.shubin@maquefel.me>
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

On Mon, Apr 24, 2023 at 03:34:48PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/gpio/gpio-ep93xx.yaml | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml
> new file mode 100644
> index 000000000000..4cf03c325d39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-ep93xx.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-ep93xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EP93xx GPIO controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +  - Bartosz Golaszewski <brgl@bgdev.pl>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-gpio
> +
> +  chip-label:
> +    maxItems: 1
> +    description: human readable name.

Why do you need this? It's not standard and I don't see other GPIO 
controllers needing it.


> +
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: data register
> +      - description: direction register
> +      - description: interrupt registers base
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: data
> +      - const: dir
> +      - const: intr
> +
> +  gpio-controller: true
> +
> +  gpio-ranges: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    items:
> +      - const: 27

The value of the interrupt cells depends on the parent which is outside 
the scope of this binding. Just 'maxItems: 1' is sufficient.

> +
> +  interrupts-extended:

'interrupts' covers interrupts-extended. So 'interrupts' should be:

interrupts:
  oneOf:
    - maxItems: 1
    - description: port F has dedicated irq line for each gpio line
      maxItems: 8

> +    minItems: 8
> +    maxItems: 8
> +    description: port F has dedicated irq line for each gpio line.
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        gpio0: gpio@80840000 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "A";
> +                reg = <0x80840000 0x04>,
> +                      <0x80840010 0x04>,
> +                      <0x80840090 0x1c>;
> +                reg-names = "data", "dir", "intr";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                interrupt-parent = <&vic1>;
> +                interrupts = <27>;
> +        };
> +
> +        gpio1: gpio@80840004 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "B";
> +                reg = <0x80840004 0x04>,
> +                      <0x80840014 0x04>,
> +                      <0x808400ac 0x1c>;
> +                reg-names = "data", "dir", "intr";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                interrupt-parent = <&vic1>;
> +                interrupts = <27>;
> +        };
> +
> +        gpio2: gpio@80840008 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "C";
> +                reg = <0x80840008 0x04>,
> +                      <0x80840018 0x04>;
> +                reg-names = "data", "dir";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +
> +        gpio3: gpio@8084000c {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "D";
> +                reg = <0x8084000c 0x04>,
> +                      <0x8084001c 0x04>;
> +                reg-names = "data", "dir";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +
> +        gpio4: gpio@80840020 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "E";
> +                reg = <0x80840020 0x04>,
> +                      <0x80840024 0x04>;
> +                reg-names = "data", "dir";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +
> +        gpio5: gpio@80840030 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "F";
> +                reg = <0x80840030 0x04>,
> +                      <0x80840034 0x04>,
> +                      <0x8084004c 0x1c>;
> +                reg-names = "data", "dir", "intr";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                interrupts-extended = <&vic0 19>, <&vic0 20>,
> +                                      <&vic0 21>, <&vic0 22>,
> +                                      <&vic1 15>, <&vic1 16>,
> +                                      <&vic1 17>, <&vic1 18>;
> +        };
> +
> +        gpio6: gpio@80840038 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "G";
> +                reg = <0x80840038 0x04>,
> +                      <0x8084003c 0x04>;
> +                reg-names = "data", "dir";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +
> +        gpio7: gpio@80840040 {
> +                compatible = "cirrus,ep9301-gpio";
> +                chip-label = "H";
> +                reg = <0x80840040 0x04>,
> +                      <0x80840044 0x04>;
> +                reg-names = "data", "dir";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +        };
> +
> +...
> -- 
> 2.39.2
> 
