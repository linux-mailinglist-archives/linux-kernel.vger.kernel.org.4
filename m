Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3753661616
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjAHPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjAHPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:16:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652CD2BE3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:16:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z5so4745458wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXw9KAygztT5jDGimnXGtcc/RXt5y1LZ6kVLW6bynMM=;
        b=tpTCz4ws4jY+X1l3CQZUYaPGZa/EpzKs+yq2hYz6I47CqYW66cl+bAfI4BbsrWfmGs
         wtQgtBjyGmpB2lgMW0B1jgg3XLN9/ToR1pRqizZcEcj14V864ktX4fOpZODMiqs4QVlE
         89UDXaMWkCdVIeWxrbTMXsbvD5Hi55UcJXWyAUya0Ad5cGzzO9UkgL3JPCRYHinRUwoJ
         MuLaN18LU1Pm+aAZQDXbiTxX4s7eb9ALHtsSAS30swbfEvafY2NlTrmy/rpV5N+6dMDq
         pRGu/DUepZ8mhJShTxyIljbBeZfAscuPDkR3GYSyzWUEZdDqbobrRMhAg6jYvjyFBa/M
         98kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXw9KAygztT5jDGimnXGtcc/RXt5y1LZ6kVLW6bynMM=;
        b=4PP5dBZBWSBTXoAZWp/oedVu/TzXDn4IsldPiczAkyScTJye/aaSFkxoxUWZMVa7ri
         Ra3D5QiTj2AY736hPfhVQaE02WNysBCJHONyJko25+8Pxa2pPs4wccbO/i6KEQ37gse/
         wBQpiATmwtQXQ0F/XYLYTRhNaEAXQ3SfQO+P94nzJROCCt1WgCHWc3lISBbKKbKwd4TJ
         Wej/AGJgsbPFu4JGh1k6lu2EoZikZfiF9Njdi9/ua4fLeiupi3rzqn2YaW3WEhCQbA2/
         S4nfHksyR3SUjqoadB34YF1OjGy0DCPPgSA6FgZv8ObjTS7K9wgEj4Uoa/tZXG6qOF0/
         YAPw==
X-Gm-Message-State: AFqh2krnryq9oLPQ5I8hXnShloTMw7BjcMpzeSTWoXc0F/kLVzsh6V+o
        pFHAHtgghBGGXBy5Pct16pPskw==
X-Google-Smtp-Source: AMrXdXviZdBmClnb6Toply9D3tNh+sz2JLSNoU9T04Iga71AMgdwS3TaY1guKipjbFqDnRnrIwrRUA==
X-Received: by 2002:a5d:5e81:0:b0:244:e704:df2c with SMTP id ck1-20020a5d5e81000000b00244e704df2cmr44150318wrb.57.1673190986931;
        Sun, 08 Jan 2023 07:16:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d4b44000000b002366dd0e030sm6261986wrs.68.2023.01.08.07.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:16:26 -0800 (PST)
Message-ID: <c393e532-d466-366b-a390-65de47c58b6a@linaro.org>
Date:   Sun, 8 Jan 2023 16:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 08/10] dt-bindings: sound: Add support for QMC audio
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
 <20230106163746.439717-9-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106163746.439717-9-herve.codina@bootlin.com>
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
> The QMC (QUICC mutichannel controller) is a controller
> present in some PowerQUICC SoC such as MPC885.
> The QMC audio is an ASoC component that uses the QMC
> controller to transfer the audio data.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/fsl,qmc-audio.yaml         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
> new file mode 100644
> index 000000000000..b3774be36c19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,qmc-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QMC audio
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
> +  Controller) channels to transfer the audio data.
> +  It provides as many DAI as the number of QMC channel used.
> +
> +properties:
> +  compatible:
> +    items:

Drop items.

> +      - const: fsl,qmc-audio
> +
> +  '#address-cells':
> +    const: 1
> +  '#size-cells':
> +    const: 0
> +  '#sound-dai-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^dai@([0-9]|[1-5][0-9]|6[0-3])$":
> +    description:
> +      A DAI managed by this controller
> +    type: object
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 63
> +        description:
> +          The DAI number
> +
> +      qmc-chan:

Missing vendor prefix.

> +        $ref: /schemas/types.yaml#/definitions/phandle-array

Why this is not a phandle?

> +        description: phandle to the QMC channel> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - qmc-chan
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#sound-dai-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    qmc_audio: qmc_audio {

Same problem as in previous patch.

> +        compatible = "fsl,qmc-audio";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #sound-dai-cells = <1>;
> +        dai@16 {
> +            reg = <16>;
> +            qmc-chan = <&scc_qmc 16>;
> +        };
> +        dai@17 {
> +            reg = <17>;
> +            qmc-chan = <&scc_qmc 17>;
> +        };
> +    };

Best regards,
Krzysztof

