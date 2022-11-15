Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B658629A39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKON31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKON3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:29:24 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE8A39F;
        Tue, 15 Nov 2022 05:29:22 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7D9911BF20B;
        Tue, 15 Nov 2022 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668518961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJxvgQFewGeH+lNYexUEwtwmd3hrAmaAreqDAyyZF4A=;
        b=jIHayz5ZZavVsRHqyoB8Yd3ScdS1hDY8zfiK0mvDzh/MPwk6zb0wy7p5AXdhUOl/vbYC0Q
        a/218pWElmPCX3kr/Dt5ljqgcVwOtQMpcdL6bcMXgCTLw0yN00qU1J3V0hFKtF4Rj+L96g
        0Lysz4FdAb9acC+wnHQjk2YCE4Lps8FtHDy0lpxLUoArONyU7gJkcifqOnKvilgFvs+tx1
        08uSyOEFGiU8Dlu/tMT2zVdPQ5qDZrLFn7NOWbqIZF9NDxBWL3KhSTGfxaB6nebWraVcQ2
        qbBWAFVv9bTClvWMSLNrFUnvg5geAdq05oQppNOISzQL8dfR8avXKpQmi7bNUw==
Date:   Tue, 15 Nov 2022 14:29:17 +0100
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
Subject: Re: [PATCH v2 4/7] dt-bindings: usb: add the Renesas RZ/N1 USBF
 controller binding
Message-ID: <20221115142917.20c30f46@bootlin.com>
In-Reply-To: <a5d53378-51dc-a024-bbda-5dd03bbf37b3@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-5-herve.codina@bootlin.com>
        <a5d53378-51dc-a024-bbda-5dd03bbf37b3@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 14:13:00 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/11/2022 12:15, Herve Codina wrote:
> > The Renesas RZ/N1 USBF controller is an USB2.0 device controller
> > (UDC) available in the Renesas r9a06g032 SoC (RZ/N1 family). =20
>=20
> Subject: drop redundant, second "binding".
>=20
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/usb/renesas,rzn1-usbf.yaml       | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-=
usbf.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.ya=
ml b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> > new file mode 100644
> > index 000000000000..b67e9cea2522
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/renesas,rzn1-usbf.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/N1 SoCs USBF (USB Function) controller binding =20
>=20
> Drop "binding"
>=20
> With two above:
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof
>=20

"binding" will be dropped as suggested in v3.
Thanks for the review.

Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
