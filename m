Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6047020B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjEOACf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEOACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:02:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583413D;
        Sun, 14 May 2023 17:02:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKKLY1jGkz4x49;
        Mon, 15 May 2023 10:02:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684108949;
        bh=O7DE0/YBEamQl42+Wd4zFv29Rc1nfm1/xq4Qlqqbz8A=;
        h=Date:From:To:Cc:Subject:From;
        b=Z26hmNjkfEfIUtm7jOpWpHXNum4G8vbP2atDmPyrwmjDq1vqdBxCEQ8QoJfSsdm8N
         ZmZf+SW1reNvC6kfscFS5l/GwTmNi9PHs0+Cjyj12i5F/+H8r7Wv9M9ZKd5S5337ca
         E/+ME30zTiRYKILTjPsdYxcaUj5jOdjjmEoYe/TszK4t7WRaDTwpeeOFM0qkGQLOD2
         NEP5VaSAs3zVm2rAtwQdSK//MMSzZ0S8irzXi3+hDLaYYU9PcL+gzMyzMP6I6pHCIL
         zdr9D10j/ZZSP1NmY2W6R/q79TWsyxlsS4/F7hCGrR3JQbQxMK0+INV0gZmHf1WRce
         DcC5V+02pW5wg==
Date:   Mon, 15 May 2023 10:02:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: manual merge of the mm-hotfixes tree with Linus' tree
Message-ID: <20230515100226.1ead3fd8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gbyJq=b.AzAtDgzlXtqfMy4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gbyJq=b.AzAtDgzlXtqfMy4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-hotfixes tree got a conflict in:

  MAINTAINERS

between commit:

  4bc4bb3bf76a ("MAINTAINERS: repair pattern in DIALOG SEMICONDUCTOR DRIVER=
S")

from the mm-hotfixes tree and commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree.

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
index e0ad886d3163,789ceee3424a..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -6012,9 -6014,9 +6007,9 @@@ W:	http://www.dialog-semiconductor.com/
  F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
  F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
  F:	Documentation/devicetree/bindings/mfd/da90*.txt
- F:	Documentation/devicetree/bindings/mfd/da90*.yaml
+ F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
 -F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
  F:	Documentation/devicetree/bindings/regulator/da92*.txt
 +F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
  F:	Documentation/devicetree/bindings/regulator/slg51000.txt
  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
  F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt


--Sig_/gbyJq=b.AzAtDgzlXtqfMy4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhdpMACgkQAVBC80lX
0GzgXwf+P2j0y3y1JmQOa3MU5WD+FGlFL3Bp1hA+14q5raOAQrIXLzuoESqGLdu+
EqN9xZzrqY7mI4U+WOUrM3plB8utcxe3sSmytBA7aiN+A30LJGCE775F0LqWrBOB
cbRPWSgGKpdjTNRk9zdEGVh614amDuX3Wutt34FdJjkv7CHDjylkLxz14YbvB/dD
adhxsvYHbed9qln4O6qSzZ+wbLH1nTOGtgJ4R8zSEHK/1cZvcbd3WwSkH5W49R+X
WUHmW14ckzaEqzrjgtvNj2jLMP+NCVQNwJCHghH0yeWGX8B0ZxA2lg7grnsg+rna
IAP090QlB++XzM1morBcH/5Vzyb3+Q==
=mj58
-----END PGP SIGNATURE-----

--Sig_/gbyJq=b.AzAtDgzlXtqfMy4--
