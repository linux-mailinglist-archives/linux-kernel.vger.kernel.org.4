Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFEB5B7C72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIMVFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIMVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:05:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2613E9F;
        Tue, 13 Sep 2022 14:05:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRwwY1C4Vz4xD1;
        Wed, 14 Sep 2022 07:05:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663103133;
        bh=GBoVCfnsdgQmNgiCC44VsqCHsq/DK04wIqze0IJdQbY=;
        h=Date:From:To:Cc:Subject:From;
        b=oVC3RtDx8yZ6j7NbpM1WtHTSiBQFpsDGWZFeHEiPt4vPJbmnh1qPkPwt2r7rqs2PB
         YWNG5ImUDscMX1HqVRt6gCBCtpYrJh54nzKsCe3jhcN7lAfDMlBuGOnbj1P4UeCYx7
         BtA7zXXGSSCknIehNcxokgc2wIC5832jadDIEipcQoDpE0tuZJjnYlSK/5fJaIOxtA
         sw6istEFkyLOmpGiDbtpMVbmfe51MmZO1ok7JYiIrKy33/CFw2cx2tZ7EICx5F4P2c
         9vdjIA6HimbFlP4UunQfSYF25PBecPTw5tJRrFE3HJlEgPIn/DSwP1wn2tW1o3Kkg/
         DANTDsMRkP4jA==
Date:   Wed, 14 Sep 2022 07:05:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20220914070514.3a2718b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wNltMeyZv2DZMen/BPodXaL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wNltMeyZv2DZMen/BPodXaL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  78b161ba86dd ("Kconfig: remove unused function 'menu_get_root_menu'")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/wNltMeyZv2DZMen/BPodXaL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMg8IoACgkQAVBC80lX
0GwODQf9F2UDAcUQvUhVlL1u2xvnOZowgWl6JCE5Xj7orAs5OW6jiHbrIQ33/L9A
Kbr9QpSGHgSODcCP7vzqFbHj0K0/zGqIcg10Uap7mSBcApk2pBG51F0XtOIiO1Yh
oOJc9rg7dYJwsA8AkShUzUmDut+PepwyDykMBZZtKErOOtjzAuewLM9g0qumARFV
s9DYfrgZZDczs4i0rdwCz6olPT8Cmza6EiTuvIybQISSajqDOuLEZ4q49eV804qa
JTMyIFS69MC2dsuEaPJfkj6El6L6IUCBgcVpb8X80jUX9HndlQ3+2kjFLDc2QjHM
8/Y5anpIMev/8mBp8r21dsTtdoa2eg==
=UnrZ
-----END PGP SIGNATURE-----

--Sig_/wNltMeyZv2DZMen/BPodXaL--
