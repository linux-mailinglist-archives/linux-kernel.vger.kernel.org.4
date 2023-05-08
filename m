Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524466F9ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjEHEyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEHEya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:54:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980297AA1;
        Sun,  7 May 2023 21:54:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF88h1fCWz4x1N;
        Mon,  8 May 2023 14:54:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683521668;
        bh=od+nnw96aOvulVFXSLJMdQwl19UeeKedaONQos6fpU0=;
        h=Date:From:To:Cc:Subject:From;
        b=YIwHEviiywF4Irw6z/5UYY/MC+xLhunuJ81fFMduJzKMOEC1Bi4tHc/hhB4g4XLvz
         ib5a5rw8Aim76RQFkOc3w+dS7gIDDKjvn3vKauh2EfIJxCLAaLpypB1HdgzZ7Rmj7t
         oTqGy4zZFEnJHnUeejztkbZ29W5VStEw0ugWeQk7Ai5odXkrYqBdVexy9jljPENun8
         gsOCpDl07+7CK6q9BujB2v8FtpUH9C8+QMyPMzeqFbG30VrJE8MwZz62RF6GbM2BmQ
         7/lP2GmPpk4QBF0QLSO8QW/LvpNp0xxjqQu41g7vcBgovFOrJvTOn8vihgMLZbS+ex
         jLGkmontqwj4w==
Date:   Mon, 8 May 2023 14:54:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20230508145427.0edfbb16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mana=l6An1CPzs6t+izywDF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mana=l6An1CPzs6t+izywDF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
these warnings:

lib/maple_tree.c:6054: warning: Function parameter or member 'mas' not desc=
ribed in 'mas_find_setup'
lib/maple_tree.c:6054: warning: Function parameter or member 'max' not desc=
ribed in 'mas_find_setup'
lib/maple_tree.c:6054: warning: Function parameter or member 'entry' not de=
scribed in 'mas_find_setup'
lib/maple_tree.c:6157: warning: Function parameter or member 'mas' not desc=
ribed in 'mas_find_rev_setup'
lib/maple_tree.c:6157: warning: Function parameter or member 'min' not desc=
ribed in 'mas_find_rev_setup'
lib/maple_tree.c:6157: warning: Function parameter or member 'entry' not de=
scribed in 'mas_find_rev_setup'

Introduced by commits

  ef6a3f9e88a1 ("maple_tree: add mas_next_range() and mas_find_range() inte=
rfaces")
  3bd55a4fa16d ("maple_tree: add mas_prev_range() and mas_find_range_rev in=
terface")

--=20
Cheers,
Stephen Rothwell

--Sig_/mana=l6An1CPzs6t+izywDF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYgIMACgkQAVBC80lX
0GxjHAf+JrZpyt8WxRE3VrwlKX6pd/X6t/XMSE/I7krxGISWZykI3Jgp8HhWFpZM
LREogmxtAWVoPINrbuSDgPjKDX872g6RKuN3zoMyj/JKjTD4cA1yt8vyGaqOvDv1
BqVCovUKluTyb1wlAQYXzS4Ey//0SV0xG+5osRf2ISJ8ae09BL6nkXTrGBtbemr9
H0l1OGRsDW6epKrWurj85oSnT5q9G69pNnefY3Ehh1EkiSQraF+0qYOsk14I+kCp
4k13GtGRtKF1Wb/RhyT0ajvSpSEJJD7MfVzmkG8kjZdMNOB89ExupbPljosaLt/I
n5HnDLVASh04J5Ja4K3UCODulHjoPQ==
=YI+2
-----END PGP SIGNATURE-----

--Sig_/mana=l6An1CPzs6t+izywDF--
