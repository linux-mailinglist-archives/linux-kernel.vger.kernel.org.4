Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8B5F392D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJCWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJCWgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:36:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB72DAB4;
        Mon,  3 Oct 2022 15:36:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhG0Q2SF3z4xGn;
        Tue,  4 Oct 2022 09:36:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664836599;
        bh=RtqDmrbTmunQf6Uzcn9SrBoEFO15s5G7MruypZLDlWk=;
        h=Date:From:To:Cc:Subject:From;
        b=KzbQ7rOn2kVVZR+IznVIvE1eg+vhgdo0lqseOyO1Q7phQkmvOA9TCvT1rOz7euskH
         pQsefraZ/CQHZVz5izS9IZbjB6ScEogeRwaEiUaFgYbMSV1JmAyL2WA7Mq6wuOqasX
         5cFqmMx6RjCNZNW2zFimWd3qFsY1Z8TME6ocijmlV/3vVqCz29/gvJL3yTPpWWztGm
         MS3XCKaOV/GbaXFP3Kag6Lxb7ZI1aTXNuijJoqfuOpS3UNgd4ny7lAp4Epr96+WinF
         jfkMqB85PKlo3H0ASB4UFC18BYvKNVpjW9TVo5pEmwgxuraZny6qir/ljtBw4M3Ift
         ZdLHu1H/hSL8Q==
Date:   Tue, 4 Oct 2022 09:36:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yuan Can <yuancan@huawei.com>
Subject: linux-next: manual merge of the ntfs3 tree with the vfs-idmapping
 tree
Message-ID: <20221004093636.2f4d0146@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kgU9kG+y6YA9Az4KTJTFtid";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kgU9kG+y6YA9Az4KTJTFtid
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ntfs3 tree got a conflict in:

  fs/ntfs3/xattr.c

between commit:

  a26aa1238415 ("ntfs3: rework xattr handlers and switch to POSIX ACL VFS h=
elpers")

from the vfs-idmapping tree and commit:

  d45da67caeda ("fs/ntfs3: Use strcmp to determine attribute type")

from the ntfs3 tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/kgU9kG+y6YA9Az4KTJTFtid
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7Y/QACgkQAVBC80lX
0GzNRQf+P1RBvdR2CevjXldQpN/9mjvpaYSOT5mbZX+Fn+j4120tsymmQH795qHz
v6qaleM4vZG5cOCBKMxJeECQTQnZ9iIuG5QXO8wD/rszhHyMr+E5XS6xbcJQbDLP
O/q/z+OD1Jn540HK5Pwz8mOcJQUECyqGCeDbBFH0cpiEPjvXYLbvZmFH7s5Rri66
s8uDaOCKULG1GsaGjpujwpEDzpozQsn/eu89bv5OHsKWtcVd5D6VTR7pFDxsyJD7
9B4lkut78e8aOojXfoHRw7qERq0imY+Bdl2Fzs9TfwhjPKUUjhE7qhOVnRFuEULb
EbevgDdzZRUnBwbcDuJLiOqP9LY36Q==
=kYbN
-----END PGP SIGNATURE-----

--Sig_/kgU9kG+y6YA9Az4KTJTFtid--
