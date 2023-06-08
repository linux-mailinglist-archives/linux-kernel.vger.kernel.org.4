Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3D728B19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjFHWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFHWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:31:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51D26BF;
        Thu,  8 Jun 2023 15:31:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qcf7W5cg5z4x3y;
        Fri,  9 Jun 2023 08:31:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686263463;
        bh=dnfQY9QlabjkPv5G7rUEJMwBoP4jcM89U4r5dgVvC1c=;
        h=Date:From:To:Cc:Subject:From;
        b=Kx55z9JwuJ9YcaXej0IZDMd4KoJUYHI4Go1yNneNgJLM3n7F2ACk9NH9HewB0+QJF
         9zg3C+z1KlO0wR44Lu5wCXverZsL3m3/V8GoSLzCPIHnTYFLtLbtBm97ExQ09yCTOm
         J2GnrGBo6+1BODioiKdQN0Sg2iUgxp+0x04ploUnhPBSK6N3nAihq+gpTyQ+0/y8Gi
         ANIHjvKPmkIpuzm6pVNXfo+ALLA531O78ff61EBlUulIc+a0jv/pO4rAT8qrotxHnm
         dCUCtQ2k/HuQdbP0YGR+qocf0gXGnnrcW1tnHpxve/fV94Kn9W+/hxDB0sWu/1pWjj
         ZnPgVkWWyF77w==
Date:   Fri, 9 Jun 2023 08:31:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20230609083102.0a063bc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RLWHBOs4dEo/cnrQkjTJ7nt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RLWHBOs4dEo/cnrQkjTJ7nt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

  bc6edad600e6 ("selftests/nolibc: make sure gcc always use little endian o=
n MIPS")
  15f57edf4753 ("selftests/nolibc: also count skipped and failed tests in o=
utput")
  87c76b30c631 ("selftests/nolibc: add new gettimeofday test cases")
  168bacf2b889 ("selftests/nolibc: remove gettimeofday_bad1/2 completely")
  b58a501ed987 ("selftests/nolibc: support two errnos with EXPECT_SYSER2()")
  5b654b2c0284 ("tools/nolibc: open: fix up compile warning for arm")
  a50316875429 ("tools/nolibc: arm: add missing my_syscall6")
  1993d9c770c2 ("selftests/nolibc: use INT_MAX instead of __INT_MAX__")
  fc41c241d79c ("selftests/nolibc: not include limits.h for nolibc")
  a8b20e76e877 ("selftests/nolibc: fix up compile warning with glibc on x86=
_64")
  d785d831bde5 ("selftests/nolibc: allow specify extra arguments for qemu")
  df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
  3f83dcdf4fc6 ("selftests/nolibc: remove test gettimeofday_null")
  a54457590ece ("tools/nolibc: ensure fast64 integer types have 64 bits")
  a232f7f31314 ("selftests/nolibc: test_fork: fix up duplicated print")
  c79ff8143435 ("tools/nolibc: ppoll/ppoll_time64: add a missing argument")
  b1f9a5df6b53 ("selftests/nolibc: remove the duplicated gettimeofday_bad2")
  b38d446d8364 ("selftests/nolibc: print name instead of number for EOVERFL=
OW")
  37363156afc3 ("tools/nolibc: support nanoseconds in stat()")
  6a1935f83840 ("selftests/nolibc: prevent coredumps during test execution")
  6066aced432c ("tools/nolibc: add support for prctl()")
  997c1685b7ec ("tools/nolibc: s390: disable stackprotector in _start")
  4eb9ada569ee ("tools/nolibc: fix segfaults on compilers without attribute=
 no_stack_protector")
  be5547775590 ("tools/nolibc: simplify stackprotector compiler flags")
  ea22ffdf3acf ("tools/nolibc: add autodetection for stackprotector support=
")
  92b85d2cc2e4 ("tools/nolibc: reformat list of headers to be installed")
  af29d2e6df83 ("tools/nolibc: add test for __stack_chk_guard initializatio=
n")
  b0e9a86caded ("tools/nolibc: ensure stack protector guard is never zero")
  f14f35a85ee6 ("tools/nolibc: x86_64: disable stack protector for _start")
  9d15cbe52c62 ("tools/nolibc: fix typo pint -> point")
  340529052f74 ("tools/nolibc: riscv: add stackprotector support")
  9b80e2f60acb ("tools/nolibc: mips: add stackprotector support")
  58ac7b1823c7 ("tools/nolibc: loongarch: add stackprotector support")
  3259f396c0e6 ("tools/nolibc: arm: add stackprotector support")
  8411f6ee8393 ("tools/nolibc: aarch64: add stackprotector support")
  8c9ea6b3d1b7 ("selftests/nolibc: reduce syscalls during space padding")
  6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
  5f97e9feb11e ("tools/nolibc: riscv: Fix up load/store instructions for rv=
32")

are missing a Signed-off-by from their committer.

It looks like you should have merged someone else's branch, but ended
up rebasing it instead.

--=20
Cheers,
Stephen Rothwell

--Sig_/RLWHBOs4dEo/cnrQkjTJ7nt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCVqYACgkQAVBC80lX
0GzjVwf/T0XHzMbQ7VskTL9LtvAdJxgD+2Hmv4z0b2Dzx+N9Ocwv50j/YkrCl2qp
EVcg8VbVsbmHm9WjCI9Urij9a1Swnilhmt+tFE1S6GfJYfc2HJFxC/PCpcEL5quU
skxNUhLNz22feJ+twzoID/PsWCxQpjCA2gDYoWRk/oJuH7gaa3zc8rdPbHHIjPNv
koUwor/T4QCUA+c/zxc4XuTu2xiuRNpV6sN7T8Mk299Aj+R2yV3wVB43gBCNcwfC
PZlU1Ny93OVhXj5ALbZBxEgpjNI1xWdDUCB/ScJp8QpHEj/5YuvMu4YuCLR1fEha
C6z5k5n1IDkee9rLCegGygcRNl6LPg==
=gtoa
-----END PGP SIGNATURE-----

--Sig_/RLWHBOs4dEo/cnrQkjTJ7nt--
