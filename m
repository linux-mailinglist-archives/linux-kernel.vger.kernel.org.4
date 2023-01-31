Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5496838C2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjAaVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:37:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B86C1EFEA;
        Tue, 31 Jan 2023 13:37:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5z0Q3xgMz4x1f;
        Wed,  1 Feb 2023 08:37:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675201030;
        bh=70uPOttFwg2oCLYLtz9GLb5TnWu84Alghi/ju4dMvCE=;
        h=Date:From:To:Cc:Subject:From;
        b=aQ0hZa5CvnFcFI4CyxBbIu/TL2W1A/Tsu4yWDaA8Usp/REH0K+LtJBSrC/anUA+uX
         j6Gj2RrF+JYSVp/wJu5NsKvvgdkYfJcWrv3rF2qUCH4XFxTS7O86ePJ+BUZRxtl49u
         37jTurFDKfEKn1FH67b7jQzs21kGQA1eN0xOP/C0T1VbhOhDAeNsE4eC8kmEi5NyFt
         ZZVim0q36P4R9ysObNtdGkyEFeaNjmk5unZALDsQr4s3knAGpBQuGxNrG4+s9nCFOD
         Ux3uJ/ePUV739cS31jnfSA9VP10ipd2YiI4yw4cSEY3bMAc3DYnJgbEJ8QElvyKAyh
         dpkfVF8DHHr/A==
Date:   Wed, 1 Feb 2023 08:37:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20230201083708.4bf3b219@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SfM3rhZDisMD4zNseuXR5nv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SfM3rhZDisMD4zNseuXR5nv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0e1c26572546 ("gfs2: Improve gfs2_upgrade_iopen_glock comment")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/SfM3rhZDisMD4zNseuXR5nv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZigQACgkQAVBC80lX
0GwsnQf+KaGb5K0DCyqvZ3nhyHLNhrua3fI5ykihmL/2RISfldFcoUpY7lWoNFf0
f2jN8KskRHA1vrAUHgXk8i3d0eEauy464BlhYREYp9oElZh+PmC4cMUrqQju8RD3
3GLWdCiPShYiLX6n+m2K6W9LmELACejaY6zDZ9eXk0JnkbVJZDANP+E+3JtXHeyO
OuiwPVpDmkCJsL60idjvdVdimxWLq1t10GWzyBxdPDwf7b0uVKYhM5Mt//TXjPDl
oTLnCqkAEcnXduaOayaQ8ya80HwlpDBJmSLyYW2mL6giurJS3vWl8OiPs9sGb/Tq
YJKC7Ra/JJQtT7JqA3/8G9MMA56DwA==
=XzUK
-----END PGP SIGNATURE-----

--Sig_/SfM3rhZDisMD4zNseuXR5nv--
