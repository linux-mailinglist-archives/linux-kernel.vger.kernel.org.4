Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26300661610
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjAHPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjAHPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:14:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391FCDEFC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:14:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so7192270wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kum/h3WoydN+pm7yzyrAbYktEmQZxXZIgzMlKqIfzRs=;
        b=B17dgkv12M5xpcm41prkaN1pTZSj1sIvPdyYkNeyGu+fVlfcN/UNBd5Vfr+PCgtrrR
         uUyGKa5hIjxm6nWEFQflNI8Z/T0BePImhtKOOfq0ha7YhJVOacTw7oCFowQx3vvsBCC8
         Jo09Ga6boCwekrTRdjCBRLlPPmVUa0epePP9gvYMzROlxMU+gUA4d+xJGRzCVE4ndqDL
         dSpwiyEnbx9uwnCHMIiOBrJI1YuNqedHnVuzroaYBVPuvGhAMh26mXwwgcC1yaxghFqu
         B4V9ZbTaoq2T1ov47NvIJB9QQDKVH8rJCoBQwxFxCjOqBsdav6y1Bnr7APW0nkjfg99T
         vIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kum/h3WoydN+pm7yzyrAbYktEmQZxXZIgzMlKqIfzRs=;
        b=kws/OdI6dWz0pfULuVfxvAt4FuzMN6I8i6w+/ly7c5hQPbjxwjuQbNYUPCugfGOFNF
         UhA0l0xNgK4hPathuoQW041TeC4NxGhGDY/TH7fSMbaXhIDbklQyvAy291d9kOonNVss
         1iCP7e+QDmDTlXQmeIintRq9c3zblcnDzU7W17FKjbulfX0WFcVzwgSWoIuvsG26hVht
         zS8/Rf3YmI17/YUE2qpT3W+FcVwByxJeSjpoz0H5yxlyZ4EARlST/Lq2IO4Ewa7GmSq/
         rRfNmgGlsH//yhs3xvv+27FjZ12h8SYgCW+eF7L0jiEqrrYPdf+dFUbvzY+dKhQgEi9b
         axmA==
X-Gm-Message-State: AFqh2kpLva2+fIk0IidX0/iCzQzE5niHuhG/WqL6iF96gsGFkKlC2jyP
        Yzd8cg1vg6yTZ13ztG8ty7HKuQ==
X-Google-Smtp-Source: AMrXdXsEQW0bDV9OZcom7tmbUrlLwDsgiDLU21uXmHqGTahcowbhAAYwsT+7Wijlz/86kxWzzUwtZg==
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr48239469wmg.14.1673190889730;
        Sun, 08 Jan 2023 07:14:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d55c5000000b002a6f329203esm6356517wrw.61.2023.01.08.07.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:14:49 -0800 (PST)
Message-ID: <76077f5f-fbda-800b-b8d8-6a3f6600f4d1@linaro.org>
Date:   Sun, 8 Jan 2023 16:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
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
References: <20230106163746.439717-1-herve.codina@bootlin.com>
 <20230106163746.439717-6-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106163746.439717-6-herve.codina@bootlin.com>
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

On 06/01/2023 17:37, Herve Codina wrote:
> Add support for the QMC (QUICC Multichannel Controller)
> available in some PowerQUICC SoC such as MPC885 or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> new file mode 100644
> index 000000000000..caf71f3a3f3f
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
> +description: |
> +  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within
> +  one serial controller using the same TDM physical interface routed from
> +  TSA.
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
> +    description: SCC interrupt line in the CPM interrupt controller

Missing constraints.

> +
> +  fsl,cpm-command:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Cf. soc/fsl/cpm_qe/cpm.txt

Missing description.

> +
> +  tsa:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the TSA

Missing vendor prefix. Does not look like a generic property.

> +
> +  tsa-cell-id:
> +    enum: [1, 2, 3]
> +    description: |
> +      TSA cell ID (dt-bindings/soc/fsl-tsa.h defines these values)
> +       - 1: SCC2
> +       - 2: SCC3
> +       - 3: SCC4
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#chan-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^channel@([0-9]|[1-5][0-9]|6[0-3])$":
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
> +      fsl,mode:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [transparent, hdlc]
> +        default: transparent
> +        description: Operational mode

And what do they mean?

> +
> +      fsl,reverse-data:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The bit order as seen on the channels is reversed,
> +          transmitting/receiving the MSB of each octet first.
> +          This flag is used only in 'transparent' mode.
> +
> +      tx-ts-mask:

Missing vendor prefix.

> +        $ref: /schemas/types.yaml#/definitions/uint64
> +        description:
> +          Channel assigned Tx time-slots within the Tx time-slots routed
> +          by the TSA to this cell.
> +
> +      rx-ts-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint64
> +        description:
> +          Channel assigned Rx time-slots within the Rx time-slots routed
> +          by the TSA to this cell.
> +
> +    required:
> +      - reg
> +      - tx-ts-mask
> +      - rx-ts-mask
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - tsa
> +  - tsa-cell-id
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#chan-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/fsl-tsa.h>
> +
> +    scc_qmc@a60 {

No underscores in node names.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "fsl,mpc885-scc-qmc", "fsl,cpm1-scc-qmc";
> +        reg = <0xa60 0x20>,
> +              <0x3f00 0xc0>,
> +              <0x2000 0x1000>;
> +        reg-names = "scc_regs", "scc_pram", "dpram";
> +        interrupts = <27>;
> +        interrupt-parent = <&CPM_PIC>;
> +        fsl,cpm-command = <0xc0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #chan-cells = <1>;
> +
> +        tsa = <&tsa>;
> +        tsa-cell-id = <FSL_CPM_TSA_SCC4>;
> +
> +        channel@16 {
> +            /* Ch16 : First 4 even TS from all routed from TSA */
> +            reg = <16>;
> +            fsl,mode = "transparent";
> +            fsl,reverse-data;
> +            tx-ts-mask = <0x00000000 0x000000AA>;
> +            rx-ts-mask = <0x00000000 0x000000AA>;

Keep case consistent. lower-case hex.

Best regards,
Krzysztof

