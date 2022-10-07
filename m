Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316FB5F73A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGEyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJGEyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:54:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC1410F2;
        Thu,  6 Oct 2022 21:54:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MkGF457QCz4x1R;
        Fri,  7 Oct 2022 15:54:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665118474;
        bh=NFC0Gb1GaKx4jpIdtROHwyz2qmQpPy1pOB3qz2l8134=;
        h=Date:From:To:Cc:Subject:From;
        b=EoWFdjEgmMtqlvpcig9o2o+7enXMN9pq7Pfw0jdllz4miYF9+y5AMshnfoAHE6/ky
         eBEtFiolM3RGnQrh9BSuOS8dCftT47exKGbYcemiYU0mmp2lJaAimZPuxSKxjbjPWG
         dcG5fBlV4RiJaaO3C+/RA6V3EQFID+++mCMy4WVI2IpwnnrxNSQO/qMDPOokEEYOM6
         q505rx2DfoHeucJ68PRMarUbx4AfSZpIU6NgCNdf5+t2IWyVKeXH4uqLSw8Q9wOyGe
         kI8PtVFhGKCyy36gnTfLdb1a0AOElnaHq9M1EYo8BqU7XFkCsFdApqX7GbDqIh+pOL
         q/CIkxBAVMw3w==
Date:   Fri, 7 Oct 2022 15:54:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Subject: linux-next: manual merge of the random tree with Linus' tree
Message-ID: <20221007155427.2b0ad053@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yF_lnIualKQSN9R5Bco0o43";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yF_lnIualKQSN9R5Bco0o43
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  drivers/gpu/drm/selftests/test-drm_buddy.c

between commit:

  932da861956a ("drm: selftest: convert drm_buddy selftest to KUnit")

from Linus' tree and commit:

  87b2389e69dd ("treewide: use get_random_u32() when possible")

from the random tree.

I fixed it up (I deleted the file and applied the following merge fix
patch) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 7 Oct 2022 15:46:52 +1100
Subject: [PATCH] drm: selftest: fix up for "convert drm_buddy selftest to K=
Unit"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests=
/drm_buddy_test.c
index 7a2b2d6bc3fe..62f69589a72d 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -729,7 +729,7 @@ static void drm_test_buddy_alloc_limit(struct kunit *te=
st)
 static int drm_buddy_init_test(struct kunit *test)
 {
 	while (!random_seed)
-		random_seed =3D get_random_int();
+		random_seed =3D get_random_u32();
=20
 	return 0;
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/yF_lnIualKQSN9R5Bco0o43
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/sQMACgkQAVBC80lX
0GwESQf/Ter5RtrzzK/ERDJ3HBpvX7BZh+DzwoK7AvJdh4kT7eRPM2B6vyoJ5nsI
VkzBq+SeTI5Rd4pfyPiCAndNsUet+O9yr73OQJQd0a1HpzcvfcjX6ywY3EDvQnUV
TxdyHLHmBlsbrkcqE9FpTLsXZ9Wq+brQYCCTW30q9yTBbUqgJt8aN3KQBQ+cGhRL
xB5PAUa710uNQmR700Boekwgm6xvH2yj8kwsG21BkAxNNwDXgb1qKZIchgjReEJo
vkVbXpejzAf/kkUcVBuG7jpOHhKWzbA2MYspeviRIAL/pQSBqKSXSCgMY7qlA922
A/vzKWxV4d/bMpwI6EAQ9EOxfsMZBw==
=t1q0
-----END PGP SIGNATURE-----

--Sig_/yF_lnIualKQSN9R5Bco0o43--
