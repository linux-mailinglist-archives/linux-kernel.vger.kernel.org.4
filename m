Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC362A333
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiKOUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiKOUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:41:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189301C10E;
        Tue, 15 Nov 2022 12:41:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBdQ413mgz4xYV;
        Wed, 16 Nov 2022 07:41:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668544909;
        bh=7bI5e+0Hg7X4jftM/RxCXhw9GKH3MRt/aNMuRTVjD80=;
        h=Date:From:To:Cc:Subject:From;
        b=O4c8zt1jYYu6Y6Jdx+u+fDLlfD3VLekRVBuI4bOcCFvALW2xKk+Qlp+9tknspHD5a
         M5bPz9rp7M9bMcLC9yGqNzew/0IRU9C1aWRTZngBws3udDSHbUjFhyg2anvIrFuXws
         qpz8fjBl5eyyOvg4Lmj4Qg6h7aLq8NR6obmesZFIFLRdaXwIJ1ydS8QTgF1r9MY8Hr
         1Y0Wf/Yn61YEwkzsn/14UR6kc737VzYNFXmw2TRRMYr+pYrfeS+fwoBcz+EvK+WNkR
         QIFnr403kAERceWW9vxeJC9VeDbFx6KU82MErvkyWWZq0Xep3MtGs8m+WdSi4LIwIo
         02LKQ+3Niup7A==
Date:   Wed, 16 Nov 2022 07:41:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20221116074146.6e7cbce9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9CmOp9bGL3ZEjCl_B3bAYt2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9CmOp9bGL3ZEjCl_B3bAYt2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9898f0456aa3 ("cifs: Fix wrong return value checking when GETFLAGS")

Fixes tag

  Fixes: 64a5cfa6db9 ("Allow setting per-file compression via SMB2/3")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/9CmOp9bGL3ZEjCl_B3bAYt2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNz+YoACgkQAVBC80lX
0Gw5Sgf9FFkHPjtBJq+FNiWEgHnYfSZ38BmX0Vs2OBw2QkGxoJqT4z5OdKshGd17
IaQBs84sbyvxLkk9FSgGl1km7QN7ySHzPjZxf23ZrcjHCAw/qC7xpVXRbo2ubYs7
hQGZszpIIfu8eWM8oSKK6FQUAjm+5H4OfOIXIvGuvS69JGwPljHDSmulEG8IMtjy
IjKXIZ5Jx+lx1a9yzNDDE9gJIwH66k2ogiPGHiYOATQylLIlOJ1Wp8CKY+TfF+Y9
DVy/Vz2OPgOS102uQzO1V4jn5GD2lIDTm5K8tWZia4Ghh6kQsm9VMoaW65RbAcV+
d/xcYCFyOYWkmRO3iFxR/bod9O7MUQ==
=wpTn
-----END PGP SIGNATURE-----

--Sig_/9CmOp9bGL3ZEjCl_B3bAYt2--
