Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FF6A9226
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCCIGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCCIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:06:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5955523
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:06:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so7085359edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677830787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdJcfcyXGWtXoLMcnxOxEylM1d1K2JuAwfWfX2Z+dfI=;
        b=aDkxPUvGNZ2oKuQ1gSddr+5WFzfVA/+eAkdBSR6e4ep84Q7aEyXK0qddNYb42QI6Jb
         OBHIBLyCOs1uFiGQ2mH5G7ks+KkrzBnfjjMys5ayUPGX3Wn6n36oywFrBLEXK0BYAoUI
         /gI/fH6MUeutl39jyF8IVRcgvN93+CzQu6mySuRhYK7iaSHQJsyYccHlForU9VYgkIH8
         w9eGwLgnbOGEsZeiv2xX4Cq5nqVI75Tb989kvOG0dPjhhadB3Vlxjd0Y356RLyLreFXo
         RPtZh+ilGJT1H6UkpVn6OjVhCk5MMF66cU/IcxnopjW2eldryIpgwU/sXGoB+fkaU1eS
         b7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677830787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdJcfcyXGWtXoLMcnxOxEylM1d1K2JuAwfWfX2Z+dfI=;
        b=tYLWLzfEf2T8KEMoReRbQRNCDvZRedtXQ/Rn6JvVDALIqusDPjBiqma+nYkEeujeRG
         /A1/dWsFxtvmDv5xAHqgDfDFyewj2dKs3moNziBJGRHP3sKBwFeLdB0HvR8MyBDAAy9e
         1adOjhmAgo6KseDjReelkQOyrklH9FJwl5jSLdwQVq1a0XU9QPdboqz3GaymjCiaOf0b
         Ab9+zTjPVton7u9xWxtLHzL09d9qCSYA9n5LHg3laXODQjpxnEfI0rXRHa1eUdqpr4Vm
         oa955VOuWDqkyG697FU8OxMOQ2aqsyxysvUTpcPLQ/N8uYGPi/BX+PrOpk2ka25TWw2c
         YfSg==
X-Gm-Message-State: AO0yUKW4TaFySvW/3i/3qTwGFKWnaMQJh5d8V2jdTelBQvwQAwsjlrgr
        6haizF8ETVLOTvLfKBwOAWjDhiQDx/dMAt/q
X-Google-Smtp-Source: AK7set9sgWEXima5pGSbzL+6LPs/nnZ9r6/bqSMGWbMISKvmqrPcBaoumBJ9HU2dN5qPXd4dl3hWbg==
X-Received: by 2002:a17:907:6089:b0:8b1:3554:25 with SMTP id ht9-20020a170907608900b008b135540025mr869239ejc.61.1677830786805;
        Fri, 03 Mar 2023 00:06:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n26-20020a50c21a000000b004a27046b7a7sm839952edf.73.2023.03.03.00.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:06:26 -0800 (PST)
Message-ID: <5c9130de-5092-9446-6e00-d86de7dcd6b4@linaro.org>
Date:   Fri, 3 Mar 2023 09:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings for
 K3 AM64x SoCs
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>
Cc:     kernel@collabora.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-2-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302171450.1598576-2-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 18:14, Martyn Welch wrote:
> From: Hari Nagalla <hnagalla@ti.com>

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [Martyn Welch: Amended as per review comments and to pass DT tests]
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Note: The only review comment that I don't see directly addressed is the
>       lack of description of `ti,sci`, `ti,sci-dev-id` and
>       `ti,sci-proc-ids`. A reference has been added to
>       `/schemas/arm/keystone/ti,k3-sci-common.yaml#` where they are
>       described. I believe this is the correct approach, please advise if
>       that is not the case.
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> new file mode 100644
> index 000000000000..1b38df0be2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 M4F processor subsystems
> +
> +maintainers:
> +  - Hari Nagalla <hnagalla@ti.com>
> +
> +description: |
> +  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
> +  family with a M4F core. Typically safety oriented applications may use
> +  the M4F core in isolation without an IPC. Where as some industrial and
> +  home automation applications, may use the M4F core as a remote processor
> +  with IPC communications.
> +
> +$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^m4fss(@.*)?"

Drop. It's not a generic name. Also we do not enforce names in device
schemas.

> +
> +  compatible:
> +    enum:
> +      - ti,am64-m4fss
> +
> +  power-domains:
> +    description: |
> +      Should contain a phandle to a PM domain provider node and an args
> +      specifier containing the M4FSS device id value.

Drop description, especially that the args depend on provider, not consumer.

> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Address and Size of the IRAM internal memory region

Just "IRAM internal memory region"

> +      - description: Address and Size of the DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: iram
> +      - const: dram
> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node managing the
> +      local resets for this device, and a reset specifier.

Drop description.


> +    maxItems: 1
> +
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path

This description is basically duplicating the name... say something
useful or shorten it (e.g. "Should contain" is really redundant). You
also need $ref because we do not have the type defined anywhere.

> +
> +  mboxes:
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for

OMAP?

> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image.
> +    maxItems: 1
> +
> +  memory-region:
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the
> +      remoteproc device. There should be at least two reserved memory nodes
> +      defined. 

Don't repeat constraints in free form text.

> The reserved memory nodes should be carveout nodes, and
> +      should be defined with a "no-map" property as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +    minItems: 2
> +    maxItems: 8
> +    items:
> +      - description: region used for dynamic DMA allocations like vrings and
> +                     vring buffers
> +      - description: region reserved for firmware image sections
> +    additionalItems: true

And what is the purpose of the rest of reserved nodes?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids
> +  - resets
> +  - firmware-name
> +  - mboxes
> +  - memory-region
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cb00000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +            no-map;
> +        };
> +    };
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mailbox0_cluster0: mailbox-0 {
> +            #mbox-cells = <1>;
> +
> +            mbox_m4_0: mbox-m4-0 {
> +                ti,mbox-rx = <0 0 0>;
> +                ti,mbox-tx = <1 0 0>;
> +            };
> +        };

Does not look related to this binding... or is it somehow very specific
and needs showing?

> +
> +        bus@f0000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;

Why another bus? You already have soc in example, why more nodes?

> +
> +            bus@4000000 {

And one more bus?

> +                compatible = "simple-bus";
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
> +
> +                mcu_m4fss: m4fss@5000000 {

Generic node name. Qualcomm uses remoteproc.

> +                    compatible = "ti,am64-m4fss";
> +                    reg = <0x00 0x5000000 0x00 0x30000>,
> +                          <0x00 0x5040000 0x00 0x10000>;
> +                    reg-names = "iram", "dram";
> +                    ti,sci = <&dmsc>;
> +                    ti,sci-dev-id = <9>;
> +                    ti,sci-proc-ids = <0x18 0xff>;
> +                    resets = <&k3_reset 9 1>;
> +                    firmware-name = "am62-mcu-m4f0_0-fw";
> +                    mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> +                    memory-region = <&mcu_m4fss_dma_memory_region>,
> +                                    <&mcu_m4fss_memory_region>;
> +                };
> +            };
> +        };
> +    };

Best regards,
Krzysztof

