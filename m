Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8F5BF26E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIUArx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiIUArt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:47:49 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2179A78
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:47:48 -0700 (PDT)
Received: from localhost.localdomain (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 186683F218;
        Wed, 21 Sep 2022 02:47:46 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998-yoshino: Fix up SMD regulators formatting
Date:   Wed, 21 Sep 2022 02:47:41 +0200
Message-Id: <20220921004741.152765-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line between each subnode and make the { } consistent.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index d08639082247..862d859af885 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -410,131 +410,162 @@ vreg_s3a_1p35: s3 {
 			regulator-min-microvolt = <1352000>;
 			regulator-max-microvolt = <1352000>;
 		};
+
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-system-load = <100000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
 			regulator-max-microvolt = <2032000>;
 		};
+
 		vreg_s7a_1p025: s7 {
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1028000>;
 		};
+
 		vreg_l1a_0p875: l1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
 			regulator-system-load = <73400>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l2a_1p2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-system-load = <12560>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l3a_1p0: l3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l5a_0p8: l5 {
 			regulator-min-microvolt = <800000>;
 			regulator-max-microvolt = <800000>;
 		};
+
 		vreg_l6a_1p8: l6 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l7a_1p8: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l8a_1p2: l8 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 		};
+
 		vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l10a_1p8: l10 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 		};
+
 		vreg_l11a_1p0: l11 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 		};
+
 		vreg_l12a_1p8: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l13a_2p95: l13 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l14a_1p85: l14 {
 			regulator-min-microvolt = <1848000>;
 			regulator-max-microvolt = <1856000>;
 			regulator-system-load = <32000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l15a_1p8: l15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
+
 		vreg_l16a_2p7: l16 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l17a_1p3: l17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
 		};
-		vreg_l18a_2p85: l18 {};
+
+		vreg_l18a_2p85: l18 { };
+
 		vreg_l19a_2p7: l19 {
 			regulator-min-microvolt = <2696000>;
 			regulator-max-microvolt = <2704000>;
 		};
+
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
 			regulator-system-load = <10000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
 			regulator-system-load = <800000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l22a_2p85: l22 { };
+
 		vreg_l23a_3p3: l23 {
 			regulator-min-microvolt = <3312000>;
 			regulator-max-microvolt = <3312000>;
 		};
+
 		vreg_l24a_3p075: l24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
 		};
+
 		vreg_l25a_3p3: l25 {
 			regulator-min-microvolt = <3104000>;
 			regulator-max-microvolt = <3312000>;
 		};
+
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-allow-set-load;
 		};
+
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 		};
+
 		vreg_lvs1a_1p8: lvs1 { };
+
 		vreg_lvs2a_1p8: lvs2 { };
 	};
 
-- 
2.37.3

