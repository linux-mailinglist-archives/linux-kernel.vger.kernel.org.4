Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D516AC9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCFRUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCFRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:20:52 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00223E624
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:20:17 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PVlRG4ylQz1S5K9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:08:58 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1678122537;
         x=1678986538; bh=XBMOf7rDZmk1/gq6Hnv29VSjIdHlkH5Ie/sn9RbtUDE=; b=
        SBLHlIZHp18TF8XEMfqxRVYUtBJ8qLg3S1zwWYUHk3/1VlWgP5VBKUhx2FOcNObe
        NKPSq0pEBnqPVpEu5hfCaNZskZ9huTSWKm2nE6PbIkK5H9r6GoTV8nttG5Z1k/W8
        vU2/KUzNaTASQ48/WQMRavNv6QfFgC5ytJt2hLqG+Msx1kpjDOcAY8AXTnPFoa/E
        I81JWFq9fu7PjXv+TugiI5IBF27GhPX1w6VIBdK8dp0gDZjDclyF1P5nfeyVcaA1
        i2XNs34AUdH0JpxREVX5t+j1+FEvws+YP93uj4NdXoz5QREYVqIpJ45Z6mQalNnQ
        AL4udljajE26cFNUKTS85w==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GSZnFV6g0-n9 for <linux-kernel@vger.kernel.org>;
        Mon,  6 Mar 2023 12:08:57 -0500 (EST)
Received: from dorothy.. (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PVlR46j1Tz1S5Jl;
        Mon,  6 Mar 2023 12:08:48 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>
Subject: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Date:   Mon,  6 Mar 2023 14:08:13 -0300
Message-Id: <20230306170817.3806-4-they@mint.lgbt>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306170817.3806-1-they@mint.lgbt>
References: <20230306170817.3806-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM6125 UFS PHY is compatible with the one from SM6115. Add a
compatible for it and modify the config from SM6115 to make them
compatible with the SC8280XP binding

Signed-off-by: Lux Aliaga <they@mint.lgbt>
Reviewed-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualco=
mm/phy-qcom-qmp-ufs.c
index 318eea35b972..44c29fdfc551 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] =3D {
 	"vdda-phy", "vdda-pll",
 };
=20
+static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 =3D {
+	.serdes		=3D 0,
+	.pcs		=3D 0xc00,
+	.tx		=3D 0x400,
+	.rx		=3D 0x600,
+};
+
 static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 =3D {
 	.serdes		=3D 0,
 	.pcs		=3D 0xc00,
@@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg =3D=
 {
 static const struct qmp_phy_cfg sm6115_ufsphy_cfg =3D {
 	.lanes			=3D 1,
=20
+	.offsets		=3D &qmp_ufs_offsets_v3_660,
+
 	.serdes_tbl		=3D sm6115_ufsphy_serdes_tbl,
 	.serdes_tbl_num		=3D ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
 	.tx_tbl			=3D sm6115_ufsphy_tx_tbl,
@@ -1172,6 +1181,9 @@ static const struct of_device_id qmp_ufs_of_match_t=
able[] =3D {
 	}, {
 		.compatible =3D "qcom,sm6115-qmp-ufs-phy",
 		.data =3D &sm6115_ufsphy_cfg,
+	}, {
+		.compatible =3D "qcom,sm6125-qmp-ufs-phy",
+		.data =3D &sm6115_ufsphy_cfg,
 	}, {
 		.compatible =3D "qcom,sm6350-qmp-ufs-phy",
 		.data =3D &sdm845_ufsphy_cfg,
--=20
2.39.2

