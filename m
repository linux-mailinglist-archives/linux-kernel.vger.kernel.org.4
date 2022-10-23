Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA9609655
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJWUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJWUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:55:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9A43314;
        Sun, 23 Oct 2022 13:55:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MwVnw5R9rz4x1G;
        Mon, 24 Oct 2022 07:55:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666558501;
        bh=4KOcWjIHUV+bFt3KF/p0g/pELvGUf/h9QNWfEapfHIo=;
        h=Date:From:To:Cc:Subject:From;
        b=DmSIjmYFMoxHlMHdOasMqarWVkLocx/+LSoORALNBGYbfRBTE2aL+FEW4LqMZrwh+
         kl3DGT8Y5s0MZtJ+YkzUW2Z8PAE4s1dXsgvdMo6LyDN3Vu12id7Yk3O6EaU/8RkJMW
         Dr85LTNv3Cf9uOgCJzK7oMZhAyd/nySDGQkwf35aaQruPPKiFEbPXVTtM1Ju3xcJ40
         0TuAjkGBVpsgc0iEVpIq4tjmsNuM1lvdORA7nu44fSvgXppuMdjdrvDQVFxww/Ar4f
         paoac2dG8R4knYxa+yTSnBqsJjuslW50YVPxzHyzTZZBnmuNm/ct7gaHQpHJth6GAq
         DCCts31hxj7EA==
Date:   Sun, 23 Oct 2022 12:48:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild-current
 tree
Message-ID: <20221023124810.51b1201b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rkahi.Q2swWNgzpz6S8fIIX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rkahi.Q2swWNgzpz6S8fIIX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9a21115ca50e ("Documentation: kbuild: Add description of git for reproduc=
ible builds")

is missing a Signed-off-by from its committer.

Also, I am guessing (I haven't actually done the build, yet) that this
will produce a new build warning from (e.g.) "make htmldocs", as the
underlining of the new "Git" header line is longer than it should be.

--=20
Cheers,
Stephen Rothwell

--Sig_/Rkahi.Q2swWNgzpz6S8fIIX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNUnVoACgkQAVBC80lX
0GwoBQf/e7mzHvNQ9ceEhk9YWGqwA3yaSFUzpqgbQbthaSd1RqsH5tzaJsHUCiNz
mdIYsorHJPaPEXmBKpDATA5OQEuwVVUvv3uyrifMRYBuwy7Nz6VdbeqNNpWdMjhM
KFjN3ROWoqrEOb2NFHFFCdFuE3eG80I9CRR3LQMUjbOdRg6Tit9VC/35k0XLwzVY
bPMDuSgTmKNXe3FDV+Yh4ZSaFQu9PerDRnmU2blDd1r32LCIvFbOjdffoBW5leCS
VpI0xd+zjO5KCXnaejcZixLaorvtQBM3Naj06Kthy2t8QHbf04nAQ44dze/YpCem
Cjf0RqCIzGy2RRIQKI/SvbrJA7LwtA==
=5++v
-----END PGP SIGNATURE-----

--Sig_/Rkahi.Q2swWNgzpz6S8fIIX--
