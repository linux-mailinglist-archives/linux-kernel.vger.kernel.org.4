Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630D742AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjF2Qm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjF2Qm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:42:26 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42130DD;
        Thu, 29 Jun 2023 09:42:23 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-34568286979so3976655ab.2;
        Thu, 29 Jun 2023 09:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056943; x=1690648943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRWy3i6pbeNlRXNAD1TtP6TYXEvbi4bC2/D/Non/65w=;
        b=Z3+zQlidyDDk1Sxokbib6GgCqm6kidBCsraKl/y2XrNPGyolXNbP5Fy1Qri1ofgqdp
         eLGjsgUvrkdHZVw5i4zzBNPEp/dQJxhODQ593SrxUMKZEMpzaDk+Xhcgv9pcWk8+Ni/F
         cj0jP8tyAZTjTwxSvt+h3gN9fSNnCEF2jY5727+JPTWvWnvdvNA+byoF02BcvLDSb41/
         IoEXuLrEsGYLe2dc1BAbJTePMhQz6DKlXAZilK2sxMHXhG31egvo8huyt4goC4+dJo0D
         0RyR+QDrBIe7Iq/DbM+O/xqQ/q8OpNoSwSeLQgHO+4l5cBdCQscjNur2ZV808S/ly9dq
         Q1fw==
X-Gm-Message-State: AC+VfDzKt0X6xtPcA+FEQOU4/qTglR5B/KPb5hRQFdx/PxI2mJ9Y3KEi
        zlEV9vVTdLvoJy/8/8FIiQ==
X-Google-Smtp-Source: ACHHUZ7M99eTAmUw4XoU5ZkgjxBk1JtUJxqFkrmyUDW3gTIetju8FtlPY8j8oAevFgTFYsWNosN0qw==
X-Received: by 2002:a92:d947:0:b0:345:6ce1:d255 with SMTP id l7-20020a92d947000000b003456ce1d255mr14874073ilq.1.1688056942890;
        Thu, 29 Jun 2023 09:42:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u10-20020a92da8a000000b00345b0111f91sm2512841iln.36.2023.06.29.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:42:22 -0700 (PDT)
Received: (nullmailer pid 3167869 invoked by uid 1000);
        Thu, 29 Jun 2023 16:42:20 -0000
Date:   Thu, 29 Jun 2023 10:42:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Message-ID: <20230629164220.GA3146341-robh@kernel.org>
References: <20230629054523.7519-1-stanley_chang@realtek.com>
 <20230629054523.7519-4-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629054523.7519-4-stanley_chang@realtek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:45:12PM +0800, Stanley Chang wrote:
> Add the documentation explain the property about Realtek USB PHY driver.

In the subject, drop "the doc about the". It's redundant. And perhaps 
add 'DHC RTD SoC' if this isn't for *all* Realtek SoCs.

> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 2.0 PHY transceivers.

driver? This is a binding for the h/w.

> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v5 to v6 change:
>     Drop the redundant examples
>     Drop the label of example
> v4 to v5 change:
>     1. Add more examples.
>     2. Remove the compatible realtek,usb2phy.
>     3. Revise the descriptor of the property.
>     4. Add the default of the property.
> v3 to v4 change:
>     1. Remove the parameter and non hardware properties from dts.
>     2. Using the compatible data included the config and parameter
>        in driver.
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3.
>     2. Add more description about Realtek RTD SoCs architecture.
>     3. Removed parameter v1 support for simplification.
>     4. Revised the compatible name for fallback compatible.
>     5. Remove some properties that can be set in the driver.
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb2phy.yaml         | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> new file mode 100644
> index 000000000000..773663bf5c62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> @@ -0,0 +1,153 @@
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

You need '|' if formatting (line breaks) are important.

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
> +    enum:
> +      - realtek,rtd1295-usb2phy
> +      - realtek,rtd1312c-usb2phy
> +      - realtek,rtd1315e-usb2phy
> +      - realtek,rtd1319-usb2phy
> +      - realtek,rtd1319d-usb2phy
> +      - realtek,rtd1395-usb2phy
> +      - realtek,rtd1395-usb2phy-2port
> +      - realtek,rtd1619-usb2phy
> +      - realtek,rtd1619b-usb2phy
> +
> +  reg:
> +    items:
> +      - description: PHY data registers
> +      - description: PHY control registers
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Phandles to nvmem cell that contains the trimming data.
> +      If unspecified, default value is used.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: usb-dc-cal
> +      - const: usb-dc-dis
> +    description:
> +      The following names, which correspond to each nvmem-cells.
> +      usb-dc-cal is the driving level for each phy specified via efuse.
> +      usb-dc-dis is the disconnection level for each phy specified via efuse.
> +
> +  realtek,inverse-hstx-sync-clock:
> +    description:
> +      For one of the phys of RTD1619b SoC, the synchronous clock of the
> +      high-speed tx must be inverted.

"invert" assumes I know what non-inverted means. I do not. Better to 
state in terms of active high, low, falling edge, rising edge, etc.

> +    type: boolean
> +
> +  realtek,driving-level:
> +    description:
> +      Control the magnitude of High speed Dp/Dm output swing.
> +      For a different board or port, the original magnitude maybe not meet
> +      the specification. In this situation we can adjust the value to meet
> +      the specification.

What are the units?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 8
> +    minimum: 0
> +    maximum: 31
> +
> +  realtek,driving-compensate:

compensate what?

> +    description:
> +      For RTD1315e SoC, the driving level can be adjusted by reading the
> +      efuse table. This property provides drive compensation.
> +      If the magnitude of High speed Dp/Dm output swing still not meet the
> +      specification, then we can set this value to meet the specification.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    default: 0
> +    minimum: -8
> +    maximum: 8
> +
> +  realtek,disconnection-compensate:
> +    description:
> +      This adjusts the disconnection level compensation for the different
> +      boards with different disconnection level.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    default: 0
> +    minimum: -8
> +    maximum: 8
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
> +    usb-phy@13214 {
> +        compatible = "realtek,rtd1619b-usb2phy";
> +        reg = <0x13214 0x4>, <0x28280 0x4>;
> +        #phy-cells = <0>;
> +        nvmem-cells = <&otp_usb_port0_dc_cal>, <&otp_usb_port0_dc_dis>;
> +        nvmem-cell-names = "usb-dc-cal", "usb-dc-dis";
> +
> +        realtek,inverse-hstx-sync-clock;
> +        realtek,driving-level = <0xa>;
> +        realtek,driving-compensate = <(-1)>;
> +        realtek,disconnection-compensate = <(-1)>;
> +    };
> -- 
> 2.34.1
> 
