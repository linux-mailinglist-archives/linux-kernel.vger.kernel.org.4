Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113969577E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjBNDcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:32:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC818A87;
        Mon, 13 Feb 2023 19:31:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG6Fg37lcz4x5V;
        Tue, 14 Feb 2023 14:31:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676345511;
        bh=Bfgx8xUHxfhLQ0qS9KkOxVzt4NQCDeV4YkZ6medyiX8=;
        h=Date:From:To:Cc:Subject:From;
        b=oUR/jiYuNfxc5YhytS6fPgt5nVZIGrGauTkAEK0wrdIWA26ORvmIQAMCr+CEMEhhw
         RnK3+jOw19fZKS0s62gnRUSM2l3fBJ3ll70OeWrBbrNoDqoujA0Yl2LTRBfw3qm/xM
         QERIjhTx/BLC61Df01c0u4Fx6jMPl3H6aFh6Ifkyjou/0hTsf3A0PCH1qoYc2JRaVg
         T+tvBJFjltSE3Ci+hTf/j/FxDDAm9eO1nRRaUR32jkQ3UumnVlj3EpWJefinZT9UtR
         4to3q4Jvb4DmvKgPN0IsFU6ltp3TQ/aMyUEjv9Jy2Ysi+pPMquJMpk4hrF+Ge+Tjxy
         munDc/u0QzyZw==
Date:   Tue, 14 Feb 2023 14:31:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: qemu boot log difference today
Message-ID: <20230214143150.7c7fdd05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F4uhqVyv5ZP1XVIfUuW3fIK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F4uhqVyv5ZP1XVIfUuW3fIK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's qemu boot log shows 256k extra in reserved memory:

- Memory: 2046080K/2097152K available (14720K kernel code, 2944K rwdata, 18=
048K rodata, 5184K init, 1431K bss, 51072K reserved, 0K cma-reserved)
+ Memory: 2045824K/2097152K available (14720K kernel code, 2944K rwdata, 18=
048K rodata, 5184K init, 1439K bss, 51328K reserved, 0K cma-reserved)

I don't know what has caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/F4uhqVyv5ZP1XVIfUuW3fIK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPrAKYACgkQAVBC80lX
0GxnpQf+MAoK/LgFvfGt+1XO7leXU/c20y0bYK2QgHtBNKQFbccFTelduZBPVX/e
NbwZSBxyhZtiHJ7zFVu4EXuGbihCWvu/UylKKDxKAMGNgy6W3hCnjH9vEo1r14Yk
D+Mlqv42tLg36biJ/Lx6mVDsxh2Y+zZAKEwyK4a+yhVKCTfZ3iz7hw0vXlA6S6Ry
xf76njpf+Nu96SNgEzqDT1Ta4H6vq5khumj4V4hDyrMGnf4bKb0LoTxDTuFQxUgi
ctBb3747AzE8+lGEgNFpeUgLnsgJzXM7EPQMPvnima8DkD8ME+804ktvl/K3Tgfd
OmB0TvXBNeDqyLLydaOmlRBzlAz2Rw==
=Bdie
-----END PGP SIGNATURE-----

--Sig_/F4uhqVyv5ZP1XVIfUuW3fIK--
