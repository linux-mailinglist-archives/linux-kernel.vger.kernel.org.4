Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DA701FA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjENVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjENVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:04:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2210DF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:04:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyIsh-0008IM-NV; Sun, 14 May 2023 23:03:51 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2BF241C3D1B;
        Sun, 14 May 2023 20:09:51 +0000 (UTC)
Date:   Sun, 14 May 2023 22:09:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Harald Mommer <harald.mommer@opensynergy.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
Subject: Re: [RFC PATCH v3] can: virtio: Initial virtio CAN driver.
Message-ID: <20230514-senior-container-bf049eb882a9-mkl@pengutronix.de>
References: <20230511151444.162882-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <CAMZ6RqJbjoApwZbiivbvJRYQyBWfWXG4azmwuXGaicrMq0Lozg@mail.gmail.com>
 <a83e29fd-09d0-64b4-ce56-c7f7a5e44f66@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6qfmmn4wmyaeefb"
Content-Disposition: inline
In-Reply-To: <a83e29fd-09d0-64b4-ce56-c7f7a5e44f66@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6qfmmn4wmyaeefb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.05.2023 19:39:40, Harald Mommer wrote:
> > > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > > index ff8f76295d13..19314adaff59 100644
> > > --- a/drivers/net/can/Makefile
> > > +++ b/drivers/net/can/Makefile
> > > @@ -17,8 +17,8 @@ obj-$(CONFIG_CAN_AT91)                +=3D at91_can=
=2Eo
> > >   obj-$(CONFIG_CAN_BXCAN)                +=3D bxcan.o
> > >   obj-$(CONFIG_CAN_CAN327)       +=3D can327.o
> > >   obj-$(CONFIG_CAN_CC770)                +=3D cc770/
> > > -obj-$(CONFIG_CAN_C_CAN)                +=3D c_can/
> > >   obj-$(CONFIG_CAN_CTUCANFD)     +=3D ctucanfd/
> > > +obj-$(CONFIG_CAN_C_CAN)                +=3D c_can/
> > This reordering is unrelated to this patch goal. Please send it as a
> > separate patch.
>=20
> @Marc Kleine-Budde: We got this reordering change from you.

That reordering was not intended.

> How to proceed?

Remove that change and sorry for the confusion.

> We can split this in 2 commits, reordering and on top adding virtio CAN. =
No
> issue, a question of minutes and done. Fine. But here the word "patch" was
> used, not the word "commit".

I think in first approximation patches and commits can be/are used
interchangeably :) (One thought process might be: If you make it a
separate commit and send it here, it's no longer in git and thus just a
patch, no longer a commit.)

> Sending a separate patch to somewhere? Maybe
> Mikhail does this fight to get this in (unlikely), I personally would pre=
fer
> to run away. Or we don't reorder at all, wrong ordering remains and we wi=
ll
> not make only you unhappy.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--i6qfmmn4wmyaeefb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRhQAsACgkQvlAcSiqK
BOiLrwf+MivjvW3UCXg71VmfmbA3FMZQOYEREO80Bd/GD1zKMbD3PtaN/jFo2bHo
kYXOW4N67y4TYbwHFVoY4wYzzv+1OSfUzVc5xYgYbcGzBBxS80zmGlvMpEmI4H2z
50XyMbZVBZOhxUrAvfQc40KY05IIoSWnkT1ReBN7nmYtm+FK0Ctpww1jgmyGK9/G
9W0ZoIOfmoQWXSTp7KtocxpUWNiU4uCgZYFt9I5bNag/qZDztgjVTFbct1lCYejs
jvNjWvWqXPneFd1B1I6Tca3zup1hTKTpT2C6uOZ1/GcN8GWoIbLdNtBZYIHnnlXg
IhaMq27QJd3111vs57wiCmwwyWcZXQ==
=kAT9
-----END PGP SIGNATURE-----

--i6qfmmn4wmyaeefb--
