Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F674CE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGJHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGJHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:32:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401D127;
        Mon, 10 Jul 2023 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688974322;
        bh=nYExeVWTKDVpjPfK7T5v4kV03BaqS2nwUSenZ8ILsbw=;
        h=Date:From:To:Cc:Subject:From;
        b=AcetUZdFSYKuJErgg0mbvUvVhCXmIKwPSGkT6SlDJg0jaRDnBua0PlZMd2UBdWG7Q
         /6IR3aid1zvkQosr2fX9EXMaE3xiy/8Kiu80nxijWhuolu1hf9qHO6iy5KRk60Mp2y
         c3n5+J49X/uCnldshONYpnAVyoxRwqpN0mBmNKvrmkv8K8Na1uDDNakZmlfjV+M152
         82Xzcgp8FUiKQFWbXrMX26inya5xcRm0waHhbxSxc/nbL34/BWgEdDlKUdTzYsHTTz
         rGLMDxtttg+3lbrhLyvrI+IY6D4yqCKDUnz5WHooodPYYMzHS9yAkD//fyetqBYEJq
         7XphTD52POW0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QzwgN1xqxz4wb5;
        Mon, 10 Jul 2023 17:32:00 +1000 (AEST)
Date:   Mon, 10 Jul 2023 17:26:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: linux-next: branches to be removed
Message-ID: <20230710172602.05d32c03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mLLH.VOdAvu65=mT.zWTVbR";
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

--Sig_/mLLH.VOdAvu65=mT.zWTVbR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I will remove the following branches from linux-next tomorrow as they have
not been updated in over a year.  If you want your branch retained or
reinstated, please just send me an email letting me know.

Tree			Last commit date
----			----------------
arc			2022-06-05 17:18:54 -0700
  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git    for-next
cfi			2022-04-03 14:08:21 -0700
  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git     cfi/next
clang-format		2022-05-20 19:27:16 +0200
  https://github.com/ojeda/linux.git      clang-format
clk-samsung		2022-05-10 19:19:34 +0200
  git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git for-next
fscache			2022-06-10 17:28:43 -0700
  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git     f=
scache-next
imx-drm			2022-04-04 09:34:21 +0200
  https://git.pengutronix.de/git/pza/linux        imx-drm/next
netfilter		2022-05-23 14:33:38 -0700
  git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git      master
netfilter-next		2022-05-23 21:19:17 -0700
  git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master
soc-fsl-fixes		2022-05-22 09:52:31 -1000
  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git     fix
unicode			2022-04-28 18:19:09 -0400
  git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git       f=
or-next

These branches are all empty except the last which just contains a
commit that is the same patch of a commit in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/mLLH.VOdAvu65=mT.zWTVbR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrsooACgkQAVBC80lX
0GygVQgApAEdcKjfY31HOAfD9Zb1M79r8im2AJPjoZ7m0yU5Ttf+6zRh24TfaFvc
TKhxkWMXqd+GpuriNXhmNEeehKoteASWtV7ZR9WD1rSKuM3oe0JS69DZjKPpI0H5
tQffDqjUsuH0JX0gFkdzp+xglwP3HBRV6NZ0TfhLMpMzdbfhw6r1z6cxY9vlMt42
bmvpfIRmmTZ7dHz9PFjoXYVqe1SoZDDM+6SE8nCbVg7IqHqVuT/dqunbDtSKoDtj
10kD4LJJN3FJhV5mQBRswZ+n83/9SEPccF59M3W7ertCZrXc9EhMdyYyQxewqUjl
QCEYT+Upant4/2kEZFQo+JPu6J7Bqw==
=uo5i
-----END PGP SIGNATURE-----

--Sig_/mLLH.VOdAvu65=mT.zWTVbR--
