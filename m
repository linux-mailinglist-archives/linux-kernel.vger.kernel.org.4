Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B796310D1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiKSUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiKSUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:39:17 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FA1A802;
        Sat, 19 Nov 2022 12:39:13 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DB007D05D9;
        Sat, 19 Nov 2022 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668890322; bh=ALq0hhxNOQbLR71kbPD3QDnev8mXmvLWMQRmKtUJtuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k5Nt5MWLCLhPHkqZBdIdkFzu/B7brovegZqehpQcY6LN2T48ff/ex/f2o5Y9QvH5m
         yxrsuJ2X/WSs/ubitql5nCmYxYADh8NZaVBxNVbTslVpEC5//hnwetEjAciTOLeXXm
         8vk3IfPIlRS60dQmOD5ZwkpEDTWiqIwDPfmcDrgM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] arm64: dts: qcom: msm8953: Adjust reserved-memory nodes
Date:   Sat, 19 Nov 2022 21:37:43 +0100
Message-Id: <20221119203758.888207-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119203758.888207-1-luca@z3ntu.xyz>
References: <20221119203758.888207-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust node names so they're not just memory@ but actually show what
they're used for. Also add labels to most nodes so we can easily
reference them from devices.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* new patch

 arch/arm64/boot/dts/qcom/msm8953.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 32349174c4bd..62d2ae30711b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -245,18 +245,18 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		zap_shader_region: memory@81800000 {
+		zap_shader_region: zap@81800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x0 0x81800000 0x0 0x2000>;
 			no-map;
 		};
 
-		memory@85b00000 {
+		qseecom_mem: qseecom@85b00000 {
 			reg = <0x0 0x85b00000 0x0 0x800000>;
 			no-map;
 		};
 
-		smem_mem: memory@86300000 {
+		smem_mem: smem@86300000 {
 			compatible = "qcom,smem";
 			reg = <0x0 0x86300000 0x0 0x100000>;
 			qcom,rpm-msg-ram = <&rpm_msg_ram>;
@@ -264,47 +264,47 @@ smem_mem: memory@86300000 {
 			no-map;
 		};
 
-		memory@86400000 {
+		reserved@86400000 {
 			reg = <0x0 0x86400000 0x0 0x400000>;
 			no-map;
 		};
 
-		mpss_mem: memory@86c00000 {
+		mpss_mem: mpss@86c00000 {
 			reg = <0x0 0x86c00000 0x0 0x6a00000>;
 			no-map;
 		};
 
-		adsp_fw_mem: memory@8d600000 {
+		adsp_fw_mem: adsp@8d600000 {
 			reg = <0x0 0x8d600000 0x0 0x1100000>;
 			no-map;
 		};
 
-		wcnss_fw_mem: memory@8e700000 {
+		wcnss_fw_mem: wcnss@8e700000 {
 			reg = <0x0 0x8e700000 0x0 0x700000>;
 			no-map;
 		};
 
-		memory@90000000 {
+		dfps_data_mem: dfps-data@90000000 {
 			reg = <0 0x90000000 0 0x1000>;
 			no-map;
 		};
 
-		memory@90001000 {
+		cont_splash_mem: cont-splash@90001000 {
 			reg = <0x0 0x90001000 0x0 0x13ff000>;
 			no-map;
 		};
 
-		venus_mem: memory@91400000 {
+		venus_mem: venus@91400000 {
 			reg = <0x0 0x91400000 0x0 0x700000>;
 			no-map;
 		};
 
-		mba_mem: memory@92000000 {
+		mba_mem: mba@92000000 {
 			reg = <0x0 0x92000000 0x0 0x100000>;
 			no-map;
 		};
 
-		memory@f2d00000 {
+		rmtfs@f2d00000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf2d00000 0x0 0x180000>;
 			no-map;
-- 
2.38.1

