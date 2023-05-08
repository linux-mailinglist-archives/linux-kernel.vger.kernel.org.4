Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0585D6FBB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjEHWwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:52:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8668A40;
        Mon,  8 May 2023 15:52:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QFc4c2bbfz4x4J;
        Tue,  9 May 2023 08:52:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683586352;
        bh=kr+Oumow8u22GYtFI/u0jVmTHf09hXu3paGAh53EgLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=TObrQiRRJzrP3B4+k0IoaVIeufvqbGOU3KNpRWv9gNT683aL66SEpMtQYp11JrsiA
         fAgA2b61OyUW4RrWrx2X797gzsLNYOEXPx3hCz2Gld8S+JdfUq1U+aMBZnhpBJvZzS
         hxGS3CgY+pFY/MUCCqOcgMzhEiyLgzWnoM6+028FA0Hogic2Uxsx11v5IFoqCEAs2U
         WiXDKVGlCK1xieUCL1EQjVZMyPQsOtpYOlde1QjkCc7uV98K1fNbH3AXQzLCYLmDFY
         Z/ygHN1GwlIjwk7p0Ivcf8DdSPEXqO8K5DvzVxgSwnkuvSAWs99aHqpIegDUjpwZM3
         z2fi4wqq7Xcnw==
Date:   Tue, 9 May 2023 06:34:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Message-ID: <20230509063458.5fe8ab5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O8bd.08Cvns5=0zc0C48hFh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O8bd.08Cvns5=0zc0C48hFh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6b854bb90d23 ("media: platform: mtk-mdp3: work around unused-variable war=
ning")
  814fb7f94d70 ("media: nxp: ignore unused suspend operations")
  4ab0bfe3badf ("media: nxp: imx8-isi: fix buiding on 32-bit")
  97e814237417 ("media: rcar-vin: Select correct interrupt mode for V4L2_FI=
ELD_ALTERNATE")
  07ea2bc2f320 ("media: rcar-vin: Fix NV12 size alignment")
  60ddb2e1a331 ("media: rcar-vin: Gen3 can not scale NV12")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/O8bd.08Cvns5=0zc0C48hFh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRZXPIACgkQAVBC80lX
0GyIUQgAm0NoP9/AySKbQ8mTUGZJcmeZ01/69BiSLbdf7ygEcRzgeZF2406pUtuH
YOvngvr8SPqxHS5Sj1v9fYBR4P+aWcjz3M5BM2m7EXh6eHslDZB7VVRnlytWhQ8b
NYqd3A88oPCrxwblrNSvXrpUzs/+T4vW7vCULUTqC+v3LoPqcFXWtkbXvzSRBYTn
fD+JEiqn8eVmXu3hR4D2LN6U2SsoTZ2DBJOXvNMFdT0p+2XOlje7MPo/0LuShJLl
KqDaUmn7zNJWgjeDQ3SffxpEs3OlDwOPtAFhyZBTlsO3eR53d/Rt+7zYiYRP2AH6
gGL9hMTREkJt2n3S/F3yMhobkRaQMg==
=WRkg
-----END PGP SIGNATURE-----

--Sig_/O8bd.08Cvns5=0zc0C48hFh--
