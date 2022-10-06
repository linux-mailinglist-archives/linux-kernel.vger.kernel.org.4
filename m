Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A125F711D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiJFWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:25:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622EC5109;
        Thu,  6 Oct 2022 15:25:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mk5c96hP2z4x1V;
        Fri,  7 Oct 2022 09:25:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665095134;
        bh=WItBWR5VdZOwUNQvtjVFvL3cxTiPIDKBURswLB2Y0Yc=;
        h=Date:From:To:Cc:Subject:From;
        b=MHj76dkuR8itYSRyl2q8zESg6uAGL3+fih0lSoCdsjHaRnmdGt8Yn4p1hv2P+GD8S
         wph0uWdc05eiXAQzA7SLp6OWOs5ENANejC7KxC08IQYwvKeUsyDC8n4KopwV9WBh8b
         w92esPNUsUimS/ySiBRFSsWnWbNHYKj5Pmy2uxu9OStEPFV93OM/wU+wArqFNd/Qog
         TOoQmIZuuT8SqjbwW2ktEbFgjFpDUfgs8ZPsteK3nBINMYCAwGI3gTffm5Mr5k2llv
         uXUhebNBPHYcMiCcf/nFirJpKuQD8ovF8YPlc9+1nN6AWB0nb/DThuqp7Gn8jict/R
         4oZeLTZqXzouA==
Date:   Fri, 7 Oct 2022 05:16:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>, Julian Merkle <me@jvmerkle.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20221007051628.004a89d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EGF=xV7cIqEmPDoPFq3HMOM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EGF=xV7cIqEmPDoPFq3HMOM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  d07479b211b7 ("docs: add Rust documentation")

from Linus' tree and commit:

  0715fdb03e2c ("docs: bump minimal GNU Make version to 3.82")

from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/process/changes.rst
index 9a90197989dd,26a7fd875cfa..000000000000
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@@ -31,9 -31,7 +31,9 @@@ you probably needn't concern yourself w
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  GNU C                  5.1              gcc --version
  Clang/LLVM (optional)  11.0.0           clang --version
 +Rust (optional)        1.62.0           rustc --version
 +bindgen (optional)     0.56.0           bindgen --version
- GNU make               3.81             make --version
+ GNU make               3.82             make --version
  bash                   4.2              bash --version
  binutils               2.23             ld -v
  flex                   2.5.35           flex --version

--Sig_/EGF=xV7cIqEmPDoPFq3HMOM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/G3wACgkQAVBC80lX
0Gx0xQf/fMHBQuecGKnRAlr8EmovP9qaY90Fr+Wqckj+dEsK7nIabIG2aNENFgvT
gkBu3VgYHLDT383a3pnf8hJARzsezAGPLvy3mzuAuXgTb7Ob1gC98p8XCtZNOYk2
C1BjXURtUSux5D2I03zzoDgwtErrM6ffmLsaNDThr+3QnuRtf1tqtcznMGBtipti
4FU+Oa/r0xbLsakoZOuJs/m0YmiLXVLcn8M2YJYTaHBK3Gf2kkFMj1KU3B7ik7NB
eCnV8OR7Qc4lxcsxq/90y9SaRoAYjTWRm/1qFk9XzwTsWPOIPTFTc4bveULpRrXz
6lQhV+TK/18DTeDb1wfGxgUyXI2tiQ==
=GSlG
-----END PGP SIGNATURE-----

--Sig_/EGF=xV7cIqEmPDoPFq3HMOM--
