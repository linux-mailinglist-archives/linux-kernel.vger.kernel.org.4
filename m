Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564DA685D82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBACtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBACtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:49:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A0360AD;
        Tue, 31 Jan 2023 18:49:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P65x23Ktyz4x1f;
        Wed,  1 Feb 2023 13:49:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675219783;
        bh=IA8Spk2wFX0UfKzjGk6QUXRs+xAc/2oltV9gsDSh5Ok=;
        h=Date:From:To:Cc:Subject:From;
        b=CKd4/4KQTwXfLrTsDyPiyG5sejenjzDpmpPAt6y7iiuwNd9GHVNiVTDmJbeuHCqv0
         p2bxw8Yt3bQEgItzS3yEfPLrUnT0P8JyyNHgmnuJBZXVWjChj8iskKiPPUB58DB4Eh
         WzDJsf6DYbtcTs3QvXmBCNsPSh0BRqG2nhsYnBQuBR41OlDPD1ZWp3Ccw9gbY1MCi/
         fxXlcYxSApzvtEnOY+fAo34+61UsNvzK9Q/PKsYbSohVCgeaHSYPTtHrFo9zLGkLFi
         VHvbKrJUvUHcDcgWOQkWTF6bKKlkSsW3hcpmOJ1DYtOnckKNHVCoqYhfJI69ktjeyW
         VUeG1skwxglyQ==
Date:   Wed, 1 Feb 2023 13:49:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kunit-next tree with the
 kunit-fixes tree
Message-ID: <20230201134941.46b02711@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eNJ3OFUCzxJeQEx4bvUJdLv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eNJ3OFUCzxJeQEx4bvUJdLv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  lib/kunit/test.c

between commit:

  db105c37a4d6 ("kunit: Export kunit_running()")

from the kunit-fixes tree and commit:

  cc3ed2fe5c93 ("kunit: Add "hooks" to call into KUnit when it's built as a=
 module")

from the kunit-next tree.

I fixed it up (the latter incorporated the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eNJ3OFUCzxJeQEx4bvUJdLv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZ00UACgkQAVBC80lX
0GzsDgf8Cj+jPrDcQQJ2KlNd28/LUIVpVej5KtynnGcPwxcR8UDLn7YScO1NB48d
y3N3D+N4jEXbWrXTLBuoWGVMPWooJtFM8nTu8vnidaWBUUpsmvg6DfcNfPtRgPgs
oVOJeanj9DX6Gc7LONGe6wHV9FzvM/TAmRdAlPuiSxMM7FVE1++5dzIvwWFV4FFy
fm70XtKyWOkYQCXu/PeL4mk7yjpbym0R4T3Hn5wJsAQEWYLDj79Zpa3cyWDEwkqD
EjMKPTNyAEVS1rTtI3xnjlPCkgtWCsKo9iT3hpXnofIo3FCXyVTWqzi+ow8vQq+6
RHENSS5DknWwsZUgu5ivZaEMqQFqSw==
=vGDz
-----END PGP SIGNATURE-----

--Sig_/eNJ3OFUCzxJeQEx4bvUJdLv--
