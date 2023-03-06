Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2716AB45C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCFBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFBlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:41:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEFE113CD;
        Sun,  5 Mar 2023 17:41:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVLsK5LjHz4x5Z;
        Mon,  6 Mar 2023 12:41:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678066901;
        bh=H1Pi6MUM1GOz6ht/UylKRvESYru/TTexAZ9vRNwF/34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P2QjKTxnQ211QkBV5sVI3d+90pp4Ud07nl2KC0IgJPK0WVnYov65jbcaj8gQareKp
         BZQQSvQrBInSGMShKjW583IOsXnsxLD3FLzA5KNjstxWdb6LQggZ/XW8ikcux21bEw
         MGYBsbxdZi7xPcvS/4b7oomluPVnT1KxpGcwUItplvasylgK+zyf2XgNI5Fdcm7+N4
         a7IYx0qkbjdQTlzwRM8pNDS4T3A3ygRZs9iPq3Ub9WGtw4jsOZM6SUOmVLYfFjMmtY
         zmJEypCQT/h5CeErqaiQtjAO/sHqtvDzkU/uERQpKuksWOKSFHHZWkVF2rBaGh8PoJ
         3QUKKtrWjPS2w==
Date:   Mon, 6 Mar 2023 12:41:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.3-rc1)
Message-ID: <20230306124140.48324254@canb.auug.org.au>
In-Reply-To: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rl9__J4XXUlGLF9qh=41=AY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rl9__J4XXUlGLF9qh=41=AY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20230220 was the first linux-next after
the merge window opened.)

Commits in v6.3-rc1 (relative to v6.2):            12717
Commits in next-20230220:                          12390
Commits with the same SHA1:                        11749
Commits with the same patch_id:                      317 (1)
Commits with the same subject line:                   12 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20230220:     12078 94%

Some breakdown of the list of extra commits (relative to next-20230220)
in -rc1:

Top ten first word of commit summary:

     66 net
     43 drm
     32 scsi
     28 cifs
     25 asoc
     24 dt-bindings
     19 risc-v
     18 alpha
     17 rtc
     17 riscv

Top ten authors:

     19 dhowells@redhat.com
     16 viro@zeniv.linux.org.uk
     15 miquel.raynal@bootlin.com
     14 atishp@rivosinc.com
     12 edumazet@google.com
     12 broonie@kernel.org
      8 paulb@nvidia.com
      8 arnd@arndb.de
      7 vladimir.oltean@nxp.com
      7 torvalds@linux-foundation.org

Top ten commiters:

     44 davem@davemloft.net
     36 kuba@kernel.org
     34 stfrench@microsoft.com
     33 alexander.deucher@amd.com
     32 martin.petersen@oracle.com
     32 broonie@kernel.org
     23 palmer@rivosinc.com
     21 pabeni@redhat.com
     21 alexandre.belloni@bootlin.com
     20 stefan@datenfreihafen.org

There are also 312 commits in next-20230220 that didn't make it into
v6.3-rc1.

Top ten first word of commit summary:

     37 fs
     29 habanalabs
     22 nvmem
     17 arm
     13 btrfs
     12 dmapool
     11 dt-bindings
     10 virtio_ring
     10 soc
     10 iio

Top ten authors:

     16 almaz.alexandrovich@paragon-software.com
     15 krzysztof.kozlowski@linaro.org
     14 arnd@arndb.de
     11 michael@walle.cc
     11 dhowells@redhat.com
     10 xuanzhuo@linux.alibaba.com
      8 xu.xin16@zte.com.cn
      8 kbusch@kernel.org
      7 josef@toxicpanda.com
      7 ericvh@kernel.org

Top ten commiters:

     32 srinivas.kandagatla@linaro.org
     32 almaz.alexandrovich@paragon-software.com
     30 akpm@linux-foundation.org
     29 ogabbay@kernel.org
     16 krzysztof.kozlowski@linaro.org
     14 jonathan.cameron@huawei.com
     13 dsterba@suse.com
     12 mst@redhat.com
     12 dhowells@redhat.com
     10 yilun.xu@intel.com

--=20
Cheers,
Stephen Rothwell

--Sig_/Rl9__J4XXUlGLF9qh=41=AY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFRNUACgkQAVBC80lX
0Gy9Vgf8CMxlyP2bv3YhC4yPqDIeL3ElTXAVi+NH2nvbENsSJyVGjUzDiM1dIQjg
eyaHcz+dC7CUWpln8eZgG+R1a62FqHDU7MGcwauW0q84IRLLQkAaKpl6xN+Xxzxp
uWJ453hGFvRRSUeyq2TbBksU1PnaMlPQgegchRa/Vdw1UqxXbakXEgmPOhW7qOMa
I9HvjO1MOs3VaJN5AAfsKdeBj20qKM8Iwy6nX9c8mnLE4dOSxl7MWlMNI6XzO0Mi
W6e95dFZ5MSjS17/QG/DAyIqgk9yAaM5Br65yNNEclkHLZIcgfDMqK3hYLJvo3BK
Jq/QvG90fQ39ShyQY2NkOitEWZOSrg==
=2Uma
-----END PGP SIGNATURE-----

--Sig_/Rl9__J4XXUlGLF9qh=41=AY--
