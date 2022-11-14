Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B8628C55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKNWts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiKNWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:49:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B67B12AA1;
        Mon, 14 Nov 2022 14:49:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NB4J63dsGz4xGW;
        Tue, 15 Nov 2022 09:49:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668466183;
        bh=L5/Wo9bImMUqc+29ny58wt8smD6ICoAkNBUXEYXHNdU=;
        h=Date:From:To:Cc:Subject:From;
        b=CAPdXI/Sgl1l80ixMZ3CrnGfvkpbm2tDUdm7S6cqZXgNIZTmwsfa0hVJRhKxzMnRD
         sm4FCq/Lt6UnH8h7Xic3I7TvyqxhGEIIllmSJS8YYxvm1g2A57M1Svqo5OASQ1qEfS
         hDJnJ3ClvTULp3xi2wqBxmHGGA3qR70VSBgD9Z7LsUWKA7HY6AcPSP6+TvQPogfJ23
         iehZZDdBPYASr/cMrvyyG0R9riWniCTHsFUWJeb4fkjrTtVpcerkIOl5seBbFEoJKO
         oZlDe1WVIowoIpmA7Jx/FFhRj6yD5GJNK0U1IUAvhlfRxC0eyoayuKUfjXjsKWQRoC
         JZKWnrg0vQRKw==
Date:   Tue, 15 Nov 2022 09:49:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Yi <yi.zhang@huawei.com>
Subject: linux-next: manual merge of the ntfs3 tree with Linus' tree
Message-ID: <20221115094941.2470ef69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lAMJNgO1sR0M3ECGuxOqjvw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lAMJNgO1sR0M3ECGuxOqjvw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ntfs3 tree got a conflict in:

  fs/ntfs3/inode.c

between commit:

  6bf414a00ae7 ("ntfs3: replace ll_rw_block()")

from Linus' tree and commit:

  2f56a3f8d824 ("fs/ntfs3: Fixing work with sparse clusters")

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

--Sig_/lAMJNgO1sR0M3ECGuxOqjvw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNyxgUACgkQAVBC80lX
0Gy0mggAlgfS71cRpdoupAS1pCUH1eb8v/Y88N7Yk4AJzBGSLuLSDWxrDsLx18Gb
F72/xTBMcHg49MDMbOFm3JYvle+LErPdV8NTCSOVAxsSCqJ2bjfZETr0odzqT3PN
R7GfyU8QfZaUuSk53y3YkhKT+iwiVV7SdSryClQV+AXNgLxJ+EpB7mzkYudkxnl5
FKxbcwYf+LiFeGXpUtnMCkUfnn7HSD5rq1DLhwFjL4gUUFJRF627xslEJ9zdrt4F
jEzf7q3PZnbR3qNf/0E/EWQ7HlyaJwblQx0S+ZWusACj0JdoGirnsMTHASdj4cmz
l6l5goYDGZglk89XaBMU8EA4sT2YXQ==
=6oDo
-----END PGP SIGNATURE-----

--Sig_/lAMJNgO1sR0M3ECGuxOqjvw--
