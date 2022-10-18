Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8610760326B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJRS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJRS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:27:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9439122
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:27:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s17so8039741qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KDGYKucLfiMgHID9r3bn/04iPGOCosjXcb6ueV7Xpw=;
        b=GmIiIZiTf8Ow+31uIoZB6zGc8her8/I4yCWQR96ktu3UWsUKy9IwqqS2tEnQET4Mx/
         Bsaob+n9GcUH0AR+8eD8pjh9eYHzcRLkSuRZacHXyno4lf0JT+pjb6lNVTY85oI0OirY
         MBkFlAVKcIhANbaKuZwFuCcvlN3ruHvY82nXzKgAxw/YIqFGgKDXvSeOvdKld+t+XZzi
         6v0eKBTHoaPxREoHGPiX584sczISS4NOdO34uL2JX2KExE+uUPCxKdhzLzE102Ya7EmU
         e2VLg4+wRHCG4VyDaMh6F+GZx4eDRFKfSmBHuruAMsDSOXnyNWowNys1+dUto47Pq7Az
         vyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KDGYKucLfiMgHID9r3bn/04iPGOCosjXcb6ueV7Xpw=;
        b=g0JIUUYXFlhWDtTBhq0i2IYXycd1x5TVzid+gT/qGYmGt/GLKX1TAw2xfL6R1PcFNH
         aTC5x2mOsB4cTQIzORScQOQHm88UwlAw6p8s1kGDd2sMHZoFqLtlZpP+E3YOfwaObZ8q
         vDxT5UhDjERyeKPraqA9or61A2C9S/WCUfJ2bVRLgN6nD+2YYKaSjgP5N67zsnKHiSiC
         KoJK+d/rquF1IsFVFizc3iR+7qZv6xjqC9SQowrYdpRbxI3Wi+obU06d/CqZXhjI/Bx2
         lZHK8KSqA/EyI0sLro8TDy0rZaIcBJ6fTQiEQZg96E/Cvyy2AAgiBBIuwKxBJ6j1uxMY
         I4BQ==
X-Gm-Message-State: ACrzQf0QnIFzE01uVI9EfAxibNeZwgPb/guuVqz25aAci5P1q48vEC7T
        cQRySPtE54umCMKKRi3JB+ZaAQ==
X-Google-Smtp-Source: AMsMyM64KB+tM8SKsGF/O5RMvYWwj38h0gZY0qEDibEpmHsA7e/OJVZBq4mqzrRsiH4miUBf7F2hGw==
X-Received: by 2002:a05:620a:22cc:b0:6ee:3e43:ac40 with SMTP id o12-20020a05620a22cc00b006ee3e43ac40mr2874489qki.454.1666117639454;
        Tue, 18 Oct 2022 11:27:19 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a404f00b006ee91ab3538sm3194991qko.36.2022.10.18.11.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:27:18 -0700 (PDT)
Message-ID: <94c1acb4-f914-8b69-eebb-cf5e812ca453@linaro.org>
Date:   Tue, 18 Oct 2022 14:27:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: add binding for tft displays based on
 ilitek,ili9488
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     michael@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, kamlesh.gurudasani@gmail.com,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com>
 <20221018164532.1705215-2-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018164532.1705215-2-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 12:45, Tommaso Merciai wrote:
> This binding is for the tft displays based on ilitek,ili9488.
> waveshare,waveshare,pico-rt-lcd-35 (waveshare pico-restouch-lcd-3.5)
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  .../bindings/display/ilitek,ili9488.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
> new file mode 100644
> index 0000000000000..879ecc42c350c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ilitek,ili9488.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ILI9488 display panels device tree bindings

Drop "device tree bindings"

> +
> +maintainers:
> +  - Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
> +  - Michael Trimarchi <michael@amarulasolutions.com>
> +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> +
> +description:
> +  This binding is for display panels using an Ilitek ILI9488 controller in SPI

Drop "This binding is for" and instead describe hardware.

> +  mode.
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          # Waveshare 3.5" 320x480 Color TFT LCD
> +          - "waveshare,pico-rt-lcd-35"
> +      - const: ilitek,ili9488
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description: Display data/command selection (D/CX)
> +
> +  backlight: true
> +  reg: true
> +  reset-gpios: true
> +  rotation: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - dc-gpios
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    backlight: backlight {
> +            compatible = "gpio-backlight";
> +            gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;

Drop it, no need for this example.


> +    };
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;

Use 4 spaces for example indentation.

> +
> +

No need for two blank lines.

> +            display@0{
> +                    compatible = "waveshare,pico-rt-lcd-35", "ilitek,ili9488";
> +                    reg = <0>;
> +                    spi-max-frequency = <20000000>;
> +                    dc-gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +                    reset-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> +                    backlight = <&backlight>;
> +            };
> +    };
> +
> +...

Best regards,
Krzysztof

