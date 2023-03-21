Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48AA6C2808
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCUCU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCUCU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:20:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D44A250;
        Mon, 20 Mar 2023 19:20:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pgb1d1hqzz4x1f;
        Tue, 21 Mar 2023 13:20:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679365254;
        bh=nqgTdeGG7OlP5UnnCB0RdzneM0UnQwv6EGrVYrt9vc4=;
        h=Date:From:To:Cc:Subject:From;
        b=IaI25pv9KD4s485MxFU1ZVitScQWg63m3g6qEPhCgxFcpz8IrEkSfpkp/6Ka9UD/5
         N0S5Ao17oeN9oQwYcLjcjshNggp7A36w6QKi29NdJYAndi2hz7hwlkH/3gBDs83hNV
         12CpyhTUU0WSzPiw/7q85i1Aj0eb+tA3/8SuvkgD2/O3zif+lhkcXc6T0L6caXytSL
         3OdC0DjgTPAVyCAJi6Bu/X+rqwsFmVS6CBozNZDu8TCglWY0P5P1e+jBLlDkwu797h
         C/eyErIFaI/WIa73/ll21JctyHFeZDQYQYHylGwobt+q2ffQZI3sPgpow6KGBEO8ao
         gPFgaTUi+IiUA==
Date:   Tue, 21 Mar 2023 13:20:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the sysctl tree with Linus' tree
Message-ID: <20230321132052.7d12fd7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EBOE0W6zM5Kqjzbw1oQHgJO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EBOE0W6zM5Kqjzbw1oQHgJO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sysctl tree got a conflict in:

  mm/memory-failure.c

between commit:

  44b8f8bf2438 ("mm: memory-failure: add memory failure stats to sysfs")

from Linus' tree and commit:

  cfe7e6ea5ee2 ("mm: memory-failure: Move memory failure sysctls to its own=
 file")

from the sysctl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/EBOE0W6zM5Kqjzbw1oQHgJO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQZFIQACgkQAVBC80lX
0GztSgf/akU9uLwzQlanwW8vpegUahFakzjTdqZlNtXUhd1ATz0+cK7qHhRwD4Fo
Me+rLfqkMvnSJ9JOrNAGDh1/KrrzKLqIvqekIjNKtRmUHb27UcZ894fBt6cfsqXG
qSYf5RuUntvwYU5dTnEu2QVDrAUsyTFSYZm1YmBaqxqAGRfWjnbwvTvWGC/DdTQ4
MgLcma0ZJ4SOstWr+9ue25evo831s1cGXiG6C/PxHYk8PdRVOqigax0WsFp+KePa
y9WPo9GJIH9vz9NnNuRqK+ATE9lXmFdMZoyiZDw1+IJY9y3CyRKkDyMBvvA1brbL
BU2Ufa1/z/jLp7L5+5STUy5vHoOM+Q==
=gxLT
-----END PGP SIGNATURE-----

--Sig_/EBOE0W6zM5Kqjzbw1oQHgJO--
