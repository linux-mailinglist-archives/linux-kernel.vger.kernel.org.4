Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76C740418
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjF0Ts2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Ts0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:48:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7272117;
        Tue, 27 Jun 2023 12:48:25 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AF2E0CEF9D;
        Tue, 27 Jun 2023 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687895303; bh=1AST4vmGqyyopRw6fBbBcWsj4mGraI5Kmepr9XtYR34=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Xl2w2IQCXE3n2+E7jNfwwpcMalxBPB2ETIL9kqaJq9Xau2/77piaYPNfXmblt4Ghu
         omsseP2hj0PSQ0MoRUvEgKfyIYYS/PWHFMrJOdbUFdgWM6N6hJ54sLtxStQnaiae4P
         M9zcXYrmhQ15RT/u8gRXoBByelnwegKYAJ7xDyFM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 27 Jun 2023 21:45:13 +0200
Subject: [PATCH 1/2] ARM: dts: qcom: msm8974: replace incorrect indentation
 in interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-msm8974-sort-v1-1-75c5800a2e09@z3ntu.xyz>
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
In-Reply-To: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=1AST4vmGqyyopRw6fBbBcWsj4mGraI5Kmepr9XtYR34=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkmz0FKLpt4w2A7o84Wh00hpYk1v8DNlfzVBQgZ
 dcjfnMkhpKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZJs9BQAKCRBy2EO4nU3X
 Vg6HEACsSA5saxlRVR/qaSzvsjBGkbdscH54SGld5lsyA2aSG/qYC8qvlsL4U69Hc4J0vVurijX
 vKQ4/jKYXvc+vLaAryS6ShL7aEkhhDG4Lg9OE2JJNF3RNKHYJabSeRSb3x7DlvnnJrCZpZwDN+3
 5cGFrQ4TMzRzBDeQ185/VPh7OLRrv8CA2c5Y9BUe7+HuHx1jQTJicyCWqv5XEdCFLvt+FDJMnZc
 H9NNRS7evXvyEoyBc2JwQf6Gc2IUrNZH//HIXT8jNBdel9sk8A8dqGghrKHuxwa9iZ0uEofvipu
 3B7mR6f1vhCKfGZtsXOZ8C2bvIRlgVE5p5ZuvR1dxwebmz2S6sCGs5lEl4bEmZ4CiUWM3vAFxHs
 wMnUOZ52XMPrcGEksFdlokgtChdAyBa2dOzjPqI5VMbNnyEkZXU/ZrrYfezMtSrOnF6EEYTFQvL
 xStQlmwAV77vcBVbnG4NiL2dy3s9NbUJFOlje1S89lMvocUnXlyKav8EDJsNZMVPPVYSX9n+o2t
 9VgfYYVTWuadZe05ozITWa5G71Xhj0fH7K1lLn3M3Jj5DEtjUcKhdjcFTAKG8VOqwoB1/1FHVvS
 ywdZ1ShLKt3umBxzYz9a83vcdtXhawEYdh993qQOERHq0GKPRfGsQ2WsE219m7w/K1j5wTFbrgA
 5emc7nT37OWs2vQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks definition in the interconnect nodes should use tabs (+ 1
space) for indentation instead of 9 spaces. Fix that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index aeca504918a0..c6475837eda3 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1075,7 +1075,7 @@ bimc: interconnect@fc380000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-			         <&rpmcc RPM_SMD_BIMC_A_CLK>;
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		snoc: interconnect@fc460000 {
@@ -1084,7 +1084,7 @@ snoc: interconnect@fc460000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-			         <&rpmcc RPM_SMD_SNOC_A_CLK>;
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		pnoc: interconnect@fc468000 {
@@ -1093,7 +1093,7 @@ pnoc: interconnect@fc468000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
-			         <&rpmcc RPM_SMD_PNOC_A_CLK>;
+				 <&rpmcc RPM_SMD_PNOC_A_CLK>;
 		};
 
 		ocmemnoc: interconnect@fc470000 {
@@ -1102,7 +1102,7 @@ ocmemnoc: interconnect@fc470000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
-			         <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
+				 <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
 		};
 
 		mmssnoc: interconnect@fc478000 {
@@ -1111,7 +1111,7 @@ mmssnoc: interconnect@fc478000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&mmcc MMSS_S0_AXI_CLK>,
-			         <&mmcc MMSS_S0_AXI_CLK>;
+				 <&mmcc MMSS_S0_AXI_CLK>;
 		};
 
 		cnoc: interconnect@fc480000 {
@@ -1120,7 +1120,7 @@ cnoc: interconnect@fc480000 {
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a";
 			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
-			         <&rpmcc RPM_SMD_CNOC_A_CLK>;
+				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
 		};
 
 		tsens: thermal-sensor@fc4a9000 {

-- 
2.41.0

