Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E016241BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKJLrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiKJLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:46:57 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3AB2CE2E;
        Thu, 10 Nov 2022 03:46:54 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 04A38C0003;
        Thu, 10 Nov 2022 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668080813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiAAdHYzbPaEDUFu+7SLegTpQrvPsJnBynesNdlRAi4=;
        b=Ut2WXe4mh9+0Aw40DQLRV1z7aqSkaAQZKgB/bxsSuoBJ2VuNjm9EItmXqVrXzCWs7rqhNH
        bHkxbrsbbtCB8t6WsARNZfqP2B8iBIC/ZqYCzljP80jdqDwSDJSX6mlCH3OBDk+mYpRVOg
        Cit3Z3zEVwv8+b3UiHDIChUDg3HSSOaWmvmxlGj5Y4ue8jfdRAx55FDlAyslcMI5/B0wMy
        FxffFMIbPC6vLRzvsAkRcOZbOD8w2XFxcfIRNmwGLNqcdrBNtv6Kxa2iThtDRWmQ5Hk/qv
        bGrY/bLV2UaoanZ4AAUMOxeNpKTTtUfn7Wbn+zuVhcTqqW3vrMCYCN4A8N61Ow==
Date:   Thu, 10 Nov 2022 12:46:42 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/7] dt-bindings: usb: add the Renesas USBF controller
 binding
Message-ID: <20221110124642.38bf5edf@bootlin.com>
In-Reply-To: <c10df12c-ccb9-03b7-96be-1aac5feee1aa@linaro.org>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-5-herve.codina@bootlin.com>
        <c10df12c-ccb9-03b7-96be-1aac5feee1aa@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 7 Nov 2022 19:24:01 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/11/2022 14:58, Herve Codina wrote:
> > The Renesas USBF controller is an USB2.0 device controller
> > (UDC) available in Renesas r9a06g032 SoC (RZ/N1 family).
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../devicetree/bindings/usb/renesas,usbf.yaml | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbf.=
yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/renesas,usbf.yaml b/=
Documentation/devicetree/bindings/usb/renesas,usbf.yaml
> > new file mode 100644
> > index 000000000000..f2b146d9d37b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/renesas,usbf.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/renesas,usbf.yaml# =20
>=20
> Filename based on compatible, so renesas,rzn1-usbf.yaml.

Will be fixed in the v2 series.

>=20
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas USBF (USB Function) controller binding
> > +
> > +description: |
> > +   The Renesas USBF controller is an USB2.0 device
> > +   controller (UDC).
> > +
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf: =20
>=20
> You have only one possibility, so oneOf is not needed. Unless you
> already predict it will grow with new incompatible lists?

No new compatible planned right now. So, oneOf will be removed
in the v2 series.

>=20
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a06g032-usbf
> > +          - const: renesas,rzn1-usbf
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Internal bus clock (AHB) for Function
> > +      - description: Internal bus clock (AHB) for Power Management =20
>=20
> Blank line

Will be fixed in the v2 series

>=20
> > +  clock-names:
> > +    items:
> > +      - const: hclkf
> > +      - const: hclkpm
> > +
> > +  interrupts:
> > +    items:
> > +      - description: The USBF EPC interrupt
> > +      - description: The USBF AHB-EPC interrupt
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
> > +
> > +    usb@4001e000 {
> > +        compatible =3D "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
> > +        reg =3D <0x4001e000 0x2000>;
> > +        interrupts =3D =20
>=20
> No need for line break. It's not helping in readability.

Will be fixed in the v2 series

>=20
>=20
> > +            <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> > +            <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&sysctrl R9A06G032_HCLK_USBF>,
> > +                 <&sysctrl R9A06G032_HCLK_USBPM>;
> > +        clock-names =3D "hclkf", "hclkpm";
> > +    }; =20
>=20
> Best regards,
> Krzysztof
>=20

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
