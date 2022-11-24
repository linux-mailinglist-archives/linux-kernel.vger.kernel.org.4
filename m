Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08C36378F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiKXMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:35:57 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2FD898E1;
        Thu, 24 Nov 2022 04:35:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3BD8DEC9DF;
        Thu, 24 Nov 2022 04:35:56 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oW5luY8rDfud; Thu, 24 Nov 2022 04:35:55 -0800 (PST)
Date:   Thu, 24 Nov 2022 13:35:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1669293355; bh=RgJG5Oidxh068x+5k52+UvIseZv630peSoQN5/PYCPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iFsi2/PVDljgfb1nr8mziG0gyeBx8cDqZjgkthRQ27i0jmfzIYDIGtzA3t9orfNZR
         uvXk9Aaax8wuxnLts44dS9tCrj8yEHC7mqP9u5ps8U6xdoiJV5NvdbU/cfKG58y2lX
         iKC9EE2Hmg4PJhv2r1OHdEYfi0VbXiM/gJYJ+3L4FNiUPeG9wM/UKjlXeZ5M2+SNAf
         zJnW49PpncLiAcPvxQslziVBetIFjqaeRFXwVwuj3PDg45NkKVl1VHcZVlyfTyHJ3j
         JWS6LDX/zLnCU/+RJDh2JtPZ2cCgQZjnPyKl0clE4ccOuB26ix/m1SYCzFN8DFjEb8
         et6ydzTNzp9tg==
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
Message-ID: <20221124133533.1041f1b1.dorota.czaplejewicz@puri.sm>
In-Reply-To: <Y39Vx6L7MovBxOfs@pendragon.ideasonboard.com>
References: <20221016163928.1ef0a4fe.dorota.czaplejewicz@puri.sm>
        <Y00SSRMFuL3Drjd4@pendragon.ideasonboard.com>
        <20221017163059.377ac677.dorota.czaplejewicz@puri.sm>
        <20221101133834.0c1a20db.dorota.czaplejewicz@puri.sm>
        <Y39Vx6L7MovBxOfs@pendragon.ideasonboard.com>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0w4EGCp0VVCKoSCDIxcxR1Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0w4EGCp0VVCKoSCDIxcxR1Z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 24 Nov 2022 13:30:15 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Dorota,
>=20
> On Tue, Nov 01, 2022 at 01:38:34PM +0100, Dorota Czaplejewicz wrote:
> > On Mon, 17 Oct 2022 16:30:59 +0200 Dorota Czaplejewicz wrote: =20
> > > On Mon, 17 Oct 2022 11:28:57 +0300 Laurent Pinchart wrote: =20
> >=20
> > [snip]
> >  =20
> > > > I would also very much appreciate feedback from NXP on this. There'=
s a
> > > > risk of ill side-effects that I would prefer ruling out very clearl=
y.   =20
> > >=20
> > > I posted a question on the NXP forum: https://community.nxp.com/t5/i-=
MX-Processors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p/15=
38629#M196448
> > >  =20
> >=20
> > This question received a reply from NXP today: https://community.nxp.co=
m/t5/i-MX-Processors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake=
/m-p/1546872/highlight/true#M197067
> >=20
> > Quoting NXP's answer:
> >  =20
> > > Do I understand correctly, that streams divisible by 4=C3=974 will wo=
rk on other i.MX8 hardware too? - Yes
> > > Will those kind of resolutions work on i.MX7 series CSI hardware? - Y=
es =20
> >=20
> > which implies no bad side effects the way I read it. Is this
> > sufficient for the kernel? =20
>=20
> Ideally I'd like to test that on i.MX7 but I don't think I'll have time
> to do so in the near future. I don't want to block the patch on this, so
> I'm fine merging it, but I'd like a comment in the code that explains
> why it's safe to depart from the documentation.
>=20
> Also, the discussion on the NXP forum said that a width that is a
> multiple of 4 bytes but not a multiple of 8 bytes works only if the
> height is also a multiple of 4. I don't see that constraint being
> enforced in the code, am I missing something ?

Thanks for pointing it out, I'll have to double-check it.
>=20
> You mentioned in the forum that you tried 1052x779 and that failed. How
> did it fail ? Have you also tried 1052x778 ?

I tried with many resolutions when I was checking out the sensor, and came =
to the conclusion that the line count must be even. Otherwise the last 4 by=
tes of the buffer would end up corrupted.

My guess is that the copy engine can indeed only do bursts of 8 bytes, but =
that the whole buffer is copied at once rather than line-by-line.
>=20
> > > > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > > > ---
> > > > > Hello,
> > > > >=20
> > > > > the Librem 5 is using an out-of-tree driver for s5k3l6xx, and
> > > > > rounding to 4 is optimal to operate it.
> > > > >=20
> > > > > This revision improves the commit message.
> > > > >=20
> > > > > Cheers,
> > > > > Dorota Czaplejewicz
> > > > >=20
> > > > >  drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers=
/staging/media/imx/imx7-media-csi.c
> > > > > index a0553c24cce4..af821b410c3f 100644
> > > > > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > > > > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > > > > @@ -999,10 +999,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(str=
uct v4l2_pix_format *pix,
> > > > >  	}
> > > > > =20
> > > > >  	/* Round up width for minimum burst size */
> > > > > -	width =3D round_up(mbus->width, 8);
> > > > > +	width =3D round_up(mbus->width, 4);
> > > > > =20
> > > > >  	/* Round up stride for IDMAC line start address alignment */
> > > > > -	stride =3D round_up((width * cc->bpp) >> 3, 8);
> > > > > +	stride =3D round_up((width * cc->bpp) >> 3, 4);
> > > > > =20
> > > > >  	pix->width =3D width;
> > > > >  	pix->height =3D mbus->height;     =20
>=20


--Sig_/0w4EGCp0VVCKoSCDIxcxR1Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmN/ZRUACgkQADBpX4S8
ZncZgg/+M00zWn+qqaDOzjU/5vY0xfnGbBLJutiOhKbc6PJnYAJKk3Kxm1EDpRKK
h/Ux3rgC8FAo8nJXcL0nrromadYRwBK62ph4cszlOM4P1Yz9FxV7qA0ePvoNk+qY
vJEEwSeHjKwiyls8knSEcLPNeynR7zNndWTmL9lKkiWIkXHYJcfj5hEl/f8GllPj
tMN4tPFxlDtyDwBn3+Fcn/Q1577Z/u16h+/93U0PZjMwgV3hOTnxbvsvcKyKWQz4
3jHKx8vRgYxkKABqlR30TaBcxUXm/+Mg2ThvjBJjpdu+3agNFhsi4FC+kUrZ2LFn
nnQzJ2QjHtiSVNLABjeVWRnn0PscnmGguMv5SAygDAxzAqFGWSWuFwHLNPExd5nN
9rGxC0ndbQe6IV8pz3I87DBQ0Q92RgH8noI9UHoRhJDhqLCP/M0vMZf2yca5YDH6
/k5z8Hg8H/IUGw9nYJ+u0pUUaMY2El/vTPmtwooEsaxBgUAoEbrBCiQiGXDMWCiW
qPfdjiN+sMjpbYWxMMuOn+EaOPk5GUmssOF3WSezxVnQHpcMRx9Zz+Vudhak1n21
3xk4fce95luLiEwnPivkvXYBsOWyFHA8ba7yKqSd4YKzy5WvackN6169EQhoEomp
0YjTbktaA0AOxXHSar2QeaMJ7T5lu4ZdA+0wem7hfySVXbgNsvw=
=2qyk
-----END PGP SIGNATURE-----

--Sig_/0w4EGCp0VVCKoSCDIxcxR1Z--
