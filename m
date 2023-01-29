Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A4680210
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjA2V5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjA2V5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:57:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9EB170A;
        Sun, 29 Jan 2023 13:57:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4lXy0hh2z4x1f;
        Mon, 30 Jan 2023 08:57:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675029459;
        bh=TprZzZlRmx1MMQcznzzLjoSYmA+RJQsb5MwXXe4BfzA=;
        h=Date:From:To:Cc:Subject:From;
        b=Pl95kkMzwA5vZaA91Okv4bb9lxi1lRB73XqhCQSU29FT8zVUyTcKlUsNE0rBtXWHt
         3pwZnCjOKL9eBFhTorT2Av93NTzSHUNIc+lyvTAbBoRaGW2u2F0wTjubN5ZtqrBUUG
         Mu/ujt5IJ3gNOJvO2dF0nffGKsr6IL/ov3XJaBueHu4rBMgm1wj0s+ox91Tdsdo6+q
         d1FSr8l5CzCxLVTpw1ZOPv8v8DSiZWKDPkfAm+19BflWC6wcbseNZCJdOsmlQAUCHy
         iswwErRjclxP/JprgHQ660tP8q+eJk++897YgrJdj0O58tdaPMKCx1hrwTZ0c0ZwH5
         LC4IET9DM8p+w==
Date:   Mon, 30 Jan 2023 08:57:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm-hotfixes tree
Message-ID: <20230130085736.425c0846@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.9/X3YAQSoPRTbtKuKUNrUX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.9/X3YAQSoPRTbtKuKUNrUX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  6db597d57118 ("lib: Kconfig: fix spellos")
  f21c83eb3617 ("Revert "mm/compaction: fix set skip in fast_find_migratebl=
ock"")

These are commits

  ca0f2cfc495d ("lib: Kconfig: fix spellos")
  95e7a450b819 ("Revert "mm/compaction: fix set skip in fast_find_migratebl=
ock"")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.9/X3YAQSoPRTbtKuKUNrUX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPW69AACgkQAVBC80lX
0GygnAgAgGTNpMjs0Awn3BfFfmKSWvGNwl85AGGvzLe3dVrAJw04g9ozsoAQsnSn
YbaGCsT7mKQF4FdgtzZxMJU8604jNJmXP4a7Qzpt3ZiqfmocvOexabwss/0N7Nqc
bgviJH7c7EiDamYzoBeyYXzDOV6CW4eBwFr9lKItxn5X0RUm97mOab7EaQUDOUjC
MJ0Jw1GqZsP6X+tJOwuC2hCObQPubSZuoQ3d0TIrbZl/T8b1Fhbzqm0JNj8CJplP
dMN7mf41BoVwPMbdrIMp3IzEpQJId259DW9bEqC7yYNLRH1iavbRwg06861UQvHi
nxyHXUzAS5ywp79Yj6kdwvSEQu6CHg==
=wfZl
-----END PGP SIGNATURE-----

--Sig_/.9/X3YAQSoPRTbtKuKUNrUX--
