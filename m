Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E25BE813
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiITOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiITOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:07:50 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3985A15F;
        Tue, 20 Sep 2022 07:07:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E9E7D100017;
        Tue, 20 Sep 2022 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663682865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GF6cPJVtOJVbesTQZDktFClOlGzeyriaAidJCIdaM/M=;
        b=IFfCR6B4r/Krfaqb3kk+lbwGk74VHj2gL6Kwed5+b1fCnmg0uZI5FMDZPRpzvk2s3Evpd7
        gedyWriqEBppAhbih6GFGNFHL5GbSXF1SwKEYDG0i0MyEA4rYAf0q7t9EXi/yAJGW4TX8s
        2/6oRLDYieJen4O8dkJy+WHCJe+D7u5kJEtrSLTzYn/fU1obPZdjN+//hhxIKnu0YKKSY3
        +Qll5cxtQvGxoVI4YsQFQYTlu22WqF7XZC2FzFiksGrgPtPEmqw45ggMYxBAU0bo8Eows8
        D2s10PhkdCabDQt70cDFxcfS2G4QVOX+E1BvtCGo2rG3LP6v5jz1TJOGEl2S7A==
Date:   Tue, 20 Sep 2022 16:07:43 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Message-ID: <YynJL5834XNvshyT@aptenodytes>
References: <20220919023247.731106-1-rafaelmendsr@gmail.com>
 <Yym/QDURAtn1LX8i@aptenodytes>
 <YynHBkbTw6bTgYNq@macondo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaB1nv5BiLMNa+jQ"
Content-Disposition: inline
In-Reply-To: <YynHBkbTw6bTgYNq@macondo>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zaB1nv5BiLMNa+jQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Tue 20 Sep 22, 10:58, Rafael Mendonca wrote:
> On Tue, Sep 20, 2022 at 03:25:20PM +0200, Paul Kocialkowski wrote:
> > Hi Rafael,
> >=20
> > On Sun 18 Sep 22, 23:32, Rafael Mendonca wrote:
> > > The V4L2 fwnode data structure doesn't get freed on unbind, which lea=
ds to
> > > a memleak.
> >=20
> > Thanks for this patch, good catch!
> >=20
> > I agree with Jacopo, you shouldn't add a newline before the call.
>=20
> Thanks for the review, I'll send a v2. As the code for the ov5648 is
> similar to the ov8865, and in the 8865 there is this blank line before
> the v4l2_fwnode_endpoint_free() call, I thought it might be good to keep
> the same style here, that's why this empty line ended up appearing here.

Understood! I'd be tempted to make a cosmetic fix for 8865 but will probably
wait to group it with functional changes.

Cheers,

Paul

> > Feel free to send a v2 with that fixed and include my:
> >=20
> > Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
> > > Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image se=
nsor")
> > > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > > ---
> > >  drivers/media/i2c/ov5648.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> > > index dfcd33e9ee13..95850f06112b 100644
> > > --- a/drivers/media/i2c/ov5648.c
> > > +++ b/drivers/media/i2c/ov5648.c
> > > @@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *cli=
ent)
> > >  	mutex_destroy(&sensor->mutex);
> > >  	media_entity_cleanup(&subdev->entity);
> > > =20
> > > +	v4l2_fwnode_endpoint_free(&sensor->endpoint);
> > > +
> > >  	return 0;
> > >  }
> > > =20
> > > --=20
> > > 2.34.1
> > >=20
> >=20
> > --=20
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--zaB1nv5BiLMNa+jQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMpyS8ACgkQ3cLmz3+f
v9F2rgf9GWJRbsfTRwscJGXsW2i6pIThfLIysGiwYV+1lqVNbTCzLA4z1XckxHrw
06zL/v+ZIq0KROZXE5Z3DTOBhnfXd0xVnfrVlY145dgRxFsg44icsjHtf/NFcS/b
F5vj+kGhuddzFi7Vdg9HtuZFexzZBQCZ3of2+1E3bjsuzqt000DEeoVHLnuqg4vP
UWsp/LrqgM1197fw+ylhJpE4RJWQSAreMywhvaabfJQO28KkqDMTJQI/AvOeU/6h
eAzIIG43OiNtIjedkJWb3dS6ZYWgUeAclKQcx5JG24msZub0UZyKKoZa+ycTMb5/
jvFgrKg6TT0oH4W2ftvPLQ5xSxCFUQ==
=jW0C
-----END PGP SIGNATURE-----

--zaB1nv5BiLMNa+jQ--
