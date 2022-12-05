Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D11643783
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiLEV4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLEV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:56:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF7B8F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:55:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s8so20726742lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IYiXc3taqf3OqgKX8G3ZmQD8ADNe5yBaMSKzXtc0OqI=;
        b=SMgQKy8n3TTVSyAcOapLk++OS+iAeyaN+5cH/F7kNHQV5SL/prmMjWWwJqcitjqO7T
         Z7/FLCKlrTa93GdDv5wN97xxWwFoEprCdwKzQrmhd3WC2Ofys4xXk1p1l+ugH40FMAFE
         RZQqE3xL3bv43b87qTHEIkPj6+G/EgPWUySEbotpbKMhYsqHRFHkczzZO3XY8AaYwAQ2
         3rqb/6+mQpCX5jxbtjwydy+DOPCg6AKMCgkvBijqDO26G93Lrw09h9wl5LETDI0wzKA2
         oEYMzVEGcWLTgqMcrKM68FFaJtR5NYcnxyGgm8pXd4iRB6VlIcrhuZywEYbaFbH1yR00
         QhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYiXc3taqf3OqgKX8G3ZmQD8ADNe5yBaMSKzXtc0OqI=;
        b=8Jiy3lCbXshh0w6402cZQ/yMrLkM2T55TIK4zpnWIQvje/R6w+UQJ/DLepggFF/LvQ
         6ewTPCZPFswCxJoGVrDSqvjEFeIAmpgSBLU2EXkeagt+++qustGmrUke9K4MGmy+mgbR
         gjmM7tZJg0fCJkz5n1cJvtIORgZHAi5A5psCsrSGjxJGV/DwFJT3RbSdUJ2YxJRu1JNK
         +qwwoi8Z45AfuP4pBR5BuFGDh1H375Gut+hwU1JmhlnkEFJdh+JIZfUvF7C/kp6mBWGQ
         z1GJMLGaQ5bpiq2rLofUUNBSZ2HJpk9QbIRMMDRoQeTZEQOYypIXWPvj3wG4CletLA05
         k4hw==
X-Gm-Message-State: ANoB5pmzVF4y8c3ARE/IBnQuuVcI5qJ610n67ZqxEJhxFiFjjG9nKuY2
        EFpDYcysM60OcGxV40HE1jtzig==
X-Google-Smtp-Source: AA0mqf4oBbBb6gVe51gRGsXHv3lwQC3IykjlDmFr9izuKScYSa1W+5PArG3TfWQQG9q4PJJ/D23IHA==
X-Received: by 2002:a05:6512:14f:b0:4b5:8504:7070 with SMTP id m15-20020a056512014f00b004b585047070mr217183lfo.304.1670277337023;
        Mon, 05 Dec 2022 13:55:37 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25e26000000b00492e3a8366esm2249627lfg.9.2022.12.05.13.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:55:36 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:55:32 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_10/23=5D_phy=3A_qcom-qmp-ufs?= =?US-ASCII?Q?=3A_Add_HS_G4_mode_support_to_SM8350_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-11-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-11-manivannan.sadhasivam@linaro.org>
Message-ID: <A94528A7-01B3-473D-A5D5-6FA2FED00CAD@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 December 2022 20:43:15 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>UFS PHY in SM8350 SoC is capable of operating at HS G4 mode=2E Hence, add=
 the
>required register settings using the tables_hs_g4 struct instance=2E


Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 36 +++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 6c7c6a06fe3b=2E=2E75e55c4181c9 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -571,6 +571,34 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_p=
cs[] =3D {
> 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> };
>=20
>+static const struct qmp_phy_init_tbl sm8350_ufsphy_g4_tx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xe5),
>+};
>+
>+static const struct qmp_phy_init_tbl sm8350_ufsphy_g4_rx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CTRL2, 0x81),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_TERM_BW, 0x6f),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_MEASURE_TIME, 0x20),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW, 0x80),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xbf),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xbf),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x7f),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0x2d),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xed),
>+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0x3c),
>+};
>+
>+static const struct qmp_phy_init_tbl sm8350_ufsphy_g4_pcs[] =3D {
>+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
>+};
>+
> struct qmp_ufs_offsets {
> 	u16 serdes;
> 	u16 pcs;
>@@ -875,6 +903,14 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg =
=3D {
> 		=2Eserdes		=3D sm8350_ufsphy_hs_b_serdes,
> 		=2Eserdes_num	=3D ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
> 	},
>+	=2Etbls_hs_g4 =3D {
>+		=2Etx		=3D sm8350_ufsphy_g4_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>+		=2Erx		=3D sm8350_ufsphy_g4_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>+		=2Epcs		=3D sm8350_ufsphy_g4_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,

--=20
With best wishes
Dmitry
