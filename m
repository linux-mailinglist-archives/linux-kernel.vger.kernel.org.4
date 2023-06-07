Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619887252E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFGEfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFGEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:35:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35219A4;
        Tue,  6 Jun 2023 21:35:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbZJd45N5z4x2c;
        Wed,  7 Jun 2023 14:35:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686112513;
        bh=iqhGsOdNkB4BZgM6RpJLFNNh91haTCn93KcBqMa2SRg=;
        h=Date:From:To:Cc:Subject:From;
        b=kMik/DrU+2Q8IVYZFCDESBBd6CS5EDW4IqG5ZiABD48SDUI82Qe08bARi/KjbEAlK
         EmciNjorUv1dWC44OHmtQBRhKnIbv3QShofH8t1qxlcCDOiBznM3NVOa8lBWggyMOy
         9rDvTGUvW7KsUmB6yPrxfuqiKsfuFe55au/bAzfhSsoNKlPgs0zDu/oZ+QAergt+X8
         Qhp2gJtWzAe+asyxyuZqYxIY+w+rcuH8NnWgU7V0MTDSFBnG4b/ZaRgOzEHo94Es7F
         myNrMcsIRmAoW/pD9zqPrIq1/8i0A0l0OST0/r/gb0mY1SyFvev7UBHaxsOW1sKrzV
         4UVrQ/NjotL+w==
Date:   Wed, 7 Jun 2023 14:35:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <20230607143512.109cd8c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BHUENl5S=4km3I3ZiQUO9SD";
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

--Sig_/BHUENl5S=4km3I3ZiQUO9SD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ade5d74c84d4 ("lazy tlb: consolidate lazy tlb mm switching fix")

Fixes tag

  Fixes: a665eec0a22e1 ("powerpc/64s/radix: Fix mm_cpumask trimming race vs=
 k>

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

I guess this is just a quoted commit message in this commit message that
has confused my script :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/BHUENl5S=4km3I3ZiQUO9SD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSACQAACgkQAVBC80lX
0GwoIwf/ee99PttqQRpP/wyg+CQr4NQ96qsRfQICMsO7IrJA59AzQd0GRn7tb7DY
sgkePdYZKnEtnE+kfo+XH3wfyCZtlkOlVc6SN9jIvaTzYX1mQ2I7+emp5BaHSse7
5vDZKHUIPH6P2R18x2Eo7TLDJWDbWJr+zEk1GlZ/7TLRbJwkmo4O7ldRp/xEucEC
Q6JhTtyBLYEJ+uNb3pFdWSED8BEaU0IPr3N9+T2awSh5+4eCp5UJXVm37T1ym1GC
yMKpHDVBa/GYuaNRcIzmzEgQ+8gCSxHBFBIay/UCoP3TZdquwsQXOlf8AweWFbqO
VmJ3wWToHfo6ntaKGpfaMm3Qyq/5pw==
=qN/p
-----END PGP SIGNATURE-----

--Sig_/BHUENl5S=4km3I3ZiQUO9SD--
