Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27249668F97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjAMHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAMHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:52:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556E63391
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:52:12 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so7375962ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBghY86jJuEVQ+AH+91zNe2AIXF3nPFzvcmXm4jdEbQ=;
        b=qrQtVENj71y4qXu0yz0Y3sXQ4A/TRVKwjpPaSmS9OHf1H6c/xj1qF1HhbGiqxXbskA
         s1BNaIB/Ebf2aew2Bff8cTa//o6Chk6g4qqke0WwIbMCvnS5sfvTC58UWHFBxRWnYCQs
         CChymXkI6bnQOGRX+0NZ3ieHcKDbBNnC7VJp95THNKKS1JyjQ/3ShS42gKcVnlK40L36
         OBmfSg11a4Cz3CoyWm17rDr6/ax6bcLCsjyei0P6ZeLd9KLzlO+be061piadNMg7L+zi
         RyPwmMXIGtt+Ya36mzbguUexyLcCfM4vgbnCCCXb9oFzif4bUOwU/Hicd6PyfTWyFvdj
         b58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBghY86jJuEVQ+AH+91zNe2AIXF3nPFzvcmXm4jdEbQ=;
        b=yPO6gIpbG108OjGHjneNWjvnLliCDKXNQTAAT+yepLFZg6ysIv6suEMBJiDabW3pqg
         UpEtRnq0DQT0fM4rqTxG1foVGeLO0Rz+3ayf9zmKlVmg+ZlzdmvgQxgbD/aYVULvJ2cz
         0uv/XAXIXL7nAeX1k92lYjZCkqXWSeE4qYoBPF9VpWTttFC2w58tkaQBUYsZiqZEJyJv
         kYyFolkAAwTZBWiFSva0aGhbmAo87AheCQd7OpHB61u/nhj1BjOvt1zkLxXZxBfgD7Fp
         K76p3C/Nj9V5BMBFAjD9Cr+9yMggF+oM9DSxOltI8GEIX6TkGiuRDqdE+hVEVbJ9Exrk
         9M9g==
X-Gm-Message-State: AFqh2kobxS5yMlcCT1fYom/iIsS/LbMIKs77KfTMDz+HET6T57M7Kxrm
        xhRcP2pnambG9KKZsNT+5nx93w==
X-Google-Smtp-Source: AMrXdXsEEkA/Hk4h+bKI2b+6ohFfmnxdxyLhgZVNraLrg8zBIS8U5vNBD9c95jtXqkX/bSR+jBXT3g==
X-Received: by 2002:a17:907:7e83:b0:7c0:f558:e518 with SMTP id qb3-20020a1709077e8300b007c0f558e518mr83747934ejc.51.1673596330697;
        Thu, 12 Jan 2023 23:52:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709062bcc00b007ae38d837c5sm8347522ejg.174.2023.01.12.23.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:52:10 -0800 (PST)
Message-ID: <df4fdecb-6ca7-d96b-bcad-02cefb52ce4e@linaro.org>
Date:   Fri, 13 Jan 2023 08:52:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113073045.4008853-1-tanmay.shah@amd.com>
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

On 13/01/2023 08:30, Tanmay Shah wrote:
> This patch introduces bindings for TCM memory address space on AMD-xilinx
> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
> driver. This bindings will help in defining TCM in device-tree and
> make it's access platform agnostic and data-driven from the driver.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  .../devicetree/bindings/sram/xlnx,tcm.yaml    | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
> new file mode 100644
> index 000000000000..02d17026fb1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/xlnx,tcm.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/xlnx,tcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tightly Coupled Memory (TCM)
> +
> +maintainers:
> +  - Tanmay Shah <tanmay.shah@amd.com>
> +
> +description: |
> +  Tightly Coupled Memory(TCM) is available on AMD-Xilinx paltforms for ARM
> +  cortex remote processors to use. It is low-latency memory that provide
> +  predictable instruction execution and predictable data load/store timing.
> +  TCM can be configured in lockstep mode or split mode. In split mode
> +  configuration each RPU core has its own set of ATCM and BTCM memories and in
> +  lockstep mode redundant processor's TCM become available to lockstep
> +  processor. So In lockstep mode ATCM and BTCM size is increased.
> +
> +properties:
> +  $nodename:
> +    pattern: "sram-[0-9a-f]+$"

Drop node name requirement.

Why do you need sram node at all?

> +
> +patternProperties:
> +  "^tcm-[a-z]+@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      During the split mode, each RPU core has its own set of ATCM and BTCM memory
> +
> +      During the lock-step operation, the TCMs that are associated with the
> +      redundant processor become available to the lock-step processor.
> +      For example if each individual processor has 64KB ATCM, then in lockstep mode
> +      The size of ATCM become 128KB. Same for BTCM. tcm-lockstep node represents
> +      TCM address space in lockstep mode. tcm-core@x node specfies each core's
> +      TCM address space in split mode.
> +
> +    properties:
> +      compatible:
> +        oneOf:

This is not oneOf.

> +          - items:

and you do not have more than one item.

> +              - enum:
> +                  - xlnx,tcm-lockstep
> +                  - xlnx,tcm-split

compatible describes hardware, not configuration. What you encode here
does not fit compatible.

> +
> +      "#address-cells":

Use consistent quotes, either " or '

> +        const: 1
> +
> +      "#size-cells":
> +        const: 1
> +
> +      reg:
> +        items:
> +          - description: |
> +              ATCM Memory address space. An ATCM typically holds interrupt or
> +              exception code that must be accessed at high speed, without any
> +              potential delay resulting from a cache miss.
> +              RPU on AMD-Xilinx platform can also fetch data from ATCM
> +          - description: |
> +              BTCM Memory address space. A BTCM typically holds a block of data
> +              for intensive processing, such as audio or video processing. RPU on
> +              AMD-Xilinx Platforms can also fetch Code (Instructions) from BTCM
> +
> +      reg-names:
> +        items:
> +          - const: atcm
> +          - const: btcm
> +
> +      ranges: true
> +
> +      power-domains:
> +        maxItems: 8
> +        items:
> +          - description: list of ATCM Power domains
> +          - description: list of BTCM Power domains
> +        additionalItems: true

And what are the rest?

> +
> +    required:
> +      - compatible
> +      - '#address-cells'
> +      - '#size-cells'
> +      - reg
> +      - ranges
> +      - power-domains
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +
> +    amba {

Drop.

> +        sram@ffe00000 {

This does not match your bindings.

> +            tcm-lockstep@ffe00000 {
> +                compatible = "xlnx,tcm-lockstep";
> +
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
> +                reg-names = "atcm", "btcm";
> +                ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
> +                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
> +                                <&zynqmp_firmware PD_R5_1_ATCM>,

This is BTCM domain according to your binding. Your binding here is
probably wrong and does not match real DTS.

> +                                <&zynqmp_firmware PD_R5_0_BTCM>,
> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
> +            };
> +
> +            tcm-core@0 {
> +                compatible = "xlnx,tcm-split";
> +
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
> +                reg-names = "atcm", "btcm";
> +                ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>;
> +                power-domains = <&zynqmp_firmware PD_R5_0_ATCM>,
> +                                <&zynqmp_firmware PD_R5_0_BTCM>;
> +            };
> +
> +            tcm-core@1 {
> +                compatible = "xlnx,tcm-split";
> +
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> +                reg-names = "atcm", "btcm";
> +                ranges = <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
> +                power-domains = <&zynqmp_firmware PD_R5_1_ATCM>,
> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
> +            };
> +        };
> +    };
> +...
> 
> base-commit: 6b31ffe9c8b9947d6d3552d6e10752fd96d0f80f

Best regards,
Krzysztof

