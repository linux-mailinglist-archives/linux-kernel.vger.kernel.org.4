Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2D6BA139
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCNVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:11:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37F19B2;
        Tue, 14 Mar 2023 14:11:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbmRK1gtyz4x5Z;
        Wed, 15 Mar 2023 08:11:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678828286;
        bh=fIQHoPSvibSHu4TS2oQgYdG05lQ5UrRwOyPQIAqWekc=;
        h=Date:From:To:Cc:Subject:From;
        b=X82blIAV7ew2Q04lc6Uu7b29oO9XDxdBH8mwaZDMrHhTVQlj7fBJvwQmTb28TG95R
         3HW+JBnzlfifs6HiBCGdMwvGCoSbCpX6HFupeK4M5vO5d3r+vSREjBzHByfmBml25C
         YMF1uz2RbUByX2PG16FZ5WLQqr/MEFRMaT3DTUwaomVLO79NP8r1m0Q+cCKE7KLZjb
         ZMwm1fmR2hEeP11zjI4s0UGVmaviVqImpVeWUGkS6TbjJCWk766ib92A7fnnl+L+5p
         erQdWCBxbD4OzBykCL45AWi7BNY76dhC1PJktS0Ew1zvXKjKsPUU8VOfgdUlXo1uuO
         EGvNIuwnZI9Qg==
Date:   Wed, 15 Mar 2023 08:11:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tzafrir Cohen <nvidia@cohens.org.il>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the kbuild-current tree
Message-ID: <20230315081123.704ad19b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8KcUd3sAQ9t+LWh3nI0QFip";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8KcUd3sAQ9t+LWh3nI0QFip
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  51ab7ee81f5f ("Makefile: Make kernelrelease target work with M=3D")

Fixes tag

  Fixes: commit 1cb86b6c3136 ("kbuild: save overridden KERNELRELEASE in inc=
lude/config/kernel.release")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/8KcUd3sAQ9t+LWh3nI0QFip
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQQ4vsACgkQAVBC80lX
0Gz2FwgAkGjcuyCXGsXupTn65rBKzbAlFMJOf7aASOB0z7gz+psjsjrrp6npaMkQ
9HSQAbQBpTyjhzp/iFxNqL5hNUCSk7uua3QLzSlH/p/Dz9C0WXDuRnt1kSOesYoa
Ni3DEk68yOl8uvpF4zIiNZZ2j07KsG/BKyqzsK5N2zoT/WQZ52pkF/TZ9Z+aLyvN
Yreip8Qr6unN/FEV/FqNpbf0wuzypkD3w2ijTmpc68vNfBMMSfzghGWx+E+QWgnn
lQvKYkgg8NHjx72n5uDb6II0L7079fholEV2HqeYJPVlTFjFhntW2RXIODM+cikR
k8uOC6FH1dxRmFcUQbGbTKRg8JtbBQ==
=zY/L
-----END PGP SIGNATURE-----

--Sig_/8KcUd3sAQ9t+LWh3nI0QFip--
