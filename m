Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AC71035B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjEYDhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEYDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:37:29 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C7A186;
        Wed, 24 May 2023 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xlDhquQP7khL3b8wtZ40xgVAOHpND88MK/6+rMuT5pE=; b=WtWe7YNaR6bmOmJzZG2nout/vy
        9ox+rL0MLVHqrAlkVcPgBsSqRN7YSefQiSTtIFXT+OOzE9eT2jhDEQPcikVDuodpIcjbvyLNDI7Ry
        dYMk9OWiEo3fN+bOdkTQaGYc49kY9AOSfClKjrQtVdFshfB5vxjn+s1tg8k0EL3romTw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57496 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q21mu-0001Dv-W9; Wed, 24 May 2023 23:37:17 -0400
Date:   Wed, 24 May 2023 23:37:16 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230524233716.b433edc0fe4afc519976bcea@hugovil.com>
In-Reply-To: <1e4e6886-70ed-2db3-23e1-b22bf2f39dc0@camlingroup.com>
References: <20230518132905.4182265-1-hugo@hugovil.com>
        <1e4e6886-70ed-2db3-23e1-b22bf2f39dc0@camlingroup.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: sc16is7xx: Add property to
 change GPIO function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 15:03:37 +0200
Lech Perczak <lech.perczak@camlingroup.com> wrote:

> Hello Hugo,
>=20
> W dniu 18.05.2023 o=A015:29, Hugo Villeneuve pisze:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Some variants in this series of uart controllers have GPIO pins that
> > are shared between GPIO and modem control lines.
> >
> > The pin mux mode (GPIO or modem control lines) can be set for each
> > ports (channels) supported by the variant.
> >
> > This adds a property to the device tree to set the GPIO pin mux to
> > modem control lines on selected ports if needed.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > v1 -> v2: Add nxp vendor prefix
> >           Add git base-commit
> >
> >  .../bindings/serial/nxp,sc16is7xx.txt         | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt=
 b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > index 0fa8e3e43bf8..23a81c83f012 100644
> > --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> > @@ -23,6 +23,9 @@ Optional properties:
> >      1 =3D active low.
> >  - irda-mode-ports: An array that lists the indices of the port that
> >                    should operate in IrDA mode.
> > +- nxp,modem-control-line-ports: An array that lists the indices of the=
 port that
> > +                               should have shared GPIO lines configure=
d as modem
> > +                               control lines.
> >
> >  Example:
> >          sc16is750: sc16is750@51 {
> > @@ -35,6 +38,17 @@ Example:
> >                  #gpio-cells =3D <2>;
> >          };
> >
> > +       sc16is752: sc16is752@54 {
> > +               compatible =3D "nxp,sc16is752";
> > +               reg =3D <0x54>;
> > +               clocks =3D <&clk20m>;
> > +               interrupt-parent =3D <&gpio3>;
> > +               interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> > +               nxp,modem-control-line-ports =3D <1>; /* Port 1 as mode=
m control lines */
> > +               gpio-controller; /* Port 0 as GPIOs */
> > +               #gpio-cells =3D <2>;
> > +       };
> > +
> >  * spi as bus
> >
> >  Required properties:
> > @@ -59,6 +73,9 @@ Optional properties:
> >      1 =3D active low.
> >  - irda-mode-ports: An array that lists the indices of the port that
> >                    should operate in IrDA mode.
> > +- nxp,modem-control-line-ports: An array that lists the indices of the=
 port that
> > +                               should have shared GPIO lines configure=
d as modem
> > +                               control lines.
> >
> >  Example:
> >         sc16is750: sc16is750@0 {
> > @@ -70,3 +87,14 @@ Example:
> >                 gpio-controller;
> >                 #gpio-cells =3D <2>;
> >         };
> > +
> > +       sc16is752: sc16is752@0 {
> > +               compatible =3D "nxp,sc16is752";
> > +               reg =3D <0>;
> > +               clocks =3D <&clk20m>;
> > +               interrupt-parent =3D <&gpio3>;
> > +               interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> > +               nxp,modem-control-line-ports =3D <1>; /* Port 1 as mode=
m control lines */
> Just a minor nitpick: an example showing syntax for both ports would be g=
reat.
> This can be included here, leaving the previous example intact. Otherwise=
, LGTM.
> > +               gpio-controller; /* Port 0 as GPIOs */
> > +               #gpio-cells =3D <2>;

Hi,
I have decided to add a separate example, because adding an example for bot=
h ports also means that the gpio-controller property should be removed.

Hugo.


> > +       };
> >
> > base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
> > --
> > 2.30.2
>=20
> --=20
> Pozdrawiam/With kind regards,
> Lech Perczak
>=20
> Sr. Software Engineer
> Camlin Technologies Poland Limited Sp. z o.o.
> Strzegomska 54,
> 53-611 Wroclaw
> Tel:     (+48) 71 75 000 16
> Email:   lech.perczak@camlingroup.com
> Website: http://www.camlingroup.com
>=20
>=20
