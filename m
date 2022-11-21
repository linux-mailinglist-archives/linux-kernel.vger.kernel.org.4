Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5906E631E18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKUKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiKUKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:19:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDF27CE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:19:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p8so18077828lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQFiTXKsbrPoyRwi6lLbPzZv5BmjQmydSUj+NPTsrV0=;
        b=xX0cDnzBkKbABaHljYhDPgdYLby3aZc3/kIlcu8Xq5CPnPPajyZEHJqnb4fDymLa5Q
         HoZWECNzSlti0j3E/vmV74/CtPWW3nlMV8quBFQ1gMGY3/q9Ilgf4v6P3g+o8OLhdTjp
         haddN5VCqqpVNrn10yXAOTHO/VjkXeOhPASl65NscKT6PJ+YNgIGY116jVaa4NoUXuri
         wYtidbKpG+WUstzcjva5FPSi2CTb6ldu1JBYYD+Y9+a2tRm+DYj+QVNCxJd6DvxdvPTD
         k9VE3c/XWSZWZVNOe+WW+K/qIy8Ssd0IJaCZqDFgoQvjkiLVnxNuT80r8VmOvqxIsU0j
         8cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQFiTXKsbrPoyRwi6lLbPzZv5BmjQmydSUj+NPTsrV0=;
        b=v4iEMQJQv3fcfOg8NjZxt31gQMJQevsGl5LGEbtAEajUZ4SMuMh9Dtg4Yd/lXehLw8
         U7BPfpNT9fJTimKJ5IBuOiiEW1HAE8c+P+Ovwng63rRuGnyehljEVXAwknAMESVNXrpU
         i6FcucgQEcSorpesYMSLm6TfCuo4UeXxWX6vKB/dAEg8UdCDXCS/eblMhRfKq/uoZvTR
         S7OpQecgtcO8XGeC4AxpOhCNXORmwUX/tpNNMd7HMk74daYuDAtCqDSLi+wt2QGGgq4d
         Il+kWUfENSulWFXgm0mg+O0C0qYdSwScMiKaZLIqSZtr8X2Tlvh2c/T+UlVxt1rNkAgN
         gjRQ==
X-Gm-Message-State: ANoB5pnfESyYr1pJnymS6BcxB7SzRaANZNY7/0i2IHxmIBewiObYBo0Z
        Q7xkYwCDdEd7HEdhp+fOIxvlKA==
X-Google-Smtp-Source: AA0mqf4xDVTzYMg5nYnajryHXTp+sUINRNseKDzeRpO7t5jphdWM+k1SxWFqZVEvEU97E6csCvKFOg==
X-Received: by 2002:a19:2d5d:0:b0:4af:ad36:7a91 with SMTP id t29-20020a192d5d000000b004afad367a91mr5985026lft.596.1669025974124;
        Mon, 21 Nov 2022 02:19:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m12-20020ac24acc000000b004a240eb0217sm1980833lfp.251.2022.11.21.02.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:19:33 -0800 (PST)
Message-ID: <0dc15e61-62a3-fa23-1fa9-09179d90874b@linaro.org>
Date:   Mon, 21 Nov 2022 11:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: timer: add a binding for LiteX Timer
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221121042545.421532-1-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121042545.421532-1-uwu@icenowy.me>
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

On 21/11/2022 05:25, Icenowy Zheng wrote:
> The LiteX SoC generator has a timer core, which by default only
> generates a simple down counter.

Subject: drop second, redundant "bindings".

> 
> Add a DT binding for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../bindings/timer/litex,timer.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/litex,timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/litex,timer.yaml b/Documentation/devicetree/bindings/timer/litex,timer.yaml
> new file mode 100644
> index 000000000000..bece07586c6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/litex,timer.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/litex,timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LiteX Timer
> +
> +maintainers:
> +  - Icenowy Zheng <uwu@icenowy.me>
> +
> +description: |
> +  The LiteX Timer is a count-down timer that is defaultly embedded
> +  into all LiteX SoCs, unless explicitly disabled. It's fed directly
> +  by the system clock like other LiteX peripherals.
> +
> +properties:
> +  compatible:
> +    const: litex,timer

No model name/number? If it is part of Soc, then a SoC specific number
is expected usually.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  litex,width:
> +    description:
> +      The width of the timer's value, specified as the width argument
> +      when creating an instance of litex.soc.cores.Timer.

This lacks type ($ref) and units in description, but more important -
why this is not part of compatible? Is it a width of register(s)?

And what is "instance of litex.soc.cores.Timer"? Is it configurable,
soft-core?

BTW, there is reg-io-width property.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - litex,width
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +     timer@a0006000 {

Use 4 spaces for example indentation.

> +        compatible = "litex,timer";
> +        reg = <0xa0006000 0x20>;
> +        clocks = <&sys_clk>;
> +        interrupts = <17>;
> +        litex,width = <32>;
> +     };

Best regards,
Krzysztof

