Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1214D68193A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjA3Sb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjA3Sb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:31:27 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C454614A;
        Mon, 30 Jan 2023 10:30:40 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-15ff0a1f735so16218395fac.5;
        Mon, 30 Jan 2023 10:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL0XOnM/U7AHKraTDCdJZWk2TQOTKFX1C9g4dchN86w=;
        b=Dbd7jewtuzj6xdVqVpHzCEIl0cFEot9ATcbaviMyPaqx2tl/+E+xNXE88qcj30PeYL
         rsdyEhB65sQqWYBfsKyT1jta0MlwbO1XqtIFUzUvsMq5BG3pEMrW6YKSwyPtZW6VZYdH
         K1KZ2LFjEHu2LMC/yLgBgULOoPnwBLq6CFF/MXHxLHxJ/ZDB19CVgKUYKPEQ9KQrS3Wd
         xCFFqZynhNWc4S8MrZvEt57KSZKlqhGLnLJxgi1/6W8chlbnHzf/rFr9E3pqcxDTwtXB
         XTB6tZIrbU1yAm0G0VpiZC26TM301aJDWvYbyb6UhZGaF8XLMaSxIeH9+A8jLMAJ+jV6
         3vDg==
X-Gm-Message-State: AO0yUKUeiKzO8ROTqQLkBN9l/HzAdssAtrjCjvo20738mBCKzZL8iCy4
        G74V7Lt/fB/IVU8+FPfB9w==
X-Google-Smtp-Source: AK7set8WumFqo2/url09aCWXFr9d4CgsgMxE0JPfvUmC+ZR+vH6Rzi3hfHg9slwsD0qBFnUrzRcYzQ==
X-Received: by 2002:a05:6870:2482:b0:156:6665:ed6d with SMTP id s2-20020a056870248200b001566665ed6dmr4636731oaq.38.1675103439204;
        Mon, 30 Jan 2023 10:30:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w17-20020a056870e2d100b00144e6ffe9e5sm5534767oad.47.2023.01.30.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:30:38 -0800 (PST)
Received: (nullmailer pid 3079408 invoked by uid 1000);
        Mon, 30 Jan 2023 18:30:37 -0000
Date:   Mon, 30 Jan 2023 12:30:37 -0600
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
Subject: Re: [PATCH v4 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
 controller
Message-ID: <20230130183037.GA3076426-robh@kernel.org>
References: <20230126083222.374243-1-herve.codina@bootlin.com>
 <20230126083222.374243-6-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126083222.374243-6-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:32:17AM +0100, Herve Codina wrote:
> Add support for the QMC (QUICC Multichannel Controller)
> available in some PowerQUICC SoC such as MPC885 or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 167 ++++++++++++++++++

fsl,cpm1-scc-qmc.yaml

>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> new file mode 100644
> index 000000000000..9141a8ca183b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> @@ -0,0 +1,167 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within one
> +  serial controller using the same TDM physical interface routed from TSA.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,mpc885-scc-qmc
> +          - fsl,mpc866-scc-qmc
> +      - const: fsl,cpm1-scc-qmc
> +
> +  reg:
> +    items:
> +      - description: SCC (Serial communication controller) register base
> +      - description: SCC parameter ram base
> +      - description: Dual port ram base
> +
> +  reg-names:
> +    items:
> +      - const: scc_regs
> +      - const: scc_pram
> +      - const: dpram
> +
> +  interrupts:
> +    maxItems: 1
> +    description: SCC interrupt line in the CPM interrupt controller
> +
> +  fsl,tsa-serial:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TSA node
> +          - enum: [1, 2, 3]
> +            description: |
> +              TSA serial interface (dt-bindings/soc/fsl,tsa.h defines these
> +              values)
> +               - 1: SCC2
> +               - 2: SCC3
> +               - 3: SCC4
> +    description:
> +      Should be a phandle/number pair. The phandle to TSA node and the TSA
> +      serial interface to use.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#chan-cells':
> +    const: 1

What's this?

> +
> +patternProperties:
> +  '^channel@([0-9]|[1-5][0-9]|6[0-3])$':
> +    description:
> +      A channel managed by this controller
> +    type: object
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 63
> +        description:
> +          The channel number
> +
> +      fsl,operational-mode:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [transparent, hdlc]
> +        default: transparent
> +        description: |
> +          The channel operational mode
> +            - hdlc: The channel handles HDLC frames
> +            - transparent: The channel handles raw data without any processing
> +
> +      fsl,reverse-data:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The bit order as seen on the channels is reversed,
> +          transmitting/receiving the MSB of each octet first.
> +          This flag is used only in 'transparent' mode.
> +
> +      fsl,tx-ts-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint64
> +        description:
> +          Channel assigned Tx time-slots within the Tx time-slots routed by the
> +          TSA to this cell.
> +
> +      fsl,rx-ts-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint64
> +        description:
> +          Channel assigned Rx time-slots within the Rx time-slots routed by the
> +          TSA to this cell.
> +
> +    required:
> +      - reg
> +      - fsl,tx-ts-mask
> +      - fsl,rx-ts-mask
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - fsl,tsa-serial
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#chan-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/fsl,tsa.h>
> +
> +    qmc@a60 {
> +        compatible = "fsl,mpc885-scc-qmc", "fsl,cpm1-scc-qmc";
> +        reg = <0xa60 0x20>,
> +              <0x3f00 0xc0>,
> +              <0x2000 0x1000>;
> +        reg-names = "scc_regs", "scc_pram", "dpram";
> +        interrupts = <27>;
> +        interrupt-parent = <&CPM_PIC>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #chan-cells = <1>;
> +
> +        fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;
> +
> +        channel@16 {
> +            /* Ch16 : First 4 even TS from all routed from TSA */
> +            reg = <16>;
> +            fsl,mode = "transparent";
> +            fsl,reverse-data;
> +            fsl,tx-ts-mask = <0x00000000 0x000000aa>;
> +            fsl,rx-ts-mask = <0x00000000 0x000000aa>;
> +        };
> +
> +        channel@17 {
> +            /* Ch17 : First 4 odd TS from all routed from TSA */
> +            reg = <17>;
> +            fsl,mode = "transparent";
> +            fsl,reverse-data;
> +            fsl,tx-ts-mask = <0x00000000 0x00000055>;
> +            fsl,rx-ts-mask = <0x00000000 0x00000055>;
> +        };
> +
> +        channel@19 {
> +            /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
> +            reg = <19>;
> +            fsl,mode = "hdlc";
> +            fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
> +            fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
> +        };
> +    };
> -- 
> 2.39.0
> 
