Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A848A66504A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAKAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjAKAOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:14:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A95BA08;
        Tue, 10 Jan 2023 16:14:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ns7Tr3skpz4xyP;
        Wed, 11 Jan 2023 11:14:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673396081;
        bh=6l3SLcIc8pIPh6D1lb3lPuNU2LSqGXMwWidA59p7Sy8=;
        h=Date:From:To:Cc:Subject:From;
        b=Z5II0bDVr3t6RRkxho+yU2V/du9nWQPVA7KIquelZnk60TjEf4CY5kjClzQ7sbCPD
         1kL+LD8OmSQ3RXrL8s4+sBXzFoTY2uTNxN6C7QFgOugO5HuaXIvANJ1sS28nUbfihN
         hwRwLuL769I7WiwPD/SR7zfnxii/6hua9WKA9pj+inIrffjhFdfkrgMV/vbj8tIjcX
         6+SDjOH5zrCthBFfXRKyFyRYabKfqHjTjtXvsO+5qfFBEx5zklxQZZoTVM9lTGAsR3
         zNdFH+zbwiq+l1RaerzTXd2KBPfyjRxybsGr6qsm1FdB/hQbPU/sQJs0yKHBgRzdhv
         2EYJz9lVpWw4A==
Date:   Wed, 11 Jan 2023 11:14:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the rcu tree with the tomoyo tree
Message-ID: <20230111111439.4c4745d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/58cR6x89EqNrDrHYPfwdeBy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/58cR6x89EqNrDrHYPfwdeBy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  security/tomoyo/Kconfig

between commit:

  80f8be7af03f ("tomoyo: Omit use of bin2c")

from the tomoyo tree and commit:

  ed87f6865857 ("tomoyo: Remove "select SRCU"")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/tomoyo/Kconfig
index 772d2ab58fd1,a9796b400312..000000000000
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@@ -6,7 -6,7 +6,6 @@@ config SECURITY_TOMOY
  	select SECURITYFS
  	select SECURITY_PATH
  	select SECURITY_NETWORK
- 	select SRCU
 -	select BUILD_BIN2C
  	default n
  	help
  	  This selects TOMOYO Linux, pathname-based access control.

--Sig_/58cR6x89EqNrDrHYPfwdeBy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO9/28ACgkQAVBC80lX
0Gx3sggAkXdU/iNkmS/dHW9wyw0PLnptDZMonH3ADofVFWCB9zqO4gKc1v8q7q8t
yE1jtvFEUyPWqXDijWImxTnONAIArOc9m6+75+GVFH39kTamQilDuGeKzVA+l0Hx
hpggw4JxX4Il2xhcZ5oRbTzFPB7bwrTFAXMUerSoan9+EbMHKCHkFDPWfun8sUQ/
ScPRl11EEKb4Pr/WXtwlHq2SQ0vOlmf19ZVoVp3swY9HHRN+mc55EYy22GbIrUcY
HeNuYmJDnBplwdlTthXNiJIJFiAzitI+cC/KAcGS6DAikBJTaQ6EAZnkU+MNi8Un
UyAc4ymsCbLMBrCDBQfkz9YZhcAj/A==
=sCwe
-----END PGP SIGNATURE-----

--Sig_/58cR6x89EqNrDrHYPfwdeBy--
