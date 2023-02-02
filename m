Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496646877FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBBI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjBBIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:55:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A1514EB8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:55:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3164946wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POWoFIiezkQ7xB1RHj3NozzgnXzo2XDIWIWlrZ65h/g=;
        b=w8ujg9oNS8uVlfJbDR44MAugiDMve16QPs97ZkiRiGFzVO32tk88W1WNopA88byYgT
         gZUXDe0LM0uzMFxsSJUJUh+mFk0Bu3qKqKtmoNm2QNYPNF6y9uxm4Y1ErqAIzdJaGOSn
         vgDGFlXhaCnt+lUhG/SBUpH66RP+kYspyh497Xh4ctpDocxl27T8ol7bib3eQkAu/EsX
         7L23EGdi6ww4gNxEoAxhCRxCGtv9BC/mposJXVOloH3Pn/GDe7SktTK44//4jGYSNOzT
         P3gP6A83EO434iElZnADFYp99QFRd3WHt28S/ezvLLGIxe42DnGuiPy/vNxfePE9X1fZ
         dyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POWoFIiezkQ7xB1RHj3NozzgnXzo2XDIWIWlrZ65h/g=;
        b=UXjr3AeAf9Hl41ozBIcX0YoaVpbOWAdkCvf19SA8SmKAAlIPsM7ESTn0IgJNFoSUvz
         FpxieRYqtfxjZzfXlT9epFGBhz9UqG2KT50AOXWxKQ/AQp9jXjYQOzt+NOq9nk9qt4dT
         t7DZHG2wDepJ/HAVcHE/YFGE0yoTt7VzBVlXuc6Tw3U20UKHlaDJMaF1RPgIhf3DCSt3
         ZudSI1SQvG9mSqJmOLanW8WVJG7AWvF1HX9Aq4k/njllis1fbXIwwOlyDzRwEF0p71Qp
         QRM2s37kX0SvgODA36F/8Y7pOo1ZPHbwtfRSFr0j2moplHzKTLXFBW1r6jwIXS+IGED7
         QStw==
X-Gm-Message-State: AO0yUKWTtVXh4lW39XF78EzFgVKVmQGa9dsJw6anbtydLxqTt+yy1H/r
        DoqI519ogg560esdjoPq9USgfQ==
X-Google-Smtp-Source: AK7set9nIjbCt0rzWfU1vQkAIIFH6HJ2GKEJdXgJBW28RvRh8fXf/ONu3jzIWkLZADeSv4W1sVeTpA==
X-Received: by 2002:a05:600c:1e13:b0:3d9:f836:3728 with SMTP id ay19-20020a05600c1e1300b003d9f8363728mr5242681wmb.11.1675328149379;
        Thu, 02 Feb 2023 00:55:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6daf000000b002bfe266d710sm938230wrs.90.2023.02.02.00.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:55:48 -0800 (PST)
Message-ID: <a3c63ebd-540b-40a0-6caf-bf2a8e629538@linaro.org>
Date:   Thu, 2 Feb 2023 09:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 11:33, Ryan Chen wrote:
> AST2600 support new register set for I2C controller, add bindings document
> to support driver of i2c new register mode controller.

Subject: drop "driver". You are not adding here driver.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,i2c-ast2600.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> new file mode 100644
> index 000000000000..b7d7bc303e77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml

Filename based on compatible.

> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-i2c
> +
> +  reg:
> +    minItems: 1

Why second item is optional?

> +    items:
> +      - description: address offset and range of bus
> +      - description: address offset and range of bus buffer
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      root clock of bus, should reference the APB
> +      clock in the second cell

Either this is root clock or APB clock. Decide and describe the clock
(hardware), not the DT syntax (drop "cell").

> +
> +  resets:
> +    maxItems: 1
> +
> +  bus-frequency:
> +    minimum: 500
> +    maximum: 2000000
> +    default: 100000
> +    description: frequency of the bus clock in Hz defaults to 100 kHz when not
> +      specified

Don't repeat constraints in free form text.

> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus
> +
> +required:
> +  - reg
> +  - compatible
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    i2c_gr: i2c-global-regs@0 {
> +      compatible = "aspeed,ast2600-i2c-global", "syscon";
> +      reg = <0x0 0x20>;
> +      resets = <&syscon ASPEED_RESET_I2C>;

Drop. not related.

> +    };
> +
> +    i2c0: i2c-bus@80 {

Drop label.
Node name: i2c

I guess this wasn't tested, right?

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <1>;
> +      compatible = "aspeed,ast2600-i2c";
> +      reg = <0x80 0x80>, <0xC00 0x20>;

Compatible is first, reg is second.

Use lowercase hex.

> +      clocks = <&syscon ASPEED_CLK_APB2>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +      bus-frequency = <100000>;
> +    };

Best regards,
Krzysztof

