Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3869D6022CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJRDmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJRDmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:42:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954F10B70;
        Mon, 17 Oct 2022 20:38:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ms01z5sgyz4x1F;
        Tue, 18 Oct 2022 14:38:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666064296;
        bh=hFKai3gFyN16yzXHC3ljQgqkU9Y4Kj4jOOZKFp5hLYo=;
        h=Date:From:To:Cc:Subject:From;
        b=MVOCPVK7Sat/iG95fMY5Oq79pScMaHDvSd7pRN1xYlOnKio1gdzVqP7wnqCoZWUVh
         2wnL7+mxSMKNQG6p1NNmeL1G5ITAYc311AMz8pYy21zTEJgXyiqkxkAbwz2DbaaEcc
         kVeCbdmDPvqq8o2HZkHXPC5yv55xP8+cyQM48bufooto8jQ2RjEuevfWoVta5K7++k
         9oDVzdAw8l7peMybpnwVsZCr3d4BjW79i0gJNTrd6IlVLEsjq3YZO8nt77JGGazWAH
         AtkOCpaEEWuhCMN7KyLs1s6+rHZ+SJSI510L64iKsx/BvCTc+EfhWdSHXP186otLUA
         3FO+lbCv7mkjg==
Date:   Tue, 18 Oct 2022 14:38:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20221018143814.34815e82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jMzh74PHCMpHg5WRnO/OFfY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jMzh74PHCMpHg5WRnO/OFfY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1b028682528c ("cifs: set rc to -ENOENT if we can not get a dentry for the=
 cached dir")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/jMzh74PHCMpHg5WRnO/OFfY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNOH6YACgkQAVBC80lX
0Gz2lgf9HU0ZKqQ2NxKCwJATiv3a3qfcBduNbjNTqMT8kz1gzowvCPIZXVa94k7p
ZeUlDE3OetmxV4FmGLqBG8TSePiY+0QvkjfDJqTSjvO8hXwF0264aPTXsMXOVV4i
/E3xwB4ILwnnf15xHWcO+du6zMrRef+o0pS/+L/2NJURVDRg5ijAE3A2+cRPZ70n
4+SyUj42QOWmQkisI7DzHJXb2sRQAJE7IOU5PGfRjk8aE5Ol8h5RTDgUkszGqKF6
r4ARM/YAdvswPboHXXb2t+8XfnCkLuK1KQxuTYbG8kRWGhMl2fcC3E4T2BhOQ6WF
6BEZ4+6RCo9KCP2byhWLRdIieFClCw==
=XCXv
-----END PGP SIGNATURE-----

--Sig_/jMzh74PHCMpHg5WRnO/OFfY--
