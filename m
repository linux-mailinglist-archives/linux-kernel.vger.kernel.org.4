Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5274072B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjF1AXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjF1AW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:22:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915726BC;
        Tue, 27 Jun 2023 17:22:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QrMjk3GYZz4wZy;
        Wed, 28 Jun 2023 10:22:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687911770;
        bh=d9qp0w1IEjACU0PufpTb5hr6JpBscppsya9LwwgZR0I=;
        h=Date:From:To:Cc:Subject:From;
        b=UZ6woTnSQ68Y+EeWLNxpSR8+PiEUmSC2NSJArhBF1mEzlJB6Qnn0DL4SZnHpLfUdV
         DbQTEzLg1Z46PUyHF2pS/Sn2IK9A0pEYn4GzW/tygrkqVomYFF65nmIE1pvEt8W85Y
         Kx+UFm4kreRXmiF2HDUXnSrLSKKHGdNfx3+gG6P3psW5UUVABhTBSgNwNfqKWW1BzL
         ze8irWrodkcE0nLfrIPAViEVl3Potu09pW6fdISM2Oa+4x1zzELEnjALb6n0GCEjN/
         lcmIXQagxKN3Xthj8EAfj5WILwDJmuTsfoZImkq0idBAc1KWok9zz1HB/SI95SVxlx
         1D5Ia9P2ej7vQ==
Date:   Wed, 28 Jun 2023 10:22:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the parisc-hd tree with the
 mm-nonmm-stable tree
Message-ID: <20230628102248.742b79e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IuO7Y0SK43M6.niNEyTxPa5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IuO7Y0SK43M6.niNEyTxPa5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the parisc-hd tree got a conflict in:

  arch/parisc/kernel/smp.c

between commit:

  ad1a48301f65 ("init: consolidate prototypes in linux/init.h")

from the mm-nonmm-stable tree and commit:

  57d303096f1c ("parisc: Fix prototype warnings for time related functions")

from the parisc-hd tree.

I fixed it up (the latter also removes the line removed by the former)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

Not that the latter also adds a declaration of init_IRQ() to
arch/parisc/include/asm/processor.h which will not be needed after
merging with the mm-nonmm-stable tree (but is harmless, so I have left
it there for now).

--=20
Cheers,
Stephen Rothwell

--Sig_/IuO7Y0SK43M6.niNEyTxPa5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSbfVgACgkQAVBC80lX
0GzvvggAgKaN6cbQNB4fpteIWhjXWOggYF1vigsQ7RTSi9a3EMMuLBA5qveqey06
gnVRbOW82upgbdwOubHUOOcKwwQhCE7+xOGkOu1c426DPYuL9RESHDarxyfYkaDH
bSbdp8m28bkXl6WE4tidKrOMZ1qvRqsVakqdpdUnn6N6MnskNt4c2wDD7g/W1URe
d0LEAt+c2UctnZJKxq0N/zIAY/KM8SrcMm90xP5mf0owKnmmFqWZ/a+mUXznvuar
WIf/7q8VB3st94nr/wulHVlFCh2jwMidOVgTr1jpS9/ayJ9+cNUFlV63vf1jqa00
WsAT7crEvc62DuTyibNiw0Djp98dZw==
=lDyx
-----END PGP SIGNATURE-----

--Sig_/IuO7Y0SK43M6.niNEyTxPa5--
