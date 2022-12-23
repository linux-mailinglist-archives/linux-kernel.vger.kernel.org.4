Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDF654F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiLWKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiLWKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:25:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396720347
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:25:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p36so6528116lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qp7d3U94zoNgKH8Si35nk2bX1fIT5hDmVOTvD+2+xiI=;
        b=a3ULL3KPekXKim5IREGJDUsn1quNjynauNOaAghWct3ih2A4vxASjkyY6wPjt04RtX
         Q3AjFmIl7yo0PQ8hzApg7fj9xmTj1z635ssGsJ47EZawHIfne8i146+urbheMecDQH5S
         SvUd335pD022tMegpq9jS8Ej5SA3af3lsSaQJpkNZLHZpQ2d4NQIPEdGZPXDPDyXIcUD
         7mkhis/VlcF2dZ3yM8aA14gu0DsfD9/QgT6JQUIDVMZNnhWxycAne2BGhieDPq/eVK/y
         r52AGEFWG8n+iS8dFQHahkDolvqcA90Izkog4mRVps/eGTZB3A2U/cyfhRPBhcjbDimv
         BwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp7d3U94zoNgKH8Si35nk2bX1fIT5hDmVOTvD+2+xiI=;
        b=tap2/efAOmIYx0KjENxNcnlac9Pyjjz3XB89wuBXaYKoEcZ8M/fzsuoMShX/0uO1x/
         UT9R2Ag5TZWY8rssKlWAS8dKrjQ7mWUTA3DHybGhBO2TNgrzdOBboDXH3USCY6vVWh31
         rVhRCaM5ttMxxKatn7ufNPs5JvAf+pxBYfkia5qLAK7YuoX1T/95nT0jarILc0KrgZI0
         F8r3mLa6wLHAuac5IBlPJcwCWu1l9iRN8iZK9B27+gzKFwvj+D2Uec5l/Tyw3bVwOaM4
         QZ9xGccIrW8nIcdwAcJTAFFf7Gjii3vqVKPAt3TAQtyoKxa70LAaO2LUFFp+RzEkYZah
         YI2g==
X-Gm-Message-State: AFqh2kravXHNbgh+eOL8X/SrCsiB9cf7x/oCH9Mnk9x799VdmbBxyXVq
        ynTevHhxXfit0TMJORntGumZaw==
X-Google-Smtp-Source: AMrXdXtmvRecxvsCwLnWMZT22Fb49dhaElQD52LdPUWmeeJ8sDPLBSeNLZ4a44nht9Y4xxtkSEfCvw==
X-Received: by 2002:ac2:5589:0:b0:4b5:5c9b:18c with SMTP id v9-20020ac25589000000b004b55c9b018cmr2361943lfg.34.1671791112607;
        Fri, 23 Dec 2022 02:25:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512358e00b004a4754c5db5sm471219lfr.244.2022.12.23.02.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:25:12 -0800 (PST)
Message-ID: <179e66a8-c6c0-6d3e-4f4a-6b884f532572@linaro.org>
Date:   Fri, 23 Dec 2022 11:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/3] dt-bindings: timer: Add timer for StarFive JH7110
 SoC
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
 <20221223094801.181315-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223094801.181315-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 10:47, Xingyu Wu wrote:
> Add bindings for the timer on the JH7110
> RISC-V SoC by StarFive Technology Ltd.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../timer/starfive,jh7110-timers.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
> new file mode 100644
> index 000000000000..fe58dc056313
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/starfive,jh7110-timers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Timers


Not enough, really not enough. Describe the hardware.

> +
> +maintainers:
> +  - Samin Guo <samin.guo@starfivetech.com>
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-timers

Why plural "timers", not "timer"? The module is usually called timer -
see other hardware that type.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: timer channel 0 interrupt
> +      - description: timer channel 1 interrupt
> +      - description: timer channel 2 interrupt
> +      - description: timer channel 3 interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: timer0
> +      - const: timer1
> +      - const: timer2
> +      - const: timer3

I would just drop the names, not really useful. Unless you plan to add
here some generic interrupt (like you did for clock-names)?

> +
> +  clocks:
> +    items:
> +      - description: timer channel 0 clock
> +      - description: timer channel 1 clock
> +      - description: timer channel 2 clock
> +      - description: timer channel 3 clock
> +      - description: APB clock
> +
> +  clock-names:
> +    items:
> +      - const: timer0
> +      - const: timer1
> +      - const: timer2
> +      - const: timer3
> +      - const: apb
> +
> +  resets:
> +    items:
> +      - description: timer channel 0 reset
> +      - description: timer channel 1 reset
> +      - description: timer channel 2 reset
> +      - description: timer channel 3 reset
> +      - description: APB reset
> +
> +  reset-names:
> +    items:
> +      - const: timer0
> +      - const: timer1
> +      - const: timer2
> +      - const: timer3
> +      - const: apb
> +
> +  clock-frequency:
> +    description: The frequency of the clock that drives the counter, in Hz.

Why do you need it? Use common clk framework to get that frequency.

Also, sort the nodes somehow, e.g.
compatible/reg/clocks/clock-frequency/interrupts/resets.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - clock-frequency
> +
> +unevaluatedProperties: false

Did you test the binding?


Best regards,
Krzysztof

