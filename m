Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1774CC51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGJFm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJFmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:42:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A2E3;
        Sun,  9 Jul 2023 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688967762;
        bh=dIIudDnEs8xk2ol87Xl6lmeqU9CcTCPpcA26qaGJSL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZf0V7QIp3giI71oZjSLIfAYELBN8MFRZgmiSwhSDLFouRhzZ5ayaF5nmbkKx2wah
         sXmtyw6Di+RRszt+Slt9cqvSvXZ1V/e8yTg3xO9n3Nh1ykNMgeHVVMdT9VEuQ+TrJd
         WUvNoQouBg9tOIgnO8V9NcT00ix540L/RKycYed15lLPd8Z5A83Sy9XrPNeyg3gRkI
         W2eZSsVPXaOLPtq2v5LqEp/3n9sNMkmFFkpLuxrD7z1q5mVF9Xzk5/toItucRb0Swd
         EbJZmfrdOVni1UoeI+yYAJHco2TaeMUfu/O3cNYWA7pQXYNKMYST3k8a6geBo+LAPJ
         iYDVxI5EPlgZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QztFG0NC5z4wZw;
        Mon, 10 Jul 2023 15:42:42 +1000 (AEST)
Date:   Mon, 10 Jul 2023 15:42:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.5-rc1)
Message-ID: <20230710154239.6ec4a675@canb.auug.org.au>
In-Reply-To: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N.hCBAaZdm2Ml6xB2JS56w8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N.hCBAaZdm2Ml6xB2JS56w8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20230627 was the first linux-next after
the merge window opened.)

Commits in v6.5-rc1 (relative to v6.4):            11730
Commits in next-20230627:                          11468
Commits with the same SHA1:                        11053
Commits with the same patch_id:                      144 (1)
Commits with the same subject line:                   15 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20230627:     11212 95%

Some breakdown of the list of extra commits (relative to next-20230627)
in -rc1:

Top ten first word of commit summary:

     37 drm
     29 parisc
     28 perf
     25 s390
     25 net
     20 xfs
     19 mm
     17 dt-bindings
     15 riscv
     15 alsa

Top ten authors:

     30 deller@gmx.de
     25 torvalds@linux-foundation.org
     14 irogers@google.com
     11 vladimir.oltean@nxp.com
      9 masahiroy@kernel.org
      9 djwong@kernel.org
      8 xiubli@redhat.com
      8 matthieu.baerts@tessares.net
      8 dchinner@redhat.com
      7 krzysztof.kozlowski@linaro.org

Top ten commiters:

     44 torvalds@linux-foundation.org
     34 davem@davemloft.net
     31 alexander.deucher@amd.com
     30 deller@gmx.de
     27 namhyung@kernel.org
     25 agordeev@linux.ibm.com
     23 palmer@rivosinc.com
     22 kuba@kernel.org
     22 djwong@kernel.org
     16 akpm@linux-foundation.org

There are also 256 commits in next-20230627 that didn't make it into
v6.5-rc1.

Top ten first word of commit summary:

     30 x86
     25 arm64
     22 dt-bindings
     18 drm
     17 bluetooth
     14 mm
     12 soc
     12 nvmem
     10 media
      9 virtio_ring

Top ten authors:

     38 rick.p.edgecombe@intel.com
     10 xuanzhuo@linux.alibaba.com
     10 krzysztof.kozlowski@linaro.org
      9 yunfei.dong@mediatek.com
      7 cristian.ciocaltea@collabora.com
      7 arnd@arndb.de
      6 srinivasan.shanmugam@amd.com
      5 rafal@milecki.pl
      5 marcan@marcan.st
      4 wenst@chromium.org

Top ten commiters:

     42 dave.hansen@linux.intel.com
     25 srinivas.kandagatla@linaro.org
     19 matthias.bgg@gmail.com
     17 luiz.von.dentz@intel.com
     14 mst@redhat.com
     12 jarkko@kernel.org
      9 hverkuil-cisco@xs4all.nl
      8 alexander.deucher@amd.com
      7 minyard@acm.org
      7 ebiederm@xmission.com

--=20
Cheers,
Stephen Rothwell

--Sig_/N.hCBAaZdm2Ml6xB2JS56w8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrmk8ACgkQAVBC80lX
0GyAwAf8D2JkankJEDM2kt1zrrhjA9hgLiqQcjYkkkxWJ0yfXap6Z7PtNjsud4Vt
Ii9Q19UFpwiUrFI0J3vJtkfzL1DJdoJ35O5+z4kVkchJgIE9qqeyN5qUPOR82JZe
Xy+Z+2w3mLLZtLvSoL0OdRjZ5sTtn2+A72w/+ufq41KM7q+fghUjdgOBnKKPgRGT
RT1HpgYnndvNpUN7hbtvy1u21VF1mAcPaQs4ST2eHXSMKeaovaPieMShKKPpMy9E
O0GJmepEdbAyALlcHplWCsMHkueXCxPUBFxhqsjb0t4Neb4kCMxoxL9Qyb9nWW80
y0R+6rzAdrCtwUSI00aMLGgep/kIvA==
=1LWs
-----END PGP SIGNATURE-----

--Sig_/N.hCBAaZdm2Ml6xB2JS56w8--
