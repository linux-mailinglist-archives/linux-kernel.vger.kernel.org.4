Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533186C5D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCWDrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:47:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA002CFD4;
        Wed, 22 Mar 2023 20:47:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhrrP6pj2z4whr;
        Thu, 23 Mar 2023 14:47:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679543238;
        bh=/oflFH8u0+y3EDIAa+W0ZJ3fJxp0x2wW6jB5mSBm3Ow=;
        h=Date:From:To:Cc:Subject:From;
        b=FXL4NT5tn7GakfxMSUzZk88+F2PwFb+bD9thFm6M7pbHNlUhcqVCCePwRq98zAkgO
         7rc3EEG8QcpxQeukG0+gKDT6X068480BpdBG5psiW6XP11lpgtGS0MATkSuyyuf3rW
         wrNFB1wCGkmjicCyZevdxf6mSqt2A6IDRdet9JtLzMw6XbvnabY86wCyFuCGUzSpJf
         itYbUWt8kLS7UJ3xv5IOqxXp+kDv3MoR9grEUbPtXnuCeQOgxHpGDR3YLaQ0bA4ez2
         Uo1cbnN6mEtR4VZpC6DgIDT4OWb3tcZ+Afuz/a3j3Cv+RljA9unNJPk/nLMbigPBww
         t9tu6dAsc63xw==
Date:   Thu, 23 Mar 2023 14:47:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230323144717.6346fdab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=336hLObrJMP10vgGOJ4oA3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=336hLObrJMP10vgGOJ4oA3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  f339c76cfe29 ("entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up")

This is commit

  b41651405481 ("entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=336hLObrJMP10vgGOJ4oA3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQby8UACgkQAVBC80lX
0GzCRgf+OLtQOPpY9kROnqISn5or+NWyxWuBmXhNq810Uv6rxI6USxqnQWPjBagl
8Msfu84mn/9s6olF6d0yJHJh1FQ9iwlqdKLtwLZTify4jNJmyvE0VC48ZPK22+l2
p7ZYauf2MTzTWG/1SqVlHPx+qNw59vFEgnf8ab98JJZCi8rNBiAgBTT0j20rNMLz
IyF3uSlSpzSCdUzsI0fd2KAc89hT89pKGnvZ19QUCZ/mXAbQuZ+J3Gx42x/DsTZh
2sEbQfVKL0umtN5HKwV3NwrbzfALSO1DSv9MvTp2sj4Ib34s9wd7KrbeDsWIJFwt
p2IUtl7OhwjLzrOxY1nsarEZsFHOdg==
=UT0q
-----END PGP SIGNATURE-----

--Sig_/=336hLObrJMP10vgGOJ4oA3--
