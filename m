Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18996C239B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCTVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCTVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F08399F6;
        Mon, 20 Mar 2023 14:24:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PgSQp74Fcz4xDw;
        Tue, 21 Mar 2023 08:23:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679347427;
        bh=IDSLoY4LDAJ+r4zDv2oWLD2LbFMo9xSCwqgG0yEwZYU=;
        h=Date:From:To:Cc:Subject:From;
        b=H8nb3eDWfLk2ItG0TGIQrmgoWMMjqVgXURplSaWzFLoMJkwG0ltOYnbrTYzyW3jEw
         wSYdiSitl6nrme8ljcueQAlIqyPniV2apPoTyyYh3N3qhukD9bbPg+5EkF1/UYSJFt
         itCODske5A+LmZvO2UqVqyG8zkXD2m0kT+2w7CSBEcr7yUKvYCgAEKA1Tl2AIa6/dO
         T3P/UiKdBq76u1R1WUDlS2IW2CHx3L4FMfuKs9NWFCLr/719gSew6CiV8382/U319F
         rG6kRvzChcyLyLVqy5qKL1PxwltnjhggSOANG7EAKfOD2Km/AyWgwFiT4oV0/tmOvv
         5lNi3wAwkJizw==
Date:   Tue, 21 Mar 2023 08:23:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20230321082344.6250cfc6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9ILBOFtGKbgAtVkDfXIgmGf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9ILBOFtGKbgAtVkDfXIgmGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  71937240a472 ("media: ov2685: Select VIDEO_V4L2_SUBDEV_API")

Fixes tag

  Fixes: ("media: i2c: ov2685: Add .get_selection() support")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 859128ab6f0f ("media: i2c: ov2685: Add .get_selection() support")

--=20
Cheers,
Stephen Rothwell

--Sig_/9ILBOFtGKbgAtVkDfXIgmGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQYzuEACgkQAVBC80lX
0GxOfAgAn3d9xjb17b3M0yE52MqzZsWx4Xhy5R1RlSLVCjbTex0evrfTKVEBNU/N
Ir8hNel1dG4Pw5g8jTesk4Kpp3IKTdyNZfgXG3UrB8qag0DXMG87Ibl3c0nQmIbA
Qp2c8njxBOG1Dx7KLA78ERePFffFSqi0zqqXf0XHWAzqL5D7QANKM7y7r9Z1nn+p
0NsNi+Bongg+0MndKBkiLjwHGJ4N4fehQAacTgJaZBb2XXp4cnY0dtao3n8iig8B
+v+IKONi+1i5ZP52ONmuwdzTUD8nIM/0OINIZGdCyhpZAKwCgNR8+90wNaKlr+Yd
cGSnQpCl1FxMndga0wqzna2zbnAmaA==
=0plb
-----END PGP SIGNATURE-----

--Sig_/9ILBOFtGKbgAtVkDfXIgmGf--
