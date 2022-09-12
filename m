Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCC5B5550
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiILHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiILHZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:25:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55ACE3F;
        Mon, 12 Sep 2022 00:24:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQylt02bPz4xD3;
        Mon, 12 Sep 2022 17:24:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662967482;
        bh=XuJdmswV2c9gKv/M+vCiUz1quQEgRWkwa2BIYu3NDuo=;
        h=Date:From:To:Cc:Subject:From;
        b=QbmNV3BPYi9EDMrxTPhR1fDKDDEUXd0Gjr+PUYrETCVRfSPEHf3koN6KfeGc0Y03G
         OjsO8WIj2/de8SifY+ta0B3z/WTMW5lSMFQLysCipJTn1nyqSbbB2yzhGJulSMgEi4
         lvF9WBkz8PPClJw437dieITljr3da6IfjRw4kxR1M+r+7m/eKFe9ozrGgfMPscXUPi
         6Ty7RhyS6duAIpt4sN6qFeLlSCZqRrOB603HqcHv0oJv7gmbuFVd/zair4XUn2+pWP
         b0wWcby3OpRAB38D+YrjPMg43D4UqvXVDn50eGl2wFnGCb+V5O9OtsgRCl7AVz8eDD
         SgWhckxHSL3sA==
Date:   Mon, 12 Sep 2022 17:24:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <20220912172440.76a19053@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2GXH_jUKqkbhs2pRA7wngih";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2GXH_jUKqkbhs2pRA7wngih
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  MAINTAINERS

between commit:

  fa4b9df00af4 ("MAINTAINERS: Add Runtime Verification (RV) entry")

from Linus' tree and commit:

  fa4b9df00af4 ("MAINTAINERS: Add Runtime Verification (RV) entry")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index cfb38ad66cfc,263ff9abca0b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -17806,17 -17477,24 +17806,35 @@@ L:	linux-rdma@vger.kernel.or
  S:	Maintained
  F:	drivers/infiniband/ulp/rtrs/
 =20
 +RUNTIME VERIFICATION (RV)
 +M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 +M:	Steven Rostedt <rostedt@goodmis.org>
 +L:	linux-trace-devel@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/trace/rv/
 +F:	include/linux/rv.h
 +F:	include/rv/
 +F:	kernel/trace/rv/
 +F:	tools/verification/
 +
+ RUST
+ M:	Miguel Ojeda <ojeda@kernel.org>
+ M:	Alex Gaynor <alex.gaynor@gmail.com>
+ M:	Wedson Almeida Filho <wedsonaf@google.com>
+ R:	Boqun Feng <boqun.feng@gmail.com>
+ R:	Gary Guo <gary@garyguo.net>
+ R:	Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
+ L:	rust-for-linux@vger.kernel.org
+ S:	Supported
+ W:	https://github.com/Rust-for-Linux/linux
+ B:	https://github.com/Rust-for-Linux/linux/issues
+ T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+ F:	Documentation/rust/
+ F:	rust/
+ F:	samples/rust/
+ F:	scripts/*rust*
+ K:	\b(?i:rust)\b
+=20
  RXRPC SOCKETS (AF_RXRPC)
  M:	David Howells <dhowells@redhat.com>
  M:	Marc Dionne <marc.dionne@auristor.com>

--Sig_/2GXH_jUKqkbhs2pRA7wngih
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMe3rgACgkQAVBC80lX
0GxwEgf/R7sUyZ5yiq3lioy/9hDtNZM/JsAWJ5QDnOzMUzlW0g3cac7X1kqkIrbT
e+l6RsqPv4ebUdbaxK2/8Ig+rT4l/yvpAPciOPtrRu/KWB/A5pXJg/qcYYByp0Vl
lrHz1Yrs++2cPGNFFIAkCgVNGKEHgD/GH7aBh6JBUuSyXLoF13E1qdlhPjYiRb+t
rzDkeMjFQ48LLPeqlpZhdy5zfsoYQu3Ws7QgXWoHPITn1+/DtVCoUelt9wKDivnA
YqhjadaYb2yD4RcPNeIy08xzKG0CICvEWi2LryAhow5Ep24u8oHtcSOMLORS9w6A
ecSNAqPAWYxzPFTE9e8MAhhtmHaAQw==
=WnIv
-----END PGP SIGNATURE-----

--Sig_/2GXH_jUKqkbhs2pRA7wngih--
