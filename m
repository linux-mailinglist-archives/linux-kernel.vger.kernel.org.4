Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0073EEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFZWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFZWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:42:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC711D;
        Mon, 26 Jun 2023 15:42:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqjX81hgtz4wZy;
        Tue, 27 Jun 2023 08:42:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687819336;
        bh=r1sHB9ADqHDtSLadKtB/kb5CNRefRFQiD6mixd4qz08=;
        h=Date:From:To:Cc:Subject:From;
        b=n5nZuUYagptH+CKEYCj450QBlSkL0de8tgU3LzyP4esO7T/ASIxWriPQSB+o0ftnV
         U6uX50tRn14k/74kz7RNqYwmm8Ga/Sk+2pooq1IIj9n2sH2LNNBaEboyrSrq+KA9X0
         t7FyhPGHA6b09FMKj+T9MeP0DlMHZvLyEaJwa9g5MdtBG7YyULcv+SVsffzpLMpVCG
         6O5D1iWtW/agSm/wkL5J/jX5ipU+usfqS/Clr5VPZKP6IHE96yo/v4kHQPJ+mo5Pat
         UslnMDKnJHoW3BfLT3BlYruBefnm5+yRjE9xrlUv4Yg4qrLnKZNsQiKlk9k49WTjNA
         H90RUXuHltPPw==
Date:   Tue, 27 Jun 2023 08:42:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cxl tree
Message-ID: <20230627084200.4fe0a4f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lXua+zS6ZfZJ/QDBxZKpWZV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lXua+zS6ZfZJ/QDBxZKpWZV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8ea9c33d48f2 ("cxl/mbox: Allow for IRQ_NONE case in the isr")

Fixes tag

  Fixes: ccadf1310fb (cxl/mbox: Add background cmd handling machinery)

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/lXua+zS6ZfZJ/QDBxZKpWZV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaFDgACgkQAVBC80lX
0Gy4zQgAhgNl09KNd2UtYexTy0J4uFG5Iq5QqwEt1iIA+kUVs4j0rJj91pSFsJ7U
THmtMjs9ySPpB5ui5UzLbL5MdxOPrR3kM8bRYY7PTDP/CG7bQlZkz1KWY3Z9SJLN
utZ9hC/sRp/rc5BbjHOygMUS41YFS4uOazK08iayNSOUQ2aZN7rz3A2jdHIn/ADR
NCueuqQGLGiBG1cWq79RiKw1sM/9Gjp3kejEXlObJh6mHgmCO5gFaN3tkH3V9Nab
gMYWfSa2DVi488oUnLahLmYVYmd8mpQ8Si8dYU/xbVi2OOVhymyiwAISMhwbXUSX
2DsOvjdj0bH1OPEAcQR4PHX8CkNV8w==
=OGzp
-----END PGP SIGNATURE-----

--Sig_/lXua+zS6ZfZJ/QDBxZKpWZV--
