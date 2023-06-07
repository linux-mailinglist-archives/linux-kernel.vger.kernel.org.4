Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA2725DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjFGMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbjFGMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:04:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314291BC3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:04:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6148f9679so6723592e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686139470; x=1688731470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZ6mcI1bKJ1Kz+T1ZnrarK0a6kbd0xZgbwjVj3l23gQ=;
        b=QyNIyfZNjvs9IoORoZOHIWYIzs/i5XmcHk9EYJVDXS+JzHFp2tltW8FHlmN3Sg9g8y
         hmIaMvv6uFlwRmY5iv+w7QkRqDzSkn5JYRvFvqcBd4loOW1d8Q14l2plZfWcAUO+n4IW
         FkuCdTvX+r2gydNGGHI7Im42L/LicBYZK1BKAH1+e3dk8MP1+iJBYYLSjj8JQbVYZwbP
         zpKeR6gtE7iXZlvDqnhUdc3Uf7R54JkbemoUv7uCyRe4x8Pj0u5HLqhKV5RKZjRr1xNv
         q7PZPuZnPszQw1pRNO//YWeWi2lHZCx0AQ/bfQWmd9bu+928uyzC3GJbllU2hKdybS7E
         oRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686139470; x=1688731470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6mcI1bKJ1Kz+T1ZnrarK0a6kbd0xZgbwjVj3l23gQ=;
        b=bQFZea+i++3n8MONxCjAjz6ekrv7s53qFEy73eM5r+6NZst1FsFa0IXlkT/FXmb6LO
         T6tgpbSFp5IxS+aUT9LteTV8hsPe95GfVckBac9AUYL4adoPcUW7AVtB32LKJIxnm01V
         CMrJ5vCSQWISQtwCEe8B5Ej0cSvdGAhhaK3+zeYKTNAqrvswpYJgVhtAwVQGy0l0ckRW
         pYpqdaHORF/aomQFr70NZVAc3zxeiFS4N+LCtcJPnSjpkHfX/HIMQkOd2qRWr9VcUNc/
         Uxl0C5MFa38KEwvDKB1KMYL3TK+cPZvzRITrWXlmYtp9ANAuHv3dVLV1qXHDuYE9PNKn
         VRdA==
X-Gm-Message-State: AC+VfDzPeBda50eU3LnG8JLcGSd5VHPU42mgPJzhltRZhqJqOZmMp/r0
        +A9HOfnd5jkj6bOs8LjMplxm4g==
X-Google-Smtp-Source: ACHHUZ65yqG1QTublwh1Yaw6Z8SsrNVJqtjy+wO7w5acN3E/o/a6FRCaVjvVnek45VpoZHg3PnLUmQ==
X-Received: by 2002:ac2:5d2b:0:b0:4ec:8615:303e with SMTP id i11-20020ac25d2b000000b004ec8615303emr1855791lfb.33.1686139470262;
        Wed, 07 Jun 2023 05:04:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b0051631518aabsm6057200edr.93.2023.06.07.05.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 05:04:29 -0700 (PDT)
Message-ID: <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
Date:   Wed, 7 Jun 2023 14:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
Content-Language: en-US
In-Reply-To: <20230607062500.24669-4-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:24, Stanley Chang wrote:
> Add the documentation explain the property about Realtek USB PHY driver.
> 
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 2.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3.
>     2. Add more description about Realtek RTD SoCs architecture.
>     3. Removed parameter v1 support for simplification.
>     4. Revised the compatible name for fallback compatible.
>     5. Remove some properties that can be set in the driver.
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb2phy.yaml         | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> new file mode 100644
> index 000000000000..69911e20a561
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC SoCs USB 2.0 PHY
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description:
> +  Realtek USB 2.0 PHY support the digital home center (DHC) RTD series SoCs.
> +  The USB 2.0 PHY driver is designed to support the XHCI controller. The SoCs
> +  support multiple XHCI controllers. One PHY device node maps to one XHCI
> +  controller.
> +
> +  RTD1295/RTD1619 SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on some
> +  controllers.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +
> +  RTD1395 SoCs USB
> +  The USB architecture includes two XHCI controllers.
> +  The controller#0 has one USB 2.0 PHY. The controller#1 includes two USB 2.0
> +  PHY.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +                               |- phy#1
> +
> +  RTD1319/RTD1619b SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#2.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +
> +  RTD1319d SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each xhci maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#0.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +
> +  RTD1312c/RTD1315e SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtd1295-usb2phy
> +          - realtek,rtd1395-usb2phy
> +          - realtek,rtd1619-usb2phy
> +          - realtek,rtd1319-usb2phy
> +          - realtek,rtd1619b-usb2phy
> +          - realtek,rtd1312c-usb2phy
> +          - realtek,rtd1319d-usb2phy
> +          - realtek,rtd1315e-usb2phy

Keep entries ordered alphabetically.

> +      - const: realtek,usb2phy
> +
> +  reg:
> +    items:
> +      - description: PHY data registers
> +      - description: PHY control registers
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  realtek,usb-ctrl:
> +    description: The phandle of syscon used to control USB PHY power domain.
> +    $ref: /schemas/types.yaml#/definitions/phandle

No, we have power-domains for this.

> +
> +patternProperties:
> +  "^phy@[0-3]+$":
> +    type: object
> +    description:
> +      Each sub-node is a PHY device for one XHCI controller.

I don't think it is true. You claim above that you have 0 as phy-cells,
means you have one phy. Here you say you can have up to 4 phys.

> +      For most Relatek SoCs, one XHCI controller only support one the USB 2.0
> +      phy. For RTD1395 SoC, the one XHCI controller has two USB 2.0 PHYs.
> +    properties:
> +      realtek,page0-param:
> +        description: PHY parameter at page 0. The data are the pair of the
> +          offset and value.

This needs to be specific. What the heck is "PHY parameter"?

> +        $ref: /schemas/types.yaml#/definitions/uint32-array

Array? Then maxItems.

> +
> +      realtek,page1-param:
> +        description: PHY parameter at page 1. The data are the pair of the
> +          offset and value.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      realtek,page2-param:
> +        description: PHY parameter at page 2. The data are the pair of the
> +          offset and value. If the PHY support the page 2 parameter.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      realtek,support-page2-param:
> +        description: Set this flag if PHY support page 2 parameter.

Why this cannot be deducted from compatible?

> +        type: boolean
> +
> +      realtek,do-toggle:
> +        description: Set this flag to enable PHY parameter toggle when port
> +          status change.

Do not instruct OS what to do. Explain why this is a hardware
characteristic.

> +        type: boolean
> +
> +      realtek,do-toggle-driving:
> +        description: Set this flag to enable PHY parameter toggle for adjust
> +          the driving when port status change.

Do not instruct OS what to do. Explain why this is a hardware
characteristic.


> +        type: boolean
> +
> +      realtek,check-efuse:
> +        description: Enable to update PHY parameter from reading otp table.

Do not instruct OS what to do. Explain why this is a hardware
characteristic.

> +        type: boolean
> +
> +      realtek,use-default-parameter:
> +        description: Don't set parameter and use default value in hardware.

NAK, you are just making things up.

> +        type: boolean
> +
> +      realtek,is-double-sensitivity-mode:
> +        description: Set this flag to enable double sensitivity mode.

All your descriptions copy the name of property. You basically say
nothing more. I already mentioned this before. Don't ignore the
feedback, but address it.

> +        type: boolean
> +
> +      realtek,ldo-force-enable:
> +        description: Set this flag to force enable ldo mode.

Drop everywhere "Set this flag to", because it is redundant. Now compare
what is left with property name.

Property name: realtek,ldo-force-enable
Your description: "force enable ldo mode"

How is this helpful to anybody?


Best regards,
Krzysztof

