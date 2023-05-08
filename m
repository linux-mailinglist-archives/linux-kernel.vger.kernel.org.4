Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B46FB22D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjEHOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEHOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:05:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030937C6D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:04:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so7069026a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683554696; x=1686146696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Od6I80xsaiKw2DxzK6V6K85PKWcqU0eGZ4Kv32a3GZw=;
        b=P4KW8mprrrhfQliam+5IFMGPnckRXnNnyuMGRRpwVbjTZMZFZx3S3zvSb5twopIUDh
         ex7Ahy9cpeY052PYhsk0P4Zmbil0TCMQWfqsjN48FPqwxPc8pn+Odv6PEZAnYf2Iqa3O
         cHZm3ucSVahUS+Yxs3dLEkdWvbtuurMhqE8vg8PIkrHeR1KiS4MPxTR42seNlo0jwzl3
         +ZcT1eEoMiX8uGDW8r6LTFLRFnsFPhPW/S5f5VNO6xiHOGxB5g6wBqBFs9XlAnWRRbOX
         ai51qUcZoZFSBUTB6y5LJJtxrq0sc1/BXX+tlCXPzjCYjn0xGPsxgfsenMBLCvULWlbz
         s0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554696; x=1686146696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od6I80xsaiKw2DxzK6V6K85PKWcqU0eGZ4Kv32a3GZw=;
        b=W8tKyRLUoRLacbig8ORuM8jbXlGkEP/dxY2NkiCjINC4JO2ZxbXclnVrrKjPKDYZDG
         Rg79j6ItvtvQo7MeAX/KLU7qy9uy1hwbH8FvNE1URx6SEnxAwlXb2B/urdZ+tSpD9o0X
         lUnpZNL8vOXOqfSxaNsGnsnqT2mkBe4rS+3stTnIxyuCz6fed31rCHVtx1mESoDgulan
         0ICv/1wX1qG22q4B4J1xl/rjEB8qQfG9PdwahNYaAYUMM/TSbdXzbUq8Q8dhOd1Arkek
         nhkXO3tzSbrZ/zWx24HneEi8XZPybOHMaar2MzWFIFKZL98TnKmA6T7XxjYUm5jr7dSQ
         EzSA==
X-Gm-Message-State: AC+VfDwSl4KJBCRtuH17B+fgcKqsG5kXf+SzCvAKuuJWcM4po8fIKVZu
        70lSCOi2gH9vYCI/+45uUEEWcw==
X-Google-Smtp-Source: ACHHUZ7BfzlxI0coJiSK2Pg+2b3iyjkcr6XIToVo7Gg59cfesHJL6Pt6ic2iy8AaXuzAWqMNOTkQrg==
X-Received: by 2002:a17:906:fe01:b0:951:756d:653c with SMTP id wy1-20020a170906fe0100b00951756d653cmr8310899ejb.39.1683554696342;
        Mon, 08 May 2023 07:04:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id mc27-20020a170906eb5b00b00966330021e9sm24906ejb.47.2023.05.08.07.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 07:04:55 -0700 (PDT)
Message-ID: <43945fad-f57b-cfd9-78bd-9ec9e6628382@linaro.org>
Date:   Mon, 8 May 2023 16:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefank@nvidia.com
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508122048.99953-5-pdeschrijver@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 14:20, Peter De Schrijver wrote:
> Add bindings for DRAM MRQ GSC support.
> 
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-
>  .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++

Why touching two files?

>  2 files changed, 106 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> index 833c07f1685c..d818cfe1d783 100644
> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
> @@ -57,8 +57,11 @@ description: |
>    "#address-cells" or "#size-cells" property.
>  
>    The shared memory area for the IPC TX and RX between CPU and BPMP are
> -  predefined and work on top of sysram, which is an SRAM inside the
> -  chip. See ".../sram/sram.yaml" for the bindings.
> +  predefined and work on top of either sysram, which is an SRAM inside the
> +  chip, or in normal SDRAM.
> +  See ".../sram/sram.yaml" for the bindings for the SRAM case.
> +  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings for
> +  the SDRAM case.
>  
>  properties:
>    compatible:
> @@ -81,6 +84,11 @@ properties:
>      minItems: 2
>      maxItems: 2
>  
> +  memory-region:
> +    description: phandle to reserved memory region used for IPC between
> +      CPU-NS and BPMP.
> +    maxItems: 1
> +
>    "#clock-cells":
>      const: 1
>  
> @@ -115,10 +123,16 @@ properties:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - oneOf:

Keep just oneOf and drop allOf.

> +      - required:
> +          - memory-region
> +      - required:
> +          - shmem
> +
>  required:
>    - compatible
>    - mboxes
> -  - shmem
>    - "#clock-cells"
>    - "#power-domain-cells"
>    - "#reset-cells"
> @@ -184,3 +198,52 @@ examples:
>              #thermal-sensor-cells = <1>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/mailbox/tegra186-hsp.h>
> +    #include <dt-bindings/memory/tegra186-mc.h>
> +
> +    hsp_top0: hsp@3c00000 {
> +        compatible = "nvidia,tegra186-hsp";
> +        reg = <0x03c00000 0xa0000>;
> +        interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "doorbell";
> +        #mbox-cells = <2>;

Why HSP example is here?

> +    };
> +
> +    reserved-memory {
> +        dram_cpu_bpmp_mail: shmem@f1be0000  {
> +            compatible = "nvidia,tegra264-bpmp-shmem";
> +            reg = <0x0 0xf1be0000 0x0 0x2000>;
> +            no-map;
> +        };
> +    };

Drop, fairly obvious and should be in that binding, not here.

> +
> +    bpmp {
> +        compatible = "nvidia,tegra186-bpmp";
> +        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
> +        interconnect-names = "read", "write", "dma-mem", "dma-write";
> +        iommus = <&smmu TEGRA186_SID_BPMP>;
> +        mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
> +                            TEGRA_HSP_DB_MASTER_BPMP>;
> +        memory-region = <&dram_cpu_bpmp_mail>;
> +        #clock-cells = <1>;
> +        #power-domain-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        i2c {
> +            compatible = "nvidia,tegra186-bpmp-i2c";
> +            nvidia,bpmp-bus-id = <5>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +
> +        thermal {
> +            compatible = "nvidia,tegra186-bpmp-thermal";
> +            #thermal-sensor-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
> new file mode 100644
> index 000000000000..6cd9a61cd31f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra CPU-NS - BPMP IPC reserved memory binding

Drop "binding"

> +
> +maintainers:
> + - Peter De Schrijver <pdeschrijver@nvidia.com>
> +
> +description: |
> +  Define a memory region used for communication between CPU-NS and BPMP.
> +  Typically this node is created by the bootloader as the physical address
> +  has to be known to both CPU-NS and BPMP for correct IPC operation.
> +  The memory region is defined using a child node under /reserved-memory.
> +  The sub-node is named shmem@<address>.
> +

Open other files there and implement it similar way. I really wonder why
this should be done differently than for example other nvidia stuff -
without reserved-memory schema?

> +properties:
> +  compatible:
> +    const: nvidia,tegra264-bpmp-shmem
> +
> +  reg:
> +    description: The physical address and size of the shared SDRAM region
> +
> +required:
> +  - compatible
> +  - reg
> +  - no-map
> +

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +examples:
> +  - |
> +    reserved-memory {
> +       dram_cpu_bpmp_mail: shmem@f1be0000  {
> +           compatible = "nvidia,tegra264-bpmp-shmem";
> +           reg = <0x0 0xf1be0000 0x0 0x2000>;
> +           no-map;
> +       };
> +    };
> +...

Best regards,
Krzysztof

