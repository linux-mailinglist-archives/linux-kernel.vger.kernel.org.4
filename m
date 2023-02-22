Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884FD69F109
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjBVJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBVJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:11:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012C937B53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:11:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p16so2933676wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8Z3U2jSFOxoIFyiBCe5R2j9sYihkmbTptnAxMlSu9k=;
        b=Guc3YKP0FkFYEWhWdBCSSN0zrdl2JQXrvUuLCiNQTQq8oneRfQhi8KfYThizQPGgPq
         41rsV+y2ieepGqWwj8YZTKXzuRPPYsgRZiumZsdJdTkAJM0K5bVsXmV2wE9Am/sjtTSy
         /X3xu/u4rBl3khFTJEMlAvXbDMGHV9ZeFr03IcsTFdFnzzjhvfVSYZy/D0NeQuEteN5u
         dmGvQCO4rDK5JTvFMdobJkyMbXG0yz1BWfgdO+25ZW2Na89L2wfIDRjYwx6J/xs90CZs
         t/dwlogHtTmCB069/gcUOgjpCJ8OOdEMIBFUiXjIbZbxvpCxyewiGMK1CbnGJfUia+nZ
         9RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Z3U2jSFOxoIFyiBCe5R2j9sYihkmbTptnAxMlSu9k=;
        b=lSuam8IxfpE3Tq90Ts47CJ9sp18tHJq9htVrhiP9/M6T5tUbQmL+AR9qeUi6oTXqXm
         ogo2uPYKnGx3IxDiroygedC1X9qnchqoqExmbr+HXAOC66ZxoMKRvGpFtXjLSk37yEXf
         MjlR7ceRiFYno3QY2i9IF50dxrCJzu15CN5SKk4/vHxnS+EJoLZodRtcInc38gugN518
         f2Y0avDpF3gIcyZLzdsSef/0svBJGmqcaw/5lNjN0BmE2/em+jS42ub/sy3Hk0TJ7cnr
         Qd5mWnV6Wy5xCaT6YMv6NPWc6vmGpkEnRC0IId0YxHAB7gKI46DKcAaC54zSubcVkWLk
         lALw==
X-Gm-Message-State: AO0yUKVs/fRtOO/9DRXiGUYcB3fKnHki8Y/ulY200RVGz6zCa0kjEP4w
        a1zSgqxprtGCrYdR3bYnQx+9og==
X-Google-Smtp-Source: AK7set8D+S9eMMLXDr7nQ5Ht2tAf8yzghsq0dXfGhGWC+M/PZKU/R2/n5q0isJXiYis0IFxF5v9CMA==
X-Received: by 2002:a7b:ce96:0:b0:3da:2a78:d7a4 with SMTP id q22-20020a7bce96000000b003da2a78d7a4mr5879968wmj.21.1677057096462;
        Wed, 22 Feb 2023 01:11:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b003e2059c7978sm6879903wmo.36.2023.02.22.01.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:11:36 -0800 (PST)
Message-ID: <c0df5685-d0ef-705c-9684-86928dd68ab5@linaro.org>
Date:   Wed, 22 Feb 2023 10:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
 <20230221141147.303642-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221141147.303642-2-xingyu.wu@starfivetech.com>
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

On 21/02/2023 15:11, Xingyu Wu wrote:
> Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.

Just one sentence... not explaining anything around ABI break. Nope.

> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/clock/starfive,jh7110-pll.yaml   | 45 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 12 ++---
>  2 files changed, 52 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
> new file mode 100644
> index 000000000000..8fd18e6c2e9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PLL Clock Generator
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pll
> +
> +  clocks:
> +    maxItems: 1
> +      - description: Main Oscillator (24 MHz)

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
> +
> +  starfive,sysreg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

That's not how the property is modeled... look at other code.

> +    description:
> +      the phandle to System Register Controller syscon node.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - '#clock-cells'
> +  - starfive,sysreg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pllclk: pll-clock-controller {
> +      compatible = "starfive,jh7110-pll";
> +      clocks = <&osc>;
> +      #clock-cells = <1>;
> +      starfive,sysreg = <&sys_syscon>;
> +    };
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
> index 5e4f21ca0642..086a6ddcf380 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -6,6 +6,12 @@
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>  
> +/* PLL clocks */
> +#define JH7110_CLK_PLL0_OUT			0
> +#define JH7110_CLK_PLL1_OUT			1
> +#define JH7110_CLK_PLL2_OUT			2
> +#define JH7110_PLLCLK_END			3
> +
>  /* SYSCRG clocks */
>  #define JH7110_SYSCLK_CPU_ROOT			0
>  #define JH7110_SYSCLK_CPU_CORE			1
> @@ -198,11 +204,7 @@
>  #define JH7110_SYSCLK_TDM_TDM_INV		188
>  #define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
>  
> -#define JH7110_SYSCLK_PLL0_OUT			190
> -#define JH7110_SYSCLK_PLL1_OUT			191
> -#define JH7110_SYSCLK_PLL2_OUT			192
> -


NAK. ABI break. You have entire commit msg to explain this and avoid
questions from reviewers.

Best regards,
Krzysztof

