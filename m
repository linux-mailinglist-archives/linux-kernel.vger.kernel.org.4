Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D4640505
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiLBKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLBKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:47:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B02316F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:47:03 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so6802051lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Vtg1LtCfjtyNCzyBNU5YXITjkmZBt3+mmKj+CQPVVc=;
        b=UD3RDKAs3ew754ylVfIQCZ/no50brGFS4qCHmlg5qAuU5YJ45sQ9/DYEWipoJDUrsd
         8oFBWNEhCsEvrcJOao509FHXeaRMLuWw5NWqR7TIY246o9UH4Q2SKQ+sK0hZYuZaFyYg
         XvTC2EHgY2NCB2+3Ovm5X+nF5pVBG69Cae63PobFnrLZBz7j6cHixXmFnhP55uLTiRt8
         UuXSCxnod/z2W+YT9S2M3LIpLk5jf3SaHjURYTzrpfJOZeGKFI+dpxFgbu26BKq+ODhK
         sYpsQU5mmVscmZ1pcPNSa+B8auqVN0HyyNBTosair3SGOq8wt47vDWbvAeDDdRb5zgSm
         BYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Vtg1LtCfjtyNCzyBNU5YXITjkmZBt3+mmKj+CQPVVc=;
        b=0EFreNroDHQA9/gDpoB2lbSr+7PouGg5IwiYnAcTM5R8Jg8SCv7VM6hmUqTpdauOEQ
         1hqdPXhqniX/O9VA8Bn120+rNZ5Uiax72W+vVJsH9VcAGzIqdnnYl3BxQnfXueBtOY19
         IPrAzr8jpMjOf4N5uOaX+GHqcn+0Z9F0a9DgeeVZ6R+SyUkLcR0B25dPPtACx1bhlPnl
         TB9m5am8ELN+MNjuDqxnl14KG/B9Q+3C3nJADIhPBa8gRDN0xW9QyfO5kA5jEbfZQnss
         5aoh0N8HjzAi6QDfHaiDXIZEkeWUIoAUBUVIv2qr2H6731baX7B2ZPpdJzsCb4jl5Sir
         dE2Q==
X-Gm-Message-State: ANoB5pm2mxArFJfcTDkyRoqaWZaCalmb3yMqx9zcD4qsEF5OnbN3euh6
        ZSoceY1cU5vxvlwTBWA+EWCTs71SN8xhMxM8TOc=
X-Google-Smtp-Source: AA0mqf6gr/P7/w7zGPP1KlPQazaqNcuOmcl9Iu9U5TcIblGgOCA0ThAsves7sYSTqYRGj0mj2QSL+A==
X-Received: by 2002:ac2:4c27:0:b0:4a2:4df9:4cab with SMTP id u7-20020ac24c27000000b004a24df94cabmr24215355lfq.56.1669978021914;
        Fri, 02 Dec 2022 02:47:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05651c23a500b002770eafaafbsm596033ljb.99.2022.12.02.02.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:47:01 -0800 (PST)
Message-ID: <cb8deb55-902a-0058-4764-a5f391f8de6d@linaro.org>
Date:   Fri, 2 Dec 2022 11:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/3] dt-bindings: watchdog: Add watchdog for StarFive
Content-Language: en-US
To:     "xingu.wu" <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
 <20221202093943.149674-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202093943.149674-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 10:39, xingu.wu wrote:
> From: Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> Add bindings to describe the watchdog for the StarFive SoCs.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/watchdog/starfive,wdt.yaml       | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
> new file mode 100644
> index 000000000000..ece3e80153a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml

Filename should be based on compatible. You do not allow here any other
models... If you intent and you are 100% sure you will grow with new
models, make it maybe a family-based name.


> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/starfive,wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

Drop quotes.

> +
> +maintainers:
> +  - Samin Guo <samin.guo@starfivetech.com>
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: APB clock
> +
> +  clock-names:
> +    items:
> +      - const: core_clk

Drop _clk

> +      - const: apb_clk

Drop _clk

> +
> +  resets:
> +    items:
> +      - description: APB reset
> +      - description: Core reset
> +
> +  reset-names:
> +    items:
> +      - const: rst_apb

Drop rst_

> +      - const: rst_core

Ditto

> +
> +  timeout-sec: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - timeout-sec
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +
> +    watchdog@13070000 {
> +            compatible = "starfive,jh7110-wdt";

Use 4 spaces for example indentation.

> +            reg = <0x13070000 0x10000>;
> +            interrupts = <68>;
> +            clocks = <&syscrg_clk JH7110_SYSCLK_WDT_CORE>,
> +                     <&syscrg_clk JH7110_SYSCLK_WDT_APB>;
> +            clock-names = "core_clk", "apb_clk";
> +            resets = <&syscrg_rst JH7110_SYSRST_WDT_APB>,
> +                     <&syscrg_rst JH7110_SYSRST_WDT_CORE>;
> +            reset-names = "rst_apb", "rst_core";
> +            timeout-sec = <15>;
> +    };
> +

Drop trailing line.

Best regards,
Krzysztof

