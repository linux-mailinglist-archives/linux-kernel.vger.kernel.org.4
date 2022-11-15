Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B2628E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiKOAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiKOAUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:20:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124715A25;
        Mon, 14 Nov 2022 16:20:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NB6Jl4w4Tz4xZZ;
        Tue, 15 Nov 2022 11:20:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668471624;
        bh=Flkuiws2gQG551lQNjjxnw9zCJ8mpY2AsUxbL0rV8II=;
        h=Date:From:To:Cc:Subject:From;
        b=aTATRPWW8da1jkc6sPi5I0y71BJJODAI/fZq10Ky1y5ycqPpv7xHJQoRvaLgxbC2b
         AJH23X061ftqmPvH6Fti6Fgzv6tUUVMxwNIZ0omgkysbSpvp6fT9RjHafsHGidalOM
         6jPtVfwWOd86j0sSB6vwnkvtk+CXkWtS11NdWnQgD8Y7ZFW+nCpfwnYva7XGIGmrbC
         yfl4sqKxlH45oynMRzWkeLko+DbGyb1g6VVR2mzVRiSeooB+v74IimCBYRc4a7g8N3
         /nFp/H32dXeWNotMLVQxlSiulNuZyahlBVorI5aa7MjXvY5FPKUhpIR4hVhVXcdtwm
         PCb7pk5dKuhdg==
Date:   Tue, 15 Nov 2022 11:20:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the fbdev tree
Message-ID: <20221115112021.1c8aa004@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RBOXzVc3SgC_7VbRKmzX=Mn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RBOXzVc3SgC_7VbRKmzX=Mn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: drivers/video/fbdev/via/viafb.o: section mismatch in refe=
rence: init_module (section: .init.text) -> viafb_exit (section: .exit.text)

Introduced by commit

  ab885d8c7e15 ("fbdev: via: Fix error in via_core_init()")

--=20
Cheers,
Stephen Rothwell

--Sig_/RBOXzVc3SgC_7VbRKmzX=Mn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNy20UACgkQAVBC80lX
0Gy6zQf9H1H0rD0Xqy7XbQgZzHxix0EHeKVeWutp/+ia9NjzdZGP3g4zR9Dfki4s
K9kWPX6qyjZLEjemUyJnZgKgRF4XBYr+WiShvcxhxFTENr8y6veoefftHysf31EO
GRX6S0sU66sz0oeKqy6k95DshNEWzHBrxei/jjElGStR9k0Bog09znGWWzlqtlfa
nc0kr1GpJo88ClNmNJaOl8jI+flZLIq7N/XGc/0qE1Ay0xZIb8ZJWZ7UGVTZXF8G
Nw8i4i3K//Kf6zGtOxUbvL4XS0o/WIx3qKedR6ZvxxAHnoSNF3eiL37wOzWZg6+2
T7xDi8IarcULgmj9QFMgrvk52YASfw==
=Rngp
-----END PGP SIGNATURE-----

--Sig_/RBOXzVc3SgC_7VbRKmzX=Mn--
