Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EF69C6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBTIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBTIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:35:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A326B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:35:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id eq27so6110224edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPgdhAOmSIiYem88u79FyFtC580XWiSnDRefpcl3wxU=;
        b=XWuKWkAULnvOtoiztVJqveR6mJF0HJSLsHXvwCqTl47YE1Z09KyvXcf2p6HuH/9tS6
         1VDN4XRJZFPJ3TPX8UXippcMlEA0yObXO3eSR/pw60Ks8dgBAyQYb47UHzfHVXKItjVf
         9Lhk5+6yRVZi77L8OaxOOQFy9v8X+xQsKbG0ec3Fz7M534XEnmPtGXufX11HGrFzvseG
         JcYBiUgG+Qgda7WMkNL0PdAv9Mjw5qmgRhcA1s+o7HTP3BA5JqT7YhiRiPQ2WKLOaHq5
         W7DiYnGWmCTc+yiQohwONZc2jOyTKiV5RAdFIS9ni36dJWzATWW/GKDy3GnRl8boJl5o
         3iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPgdhAOmSIiYem88u79FyFtC580XWiSnDRefpcl3wxU=;
        b=tls2L2NEWqyZkllZqbKPI9CSGBc+0WNW6PRDiArTcyv7VMzMYoTe99rGScMOEeNOPl
         Mb/zq+yuPA3WSR2MvjQ4Sg/9gHHAiMZD57IsF7cu/1pJyZ6CDXaXjtO0Wdv7sRI0L8bb
         cKqkoP88KZHpe6DqO+QHDVvgeX9pH969EbvrAtxm8K7sUtsjhCrBBV8lqMUa0jCRyOyC
         +eR8CaUTtG1wxqyW/v/V92qkCUkjl80TfzxhuUiBKyK3atHjzcvFIyvXPOz0FU81jm79
         mr/iiWsPG/2axsOJzg0vTb1naWbRXrtyhcWUKxtWn86OGqxLyFRS6bTKvWdfP3K779qi
         kW8w==
X-Gm-Message-State: AO0yUKWdHlslW93IbDOE798eAWD/vesuXHrii+Mm+pjJjMCH8djQEPe0
        w1U1J5gLV9D4YdSEQfPth76t9Q==
X-Google-Smtp-Source: AK7set80th0Zs5GwkSRoZ8yyoVVCdR5vADjna3NgcLVVDgQANN7HhHjfPwAuhBHbUzPjMXDUMdQ9sw==
X-Received: by 2002:a17:906:174b:b0:88e:e6ee:feab with SMTP id d11-20020a170906174b00b0088ee6eefeabmr9286561eje.62.1676882106773;
        Mon, 20 Feb 2023 00:35:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090629d000b008cc0294b69esm1665877eje.108.2023.02.20.00.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:35:06 -0800 (PST)
Message-ID: <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
Date:   Mon, 20 Feb 2023 09:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
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

On 20/02/2023 07:17, Ryan Chen wrote:
> AST2600 support new register set for I2Cv2 controller, add bindings
> document to support driver of i2cv2 new register mode controller.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml

New compatible is okay, but as this is the same controller as old one,
this should go to old binding.

There are several issues anyway here, but I won't reviewing it except
few obvious cases.

> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> new file mode 100644
> index 000000000000..913fb45d5fbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED I2Cv2 Controller on the AST26XX SoCs
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
> +      - aspeed,ast2600-i2cv2
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: address offset and range of register
> +      - description: address offset and range of buffer register

Why this is optional?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Reference clock for the I2C bus
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      Desired I2C bus clock frequency in Hz. default 100khz.
> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus

Drop description and type. Just :true.

> +
> +  timeout:
> +    type: boolean
> +    description: Enable i2c bus timeout for master/slave (35ms)

Why this is property for DT? It's for sure not bool, but proper type
coming from units.

> +
> +  byte-mode:
> +    type: boolean
> +    description: Force i2c driver use byte mode transmit

Drop, not a DT property.

> +
> +  buff-mode:
> +    type: boolean
> +    description: Force i2c driver use buffer mode transmit

Drop, not a DT property.

> +
> +  aspeed,gr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of i2c global register node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - aspeed,gr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    i2c: i2c-bus@80 {

You did not test the bindings... This is i2c.


Best regards,
Krzysztof

