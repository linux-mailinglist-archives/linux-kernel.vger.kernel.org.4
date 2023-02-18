Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A769A7F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBQJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:14:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8DC5F804
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:14:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i28so1311322eda.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K51Bjs5B3NHAbD45wBFw53eNVShrx9FURGTxvHG8bmI=;
        b=N33Csxe86TgmSFiUEClcGuaTp0xjJ6B2T4dmJYtpwfx51AJEd/QSYkmOOir04Sy+8g
         4zVdOHQveUMqAGZWBPdvOtUSwOsrGj8UH7eOe4C7GeUx2h2IV+cmQTe22DEiuepi2Y9Y
         /RvFBDbzIbryiqSB9pTtRiKr95HY6Kf5Dg4yO5gmp5xyAfJjaKWP4l3yRjWEDejLuSEl
         QQXeAkWvlwWBVvrbOCYIV5y0tnS3Ec+zOLXjuQ1yiVB7LBvEkXJL/JSa/jHXZ05Y+tvV
         iU/cASkwhV1YVH6a6yCZixhk0ox43qvhgL5V1VcZM871dhiCb6VnCOrKXdZOeSBBpWdn
         7zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K51Bjs5B3NHAbD45wBFw53eNVShrx9FURGTxvHG8bmI=;
        b=BuXT6UaGd1ZZ9A0s1gEFPd6h0JVLGmg6Q+rDgPEG7wRChFBsePEeO/WEvwK9/QDKFO
         DsgduxrVOBXwNw/geC7SbIwtNmXqFcP+n2bjzU6ag8UBbCQIdSL3afXJttFXt25DLQkr
         iI0SLJLbrTgpU2udP2b2Q8bMr+2qdEm7DBKAOUpKO4dw+XaqKA7xfYMd7x6WDkxTD6lI
         kUTgS4deLfghD2LwX9ExIdNuXAoBlbyrCCFJ/8ljXTsNPMgpvnVVzr9vqxxO8TJ6dWhZ
         yxOrGbR0z64SRbfrhrvGpoaOGfIddfigk737E8TOqSTD8nQYjWodqBycgSf0Gq9FPJbw
         c+tw==
X-Gm-Message-State: AO0yUKXH+rBDL8NNG0Q8mDWgnU1BQL4NOSKVCCHw8wmsB622g/8sWUyK
        mNXHVuHiTcRuwQ99AFr/oIH6RA==
X-Google-Smtp-Source: AK7set8z65bE0+M0gykNppgGWBk8TlWcsgx5DUzESwfw/Ax2XlbrCEBLdhV3Mv/HMzjJGvRob3b5gw==
X-Received: by 2002:a17:906:6d53:b0:88e:682e:3a9e with SMTP id a19-20020a1709066d5300b0088e682e3a9emr8396987ejt.61.1676625293786;
        Fri, 17 Feb 2023 01:14:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm1868846ejz.127.2023.02.17.01.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 01:14:53 -0800 (PST)
Message-ID: <6ae9af19-1d52-c31f-79be-a36f06caaf80@linaro.org>
Date:   Fri, 17 Feb 2023 10:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
 <20230216134226.1692107-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216134226.1692107-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 14:42, Herve Codina wrote:
> Add support for the time slot assigner (TSA)
> available in some PowerQUICC SoC such as MPC885
> or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml | 234 ++++++++++++++++++
>  include/dt-bindings/soc/fsl,tsa.h             |  13 +
>  2 files changed, 247 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
>  create mode 100644 include/dt-bindings/soc/fsl,tsa.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
> new file mode 100644
> index 000000000000..bcd03f89780e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
> @@ -0,0 +1,234 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerQUICC CPM Time-slot assigner (TSA) controller
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The TSA is the time-slot assigner that can be found on some PowerQUICC SoC.
> +  Its purpose is to route some TDM time-slots to other internal serial
> +  controllers.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,mpc885-tsa
> +          - fsl,mpc866-tsa
> +      - const: fsl,cpm1-tsa
> +
> +  reg:
> +    items:
> +      - description: SI (Serial Interface) register base
> +      - description: SI RAM base
> +
> +  reg-names:
> +    items:
> +      - const: si_regs
> +      - const: si_ram
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#fsl,serial-cells':
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 1
> +    description:
> +      TSA consumers that use a phandle to TSA need to pass the serial identifier
> +      with this phandle (defined in dt-bindings/soc/fsl,tsa.h).
> +      For instance "fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;".
> +
> +patternProperties:
> +  '^tdm@[0-1]$':
> +    description:
> +      The TDM managed by this controller
> +    type: object
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +        description:
> +          The TDM number for this TDM, 0 for TDMa and 1 for TDMb
> +
> +      fsl,common-rxtx-pins:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The hardware can use four dedicated pins for Tx clock, Tx sync, Rx
> +          clock and Rx sync or use only two pins, Tx/Rx clock and Tx/Rx sync.
> +          Without the 'fsl,common-rxtx-pins' property, the four pins are used.
> +          With the 'fsl,common-rxtx-pins' property, two pins are used.
> +
> +      clocks:
> +        minItems: 2
> +        items:
> +          - description: External clock connected to L1RSYNC pin
> +          - description: External clock connected to L1RCLK pin
> +          - description: External clock connected to L1TSYNC pin
> +          - description: External clock connected to L1TCLK pin

Blank line

> +      clock-names:
> +        minItems: 2
> +        items:
> +          - const: l1rsync
> +          - const: l1rclk
> +          - const: l1tsync
> +          - const: l1tclk
> +
> +      fsl,diagnostic-mode:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [disabled, echo, internal-loopback, control-loopback]
> +        default: disabled
> +        description: |
> +          The diagnostic mode can be used to diagnose some communication issues.
> +          It should not be set (or set to 'disabled') when diagnostic is not
> +          needed.

I don't think this is property for DT. Are you going to ship devices to
customers with diagnostic mode? As you explained: no, so this can never
appear. You might need sysfs/debugfs knob.

You already got a comment for this. Your explanation "I plan" is not an
explanation why DT is suitable for such property. So let's make it more
obvious: drop it.

> +          Diagnostic mode:
> +            - disabled:
> +                Diagnostic disabled (ie. normal operation)
> +            - echo:
> +                Automatic echo. Rx data is resent on Tx.
> +            - internal-loopback:
> +                The TDM transmitter is connected to the receiver. Data appears
> +                on Tx pin.
> +            - control-loopback:
> +                The TDM transmitter is connected to the receiver. The Tx pin is
> +                disconnected.
> +
> +      fsl,rx-frame-sync-delay-bits:
> +        enum: [0, 1, 2, 3]

maxItems: 1

> +        default: 0
> +        description: |
> +          Receive frame sync delay in number of bits.
> +          Indicates the delay between the Rx sync and the first bit of the Rx
> +          frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
> +
> +      fsl,tx-frame-sync-delay-bits:
> +        enum: [0, 1, 2, 3]

maxItems: 1

> +        default: 0
> +        description: |
> +          Transmit frame sync delay in number of bits.
> +          Indicates the delay between the Tx sync and the first bit of the Tx
> +          frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
> +
> +      fsl,clock-falling-edge:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Data is sent on falling edge of the clock (and received on the rising
> +          edge). If 'clock-falling-edge' is not present, data is sent on the
> +          rising edge (and received on the falling edge).
> +
> +      fsl,fsync-rising-edge:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Frame sync pulses are sampled with the rising edge of the channel
> +          clock. If 'fsync-rising-edge' is not present, pulses are sampled with
> +          the falling edge.
> +
> +      fsl,double-speed-clock:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The channel clock is twice the data rate.
> +
> +    patternProperties:
> +      '^fsl,[rt]x-ts-routes$':
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        description: |
> +          A list of tuple that indicates the Tx or Rx time-slots routes.
> +        items:
> +          items:
> +            - description:
> +                The number of time-slots
> +              minimum: 1
> +              maximum: 64
> +            - description: |
> +                The source (Tx) or destination (Rx) serial interface
> +                (dt-bindings/soc/fsl,tsa.h defines these values)
> +                 - 0: No destination
> +                 - 1: SCC2
> +                 - 2: SCC3
> +                 - 3: SCC4
> +                 - 4: SMC1
> +                 - 5: SMC2
> +              enum: [0, 1, 2, 3, 4, 5]
> +        minItems: 1
> +        maxItems: 64
> +
> +    allOf:
> +      # If fsl,common-rxtx-pins is present, only 2 clocks are needed.
> +      # Else, the 4 clocks must be present.
> +      - if:
> +          required:
> +            - fsl,common-rxtx-pins
> +        then:
> +          properties:
> +            clocks:
> +              maxItems: 2
> +            clock-names:
> +              maxItems: 2
> +        else:
> +          properties:
> +            clocks:
> +              minItems: 4
> +            clock-names:
> +              minItems: 4
> +
> +    required:
> +      - reg
> +      - clocks
> +      - clock-names
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#fsl,serial-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/fsl,tsa.h>
> +
> +    tsa@ae0 {
> +        compatible = "fsl,mpc885-tsa", "fsl,cpm1-tsa";
> +        reg = <0xae0 0x10>,
> +              <0xc00 0x200>;
> +        reg-names = "si_regs", "si_ram";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #fsl,serial-cells = <1>;
> +
> +        tdm@0 {
> +            /* TDMa */
> +            reg = <0>;
> +
> +            clocks = <&clk_l1rsynca>, <&clk_l1rclka>;
> +            clock-names = "l1rsync", "l1rclk";
> +
> +            fsl,common-rxtx-pins;
> +            fsl,fsync-rising-edge;
> +
> +            fsl,tx-ts-routes = < 2 0 >,             /* TS 0..1 */

No spaces after < and before >

> +                           < 24 FSL_CPM_TSA_SCC4 >, /* TS 2..25 */
> +                           < 1 0 >,                 /* TS 26 */
> +                           < 5 FSL_CPM_TSA_SCC3 >;  /* TS 27..31 */
> +
> +            fsl,rx-ts-routes = < 2 0 >,             /* TS 0..1 */
> +                           < 24 FSL_CPM_TSA_SCC4 >, /* 2..25 */
> +                           < 1 0 >,                 /* TS 26 */
> +                           < 5 FSL_CPM_TSA_SCC3 >;  /* TS 27..31 */
> +        };
> +    };
> diff --git a/include/dt-bindings/soc/fsl,tsa.h b/include/dt-bindings/soc/fsl,tsa.h
> new file mode 100644
> index 000000000000..2cc44e867dbe
> --- /dev/null
> +++ b/include/dt-bindings/soc/fsl,tsa.h

Use same name as binding file.

> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +
> +#ifndef __DT_BINDINGS_SOC_FSL_TSA_H
> +#define __DT_BINDINGS_SOC_FSL_TSA_H

Best regards,
Krzysztof

