Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9668FCF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjBICNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjBICNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:13:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECFD14229;
        Wed,  8 Feb 2023 18:13:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PC0kz3RSnz4xxJ;
        Thu,  9 Feb 2023 13:12:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675908779;
        bh=SqqF476/gbjX9ylAeRVbe5SjYoh4ca/kGQLCtFrnXwo=;
        h=Date:From:To:Cc:Subject:From;
        b=KrD358W7irL6HmUqJ8Xn7pLiYicHck4q2w0fVK50bvaKAQh8J9+7jA6LUZ+J/0CaQ
         21rguaLdlMHo7JJU8Ic+jGFhsEAd+QKyGy/E2n17FrFTaQ1aYG5EngpufEsyw2rPTM
         uDmmrPIBgny1igi9IkFbZDg77yHsM/h5vscoQmXYk8R3DAQ54prVi83aONbwJuE/Z2
         SrMGEB7hfXLplKUGqC+Vt+PPS6p0tdKHeSGoPmklcQqDOZBhJy1NbUPoYrW0XWhr2M
         AXzsAGnoF4AcG0tI1ZhkA8bpkduV83Xm8aSXo3DWs6Oext9NXpC2Ua5qw32PU/CPq2
         q28C4rEXdNU1w==
Date:   Thu, 9 Feb 2023 13:12:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: linux-next: manual merge of the mm-stable tree with the jc_docs
 tree
Message-ID: <20230209131258.1d7a28fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9O9glMUJSxK.Qu1Jzqyzuly";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9O9glMUJSxK.Qu1Jzqyzuly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  Documentation/admin-guide/mm/numaperf.rst

between commit:

  00cba6b60fed ("docs/admin-guide/mm: remove useless markup")

from the jc_docs tree and commit:

  6c364edc194e ("Docs/admin-guide/mm/numaperf: increase depth of subsection=
s")

from the mm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/mm/numaperf.rst
index 24e63e740420,544a6d16c801..000000000000
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@@ -1,4 -1,9 +1,7 @@@
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 -.. _numaperf:
 -
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ NUMA Memory Performance
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=20
  NUMA Locality
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20

--Sig_/9O9glMUJSxK.Qu1Jzqyzuly
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkVqoACgkQAVBC80lX
0GyebQgAnSHiz16KoUVD+5vRL2hVs5unjUdR37Q9+6QNnB6PRTcAX7ha6NdIillh
FmUVW4GBa4064GnQg+xB0r6S9+oVe2430meQqeuhh/AyvPihctBR3w/+NmUU/sam
rfyne3hlhhHlp5n5owXslzh+qu1c2NBDBwQ7tpYhvDdPeZ7GUqPBk+iSjjWZistE
BsytITl5QZSRm472vrIUhMXw3ii4kJumSzTpCnjdRQf45XS38wVnHHvp/ISjOLpI
+2T2/jiMurLzTrGypcKff0UkR0ve8inHYht7kSpRQ+q8EDlaZwJa4mnpd9gyvDuO
+S27MjKEhY0iqGF+/xxEYAuSHbWZug==
=lCrr
-----END PGP SIGNATURE-----

--Sig_/9O9glMUJSxK.Qu1Jzqyzuly--
