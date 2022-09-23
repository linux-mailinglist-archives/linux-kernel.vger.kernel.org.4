Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E595E817D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiIWSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiIWSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:07:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D413EE99
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:05:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so1489592lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0P++JAFuUUDKT2D9NWr416tneMWYEhMZwQOa7Bx9b3A=;
        b=DJyY6A5eu+W0UflY/SVlgDu5aTDgsqWFKyep2Q3lnHIXS8Ry3ly3U3RLnsSX/edb4V
         vq5hO9+NsBq8zleyZlB+m0QODezrMFPqKE3SLtF4hs2ZHZnmytCfDoxSoGnwilySeD16
         ZSgbUEshv4td7IW9dU9waVhK+Yp68EKpLMN3exIQx1ulBictZhrs9M7Gi6GTQCJXmRdb
         adonGgk7N+5Rf4HXPJwVAFgifhe7r3sog6JZez18chSAvmSmiGcYEq01bKChukPqJTm+
         3grM7hblRH8dG9OiwLWrScLspkfDmbOUugbz+61s8jNi4ri5WJFW4gVQ7i6lP2NABEDk
         Si2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0P++JAFuUUDKT2D9NWr416tneMWYEhMZwQOa7Bx9b3A=;
        b=6ylUaaAAEmB25Tsv+INpoZwRvdJ9eHpzt+qSBaqKh1YqB1pOgZmebX1jsyFjWz7eef
         XM+kFFOPNiogM46ymVbxX/PtrPFzwxKbu/iyGJmj10PuXGpvKaWXHBtcncW8RNGJSl4n
         mBQPgPQw5QgWLzSquZqrpJNxBySvjhSmC4ZJ5+wyho2eTDdMJk58jur9ak/S3RxEGL0B
         gNEF6rTLWbFwTWrTVYfsq27CegPT1xheATEwNCkhKgCng0BXrwONU9biBX2JesdBGghv
         Uzm6O7XCjRPppjS7Z+3Mcaka9WR9dfMbEGiOZyj4kgxjwPMYK+EuZ/swrLPmOZJBbrkZ
         RXDw==
X-Gm-Message-State: ACrzQf3ypsEByVxk+RfA3Di8MXjObnGhxissjPpKnFOpxisnZxBmXVkQ
        1aCJZRd5dLyKknxBbQ5WsNLqhzwMijfwhQ==
X-Google-Smtp-Source: AMsMyM5O/6DsfnZjF3DoP0ztXtTibC6UcjHug0RkJiqrFETUoZJlvDSAP72ociHCt0cWhdXyiVvPhQ==
X-Received: by 2002:a05:6512:1112:b0:49b:4e7b:9752 with SMTP id l18-20020a056512111200b0049b4e7b9752mr3533662lfg.685.1663956273057;
        Fri, 23 Sep 2022 11:04:33 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25e83000000b0049a6a9bc0dcsm1548875lfq.134.2022.09.23.11.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:04:32 -0700 (PDT)
Message-ID: <699d3c00-ed41-9e08-dd86-f06a332fa7a8@linaro.org>
Date:   Fri, 23 Sep 2022 20:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220921095053.88658-1-tmaimon77@gmail.com>
 <20220921095053.88658-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921095053.88658-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:50, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> new file mode 100644
> index 000000000000..2e8bc9b22166
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM845 Pin Controller and GPIO
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description:
> +  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
> +  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
> +  and multiple functions that directly connect the pin to different
> +  hardware blocks.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,npcm845-pinctrl
> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':

Use consistent quotes - either ' or "

> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  nuvoton,sysgcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to access GCR registers.
> +
> +patternProperties:
> +  "^gpio@":
> +    type: object
> +
> +    description:
> +      Eight GPIO banks that each contain 32 GPIOs.
> +
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      gpio-ranges:
> +        maxItems: 1
> +
> +    required:
> +      - gpio-controller
> +      - '#gpio-cells'
> +      - reg
> +      - interrupts
> +      - gpio-ranges
> +
> +  "-mux":
> +    $ref: pinmux-node.yaml#
> +
> +    properties:
> +      groups:
> +        description:
> +          One or more groups of pins to mux to a certain function
> +        items:
> +          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> +                  smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> +                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> +                  smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> +                  spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> +                  bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> +                  rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> +                  fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> +                  fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> +                  r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> +                  rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> +                  smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> +                  smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> +                  pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> +                  serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> +                  spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> +                  smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> +                  smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> +                  hgpio4, hgpio5, hgpio6, hgpio7 ]
> +
> +      function:
> +        description:
> +          The function that a group of pins is muxed to
> +        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
> +                smb5b, smb5c, lkgpo0, pspi2, jm1, jm2, smb4den, smb4b,
> +                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
> +                smb22, smb23, smb4d, smb14, smb5, smb4, smb3, spi0cs1,
> +                spi0cs2, spi0cs3, smb3c, smb3b, bmcuart0a, uart1, jtag2,
> +                bmcuart1, uart2, bmcuart0b, r1err, r1md, r1oen, r2oen,
> +                rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3, fanin4,
> +                fanin5, fanin6, fanin7, fanin8, fanin9, fanin10, fanin11,
> +                fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2, pwm3,
> +                r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg1,
> +                rg1mdio, rg2, ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5,
> +                smb0, smb1, smb2, smb2c, smb2b, smb1c, smb1b, smb8, smb9,
> +                smb10, smb11, sd1, sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8,
> +                pwm9, pwm10, pwm11, mmc8, mmc, mmcwp, mmccd, mmcrst, clkout,
> +                serirq, lpcclk, scipme, sci, smb6, smb7, spi1, faninx, r1,
> +                spi3, spi3cs1, spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b,
> +                smb0c, smb0den, smb0d, ddc, rg2mdio, wdog1, wdog2, smb12,
> +                smb13, spix, spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3,
> +                hgpio4, hgpio5, hgpio6, hgpio7 ]
> +
> +    dependencies:
> +      groups: [ function ]
> +      function: [ groups ]
> +
> +    additionalProperties: false
> +
> +  "^pin":
> +    $ref: pincfg-node.yaml#
> +
> +    properties:
> +      pins:
> +        description:
> +          A list of pins to configure in certain ways, such as enabling
> +          debouncing
> +
> +      bias-disable: true
> +
> +      bias-pull-up: true
> +
> +      bias-pull-down: true
> +
> +      input-enable: true
> +
> +      output-low: true
> +
> +      output-high: true
> +
> +      drive-push-pull: true
> +
> +      drive-open-drain: true
> +
> +      input-debounce:
> +        description:
> +          Debouncing periods in microseconds, one period per interrupt
> +          bank found in the controller
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 4
> +
> +      slew-rate:
> +        description: |
> +          0: Low rate
> +          1: High rate
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +      drive-strength:
> +        enum: [ 0, 1, 2, 4, 8, 12 ]
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

Drop quotes.

> +
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +  - nuvoton,sysgcr

I don't think this solves any questions...


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pinctrl: pinctrl@f0800000 {

gcr has @f0800000, hasn't it?

> +        compatible = "nuvoton,npcm845-pinctrl";
> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        nuvoton,sysgcr = <&gcr>;
> +
> +        gpio0: gpio@f0010000 {
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          reg = <0x0 0xB0>;
> +          interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +          gpio-ranges = <&pinctrl 0 0 32>;
> +        };
> +
> +        fanin0_pin: fanin0-mux {
> +          groups = "fanin0";
> +          function = "fanin0";
> +        };
> +
> +        pin34_slew: pin34-slew {
> +          pins = "GPIO34/I3C4_SDA";
> +          bias-disable;
> +        };
> +      };
> +    };
> +

Best regards,
Krzysztof

