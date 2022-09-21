Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743B5BF35A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIUCPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIUCO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:14:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED722A438;
        Tue, 20 Sep 2022 19:14:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXMSD5PxXz4xGC;
        Wed, 21 Sep 2022 12:14:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663726494;
        bh=gv8KIftZ5IZl3GUsqA+3wIqePj2kLhPNRG/GST2mC2Y=;
        h=Date:From:To:Cc:Subject:From;
        b=R2i3jmKhCbuML23J+gCCR+A8awouVIjPk4AKObaEPyXFgO1gxyz0I9aHlxzcDYg9f
         WrbhL85ahmvEJy/DFw4iJCwBqrMj82GOsAVdqoZi/NqPKqPdi2pzyRLdfgA/DW/np0
         CRwIa21SdsmNmbU4jkVkhnmZtHfe7FO7L7n5DZVdiSEMPXaV5bCrDi2UFVBvdtahp0
         BKCOLzKDLcqus9ArE1btbvbwiO5eBWteubaNSqvbhn4MiHx46fMZf/oydl1toavy3g
         4kuIXgp4M03sPiliqQUTOUGd41xufdjv6Ilt8wzQ0U9ZAJ1ZrFiCBTcwRKxdCtGmpi
         e2iuWhDKZizQw==
Date:   Wed, 21 Sep 2022 12:14:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the sound-asoc tree with the i2c tree
Message-ID: <20220921121450.7de65169@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7D/D482tHx3BwjJCQ+j0AR.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7D/D482tHx3BwjJCQ+j0AR.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  sound/soc/codecs/cs42l42.c

between commit:

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree and commits:

  0285042feda7 ("ASoC: cs42l42: Split probe() and remove() into stages")
  ae9f5e607da4 ("ASoC: cs42l42: Split I2C identity into separate module")

from the sound-asoc tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

=46rom Uwe:
"There is an immutable tag that can be merged into your tree to
resolve the conflict before you send your changes to Linux at

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_rem=
ove_callback_void-immutable"

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 21 Sep 2022 12:07:39 +1000
Subject: [PATCH] ASoC: cs42l42: fix up for "i2c: Make remove callback retur=
n void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/codecs/cs42l42-i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42-i2c.c b/sound/soc/codecs/cs42l42-i2c.c
index 1900ec75576e..67b253287daf 100644
--- a/sound/soc/codecs/cs42l42-i2c.c
+++ b/sound/soc/codecs/cs42l42-i2c.c
@@ -41,13 +41,11 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_cli=
ent)
 	return cs42l42_init(cs42l42);
 }
=20
-static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
+static void cs42l42_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs42l42_private *cs42l42 =3D dev_get_drvdata(&i2c_client->dev);
=20
 	cs42l42_common_remove(cs42l42);
-
-	return 0;
 }
=20
 static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/7D/D482tHx3BwjJCQ+j0AR.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqc5oACgkQAVBC80lX
0GwhJQf+NtHhkof5L/Ou7kOn7P5h/j+OCVPchVLio9gOS06HOEp60KDV5BRJJRxt
aBukLuOR3ytokSRtnvp6HwuIAMjFjecoNDKRRcn9uQ8WBY4G2rWW7dY2ZHcyGGSF
8CwTnKAAgNWHSJlN2HDC3Y+yzGBSl9ASn+GaE8F4CjT86D/8mknDl6guUOs7wjvK
nZYrMbhg2z7Exno4Vev3Kchh6gBhfBJkwQex6PXEFhKlyj8aDv1uMMJIctfklY7A
3fDQgkP+43GJcKKrziqlA0vwCu1tLoe4fEXLS0Akp6GU2Rb8hPRUyoN1ztxjFZMF
j0oiyKSoVwXXyBdi4gtSfcL7UXK3uw==
=z9ps
-----END PGP SIGNATURE-----

--Sig_/7D/D482tHx3BwjJCQ+j0AR.--
