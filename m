Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2995E5B87B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiINL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiINL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:58:55 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BC7E01A;
        Wed, 14 Sep 2022 04:58:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D3C06E0F93;
        Wed, 14 Sep 2022 04:58:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R02vuMtXWq3E; Wed, 14 Sep 2022 04:58:23 -0700 (PDT)
Date:   Wed, 14 Sep 2022 13:58:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663156703; bh=6Cy4wlXEsbh2KFaV8g1LkVJeWFmWKSLXGZ3+KMzj9/E=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=QDPB+0GUoQT6b2OU+Tx/dvo9BVZ31KGGsNRwgagbjVDxPcd/WBlQdThsL+Zai111T
         7KwsZduhHuyFM/ONcfgHJS8w7my0Bb/j21/GuUWyT0/OjO/BBzICzN/4ZwY2ekmn47
         hNAjteW2j4P//W1sWXGyJV98BM0tHpDBIFaglecRWweDNtwFgWkbvSeMaWS2/Yw3E2
         HhAQNfln++pkknKfUdyY/t03a9fPhA1xJ3iJTCQ7w6hJjI+sz1YtopXPwSsNyy7T7x
         XxK7/1NFwTg/KK1L4GFmziWuHnyCoH67qbi34sa5AEkvyPm8Z6nfk18DZYQ8XFX2ZU
         xIzCwBiK34sjA==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: [PATCH 2/2] Revert "media: imx: Round line size to 4 bytes"
Message-ID: <20220914113436.1503790-2-dorota.czaplejewicz@puri.sm>
In-Reply-To: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
References: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YX3pqtpGeBOz/ycx14pb+iH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YX3pqtpGeBOz/ycx14pb+iH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This reverts commit 056f9af9fbebb81ebc972540122fb3bdad81d8b1.

The method is no longer getting called on the i.MX8, meaning that
the responsibility for this functionality has been moved entirely to
imx7_csi_mbus_fmt_to_pix_fmt.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
 drivers/staging/media/imx/imx-media-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/=
media/imx/imx-media-utils.c
index 73cf0d855967..294c808b2ebe 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -545,13 +545,13 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_for=
mat *pix,
 	}
=20
 	/* Round up width for minimum burst size */
-	width =3D round_up(mbus->width, 4);
+	width =3D round_up(mbus->width, 8);
=20
 	/* Round up stride for IDMAC line start address alignment */
 	if (cc->planar)
 		stride =3D round_up(width, 16);
 	else
-		stride =3D round_up((width * cc->bpp) >> 3, 4);
+		stride =3D round_up((width * cc->bpp) >> 3, 8);
=20
 	pix->width =3D width;
 	pix->height =3D mbus->height;
--=20
2.37.3


--Sig_/YX3pqtpGeBOz/ycx14pb+iH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMhwdcACgkQADBpX4S8
ZncOlRAAnYd6aqRm9Jxu3Yt/QBLmrQKMKDg0MkwZaudSnDtCQCGuPnQihWEuCFvK
3V1CKH6MjmrJ5Aj22YzpnX5hmtBZ3qJJMLPErKejc29ppK5jqmYmMx6FpAGZHwtV
lhUUQ5/cEtbbDtx3eYJi8c8niu3rzHhn6y6UOrtHs/UYQKVMVdT/bYwp1qtd9OuI
k+mDMR2raxwdCe5GaQhCgAe/YoaenPyqTXYBtrpG3KFVBHrBY2cShy9ZRyRwXIw3
YiZZ5l23eKgQsnrHZuwj+fNQ5e+MDxdmxj3WjBrt5UfxYKzZv2TaeFQgrcxrbQ4S
cYCkeCOJpuXiCPTv6xZhFaAsli9E55Pn+J+vEC/VY79UUJnrB88oE+p1US7Z6H+V
5F0duTfUdAslzURhMHfra0wvZ9vPQadQawa29a4pMayqnz1mZeBED+5dDt32l82e
HlbKL1M2+uvanrXF1twmdXZmByrTv1F4pGv44MTutAobWsoKkM5kc+B3Mwi5wfeR
q98ErStCNb1Xf2W5nWrS3qlE/dYsjjABG/k6R9dioeJyX20ms3pXT2JUia8aP2bJ
xDNknxeCmBm83eKyIr2KyVQzUS/UZPsYOtsWGV6L5dRLVpW9flxJqKGdf/WROlWv
5EZss2gXY3Q7KrmTkF4BK+UIfMk3InUebrPrN/bAA6Yf2oKigVc=
=vqCl
-----END PGP SIGNATURE-----

--Sig_/YX3pqtpGeBOz/ycx14pb+iH--
