Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A41683ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjAaX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjAaX55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:57:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60086186;
        Tue, 31 Jan 2023 15:57:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P626g31X6z4wgv;
        Wed,  1 Feb 2023 10:57:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675209469;
        bh=otidM+6s9MPV+JixMK9xAR6aP5z/OIg+VS6OavtGHBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=c970s8k8w05wM7rYLtu/8ubUoK/kCmd8ZeZI7+5q4cO52wyaJb1TKYKFElLI/3eka
         O5mWeyKG2Mli3lViAELX5g+OxxGBKyTaPnDUJwL9Zawh0kkyyR0GPeQGJkMPILlvco
         OQdqCnFT+Ymq4r3glvgv9rZfsNcxNeg25fdo5l2yX6r5ruC0sJJhC6W0KhAJUBAsXW
         kK5CNZFZHTMDJE68A9WEmL+ZSghpWk0xqeE7iXmGeoq+wL6tq434hFJ+Xnd8pi3nHf
         3E2HsO/j07lge4ufThBO7qSMXr4B9DCIiNLlPsDtyF4Ld0ybXX2sh8G/95n0z//cg+
         Hd+G3kSRMrYrQ==
Date:   Wed, 1 Feb 2023 10:57:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the sound-asoc tree with the arm-soc
 tree
Message-ID: <20230201105745.5f967f15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GNgInR7_X49actaugsPAcP+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GNgInR7_X49actaugsPAcP+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  sound/soc/cirrus/ep93xx-ac97.c

between commit:

  2b45e1fa9398 ("ASoC: remove unused ep93xx files")

from the arm-soc tree and commit:

  0e478b88b257 ("ASoC: cirrus: use helper function")

from the sound-asoc tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/GNgInR7_X49actaugsPAcP+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZqvkACgkQAVBC80lX
0GwCGgf/TfAu2o1BqIOkNZ3yXU4ectUq6XlyESTcfXsiixvcHNdDyU0vWv0bhz+c
ezWT4A5u/d6eXb2bEtcs2O4RuW3Xt87Aiz/SPJjjEkwSkbRvU1Afv4A2tcTjWAgs
Mdy1Piv+Ufx5773yBLm4QLWXfm2kRKGsBPn3kH2eCziVQ3ZmiqRCQ1tb8lmFa8y4
KY62Y3IPdxayX/UFz8aAHrXXOUsdOwXHkU4lWj1wz8tGKGOj4pty9bs2qgNhljWn
wzsPg6OVhqEkfaOXRmKDX3c+m7u/VdjwBN7fewGcF86knYl1/gz6iNzMUC8wqzwv
upk9UQ86f9LUT2YOBudxCDvexCNBZw==
=qMdt
-----END PGP SIGNATURE-----

--Sig_/GNgInR7_X49actaugsPAcP+--
