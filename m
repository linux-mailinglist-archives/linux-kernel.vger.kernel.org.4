Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84736DCC25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDJU3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDJU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:29:33 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2719171C;
        Mon, 10 Apr 2023 13:29:31 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D964B3FA41;
        Mon, 10 Apr 2023 22:29:27 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/5] ARM: dts: qcom: Use labels with generic node names for ADC channels
Date:   Mon, 10 Apr 2023 22:29:13 +0200
Message-Id: <20230410202917.247666-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410202917.247666-1-marijn.suijten@somainline.org>
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future bindings update will replace the free-form qcom,spmi-vadc and
qcom,spmi-adc5 channel node names with the specific name `channel`, to
be more consistent with how the driver parses the nodes and to match the
generic node name set in `iio/adc/adc.yaml`.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi  | 12 ++++++------
 arch/arm/boot/dts/qcom-pm8941.dtsi  | 14 +++++++-------
 arch/arm/boot/dts/qcom-pma8084.dtsi | 12 ++++++------
 arch/arm/boot/dts/qcom-pmx55.dtsi   |  8 ++++----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 46ba84f86c9f..bcd689a9b2d1 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -63,27 +63,27 @@ pm8226_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@7 {
+			channel@7 {
 				reg = <VADC_VSYS>;
 				qcom,pre-scaling = <1 3>;
 				label = "vph_pwr";
 			};
-			adc-chan@8 {
+			channel@8 {
 				reg = <VADC_DIE_TEMP>;
 				label = "die_temp";
 			};
-			adc-chan@9 {
+			channel@9 {
 				reg = <VADC_REF_625MV>;
 				label = "ref_625mv";
 			};
-			adc-chan@a {
+			channel@a {
 				reg = <VADC_REF_1250MV>;
 				label = "ref_1250mv";
 			};
-			adc-chan@e {
+			channel@e {
 				reg = <VADC_GND_REF>;
 			};
-			adc-chan@f {
+			channel@f {
 				reg = <VADC_VDD_VADC>;
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index a821f0368a28..a35300ed1197 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -102,31 +102,31 @@ pm8941_vadc: adc@3100 {
 			#io-channel-cells = <1>;
 
 
-			adc-chan@6 {
+			channel@6 {
 				reg = <VADC_VBAT_SNS>;
 			};
 
-			adc-chan@8 {
+			channel@8 {
 				reg = <VADC_DIE_TEMP>;
 			};
 
-			adc-chan@9 {
+			channel@9 {
 				reg = <VADC_REF_625MV>;
 			};
 
-			adc-chan@a {
+			channel@a {
 				reg = <VADC_REF_1250MV>;
 			};
 
-			adc-chan@e {
+			channel@e {
 				reg = <VADC_GND_REF>;
 			};
 
-			adc-chan@f {
+			channel@f {
 				reg = <VADC_VDD_VADC>;
 			};
 
-			adc-chan@30 {
+			channel@30 {
 				reg = <VADC_LR_MUX1_BAT_THERM>;
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index 2dd4c6aa71c9..2985f4805b93 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -64,27 +64,27 @@ pma8084_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@8 {
+			channel@8 {
 				reg = <VADC_DIE_TEMP>;
 			};
 
-			adc-chan@9 {
+			channel@9 {
 				reg = <VADC_REF_625MV>;
 			};
 
-			adc-chan@a {
+			channel@a {
 				reg = <VADC_REF_1250MV>;
 			};
 
-			adc-chan@c {
+			channel@c {
 				reg = <VADC_SPARE1>;
 			};
 
-			adc-chan@e {
+			channel@e {
 				reg = <VADC_GND_REF>;
 			};
 
-			adc-chan@f {
+			channel@f {
 				reg = <VADC_VDD_VADC>;
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom-pmx55.dtsi
index e1b869480bbd..da0851173c69 100644
--- a/arch/arm/boot/dts/qcom-pmx55.dtsi
+++ b/arch/arm/boot/dts/qcom-pmx55.dtsi
@@ -40,25 +40,25 @@ pmx55_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x8 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			ref-gnd@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
 			};
 
-			chg-temp@9 {
+			channel@9 {
 				reg = <ADC5_CHG_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "chg_temp";
-- 
2.40.0

