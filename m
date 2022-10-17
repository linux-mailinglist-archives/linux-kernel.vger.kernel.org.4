Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518560112C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiJQObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiJQObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:31:47 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A08659FD;
        Mon, 17 Oct 2022 07:31:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4F130DF771;
        Mon, 17 Oct 2022 07:31:14 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4C8rzvhNkA2M; Mon, 17 Oct 2022 07:31:13 -0700 (PDT)
Date:   Mon, 17 Oct 2022 16:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1666017073; bh=o+aJRKJ3sFKSwuftgFx085zenCbITyr/0J/mwErAjJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXF57OTkVnlR2p2KP9rqaWlk/KYEM2WTlIwB7RfX/02zllRU/7p/cGgK3w9IpY6qL
         NRu1P37vyhD1wFF0i+C1Wm3aiyu2ON/jGOGXs91mpbm+N8bz3Wzf9ToxJML1Tt3rVl
         Kl/BtBEgedrOHgIQ515Qa5bnc86Ood8nUdr6h23EuEAPc4vvGKysLeGosDPc+7Qrkz
         zHZl5WYDsWM7QR2gjpBom/vv8qgZqB/lM/WW/UKctma60JcSdqc8IDvgMhceFwoLti
         udG4sC+DUFD3y79QiZ3X8vvaL+V/LChZ32bonoDCaia1ZyPXt95Q8fKwskvvTxNDLc
         sMk2/YlXaOz6Q==
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
Message-ID: <20221017163059.377ac677.dorota.czaplejewicz@puri.sm>
In-Reply-To: <Y00SSRMFuL3Drjd4@pendragon.ideasonboard.com>
References: <20221016163928.1ef0a4fe.dorota.czaplejewicz@puri.sm>
        <Y00SSRMFuL3Drjd4@pendragon.ideasonboard.com>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QmAeHAJcc4AAIcgpE63DMc3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QmAeHAJcc4AAIcgpE63DMc3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 17 Oct 2022 11:28:57 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Dorota,
>=20
> Thank you for the patch.
>=20
> On Sun, Oct 16, 2022 at 04:39:28PM +0200, Dorota Czaplejewicz wrote:
> > Section 13.7.6.13 "CSI Image Parameter Register" of the
> > i.MX 8M Quad Applications Processors Reference Manual
> > states that the line size should be divisible by 8 bytes.
> > However, the hardware also accepts sizes divisible by 4 bytes,
> > which are needed to fully utilize the S5K3L6XX sensors.
> >=20
> > This patch accepts line sizes divisible by 4 bytes. =20
>=20
> The patch itself looks fine, but I always worry when we depart from the
> documentation (sometimes that's a worry about documentation inaccuracies
> :-)). In this particular case, we need to test the change on i.MX7 too,
> as the alignment constraints could be platform-specific.
>=20
I don't have access to any i.MX7 hardware, unfortunately. I can help anyone=
 who does and wants to test this.

> I would also very much appreciate feedback from NXP on this. There's a
> risk of ill side-effects that I would prefer ruling out very clearly.

I posted a question on the NXP forum: https://community.nxp.com/t5/i-MX-Pro=
cessors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p/1538629#=
M196448

--Dorota
>=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> > Hello,
> >=20
> > the Librem 5 is using an out-of-tree driver for s5k3l6xx, and rounding =
to 4 is optimal to operate it.
> >=20
> > This revision improves the commit message.
> >=20
> > Cheers,
> > Dorota Czaplejewicz
> >=20
> >  drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/stagi=
ng/media/imx/imx7-media-csi.c
> > index a0553c24cce4..af821b410c3f 100644
> > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > @@ -999,10 +999,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(struct v4=
l2_pix_format *pix,
> >  	}
> > =20
> >  	/* Round up width for minimum burst size */
> > -	width =3D round_up(mbus->width, 8);
> > +	width =3D round_up(mbus->width, 4);
> > =20
> >  	/* Round up stride for IDMAC line start address alignment */
> > -	stride =3D round_up((width * cc->bpp) >> 3, 8);
> > +	stride =3D round_up((width * cc->bpp) >> 3, 4);
> > =20
> >  	pix->width =3D width;
> >  	pix->height =3D mbus->height; =20
>=20


--Sig_/QmAeHAJcc4AAIcgpE63DMc3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmNNZyMACgkQADBpX4S8
Znc74hAAiYKFNGGfNNsBLc3PbZgtbYTGiZaB8Ow2s/3CVjCwVrnK0wnmL0DnHSnI
vn3RjQ/GD2Ul2yeaJaNGOar7Uyk5ZmnyQTqJxJdQOWl01GHDW52A+uIG+Boz0fry
sRkMGt2TtUSuFF5dRINb1bzsdIxXhjxanDiAGVimwZNA93atIhsPNFMvdA0iPtyH
lvAY88s6X3zP4l289Xgx8MNoOgNPBqqnJkBM7qcRyMf60MdddYmjz43/2D6AbNvZ
Wt4MKCoPWlur8Nl6u0oEI2SxDb8LEKLhg542sCKq4T9/8wDUoAU9iUnRRVTOMeqf
9/CeHNY7opXcqyux/zL2yQ/9u+q2WdPWVpavGorINbtLRJ423eNBz8qa/qPhYrGv
KUtYT5iMwKZHyBmizBsLH7nfZ+6Bq1WIPwASs4ibsJmzqzMhXFogsZrAg+FLaVGC
zM6TU6SpjSSBdRSWFgBsF+vId2ThD6C8u1ebKGGTEd8Gg6iLpNZ7IRaLdo/YHnD8
Q5yy7qUH3klPKLfPYMHtGs+rCwyZPUvOyfWouojg70sDmfSyYePgDkOvroa2dZ0Q
lyG87d2zzTQ2Wp6YRSguSI329wZIQoq/qzP2NesY4wHcZIDCrVKZyfnVFNRp9KiG
2PKynGL8eQ508zqYMdXvVXyTRa6TyVobHLTXnQhrrApAifISNCU=
=hZK2
-----END PGP SIGNATURE-----

--Sig_/QmAeHAJcc4AAIcgpE63DMc3--
