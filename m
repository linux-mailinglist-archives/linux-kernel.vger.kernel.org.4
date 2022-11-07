Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B161F68F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiKGOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKGOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:50:32 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E01A814;
        Mon,  7 Nov 2022 06:50:30 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 484F22000E;
        Mon,  7 Nov 2022 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667832628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nWmi3ii7x3WPKoN+LQdOffXG0P9SWHJIeAG6ssV3Nw=;
        b=Nh7GaufyKfCK5CNBBtQ8hREFvqONuUGqxOiumbwo5CgoE7PADRX0dNcp1yUGS38IOv0CQ0
        ShEGxbWvYJdClFeFm0a4n4ja4sKgspMafS7fVtLERJk7d51m5/HCd0y2FGN+lJZfnVSNUO
        BPQhlIZZgjhv0GiONa3YXT0z4oc8cRtse6/7ufpIIJppAD6VphSqllxEjpkyXQnz9vEInt
        wU0FIVywoFotRkif5ZTBSyyLwEIJ5oI7AVtVit2zhyrRnHdG787SjCOnvVENIdurgQQNrC
        Ewj0/JLjNxBzJJIk3+Rd4LX+h+3Uv4dNi7D3qzUyv8nHMGWHXlcuydkUbiNiJw==
Date:   Mon, 7 Nov 2022 15:50:23 +0100
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
Subject: Re: [PATCH 4/7] dt-bindings: usb: add the Renesas USBF controller
 binding
Message-ID: <20221107155023.278120f2@bootlin.com>
In-Reply-To: <CAMuHMdX9WBxkrQRV6yEXmJdj3qQ9Ne4W0xmiGDEC6j=R_ARgsQ@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-5-herve.codina@bootlin.com>
        <CAMuHMdX9WBxkrQRV6yEXmJdj3qQ9Ne4W0xmiGDEC6j=R_ARgsQ@mail.gmail.com>
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

On Mon, 7 Nov 2022 15:26:43 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 3:00 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > The Renesas USBF controller is an USB2.0 device controller
> > (UDC) available in Renesas r9a06g032 SoC (RZ/N1 family).
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
[...]
> > +maintainers:
> > +  - Herve Codina <herve.codina@bootlin.com> =20
>=20
> Herv=C3=A9? ;-)

Sure, you're right but in all my commits, signed-off-by and
other places where my email appears, I spell Herv=C3=A9 as "Herve"
So, to be consistent and avoid future confusion, I prefer
to keep Herve here.

>=20
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
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
> > +      - description: Internal bus clock (AHB) for Power Management
> > +  clock-names:
> > +    items:
> > +      - const: hclkf
> > +      - const: hclkpm =20
>=20
> power-domains?

Will be added in v2.

Thanks for the review,
Herv=C3=A9
