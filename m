Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40C5B39B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiIINq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIINqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:46:45 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400813A07C;
        Fri,  9 Sep 2022 06:46:28 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 34A74100018;
        Fri,  9 Sep 2022 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662731127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyLP9CmLkcl1bGVvXClRy+vUMLTzbqd++Vuh487Ocsk=;
        b=oMQznvKITh0Ti9IbYYaYWltTgRzj0erZ3nEh9JkMg6qA15h7sYxX2EF65aX3mmzXRk293A
        +HG/yTf4Ni6GyAQhiTSga94vVXPypRU6YO2dhOEmwKHjvW4e2RgJ3KykvbG5+Bq6X6jEyI
        ETn2U854M/fwiHLSqxO073gW3IDHfUl91R5HlwCyyDUkoWQXj3QTvpo/f4V2OkdEO1k/10
        bne2wy20JT4FwGDoRvu6Hgc908GM9EdRIGphOPZSOQg72KwYQSDcZjHKR+y2bA3lG1EXtq
        0qI8UeLQNX17RDT/fOShMmUi6fowMDBGKoJpGYSEechAQ5GW/WD2J94Mm+AYNg==
Date:   Fri, 9 Sep 2022 15:45:19 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/6] ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller
 node
Message-ID: <YxtDb/jrR7uMabs5@aptenodytes>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-6-paul.kocialkowski@bootlin.com>
 <YwkYKcffdRGnq+pK@pendragon.ideasonboard.com>
 <YxC7+Pi4v3Bc1oXc@aptenodytes>
 <YxC/3KLfJHpld+jx@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0g1R3vKr/uSZfMdm"
Content-Disposition: inline
In-Reply-To: <YxC/3KLfJHpld+jx@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0g1R3vKr/uSZfMdm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Thu 01 Sep 22, 17:21, Laurent Pinchart wrote:
> On Thu, Sep 01, 2022 at 04:04:40PM +0200, Paul Kocialkowski wrote:
> > Hi Laurent,
> >=20
> > On Fri 26 Aug 22, 21:59, Laurent Pinchart wrote:
> > > Hi Paul,
> > >=20
> > > Thank you for the patch.
> > >=20
> > > On Fri, Aug 26, 2022 at 08:28:02PM +0200, Paul Kocialkowski wrote:
> > > > MIPI CSI-2 is supported on the A83T with a dedicated controller that
> > > > covers both the protocol and D-PHY. It can be connected to the CSI
> > > > interface as a V4L2 subdev through the fwnode graph.
> > > >=20
> > > > This is not done by default since connecting the bridge without a
> > > > subdev attached to it will cause a failure on the CSI driver.
> > >=20
> > > No urgency, but would it be possible to fix this so that the CSI-2
> > > receiver can be connected to the CSI unconditionally in DT ? The
> > > connection exists at the hardware level in the SoC, and should thus
> > > exist here too, regardless of whether or not a sensor is connected.
> >=20
> > Yes it's true that having the link always would be legitimate.
> >=20
> > For the context, this CSI controller can be switched between the MIPI C=
SI-2
> > controller and a parallel sensor input (i.e. it's not dedicated to one =
or the
> > other like on the V3).
> >=20
> > Last time I tried, having the connection between the two always there r=
esulted
> > in the unability to use a parallel sensor when no sensor is attached to=
 the
> > mipi csi-2 receiver. Probably because the async notifier never complete=
s since
> > the mipi csi-2's subdev is never registered without a sensor subdev att=
ached.
> >=20
> > Do you see a way to handle this case properly?
>=20
> It sounds like an issue in the CSI-2 receiver driver. If there's no
> input device attached to it, it should register its subdev directly,
> without its own async notifier.

Yes it turns out there was an error on that side, thanks for bringing it up!
I have sent a fixup series which takes care of it.

Now it becomes possible to always describe the links without downsides.
Well, the CSI driver will still wait for the MIPI CSI-2 bridge's subdev
when its node is enabled in device-tree, but I think that is expected.

Cheers,

Paul

> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/=
sun8i-a83t.dtsi
> > > > index 82fdb04122ca..ecf9f3b2c0c0 100644
> > > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > > @@ -1064,6 +1064,32 @@ csi: camera@1cb0000 {
> > > >  			status =3D "disabled";
> > > >  		};
> > > > =20
> > > > +		mipi_csi2: csi@1cb1000 {
> > > > +			compatible =3D "allwinner,sun8i-a83t-mipi-csi2";
> > > > +			reg =3D <0x01cb1000 0x1000>;
> > > > +			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			clocks =3D <&ccu CLK_BUS_CSI>,
> > > > +				 <&ccu CLK_CSI_SCLK>,
> > > > +				 <&ccu CLK_MIPI_CSI>,
> > > > +				 <&ccu CLK_CSI_MISC>;
> > > > +			clock-names =3D "bus", "mod", "mipi", "misc";
> > > > +			resets =3D <&ccu RST_BUS_CSI>;
> > > > +			status =3D "disabled";
> > > > +
> > > > +			ports {
> > > > +				#address-cells =3D <1>;
> > > > +				#size-cells =3D <0>;
> > > > +
> > > > +				mipi_csi2_in: port@0 {
> > > > +					reg =3D <0>;
> > > > +				};
> > > > +
> > > > +				mipi_csi2_out: port@1 {
> > > > +					reg =3D <1>;
> > > > +				};
> > > > +			};
> > > > +		};
> > > > +
> > > >  		hdmi: hdmi@1ee0000 {
> > > >  			compatible =3D "allwinner,sun8i-a83t-dw-hdmi";
> > > >  			reg =3D <0x01ee0000 0x10000>;
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--0g1R3vKr/uSZfMdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMbQ28ACgkQ3cLmz3+f
v9HuxQf/URHJvX9hyDkHJd/fZD6Tl0GkdanL5dUdysUgnQe+i1ceqqoOGzF+ZJpW
mv+Rbum00q/RE6nm+lGpFT2ig1SYGuOCxnZrbsXZiSvSzZ8+YY/cB6sRm+ywP7Go
QbVk+I+bEky7qtcKIWa3guNbtFBLm3rixBZ6CmjKnxdTXh6vN9lJlTMbbui0pffQ
k1QuoQ1Ea9AK7Rxyc4tWIIGK9Ljn96j7cHKqW1/Bi5FQyqDtFWgvwQGA4eiOxWOj
RrkwZH7D28Z1mHgUO6Mc8O+z/t2AzE3VvD7hcxt1RtNh1Un6t3YS4I9d6LSNCDyH
ylFJhr0z42NWy3mkaxagW6QSEaVn1A==
=jCke
-----END PGP SIGNATURE-----

--0g1R3vKr/uSZfMdm--
