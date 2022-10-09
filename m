Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B55F8A24
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJIIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:35:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF02A42C;
        Sun,  9 Oct 2022 01:35:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mlb3T6rnbz4xDn;
        Sun,  9 Oct 2022 19:35:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665304550;
        bh=MZsGwng4QReW8FUq+LqjxWdqB/upELTg+Vgo70MKJPI=;
        h=Date:From:To:Cc:Subject:From;
        b=PP/Z3w73tBScFk+ixLyNioK/feFWeLVWjn8GJQ2FqYo/MokNfJqFSUgpIaXEfzlzq
         R/yfAAfgkauwTOBFAHZYS9F27QahcxqDabSU/7P9bCR/JaIf49gV4Ob7aYg8UTXkr3
         D76u4F7/iD6EwA6o+1qbWRwpAeonhND0F469ayzbJb9nJDRUOmDo2SHVonVrNBJwZ2
         DMUL8FVb1HIjnRxj/Q55CHxe/ItqJKuKww0boh9XS4kwtSCPa4D1oYJxWrRwJVUBoo
         kCqDgAjbStifmKfAD64/kyF7vaUiZUEITIBTZ2a608shIZa6AELkzxt2uQZuJTg76F
         s0kSc9WRLqCig==
Date:   Sun, 9 Oct 2022 19:35:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221009193544.27055db5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C13FEtfwoFhTURdSWqel2FY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C13FEtfwoFhTURdSWqel2FY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")

Fixes tag

  Fixes: "hugetlb: clean up code checking for fault/truncation races"

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: fa27759af4a6 ("hugetlb: clean up code checking for fault/truncation =
races")

--=20
Cheers,
Stephen Rothwell

--Sig_/C13FEtfwoFhTURdSWqel2FY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNCh+AACgkQAVBC80lX
0Gwh6Af/XCxeLnwUeTno//GxKWX8Sc7HGvoipDq3zyRDJLzbkPx8M0twVCt0bwGP
fJTVW3VylzIl0a6X8NiIDeRX/mAek8SWPOXx+zm/Q6+yxa31ajR7IBEIbolE4Tni
V874n+OYYFed5BMVTBp4memFBCABD2nYcyHP/3CZr0PG+FeXWlBIXVf64xioWCuX
+5Ns6A3nV4F+HljhBXbZVIzctJ4kUQF2/qPn75QWvgVrxip3QLYJ5PlxQPTjvF88
tcSh8jky5I/URk+Rjn4giQNdnt10EZT11pWNFBrnBrqUyDUhVsrkF/AwsR30rk47
/NTvcvybw7r5RkHX0WSeqFEuDetncg==
=AvIV
-----END PGP SIGNATURE-----

--Sig_/C13FEtfwoFhTURdSWqel2FY--
