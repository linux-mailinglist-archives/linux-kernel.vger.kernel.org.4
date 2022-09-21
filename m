Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183115BF9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIUI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:57:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE497B28D;
        Wed, 21 Sep 2022 01:57:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXXP54YtNz4xGG;
        Wed, 21 Sep 2022 18:57:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663750665;
        bh=zw1LF9s9Vz8GB6DO4oQk0YjiWsKYBJfv1ncx1IwCJsE=;
        h=Date:From:To:Cc:Subject:From;
        b=DPUk9sqRydw4CTZNS6i8dbenO+iDSLuvpb/35eHcyg0zEtjZctBhzIW5WbGeGKnde
         0hwYFcXj1s9Hgaasy4L2xAkIdtdy4DVHlwCP7Rah9eTWNTfXicQ8MA2FBdgFfGwwJZ
         2Heubhy+8/irpVopkL+HfLw0cP0rYnNJlCXVKoCk5174GY3jHUdk9KWU3rWcMWRoxT
         r/baV0sPJ0kyooZ5KBRo3DjyPg3UPjsLvuxf0JY/0tTx6dQJgZCiPAjI0TyLDZ/8JH
         7fXUTwLFMI1iRbAmtnnN2ISD6txwol8QyJY+ot8a42uxItIb3wn4rmEkKmB1rjlNqL
         hMeevUc1LXm9A==
Date:   Wed, 21 Sep 2022 18:57:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 21
Message-ID: <20220921185740.6e19ee1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WloQ2eMTmpwdigRHaV32l6T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WloQ2eMTmpwdigRHaV32l6T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220920:

The net-next tree gained conflicts against Linus' tree and the net tree.

The nand tree gained a build failure so I used the version from
next-20220920.

The sound-asoc tree gained semantic conflicts against the i2c tree.

The tty tree gained a conflict against the usb-serial tree.

The soundwire tree gained a conflict against Linus' tree.

The bitmap tree lost its build failure.

Non-merge commits (relative to Linus' tree): 7972
 9000 files changed, 445932 insertions(+), 192298 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 360 trees (counting Linus' and 99 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.



--=20
Cheers,
Stephen Rothwell

--Sig_/WloQ2eMTmpwdigRHaV32l6T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMq0gQACgkQAVBC80lX
0GwYTQf+NN/eAJfoPAvWZbcqUoERGCu7u5eOKER/lx1Po+8PuEEqFbzHvh4l7bKq
sf4FT4k6I0CLQnu1FHQ7NfM9KXy15RAVS8PNH0UuAJjZsNchPqajo2dlof2mxU5o
Nvmh52eOZkV57/jXnswbeH3F4p9BWRBhpULsD4NjeU43w6Ks1U4HQQlN3+A1o/iR
M8waXIlzVUO4oqM///ZmEeZ6RfHwfI1NnDfSTqTw95zJCLOkkofr5RPCRxYn1M2H
CY3eWPoGEAWq+s7/88MK9qRax9vmyqP+TfrEPKwwh/Qi1OIgRCbY0OOOgaEMU2vK
qOPcfMSuW4YiBbItvXk47UXSDNHFdw==
=reRs
-----END PGP SIGNATURE-----

--Sig_/WloQ2eMTmpwdigRHaV32l6T--
