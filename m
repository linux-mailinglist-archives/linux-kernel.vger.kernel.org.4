Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F164BE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiLMVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:34:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0824BED;
        Tue, 13 Dec 2022 13:34:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWsG31rFfz4xVH;
        Wed, 14 Dec 2022 08:34:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670967275;
        bh=q9NPhH/2/2nh2f6LGqYKrk6aHHA/IEOeaosLLSwo/NQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RcSmbroaa0ZwG7mKJLQwPE71+Ih6WeHnoF3rd6xJCoP239E6okHPCW3o1SIG7QFsI
         238AAKY6aVCt5yFryVyZ3bOW2zxSuaRE+iTJTJhyHmrlREOfM9lSjZxcfwqm7AIFUj
         dLX3gGbFY18cpaxVr+02Km6fuAGAk70m7OPKsDqZB5KYNmJ2IAReYrc8MaZzZ/fbDP
         BfBYftJr5K29yGsYrZpoI+9RRr8wLqxVZ4wAETc09C/Rv1onmp/l4hHDAdVS+rjI11
         IkAbdZhibvI1D7D5hWmKGJx2elAyuZcNGy+JLHwHwaZUDXDYlFra/WG/hjt0DQGOvF
         MzyuMzf45SUBA==
Date:   Wed, 14 Dec 2022 08:34:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <20221214083434.4616378b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xAf1HLKvZbVue8+/8SHJrg2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xAf1HLKvZbVue8+/8SHJrg2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9e03ed43cd4f ("perf stat: Check existence of os->prefix, fixing a segfaul=
t")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/xAf1HLKvZbVue8+/8SHJrg2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOY7+oACgkQAVBC80lX
0Gyn3QgAhqP9/P72VovGHGa5yl4o/y61alsjV3sIO95VmJsz+j2ubJ5u9kel5v+W
wo18B7p66NKuSF4H4CpiTckWLsf4+JKhX58idoeWpDFNzEVaI2n9cQ1L6eTGgQx3
Jpa1/Oywq2VdvoKUfvQhyYh3EAn46pS8s7anuqB9psprv3S7QaxoylyO6E1hKuZi
Gr5OA2vOj+m1OKzvo/ZP267KwjAyMae7b3ktXnajbtZPpQqiWrA0su0j6amYH6Y8
A/GEaUpY7DZf4HCV1OkfXukBwtP/zWc2NIo1ei10W4DdrI7lFRqv4Foj/CodZZj3
89mYB9SqmlKI2gB6tbOWh5pXHtDBtA==
=jv2J
-----END PGP SIGNATURE-----

--Sig_/xAf1HLKvZbVue8+/8SHJrg2--
