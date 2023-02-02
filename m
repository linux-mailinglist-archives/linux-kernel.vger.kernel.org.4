Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA46877EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjBBIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:52:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8746D7C73C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:52:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso760068wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP/sXG6BbiZp8djPCPgh/7Unv00A4lZ4qBzipf/bhsw=;
        b=XwN8l9XYFjm4ZrMbgDED4aiv0zeRcUNbp5GZihY8LHKMp2UwRH2Rceypz6EYWj1aAd
         pUkIYqwM+QGYyHpBD4u00DZGyaUeYeRJLjBr3ODdsWyS8nV3+7IZT4u7bDXN/UaP+068
         1g2lKw7gO2oNZ4c8vC2s+WYt1ssRJ6836EB9ErE/ke2SCLndciXjSXIsi5/GrOm2Vib5
         bl35tk9xx+TuvQug7Q95iHzAhgrXMdwHtl+OxPNtqGcgxWPQGrHS8rP9zJX9IOgn508u
         Ut9iBVlktBP8cd56jpz7uDkbRayVArniaM24SadAEdomOMrHeCmm3+oQu8iNGsJyqY9+
         0PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UP/sXG6BbiZp8djPCPgh/7Unv00A4lZ4qBzipf/bhsw=;
        b=6WlJmDo6a49roiTbvrw4OXsCPfBPj44AboK7UcxkZwiidJWJVn84qqw1oAIkByFK5K
         kNkoyRg/eZoY9Qdp7c57So0Wrrtm315K8l2PD8w0lK85e3hVEZMNP9k2hQiK6AGpxEWY
         cgiX8uqTAszVgfKqYtEmzlGcDZN2ETOF3mGk4RSzPuZTDYCz97CgY/sMVoUJhT0sa52s
         VSQWIexMHvgWP+04K1YCw98r02iIk2hVUTcwvFq5ttlWmFtkB8RqDjtTZUIeKFldzVt3
         LdE1924Oj7o0z9zklQEwjMxntbCcKEzJak7aWuEjF2+FsP5dg7PtNNgYSs0S+U77FASy
         EdmA==
X-Gm-Message-State: AO0yUKW0U64fRoNZpTp6h69IoXOmc7A5o0GWK+2gS+sWLds5IUQWRUGG
        FD8GXxdQC/8l963iRUzr06ku1w==
X-Google-Smtp-Source: AK7set9B04peanV4wBhLfFzs1g9pGIOA4lkMICSMs7zldQ2TUJBQMnQJ7ne0vOW2lLc8zPNnsIbVVQ==
X-Received: by 2002:a05:600c:4f41:b0:3dc:53da:329b with SMTP id m1-20020a05600c4f4100b003dc53da329bmr5029207wmq.17.1675327968137;
        Thu, 02 Feb 2023 00:52:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003d1d5a83b2esm3976373wmr.35.2023.02.02.00.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:52:47 -0800 (PST)
Message-ID: <fcb460cd-f435-e52a-e335-ccea3ac56a30@linaro.org>
Date:   Thu, 2 Feb 2023 09:52:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c-ast2600: Add support for AST2600
 I2C global controller
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
 <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
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
> AST2600 I2C global register controller, add bindings document
> to support driver of i2c global register set.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../i2c/aspeed,i2c-ast2600-global.yaml        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> new file mode 100644
> index 000000000000..d92a0878d03b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600-global.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Global Register on the AST26XX SoCs Device Tree Bindings

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
> +      - aspeed,ast2600-i2c-global

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

I'll stop review till you test the patches before sending.

Best regards,
Krzysztof

