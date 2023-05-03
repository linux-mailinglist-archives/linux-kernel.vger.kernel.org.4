Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9086F5A39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjECOiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjECOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:38:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11144ED2
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:38:18 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1puDc9-00088a-Id; Wed, 03 May 2023 16:37:53 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1E13E1BD106;
        Wed,  3 May 2023 14:37:45 +0000 (UTC)
Date:   Wed, 3 May 2023 16:37:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Hong <peter_hong@fintek.com.tw>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        wg@grandegger.com, Steen.Hegelund@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, frank.jungclaus@esd.eu,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V5] can: usb: f81604: add Fintek F81604 support
Message-ID: <20230503-companion-sincere-573fc8d234d8-mkl@pengutronix.de>
References: <20230420024403.13830-1-peter_hong@fintek.com.tw>
 <CAMZ6RqKWrtBMFSD=BzGuCbvj=+3X-A-oW9haJ7=4kyL2AbEuHQ@mail.gmail.com>
 <51991fc1-0746-608f-b3bb-78b64e6d1a3e@fintek.com.tw>
 <CAMZ6Rq+zsC4F-mNhjKvqgPQuLhnnX1y79J=qOT8szPvkHY86VQ@mail.gmail.com>
 <f9c007ae-fcfb-4091-c202-2c27e3ba1151@fintek.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zdnzbummcllnzbh"
Content-Disposition: inline
In-Reply-To: <f9c007ae-fcfb-4091-c202-2c27e3ba1151@fintek.com.tw>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zdnzbummcllnzbh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.05.2023 10:53:43, Peter Hong wrote:
> Hi Vincent, Michal and Marc,
>=20
> Vincent MAILHOL =E6=96=BC 2023/4/21 =E4=B8=8B=E5=8D=88 03:30 =E5=AF=AB=E9=
=81=93:
> > Hi Peter and Michal,
> >=20
> > On Fry. 21 Apr. 2023 at 12:14, Peter Hong <peter_hong@fintek.com.tw> wr=
ote:
> > > Hi Vincent,
> > >=20
> > > Vincent MAILHOL =E6=96=BC 2023/4/20 =E4=B8=8B=E5=8D=88 08:02 =E5=AF=
=AB=E9=81=93:
> > > > Hi Peter,
> > > >=20
> > > > Here are my comments. Now, it is mostly nitpicks. I guess that this=
 is
> > > > the final round.
> > > >=20
> > > > On Thu. 20 avr. 2023 at 11:44, Ji-Ze Hong (Peter Hong)
> > > > <peter_hong@fintek.com.tw> wrote:
> > > > > +static void f81604_handle_tx(struct f81604_port_priv *priv,
> > > > > +                            struct f81604_int_data *data)
> > > > > +{
> > > > > +       struct net_device *netdev =3D priv->netdev;
> > > > > +       struct net_device_stats *stats;
> > > > > +
> > > > > +       stats =3D &netdev->stats;
> > > > Merge the declaration with the initialization.
> > > If I merge initialization into declaration, it's may violation RCT?
> > > How could I change about this ?
> > @Michal: You requested RTC in:
> >=20
> > https://lore.kernel.org/linux-can/ZBgKSqaFiImtTThv@localhost.localdomai=
n/
> >=20
> > I looked at the kernel documentation but I could not find "Reverse
> > Chistmas Tree". Can you point me to where this is defined?
> >=20
> > In the above case, I do not think RCT should apply.
> >=20
> > I think that this:
> >=20
> >          struct net_device *netdev =3D priv->netdev;
> >          struct net_device_stats *stats =3D &netdev->stats;
> >=20
> > Is better than that:
> >=20
> >          struct net_device *netdev =3D priv->netdev;
> >          struct net_device_stats *stats;
> >=20
> >          stats =3D &netdev->stats;
> >=20
> > Arbitrarily splitting the definition and assignment does not make sense=
 to me.
> >=20
> > Thank you for your comments.
>=20
> The RCT coding style seems a bit confuse. How about refactoring of next
> step? @Marc ?

I don't are that much about RCT (so far my upstream has not complained).
Either of the above is fine with me.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2zdnzbummcllnzbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRScbUACgkQvlAcSiqK
BOg7fgf/Rcocbit+eYsSyvu1J/b+f2NEUYAwjDYH8JKZ3qY1jHq4uPsd81dYGTJA
MqBRikUZ9+9uIBf7oZPCapOYuVbSn8oRjphmRogLpJhos3xFOj9YyvK/ghypUbce
5Ywi7RI5VFeoSuxBYh/7uCyWB5dpGi59SUNXACijeBVva1cFluCvBeNVOJ98mAjV
oJp00jvJOtnsr8ARwxUWcM/y4N7N3276FQInKisfPCiiVPoec8xhplJRkr8kLcMB
aBsL29t4yy+5LTZJ4cE8GPS9sn1buJqnmKjKrLc1IWTsaWabv1QrKRKPx1SLK3ro
DeWlwoup2kKYXnccclJTGR6hmIlrhg==
=SrP+
-----END PGP SIGNATURE-----

--2zdnzbummcllnzbh--
