Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA54628C31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiKNWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:39:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48F167F1;
        Mon, 14 Nov 2022 14:39:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NB44V5Fjwz4xG5;
        Tue, 15 Nov 2022 09:39:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668465578;
        bh=kaAnqD2lvHJF3tlHerw/d/0hAw7n8wp2+NdVtdeu598=;
        h=Date:From:To:Cc:Subject:From;
        b=usgfQObThxOlJRUEH4xDrzQpwZqpZM99P/v5kAmrNAMsUX9zQLygoHMKkFMR5QuXs
         Ab1vHLCEwBs0BaYtlgRx1LStFor/wz0YxZMHC9f7tXqIItHomKN910e6LQhgJmFwbh
         hDTjRBANvUjtTrbaUTzFnapkU6wFDf0rdOB8v8DepdmRtNLIRdCEoMzvgE2Y4wy07T
         W93ElNClqhV+q0G2Gxi11e2AMPMMHgYejfgpZOGusYCXDmz5cNNSW9W6KkbT2QIb+L
         mmXO2Bdz6iE/qvQqBV4+9EPCIv7WDFsOo6xMXFPj8t+GyAsaDkQFQtnV7+AGr3TEBo
         6uJpznXD3mrsw==
Date:   Tue, 15 Nov 2022 09:39:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: linux-next: manual merge of the ntfs3 tree with Linus' tree
Message-ID: <20221115093921.407f2eb9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2X2t=TUU_RSsz7BO3yEg=tR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2X2t=TUU_RSsz7BO3yEg=tR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ntfs3 tree got a conflict in:

  fs/ntfs3/bitmap.c

between commit:

  70a1cb106d94 ("lib/bitmap: don't call __bitmap_weight() in kernel code")

from Linus' tree and commit:

  08811ba59a61 ("fs/ntfs3: Add ntfs_bitmap_weight_le function and refactori=
ng")

from the ntfs3 tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2X2t=TUU_RSsz7BO3yEg=tR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNyw5kACgkQAVBC80lX
0Gxn7ggAjggK+QPss0v2fHJwxh/zwyxZwe8KZGTr6xVUPuWH75bJwlOaKDocaoqY
7HGmkKCGBH52vejAeD/rzd64K8UREerpk462MWHCD/hUQA6JNpYarkXifeq8Yb4R
JmJIGNCq6cGqTJDlFLaLFjp97np7I5nmwSGdW02XU39cN+u/2zccXSNrjs5onqrC
cLD/tzJHScSJQVk2/FFpU02RaAUOqyQeSd+pBLX5Giyu1L0OJG7sS1fJMaHR6FNW
S5vweJvB9qf08p40ujP6cOMBJoeMP332ODu2Nxd6wWd1+0ZW4kQJ9+mTK71dFC09
BfKWqDOQ/3kQLtQ/aJS9LPnlKrjvvw==
=dOry
-----END PGP SIGNATURE-----

--Sig_/2X2t=TUU_RSsz7BO3yEg=tR--
