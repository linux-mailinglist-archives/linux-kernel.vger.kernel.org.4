Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7416A6139
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjB1V3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1V3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:29:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBE29153;
        Tue, 28 Feb 2023 13:29:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PR9V74dVzz4x1R;
        Wed,  1 Mar 2023 08:29:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677619743;
        bh=1YTwPo7oLOtuSR38KjHXSv+yT55KdVYy1P9mQp9lAF8=;
        h=Date:From:To:Cc:Subject:From;
        b=XTL2doQNxhXJfn2VHW66N6ZXB9TDlwJZhuK6qLfIPFaiQKqhca40v//4DQjscyGZN
         BBm6TZKsVgb9Ck6+VzMKWYP/rxVYEhZRmKKLrstQu/7RZ1UG0G8iJhxj02phyWv3Id
         qt2aEdi7TPCoj4NoSGdrfB4Nu3vOStbZ2e77bgGMqwxSeryFP/pY2WQOJS3w7d8jC2
         qTznYWH7fRdyAk2/YWCOCxkTOdcMz0KcFiWDIuXTHYvyoTdrPp7FwR80q2LDxGv2AG
         eTfIXydczgDfnJ4Y4ujx9ICNorFr3opWMw8uxPaTkvCL490ezCWtm5yxW1TbFT9Tt7
         8glDefKtOG/ZA==
Date:   Wed, 1 Mar 2023 08:28:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ext4 tree
Message-ID: <20230301082851.221dbf83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MUCAmb=tFHq6hPf8mcPXyk5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MUCAmb=tFHq6hPf8mcPXyk5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  2806abcc9782 ("ext4: init error handle resource before init group descrip=
tors")
  98c8afa3038a ("ext4: Fix possible corruption when moving a directory")
  2c2dec1e86cc ("ext4: fix incorrect options show of original mount_opt and=
 extend mount_opt2")

these are commits

  172e344e6f82 ("ext4: init error handle resource before init group descrip=
tors")
  0813299c586b ("ext4: Fix possible corruption when moving a directory")
  e3645d72f886 ("ext4: fix incorrect options show of original mount_opt and=
 extend mount_opt2")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MUCAmb=tFHq6hPf8mcPXyk5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+chQACgkQAVBC80lX
0GyR4wgAjxCMeWkrpo0ov4Ucfz5vR2FjYzv1D2KsnoDM+qgLbOcxU6XCNADFKq3Q
Pf2TwMBtmiszlWpnq+8yX1jZps8AUAC3Tdg5GME6Ie7zIcxz7fB0gGDHx/jMCDId
oYakJkgdJ2f2H1S2YciFTdfo02EkfCyyGRiRtXkErOSqvWSkUZnMzZDMJ6eO0BIr
vgPizZ1kdf66VsZABZjXX/qPjNsVmE/QslWVnCo/HFaAqOP7Q79MDzVZ3l+/1vpT
LtLrQO0ZcKU93zulR1ju//wCgY6iHTJXjfYe+EJ27jCp63xUlZd18XjROVmajSSO
+DCPWORRsrIWAKqrmtRFyDMnTdqCww==
=4sQZ
-----END PGP SIGNATURE-----

--Sig_/MUCAmb=tFHq6hPf8mcPXyk5--
