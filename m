Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1570E9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbjEWX4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjEWX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:56:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6ECB5;
        Tue, 23 May 2023 16:56:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQrnC3D1Wz4x2j;
        Wed, 24 May 2023 09:56:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684886176;
        bh=L/HSCzAJRUnfX/VKm3lfNCVOb/8Hr3+vA2626SExfiU=;
        h=Date:From:To:Cc:Subject:From;
        b=tMKrGj+g1XDd6OilaKFpFg/eh3IdfIuVWInAup0NDZx7gE9nl5lcB1dtbObYzWn3w
         QrFP4iN3Nxs4UZXv2qZDmfvZvszftyCYXQcL2PxS2LFcyQgZeC2Ay6gXF+oCYBnlxa
         IWFGFuFOShNzjHJs+RjJ1WqyC3a9KXMcZl1OAhRK4PbuMyAELm9w6oNepE2OgigsCY
         ABdF/DsGCNobIy6GF0bG4VSNgt7UOJ/xzkhpdcsjSYtx8HqN0SdfyHQvPeszubH+J+
         BebHbXVXZboSb4t0EUmLBUapXnuIviuWgj+jO6AshTXL2sbhpo8+3/m5j35BveZFMA
         dL/Ni8f4Fbp9g==
Date:   Wed, 24 May 2023 09:56:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the nfsd tree
Message-ID: <20230524095545.0f70a1e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ejuOwkyWS6CyxdpTGoG7tsu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ejuOwkyWS6CyxdpTGoG7tsu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/nfsd/nfsfh.c

between commit:

  fed41678532c ("nfsd: don't provide pre/post-op attrs if fh_getattr fails")

from the nfsd tree and commit:

  1a6f4cbffdf5 ("nfsd: ensure we use ctime_peek to grab the inode->i_ctime")

from the vfs-brauner tree.

I fixed it up (I just used the version from the nsfd tree - which
removed the code modified by the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ejuOwkyWS6CyxdpTGoG7tsu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtUp4ACgkQAVBC80lX
0GyEBwf+I8XMGKNktgTLIrfhhukPptgomuinAmZ0vxij3gc1Z4qbZRgQqXghFvxR
Sn9utNu/k7l6w3ooCx2novKedVAH2BnikrvgKJK3P7+j9jxa0xVRH7RNnfS38bAZ
AN16OUf/Lit26AkdeWlT9UUtqMmYy9Ki/4XEQ2IKMNd8QrHqvvM+x+VzgsT3QBG9
4WYdDXSK4FBcqnvoJUmHKMhYQF7mKqr5cb5u70ruvMhcn5lQTZfTAyUbdx/eiFhn
IFpt/MIMAqu9Nmq//NQmAR2dEn0WuVaNFuXgKpRr0SDVr7Bb/tsCm4VZhnvaVTWE
7dLgsK8fJ4dhNpwZ0jxOcoTqTR7vdw==
=KBXc
-----END PGP SIGNATURE-----

--Sig_/ejuOwkyWS6CyxdpTGoG7tsu--
