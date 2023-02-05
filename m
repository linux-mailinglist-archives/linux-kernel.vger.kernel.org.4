Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CC68B1EF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBEV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:29:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093711EBA;
        Sun,  5 Feb 2023 13:29:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P92b14Qp3z4xN4;
        Mon,  6 Feb 2023 08:29:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675632558;
        bh=zI9yBLi8+G2PXMoLp74Mqw8nA7nRVr/jUA+uR45Xw9o=;
        h=Date:From:To:Cc:Subject:From;
        b=leILFVVHcgc41/6cpsXiMx72IR5n+m5rvfp4cbU3NWNv64OW9qlg0XTYBBZFVDRkl
         IiWUyMQTh6Fc5cZFj1jG6qt7hUDSSRjC/UZwkZ5WErYSnbdTolK17CSRWqFVy17E6D
         mnRi1zepbCAbISB+UCtk3lq2Ve8eLf2AC8zwG5EjNvxxgasQHGBZ3LT4bASQmlA5O/
         uwGPaXDNrW3i7/28I3lug94M+E/5GqSTAU4eP+IRA2hZqaY7T53ZSj5AG+igG+wLgN
         XXafl7HxBtX62e8onzfES1/Z7Gb5QckI7yzy9BKLd4oKxZvEM4nj/kVPB8aHOBwRyB
         bBsNTHdO2h0LQ==
Date:   Mon, 6 Feb 2023 08:29:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm-nonmm-stable tree
Message-ID: <20230206082916.0c5991f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MH+AnDjuHXxq3D0/4yskqjR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MH+AnDjuHXxq3D0/4yskqjR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1d4beeb4edc7 ("selftests/filesystems: grant executable permission to run_=
fat_tests.sh")

This is commit

  24b5308cf5ee ("selftests/filesystems: grant executable permission to run_=
fat_tests.sh")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MH+AnDjuHXxq3D0/4yskqjR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgH6wACgkQAVBC80lX
0GwXpgf+KM+HXWbViWnGpzkkMCC3YvPHzdVnCIDez9PPN12C6qjs/ep5c1mQb9L2
ZgP7FyvQIrH+keuP8Zn1+MHAX0GjV86AEGoMrbd2S2+WGensex/QQtKQL/xHWMy4
2NXie2l8dwH/18ads5zqCxjeF4J4xdGgU1J/15DbB+5UvFKq193LpVMlwHvcsGF4
JNSMUw0uGjagC2kVQa5flxVZot9kz5UNpgpyW5leD+W5ZyQg6nFpZt10HQgj0cHX
HeqfOVMd8bF0CQjeP9fvubaq0p6eO2k8WU99UsuT9EX7bTtLNzxGn0kshzH9FZNb
XVu9mEoAOaLYYycBj3CFC+j5xthWzA==
=3p45
-----END PGP SIGNATURE-----

--Sig_/MH+AnDjuHXxq3D0/4yskqjR--
