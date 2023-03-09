Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABB6B20EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCIKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCIKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:07:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC880E4C77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:07:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a25so4944673edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678356425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1rKZQWrvQdsaiUknj2gLx58N9hXAh/NcUMYH+8P2Io=;
        b=NiDoNuNKomZlAKL/pzyIYZUo/9we1SdUtGyI3dm+QSAUoxdzMY/2nMis/n7ozTn75i
         HSwbe8wbQkXHxOAs30NTUKURdBt9sThyysncB6m1Yo6aDJ2QzR6S4UBYIDhbPFiTBSC/
         NihP53M2ZqKtlgm4yaGtqyG3HVJNt/CwqGCdK1ZKu/Hg0yf6pnT5gnzUTlaBP4rpoRES
         uhG/BDxi+XD/M4qr0/qq3y04uC4Gr1kA6DxGhWxgYgjE/nmgwwsrRWf7mTcU58Thgez8
         GM9JgCHjwZxLJG1YapfL1jM3GriBjqgbZ0qxTMbX+mbpUzM/5+857XK4DKHmVZdcU+ej
         c9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1rKZQWrvQdsaiUknj2gLx58N9hXAh/NcUMYH+8P2Io=;
        b=K1zCnkWcZN+//ArRVjrWCV4IqadK+0mWiEjEnGgjTJyn6MwBKkVBzXNbeasrJTEWyr
         6oU6FLz544eW1RgrhnZkZTcuKYhhrSuTGMhzRgvayy7eJ1PlF65hvUNT5zud2m7iWt1/
         rnS7DjTykMMNQF02Gb176R/0JnIe1ZkLmPLX0/yl0PZxsR1QHDz1Kf14OHcTKRUvbOUN
         V2MBwYULULQwIA7mtGBcZwf/LmCp48PuDotu3matOhiu1rucfHmOEv2AjWnXLq5CrX3Z
         2+MDOhq2CgaxAJOfnAa/x0rRO9Hcpd/jy+GAjYF9vt7nnAvMHB4z7vBr88a+cSkgcBs3
         4kTA==
X-Gm-Message-State: AO0yUKXmNSZTeRMRTY6byroLnb1y86ZJ9D6fjtQbOEYSVkUWnpS8ZQML
        D1Xglpx/Nj/5FwJo0Y8qyNdirw==
X-Google-Smtp-Source: AK7set9dG7e71ZUsBA8QSEtjZmcxScdoi257cMlVacjcfvEL5jfaX1PVjAAYQWu+1xVUYACTvB0xpA==
X-Received: by 2002:a17:907:8b16:b0:8b1:2e7c:df49 with SMTP id sz22-20020a1709078b1600b008b12e7cdf49mr23571182ejc.7.1678356425261;
        Thu, 09 Mar 2023 02:07:05 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id t25-20020a50c259000000b004efd65452a5sm3335676edf.70.2023.03.09.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:07:04 -0800 (PST)
Message-ID: <8124eed7-b9ab-046d-4eb2-9b853ce2bcdd@linaro.org>
Date:   Thu, 9 Mar 2023 11:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add StarFive JH7110 USB
 dt-binding
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230308082800.3008-1-minda.chen@starfivetech.com>
 <20230308082800.3008-2-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308082800.3008-2-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 09:27, Minda Chen wrote:
> Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
> USB controller is cadence USB 3.0 IP.

Subject: drop second/last, redundant "binding". The "dt-bindings" prefix
is already stating that these are bindings.

> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> new file mode 100644
> index 000000000000..daa88d065deb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive USB 2.0 and 3.0 PHY
> +
> +maintainers:
> +  - Minda Chen<minda.chen@starfivetech.com>

Missing space

> +
> +properties:
> +  compatible:
> +    items:

Drop items, it's just one item.


> +      - const: starfive,jh7110-usb
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: usb3
> +      - const: usb2
> +
> +  clocks:
> +    items:
> +      - description: usb 125m clock
> +      - description: app 125m clock
> +      - description: lpm clock
> +      - description: stb clock
> +      - description: apb clock
> +      - description: axi clock
> +      - description: utmi apb clock
> +
> +  clock-names:
> +    items:
> +      - const: usb_125m
> +      - const: usb0_app_125
> +      - const: usb0_lpm
> +      - const: usb0_stb
> +      - const: usb0_apb
> +      - const: usb0_axi
> +      - const: usb0_utmi_apb
> +
> +  resets:
> +    items:
> +      - description: USB0_PWRUP reset
> +      - description: USB0_APB reset
> +      - description: USB0_AXI reset
> +      - description: USB0_UTMI_APB reset
> +
> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to System Register Controller sys_syscon node.
> +        - description: offset of SYS_SYSCONSAIF__SYSCFG register for USB.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of SYS_SYSCONSAIF__SYSCFG register for USB.
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to System Register Controller stg_syscon node.
> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for USB.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of STG_SYSCONSAIF__SYSCFG register for USB. Total 4 regsisters offset
> +      for USB.
> +
> +  dr_mode:
> +    description: PHY mode.
> +    enum:
> +      - host
> +      - peripheral
> +      - otg
> +
> +  "#address-cells":
> +    maximum: 2
> +
> +  "#size-cells":
> +    maximum: 2
> +
> +  ranges: true
> +
> +  starfive,usb2-only:
> +    type: boolean
> +    description: Set USB using usb 2.0 phy. Supprt USB 2.0 only
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - starfive,sys-syscon
> +  - starfive,stg-syscon
> +  - dr_mode
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +patternProperties:

This goes before required block

> +  "^usb@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      usbphy node should have '1' usb controller subnode.
> +      It could be Cadence USB3 DRD controller.
> +      Cadence USB3 should follow the bindings specified in
> +      Documentation/devicetree/bindings/usb/cdns,usb3.yaml

$ref instead of free form text


Best regards,
Krzysztof

