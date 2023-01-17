Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6466E15F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAQOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAQOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:55:34 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102543E62B;
        Tue, 17 Jan 2023 06:55:32 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15f64f2791dso1889995fac.7;
        Tue, 17 Jan 2023 06:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0xOPUwMGbHKwlz1eX+ZfzIFwn/1MAHYgP6guftK2G0=;
        b=QsmuofTh3tL6pNnLGIlkEw0QvnnBuTtu77jvG0AJmRrq3CdRtBCU0LEZ8btw0eJz7b
         +lzlAhyGb/1qWGKWeo+HfbzqZelrZT7QStCVepLvwk7YMACAiHsAqhWvjxembfvYG+qH
         59cC+Yuhr3L7Yz1KIWN+DsgeiYgeq66fpcciMugUMYoYe6nFyAmL2CIN7RUjxwx0sRsc
         sYuBxaCB8IJe8HKnpjhjIXTsCYoo7Stuws3Qg/vJ7eqMcGNGE0F+lgWugrp1+Q9OJ1gX
         kod1mfB2IjoURiLzzTkgr0go0b0zBDc3bH8zP01uon/3AaXj6rdNuyoRZW1anmXXXo5H
         M2ww==
X-Gm-Message-State: AFqh2krxanjSKePbknml8NCAnkReyKQkrKrO2Xg90bm19zLgmPUO+OJl
        TXS/6ppTpdwb321b32CfGQ==
X-Google-Smtp-Source: AMrXdXsNUJ00dTOKvt2jfPMH4Ze0uTp6cmxdG4fza3JfdEkyhCZe9BD6Z//VMQY6JmDD12zrOOWqFg==
X-Received: by 2002:a05:6870:2f02:b0:15f:3213:dfc6 with SMTP id qj2-20020a0568702f0200b0015f3213dfc6mr1901825oab.35.1673967331153;
        Tue, 17 Jan 2023 06:55:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0013ae5246449sm16348572oac.22.2023.01.17.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:55:30 -0800 (PST)
Received: (nullmailer pid 3058299 invoked by uid 1000);
        Tue, 17 Jan 2023 14:55:29 -0000
Date:   Tue, 17 Jan 2023 08:55:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>,
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
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Message-ID: <20230117145529.GA3044055-robh@kernel.org>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
 <20230113103759.327698-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103759.327698-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:37:50AM +0100, Herve Codina wrote:
> Add support for the time slot assigner (TSA)
> available in some PowerQUICC SoC such as MPC885
> or MPC866.

An odd line wrap length... 

> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,tsa.yaml      | 260 ++++++++++++++++++
>  include/dt-bindings/soc/fsl,tsa.h             |  13 +
>  2 files changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml
>  create mode 100644 include/dt-bindings/soc/fsl,tsa.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml
> new file mode 100644
> index 000000000000..eb17b6119abd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml
> @@ -0,0 +1,260 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,tsa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerQUICC CPM Time-slot assigner (TSA) controller
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  The TSA is the time-slot assigner that can be found on some
> +  PowerQUICC SoC.
> +  Its purpose is to route some TDM time-slots to other internal
> +  serial controllers.

Wrap at 80.

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
> +patternProperties:
> +  '^tdm@[0-1]$':
> +    description:
> +      The TDM managed by this controller
> +    type: object

       additionalProperties: false

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
> +          The hardware can use four dedicated pins for Tx clock,
> +          Tx sync, Rx clock and Rx sync or use only two pins,
> +          Tx/Rx clock and Rx/Rx sync.
> +          Without the 'fsl,common-rxtx-pins' property, the four
> +          pins are used. With the 'fsl,common-rxtx-pins' property,
> +          two pins are used.
> +
> +      clocks:
> +        minItems: 2
> +        maxItems: 4
> +
> +      clock-names:
> +        minItems: 2
> +        maxItems: 4
> +
> +      fsl,mode:

'mode' is a bit vague. It's already used as well which can be a problem 
if there are differing types. (There's not in this case)

> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [normal, echo, internal-loopback, control-loopback]
> +        default: normal
> +        description: |
> +          Operational mode:
> +            - normal:
> +                Normal operation
> +            - echo:
> +                Automatic echo. Rx data is resent on Tx
> +            - internal-loopback:
> +                The TDM transmitter is connected to the receiver.
> +                Data appears on Tx pin.
> +            - control-loopback:
> +                The TDM transmitter is connected to the receiver.
> +                The Tx pin is disconnected.
> +
> +      fsl,rx-frame-sync-delay-bits:
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +        description: |
> +          Receive frame sync delay in number of bits.
> +          Indicates the delay between the Rx sync and the first bit of the
> +          Rx frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
> +
> +      fsl,tx-frame-sync-delay-bits:
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +        description: |
> +          Transmit frame sync delay in number of bits.
> +          Indicates the delay between the Tx sync and the first bit of the
> +          Tx frame. 0 for no bit delay. 1, 2 or 3 for 1, 2 or 3 bits delay.
> +
> +      fsl,clock-falling-edge:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: |
> +          Data is sent on falling edge of the clock (and received on the
> +          rising edge).
> +          If 'clock-falling-edge' is not present, data is sent on the
> +          rising edge (and received on the falling edge).
> +
> +      fsl,fsync-rising-edge:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Frame sync pulses are sampled with the rising edge of the channel
> +          clock. If 'fsync-rising-edge' is not present, pulses are sample
> +          with e falling edge.
> +
> +      fsl,double-speed-clock:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The channel clock is twice the data rate.
> +
> +      fsl,tx-ts-routes:
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        description: |
> +          A list of tupple that indicates the Tx time-slots routes.
> +            tx_ts_routes =
> +               < 2 0 >, /* The first 2 time slots are not used */
> +               < 3 1 >, /* The next 3 ones are route to SCC2 */
> +               < 4 0 >, /* The next 4 ones are not used */
> +               < 2 2 >; /* The nest 2 ones are route to SCC3 */
> +        items:
> +          items:
> +            - description:
> +                The number of time-slots
> +              minimum: 1
> +              maximum: 64
> +            - description: |
> +                The source serial interface (dt-bindings/soc/fsl,tsa.h
> +                defines these values)
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
> +      fsl,rx-ts-routes:
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        description: |
> +          A list of tupple that indicates the Rx time-slots routes.
> +            tx_ts_routes =
> +               < 2 0 >, /* The first 2 time slots are not used */
> +               < 3 1 >, /* The next 3 ones are route from SCC2 */
> +               < 4 0 >, /* The next 4 ones are not used */
> +               < 2 2 >; /* The nest 2 ones are route from SCC3 */
> +        items:
> +          items:
> +            - description:
> +                The number of time-slots
> +              minimum: 1
> +              maximum: 64
> +            - description: |
> +                The destination serial interface (dt-bindings/soc/fsl,tsa.h
> +                defines these values)
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
> +              items:
> +                - description: External clock connected to L1RSYNC pin
> +                - description: External clock connected to L1RCLK pin
> +            clock-names:
> +              items:
> +                - const: l1rsync
> +                - const: l1rclk
> +        else:
> +          properties:
> +            clocks:
> +              items:
> +                - description: External clock connected to L1RSYNC pin
> +                - description: External clock connected to L1RCLK pin
> +                - description: External clock connected to L1TSYNC pin
> +                - description: External clock connected to L1TCLK pin
> +            clock-names:
> +              items:
> +                - const: l1rsync
> +                - const: l1rclk
> +                - const: l1tsync
> +                - const: l1tclk

As the names are the same, just the length varies between 2 or 4, move 
all this to the main definition and here just put constraints on the 
length.

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
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +
> +#ifndef __DT_BINDINGS_SOC_FSL_TSA_H
> +#define __DT_BINDINGS_SOC_FSL_TSA_H
> +
> +#define FSL_CPM_TSA_NU		0	/* Pseuso Cell Id for not used item */
> +#define FSL_CPM_TSA_SCC2	1
> +#define FSL_CPM_TSA_SCC3	2
> +#define FSL_CPM_TSA_SCC4	3
> +#define FSL_CPM_TSA_SMC1	4
> +#define FSL_CPM_TSA_SMC2	5
> +
> +#endif
> -- 
> 2.38.1
> 
