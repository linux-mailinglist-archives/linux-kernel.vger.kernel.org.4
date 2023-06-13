Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAEA72EB01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjFMSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFMSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:31:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D119A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:31:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977d0288fd2so958190066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681089; x=1689273089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5thdLVYeuJeTUk/dZICHlBR7keQEdx+TmjFnb0n07Q=;
        b=lWqpp6puRrFsbAwShsKqSraSDgQObj9USYvpffkItesvmaDcgsXF/WGZZ5Y5f921Ff
         1vHZcEY8552gz4V+6UU3jg6GebW8ykbiW2RwL8pH2ZJQUbkiNMWCBGAJhCCwXCtpj4Mn
         UHeXizNVq0XyD/uQKq3JcfuEjqiDsSX+pYgCWoEouDox+C7KP1cjEseLgNgULKtWAAAQ
         qta1fFgpPxUmeLzv8WOaWGA6vxxwrZbM8+JNjwNfYjFbPgVrgdUI+4Xm/bhyl3xszcOe
         37erSN21JN0piPgVvYcQ62/OfHBGc5JX/OR2qWu+4J4fUZxN6VGAKB2gYIRf6QFaWYjE
         DrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681090; x=1689273090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5thdLVYeuJeTUk/dZICHlBR7keQEdx+TmjFnb0n07Q=;
        b=cmtUepdfo1bYC99etCL8RS97e8nPxSYMhpVT0fn+CJmhmbAH0okT6Yvae3SX5h80Pw
         bSQXEsWcfIhyrqtVaN1Gv+CN8SDTvoVQtubd48qo8aLTG2ZTd/+oNOL+M83JAcnXj/fe
         yROVmmxBYmItuhAF6GRsnSGX1xN1YX+kUbY/R9n6D4HtWXc0FssXONGI5UeLawXaKN8g
         hKs2YdQUXkb3TNJXi/359UiCl32XThdufVRwV9prU96TOb0zeeWwP9RI7n7OxV5IF8hn
         BWJmFhaXrI2DiBx0/1T9/nTobofn6+3pZRNQXUKJAasmnO8yUJYYjIGOsNe4T4nkONPH
         HzwA==
X-Gm-Message-State: AC+VfDxVBWxWepkLO8kYFBkMnXQbM3AJQyaOX8eFsdFQJCp9adIw1HKP
        onjJxS1QFzaSyPrHpWUZ8BuSuw==
X-Google-Smtp-Source: ACHHUZ7FW4zcNCHYDLc8YmIToBwJQq9MRqn3NydANM5LTgdwq836BPniBmMoR6EXg/p91D8iAKdAqw==
X-Received: by 2002:a17:907:3fa4:b0:977:da9d:b842 with SMTP id hr36-20020a1709073fa400b00977da9db842mr13680418ejc.74.1686681089686;
        Tue, 13 Jun 2023 11:31:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b00977e0bcff1esm7071095ejb.10.2023.06.13.11.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:31:29 -0700 (PDT)
Message-ID: <7e2d6bfe-5687-97c5-778b-c02e9c0894af@linaro.org>
Date:   Tue, 13 Jun 2023 20:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-3-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613125852.211636-3-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 14:58, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..a81190f8a54d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-stg-syscon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
> +    type: object
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-aon-syscon
> +    then:
> +      required:
> +        - "#power-domain-cells"

Where did you implement the results of the discussion that only some
devices can have power and clock controller?

According to your code all of above - sys, aon and stg - have clock and
power controllers. If not, then the code is not correct, so please do
not respond with what is where (like you did last time) but actually
implement what you say.

Best regards,
Krzysztof

