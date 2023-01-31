Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC76839B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjAaWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjAaWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:54:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93A410AE;
        Tue, 31 Jan 2023 14:54:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P60jf5xWXz4x1d;
        Wed,  1 Feb 2023 09:54:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675205671;
        bh=5V/LAnN0pFO5vCbZcZP47Qcu2W8IXRG/+P4wvCiMzaU=;
        h=Date:From:To:Cc:Subject:From;
        b=km+hFuoPZO4BafXVBgVWf1orrIGbH8OSID482RcMFICF+B5Lo+LmRrVqFh+P7i+c+
         aKZUQ2xEUd3AwV+zCi4GuAgYq610xXPq3SeZIEme2/SP9AgY9x46MCfdlK8rZgElTL
         R/rWjDaXzATE9BO0Ny9/YaYAN45WxD5HiF8JzTXY7Bv6nR8/w+iPnQrYpg3RRaW4TG
         O1YDRoZ6MZT4GGD/HeYF7tjlGJJ1wH+uwMZ/Pfpn98E5oyptGSuYbpLJ4P8j3Q0d2f
         S9HaNELWIc36jpPF6auJP1y86LwFAKGeahQRU4b9+SBi/OWwBXi3+KSih0Lp/2l5sd
         +bl+/uta5X22w==
Date:   Wed, 1 Feb 2023 09:54:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the hwmon-staging
 tree
Message-ID: <20230201095429.3aa29df0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CJ67WxMix1V5wb8YcYKRhI0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CJ67WxMix1V5wb8YcYKRhI0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/hwmon/index.rst

between commit:

  62485d4ae451 ("Docs/hwmon/index: Add missing SPDX License Identifier")

from the hwmon-staging tree and commit:

  941c95fdd61f ("Docs/subsystem-apis: Remove '[The ]Linux' prefixes from ti=
tles of listed documents")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/hwmon/index.rst
index 96ce91b7d9a8,c2b3c1a822dd..000000000000
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@@ -1,8 -1,6 +1,8 @@@
 +.. SPDX-License-Identifier: GPL-2.0
 +
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
- Linux Hardware Monitoring
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ Hardware Monitoring
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20
  .. toctree::
     :maxdepth: 1

--Sig_/CJ67WxMix1V5wb8YcYKRhI0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZnCUACgkQAVBC80lX
0GzEiwf/SpwV265hCKrMUuF5PhyqXeGUjz0o/CxUwgik7kCBXXh8tlmy40t9MumK
7F7PXG6r3WWzuWfO8iacPEynAOJLbwaXjKuAMDRnYnQQ6SyfqNn3Nn3hlAfnIlBw
Cg7NGoSiuf0Pq52o/NZlF+smBrP3W9pOlU2it/+ZgvkBM4xIm/uDwQTbjvkS6JVq
mw9RojPnuI1lvrZiZ0JvkMRJUXy1EAj7HQWvdTmZyUaKIMlrXyDUQmwcE/9DnfPN
9woS1L8mSOsjC7MEOeS0RyHzUw/0/+eNJGcHzcRFMiqiCjyPf5q2+jYvhBj80bm3
viHdjNWrdat32I5XYPpekiaiKlwSQw==
=gMhQ
-----END PGP SIGNATURE-----

--Sig_/CJ67WxMix1V5wb8YcYKRhI0--
