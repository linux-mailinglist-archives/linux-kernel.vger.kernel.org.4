Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35026F9EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjEHEod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:44:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BAF1569E;
        Sun,  7 May 2023 21:44:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF7x82Mrhz4x3r;
        Mon,  8 May 2023 14:44:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683521069;
        bh=KCucJGJ5tzmt46L1nqBZCyljr3pj6lo/3+pB8fJyW8E=;
        h=Date:From:To:Cc:Subject:From;
        b=DqqGexDiyuC1rgNbmcWJckC21f9OpnycGfAt2SsUSA3DFvvQ0V/kzLjNpaSgq8+V7
         ZUsJkS8KSRdZO2iBqkgYejODsjgJGRhuLXHp3ardkjfoolP7wtA/V0q0TW5TVoTyXr
         X0Rj3K1w8tLfrlLXZ1eNzSdbCqsadHtQCQwMT30WzJvdSAo7P3TyLETU9rrBMJbbuC
         NwC7UXofl6qS+B1+YgemfgqftykSluXYttpeRihnYHt3wTiYlydvis4DUUSW2LDlS8
         +1Oxz69uNO9xXUHfc8UvxckjlSDHkAdkzG7shG5aPoLOXtW/50hcjweq+zKirKZbSl
         CIUMO2U2eL7lA==
Date:   Mon, 8 May 2023 14:44:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of Linus' tree
Message-ID: <20230508144426.608fb8e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T82=BPcd3bDu.6i_92Od.Py";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T82=BPcd3bDu.6i_92Od.Py
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

While building Linus' tree, today's linux-next build (htmldocs)
produced this warning:

include/media/v4l2-subdev.h:1130: warning: Function parameter or member 'cl=
ient_caps' not described in 'v4l2_subdev_fh'

Introduced by commit

  f57fa2959244 ("media: v4l2-subdev: Add new ioctl for client capabilities")

--=20
Cheers,
Stephen Rothwell

--Sig_/T82=BPcd3bDu.6i_92Od.Py
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYfioACgkQAVBC80lX
0GxXXgf9HY8jJZyZ5oyGDEDS3MszLfl7G0EKVwIGL7mHCY0AjgT1RIG0OxClGKXk
v9N6Oj/QGvpDtJfHJfp6/1Qz3kYpPWVeDXYJNor/EcIwWMc3gPQdi+PtOdtR6vbX
JptLiVkU2lO6xuogT3bq+3BW7qS3+iCsf6Jc9n+LaEEyJE1ytbaGlwi57oyfpqAM
XAhEAuSEBfxCf5qR6ibJRpRadK/p+ghoaHGxOac8nv7HD66LLiHqWB41/ySVTaab
RJyVSIf8uGmvvfVUTSJwKfpNLclVKBedu8C/LjOft9djGhJD0dU3ct/m+5BdqRqf
0SJM0C0t5nftqulnO9EyYImovOkZPw==
=fPNV
-----END PGP SIGNATURE-----

--Sig_/T82=BPcd3bDu.6i_92Od.Py--
