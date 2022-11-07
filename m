Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DC61FA1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKGQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKGQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:39:17 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED2218;
        Mon,  7 Nov 2022 08:39:15 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 285CF20002;
        Mon,  7 Nov 2022 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667839154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1y0s8VQyRRPKoR290AvBHMmKC1XvfiLfyXZ/t0ndQtc=;
        b=CNYxkGV/NcHfsVKZW9py4VEQNd5Q7qgOA2FmKb8BMkQWOmRaMSg0qOHZ5ET/Zuur+EIJP3
        DR1YJK+Xffm5Ug1EcFMTE6VQJ9C01M2TP4GgUWyhfvwQJmbmAPk75YRfq0dV5CyUtV21LA
        MYIerceEF3t2EX/SL+gwQpjc0jdxQeXCBygeZnnE9nByDEZyJvq4efG5+1+7SwjsjABKux
        XP/TU9PvZxYp3w4E8AFlx0goElOaVbi9UK+2245slTIecZm+9DBZoWq0zhHjzPQUHPA9O5
        +aQSjGEHgC65aF5qCUfLrzjoYACY0zhpqvmwdutYlCDKtdBS5vJqalDmXM67NA==
Date:   Mon, 7 Nov 2022 17:39:09 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
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
Subject: Re: [PATCH 7/7] MAINTAINERS: add the Renesas RZ/N1 USBF controller
 entry
Message-ID: <20221107173909.24ef160c@bootlin.com>
In-Reply-To: <CAMuHMdVip_e7dZ2P7sv1OH+P48dQyjnmsJBoATHLAqzPEcwDdw@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-8-herve.codina@bootlin.com>
        <CAMuHMdVip_e7dZ2P7sv1OH+P48dQyjnmsJBoATHLAqzPEcwDdw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Geert,

On Mon, 7 Nov 2022 15:42:49 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 3:00 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > After contributing the driver, add myself as the maintainer
> > for Renesas RZ/N1 USBF controller.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17627,6 +17627,14 @@ S:     Maintained
> >  F:     Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> >  F:     drivers/rtc/rtc-rzn1.c
> >
> > +RENESAS RZ/N1 USBF CONTROLLER DRIVER
> > +M:     Herve Codina <herve.codina@bootlin.com> =20
>=20
> Herv=C3=A9?

Just to be consistent with other places, I keep "Herve" :)

>=20
> > +L:     linux-renesas-soc@vger.kernel.org
> > +L:     linux-usb@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/usb/renesas,usbf.yaml
> > +F:     drivers/usb/gadget/udc/renesas_usbf.c
> > +
> >  RENESAS R-CAR GEN3 & RZ/N1 NAND CONTROLLER DRIVER
> >  M:     Miquel Raynal <miquel.raynal@bootlin.com>
> >  L:     linux-mtd@lists.infradead.org =20
>=20
> Up to you, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
