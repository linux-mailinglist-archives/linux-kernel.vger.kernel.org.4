Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BC69413E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBMJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBMJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:32:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D39ED9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:30:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j23so11461614wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpHa2OO6IfUJ9x7Qw45HN5IHZS4VCZar5vwweznON50=;
        b=opZ+UQ/pXegz0SLGsPVxyy2F+I7SvtBR++2Ja90BdT6e+WGwxdDqNL4tiyNBwhxNjz
         lhS/SBpAmzILo0ZEFyBbAuRrZU934ghWnoPT25PSC7L/oYtAKg3FGc87Ytl8uscL+fuj
         CO3GYv0oTl3eBBgfrX5NqQj9tNV26fOYeiw8/9hCbtpuTDbrAJOl0M5dH6dCTpuWiNP6
         fuQNX7LO1b3Vz5SJrd5Kska792fxssD4J5mYjbsZXcUqkwMeQzSd3Q49ZEhLMP6e2KH6
         yDu1DTBNzLEn9gRAAlg9UX5CZKDmh/yJV93exUlTy0Vs6UJd+fSBYzcFuTf3ikEgjDa4
         RDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpHa2OO6IfUJ9x7Qw45HN5IHZS4VCZar5vwweznON50=;
        b=NbeC2T54CnU9AbdNRrH6PEdKV7jQqKiQnhqRq7oAf9zb2C/LZZK8AtsYCNc5OH0YzR
         m6X80T1xwPTMPKAQzEIsn6/p01wSImP2FvfpfNYFoI2rDrBXRUF6sHThgkiRnXDwa4lM
         TEZBAh6xE2xo/H1pF8mHIZuT3GHUx4g30ahp9iIWg498CPmWnUhxsg5tEJO6YY9ifbxG
         uKdEeX/FryBGMlZi8EmLp0BSyK+b30tCoMk5HpwRgQ0P7cllEHBJnGli8H6HQX9YwHqr
         W5tS0aqDsymhW0bv1K645WKRT6A1IRM0d22wx+O0xYlxTnd4ZteTGUyEbOrEyGOZxlOS
         iDVQ==
X-Gm-Message-State: AO0yUKVL5L+iKPNG8L66r1u8kBvvjlIzGl948BGS5/rqtj52ODjan5mo
        rhMRQpIWE7eXMmhrUtZXP7JTTA==
X-Google-Smtp-Source: AK7set+T1ZW6DDEn7b6T2RvBeRhzbgzRxitNFID/D8/L4CyhFCQOIccrzH+3dp9VV7nUb+Gfi/O6Nw==
X-Received: by 2002:a5d:6805:0:b0:2c5:5886:850d with SMTP id w5-20020a5d6805000000b002c55886850dmr2557588wru.5.1676280624569;
        Mon, 13 Feb 2023 01:30:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b002c5584d0e3dsm2486583wrx.24.2023.02.13.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:30:24 -0800 (PST)
Message-ID: <3fc07187-f5a0-86d1-a0fd-ba18a2baf555@linaro.org>
Date:   Mon, 13 Feb 2023 10:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210061713.6449-3-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 07:17, Changhuang Liang wrote:
> Starfive SoC like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> new file mode 100644
> index 000000000000..1c1e5c7cbee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive SoC MIPI D-PHY Rx Controller
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description: |
> +  The Starfive SOC has a MIPI CSI D-PHY based on M31 IP use to transfer
> +  the CSI cameras data.
> +
> +properties:
> +  compatible:
> +    items:

Drop items

> +      - const: "starfive,jh7110-dphy-rx"

Drop quotes

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

Drop minItems

> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: ref
> +      - const: tx
> +
> +  resets:
> +    minItems: 2

Ditto

> +    maxItems: 2
> +
> +  starfive,aon-syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes

> +    items:
> +      items:
> +        - description: phandle of AON SYSCON
> +        - description: register offset
> +    description: The register of dphy rx driver can be configured
> +      by AON SYSCON in this property.

Can be? So does not have to? But you made it a required property....

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - starfive,aon-syscon
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    dphy@19820000 {

just phy@......

> +      compatible = "starfive,jh7110-dphy-rx";
> +      reg = <0x19820000 0x10000>;
> +      clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFGCLK_IN>,
> +               <&ispcrg JH7110_ISPCLK_M31DPHY_REFCLK_IN>,
> +               <&ispcrg JH7110_ISPCLK_M31DPHY_TXCLKESC_LAN0>;
> +      clock-names = "cfg", "ref", "tx";
> +      resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
> +               <&ispcrg JH7110_ISPRST_M31DPHY_B09_ALWAYS_ON>;
> +      starfive,aon-syscon = <&aon_syscon 0x00>;
> +      #phy-cells = <0>;
> +    };

Best regards,
Krzysztof

