Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D573AE83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFWCWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFWCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:22:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBF1BCA;
        Thu, 22 Jun 2023 19:22:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnLcL02xTz4x0L;
        Fri, 23 Jun 2023 12:22:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687486964;
        bh=TCCFMEXH3LH5PAQ+wFvijb678E4tpW9KTYyHVKC9U20=;
        h=Date:From:To:Cc:Subject:From;
        b=Hlg9OpxzQWUETfnm9O4rXdyMcR7T4wRgbcqSlrtofEDlq9pEGF3fLT7DmlTxKo/Vx
         /XOU5TqPmyDWlGjtou6Ildqxh0HYB/uX82TQwk5SQfDYOCxJYZnFVnl1EDneAj8djw
         nI16KYIbkmyrhtRoQO/pg0l8c5X1/uDoW9mKI9xlkSPeqrnnvQRVRIF7qaFE1jToBf
         pv1Il+AkKXiMmjhH74qcnW3FWf/55Z1S6YfIbVKMd3ZzgcYhJfUHxyqBuHLRIrvK9U
         Hq6LIY1fXvQdgbsi/kyDWTy9pCrMGvA/BpB5r+F2DO71VaH8yzKlo+4VinfXwnpz29
         KbwMjg7BhFlFw==
Date:   Fri, 23 Jun 2023 12:20:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-x86 tree with the arm-soc tree
Message-ID: <20230623122037.16eb8bec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j_I.t+bRIB0/0J=TouOZEKb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j_I.t+bRIB0/0J=TouOZEKb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-x86 tree got a conflict in:

  Documentation/process/maintainer-handbooks.rst

between commit:

  425d827ef91e ("Documentation/process: add soc maintainer handbook")

from the arm-soc tree and commit:

  63e2f55cabed ("Documentation/process: Add a maintainer handbook for KVM x=
86")

from the kvm-x86 tree.

I fixed it up (and sorted the entries - see below) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/process/maintainer-handbooks.rst
index fe24cb665fb7,d12cbbe2b7df..000000000000
--- a/Documentation/process/maintainer-handbooks.rst
+++ b/Documentation/process/maintainer-handbooks.rst
@@@ -15,6 -15,6 +15,7 @@@ Contents
     :numbered:
     :maxdepth: 2
 =20
 -   maintainer-tip
 -   maintainer-netdev
+    maintainer-kvm-x86
 +   maintainer-netdev
 +   maintainer-soc
 +   maintainer-tip

--Sig_/j_I.t+bRIB0/0J=TouOZEKb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSVAXUACgkQAVBC80lX
0Gx9Awf+LMYa/6C8gqfIdqZvbe74wj4jd0topCoNlmDQvHMBiYEr2Az78O4a9Okf
eBG5JnCPdsCfe1U8PezWHSNA/Sg45XLWt1/TJfHZLVU5c4uaKV3Mrcu79fLDgSdN
IVrvEYbNZVdHr/of2xBtTkl+VueqTqbYR8HXOFOXijh5Fk0exm+0vMgvCOnDlhz0
j/hAyET47aBfqe6JOCdnKd2QR6uclz1OseHL/yRJtFQYoLpgMAxPkEuFIBC0PfwI
wTyI+7x4WOxYyVMI0fojYE1XNbN+qtuLJrqql1g01z6k5ybgjn4LV47e0GmwKsKE
r3/e+B9C26SxOOPlbm/OR1yCmUTKAw==
=1WrR
-----END PGP SIGNATURE-----

--Sig_/j_I.t+bRIB0/0J=TouOZEKb--
