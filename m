Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446876956C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBNCjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBNCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:39:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740217CEE;
        Mon, 13 Feb 2023 18:39:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG55G205hz4x5Z;
        Tue, 14 Feb 2023 13:39:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676342375;
        bh=/ZSO+birFbnmxuQlXlHZMCGvmbGaNnu+kdufeLm0WYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=sHUWmgDYxM0s8ijljHaU+QQFhUZXnpKK7jHqPuUNuFaPyo3+nMPiV5ZUO82hWsZD8
         hZ1EwEueeC1uuwHh5nc95cgc1O8d9Jgso3FUU+GDy5wfgfjHtu3VYmybN7DFfWOxtb
         X3YDwpFlqyp1s3pK562RYNUXT03nqaioivCs7xSd2AbV5KElMk5Ws1kvbSC+GVKGZP
         zBgW+G+hrg43eJo/aNjYIdw4FvtabAXWuiFcBNQWArv94/BYbYEN2CYmP+RN9l5EFw
         GSHr3s4eGSFpQsfatEuYwAmEzgeq7KMnafBVvS2u2LEPcn2xMFPTQ8vizbEoZ1qj6V
         KbDosiVP9cl5g==
Date:   Tue, 14 Feb 2023 13:39:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wang Yong <wang.yong12@zte.com.cn>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: linux-next: manual merge of the mm tree with the jc_docs tree
Message-ID: <20230214133929.7d8ed00f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ofx6+7xe7Ge.+wrUvSi1.DL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ofx6+7xe7Ge.+wrUvSi1.DL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  Documentation/translations/zh_CN/accounting/delay-accounting.rst

between commit:

  6ab587e8e8b4 ("docs/zh_CN: Update the translation of delay-accounting to =
6.1-rc8")

from the jc_docs tree and commit:

  f66f8a7e4730 ("delayacct: improve the average delay precision of getdelay=
 tool to microsecond")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I also aligned the last 2 lines with the lines above.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/translations/zh_CN/accounting/delay-accounting.rst
index a01dc3d5b0db,5623f555d7c5..000000000000
--- a/Documentation/translations/zh_CN/accounting/delay-accounting.rst
+++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
@@@ -92,17 -91,15 +92,17 @@@ getdelays=E5=91=BD=E4=BB=A4=E7=9A=84=E4=B8=80=
=E8=88=AC=E6=A0=BC=E5=BC=8F:
  	CPU             count     real total  virtual total    delay total  dela=
y average
  	                    8        7000000        6872122        3382277      =
    0.423ms
  	IO              count    delay total  delay average
- 	                    0              0              0ms
+ 	                    0              0              0.000ms
  	SWAP            count    delay total  delay average
- 	                    0              0              0ms
+ 	                    0              0              0.000ms
  	RECLAIM         count    delay total  delay average
- 	                    0              0              0ms
+ 	                    0              0              0.000ms
  	THRASHING       count    delay total  delay average
- 	                    0              0              0ms
+ 	                    0              0              0.000ms
  	COMPACT         count    delay total  delay average
- 	                    0              0              0ms
-     WPCOPY          count    delay total  delay average
-                        0              0              0ms
+ 	                    0              0              0.000ms
++	WPCOPY          count    delay total  delay average
++	                    0              0              0.000ms
 =20
  =E8=8E=B7=E5=8F=96pid=E4=B8=BA1=E7=9A=84IO=E8=AE=A1=E6=95=B0=EF=BC=8C=E5=
=AE=83=E5=8F=AA=E5=92=8C-p=E4=B8=80=E8=B5=B7=E4=BD=BF=E7=94=A8::
  	# ./getdelays -i -p 1

--Sig_/Ofx6+7xe7Ge.+wrUvSi1.DL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPq9GEACgkQAVBC80lX
0GytGQgAlC2ENkthEroyVjYa8VPKbsg4Wh+CszrmtPAghKtJIUzfws2bBypNoEMw
Gw8k40fRi2hTJRyGA6A/j79qgVic4Vf3rqwRElU4qGhrIF9MiMWFhekcG5KYGrHo
GMAHBdSraGQ8cO2M84a8PghKQp52jCtUmzmgFAtBpRP/wrNicfnd6NsID/8P8jaa
c5Ynf8tgqSRQavvfKmzBKq3cHtWrS9qqSDMaxRFF7kEjTofsu5mc8fZnAS1qTY7L
Xum1Q56K7w9++V6ODZEYMcnPU9mUWXCYiscivF7lF3hFpSPzs5RNmLb9+BUEtdyc
kznOyV5vWyqTPWaoexMbx4bvh3S4jQ==
=SlcS
-----END PGP SIGNATURE-----

--Sig_/Ofx6+7xe7Ge.+wrUvSi1.DL--
