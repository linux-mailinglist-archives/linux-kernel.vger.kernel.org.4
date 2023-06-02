Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3503171F8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjFBDb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBDby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:31:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35FBA;
        Thu,  1 Jun 2023 20:31:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXT7p43vbz4x41;
        Fri,  2 Jun 2023 13:31:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685676710;
        bh=0iaVf8GJWyfmYi6SHJope2hZ9PMHYHgK1IvlLN/uFJo=;
        h=Date:From:To:Cc:Subject:From;
        b=Udm+Sm/8CC927+8Sj8+TBpCBkd1+QodKWi4tQUgwG9y15ZeYdJMNRP1q1PvMroh0W
         7k5Ur73XZpgjDB1eu8AoVt4iOT9uZ6Q+Z9/cVl9g+2suecJItZLaUWtmUooXDyK0cg
         gZiJF13hZITiSAQktm+0q6IRqFS7Nyq3TTNAIqxjlTwLsQW0hMsDjZRebwz6dFMFFI
         fQClLAbYXqqee87kjBAKa/O4kGHkLp5T626kspd4K2m3fW2yfREsYz7G/T3VqsB/Co
         Tor+tPWYKH+UoLJ1qaXp3lEnIia87dBm3E9IBfMlw8D+mtXLm6yJBP7IIBt5XtvEfA
         mXsmYwWcbZVtQ==
Date:   Fri, 2 Jun 2023 13:31:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Rosin <peda@axentia.se>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mux tree
Message-ID: <20230602133148.1fc0b305@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NfZc7UN29A4O/UU7sq3zduI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NfZc7UN29A4O/UU7sq3zduI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc tree as different
commits (but the same patches):

  213700a8b96f ("dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC")
  76ac787cd671 ("mux: mmio: drop obsolete dependency on COMPILE_TEST")

These are commits

  8258d997b874 ("dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC")
  5ccf40288ca0 ("mux: mmio: drop obsolete dependency on COMPILE_TEST")

in the char-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/NfZc7UN29A4O/UU7sq3zduI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR5YqQACgkQAVBC80lX
0GyGSAf8Cel/Kkag4AlLZTR0PQy+PWqr36/qpeHzE2DyDB2ZNb6pA0Td6gU6XM9z
D9g0ErPnqhAe7P+Oqai8F2+ckug76c1O9N7P/KAR98NRle+104GO7r+cBecY8NxT
dy0x8teyCelXamhLuIRpXpal4c4fgbjP3WU1wvkWOFxX2sI7Z5eJLw2tUtzEZ9ri
1CcwmIVb3M301+zt1XAOhrllywGrxV7QjeummmWEaWo1QLfYQ7c/3wT3exam4yiC
xXgtLoewpMkx3MsZoF8w6Rlilhh0VHAHnaZCY2xi9i15ug5kXoBGGI+4ssZ8mEL+
9nqH0ltK+C0akR0k1a9CM8eU9HiQ9A==
=qtQh
-----END PGP SIGNATURE-----

--Sig_/NfZc7UN29A4O/UU7sq3zduI--
