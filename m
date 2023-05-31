Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE771895F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjEaS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEaS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:29:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFD98
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:29:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so91069a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685557792; x=1688149792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pihiUzb9YxLfu51QSeEHkna3pCWxr+8MeT8nCbzASms=;
        b=Jb9LHbe6lXUEAJf5CAAF3X+s5FbueqCJV982aFn/0okeUvxFyfhFwneunVH7H9Tj6m
         97PG/SoxYRQi3jJV4xNnuOYiXLA/W9McETyGk55cxX/+IKcKoK+cwcwKodBQD6xKIgQj
         bjn75tWjmf4HkY/H03pf1IY60w0ZiZbZmK/O9QkAn4m30avzc6q5srTBfbR6PRICWw5h
         DiWxsgg8D53ca/HmHxeMg1TfTXCYWIdqomDw5UDyf6CvEzOIfTUTX7ikXIZxIx9JGHoQ
         Fun/NjsMjtqwG+1ALJ1STiJQ3tGjkFleg7OX29DZa90RihA1aBTBN/0gx2JNTXFv3jdy
         mTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557792; x=1688149792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pihiUzb9YxLfu51QSeEHkna3pCWxr+8MeT8nCbzASms=;
        b=cf/f9BIlns1ZwRd+2+LTi119I1mZNUF1DCnf0Io/BV6NsphLcI7es8qX+L69z9EFG0
         cuoIqDLrs3nU9nfXvdeIAkH4zQyyauVo/vJHnqcLRjEYmIIZLfUB9I7BArv2wUJvWGkv
         NZswAz05YSGV5Gz2Tj4m+AQY6xIB7GIOWcQcgxDXlHerhIqUNnohK4cpFOKIP5cQHMPv
         ZsJ8x0oxhxC87datsvW5jCnZx9FGUMpSFCTIenGW2g8Var4lINdihGNoI3OMgiEqH7tA
         NfJKOlyQUQaQ94Rqi35bLh5dOpkhmrOtGi5Ze+pjxR8oVzhXPFE4jXadQ75MDsR7r3VS
         bv2A==
X-Gm-Message-State: AC+VfDwYsGhgNH/zx5aoHvHIuRKMRb6iaTrFIG+RFjL9slxzJjmsN/Ia
        b1fc9vjAx+T+6GpD2s6SpjecMA==
X-Google-Smtp-Source: ACHHUZ5f6R2QEnkz25fQFpsgHxX/Qz6RrfFNfAtCG9kSDrZ9kJzxA3UVguLYNuhJFhN1x+B4enUszg==
X-Received: by 2002:a17:907:724b:b0:96a:316f:8abf with SMTP id ds11-20020a170907724b00b0096a316f8abfmr6168311ejc.20.1685557792597;
        Wed, 31 May 2023 11:29:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l16-20020a056402125000b0050e01a965a3sm6154079edw.5.2023.05.31.11.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:29:52 -0700 (PDT)
Message-ID: <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
Date:   Wed, 31 May 2023 20:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230525022617.30537-3-stanley_chang@realtek.com>
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

On 25/05/2023 04:26, Stanley Chang wrote:
> Two documentations explain the property about realtek USB PHY drivers.
> 

Thank you for your patch. There is something to discuss/improve.

Actually a lot... The bindings are not suitable for review.


> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB 2.0/3.0
> controller. Added two drivers to drive the  USB 2.0/3.0 PHY transceivers.
> For USB 3.0 transceivers, a driver phy-rtk-usb3 is provided.
> The driver phy-rtk-usb2 is used to support USB 2.0 transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb2phy.yaml         | 255 ++++++++++++++++++
>  .../bindings/phy/realtek,usb3phy.yaml         | 201 ++++++++++++++
>  2 files changed, 456 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> new file mode 100644
> index 000000000000..a2a69da0a163
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> @@ -0,0 +1,255 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/realtek,usb2phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC SoCs USB2 PHY
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Realtek USB 2.0 PHY support the digital home center (DHC) RTD series SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,usb2phy

As pointed out by Conor, this does not make sense.

> +      - realtek,rtd-usb2phy
> +      - realtek,rtd1295-usb2phy
> +      - realtek,rtd1395-usb2phy
> +      - realtek,rtd1619-usb2phy
> +      - realtek,rtd1319-usb2phy
> +      - realtek,rtd1619b-usb2phy
> +      - realtek,rtd1312c-usb2phy
> +      - realtek,rtd1319d-usb2phy
> +      - realtek,rtd1315e-usb2phy
> +
> +  reg:
> +    items:
> +      - description: PHY data registers
> +      - description: PHY control registers
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  realtek,usb:
> +    description: The phandler of realtek dwc3 node

"phandler"? Except obvious typo, drop "The phandler of" and describe
what is it for.

> +    $ref: /schemas/types.yaml#/definitions/phandle

Anyway, it shouldn't be here. No, no.

> +
> +  realtek,mac:
> +    description: The phandler of dwc3 node
> +    $ref: /schemas/types.yaml#/definitions/phandle

NAK.

> +
> +  realtek,usb_ctrl:
> +    description: The phandler of usb power control node
> +    $ref: /schemas/types.yaml#/definitions/phandle

NAK for similar reasons (nothing here justifies it existence). Also, do
not use underscores in node names.

> +
> +  realtek,port-index:
> +    description: The index of USB 2.0 PHY
> +    $ref: /schemas/types.yaml#/definitions/uint32

No. No reason for this. You have reg.

> +
> +  realtek,phyN:
> +    description: The total amount of USB 2.0 PHY
> +    $ref: /schemas/types.yaml#/definitions/uint32

No. Compatible defines it.


> +
> +  phy0:
> +    description: The child node of PHY for the parameter v1.

??? Open other phy bindings and use them as example.

> +    type: object
> +    properties:
> +      realtek,phy-data-page0-size:
> +        description: PHY data page 0 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,phy-data-page0-addr:
> +        description: PHY data page 0 address
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,phy-data-page0-A00:
> +        description: PHY data page 0 value
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,phy-data-page1-size:
> +        description: PHY data page 1 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,phy-data-page1-addr:
> +        description: PHY data page 1 address
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,phy-data-page1-A00:
> +        description: PHY data page 1 value
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,phy-data-page2-size:
> +        description: PHY data page 2 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,phy-data-page2-addr:
> +        description: PHY data page 2 address
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,phy-data-page2-A00:
> +        description: PHY data page 2 value
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +      realtek,do-toggle:
> +        description: Do PHY parameter toggle when port status change
> +        type: boolean
> +
> +      realtek,check-efuse:
> +        description: Enable to fix PHY parameter from reading otp table
> +        type: boolean
> +
> +      realtek,use-default-parameter:
> +        description: Don't set parameter and use default value
> +        type: boolean
> +
> +      realtek,is-double-sensitivity-mode:
> +        description: Enable double sensitivity mode
> +        type: boolean
> +
> +      realtek,ldo-page0-e4-compensate:
> +        description: Adjust the PHY parameter for page 0 0xE4 for ldo mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,page0-e4-compensate:
> +        description: Adjust the PHY parameter for page 0 0xE4
> +          for efuse table v2
> +        $ref: /schemas/types.yaml#/definitions/uint32

I don't understand what's all this for. Most of these descriptions do
not explain anything except duplicating name of property.

> +
> +  phy0_data:
> +    description: The child node of PHY for parameter v2.

Even more question marks. We are getting close to what the hell is this
binding?

> +    type: object
> +    properties:
> +      realtek,page0-size:
> +        description: PHY data page 0 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,page0-data-A00:
> +        description: PHY data page 0 address and value
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      realtek,page1-size:
> +        description: PHY data page 1 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,page1-data-A00:
> +        description: PHY data page 1 address and value
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      realtek,page2-size:
> +        description: PHY data page 2 size
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,page2-data-A00:
> +        description: PHY data page 2 address and value
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +      realtek,do-toggle:
> +        description: Do PHY parameter toggle when port status change
> +        type: boolean
> +
> +      realtek,do-toggle-driving:
> +        description: Do PHY parameter toggle for driving when port
> +          status change
> +        type: boolean
> +
> +      realtek,check-efuse:
> +        description: Enable to fix PHY parameter from reading otp table
> +        type: boolean
> +
> +      realtek,use-default-parameter:
> +        description: Don't set parameter and use default value
> +        type: boolean
> +
> +      realtek,is-double-sensitivity-mode:
> +        description: Enable double sensitivity mode
> +        type: boolean
> +
> +      realtek,ldo-force-enable:
> +        description: Force enable ldo mode
> +        type: boolean
> +
> +      realtek,ldo-page0-e4-compensate:
> +        description: Adjust the PHY parameter for page0 0xE4 for ldo mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      realtek,page0-e4-compensate:
> +        description: Adjust the PHY parameter for page0 0xE4
> +          for efuse table v2
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dwc3_u3drd_usb2phy: dwc3_u3drd_usb2phy@98013e14 {

You must be joking with the node name.

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Make it proper DTS, not some downstream unacceptable code.

> +        compatible = "realtek,usb2phy";
> +        reg = <0x98013e14 0x4>, <0x98058280 0x4>;
> +        #phy-cells = <0>;
> +        status = "okay";

Drop.

> +        realtek,phyN = <1>;
> +
> +        phy0 {

Why not phy9999?

> +            realtek,phy-data-page0-size = <16>;
> +            realtek,phy-data-page0-addr = /bits/ 8
> +                <0xE0 0xE1 0xE2 0xE3 0xE4 0xE5 0xE6 0xE7 0xF0 0xF1

lowercase hex

> +                0xF2 0xF3 0xF4 0xF5 0xF6 0xF7>;
> +            realtek,phy-data-page0-A00 = /bits/ 8
> +                <0xE0 0x30 0x79 0x8D 0x6A 0x65 0x01 0x71 0xFC 0x8C
> +                0x00 0x11 0x9B 0x00 0x00 0x0A>;
> +            realtek,phy-data-page0-B00 = /bits/ 8
> +                <0x18 0x30 0x79 0x8D 0x6A 0x65 0x01 0x71 0xFC 0x8C
> +                0x00 0x11 0x9B 0x00 0x00 0x32>;
> +            realtek,phy-data-page1-size = <8>;
> +            realtek,phy-data-page1-addr = /bits/ 8
> +                <0xE0 0xE1 0xE2 0xE3 0xE4 0xE5 0xE6 0xE7>;
> +            realtek,phy-data-page1-A00 = /bits/ 8
> +                <0x25 0xEF 0x60 0x44 0x00 0x0F 0x18 0xE3>;
> +            realtek,phy-data-page2-size = <1>;
> +            realtek,phy-data-page2-addr = /bits/ 8
> +                <0xE0>;
> +            realtek,phy-data-page2-A00 = /bits/ 8
> +                <0x01>;
> +            realtek,do-toggle;
> +            realtek,check-efuse;
> +            realtek,is-double-sensitivity-mode;
> +            realtek,ldo-page0-e4-compensate = <(-2)>;
> +        };
> +    };
> +
> +  - |
> +    usb_port0_usb2phy: usb_port0_usb2phy@13214 {
> +        compatible = "realtek,usb2phy";
> +        reg = <0x13214 0x4>, <0x28280 0x4>;
> +        #phy-cells = <0>;
> +        realtek,usb = <&usb_port0>;
> +        realtek,mac = <&port0_dwc3>;
> +        realtek,usb_ctrl = <&usb_ctrl>;
> +
> +        realtek,port-index = <0>;
> +        realtek,phyN = <1>;
> +        phy0_data {
> +            realtek,page0-size = <16>;
> +            realtek,page0-data-A00 = /* < addr data > */
> +                    <0xE0 0xA3>, <0xE4 0xB2>, <0xE5 0x4F>, <0xE6 0x42>;
> +            realtek,page1-size = <8>;
> +            realtek,page1-data-A00 = <0xE3 0x64>;
> +            realtek,page2-size = <8>;
> +            realtek,page2-data-A00 = <0xE7 0x45>;
> +            realtek,do-toggle;
> +            realtek.do-toggle-driving;
> +            realtek,disconnect-driving-updated = <0x8>;
> +            realtek,check-efuse;
> +            realtek,is-double-sensitivity-mode;
> +            realtek,ldo-force-enable;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> new file mode 100644
> index 000000000000..2d2543acfb5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> @@ -0,0 +1,201 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/realtek,usb3phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC SoCs USB3 PHY
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description: |
> +  Realtek USB 3.0 PHY support the digital home center (DHC) RTD series SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,usb3phy
> +      - realtek,rtd-usb3phy
> +      - realtek,rtd1295-usb3phy
> +      - realtek,rtd1619-usb3phy
> +      - realtek,rtd1319-usb3phy
> +      - realtek,rtd1619b-usb3phy
> +      - realtek,rtd1319d-usb3phy

Does not make sense...
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0

One huge NAK for these bindings. It looks like copy-paste from
downstream stuff which should never be sent as is to upstream. I am
sorry for being harsh, but amount of questions, coding and naming
styles, incorrect choices is just too big to handle in one review.

Best regards,
Krzysztof

