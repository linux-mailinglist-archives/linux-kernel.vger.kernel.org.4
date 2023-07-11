Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3875474EE49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjGKMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGKMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90271BEE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b702319893so89294201fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077935; x=1691669935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmM1SbjU7EsG3x868ftGBwF3Sx0onSUF7y0rst5GVmk=;
        b=plwZoSoPJbs8qjoxscUxgQbGiP+UHsQcjAV50k4jG19V2z2Wsvtort2aBJM7r4VJmY
         fv8SPk1i0duQrQ3BKnNVobCgfRgjedwELJGkh0vA57S7fMMhEGFTmcrGDaKo2/5Ry5ey
         +nxJsn1+re5r6HxsWq9ktFNl+PbZ/mUKDzbXOfbxDYabazC4Vsg3CApgqydyexzxHV4b
         RYpaTkY7efLvYAyB/V3NAP1jXqhvDT7QwxJ53D7h2he4dgHI6KYeAxkeB7bRVeBDZDkO
         brWQQYZCJcSYdQYXGSFl7sn1J6OrS8rDxbkO/4rEmOhDgK45neFWbETYHFDfe5c7eYHe
         AnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077935; x=1691669935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmM1SbjU7EsG3x868ftGBwF3Sx0onSUF7y0rst5GVmk=;
        b=E0N69jgt6Oeyd/fRPztBmnOkvJfRQ4j1rLie34AhYT+9zv0oG7hHesgZr/qidezm8W
         pkOa9kswFfaWGO+DWRuH1dpi+vY+/X+1790BMN4ljnERX+8eeGuR7RmIq4FXhljlKx73
         oma//IOhIs+JIIG86/AWPIkyRYdZyHuDaLKPAAmTC0CDdKYRgTpIh9lo61HDwCanaxZR
         1qQ/tXuMeP+pLTDNp+a5Cfqmw+lFS985PNJAFSpsq1WJx7Wbja/yVs2QNC0kBkM8IJIK
         eGU9PWB4LrlCRxY9Jc4cIqazJl7CDZoc+ZxGOIgGyfBohQDlRE7WasexNGie/UzWluXL
         C8Uw==
X-Gm-Message-State: ABy/qLbPqtwZzqyfE/+e+UlMF9fwv4o8zJbo6BShukh8MzLp4tRCuIuT
        V5l+5kiPN7FJd6fahI3X0Pr8Wg==
X-Google-Smtp-Source: APBJJlGh1bf6Dlfv7+5YmGoZEQ4uJLOFRiB2sN966EQGlCJm5PJge2ZAOxwnqk841iFClcvOwuTwDQ==
X-Received: by 2002:a2e:8085:0:b0:2b6:e283:32cb with SMTP id i5-20020a2e8085000000b002b6e28332cbmr12705279ljg.23.1689077935036;
        Tue, 11 Jul 2023 05:18:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:20 +0200
Subject: [PATCH 21/53] interconnect: qcom: sm6350: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-21-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=8416;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SrAfEu7z7LDi+swPnqPTMHcA8pMC5/hLxqI6ZqZhaf0=;
 b=7WlneqnlYUMwfgEWnegCIMJfixgMc1PsRYVSsNGX2DEtr9WcXugI3RsfzMQZKXEXxhT053I17
 5WznrJl7egfC0ejss8NmYrjEn1JX6/Cc84u1ixD848BDyOfR/6GCl1m
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6350.c | 276 +++++++++++++++++++++++++++++++++----
 1 file changed, 251 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 7421eb4cd520..845d888f7634 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1161,31 +1161,257 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg, &qhs_camera_nrt_thrott_cfg, &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &qhs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_display_throttle_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg, &qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1, &qhs_security, &qhs_snoc_cfg, &qhs_tcsr, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_venus_cfg, &qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc);
-DEFINE_QBCM(bcm_cn1, "CN1", false, &xm_emmc, &xm_sdc2, &qhs_ahb2phy2, &qhs_emmc_cfg, &qhs_pdm, &qhs_sdc2);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_gemnoc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_npu_dsp);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_icp_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf, &qxm_mdp0);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_gemnoc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 41,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_aoss,
+		   &qhs_boot_rom,
+		   &qhs_camera_cfg,
+		   &qhs_camera_nrt_thrott_cfg,
+		   &qhs_camera_rt_throttle_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_display_throttle_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_mss_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qm_cfg,
+		   &qhs_qm_mpu_cfg,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_security,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_venus_cfg,
+		   &qhs_venus_throttle_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 6,
+	.nodes = { &xm_emmc,
+		   &xm_sdc2,
+		   &qhs_ahb2phy2,
+		   &qhs_emmc_cfg,
+		   &qhs_pdm,
+		   &qhs_sdc2
+	},
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_co2 = {
+	.name = "CO2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_co3 = {
+	.name = "CO3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxm_npu_dsp },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 5,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_icp_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf,
+		   &qxm_mdp0
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 4,
+	.nodes = { &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 4,
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.voter_idx = ICC_BCM_VOTER_APPS,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_cn1,

-- 
2.41.0

