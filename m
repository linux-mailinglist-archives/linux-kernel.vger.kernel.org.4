Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225C6A4857
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjB0RlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjB0Rkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:40:51 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBF25290;
        Mon, 27 Feb 2023 09:40:09 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id u3-20020a4ad0c3000000b0052541ef0bafso1112326oor.5;
        Mon, 27 Feb 2023 09:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgkZ/7Ar4KpMlYo0Ie0qrRnEDsnDl1Cx4IjEfHmmGEs=;
        b=csBwCiFZ7RC7zhDI6FhNj7MCxGPGeE1mjVlJH7CO1VFBLQ9D6pU/r73gZN9LrQBKrL
         kqmBY16vi4Vyumx9FF1wUtZ29mmnV4ahLSz2DYHXcdR6cWrwSLrxiYmLUNqmFbvVLLWe
         uHixoyRQ7oozQx2njPhE+W73x5D7mrwxu/wykON1GhnfgH5JIQQyuxi07IA+W6SENXPW
         8vu3vfmsgBRua5KGScAmIqkuaSyLLSuekTBUBvzb1n3yKC2Q1gUExb5FARY9N4TZ9r9+
         yLx+PbEq9JgTVbRpgr2O3UkykFZUco2f9gV9HCYNAIUQKv3yWCalAZZxo3h+sffsXDd8
         1S8Q==
X-Gm-Message-State: AO0yUKWMBB3vlVgOksl+QMaUmvpJz7R2bNZ1nsqEWROu5P6NX7Xfm1BD
        gUDybg/1d0Ffh8Iqh+Zgzg==
X-Google-Smtp-Source: AK7set8FJe5xztcBF6GRv+jcUAEBTrhZshKAEsTcASPsfocC0zofE+fXHQXjcEGimqKxXkMCQR//dw==
X-Received: by 2002:a4a:ca13:0:b0:525:3ac1:28be with SMTP id w19-20020a4aca13000000b005253ac128bemr4392209ooq.1.1677519497795;
        Mon, 27 Feb 2023 09:38:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a4a6709000000b0051ffe0fe11bsm2886260ooc.6.2023.02.27.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:38:17 -0800 (PST)
Received: (nullmailer pid 510693 invoked by uid 1000);
        Mon, 27 Feb 2023 17:38:16 -0000
Date:   Mon, 27 Feb 2023 11:38:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [RFC PATCH 09/16] dt-bindings: pinctrl: mediatek: rt305x: split
 binding
Message-ID: <20230227173816.GA505343-robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-10-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-10-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:39:25PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The RT3352 and RT5350 SoCs each contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,rt3352-pinctrl.yaml and
> mediatek,rt5350-pinctrl.yaml.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,rt305x-pinctrl.yaml      |  78 +-----
>  .../pinctrl/mediatek,rt3352-pinctrl.yaml      | 247 ++++++++++++++++++
>  .../pinctrl/mediatek,rt5350-pinctrl.yaml      | 210 +++++++++++++++
>  3 files changed, 462 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> index 61fcf3ab1091..1e6c7e7f2fe2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> @@ -11,8 +11,7 @@ maintainers:
>    - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>  
>  description:
> -  MediaTek RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
> -  SoCs.
> +  MediaTek RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
>    The pin controller can only set the muxing of pin groups. Muxing individual
>    pins is not supported. There is no pinconf support.
>  
> @@ -36,21 +35,9 @@ patternProperties:
>            function:
>              description:
>                A string containing the name of the function to mux to the group.
> -            anyOf:
> -              - description: For RT3050, RT3052 and RT3350 SoCs
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
> -                       pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
> -                       uartlite]
> -
> -              - description: For RT3352 SoC
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
> -                       lna, mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi,
> -                       spi_cs1, uartf, uartlite, wdg_cs1]
> -
> -              - description: For RT5350 SoC
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
> -                       pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf,
> -                       uartlite, wdg_cs1]
> +            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
> +                   pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
> +                   uartlite]
>  
>            groups:
>              description:
> @@ -69,17 +56,7 @@ patternProperties:
>              then:
>                properties:
>                  groups:
> -                  anyOf:
> -                    - description: For RT3050, RT3052 and RT3350 SoCs
> -                      enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf,
> -                             uartlite]
> -
> -                    - description: For RT3352 SoC
> -                      enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
> -                             uartf, uartlite]
> -
> -                    - description: For RT5350 SoC
> -                      enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
> +                  enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite]
>  
>            - if:
>                properties:
> @@ -126,24 +103,6 @@ patternProperties:
>                  groups:
>                    enum: [jtag]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: led
> -            then:
> -              properties:
> -                groups:
> -                  enum: [led]
> -
> -          - if:
> -              properties:
> -                function:
> -                  const: lna
> -            then:
> -              properties:
> -                groups:
> -                  enum: [lna]
> -
>            - if:
>                properties:
>                  function:
> @@ -153,15 +112,6 @@ patternProperties:
>                  groups:
>                    enum: [mdio]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: pa
> -            then:
> -              properties:
> -                groups:
> -                  enum: [pa]
> -
>            - if:
>                properties:
>                  function:
> @@ -216,15 +166,6 @@ patternProperties:
>                  groups:
>                    enum: [spi]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: spi_cs1
> -            then:
> -              properties:
> -                groups:
> -                  enum: [spi_cs1]
> -
>            - if:
>                properties:
>                  function:
> @@ -243,15 +184,6 @@ patternProperties:
>                  groups:
>                    enum: [uartlite]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: wdg_cs1
> -            then:
> -              properties:
> -                groups:
> -                  enum: [spi_cs1]
> -
>          additionalProperties: false
>  
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
> new file mode 100644
> index 000000000000..7a74c1602afc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
> @@ -0,0 +1,247 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,rt3352-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek RT3352 Pin Controller
> +
> +maintainers:
> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description:
> +  MediaTek RT3352 pin controller for RT3352 SoC.
> +  The pin controller can only set the muxing of pin groups. Muxing individual
> +  pins is not supported. There is no pinconf support.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,rt3352-pinctrl
> +      - ralink,rt305x-pinctrl
> +      - ralink,rt2880-pinmux
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    patternProperties:
> +      '^(.*-)?pinmux$':
> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#
> +
> +        properties:
> +          function:
> +            description:
> +              A string containing the name of the function to mux to the group.
> +            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna,
> +                   mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1,
> +                   uartf, uartlite, wdg_cs1]
> +
> +          groups:
> +            description:
> +              An array of strings. Each string contains the name of a group.
> +            maxItems: 1
> +
> +        required:
> +          - groups
> +          - function
> +
> +        allOf:
> +          - if:
> +              properties:
> +                function:
> +                  const: gpio
> +            then:
> +              properties:
> +                groups:
> +                  enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
> +                         uartf, uartlite]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: gpio i2s
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: gpio uartf
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: i2c
> +            then:
> +              properties:
> +                groups:
> +                  enum: [i2c]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: i2s uartf
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: jtag
> +            then:
> +              properties:
> +                groups:
> +                  enum: [jtag]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: led
> +            then:
> +              properties:
> +                groups:
> +                  enum: [led]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: lna
> +            then:
> +              properties:
> +                groups:
> +                  enum: [lna]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: mdio
> +            then:
> +              properties:
> +                groups:
> +                  enum: [mdio]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: pa
> +            then:
> +              properties:
> +                groups:
> +                  enum: [pa]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: pcm gpio
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: pcm i2s
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: pcm uartf
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: rgmii
> +            then:
> +              properties:
> +                groups:
> +                  enum: [rgmii]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: spi
> +            then:
> +              properties:
> +                groups:
> +                  enum: [spi]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: spi_cs1
> +            then:
> +              properties:
> +                groups:
> +                  enum: [spi_cs1]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: uartf
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartf]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: uartlite
> +            then:
> +              properties:
> +                groups:
> +                  enum: [uartlite]
> +
> +          - if:
> +              properties:
> +                function:
> +                  const: wdg_cs1
> +            then:
> +              properties:
> +                groups:
> +                  enum: [spi_cs1]
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

Drop quotes here and other refs.

