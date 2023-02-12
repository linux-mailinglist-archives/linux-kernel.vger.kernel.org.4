Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B29693A30
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBLVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBLVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:11:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA1113F1;
        Sun, 12 Feb 2023 13:11:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFKsF6PtMz4x5d;
        Mon, 13 Feb 2023 08:11:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676236290;
        bh=ghMc+0L8AT/G7owcQOfXsIdYbVipavZ2xYTru+aFv+E=;
        h=Date:From:To:Cc:Subject:From;
        b=rx7GQ8YeNiwOVi+EEszXXJCbaSKmWi1rKF7zmyjCXPzZTkqN6d5CqBWG8IK/Y9X8a
         c89e6kAGafnbIH34eguVttICpd3cLp32CBCMISskbotp1Gj+n+Gyg2AEmBIiPl8qRX
         bytng1+2fZohkCYK9hu6J2pootSy3rf7AU+diUQ9vexQKkKC7KgBzpGZHQAjYGt600
         /Vm46MIq10NPeDniASrSk8i0PngdzPB/PbsgQelbYe6GuyKyUeZqeldUg7XrEHyzq9
         GQCKAhfaT7hXlFj5saxdd7RmlIte0svdHO6kjZZVYamM7AtWYwPHeRgJi08wYP+EDi
         iAxPXGcIxMWCw==
Date:   Mon, 13 Feb 2023 08:11:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the uml tree
Message-ID: <20230213081128.0659dd4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BlV30vuyW/5+a_CfSdmdvBm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BlV30vuyW/5+a_CfSdmdvBm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  46d4f4457984 ("um: Use CFLAGS_vmlinux")
  f348208e5daa ("um: Prevent building modules incompatible with MODVERSIONS=
")
  76d23d6f4a8c ("um: Avoid pcap multiple definition errors")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/BlV30vuyW/5+a_CfSdmdvBm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpVgAACgkQAVBC80lX
0GzlzAgAk/apLTbG1C26xgv3sNsOWvKjxK3SKLhTBvFcF1Eh2voyUKQwPGw98ic5
DWZYKkzPEmPPLHyAjI+ka/xEefUOq+QiMXH2QOj0XnG8WTebM+bkas/whqAdImiY
+HWj1ZREai2WIS9UT3S54dDfVO84+p8sjmINCykrvQgFTw8BKJjfcgoo2j1nvkcp
ye2kYqxzpkt6CNcon1RdGxz+HMHQSrF2RD8CbKkLxEBaUJYpYIny0Mr4LxXyP08E
RkfmcpCtlPr/g7fKXKqRgfhCsLlmRVikxWCldTW+eAQfbB0hqhwWlrnIbwvFKf0x
YGjiX7/fgA+CuNapcEibn6YIEPDT3A==
=8PZk
-----END PGP SIGNATURE-----

--Sig_/BlV30vuyW/5+a_CfSdmdvBm--
