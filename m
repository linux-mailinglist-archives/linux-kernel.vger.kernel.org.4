Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636F634F99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiKWFdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiKWFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:33:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1C26AC4;
        Tue, 22 Nov 2022 21:32:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NH8sh3GXdz4xGW;
        Wed, 23 Nov 2022 16:32:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669181577;
        bh=+jCZiVAOePrhE8wSGyAYoXMn/pbPMzBGm+ZypBiLzQw=;
        h=Date:From:To:Cc:Subject:From;
        b=dZNqW6d53Yg4r154+mz2v86Od6HvBzGH2wgkMwN3tXRJ1MsbefFS1Y2mEfUXurqft
         wVh5daptXdLun/5U4TCyRORgEEIQ9+tx/SmBywclyu9lE+hmaiyy+Z/uZmF1uIOfNj
         KZk6AsYsUMcmqf2IRwAlUv380+Cqt2evzNdMd3CfLiNdSA8WtmjIIrXyOLq5QjPN7i
         2jLG9SAyT7Yp07LBHqT/7SlNdcUZvU3A30edvFDfOzU7lK2L8urU66WxwSQalZOF5G
         +F1WexhmwTJPBmXXT4gfBmNHJQjiwPVO9mpg02njUFTb8wyCEEfGt3gJbTaRpOri23
         z1zYXWxHq9Xfw==
Date:   Wed, 23 Nov 2022 16:32:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the rcu tree
Message-ID: <20221123163255.48653674@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EFUHsV+UjFtxK1tYhTiW1.6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EFUHsV+UjFtxK1tYhTiW1.6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/RCU/stallwarn.rst:401: WARNING: Literal block expected; none =
found.
Documentation/RCU/stallwarn.rst:428: WARNING: Literal block expected; none =
found.
Documentation/RCU/stallwarn.rst:445: WARNING: Literal block expected; none =
found.
Documentation/RCU/stallwarn.rst:459: WARNING: Literal block expected; none =
found.
Documentation/RCU/stallwarn.rst:468: WARNING: Literal block expected; none =
found.

Introduced by commit

  3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=3Dy stall infor=
mation")

--=20
Cheers,
Stephen Rothwell

--Sig_/EFUHsV+UjFtxK1tYhTiW1.6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN9sIcACgkQAVBC80lX
0GyDZwgAoqTZAoiy1Lmb7EBIul2zcS0zE90jbJLYGRQvd7zg3rMuew1RsYEvjdpA
n8amuH+o09MuacoY3xjV45YT+O8w7F3j5aMBL1wJy63Wsv2Rdlfipanx+HfXWOwF
HQemhgx91HGt+58nkLiCSdv2z0mCvtd2KhpdD6qFU/jxC2YLYiDqWLjZ61qLGfCP
TUB3XaK39N6k75QMpNLOj7ny4LwEMtJsROl8qsKcthwkvvyGg6qRHEhHYMw913TO
AcVch1sG+dnTRf+eAfkSvmNP4crHqzZU2Gb4WgrunYBV2Pr5ZhFtf2fWpAQtIug1
WdT1RfusM4y36X2I9URPDKAbN0QPBw==
=A5Gb
-----END PGP SIGNATURE-----

--Sig_/EFUHsV+UjFtxK1tYhTiW1.6--
