Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BBD62183C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKHP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiKHP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:28:24 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80F2CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:28:22 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z24so21638040ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYyQ/3KwA5SEi7xobmtMHnwgbg0DrEr9YUI+FxITXks=;
        b=oudhA7iWo073iyyJQt8Okd+b8G1K6VItNkGt4/f1tP4fNyw46cvITxgr/evZp9ORvq
         rkKqlTFcDHk+3t7el5VIFhrrAQngAPgr6QOO+cfQayIr194tPIilrMUubBSC9iSNv2N4
         gaptbtSKej2YQ0XMaua2sSnq2tBBTPd+6XX9IJoVzAU8xWAzvjeKyZccNt9GKW6RNjmF
         BfKHbhmOe5/2s67vZQyjBLFMoJ/A8AWZnLZ53XhvDY+3kWHsxDxQ8aoRlTd1TincoTZP
         c36QC8Cuzfa3bxTExcAgxbvK3Wu6BxjKMvIwuVPxDs5fcl8yslN13jt8lb0JUOP7udjN
         8Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYyQ/3KwA5SEi7xobmtMHnwgbg0DrEr9YUI+FxITXks=;
        b=Ls7juBEuGFw+4w9SMJck0FFQmS9hiUQw+oCjxqv7IMbyJghV1uhFKxzRMmmHWgDshJ
         28mzNNvufXsk7L271018uNcka2UUzB+wC5yGkyaFDpPiALWwcLgGZqzzybmDpxTsUguR
         Zfk7oJWoS1w6G7iDgXRGZwW9xaj55XgP/x6apPxc7O3fBhLFkrlf7VK0xPf1JPnZciwN
         NFvmWgKlh6k1OeJxIMtFS/r7RZq8TL4OuUEVkfmA1OZ5gB8dxbJIvV37ySUYJoCagU85
         CQtIwgcLvJpqa+gquelQTceyJL+Uy5HWFDjenYQX6LxU8nEsZdxqzHzvJKKHslWt0XNZ
         jFDQ==
X-Gm-Message-State: ACrzQf3JfrETn316SMeMe5+ite3C7RgPeiH9l3o1C68MVOS7wyNvdqp8
        6tAPyQK+fySeeq3AubUn1eOfmg==
X-Google-Smtp-Source: AMsMyM7azffc3j7n0RlXzVVXhr4h6KU9GBtHDPvSR1EQLGZAnoaDtp1H2k8dV1j18dnuFx2eTd4lcw==
X-Received: by 2002:a05:651c:88a:b0:26c:81e1:57dc with SMTP id d10-20020a05651c088a00b0026c81e157dcmr21276405ljq.236.1667921300408;
        Tue, 08 Nov 2022 07:28:20 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s2-20020a05651c048200b0026fc79fd67dsm1777329ljc.74.2022.11.08.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:28:19 -0800 (PST)
Message-ID: <d9edb6e1-c3da-0f5b-546d-37d8151aaa35@linaro.org>
Date:   Tue, 8 Nov 2022 16:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/2] dt-bindings: gpio: add loongson series gpio
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        richard.liu@st.com, Arnaud Patard <apatard@mandriva.com>,
        Hongbing Hu <huhb@lemote.com>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20221108092107.28996-1-zhuyinbo@loongson.cn>
 <20221108092107.28996-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108092107.28996-2-zhuyinbo@loongson.cn>
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

On 08/11/2022 10:21, Yinbo Zhu wrote:
> Add the Loongson series gpio binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/gpio/loongson,ls-gpio.yaml       | 154 ++++++++++++++++++
>  MAINTAINERS                                   |  11 ++
>  2 files changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> new file mode 100644
> index 000000000000..9d335262ddcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/loongson,ls-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson series GPIO controller.
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-gpio
> +      - loongson,ls7a-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  ngpios: true

minimum? maximum?

> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpio-ranges: true
> +
> +  loongson,conf_offset:

No underscores in node names. Plus comments from Linus seem to apply
here as well. Drop it entirely or explain why this is not part of
compatible, why this is needed and why encoding programming model
address in DT matches the DT...


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO configuration offset address.
> +
> +  loongson,out_offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO output value offset address.

Drop

> +
> +  loongson,in_offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO input value offset address.

Drop


> +
> +  loongson,gpio_base:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate the first GPIO number in this node.

Drop


> +
> +  loongson,support_irq:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      This option indicate this GPIO whether support interrupt.

Drop

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - ngpios
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - gpio-ranges
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gpio0: gpio@1fe00500 {
> +      compatible = "loongson,ls2k-gpio";
> +      reg = <0x1fe00500 0x38>;
> +      ngpios = <64>;
> +      #gpio-cells = <2>;
> +      gpio-controller;
> +      gpio-ranges = <&pctrl 0 0 15>,
> +                    <&pctrl 16 16 15>,
> +                    <&pctrl 32 32 10>,
> +                    <&pctrl 44 44 20>;
> +      loongson,conf_offset = <0>;
> +      loongson,out_offset = <0x10>;
> +      loongson,in_offset = <0x20>;
> +      loongson,gpio_base = <0>;
> +      loongson,support_irq;
> +      interrupt-parent = <&liointc1>;
> +      interrupts = <28 IRQ_TYPE_LEVEL_LOW>,
> +                   <29 IRQ_TYPE_LEVEL_LOW>,
> +                   <30 IRQ_TYPE_LEVEL_LOW>,
> +                   <30 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <26 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <>,

What's this?

> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <>,
> +                   <>,

What's this?

> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>,
> +                   <27 IRQ_TYPE_LEVEL_LOW>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 916b2d9cffc0..878b8320ac3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12048,6 +12048,17 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>  F:	drivers/soc/loongson/loongson2_guts.c
>  
> +LOONGSON SERIES GPIO DRIVER
> +M:	Richard Liu, STMicroelectronics <richard.liu@st.com>
> +M:	Arnaud Patard <apatard@mandriva.com>
> +M:	Hongbing Hu <huhb@lemote.com>
> +M:	Huacai Chen <chenhuacai@kernel.org>
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>

Are they all maintainers of this driver?

> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +F:	drivers/gpio/gpio-loongson.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>

Best regards,
Krzysztof

