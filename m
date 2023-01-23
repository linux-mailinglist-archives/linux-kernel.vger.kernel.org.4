Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140F677E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjAWOfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAWOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:35:33 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2B7A97
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:35:18 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 49325240008;
        Mon, 23 Jan 2023 14:35:15 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     David Airlie <airlied@redhat.com>,
        "open list:AGPGART DRIVER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] agp/amd64: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 15:35:04 +0100
Message-ID: <2864476.hPRh1b3E4p@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <bd2df24b-e19e-2ba4-c3e8-0d555f69b453@wanadoo.fr>
References: <20230122181632.54267-1-didi.debian@cknow.org>
 <bd2df24b-e19e-2ba4-c3e8-0d555f69b453@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2917665.PWPBeqnEoL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2917665.PWPBeqnEoL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] agp/amd64: Fix full name of the GPL
Date: Mon, 23 Jan 2023 15:35:04 +0100
Message-ID: <2864476.hPRh1b3E4p@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <bd2df24b-e19e-2ba4-c3e8-0d555f69b453@wanadoo.fr>
MIME-Version: 1.0

On Sunday, 22 January 2023 20:49:22 CET Christophe JAILLET wrote:
> Le 22/01/2023 =E0 19:16, Diederik de Haas a =E9crit :
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > ---
> >=20
> >   drivers/char/agp/amd64-agp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> > index ce8651436609..3020fd92fd00 100644
> > --- a/drivers/char/agp/amd64-agp.c
> > +++ b/drivers/char/agp/amd64-agp.c
> > @@ -1,7 +1,7 @@
> >=20
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> >  =20
> >    * Copyright 2001-2003 SuSE Labs.
> >=20
> > - * Distributed under the GNU public license, v2.
> > + * Distributed under the GNU General Public License, v2.
> >=20
> >    *
> >    * This is a GART driver for the AMD Opteron/Athlon64 on-CPU
> >    northbridge.
> >    * It also includes support for the AMD 8151 AGP bridge,
>=20
> maybe the line can just be removed.
> There is already a SPDX-License-Identifier above.

Hi,

That does sound reasonable, but I'm now seeing it as a legal issue [1] and =
no
longer as a spelling one. Strictly speaking it seems there is a discrepancy
between the SPDX identifier and the 'full' license statement.
While it may be reasonable to *assume* the "GNU General Public License, v2"
was meant, when it comes to license/legal stuff, I think that does not suff=
ice.

So I'd like to retract my patch submission and want to leave it up to people
who are in a position to resolve this issue, if that needs to be done.

Apologies for the noise.

Diederik

[1] https://lore.kernel.org/lkml/ad99d227-ce82-319b-6323-b70ac009d0e7@roeck=
=2Dus.net/
--nextPart2917665.PWPBeqnEoL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY86bGAAKCRDXblvOeH7b
bpDmAP9dkD6xv0+7accWtErOCfRIgkP5DZA86jJpwo3vBmbRSQD9HO65FfldWmSO
OPgm2CWJWdARSiR7d8Aa/AHJaj4X1QM=
=pjaj
-----END PGP SIGNATURE-----

--nextPart2917665.PWPBeqnEoL--



