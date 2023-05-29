Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A54714BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjE2OLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE2OLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:11:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47D110;
        Mon, 29 May 2023 07:10:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso3199623f8f.0;
        Mon, 29 May 2023 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685369450; x=1687961450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10o9jmZWeP457p2kLERKO+3a4U7ZX8eeTkQQ7+6/jtg=;
        b=R/rqDkNlnRgXOH1pDR5R2SSc30hzPgW0hPNMtwNUrgpO8HXY3pY3T2BoA4vrSxPgOD
         uXUIldAd/8jFOYIQyC153wIBVX/AJ3MjygoVgbWscuZo7HwahFejjaBDGl8bRLDFU88U
         ZinOpb71aOiSoFvt8gODU5oDbNiuDTPsb1lV3BPARvLCJkxDfAnwAj5FWAtSa8311wO1
         5DMOC4jWMkWct6/V3mTiY1omJIM1cCpeKzovWPXNM3Y4LSm1CCgQg0unu5FRiELGea//
         voB22/S3nulIGlPNptxRVXWbm5PVMiHqaQYRx4Ch0LJzaNqZvA923HAC8OKOleLQwOaY
         3/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685369450; x=1687961450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10o9jmZWeP457p2kLERKO+3a4U7ZX8eeTkQQ7+6/jtg=;
        b=U1XyGLNjoTEU1D2qAlz0wpCDOxWIxKvpx2jy3pzAhpMRvb5Rkc03mp0FhQt9bZlQva
         MbznRE/Jnff+WNjiO2ta8vePTzle52qcpDwLKcO2e6bmWN20h7+tQluehlMKY5vNdAT8
         AWiRbmrXm8evRMhCJsnytpec2GsmxCdx96IN52Tbu8qC+qr5A7SOPfqzJ+V3rnUWCA01
         oEuFeV3ycx+BweCUZH+MrjJK+6Z495tf0BU0d0tkjERR45RFmknkuwwvrNGpfFdnhzhE
         Fmj58xAONhTFsREvN7MJPZR1S0Nnuj9OcLY1qlnBOTPg6sfiRxCVdb0ptrfmN4NsfaDa
         NW+g==
X-Gm-Message-State: AC+VfDy1kAOoC/CHBsIRXimh5jVfM9Lw+vrhYJlTTgw/g3sn7OtuczvN
        +o8rPU02yuGrtigE9J99uHM=
X-Google-Smtp-Source: ACHHUZ6A74E+BgfNtlIZYglrKBVuUz4y94mfpo3xLAeito8AShd1iQMhnZMhDZbfgGvwCnI7VQYABw==
X-Received: by 2002:a5d:618d:0:b0:30a:ddb3:93b with SMTP id j13-20020a5d618d000000b0030addb3093bmr8244185wru.63.1685369449882;
        Mon, 29 May 2023 07:10:49 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe347000000b00309382eb047sm39744wrj.112.2023.05.29.07.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:10:48 -0700 (PDT)
Message-ID: <e744408d-2bc7-886e-2f32-0a05a1dd570a@gmail.com>
Date:   Mon, 29 May 2023 16:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v12 03/11] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
Content-Language: en-US, ca-ES, es-ES
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230517043449.26352-1-tinghan.shen@mediatek.com>
 <20230517043449.26352-4-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230517043449.26352-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2023 06:34, Tinghan Shen wrote:
> Extend the SCP binding to describe the MT8195 dual-core SCP.
> 
> Under different applications, the MT8195 SCP can be used as single-core
> or dual-core. This change keeps the single-core definitions and
> adds new definitions for the dual-core use case.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/remoteproc/mtk,scp.yaml          | 145 +++++++++++++++++-
>   1 file changed, 141 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 271081df0e46..09102dda4942 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -21,6 +21,7 @@ properties:
>         - mediatek,mt8188-scp
>         - mediatek,mt8192-scp
>         - mediatek,mt8195-scp
> +      - mediatek,mt8195-scp-dual
>   
>     reg:
>       description:
> @@ -31,10 +32,7 @@ properties:
>   
>     reg-names:
>       minItems: 2
> -    items:
> -      - const: sram
> -      - const: cfg
> -      - const: l1tcm
> +    maxItems: 3
>   
>     clocks:
>       description:
> @@ -70,6 +68,81 @@ properties:
>   
>       unevaluatedProperties: false
>   
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges:
> +    description:
> +      Standard ranges definition providing address translations for
> +      local SCP SRAM address spaces to bus addresses.
> +
> +patternProperties:
> +  "^scp@[a-f0-9]+$":
> +    type: object
> +    description:
> +      The MediaTek SCP integrated to SoC might be a multi-core version.
> +      The other cores are represented as child nodes of the boot core.
> +      There are some integration differences for the IP like the usage of
> +      address translator for translating SoC bus addresses into address space
> +      for the processor.
> +
> +      Each SCP core has own cache memory. The SRAM and L1TCM are shared by
> +      cores. The power of cache, SRAM and L1TCM power should be enabled
> +      before booting SCP cores. The size of cache, SRAM, and L1TCM are varied
> +      on differnt SoCs.
> +
> +      The SCP cores do not use an MMU, but has a set of registers to
> +      control the translations between 32-bit CPU addresses into system bus
> +      addresses. Cache and memory access settings are provided through a
> +      Memory Protection Unit (MPU), programmable only from the SCP.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - mediatek,scp-core
> +
> +      reg:
> +        description: The base address and size of SRAM.
> +        maxItems: 1
> +
> +      reg-names:
> +        const: sram
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      firmware-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          If present, name (or relative path) of the file within the
> +          firmware search path containing the firmware image used when
> +          initializing sub cores of multi-core SCP.
> +
> +      memory-region:
> +        maxItems: 1
> +
> +      cros-ec-rpmsg:
> +        $ref: /schemas/mfd/google,cros-ec.yaml
> +        description:
> +          This subnode represents the rpmsg device. The properties
> +          of this node are defined by the individual bindings for
> +          the rpmsg devices.
> +
> +        required:
> +          - mediatek,rpmsg-name
> +
> +        unevaluatedProperties: false
> +
> +    required:
> +      - compatible
> +      - reg
> +      - reg-names
> +
> +    additionalProperties: false
> +
>   required:
>     - compatible
>     - reg
> @@ -99,7 +172,37 @@ allOf:
>           reg:
>             maxItems: 2
>           reg-names:
> +          items:
> +            - const: sram
> +            - const: cfg
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8192-scp
> +            - mediatek,mt8195-scp
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 3
> +        reg-names:
> +          items:
> +            - const: sram
> +            - const: cfg
> +            - const: l1tcm
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8195-scp-dual
> +    then:
> +      properties:
> +        reg:
>             maxItems: 2
> +        reg-names:
> +          items:
> +            - const: cfg
> +            - const: l1tcm
>   
>   additionalProperties: false
>   
> @@ -121,3 +224,37 @@ examples:
>               mediatek,rpmsg-name = "cros-ec-rpmsg";
>           };
>       };
> +
> +  - |
> +    scp@10500000 {
> +        compatible = "mediatek,mt8195-scp-dual";
> +        reg = <0x10720000 0xe0000>,
> +              <0x10700000 0x8000>;
> +        reg-names = "cfg", "l1tcm";
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x10500000 0x100000>;
> +
> +        scp@0 {
> +            compatible = "mediatek,scp-core";
> +            reg = <0x0 0xa0000>;
> +            reg-names = "sram";
> +
> +            cros-ec-rpmsg {
> +                compatible = "google,cros-ec-rpmsg";
> +                mediatek,rpmsg-name = "cros-ec-rpmsg";
> +            };
> +        };
> +
> +        scp@a0000 {
> +            compatible = "mediatek,scp-core";
> +            reg = <0xa0000 0x20000>;
> +            reg-names = "sram";
> +
> +            cros-ec-rpmsg {
> +                compatible = "google,cros-ec-rpmsg";
> +                mediatek,rpmsg-name = "cros-ec-rpmsg";
> +            };
> +        };
> +    };
