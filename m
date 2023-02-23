Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78E6A11B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBWVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWVK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:10:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47A61EE6;
        Thu, 23 Feb 2023 13:10:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PN5Hw5ZD0z4x4r;
        Fri, 24 Feb 2023 08:09:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677186573;
        bh=IjET4LaTsMosOZdyCGu9jMUfom0oOQ8pCqeH0r0uRLc=;
        h=Date:From:To:Cc:Subject:From;
        b=jSFBIoA6Bs5zddJ07S4GFD43qZYp39wV5zYHksxhhMdrsu7y+K+wjcHTFMJtNzZ8V
         6BirU/r9Df4wPmrP1NXBjkhYgZiQD+zgLCdQ8LNmOnQLl6QBteAN2p7NHhj+fx3NAe
         YD+h6FFma4/MwUZzpQOX9Fyx2F6CyXTfj6yl94hu2Qdrr8p9Sf03guWUaT7dWhfvmH
         32lEnzhNj7GYfSsml4TM3NUPpwrHPmyfeI2METBydkeCRGz4y4TfoAtT/szhHJnj1a
         zCbzq9Xv9WeFEavHYi/I+oka9jWQsstUQ1zd2bYAU/LLb7Q0APHkQUD+6qmK8T67KW
         xMj8e+uotPD+A==
Date:   Fri, 24 Feb 2023 08:09:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20230224080931.6433105a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/00Yl2C+ngHrtSKek.=3.r3=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/00Yl2C+ngHrtSKek.=3.r3=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d7830041d59a ("cifs: Add some missing xas_retry() calls")

Fixes tag

  Fixes: 5f0955c98375 ("cifs: Add some helper functions")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b8713c4dbfa3 ("cifs: Add some helper functions")

--=20
Cheers,
Stephen Rothwell

--Sig_/00Yl2C+ngHrtSKek.=3.r3=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP31gsACgkQAVBC80lX
0GzlbggAk5m2l/jgc0RZVN2QrEW171HecCxLgCYbXqs00caVvWVmy+ylQtCMbx/Y
htea2PICrsdlt1WctDvgWbQGlWD+LhX/N/xJ6LammXbkoq2IuhMxNXT6OHyvcXSN
APQJMIJfMkKsVSTeByYRCUkPDRwEUa3yvGaIYHkDwIvbwAGnTfEWuAsSfOP1VQuh
cIzSCfFQtdTSoqZSr6O1tQiwHY7NbeIxcnJUoGpXGTwt8aIJENbRdoBNpsZcAhd7
x5O4D+UcnEnU0RWnoPgXN42jTHr83QrQhgwvXl+e5Ko09BRDwFo7uEEe0YWj2sP8
3wayqxchWCFbUBLFjFO4j1Xpq+aSqQ==
=7HPT
-----END PGP SIGNATURE-----

--Sig_/00Yl2C+ngHrtSKek.=3.r3=--
