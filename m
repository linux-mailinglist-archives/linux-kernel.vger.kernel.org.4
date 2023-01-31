Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF75683831
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjAaVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjAaVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:00:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD599
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675198817; bh=MSM1dyVVeYWbZgYwM+ZMUuaKXnKRKbTaYBvxINXvbwg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=igIY7W0L/Y8LbTjsceL4YP/hFYDA+OGHfYw1HGeBoWaQRwjw/pIQ6Q8f6OnQLKavG
         fnt5tGGhi1lQotWCFCWIIztN5ulUZwvE6QzQW90Pz6KlMapqS2X3BrRi2Zw8tjZolB
         t/ydUKQLtcsLO6e8wmMsg6WZzPjmzLH3IeWiuIVlHRtA9gT23CgmP/Nf4A2yNcU4mA
         2LiITHf7R/SxESXW2QwslZDm5NQmij8JaB2Gz7+cFolgZF5QNVTDImXNNw88MggGLT
         txwEVNs/ry795BVsCefsVYDodOlNzresgmg2+lMHR7ZrYaxepbP2H00RSzgu85pRHm
         SvMlPxY4Q0iSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1pDjNX23Uk-00UGJz; Tue, 31
 Jan 2023 22:00:17 +0100
Date:   Tue, 31 Jan 2023 22:00:16 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
Message-ID: <Y9mBYEAq/g42s/S2@probook>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dbsH6cXHw2LGY0yv"
Content-Disposition: inline
In-Reply-To: <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
X-Provags-ID: V03:K1:Vo5qwmmgMQ+JZvjbi0fTBviJBoRgT286o8jRyJJG2s4pDpMmcg2
 aelUPRVrDh5wbkaqATzXE6EDxhZpswjric/PepyfSkRSUXgYn7tFuDjcd++w0EgyFEhvwNQ
 g4l72qzQ/uEAhOedF/1Vl8YoJkepj325ZUnLfsorB3tBxZ60uxEGP3ESJ4BYcFdu72yzDi2
 r40VMq0omFErXNcAjLYbQ==
UI-OutboundReport: notjunk:1;M01:P0:sx13+h+4V6s=;GCFO3Pk6re4oQRt8cRA1H/7o0Tf
 XBPIskbN9Ny7/4jE5k2oaFtMLJLmM6zD6PY+/IhNLhQg0/X1sOWNjMzbnoYSXQeYBO5uFvxv5
 r3xtmgurmENjNWrxUSuztX+8P4pHBYLADDHYjPA2bi4y6ZWm9VcRjR8lpeoxwUJ3VbCQUc1YG
 bJSRpyUvMlydprCQt9i5aiSNlvXZVaQuQnLAN2hy89BtuGW5LtFSgwfSPot29DEflJ2McSRh/
 mck0wR4XwAkm4GzDSlURZQzHpfrOaOaMDWyjN1OX7hE8euqpkV6AmpOZ8OM844LaSA4YhFwmi
 RholBlS2rBxibBYok1/ruom8BiV/2LGUf4K5hzRQbpAlmNPWKCM3D4bMIJbF5gIlKjCJANisO
 l/5s8eaIR8gUvtxUTclnOq0X5nKuNo5WmPXt8UCsHyEZ2vJrJ5fzX6vQ7Bdw84XnQoXp4NxRp
 9CfBVxMbrke0mk4hF0Keb5eSvq4xmCwotN+hEneUDBVxmNHRR+qVXUyb7hfUWdGOeQfi5MJzY
 RAIpkT2IQUHiVHhgKTa8SttlVz+3TiXDi8MGw1AKlFmLotKj762wE0EOnsM4wzGKPKykmgFDn
 PdNSEAMInC0HHuoJYol2nmxGoM0GcSbW1EVGkQKHni/QDQ323OtH+OayF8XNVG5bA8l42Fugh
 fs/rJ8In6a809iVuV4AIko5y6PUaVbtlA/44OgbhyuLIExjRO7DIlJIj0wqceH4pLA7L1T/oX
 RlJXtrpc0idL8+ZJW6d+Ks7uVtfzVvVedlBpfNzy5jhA12Vbfa1EDSvfKxjeRacs7cSVABMlP
 iycdYyEdMLc8kQ7aH2K3clrLq3xhn1oAZnXnDN40Jj3BpCfOjmIFNQR0EvQRZHK63xGQH9Lez
 8CqX3iOxMRJcMwi6l+DhjBBGJK8+78M6tPtgu1dNFKhRkiYW06d9QP5QBocLNznEAuwAQZa9M
 jRuWP3C72HY37XG3LQNxvEjVukk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dbsH6cXHw2LGY0yv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 09:52:38AM -0800, Joe Perches wrote:
> On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neusch=C3=A4fer wrote:
> > By now, `git log --pretty=3D%h` (on my copy of linux.git) prints commit
> > hashes with 13 digits, because of the number of objects.
> >=20
> > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
>=20
> NAK without updating the process docs first.

Good point, I'll do that.

Thanks,
Jonathan

>=20
> Documentation/process/submitting-patches.rst-If your patch fixes a bug in=
 a specific commit, e.g. you found an issue using
> Documentation/process/submitting-patches.rst:``git bisect``, please use t=
he 'Fixes:' tag with the first 12 characters of
> Documentation/process/submitting-patches.rst-the SHA-1 ID, and the one li=
ne summary.  Do not split the tag across multiple
> Documentation/process/submitting-patches.rst-lines, tags are exempt from =
the "wrap at 75 columns" rule in order to simplify
> Documentation/process/submitting-patches.rst-parsing scripts.  For exampl=
e::
> Documentation/process/submitting-patches.rst-
> Documentation/process/submitting-patches.rst-   Fixes: 54a4f0239f2e ("KVM=
: MMU: make kvm_mmu_zap_page() return the number of pages it actually fr>
> Documentation/process/submitting-patches.rst-
> Documentation/process/submitting-patches.rst-The following ``git config``=
 settings can be used to add a pretty format for
> Documentation/process/submitting-patches.rst-outputting the above style i=
n the ``git log`` or ``git show`` commands::
> Documentation/process/submitting-patches.rst-
> Documentation/process/submitting-patches.rst-   [core]
> Documentation/process/submitting-patches.rst:           abbrev =3D 12
> Documentation/process/submitting-patches.rst-   [pretty]
> Documentation/process/submitting-patches.rst-           fixes =3D Fixes: =
%h (\"%s\")
>=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3177,7 +3177,7 @@ sub process {
> >  				$tag_case =3D 0 if $tag eq "Fixes:";
> >  				$tag_space =3D 0 if ($line =3D~ /^fixes:? [0-9a-f]{5,} ($balanced_=
parens)/i);
> >=20
> > -				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12}$/i);
> > +				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12,16}$/i);
> >  				$id_case =3D 0 if ($orig_commit !~ /[A-F]/);
> >=20
> >  				# Always strip leading/trailing parens then double quotes if exist=
ing
> > @@ -3194,7 +3194,7 @@ sub process {
> >  			if ($ctitle ne $title || $tag_case || $tag_space ||
> >  			    $id_length || $id_case || !$title_has_quotes) {
> >  				if (WARN("BAD_FIXES_TAG",
> > -				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (=
\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> > +				     "Please use correct Fixes: style 'Fixes: <12-16 chars of sha1=
> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> >  				    $fix) {
> >  					$fixed[$fixlinenr] =3D "Fixes: $cid (\"$ctitle\")";
> >  				}
> > --
> > 2.39.0
> >=20
>=20

--dbsH6cXHw2LGY0yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPZgWAACgkQCDBEmo7z
X9syqhAAjCLoXy/zOreS8TWQ0IrrO/yBMXSCv5pyAmT0rN01fjbaiHR7w2xpDGff
d4fAvLqc6IyN4ORhruGJSCjcm9tzYvoE/glotuygNktL9xahTeAjdFdUMYWsj6j7
zVAbxpbrtITH6F6K3zv3UXbpqE4hMPv0kDgrJblwrwrY0Pik5ypwE8eRcsXc26O6
zjNgwjNNA+b1yv+a+WvAmr7HIw46QlCWfEPeWegyDoCttvKCmTcLkXKtnaEHBgjd
YEaLGQaeE6MLXYiQB5cthPDn8X9ncy+pcjMSrl1sOrk35q8OcUnNZyiZQlLXATGf
X0RpqF4fycbRWIqU5vzikO9dLunl/gY41rEQEkV6UGia4Xj474a5IODq5Fm4FX6E
Mf2oERpqaAbn+IfBiYaP+I1juozPY55D83aCTcInWE4U+IkZOdFJXx/iIwU1AVyX
tT3X+x50dYQQ6dGXaY65wOb4mNyEbYcMu/9ygcDR2dYoSCFh72FJB20kPYOEYI1F
evIOWP6lEP5bWdU4YEmqRgYywvvJMXlE4MSXKFIx3ZTyh2R6+7k6Fo4hYKCb0690
3Qic54+33YjgdySTLrv3BKCE77z69sdvB9TxMiNcsHetkL3obcvI6cFOL0TKmJDe
9cpDR8+jUO4n8FtXkvGXIY2hhTEdsW3Od8GW5uxGY1dkI06ShQ4=
=LoGj
-----END PGP SIGNATURE-----

--dbsH6cXHw2LGY0yv--
