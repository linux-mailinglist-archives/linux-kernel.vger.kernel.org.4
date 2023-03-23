Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DF6C7405
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCWX3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCWX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:29:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51F20A22;
        Thu, 23 Mar 2023 16:29:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjM3w71GNz4x4r;
        Fri, 24 Mar 2023 10:29:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679614141;
        bh=zWVOtnubuGpY6vM9+cJnPLaBmkjmhGS9e/x0/5G1C+I=;
        h=Date:From:To:Cc:Subject:From;
        b=ubiZSTbQ8wcpirrFumdM0QUwX1zaz4o+CJ2vQ3VbF4eoBjOHeBeK2SDEdUf/dt2Ml
         xYpmNLZ3uHlqDIgduFIM7qlFw4BuXsdYKCCZOwGWw/JLUn5RA4qIDQqQ1/mnY2RbQA
         bjI9l3AahxlPEzuyr2m/zX142qC/4vH/o5M36S2lr7nMpRkpBvNaPMzaetOwgoc3Z5
         lNyfLSGtaN8m1Df7SNRlU72JdeaosRseIgfHVdNszmofW4lVkowO86+I/WDXeDCI9D
         RDf+sCdcK98pfccRY5g/pHl5PDTIbQqO8mP8CktVFgklcRM5hmUNHDp9KLTR12HhPu
         T1YsL9VArT4Hg==
Date:   Fri, 24 Mar 2023 10:29:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm-hotfixes tree
Message-ID: <20230324102900.79c916a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vcky3fmO4BLW/46bCgeRaVd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vcky3fmO4BLW/46bCgeRaVd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  016d18d82af3 ("mm/damon/paddr: fix folio_nr_pages() after folio_put() in =
damon_pa_mark_accessed_or_deactivate()")
  0cc5b461e3bc ("ocfs2: fix data corruption after failed write")
  167d82643156 ("migrate_pages: move split folios processing out of migrate=
_pages_batch()")
  7a7e4a99aff3 ("mailmap: correct Dikshita Agarwal's Qualcomm email address=
")
  915ff6b52bad ("mm/damon/paddr: fix folio_size() call after folio_put() in=
 damon_pa_young()")
  a57f94e7f291 ("migrate_pages: try migrate in batch asynchronously firstly=
")
  ae79a7c87113 (".mailmap: add Alexandre Ghiti personal email address")
  dd1a9198be28 ("mailmap: updates for Jarkko Sakkinen")
  e0af0b9623f5 ("migrate_pages: fix deadlock in batched migration")
  f7f9c033b80b ("mm/userfaultfd: propagate uffd-wp bit when PTE-mapping the=
 huge zeropage")
  f8585f589496 ("mm: teach mincore_hugetlb about pte markers")

--=20
Cheers,
Stephen Rothwell

--Sig_/Vcky3fmO4BLW/46bCgeRaVd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQc4LwACgkQAVBC80lX
0GwEvAf/RLRFJpaeYW1lggy6ohsA/pFJ8dNimAF0/I5AisuuvwliFAkdni8acFV4
V01JAKIdKsxAiuVtYK892Czpg+LAgbs0Ovdfifgb1rM5JUe8wqkiY92v2piwOVRl
2ndFLj+O226CeGTFPZUWgEwOtojgnDzP6SjCJ+he3kq6jY+RiIFlxhi4w7qdWoLw
uJHOMbdkx8jgh4M2UR/4oyX/lf69cWrO0rQPxmZkSuULL8SVYmOzKehUTXMDRhLq
l1po8gaiNigZkY2qPnK3BTv43yKBQxUgTG6pfhYrMPWsnRytNUm4b0BQEyWBr7GV
MOaCHGXO9jrR8JNGNhasMAiMbIhlvQ==
=rHgj
-----END PGP SIGNATURE-----

--Sig_/Vcky3fmO4BLW/46bCgeRaVd--
