Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969568918F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBCIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjBCIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:05:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B132945CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:03:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3194273wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO/wOlTKv2ZXyBQ/Aq4ZwUrxkA17nVhS0gL6sWJfJgU=;
        b=a9KKsDInAF1Re4LhiLxP3wdQs0pGWYrQHdmV6QmNbAWyZpX8mzHTBsD1QFyTIwx20Z
         6B+CNYeaIDaMeTDISok2fJVRBZAgxiTZArvhTbSTiD0zEVNCV6BHc6CSVMH7Gtl4GQyr
         ysPAjJGcj0tcIE+Br4FQm0ztrXBNaJ4Vx5k5ySDS0feEq8SbPnSVA8rX2zbXyZlWgCeC
         kuCNg4czlNc6buYVJkBQEOoUWGU9YauzZextYJyaw1Y/vXjG0rwN3kC7hmMgoKqCCOp4
         j8TPpa/0qF35omFlAmoehM1RCroVpAQq4QwZhuDoIhVa8cvZFFPUqq72T6UWXouXUCpA
         i4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO/wOlTKv2ZXyBQ/Aq4ZwUrxkA17nVhS0gL6sWJfJgU=;
        b=lS0ClKsmELtRdho8/C4qnJWHOqZnpkvR3bBLUWZAeIUX1Q1q4WmDdvlQ1QAhuuUuVV
         lid/95sPlNx02iiyK+8x6YFe7YlzmJhJzajaT7la88Y9RKse0b5nzhE8Df+qFjhHMO9h
         4ZX1xOoBfLb8N8CaaE65Jx6rCMKbqm6/0Ux/KGTT6g3EZy+8hUlnOYz/c8Ji6zxedxvx
         LF2Pwqy712oxt38mFCa1oK4XWapJ2yOHtuXVYQIx1dTRsOUcsQC60OnBfdUG/BTV8J7Q
         8P8whM7c01FMktiMfmO6Q+Kbx9AgLB8Mvs7L6VV8HAJ6eAGhHt2m/iHTSDwTO4wrRQLM
         lMPQ==
X-Gm-Message-State: AO0yUKUSq+mIWY80W2w6CpjFGspshYL2AMgAzhiPrqX2yTBaQHxAVLcK
        MyLpxefDve50F+LCNOEW5/kWeQ==
X-Google-Smtp-Source: AK7set8u+cmZ7lz8PRUKAve3w16hS2Y87x6C560Uz3vJTv2lGOkxZM8qBpNk5O2HUja+PkE9yv2U6Q==
X-Received: by 2002:a05:600c:16c4:b0:3db:2098:17c0 with SMTP id l4-20020a05600c16c400b003db209817c0mr10351012wmn.29.1675411416947;
        Fri, 03 Feb 2023 00:03:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm4215674wmp.38.2023.02.03.00.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:03:36 -0800 (PST)
Message-ID: <bdf35849-b1c9-224c-9d11-3fa57d224335@linaro.org>
Date:   Fri, 3 Feb 2023 09:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/9] ASoC: dt-bindings: meson: convert axg spdif input to
 schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-8-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202183653.486216-8-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 19:36, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg spdif input to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-spdifin.txt    | 27 ------
>  .../bindings/sound/amlogic,axg-spdifin.yaml   | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
> deleted file mode 100644
> index df92a4ecf288..000000000000
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Amlogic Audio SPDIF Input
> -
> -Required properties:
> -- compatible: 'amlogic,axg-spdifin' or
> -	      'amlogic,g12a-spdifin' or
> -	      'amlogic,sm1-spdifin'
> -- interrupts: interrupt specifier for the spdif input.
> -- clocks: list of clock phandle, one for each entry clock-names.
> -- clock-names: should contain the following:
> -  * "pclk" : peripheral clock.
> -  * "refclk" : spdif input reference clock
> -- #sound-dai-cells: must be 0.
> -
> -Optional property:
> -- resets: phandle to the dedicated reset line of the spdif input.
> -
> -Example on the A113 SoC:
> -
> -spdifin: audio-controller@400 {
> -	compatible = "amlogic,axg-spdifin";
> -	reg = <0x0 0x400 0x0 0x30>;
> -	#sound-dai-cells = <0>;
> -	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
> -	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
> -		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
> -	clock-names = "pclk", "refclk";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
> new file mode 100644
> index 000000000000..4f7e4c21acc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifin.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Audio AXG SPDIF Input
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^audio-controller@.*"
> +
> +  compatible:
> +    oneOf:
> +      - items:

All usual comments apply.

> +          - const:
> +              amlogic,axg-spdifin
> +      - items:
> +          - enum:
> +              - amlogic,g12a-spdifin
> +              - amlogic,sm1-spdifin
> +          - const:
> +              amlogic,axg-spdifin

All usual comments apply.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +      - description: SPDIF input reference clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: refclk
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - amlogic,g12a-spdifin
> +          - amlogic,sm1-spdifin
> +then:
> +  properties:
> +    resets:
> +      items:
> +        - description: dedicated device reset line
> +
> +  required:
> +    - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/axg-audio-clkc.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spdifin: audio-controller@400 {
> +    	compatible = "amlogic,axg-spdifin";

Fix indentation.


Best regards,
Krzysztof

