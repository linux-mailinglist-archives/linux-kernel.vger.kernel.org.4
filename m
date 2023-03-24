Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87BE6C74B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCXAqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:46:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AD193E4;
        Thu, 23 Mar 2023 17:46:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjNmy3bLdz4wgv;
        Fri, 24 Mar 2023 11:46:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679618771;
        bh=TJgMKUmafy9nEqTKVL8mKbcVFDc4HBySLWML0edTurQ=;
        h=Date:From:To:Cc:Subject:From;
        b=A3bv4aFT3sWETD7ERNI7n6sQJjtD9jw/frjjwfTc+PfN3UHVDcE0L5Fw+nVxzslUS
         4qfxR+ia83k1rEyrN2hH4wlFuELJIFOMZwADMi1VCphjC+ZAzG7aYwPiYlzhYSsmJn
         kPeGLqKquWm/wKsD58DSYoXkci6LbFsEWxPhZeuIm2QXn4fBIfjyAzueOErOK6qJYh
         d6dYHT8HkW051v5G8b2HXUUoSUKLD1fzURmx8aQUeYBmEN1pUZUgIQ2iNF1X7o8eIE
         jckxEckT/4MbEbLdT9FtbytPjT9xCvharc+VbM5/4BRSZnrly8sYMxn7djUF6YHWiB
         rUb0xD42TzqcA==
Date:   Fri, 24 Mar 2023 11:46:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: linux-next: manual merge of the jc_docs tree with the
 driver-core.current tree
Message-ID: <20230324114609.018ad2a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LqUDz=gt4lafdjLpq_AsiJ7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LqUDz=gt4lafdjLpq_AsiJ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/admin-guide/index.rst

between commit:

  44ac5abac86b ("Documentation/security-bugs: move from admin-guide/ to pro=
cess/")

from the driver-core.current tree and commit:

  efe920466f51 ("docs: describe how to quickly build a trimmed kernel")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/admin-guide/index.rst
index 09a563bbe3e7,7840fdbab585..000000000000
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@@ -36,6 -36,8 +36,7 @@@ problems and bugs in particular
 =20
     reporting-issues
     reporting-regressions
 -   security-bugs
+    quickly-build-trimmed-linux
     bug-hunting
     bug-bisect
     tainted-kernels

--Sig_/LqUDz=gt4lafdjLpq_AsiJ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQc8tEACgkQAVBC80lX
0GyEDAf9Gw2IaeLzH05bWhkeQxD/PrrID523pQ+b+mNsUpR/Ka1rfcrt9vR/1j1O
yKNT1OenzhGxXUoYfhzk0OsVzXdY48pCgOYaWf2P3jd5txnd0vZ89DQ/wLGbrn/a
Dw9K7iYmXunf/SV2SbS/lsq+2BsMqLqheMQomuu0zaZJ+7q6dLtQQWlyoYVodA5L
F3uMxkWFnk5BC2yoDWbkoKw2v3cZm0qQj06QdAxJKuxL6EdGixq+sCPGnf4tj+IY
jscx+anPJckpBG4VyedZJrr4wjBqsu2V83tBo2byuz15+9p5B+I9TLUj+9xPyxau
TmJSiZAFAjcb3q6e/kviu8t2Pavtjg==
=z72R
-----END PGP SIGNATURE-----

--Sig_/LqUDz=gt4lafdjLpq_AsiJ7--
