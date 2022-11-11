Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD06252B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiKKEhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:37:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91A24BE6;
        Thu, 10 Nov 2022 20:37:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7mCP3TZxz4xGW;
        Fri, 11 Nov 2022 15:37:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668141457;
        bh=WU6TrlXeelXb8CQZe8wCt/Lm64tF14H8Nkwbsvlo4Wg=;
        h=Date:From:To:Cc:Subject:From;
        b=MtPP4J08ZyyWxQtRVxPULU/8WEDmu4pB/X4frrY8Ra/zWQSbQv34mvUPGiFP6csfI
         zz7Gjw4aSgxPeQbdTQz4FaTug+bm9yugBhb65MEGqnJXYqrZCph6+bT75ypQh/Ve5P
         p6+sCYx2LeZk3KWM9tiehzPmC/y26AavWBPsu4sYkHTGc3Z8wHyYUZGw+ykHJLU+Hz
         ELo7q1+mdL9EMDSUQ29j8VWhjxWniYc3qo1HvYLx5elmd2Dvy/nicUOI8oE0W9wrdu
         hzHrMUFL7HhFegciii5/jbclbUqZ5Sk0JkQdbBVFTV89ng2yaiMWlkdbunK8pmn1hj
         VlUrZv+86+AcA==
Date:   Fri, 11 Nov 2022 15:37:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Anthony DeRossi <ajderossi@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the iommufd tree with the vfio-fixes
 tree
Message-ID: <20221111153735.07a2bee1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KXem6=en_JgDoDkb=9JC/X/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KXem6=en_JgDoDkb=9JC/X/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/vfio/vfio_main.c

between commit:

  7fdba0011157 ("vfio: Fix container device registration life cycle")

from the vfio-fixes tree and commit:

  55e16a188913 ("vfio: Move vfio_device driver open/close code to a functio=
n")

from the iommufd tree.

I fixed it up (I just used the latter version since it seems to
incorporate the former change) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/KXem6=en_JgDoDkb=9JC/X/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNt0Y8ACgkQAVBC80lX
0Gx6FwgAliIPn/1IsW5RmQijg8xXvCVC8d0dphtDutH0+LcTeddjx7NPHKsP7eQy
8d8Aliy9iFBVI4S4xQfbY37jPnVf7fB/HmAHUJ3RJDlsUjmFTmtN+h0gRTNlPNg6
7peJdWzxqKiPIL+w6iEracq66uxq2Jk/Zs124nPAhh3brB1pcpbWJyN0u/OGLVWh
Eonkr508fWuFMIQbhznqprCUxGd4D9HdZczEA2kR8lGmDXAT2dr4Nbau2MbBNAdz
BoNvwT+3ek8Jb2cLr15TJm83j4ZsPUfEYwpAihVfcCSpNPAlSTZennIY8+e0lAK0
taHfWrpIn7g5EQPBR20NtjLgzaYPHA==
=qSB2
-----END PGP SIGNATURE-----

--Sig_/KXem6=en_JgDoDkb=9JC/X/--
