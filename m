Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180F6BA532
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCOCXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCOCX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:23:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20522FCF3;
        Tue, 14 Mar 2023 19:22:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbvKw5qyTz4x1f;
        Wed, 15 Mar 2023 13:22:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678846934;
        bh=zpwA+T7op9/WDAttXp9+ucqhi1zob5iXVcRK/Rsjvos=;
        h=Date:From:To:Cc:Subject:From;
        b=AhgJUtHKiEirtAL0zECFW8EoXWimU/96AC6qxAV5d2Fg4bEoD5xZXiKUwtHjj3kEc
         wtv2stnqfA0B+rKrYQZ1F46rBR8xzfwLsLwbrs6UkluyaYMZztmUSWKIdRNDXUWOLx
         ysEmNsNv/2LPMd4t7YYJ6cesJNX0oqPf+FrfDGFaW9fn5voPuNKMTLqYyxm/v+8bdp
         /Z0roICb+pyCNHJ4vKQkYtDikhZ91008SunTkFHH/kC9uxxcVQu6RvyXDc89I+d9yd
         2V+fXyWp2j8lzPcJZWo78syA7ILs63Wg+/loTaL/JgatjOWg8RNXxDGbjTlmUAHx7V
         oBuDjRFCdn9zA==
Date:   Wed, 15 Mar 2023 13:22:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230315132211.3ca97ab9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CL6MaSdMZTEfvv.71EGMOrn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CL6MaSdMZTEfvv.71EGMOrn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  dc5c294a71a5 ("fs: prevent out-of-bounds array speculation when closing a=
 file descriptor")

This is commit

  609d54441493 ("fs: prevent out-of-bounds array speculation when closing a=
 file descriptor")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CL6MaSdMZTEfvv.71EGMOrn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQRK9QACgkQAVBC80lX
0Gwh6Qf/XUGPVgWV/A1S1/HkrcDx6XVisXJ58g8lv0grh/flPjk4jqtpBGTn5bkc
hoZ22TZ+aRZQ5uR2Bc7qtStNwUz0AlbPJZslsftWLdm8JsTp5PIY8iec87mWYhhZ
DD88a0bU7Ps0gUjqNlhfKSz6gTte1WcwCwgvZet8WOoLSi37qcqf+gAqmcVAIQXJ
W5PvkDy3fIkgDnffwy9CzUc6m3slC1RBgcnS6fAUWVIlfL5LjxUw1fHfdKt8zcwk
HvnT6tgdcawPLHZwraTnG2mi3a+RWiisyuGDTwboM5o6Q+hCiJZ0dA7ZFemozdPH
qHpE2bny+MF7279qg6cVPs0m3NgRYw==
=IVce
-----END PGP SIGNATURE-----

--Sig_/CL6MaSdMZTEfvv.71EGMOrn--
