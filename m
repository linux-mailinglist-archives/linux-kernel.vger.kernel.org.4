Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1A6C5D61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCWDoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCWDoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:44:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA32A175;
        Wed, 22 Mar 2023 20:44:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Phrmr2QBvz4x80;
        Thu, 23 Mar 2023 14:44:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679543052;
        bh=T6P6+FaG5sQg92MxJSM1Agy0YCJ0Zaw8cGf9eRd6wPk=;
        h=Date:From:To:Cc:Subject:From;
        b=ck6ww2D0OOa0wDniyFCCPP00nPdbyVTGi3nOQUg4V+yhghkcgSTyWp7KogEE5ADd/
         xcG7QyCr59PzC+NYGe4nlqkFi+WvaQeCCi9dBSduBu5jQXBmfmNZ4LTZ8aVJOyscUR
         GyaPDi3AOmYQexahss2U/PZXR0hawGx02qqyTnCKXNkkY9uJwLhKjY8rC3uSBAve9B
         0yB0zfmLA8Z/izjBCA9AtJyY3u/iXmLv81y5g2tqQGS+3xDKlUEH3N0NasRNu/QzWr
         ajnzrgV0yk9SchYG7aT3zbjl0yrp05HuvAK8R5ubw+9z3DhB1Uot5IuLeW6xcVrpGT
         +9uiMEOXe4m+A==
Date:   Thu, 23 Mar 2023 14:44:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230323144411.0edde523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KN+R90dIzicIqG3biaq8pvd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KN+R90dIzicIqG3biaq8pvd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  d70e2ecbc726 ("instrumented.h: Fix all kernel-doc format warnings")

This is commit

in the mm tree

  fa7596e30b4f ("instrumented.h: fix all kernel-doc format warnings")

(and tommorow it will be commit

  ce5e77e7b2cc ("instrumented.h: fix all kernel-doc format warnings")

in the mm tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/KN+R90dIzicIqG3biaq8pvd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbywsACgkQAVBC80lX
0GyzVAf/XP/u86e4NbogNQ2wspZ4tcOeVmSu394LEkOL/kACjXnEkEcA7EXUqVqF
fdVfOr7ViZeli51WaVIA4b9RJAWEyBEb8bjCunL/N82P8lJcGDLsziSaC8FWk0aO
mA61djuP5baq5+VdW5E8RxCcvfH7SXjUH1Uj01jVGx6U8hVzq5zWuuJEpcdJLiNe
yTBmotWvSIXt9u85mvVnwU1/gS7RhyhhV7HOhYiLaaNxMrKHEjpnDyFfFqa9QqyV
R/+Awp3iEkV8JcQC75rcKThTzLyEHujeDuqOdRp4kt5XWIcUg8qXo/iC3YcDWXq0
wz5KRvHHTG04z9SEkPbQbKB7pk7dHg==
=8Wxv
-----END PGP SIGNATURE-----

--Sig_/KN+R90dIzicIqG3biaq8pvd--
