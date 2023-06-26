Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DE73D59E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFZBxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFZBww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:52:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D7196;
        Sun, 25 Jun 2023 18:52:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qq9pR5tMnz4wb0;
        Mon, 26 Jun 2023 11:52:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687744368;
        bh=e9QR4udaTl7ttfZ1FiKf7+VkKI3pHgJ7/+zJ+cFuc3c=;
        h=Date:From:To:Cc:Subject:From;
        b=grLeYn9ImtEOFl+3FYDC6WNlwnz+b9uccJX2eFqK+YUtkvUbuBYZCCNK8fQPr4Unj
         dfoTUuGpiOCRRnKwvRxQ55VK7g/sxy1jm8+vZpZfifOYg3BPIZEPLJyWDUAhjnSt/b
         wRQs1fKm+DvokcbHLj1jajBIlzpnPWxOQY/QFzn04gm0+YZKY0pay7W36iBOKIJEUk
         p6UUOWyHlPRIBu0b91CpeXb8bBdK9sTyO+bCaD7eShOB4+ylmpCYOkJzTR6ctDaVB1
         tnpLZqkdvNjp1DFi1NqIdElWBP59vC7Ib2mQyTkV/4q/3GHCbVnAFPMbDjE4V2vigL
         rZdyek8w3Q8Zw==
Date:   Mon, 26 Jun 2023 11:52:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: linux-next: manual merge of the crypto tree with Linus' tree
Message-ID: <20230626115246.40f74129@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=TT7ka17ueYMQT7khVr3Gw0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=TT7ka17ueYMQT7khVr3Gw0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got a conflict in:

  crypto/asymmetric_keys/public_key.c

between commit:

  c3d03e8e35e0 ("KEYS: asymmetric: Copy sig and digest in public_key_verify=
_signature()")

from Linus' tree and commits:

  e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")
  63ba4d67594a ("KEYS: asymmetric: Use new crypto interface without scatter=
lists")

from the crypto tree.

I fixed it up (I effectively reverted the former commit - which may or may
not be the correc thing to do) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=TT7ka17ueYMQT7khVr3Gw0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSY724ACgkQAVBC80lX
0Gx1/QgAoiU3VsgWprUWu2oqvELfhH6E8oDg1LyMbJyqaaracN5aJhzSHkE8z/B9
g0zY8i3H00sWHYzX5L+p76HaKJGqGNmOudhazSXQg9IXOr7OjZLB9ZHh4IZQMVto
quRm/WLHoGa5FhehJ0G/ptx0OolR12GIov1+M6zdVy+ieFjYyKUNmFYurLy5pGnq
HXTFsmgp7ce8Kvb7Ru9K0K92HwPVgTa1b5/xfMB21qeKMvkW6tmPAY9xD2P7oYwV
KDKepfaxjhlpusOzCnnMoJxns5ZEGavE+hu3xCmJH70umC3vW0/Uij1FlY8iryIS
zjMB8YItNFPKIpuWJ5787MWstIZzEg==
=Rt8a
-----END PGP SIGNATURE-----

--Sig_/=TT7ka17ueYMQT7khVr3Gw0--
