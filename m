Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F250721AE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjFDWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:51:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE415CD;
        Sun,  4 Jun 2023 15:51:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZBmq0Xfhz4x1N;
        Mon,  5 Jun 2023 08:51:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685919084;
        bh=gS30G2CeUzC8UwUsGBHIt3Oj/UgGabW+XQAq0uJjAfs=;
        h=Date:From:To:Cc:Subject:From;
        b=QhAGOvSzwrZjBRz9tSZ/7JzPvfMq8kBqgNg93brLLWHtyOygSso+KJMDh94ru6Twx
         e2Q1dse4CHw9bsT2c+fP7B2MqcvRiH4llUBtHIeqNhyfXG4xk+abqZi8G50g96c7+p
         ilTHYjat3/EASHv0u5PPEUidcNpPugFQCS8nlJQMEU4m8Npgs5Vebw3WDAtGMHeZkg
         FuKCClANzEWb8YZ5rV8XNfraKm5BWcnuqD3nLZzVTwdo3CIz6QKkEjgwsknT/Owa0g
         esg4cnOhoVdOkHZiHjBBlp8bNDa7Qw3nCIcNLDRDmOwgk6CVJ4IeScCWeA2BTHAzxU
         /CtMvb+lNQuWg==
Date:   Mon, 5 Jun 2023 08:51:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230605085122.38f696e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m4KLJkG+F8mavPbfON_4vO0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m4KLJkG+F8mavPbfON_4vO0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  MAINTAINERS

between commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree and commit:

  cc9e654a7e81 ("MAINTAINERS: Add entry for drivers/acpi/riscv")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 607504217dc3,0d6ecb5a4107..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -406,6 -406,19 +406,13 @@@ L:	linux-arm-kernel@lists.infradead.or
  S:	Maintained
  F:	drivers/acpi/arm64
 =20
 -ACPI SERIAL MULTI INSTANTIATE DRIVER
 -M:	Hans de Goede <hdegoede@redhat.com>
 -L:	platform-driver-x86@vger.kernel.org
 -S:	Maintained
 -F:	drivers/platform/x86/serial-multi-instantiate.c
 -
+ ACPI FOR RISC-V (ACPI/riscv)
+ M:	Sunil V L <sunilvl@ventanamicro.com>
+ L:	linux-acpi@vger.kernel.org
+ L:	linux-riscv@lists.infradead.org
+ S:	Maintained
+ F:	drivers/acpi/riscv/
+=20
  ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
  M:	Sudeep Holla <sudeep.holla@arm.com>
  L:	linux-acpi@vger.kernel.org

--Sig_/m4KLJkG+F8mavPbfON_4vO0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9FWoACgkQAVBC80lX
0GyGZgf/Vg2Gl2xNCZ7u1dGg3saZjgfpmUEO6TqMioiStYxn/jWV1j7WSYsNfc31
OatpOE4EghK7to/oYBO35FAM5OBnkNHkHBXIHmwRdU6BicSMRNOB9CMAbsMhCg2g
LfAzQTOE1VGO5RdOJoJlXIZLyxsPvLWsE1x0gPpKIpjdbqm4cAFBYDDB5V+jLCtn
DxVlHq+59u3n6SyPmbT5LhVKzIss9u1E3bXsLAUcgu8GV9U4ZsWDQBSDJRe31a/L
oNHtPfnd3gkas6dKaPHHFYr0dUvUK/uIPowNOvsBPU3/ZJLEaMiorg9mWA13Qk9P
TUILVWyrgmJC08gFrBbbX0+1DQ8oVQ==
=nipF
-----END PGP SIGNATURE-----

--Sig_/m4KLJkG+F8mavPbfON_4vO0--
