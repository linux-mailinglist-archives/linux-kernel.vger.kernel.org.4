Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB569C642
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjBTIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBTIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:04:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21846CC3E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:04:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h32so1388303eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88lumBnapMN7Ps8Hk/t0fPR3JUqopUiwWmOnEOlc2Ws=;
        b=iv2wsbD8ixRzECtunIA135V2n+ioaO7wEObmSzYZhRFZTPB0DtI+Pa5Y8yG5Zgc2Ul
         pReND9ioKG44Zifqoiu3zKe4IEPn2R27mkdfHdnyF1ZsAoTW0flND5qUAisZNKKMLKl2
         pBo0mQYsaG7QCLvxkYJ8TR+aaeABws3PD9ZW/Y5clAuLETFr5DrMWbyn5SNuc7zDVN4A
         rOobs03cbKom8XT4A0d3kgsbs+E6fEAAxclBogri63fXpwca5NqyA3+vThBT/77oSfpQ
         9BX8kikm6xHsLg36zzmGdWw4VKr4D+aMGAWkNg3d45QYVYXx1uTo4pL/JKj4hppItDTv
         pJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88lumBnapMN7Ps8Hk/t0fPR3JUqopUiwWmOnEOlc2Ws=;
        b=OkMlyTjhmObCg3B6z663hiICfQ6vpKoqNeXZcDA8N03JkqyLw583DpAt4rY1V87HAe
         prjBooMbTlRepXmXpCG5cVpmLAB2I58eKzKx+Hg0VvHuYya0k+k4AhJ1u/U6TA2KDrLP
         kIrqsYsc7uaAFf0LoV0m2jp9J4RTetkYtH2krpkjsQhnheYgpAw+TIkXU3k3VIowwCfb
         qwYunyEVhzNvwj/igwtpGHQFX/+Fm56GgmrdbcyjEohYj8ov34C9VebgIi149C9NW83J
         XD7etiTqnDotTlqqhTg28MDKzeLOyGDFd579O2L5T8uNA5PjxYg7tBtY2CuurY8dZWPx
         iSjA==
X-Gm-Message-State: AO0yUKU1vfY2SwvUaKBAgEqEQNYHNX8SET6IqNhrj01H9mz5fL8ZEUjl
        upbzB6C/boFvd4EBEBE+Nxa5hQ==
X-Google-Smtp-Source: AK7set9Hivfdi5qmCapoh8XxH5/JBmdwusVTUbOJ1qWsWjyJy8ITtqKPhFZuTlU28cbY75K6X/ZwKg==
X-Received: by 2002:a17:906:a87:b0:878:955e:b4a4 with SMTP id y7-20020a1709060a8700b00878955eb4a4mr8105935ejf.33.1676880249568;
        Mon, 20 Feb 2023 00:04:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090668c600b008874c903ec5sm5416739ejr.43.2023.02.20.00.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:04:09 -0800 (PST)
Message-ID: <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org>
Date:   Mon, 20 Feb 2023 09:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20230218122236.1919465-1-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230218122236.1919465-1-keguang.zhang@gmail.com>
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

On 18/02/2023 13:22, Keguang Zhang wrote:
> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../loongson,ls1x-intc.txt                    | 24 ---------
>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> deleted file mode 100644
> index a63ed9fcb535..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Loongson ls1x Interrupt Controller
> -
> -Required properties:
> -
> -- compatible : should be "loongson,ls1x-intc". Valid strings are:
> -
> -- reg : Specifies base physical address and size of the registers.
> -- interrupt-controller : Identifies the node as an interrupt controller
> -- #interrupt-cells : Specifies the number of cells needed to encode an
> -  interrupt source. The value shall be 2.
> -- interrupts : Specifies the CPU interrupt the controller is connected to.
> -
> -Example:
> -
> -intc: interrupt-controller@1fd01040 {
> -	compatible = "loongson,ls1x-intc";
> -	reg = <0x1fd01040 0x18>;
> -
> -	interrupt-controller;
> -	#interrupt-cells = <2>;
> -
> -	interrupt-parent = <&cpu_intc>;
> -	interrupts = <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> new file mode 100644
> index 000000000000..4cea3ee9fbb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 Interrupt Controller

You changed the title, so this binding now will cover all Loonson-1
interrupt controllers?

> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +description: |

Drop |

> +  Loongson-1 interrupt controller is connected to the MIPS core interrupt
> +  controller, which controls several groups of interrupts.
> +


Best regards,
Krzysztof

