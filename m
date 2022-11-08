Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4F6206DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiKHCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:42:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335913D1B;
        Mon,  7 Nov 2022 18:42:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5snR6Qmpz4xFs;
        Tue,  8 Nov 2022 13:42:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667875324;
        bh=39799bZTxzFpwRGI33rpfYdDnnGPoa52HeOweuv0d00=;
        h=Date:From:To:Cc:Subject:From;
        b=E2TLOGOxgV2/K9qK7fTBiIFxbK96EY403EPq47LTXp4QT5BcGbt/QNfRvDAK38nzi
         2NT06hmna9dRaYhCOErJtjV5sab3iJWXFOc22k7kuD7DKUoJ9GVGo3FZl3fb4e0cTH
         /6o1UG0JmzFArjSJxQbSrb4kDfFuibplPWINpycFEsAbNO+Nz5t636jW79sMSeZx6+
         jLNjPhp5syrGYRvASEi5kAO1Ot2Ye3dGAjG+GK14z3azsaSZqPLfhdMHYK2WWmDmsq
         iEp3/WX7twf0snOmaEwb5yDKJKfQCGx6CGYONEAaAvG12bcubEdmcXbnBvkSTcr6/z
         blAr8BV5YML6A==
Date:   Tue, 8 Nov 2022 13:41:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: linux-next: manual merge of the kvms390 tree with the s390 tree
Message-ID: <20221108134159.11d09c7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ehBp9xr0n=GXISeXXd9c3Jp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ehBp9xr0n=GXISeXXd9c3Jp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  arch/s390/mm/init.c

between commit:

  2ce7a18211b0 ("s390/mm: fix virtual-physical address confusion for swiotl=
b")

from the s390 tree and commit:

  58635d6615f1 ("s390/mm: fix virtual-physical address confusion for swiotl=
b")

from the kvms390 tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/ehBp9xr0n=GXISeXXd9c3Jp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNpwfcACgkQAVBC80lX
0GyCAwf8CQD3RWFZ8YxkBEYktdm9TVi7PxH6Mwr+ZV/HzFUx5iQ8mZNRA9VbeT2A
SauhgsfFw9Q82nf1D+8P+uZbe6PHIGcHTCuEAcUFuAJjDkAVnziiWZJancs/DzUu
I/CeHIPJttjgBCcpB+Ir+6vUJdEQLMWjM1KFC06Pcuwx9j1sLXPMhJfKWqLEDLK9
xhozXSShrcGsfRSCOxjTdhWIfgVM2IaIzUDZL59AWACBM7nhKXMvgxGYYxqRXv8n
ligetF4dIQaPBUwtPL5Kte/njxLE1XODdMMPcXPidmOVYD+BalJDvW0tEVNrGGMc
trh75qqFj8+oodSJfLK7IZagA88HCw==
=siR6
-----END PGP SIGNATURE-----

--Sig_/ehBp9xr0n=GXISeXXd9c3Jp--
