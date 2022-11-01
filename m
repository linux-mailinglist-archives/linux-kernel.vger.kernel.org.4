Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F94614AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKAMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKAMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:39:58 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA64DC3;
        Tue,  1 Nov 2022 05:39:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 08310DFD80;
        Tue,  1 Nov 2022 05:39:56 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n8xqYZIp4340; Tue,  1 Nov 2022 05:39:55 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:38:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1667306394; bh=8pSgzIaLQUUfbOme6bXDDC/enrDA6us6WNpJ2EgyvtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nO2VBvvK+96us5sgtdwcOe6qTN5aDqfwOsD9TEzSxgZOQKUyxdh5J71mH/hEpZeUt
         HAGcMuncdAfi+NyjIHUPhxT7jpzXKtV+oF8Jb9TYqEYQV9yxbukyyHhYlQziafhIsI
         SinXXDrPEogVQQ2IaDtdbMGwK2VC2m4tvLbNFeDkPkK5bYY/NjH/f+GscGYMMW+Njy
         U8jlEqm01Fh3QqrNAmjIbeyWjctHY9317sKvFa5JjV3dVQN4WKYPGKektd0zLBwNZR
         2ZU9ZrPrXIfP8hsdq8nourjVDZ/kNFLlv565tw7+XHfj52s5b86FC/esKfpS43WDBj
         SwOImfPtjRiYQ==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCHv3 1/1 RESEND] media: imx: Round line size to 4 bytes
Message-ID: <20221101133834.0c1a20db.dorota.czaplejewicz@puri.sm>
In-Reply-To: <20221017163059.377ac677.dorota.czaplejewicz@puri.sm>
References: <20221016163928.1ef0a4fe.dorota.czaplejewicz@puri.sm>
        <Y00SSRMFuL3Drjd4@pendragon.ideasonboard.com>
        <20221017163059.377ac677.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yFuW051.LWjJmsi2ZVzB1l6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yFuW051.LWjJmsi2ZVzB1l6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Oct 2022 16:30:59 +0200
Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm> wrote:

> Hi,
>=20
> On Mon, 17 Oct 2022 11:28:57 +0300
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
>=20

[snip]

> > I would also very much appreciate feedback from NXP on this. There's a
> > risk of ill side-effects that I would prefer ruling out very clearly. =
=20
>=20
> I posted a question on the NXP forum: https://community.nxp.com/t5/i-MX-P=
rocessors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p/153862=
9#M196448
>=20

This question received a reply from NXP today: https://community.nxp.com/t5=
/i-MX-Processors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p=
/1546872/highlight/true#M197067

Quoting NXP's answer:

> Do I understand correctly, that streams divisible by 4=C3=974 will work o=
n other i.MX8 hardware too? - Yes
> Will those kind of resolutions work on i.MX7 series CSI hardware? - Yes

which implies no bad side effects the way I read it. Is this sufficient for=
 the kernel?

Cheers,
Dorota

> >  =20
> > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > ---
> > > Hello,
> > >=20
> > > the Librem 5 is using an out-of-tree driver for s5k3l6xx, and roundin=
g to 4 is optimal to operate it.
> > >=20
> > > This revision improves the commit message.
> > >=20
> > > Cheers,
> > > Dorota Czaplejewicz
> > >=20
> > >  drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/sta=
ging/media/imx/imx7-media-csi.c
> > > index a0553c24cce4..af821b410c3f 100644
> > > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > > @@ -999,10 +999,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(struct =
v4l2_pix_format *pix,
> > >  	}
> > > =20
> > >  	/* Round up width for minimum burst size */
> > > -	width =3D round_up(mbus->width, 8);
> > > +	width =3D round_up(mbus->width, 4);
> > > =20
> > >  	/* Round up stride for IDMAC line start address alignment */
> > > -	stride =3D round_up((width * cc->bpp) >> 3, 8);
> > > +	stride =3D round_up((width * cc->bpp) >> 3, 4);
> > > =20
> > >  	pix->width =3D width;
> > >  	pix->height =3D mbus->height;   =20
> >  =20
>=20


--Sig_/yFuW051.LWjJmsi2ZVzB1l6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmNhE0oACgkQADBpX4S8
Zndgig/+NUo8ob5DtHGxljZKFEQIJLIQ1MtT+2F01irA6OSs/6aq6eeK+QCRDBxG
z4/cmsPmg/297ysGdIgHaXt3bS2hnpKMy0fbEFAptLrLcJoxJ1/8PC+4bjdtyniv
cWGI7C2HmOJAzXzly0jJlB9neeSNAu0U0nEx3R5oYVTXY5voKMHf02G2hPtBIxj0
pe4zN7g+9sSaCFSOmdRkUizv26tIjGkgQDdljfC9pkOj4xl/DoGsA7nrJHlZB/vI
/eafm/LQg4oqQ/zgB1GmnbJFqQQh1w8TJyYl+81yRqUAeJKqEIv4MKeojYlqFSFW
uC4z62K/sHp02J/KXL9qxpwe+uEo1mtD3h/xQIY2kILKtP/mmRzk+tcoIqM0ojsh
a7rmPT6yb49gfJFdjF3Q0eRkqm7bw6ZnVwzAwuWeXH42/Nx4svB7T4GBfJ0XulrX
RPBa2o83QdEMcUqOfsD9HkVD3OkwCof7ADB6jAxenPnhhjClnGjFhcvHkvFUJpsG
aSMYr8HT1UqFGam1d5P/lZeh0J2g/E1tqT0cb8pzRsNvnjSZAFWJjO99QEHocMiG
Gg2hs+V9wbm32rlwurkZ+dyDzD370QVPL5yIK4WG0X0NAS9Hp9lYmVyKFXSRU0MZ
Y7CdMqCQxGBftfPixDbm2nHuFBrx0wksX3BtxIPb1HTMOvaGBPI=
=WMeo
-----END PGP SIGNATURE-----

--Sig_/yFuW051.LWjJmsi2ZVzB1l6--
