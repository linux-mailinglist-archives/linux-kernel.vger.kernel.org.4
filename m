Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE169C4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBTE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTE3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:29:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC3C140;
        Sun, 19 Feb 2023 20:29:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKqFV0FLtz4x7j;
        Mon, 20 Feb 2023 15:29:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676867374;
        bh=c/UYeEZhO3mrQLXP6wZiZ87jHlddci3Xgxct3eGLXQk=;
        h=Date:From:To:Cc:Subject:From;
        b=rwiKCVqMahljFNOJ/mVD32xac3IOmLl+/Mi1m65kf0ltU3/3PoN3csfvh7ZSg7cdN
         Tg+/OKtQzdoFC88BEAu2B77i0EBpinRr4UcqDyGmkGwF6pS6zy4Si5veEunmavEVji
         5jQB1G9B10Aar+7LhYHu/5BHuRgROzsC7+cirrHsSVOWpOiGrU5tqMk+7mPDuyyrbY
         17KHMIucqX/6wiR59KXpvgzS75JrC1NWEUog1fGCuFkvNPUUfFO/5XSaZ21UbQQnGE
         F+tfzFKoQ7VBmYcUwVvHt3jW7XBV+NPW7/Nj7X4CRrIc8+WL6qaCkSIDqL4su0lvRp
         R/G/IuJ8nGbPg==
Date:   Mon, 20 Feb 2023 15:29:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: linux-next: manual merge of the mm-stable tree with the cifs tree
Message-ID: <20230220152933.1ab8fa4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vz0IgLi+f8R4EKrFgG_x7Hb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vz0IgLi+f8R4EKrFgG_x7Hb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  fs/cifs/file.c

between commit:

  c8859bc0c129 ("cifs: Remove unused code")

from the cifs tree and commits:

  4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use filemap_g=
et_folios_tag()")
  d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")

from the mm-stable tree.

This is a real mess :-(

I have no idea how to fix this up, so I have used the cifs tree from
next-20230217 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vz0IgLi+f8R4EKrFgG_x7Hb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPy9y0ACgkQAVBC80lX
0GytgAf8DtAKuMSF+LXE52GNTHW2hoAjSgAYVNWebBdj5C1P2+zDLmNfphVj7owN
11k6PW9e5zISPcPtid8Kng+b95OjvxYhNMiPDgqwvi7tfdhM779aPWmewDM8gh6D
6vN/08BBD0d2QIJcYuv57jfWdOv36SySaIFSRs+fDpykKM/cwiYYUT5RZWZ+fKJ1
RE7KTr91qSsSeC8mnCNa0Qy2EhoUJVK2+GsLG56VXUrZzX+QMgpR9LgcYrlaMdl/
PCJvrMNyYTqHHBzO+N4uJ6ZUTlDoZHevMp5Vmy8lm2IYg4ZeKElU2xFEyl4jmAru
uk6wRwzFRxFeo/acSRH5fM2PAbWqcQ==
=PuCQ
-----END PGP SIGNATURE-----

--Sig_/vz0IgLi+f8R4EKrFgG_x7Hb--
