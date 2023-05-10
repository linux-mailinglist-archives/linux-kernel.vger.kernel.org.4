Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1407D6FD513
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjEJEbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJEbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:31:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DC2D53;
        Tue,  9 May 2023 21:31:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGMY640BYz4x3d;
        Wed, 10 May 2023 14:31:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683693082;
        bh=GBHS4N8sUJ+ITon3TODpQKrJigcTavGD8mpLHLtIzt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ozAIx4TygMjj1MArjIFJ3h03cIsmZD+UW1ZNSs+ZbbncdJdK4oOpZRjZboxYZCN1c
         EnITrpulFGd68mG5+wpzMHJr6C7SzUeNY/WD8bc4vO0326ZKBgx99ecUIkrwN59D8v
         wUwaPx1o4/bukcxldi+TvySyD9yCmj5QyBcgBVkyMcBod42XD6aEuSrkimrDDQn2o/
         6AX/3m4PTnHU5L3tCFvVAlMzjJFuybkIWIq2XZXGlxfch3XLKj6WoN0gWCdf0WuAYZ
         KM60pq6GJHOc02vStSDldV1kXheMdjNIuDdRw2tuZ7cqONrfSfzCsL57SjNpLPxQJV
         k2pVVwluaNIAg==
Date:   Wed, 10 May 2023 14:31:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next stats (Was: Linux 6.4-rc1)
Message-ID: <20230510143120.3df82f8f@canb.auug.org.au>
In-Reply-To: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZkNBr2zAyaskAwgCQEMB1en";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZkNBr2zAyaskAwgCQEMB1en
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20230424 was the first linux-next after
the merge window opened.)

Commits in v6.4-rc1 (relative to v6.3):            13044
Commits in next-20230424:                          12692
Commits with the same SHA1:                        12151
Commits with the same patch_id:                      216 (1)
Commits with the same subject line:                    7 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20230424:     12374 94%

Some breakdown of the list of extra commits (relative to next-20230424)
in -rc1:

Top ten first word of commit summary:

    144 btrfs
     28 net
     26 perf
     25 dt-bindings
     23 loongarch
     22 risc-v
     18 netfilter
     17 alsa
     16 drm
     14 x86

Top ten authors:

     53 hch@lst.de
     32 wqu@suse.com
     30 fdmanana@suse.com
     20 torvalds@linux-foundation.org
     12 git@xen0n.name
     11 jk@codeconstruct.com.au
     11 anand.jain@oracle.com
     10 linkinjeon@kernel.org
     10 fw@strlen.de
     10 apatel@ventanamicro.com

Top ten commiters:

    147 dsterba@suse.com
     54 davem@davemloft.net
     28 acme@redhat.com
     27 akpm@linux-foundation.org
     25 stfrench@microsoft.com
     24 torvalds@linux-foundation.org
     24 chenhuacai@kernel.org
     23 pablo@netfilter.org
     22 rafael.j.wysocki@intel.com
     20 axboe@kernel.dk

There are also 318 commits in next-20230424 that didn't make it into
v6.4-rc1.

Top ten first word of commit summary:

     72 drm
     32 x86
     22 nvmem
     22 extcon
     15 iommufd
     13 mm
     12 dt-bindings
      9 soc
      9 ntb
      9 kvm

Top ten authors:

     37 rick.p.edgecombe@intel.com
     23 miquel.raynal@bootlin.com
     16 arnd@arndb.de
     15 jgg@ziepe.ca
     13 le.ma@amd.com
     13 andriy.shevchenko@linux.intel.com
      8 michael@walle.cc
      6 srinivasan.shanmugam@amd.com
      5 broonie@kernel.org
      5 aurabindo.pillai@amd.com

Top ten commiters:

     69 alexander.deucher@amd.com
     41 dave.hansen@linux.intel.com
     40 srinivas.kandagatla@linaro.org
     24 cw00.choi@samsung.com
     17 jgg@ziepe.ca
     11 jdmason@kudzu.us
      9 stefan@datenfreihafen.org
      9 maz@kernel.org
      9 arnd@arndb.de
      7 ebiederm@xmission.com

--=20
Cheers,
Stephen Rothwell

--Sig_/ZkNBr2zAyaskAwgCQEMB1en
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRbHhgACgkQAVBC80lX
0Gw0Tgf6Al1qw4zwGcw4sOdzgzgvWqHcyTm6R7GVkhvKj0IJ+a8TvTm4MzPKYFvy
BVomgSisv3u4uGjahUbCppJvDFrCVitDI16buETQPIlPtlpJ8jq8zygVI3iMCdNZ
ANFQJ/SEviYvn/eExrr1SyS8RyWC4w8ggE26NuXizTCSEC5hFrVm0Im6qrUGInMC
YNFzbDzRjSDNhdGcDhbXfWrnrXN2duItEyjPOvgfDFSI6Ogph2p8a0ABofiKpTAC
w7Y5zXoOOc5eLAcDPQMzHcwUatescLpIDAWG48DbewY9CCxGbY2HnZvTuNjsfc9p
2bweyPmCU6zc+n4vrM8J37eczCVxMQ==
=9vm+
-----END PGP SIGNATURE-----

--Sig_/ZkNBr2zAyaskAwgCQEMB1en--
