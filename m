Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B16773BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAWBMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 20:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWBMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:12:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1421EB78;
        Sun, 22 Jan 2023 17:12:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0XCM6MQcz4y0L;
        Mon, 23 Jan 2023 12:12:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674436368;
        bh=KUHJVBb0Qq22/V85zvNZ0qTQgnpqraZ8hupOkBaj0L4=;
        h=Date:From:To:Cc:Subject:From;
        b=JoFyBxpQ0tA1Q82JkMLHzvvxF+yfVdqVJsoqHsH22+0QBj7YYa5Dm16ZgMUIpEMVp
         QHngTuCiMShLpGGmu762I4bkxl8XTFG8dnQhE6eKcdD18frkE/sjJQFF+z3qz3ekqE
         uGuIx5R/j8xPyc6fX3thPShXO9NTzdLftWK/dftuPVVuFMCdqfrZrFeeSngxSLbYjp
         Akt7JVBoxHxrPzZJEZcQK+46g6bgzQ0jsJR1HkPnH1pv5pxe5XvZVCCkHmMYYkGU+5
         7MvXbcpTeB8TpXOfMgoGDd8OLN71fLgjZb0/lqYlkeQHa3qPusrti+gtd/1jhcbnpn
         PvvU4ZkGh58tA==
Date:   Mon, 23 Jan 2023 12:12:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: linux-next: manual merge of the kvms390 tree with the s390 tree
Message-ID: <20230123121245.526d262b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZBDOGty0f.AH1xSSNea2MlZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZBDOGty0f.AH1xSSNea2MlZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  drivers/s390/crypto/vfio_ap_ops.c

between commit:

  0daf9878a799 ("s390/vfio_ap: check TAPQ response code when waiting for qu=
eue reset")

from the s390 tree and commit:

  bedac519eefa ("s390/vfio-ap: check TAPQ response code when waiting for qu=
eue reset")

from the kvms390 tree.

They seem to do the same thing, so I used the version of this file from
the s390 tree as it's commit is much newer and has other changes to this
file i.e. I effectively dropped the kvms390 tree commit.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZBDOGty0f.AH1xSSNea2MlZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPN3w0ACgkQAVBC80lX
0GzFKAf8DGGQvV9nsbrruM4/LONJm5CZd7KHpYggx/9OSh9s5WPkaH4l7M4VEtDL
Hdp1yh1TbIdVphz7UgjfAeN/pDYiDzR04+X3EJtEdJ+QbXKF0qAtFrr62r4ULNbY
sjJnoHEiVtB4ikYCvMn/eA+mXVHMf4F/6TQk3xmwOMvJapr1jJs0Zy2Hjl6r0VfF
RYD4NPovHrlujQqlwv8IILiKXl/sThdYPGGRpE8EciBBtpbc9pEV3w91QhZRfEOX
ohGYWeZ8u7FPFCv3mLI7HYVV3nnBez5ozl/N6wdq/hmEXo0cH8TsDQxXO0rudifd
72o4wnqXluD1SEeWXYsYjTALbgw9Og==
=XWEZ
-----END PGP SIGNATURE-----

--Sig_/ZBDOGty0f.AH1xSSNea2MlZ--
