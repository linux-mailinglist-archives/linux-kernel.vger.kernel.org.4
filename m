Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BE6BE463
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCQIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCQIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:54:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582C20A22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so17625949edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iI6vtw6bVD+YeZgLaHusyDLe3pnQNromosMt3XnEuTI=;
        b=u6Jr5G+DLOwJDyH8jy6Hxv/I8yYWT3p2FCp2FaCyx4jZFyXbsLVcKW7Eq/GyBRE0/f
         zcZvts+fLvxFTKbgej/fYgPJePDGLxdYyvLeK+57d2qVbFxLmfUztBJkWJvli/LKvW5T
         q+ZxxndWFzHmtEmJHgCEo7EGn3vlO165olk1ZKUNAooZ1jAO3gZYRnz8YvDm51vs14vi
         EkM3Fj6lVA9Q09h9zXH5euO3E5ldN8ffAhg1qMzKJJaKXzJmYYO1sG2+Cxb25orMhZz7
         MZs6uebdV9Ly2muXWn5un5b8sDt0vzaD4isqWsMLTs9x60pvTxxFhRyvFm1UvNkTdCRG
         a7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI6vtw6bVD+YeZgLaHusyDLe3pnQNromosMt3XnEuTI=;
        b=UIKJWI3nyxUMMAWi1o7d6f5eIc8W+snh6RiNTwRjKXz3R/+h1u5Ha+vnPRAdDHhFZw
         Bl3bQa4BtYTUk5YNTEZPJAxw2QNAZN383kKgbtFl30vPOZGhu92Hdsg7ohT+6wQVaODm
         kVA6TDq/89zWZtihlq0WRDLftUIdjjOyH8lL/I4YoyITpFyIATWEU5o1WyDTOfAvNMk1
         H+M/Of7I41CvedZCqODassEG5BaK/et0XgMZzbvrKIfCH+T5OgAh4guP/zVxO3nxqhZA
         SOCVWu3WOy1kMPFFGY1EjHKIXUpVonRJDDWSG5mrBmL6m2ekiMk7Nc4hBX8WIjXyrspx
         9SEg==
X-Gm-Message-State: AO0yUKV/s6p87qxGiphdYH+liQQOPomwkSetqmbCSODyIAP25VDT8bOF
        L4C5NBkZL/WN/vsTid+deknPkg==
X-Google-Smtp-Source: AK7set+TC7cy3xh3TDbJy1wCOYak9eKDKtIuJwTmUYNeQhh5wPfSPzE4e6kJzyHb8VfVL6a4J6Vx4g==
X-Received: by 2002:a17:907:a4cb:b0:931:f9f8:bf9e with SMTP id vq11-20020a170907a4cb00b00931f9f8bf9emr1262921ejc.74.1679043249061;
        Fri, 17 Mar 2023 01:54:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060d6a00b008d044ede804sm699544ejh.163.2023.03.17.01.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:54:08 -0700 (PDT)
Message-ID: <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
Date:   Fri, 17 Mar 2023 09:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/7] dt-bindings: misc: Add the Lantiq PEF2466 E1/T1/J1
 framer
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316122741.577663-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 13:27, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/misc/lantiq,pef2256.yaml         | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml b/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
> new file mode 100644
> index 000000000000..1ba788d06a14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/lantiq,pef2256.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq PEF2256
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a framer and
> +  line interface component designed to fulfill all required interfacing between
> +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> +
> +properties:
> +  compatible:
> +    const: lantiq,pef2256
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Master clock
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      GPIO used to reset the device.
> +    maxItems: 1
> +
> +  pinctrl:
> +    allOf:
> +      - $ref: "/schemas/pinctrl/pinctrl.yaml#"

Drop quotes. Drop allOf, no need for it.

additionalProperties: false

> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        allOf:
> +          - $ref: "/schemas/pinctrl/pincfg-node.yaml#"

Drop quotes. Drop allOf, no need for it.

additionalProperties: false


> +
> +        properties:
> +          pins:
> +            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
> +
> +          function:
> +            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, LOS,
> +                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XLT,
> +                    GPI, GPOH, GPOL ]
> +
> +        required:
> +          - pins
> +          - function
> +
> +  lantiq,line-interface:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [e1, t1j1]
> +    default: e1
> +    description: |
> +      The line interface type
> +        - e1: E1 line
> +        - t1j1: T1/J1 line
> +
> +  lantiq,sysclk-rate-hz:
> +    enum: [2048000, 4096000, 8192000, 16384000]
> +    default: 2048000
> +    description:
> +      Clock rate (Hz) on the system highway.

I am pretty sure we have discussions on sysclk for other drivers. First,
why you cannot use assigned-clock-rates? Or clk_get_rate() if this is
about being consumer?

Second, there is already system-clock-frequency property, so use it.

> +
> +  lantiq,data-rate-bps:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [2048000, 4096000, 8192000, 16384000]
> +    default: 2048000
> +    description:
> +      Data rate (bit per seconds) on the system highway.

Why do you need it? How is it different from clock? Do you expect some
DDR here?

> +
> +  lantiq,clock-falling-edge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Data is sent on falling edge of the clock (and received on the rising
> +      edge). If 'clock-falling-edge' is not present, data is sent on the
> +      rising edge (and received on the falling edge).
> +
> +  lantiq,channel-phase:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +    default: 0
> +    description:
> +      The pef2256 delivers a full frame (32 8bit time-slots in E1 and 24 8bit
> +      time-slots 8 8bit signaling in E1/J1) every 125us. This lead to a data
> +      rate of 2048000 bit/s. When lantiq,data-rate-bps is more than 2048000
> +      bit/s, the data (all 32 8bit) present in the frame are interleave with
> +      unused time-slots. The lantiq,channel-phase property allows to set the
> +      correct alignment of the interleave mechanism.
> +      For instance, suppose lantiq,data-rate-bps = 8192000 (ie 4*2048000), and
> +      lantiq,channel-phase = 2, the interleave schema with unused time-slots
> +      (nu) and used time-slots (XX) for TSi is
> +        nu nu XX nu nu nu XX nu nu nu XX nu
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +      With lantiq,data-rate-bps = 8192000, and lantiq,channel-phase = 1, the
> +      interleave schema is
> +        nu XX nu nu nu XX nu nu nu XX nu nu
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +      With lantiq,data-rate-bps = 4096000 (ie 2*2048000), and
> +      lantiq,channel-phase = 1, the interleave schema is
> +        nu    XX    nu    XX    nu    XX
> +        <-- TSi --> <- TSi+1 -> <- TSi+2 ->
> +
> +  lantiq,subordinate:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, the pef2256 works in subordinate mode. In this mode it
> +      synchronizes on line interface clock signals. Otherwise, it synchronizes
> +      on internal clocks.
> +
> +allOf:
> +  - if:
> +      properties:
> +        lantiq,line-interface:
> +          contains:
> +            const: e1
> +    then:
> +      properties:
> +        lantiq,frame-format:

Do not define properties in if:then, but in top-level. Disallow them or
customize for the specific cases in if:then

> +          $ref: /schemas/types.yaml#/definitions/string
> +          enum: [doubleframe, crc4-multiframe, auto-multiframe]
> +          default: doubleframe
> +          description: |
> +            The E1 line interface frame format
> +              - doubleframe: Doubleframe format
> +              - crc4-multiframe: CRC4 multiframe format
> +              - auto-multiframe: CRC4 multiframe format with interworking
> +                                 capabilities (ITU-T G.706 Annex B)
> +
> +    else:
> +      # T1/J1 line
> +      properties:
> +        lantiq,frame-format:

Same problem - definitions go to top level.

> +          $ref: /schemas/types.yaml#/definitions/string
> +          enum: [4frame, 12frame, 24frame, 72frame]
> +          default: 12frame
> +          description: |
> +            The T1/J1 line interface frame format
> +              - 4frame: 4-frame multiframe format (F4)
> +              - 12frame: 12-frame multiframe format (F12, D3/4)
> +              - 24frame: 24-frame multiframe format (ESF)
> +              - 72frame: 72-frame multiframe format (F72, remote switch mode)
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    pef2256@2000000 {

Figure out some generic node name.

> +      compatible = "lantiq,pef2256";
> +      reg = <0x2000000 0xFF>;

Lowercase hex

> +      interrupts = <8 1>;

if 1 is interrupt flag, use proper defines.

> +      interrupt-parent = <&PIC>;
> +      clocks = <&clk_mclk>;
> +      clock-names = "mclk";
> +      reset-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
> +      lantiq,sysclk-rate-hz = <8192000>;
> +      lantiq,data-rate-bps = <4096000>;
> +
> +      pinctrl {
> +        pef2256_rpa_sypr: rpa-pins {
> +          pins = "RPA";
> +          function = "SYPR";
> +        };
> +        pef2256_xpa_sypx: xpa-pins {
> +          pins = "XPA";
> +          function = "SYPX";
> +        };
> +      };
> +    };

Best regards,
Krzysztof

