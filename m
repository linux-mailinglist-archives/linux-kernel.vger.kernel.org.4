Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FF62798C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiKNJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiKNJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:51:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7B1EC6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:48 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d20so12387054ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DT7Lqj5itHPkRsi+26ax9bJ9oaClt2yyUwZVkdk8a+4=;
        b=rkmer+mc57x3Fd3FqVO0WATgmXDiXwPeIlaRDjJQ0OCnzV3u5OmWJw/DBKO3LzuyuB
         dSXHkxMnA9yPkSRiOn9RfSAWnZxOYgiuu+spiyqVnS115DZz4d2Ub1l2pmRJI3tQndsn
         8Y+YvXBeOsiWeHFI/yWuJ2vu3Ki0BiRnxvMjufznRHyz6sYlGYLP0xFaGxqHU0EYri62
         EoIOETOzAXWkGlSt/eAw2v8xglrMtUUKF98qhpyWmhLZDEINfqxsgrDXoWsjtQhoVd14
         eU8Af/IbQ46rHG/OUaED1O9AdJPoX+jkg4ZnFLuig0E4qN0CAQ496arCJlsUTEsh8LrZ
         Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DT7Lqj5itHPkRsi+26ax9bJ9oaClt2yyUwZVkdk8a+4=;
        b=N1KMQ18PoN//7eTul3RMz5lDbhtSRdBNwJuKSOBuKKVZJqOTRQ7PAGhKCI9LwmI3XM
         3qwDBURfa7OShMrsqo31VY2IPzPXd7KAKg4Ad2JK/B3FaeWdlDdt2PjTDS8/EFNIsa/m
         KzUTXoi8ic1+kOOMZzXIqZeDvZqVz9f8zgd7n8OqsOGIxaSoub0IuwN5nnO2xbzr+EWc
         DpDz4oZU/pxjE9bmYCyeLw4JLxWoiaumGfj48fFcmyEajAJpBe01pqESz5IPesNsjHKa
         rf0Q9joaI/A11ca2BW4dFD8Oz7JQGtXeP9gSbhlMwUBvoSl832WRsbVRtg2g6zBH+BiL
         G8Cg==
X-Gm-Message-State: ANoB5pnDUyeTnuTwtHeOxk+2iDl7wjaf+3BYAF9R+qtjj/+XrG2UmNUv
        gEt7JdOAFVRKRIEyHvqcRT7yJA==
X-Google-Smtp-Source: AA0mqf7dzDqUeVCvtLWO7fBd1nQJvIEpv9wABDCV5cLCP95ikI/GSEWJu/NmFg/E68D5VS4GkjLNRg==
X-Received: by 2002:a2e:b706:0:b0:277:d75:f1de with SMTP id j6-20020a2eb706000000b002770d75f1demr4173250ljo.272.1668419506902;
        Mon, 14 Nov 2022 01:51:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f2-20020a056512360200b004ae24559388sm1754456lfs.111.2022.11.14.01.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:51:46 -0800 (PST)
Message-ID: <6da76cb0-428e-d35a-3b11-81c7efa22460@linaro.org>
Date:   Mon, 14 Nov 2022 10:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111044207.1478350-7-apatel@ventanamicro.com>
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

On 11/11/2022 05:42, Anup Patel wrote:
> We add DT bindings document for RISC-V advanced platform level interrupt
> controller (APLIC) defined by the RISC-V advanced interrupt architecture
> (AIA) specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,aplic.yaml     | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> new file mode 100644
> index 000000000000..0aa48571f3bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Advancded Platform Level Interrupt Controller (APLIC)
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description:
> +  The RISC-V advanced interrupt architecture (AIA) defines advanced platform
> +  level interrupt controller (APLIC) for handling wired interrupts in a
> +  RISC-V platform. The RISC-V AIA specification can be found at
> +  https://github.com/riscv/riscv-aia.
> +
> +  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
> +  interrupt sources connect to the root domain which can further delegate
> +  interrupts to child domains. We have one device tree node for each APLIC
> +  domain.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - vendor,chip-aplic
> +      - const: riscv,aplic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 16384
> +    description:
> +      The presence of this property implies that given APLIC domain directly
> +      injects external interrupts to a set of RISC-V HARTS (or CPUs). Each
> +      node pointed to should be a riscv,cpu-intc node, which has a riscv node
> +      (i.e. RISC-V HART) as parent.
> +
> +  msi-parent:
> +    description:
> +      The presence of this property implies that given APLIC domain forwards

Drop "The presence of this property" and make it a proper sentence
describing hardware.

> +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> +      controller (IMSIC). This property should be considered only when the
> +      interrupts-extended property is absent.
> +
> +  riscv,num-sources:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    minimum: 1
> +    maximum: 1023
> +    description:
> +      Specifies how many wired interrupts are supported by this APLIC domain.
> +
> +  riscv,children:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    minItems: 1
> +    maxItems: 1024
> +    description:
> +      This property represents a list of child APLIC domains for the given
> +      APLIC domain. Each child APLIC domain is assigned child index in
> +      increasing order with the first child APLIC domain assigned child
> +      index 0. The APLIC domain child index is used by firmware to delegate
> +      interrupts from the given APLIC domain to a particular child APLIC
> +      domain.
> +
> +  riscv,delegate:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    minItems: 1
> +    maxItems: 1024
> +    description:
> +      This property represents a interrupt delegation list where each entry

Drop "This property represents".

> +      is a triple consisting of child APLIC domain phandle, first interrupt
> +      number, and last interrupt number. The firmware will configure interrupt
> +      delegation registers based on interrupt delegation list.
> +
> +additionalProperties: false

Same comments as in previous patch,

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - riscv,num-sources
> +
> +examples:
> +  - |
> +    // Example 1 (APIC domain directly injecting interrupt to HARTs):
> +
> +    aplic0: interrupt-controller@c000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 11>,
> +                            <&cpu2_intc 11>,
> +                            <&cpu3_intc 11>,
> +                            <&cpu4_intc 11>;
> +      reg = <0xc000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +      riscv,children = <&aplic1>;
> +      riscv,delegate = <&aplic1 1 63>;
> +    };
> +
> +    aplic1: interrupt-controller@d000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      interrupts-extended = <&cpu1_intc 9>,
> +                            <&cpu2_intc 9>,
> +                            <&cpu3_intc 9>,
> +                            <&cpu4_intc 9>;
> +      reg = <0xd000000 0x4080>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;
> +    };
> +
> +  - |
> +    // Example 2 (APIC domain forwarding interrupts as MSIs):
> +
> +    interrupt-controller@d000000 {
> +      compatible = "vendor,chip-aplic", "riscv,aplic";
> +      msi-parent = <&imsics>;
> +      reg = <0xd000000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      riscv,num-sources = <63>;

It's almost the same as previous... don't add unnecessary examples
(difference in one property usually does not mean you need new example).

> +    };
> +...

Best regards,
Krzysztof

