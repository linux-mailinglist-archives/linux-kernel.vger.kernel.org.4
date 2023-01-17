Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422D66DC76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjAQLcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjAQLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E91193CA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:31:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1306473wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3EkrOrIsoGEjlXNQEPTeW63ljQubkNcPYNJb7gZfuY=;
        b=QhBqq2ukGol8Dny+uxp1UtX3xOQ996K9vcPiDP5m3o5/CaC696MrNiK1LegSjSkp+n
         eYNR0oKhzdmtvHN21+skBAsHgJ9LmiHUG4xtsMBsuKcSHAM1taKiPK+O8in4qkYbnXQ0
         jstWKCtRvJ4/8t2Z0LkfWY+yvqYahCXfCA1ZdaUAWnQO0GASOeBKkOdi6XXAxVB2HgZG
         //MZfaHKboeCfCP+V1YvO1mYNJPc39sNyv25GAWIbsuxj/3/R8JKvn38xKtbbzV4wj4d
         V16ijyQbZDpaKcFaPitLH3Ucoms/ssVKe9XzhJjsagdPW9tK5YsJ604wVDf88Nkorwwq
         uFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3EkrOrIsoGEjlXNQEPTeW63ljQubkNcPYNJb7gZfuY=;
        b=7Ss+zcfVJES7OnaSV5dAYLu5fnAtDYwflRqWdiAOFvutQTFbxRKRc8IwH2aXkZ08wq
         ZuL9zCUR7xSMDfzfYpBPnIGT/vGzxIRRtlbEHwOu8QWvmb4PFhHyzsWQS0MBWu9y8ys9
         IMh2cJVoaoBZdHj0LzecDEurMgIjMZaL+eaKeyLXCQ6Hg8ps5kNBoOvOTj5YWyaXPh2K
         8kOYKZfgLulpZ0tWm33U9EcpSuvJGF7Y8h082L6jPdbUD1BwbB8KJqfHiC4a/Ee+7msI
         tCDlihT5vVd5blJmWxrj/L5I3N2TdWCkVl4VtdbJoz4RmzxClB4WsZeVEgJPNgt6QlaD
         54pA==
X-Gm-Message-State: AFqh2krc78stgw3DDs1LDNXYNUvDt1TgZdGhlNRixdGjhM68kCGOsl0i
        YBAz5IUtOMUoluSCNhKD/z+isA==
X-Google-Smtp-Source: AMrXdXsAZl1MLOjQo2d3qzzRlNy+HJn/RhgvDPfSZDlkj/nJewQUkMhVEVuNshej/DJMn5pYVRGtGg==
X-Received: by 2002:a05:600c:3088:b0:3da:1bb0:4d8a with SMTP id g8-20020a05600c308800b003da1bb04d8amr2902593wmn.16.1673955071493;
        Tue, 17 Jan 2023 03:31:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k7-20020adfd227000000b002bdf3809f59sm8052618wrh.38.2023.01.17.03.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:31:10 -0800 (PST)
Message-ID: <316ddb81-8d13-71dd-3396-412e31cfb880@linaro.org>
Date:   Tue, 17 Jan 2023 12:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
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
References: <20230113103759.327698-1-herve.codina@bootlin.com>
 <20230113103759.327698-6-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113103759.327698-6-herve.codina@bootlin.com>
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

On 13/01/2023 11:37, Herve Codina wrote:
> Add support for the QMC (QUICC Multichannel Controller)
> available in some PowerQUICC SoC such as MPC885 or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> new file mode 100644
> index 000000000000..3ec52f1635c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
> @@ -0,0 +1,164 @@
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
> +    maxItems: 1
> +    description: SCC interrupt line in the CPM interrupt controller
> +
> +  fsl,tsa:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the TSA
> +
> +  fsl,tsa-cell-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +    description: |
> +      TSA cell ID (dt-bindings/soc/fsl,tsa.h defines these values)
> +       - 1: SCC2
> +       - 2: SCC3
> +       - 3: SCC4

Is this used as argument to tsa? If so, this should be part of fsl,tsa
property, just like we do for all syscon-like phandles.

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
> +      fsl,mode:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: [transparent, hdlc]
> +        default: transparent
> +        description: Operational mode

You still need to explain what do transparent and hdlc mean.

> +


Best regards,
Krzysztof

