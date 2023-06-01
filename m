Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D2719360
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjFAGj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjFAGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:39:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F0E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:39:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso50792866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601559; x=1688193559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AZTti3hnOfo2K8dgJeKfKo0vQJSNPFdB0HHjqiUZdQ=;
        b=zHr2v4n33JitArg2FisrG8mOgo9OALS+MPgdsIi6awh6R4K7AJxeKBqMjcpw15pXs1
         rlG1aZa4vdmmOWU2h58TYWoiASTEXeN0wySako8E8S0iEm1kf34tQW3AWW68qOCft+pF
         Ic2yNVVvFwDrCOGRLtPfchNyIHvQ1OqWR3qrRUswrAn/KbcGky+/o/EmKbiEcfTZ/Bz6
         kio2S4ZF4Q19S9m8F/sWoCql6F6BW25dHJL4X4Pef3qZhYfHy5SxGmtgvHBkiZkB5eUS
         oRtq+fkV5z0TRavC1W1KEuXP16Nz+jZGz9rY8+XhD67WfH6fYUKSJ7XYreCwa2NZJCbd
         UT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601559; x=1688193559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AZTti3hnOfo2K8dgJeKfKo0vQJSNPFdB0HHjqiUZdQ=;
        b=EzEMzVPN48H4yp3TM/jmITaNU/EQp/Kw18/M4HovF2DX24F9CMhp1ChrFlC8ORjfxd
         wTnRhYmGngk8g1YB7EBR+DCeSCuV0PuzVe9POKA/KgMb6sNqwapSU8x681DTUk7tqgZ6
         tEibYLz+9nZ0ne/x5GjWvKGtrfKqrWAm46SQe26kMJIJr5uMx5pdLGqIs+Lwv/lwEYqB
         uo/IpxiPFqLElE2JPHAbW8JH3pcQIKG1Z6xKZspWIDpHvtx4s9guPS1bBpu8ZC+t6C7u
         uuR888FyUNAkAcSHeUsIJOy/HBJRAEEGNuv2wknH4UyEXm2QHHEyT5A+63lDdORe5glq
         cQvQ==
X-Gm-Message-State: AC+VfDxKM0JltrVmBe+GPOPGk5MjRwxz6/IxLi+iS56NNNZgIUNC2j2n
        HjQED5KRyNy/SzTU4/NygnDXRQ==
X-Google-Smtp-Source: ACHHUZ4ORU8upQ4G8si2odb+vSyyhtJVyQOUyEoJlcnD4bKHGGrw9iuWg7GKEqaeOcDwqcQov7rqUQ==
X-Received: by 2002:a17:907:3686:b0:965:fb87:4215 with SMTP id bi6-20020a170907368600b00965fb874215mr6067068ejc.15.1685601559442;
        Wed, 31 May 2023 23:39:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090685cd00b0096f83b16ab1sm10049045ejy.136.2023.05.31.23.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:39:19 -0700 (PDT)
Message-ID: <498bedab-c937-9b93-87db-5ca33ff81e3b@linaro.org>
Date:   Thu, 1 Jun 2023 08:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/43] dt-bindings: clock: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-5-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-5-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:33, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - it's now a clock controller
> 
>  .../bindings/clock/cirrus,ep9301.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml
> new file mode 100644
> index 000000000000..4f9e0d483698
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301.yaml

Filename matching compatible.

> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,ep9301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic ep93xx SoC's clock controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +description: |
> +  Cirrus Logic EP93XX SoC clocks driver bindings. The clock
> +  controller node must be defined as a child node of the ep93xx
> +  system controller node.
> +
> +  See also:
> +  - dt-bindings/clock/cirrus,ep93xx-clock.h
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-clk
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-clk
> +              - cirrus,ep9307-clk
> +              - cirrus,ep9312-clk
> +              - cirrus,ep9315-clk
> +          - const: cirrus,ep9301-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    description: List of clock specifiers which are external input
> +      clocks to the given clock controller.

Drop description, it's obvious.

> +    items:
> +      - description: reference clock
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clocks {
> +      xtali: oscillator {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <14745600>;
> +      };
> +    };

Drop this part of example, it's obvious.

> +
> +    clock-controller {
> +      #clock-cells = <1>;
> +      compatible = "cirrus,ep9301-clk";

compatible is always first property.

> +      clocks = <&xtali>;
> +    };
> +...

Best regards,
Krzysztof

