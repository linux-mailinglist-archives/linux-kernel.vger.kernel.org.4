Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12361FB4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiKGR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:26:51 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76323BEB;
        Mon,  7 Nov 2022 09:26:49 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A023C24000A;
        Mon,  7 Nov 2022 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667842007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zv+yUunUjsjy2ElQRsQJL+bVnY9BR/J89WhE/UA/CSM=;
        b=gGVonuLcssp6dLp7SlC1kwVDa35VVpmaTyA4BQ+tc43/U6b2FhrXPTp7Qw19hfxwslGtuB
        omk03iWiaTXKAl2+wbgcZ7mJJ1eDHuoKqKERRQIplI+QJg+vD5GjXb58ey3fmgSeGnwQx0
        fcnEap3BQkwsXWZj2menKRqe5BPjBahPjbAcgxQf5FxrviqgI5+vKFOlV+QDM0dmnD+4n9
        9wBd5FZwMHpVbhrY3wziYE1svF0mLr9+4lD+hKJ4JI37S4o+msPn/iutZ0+l0liDhRGLlU
        /hKEtywwQouaGOvt9AkiXbXr6RDJx+72CDSY6yti5y6gQ+rd+lW2yafzI51n7w==
Date:   Mon, 7 Nov 2022 18:26:42 +0100
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
Subject: Re: [PATCH 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Message-ID: <20221107182642.05a09f2f@bootlin.com>
In-Reply-To: <CAMuHMdXoyE+MP4N=5o6a=u83gcsYD_RijpjrYf15i5MR85gEJg@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-3-herve.codina@bootlin.com>
        <CAMuHMdXoyE+MP4N=5o6a=u83gcsYD_RijpjrYf15i5MR85gEJg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, 7 Nov 2022 16:14:10 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > Add the h2mode property to force the USBs mode ie:
> >  - 2 hosts
> > or
> >  - 1 host and 1 device
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl=
.yaml
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl=
.yaml
> > @@ -39,6 +39,16 @@ properties:
> >    '#power-domain-cells':
> >      const: 0
> >
> > +  renesas,h2mode:
> > +    description: |
> > +      Configure the USBs mode.
> > +        - <0> : the USBs are in 1 host and 1 device mode.
> > +        - <1> : the USBs are in 2 host mode.
> > +      If the property is not present, the value used is the one alread=
y present
> > +      in the CFG_USB register (from reset or set by the bootloader).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +
> >    '#address-cells':
> >      const: 1 =20
>=20
> While the H2MODE register bit is indeed located in the sysctrl's
> address space, and handling it here makes it simpler for the drivers
> (especially w.r.t. the default handling), this is really a property
> of the switchable usbh/f core...
> Perhaps it can be moved there? Or not?

Moving the property outside sysctrl (and so its handling) will not
be that easy especially if some more operations are needed (as you
mention in your patch 3/4 review).

Not sure about what is the best thing to do.
(a) Keep it simple and stay in sysctrl
  or
(b) Create an usb_role_switch driver.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds



--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
