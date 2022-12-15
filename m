Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64464D4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLOAgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOAgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:36:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796B22BF4;
        Wed, 14 Dec 2022 16:36:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NXYDt4NM0z4xGR;
        Thu, 15 Dec 2022 11:35:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671064558;
        bh=1dLJs+aAyopmprTRLfaAW8LbrfpKsfSsbarhISv2h+0=;
        h=Date:From:To:Cc:Subject:From;
        b=Mb4/ZI/d0kxv91HRYeJxiUY/6RKj4FnpywGx/x9+kQWvbuDBS9pWwlyoBxDA8OlvG
         tK5lCnXLp96RCC5qQvK+BJpi2Bkkx36pc7MywoqykN/AedjBDU1nNmOPlusxeXoy8U
         FoR4G6vWi90mRMG36EMJERLdecl7ZiXi/BIuwY39HKMfTLDuPqNWlTlbsfAqZ0BzfT
         iVMKUHD3rs/mIgjZ/rj7SisoKHMAaBs2sHr2vHoo3ttfrNyREp2FyzxcC7fZc4/XZ9
         DMfzto0c8Mq9jP4thR4+IbDFx+NjNKP609MbJxCIfq81DHnD9VmPzxgVUOzZJtCqDk
         iq/YwMoMmTlyQ==
Date:   Thu, 15 Dec 2022 11:35:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dillon Varone <Dillon.Varone@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221215113557.543d1fbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c_.1Stft.P3rDc04t=7._YB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c_.1Stft.P3rDc04t=7._YB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:876: warning: Function parameter or mem=
ber 'disable_unbounded_requesting' not described in 'dc_debug_options'

Introduced by commit

  c96d529773db ("drm/amd/display: Add debug bit to disable unbounded reques=
ting")

--=20
Cheers,
Stephen Rothwell

--Sig_/c_.1Stft.P3rDc04t=7._YB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOaa+0ACgkQAVBC80lX
0Gx7mgf/YCJ0EIE628HqaweRJhwNlc2hFAp5iOPU9XydWou9QYNRrbt67mGx5khi
qlWYMolRziK/UyaT1k0exlszBJ3GIMnt5VX/JkoxWwsZZe183Nv99kfVkAsrGbsS
cP7cYjYBfG4sbrXj/8mx8Bnnltma67eYq9BRk+Sr2fJoGvWJEYTPGsKdpyrR9VkQ
r8trFo20IJozF9Cb0tjwZtkuwVldo/t90FhwwZXRp0v2/SgQRMhahAC5MSeXgFQm
Wz/Tm6y66bRgI9L74LcT7SzT7Ws995RKdcFUg0Ol9pQp5DpHULz6yrW1xyg5XlqV
bWFRJncSgBsy6220dahJkXpP8ZK1tg==
=fJCt
-----END PGP SIGNATURE-----

--Sig_/c_.1Stft.P3rDc04t=7._YB--
