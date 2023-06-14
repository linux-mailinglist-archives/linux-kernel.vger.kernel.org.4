Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA972F23B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjFNBzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbjFNBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:55:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC971707;
        Tue, 13 Jun 2023 18:55:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgpRK2QDQz4x1f;
        Wed, 14 Jun 2023 11:55:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686707742;
        bh=+JK7cI4SCAkv07KdoiN4I7QGwZeoKwr9thXOn4WsuiQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Icpk0x47sbGbWVfEAwBI8EmpfDNKuFp7f5jHXuRo+rJYaMNrFhU9H0FnW/dfCxpbr
         FwsMxhoaV+94erC9rxNNGjegxoh6GD7lJ/cs6fb6OE8N8DYSQiZZZAd2EThaBD6RG5
         EVIygT2tK9BzKR0hHu9dGoSd6IqwM1EdRlUjYM9PkQRXiFyqmrI2ihhVYBbC7MZ0Ye
         J3qrH+HHRL9smfAJuFtTcoRWazFWd+G7IqE4NQyvELZb5gxa45PWByVfFnRPitzUAZ
         t494GJW6jHXaW186++sKldFbW17CWwzveKxnkpQRntCvylGVJfNdDKjMn7JUdRyFNo
         3N/OlaCy2+4eg==
Date:   Wed, 14 Jun 2023 11:55:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Lingfeng <lilingfeng3@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: linux-next: manual merge of the device-mapper tree with the
 mm-hotfixes tree
Message-ID: <20230614115540.569a9b9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q.0rR_woPbB9EWRoqPA7NF_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q.0rR_woPbB9EWRoqPA7NF_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  drivers/md/dm-thin-metadata.c

between commit:

  49444301e665 ("Revert "mm: shrinkers: convert shrinker_rwsem to mutex"")

from the mm-hotfixes tree and commit:

  71720b0916ca ("dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_=
client")

from the device-mapper tree.

I fixed it up (the latter removed the comment that was modified by the
former) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q.0rR_woPbB9EWRoqPA7NF_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSJHhwACgkQAVBC80lX
0Gxrhgf/fW4YCwkjkrck9xfqTmz3hnQfpSlEShSJ5VB3QGhCdl8kLjDcCV0pLH1h
ULZFAHjliH4OnRcoriIccrvtwoVwX43GvXnqe1EYwevUiMarWcUbm33i0RLRF/BH
Yhl2hzEFuGZEChgwMblZxWWyr1DPAuHms3LSOWryuvS2tZvJJTTWCBby9oX8Y7jK
jeWg+O0LQrk7+9pTu8GF+OK4lfIkSw8103JMuuKVKOTJ+mcAKLD18vRzsz77spZD
XQE9KXKp5IZJOpSWXiWOyHlMYVP+WXiwOrKKAVwheWYEUZSjaVrAiqh2BhQTOhCm
5HvlKyXd5gDr7Z3I0nrKXIBkMy14fw==
=0LRe
-----END PGP SIGNATURE-----

--Sig_/Q.0rR_woPbB9EWRoqPA7NF_--
