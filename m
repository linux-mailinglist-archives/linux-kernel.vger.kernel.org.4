Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D46DCC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjDJU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDJU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:29:36 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998561989;
        Mon, 10 Apr 2023 13:29:32 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 749AB3FA97;
        Mon, 10 Apr 2023 22:29:30 +0200 (CEST)
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
Subject: [PATCH v4 2/5] arm64: dts: qcom: Use labels with generic node names for ADC channels
Date:   Mon, 10 Apr 2023 22:29:14 +0200
Message-Id: <20230410202917.247666-3-marijn.suijten@somainline.org>
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

As discussed in [1] it is more convenient to use a generic `channel`
node name for ADC channels while storing a friendly - board-specific
instead of PMIC-specific - name in the label, if/when desired to
overwrite the channel description already contained (but previously
unused) in the driver [2].  Follow up on the dt-bindings' `channel` node
name requirement, and instead provide this (sometimes per-board) channel
description through a label property.

Also remove all the unused label references (not to be confused with
label properties) from pm660, pmp8074 and pms405.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 18 ++++++---
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |  8 ++--
 arch/arm64/boot/dts/qcom/pm660.dtsi           | 33 ++++++++++------
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         | 24 ++++++------
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |  6 +--
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  8 ++--
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  6 +--
 arch/arm64/boot/dts/qcom/pm8916.dtsi          | 14 +++----
 arch/arm64/boot/dts/qcom/pm8950.dtsi          | 39 ++++++++++++-------
 arch/arm64/boot/dts/qcom/pm8953.dtsi          | 12 +++---
 arch/arm64/boot/dts/qcom/pm8994.dtsi          | 12 +++---
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         | 12 +++---
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  6 +--
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         | 27 ++++++++-----
 arch/arm64/boot/dts/qcom/pms405.dtsi          | 21 ++++++----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 15 ++++---
 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  3 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  2 +-
 .../dts/qcom/sc7180-trogdor-pompom-r2.dts     |  2 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  3 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  3 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  4 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 26 ++++++-------
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 10 ++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 12 +++---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 ++++---
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  6 +--
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       | 21 ++++++----
 37 files changed, 231 insertions(+), 163 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 59092a551a16..99369a0cdb61 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -85,36 +85,42 @@ pm6125_adc: adc@3100 {
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#io-channel-cells = <1>;
 
-			ref-gnd@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			die-temp@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			vph-pwr@83 {
+			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			vcoin@85 {
+			channel@85 {
 				reg = <ADC5_VCOIN>;
 				qcom,pre-scaling = <1 3>;
+				label = "vcoin";
 			};
 
-			xo-therm@4c {
+			channel@4c {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "xo_therm";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 2e6afa296141..7d4d1f2767ed 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -72,7 +72,7 @@ pm6150_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				label = "die_temp";
 			};
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 6f7aa67501e2..6a7fe1e59f15 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -60,25 +60,25 @@ pm6150l_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			adc-chan@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			adc-chan@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
 			};
 
-			adc-chan@83 {
+			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
 				label = "vph_pwr";
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 4bc717917f44..98dc04962fe3 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -91,82 +91,93 @@ pm660_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			ref_gnd: ref_gnd@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref_1p25: vref_1p25@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			die_temp: die_temp@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			xo_therm: xo_therm@4c {
+			channel@4c {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "xo_therm";
 			};
 
-			msm_therm: msm_therm@4d {
+			channel@4d {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "msm_therm";
 			};
 
-			emmc_therm: emmc_therm@4e {
+			channel@4e {
 				reg = <ADC5_AMUX_THM2_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "emmc_therm";
 			};
 
-			pa_therm0: thermistor0@4f {
+			channel@4f {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "pa_therm0";
 			};
 
-			pa_therm1: thermistor1@50 {
+			channel@50 {
 				reg = <ADC5_AMUX_THM4_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "pa_therm1";
 			};
 
-			quiet_therm: quiet_therm@51 {
+			channel@51 {
 				reg = <ADC5_AMUX_THM5_100K_PU>;
 				qcom,pre-scaling = <1 1>;
 				qcom,decimation = <1024>;
 				qcom,hw-settle-time = <200>;
 				qcom,ratiometric;
+				label = "quiet_therm";
 			};
 
-			vadc_vph_pwr: vph_pwr@83 {
+			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			vcoin: vcoin@85 {
+			channel@85 {
 				reg = <ADC5_VCOIN>;
 				qcom,decimation = <1024>;
 				qcom,pre-scaling = <1 3>;
+				label = "vcoin";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index d709d955a2f5..be86b892a570 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -61,56 +61,56 @@ pm7250b_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
-			adc-chan@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_gnd";
 			};
 
-			adc-chan@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
 				label = "vref_1p25";
 			};
 
-			adc-chan@2 {
+			channel@2 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
 			};
 
-			adc-chan@7 {
+			channel@7 {
 				reg = <ADC5_USB_IN_I>;
 				qcom,pre-scaling = <1 1>;
 				label = "usb_in_i_uv";
 			};
 
-			adc-chan@8 {
+			channel@8 {
 				reg = <ADC5_USB_IN_V_16>;
 				qcom,pre-scaling = <1 16>;
 				label = "usb_in_v_div_16";
 			};
 
-			adc-chan@9 {
+			channel@9 {
 				reg = <ADC5_CHG_TEMP>;
 				qcom,pre-scaling = <1 1>;
 				label = "chg_temp";
 			};
 
-			adc-chan@e {
+			channel@e {
 				reg = <ADC5_AMUX_THM2>;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
 				label = "smb1390_therm";
 			};
 
-			adc-chan@1e {
+			channel@1e {
 				reg = <ADC5_MID_CHG_DIV6>;
 				qcom,pre-scaling = <1 6>;
 				label = "chg_mid";
 			};
 
-			adc-chan@4b {
+			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
@@ -118,19 +118,19 @@ adc-chan@4b {
 				label = "bat_id";
 			};
 
-			adc-chan@83 {
+			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
 				label = "vph_pwr";
 			};
 
-			adc-chan@84 {
+			channel@84 {
 				reg = <ADC5_VBAT_SNS>;
 				qcom,pre-scaling = <1 3>;
 				label = "vbat_sns";
 			};
 
-			adc-chan@99 {
+			channel@99 {
 				reg = <ADC5_SBUx>;
 				qcom,pre-scaling = <1 3>;
 				label = "chg_sbux";
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index db90c55fa2cf..3ba3ba5d8fce 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -90,19 +90,19 @@ pm8150_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 66752cc063d6..2b9123df5847 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -76,25 +76,25 @@ pm8150b_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index cca45fad75ac..b1686e5777b8 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -70,19 +70,19 @@ pm8150l_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index e2a6b66d8847..667e23683065 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -66,27 +66,27 @@ pm8916_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@0 {
+			channel@0 {
 				reg = <VADC_USBIN>;
 				qcom,pre-scaling = <1 10>;
 			};
-			adc-chan@7 {
+			channel@7 {
 				reg = <VADC_VSYS>;
 				qcom,pre-scaling = <1 3>;
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
 		};
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index 5ec38b7e335a..f03095779de0 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -50,77 +50,90 @@ pm8950_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			vcoin@5 {
+			channel@5 {
 				reg = <VADC_VCOIN>;
 				qcom,pre-scaling = <1 1>;
+				label = "vcoin";
 			};
 
-			vph-pwr@7 {
+			channel@7 {
 				reg = <VADC_VSYS>;
 				qcom,pre-scaling = <1 1>;
+				label = "vph_pwr";
 			};
 
-			die-temp@8 {
+			channel@8 {
 				reg = <VADC_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			ref-625mv@9 {
+			channel@9 {
 				reg = <VADC_REF_625MV>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_625mv";
 			};
 
-			ref-1250mv@a {
+			channel@a {
 				reg = <VADC_REF_1250MV>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_1250mv";
 			};
 
-			ref-buf-625mv@c {
+			channel@c {
 				reg = <VADC_SPARE1>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_buf_625mv";
 			};
 
-			ref-gnd@e {
+			channel@e {
 				reg = <VADC_GND_REF>;
+				label = "ref_gnd";
 			};
 
-			ref-vdd@f {
+			channel@f {
 				reg = <VADC_VDD_VADC>;
+				label = "ref_vdd";
 			};
 
-			pa-therm1@11 {
+			channel@11 {
 				reg = <VADC_P_MUX2_1_1>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "pa_therm1";
 			};
 
-			case-therm@13 {
+			channel@13 {
 				reg = <VADC_P_MUX4_1_1>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "case_therm";
 			};
 
-			xo-therm@32 {
+			channel@32 {
 				reg = <VADC_LR_MUX3_XO_THERM>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "xo_therm";
 			};
 
-			pa-therm0@36 {
+			channel@36 {
 				reg = <VADC_LR_MUX7_HW_ID>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "pa_therm0";
 			};
 
-			xo-therm-buf@3c {
+			channel@3c {
 				reg = <VADC_LR_MUX3_BUF_XO_THERM>;
 				qcom,pre-scaling = <1 1>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
+				label = "xo_therm_buf";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index a1d36f9ebbd2..ad94d63dfe1c 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -53,22 +53,22 @@ pm8953_vadc: adc@3100 {
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
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 672094c8ca58..d44a95caf04a 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -83,27 +83,27 @@ pm8994_vadc: adc@3100 {
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
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 340033ac3186..ce7dfda410eb 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -86,7 +86,7 @@ pm8998_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				label = "die_temp";
 			};
diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 4891be3cd68a..c09a9681bc0c 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -20,37 +20,37 @@ pmi8950_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@0 {
+			channel@0 {
 				reg = <VADC_USBIN>;
 				qcom,pre-scaling = <1 4>;
 				label = "usbin";
 			};
 
-			adc-chan@1 {
+			channel@1 {
 				reg = <VADC_DCIN>;
 				qcom,pre-scaling = <1 4>;
 				label = "dcin";
 			};
 
-			adc-chan@2 {
+			channel@2 {
 				reg = <VADC_VCHG_SNS>;
 				qcom,pre-scaling = <1 1>;
 				label = "vchg_sns";
 			};
 
-			adc-chan@9 {
+			channel@9 {
 				reg = <VADC_REF_625MV>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_625mv";
 			};
 
-			adc-chan@a {
+			channel@a {
 				reg = <VADC_REF_1250MV>;
 				qcom,pre-scaling = <1 1>;
 				label = "ref_1250mv";
 			};
 
-			adc-chan@d {
+			channel@d {
 				reg = <VADC_SPARE2>;
 				qcom,pre-scaling = <1 1>;
 				label = "chg_temp";
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index ee1e428d3a6e..dbd4b91dfe06 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -77,19 +77,19 @@ pmm8155au_1_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
index 1da4606e8ee6..1cee20ac2c9c 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -69,19 +69,19 @@ pmm8155au_2_adc: adc@3100 {
 			#io-channel-cells = <1>;
 			interrupts = <0x4 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 580684411d74..0d0a846ac8d9 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -18,57 +18,66 @@ pmp8074_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			ref-gnd@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref-1p25@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			vref-vadc@2 {
+			channel@2 {
 				reg = <ADC5_VREF_VADC>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_vadc";
 			};
 
-			pmic_die: die-temp@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "pmic_die";
 			};
 
-			xo_therm: xo-temp@76 {
+			channel@76 {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "xo_therm";
 			};
 
-			pa_therm1: thermistor1@77 {
+			channel@77 {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm1";
 			};
 
-			pa_therm2: thermistor2@78 {
+			channel@78 {
 				reg = <ADC5_AMUX_THM2_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm2";
 			};
 
-			pa_therm3: thermistor3@79 {
+			channel@79 {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm3";
 			};
 
-			vph-pwr@131 {
+			channel@131 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 22edb47c6a84..461ad97032f7 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -81,45 +81,52 @@ pms405_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			ref_gnd@0 {
+			channel@0 {
 				reg = <ADC5_REF_GND>;
 				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
 			};
 
-			vref_1p25@1 {
+			channel@1 {
 				reg = <ADC5_1P25VREF>;
 				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
 			};
 
-			pon_1: vph_pwr@131 {
+			channel@131 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
 			};
 
-			die_temp@6 {
+			channel@6 {
 				reg = <ADC5_DIE_TEMP>;
 				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
 			};
 
-			pa_therm1: thermistor1@77 {
+			channel@77 {
 				reg = <ADC5_AMUX_THM1_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm1";
 			};
 
-			pa_therm3: thermistor3@79 {
+			channel@79 {
 				reg = <ADC5_AMUX_THM3_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "pa_therm3";
 			};
 
-			xo_therm: xo_temp@76 {
+			channel@76 {
 				reg = <ADC5_XO_THERM_100K_PU>;
 				qcom,ratiometric;
 				qcom,hw-settle-time = <200>;
 				qcom,pre-scaling = <1 1>;
+				label = "xo_therm";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index dd924331b0ee..4a9e840fd3d3 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -644,16 +644,18 @@ &mdss_mdp {
 };
 
 &pm8150_adc {
-	xo-therm@4c {
+	channel@4c {
 		reg = <ADC5_XO_THERM_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "xo_therm";
 	};
 
-	wifi-therm@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "wifi_therm";
 	};
 };
 
@@ -721,10 +723,11 @@ &pm8150_gpios {
 };
 
 &pm8150b_adc {
-	conn-therm@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "conn_therm";
 	};
 };
 
@@ -756,16 +759,18 @@ &pm8150b_gpios {
 };
 
 &pm8150l_adc {
-	skin-msm-therm@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_msm_therm";
 	};
 
-	pm8150l-therm@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pm8150l_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
index edfcd47e1a00..03d350dcec96 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
@@ -24,8 +24,8 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ skin-temp-thermistor@4e;
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ channel@4e;
+	/delete-node/ channel@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 8b8ea8af165d..a532cc4aac47 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -119,10 +119,11 @@ &panel {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index b3ba23a88a0b..b27dcd2ec856 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -145,10 +145,11 @@ &panel {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 269007d73162..13339b723a93 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -55,7 +55,7 @@ &panel {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ channel@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
index 8467ff41e6d5..ba222a60c4c6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
@@ -27,7 +27,7 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ channel@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
index 88cf2246c18a..64d6172bf402 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts
@@ -24,7 +24,7 @@ &charger_thermal {
 };
 
 &pm6150_adc {
-	/delete-node/ charger-thermistor@4f;
+	/delete-node/ channel@4f;
 };
 
 &pm6150_adc_tm {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 6c5287bd27d6..fd944842dd6c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -148,10 +148,11 @@ &pen_insert {
 };
 
 &pm6150_adc {
-	5v-choke-thermistor@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "5v_choke_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 262d6691abd9..4c11fc732199 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -163,10 +163,11 @@ ap_ts: touchscreen@1 {
 };
 
 &pm6150_adc {
-	skin-temp-thermistor@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 423630c4d02c..3ab216a64c11 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -830,10 +830,11 @@ &mdss_dp_out {
 };
 
 &pm6150_adc {
-	charger-thermistor@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "charger_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 15222e92e3f5..b5fe7356be48 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -73,7 +73,7 @@ &nvme_3v3_regulator {
 };
 
 &pmk8350_vadc {
-	pmr735a-die-temp@403 {
+	channel@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 5dc9bee28e7f..4a416703940c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -432,7 +432,7 @@ &pcie1_phy {
 };
 
 &pmk8350_vadc {
-	pmk8350-die-temp@3 {
+	channel@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 88b3586e389f..d208a53a6890 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -383,13 +383,13 @@ &pm8350c_pwm {
 };
 
 &pmk8350_vadc {
-	pmk8350-die-temp@3 {
+	channel@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
 
-	pmr735a-die-temp@403 {
+	channel@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index a1db3cf80c47..8099c3296a01 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -822,88 +822,88 @@ rtc_offset: rtc-offset@bc {
 &pmk8280_vadc {
 	status = "okay";
 
-	pmic-die-temp@3 {
+	channel@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmk8350_die_temp";
 	};
 
-	xo-therm@44 {
+	channel@44 {
 		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "pmk8350_xo_therm";
 	};
 
-	pmic-die-temp@103 {
+	channel@103 {
 		reg = <PM8350_ADC7_DIE_TEMP(1)>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmc8280_1_die_temp";
 	};
 
-	sys-therm@144 {
+	channel@144 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm1";
 	};
 
-	sys-therm@145 {
+	channel@145 {
 		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm2";
 	};
 
-	sys-therm@146 {
+	channel@146 {
 		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm3";
 	};
 
-	sys-therm@147 {
+	channel@147 {
 		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm4";
 	};
 
-	pmic-die-temp@303 {
+	channel@303 {
 		reg = <PM8350_ADC7_DIE_TEMP(3)>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmc8280_2_die_temp";
 	};
 
-	sys-therm@344 {
+	channel@344 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm5";
 	};
 
-	sys-therm@345 {
+	channel@345 {
 		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm6";
 	};
 
-	sys-therm@346 {
+	channel@346 {
 		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm7";
 	};
 
-	sys-therm@347 {
+	channel@347 {
 		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "sys_therm8";
 	};
 
-	pmic-die-temp@403 {
+	channel@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmr735a_die_temp";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 59ad6a8403d2..2e9e915a2d8e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -1067,27 +1067,27 @@ &pm8005_gpios {
 };
 
 &pm8998_adc {
-	adc-chan@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		label = "sdm_temp";
 	};
 
-	adc-chan@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		label = "quiet_temp";
 	};
 
-	adc-chan@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		label = "lte_temp_1";
 	};
 
-	adc-chan@50 {
+	channel@50 {
 		reg = <ADC5_AMUX_THM4_100K_PU>;
 		label = "lte_temp_2";
 	};
 
-	adc-chan@51 {
+	channel@51 {
 		reg = <ADC5_AMUX_THM5_100K_PU>;
 		label = "charger_temp";
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index d1440b790fa6..045fcd52397e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -533,42 +533,42 @@ &mss_pil {
 };
 
 &pm8998_adc {
-	adc-chan@4c {
+	channel@4c {
 		reg = <ADC5_XO_THERM_100K_PU>;
 		label = "xo_therm";
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
 
-	adc-chan@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		label = "msm_therm";
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
 
-	adc-chan@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		label = "pa_therm1";
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
 
-	adc-chan@51 {
+	channel@51 {
 		reg = <ADC5_AMUX_THM5_100K_PU>;
 		label = "quiet_therm";
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
 
-	adc-chan@83 {
+	channel@83 {
 		reg = <ADC5_VPH_PWR>;
 		label = "vph_pwr";
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 	};
 
-	adc-chan@85 {
+	channel@85 {
 		reg = <ADC5_VCOIN>;
 		label = "vcoin";
 		qcom,ratiometric;
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 5b26389b8e72..515b5b02342e 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -242,39 +242,44 @@ &pm6125_adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
 
-	rf-pa0-therm@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "rf_pa0_therm";
 	};
 
-	quiet-therm@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "quiet_therm";
 	};
 
-	camera-flash-therm@52 {
+	channel@52 {
 		reg = <ADC5_GPIO1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "camera_flash_therm";
 	};
 
-	emmc-ufs-therm@54 {
+	channel@54 {
 		reg = <ADC5_GPIO3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "emmc_ufs_therm";
 	};
 
-	rf-pa1-therm@55 {
+	channel@55 {
 		reg = <ADC5_GPIO4_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
+		label = "rf_pa1_therm";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 7ae6aba5d2ec..e1d612a4a2d5 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -475,7 +475,7 @@ &pm6350_resin {
 };
 
 &pm7250b_adc {
-	adc-chan@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
@@ -483,7 +483,7 @@ adc-chan@4d {
 		label = "charger_skin_therm";
 	};
 
-	adc-chan@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
@@ -515,7 +515,7 @@ &pmk8350_rtc {
 };
 
 &pmk8350_vadc {
-	adc-chan@644 {
+	channel@644 {
 		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 4c9de236676d..1efefb49107a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -525,22 +525,25 @@ &i2c15 {
 };
 
 &pm8150_adc {
-	xo-therm@4c {
+	channel@4c {
 		reg = <ADC5_XO_THERM_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "xo_therm";
 	};
 
-	skin-therm@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_therm";
 	};
 
-	pa-therm1@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pa_therm1";
 	};
 };
 
@@ -570,10 +573,11 @@ pa-therm1@2 {
 };
 
 &pm8150b_adc {
-	conn-therm@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "conn_therm";
 	};
 };
 
@@ -614,22 +618,25 @@ pa-therm2@2 {
 };
 
 &pm8150l_adc {
-	camera-flash-therm@4d {
+	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "camera_flash_therm";
 	};
 
-	skin-msm-therm@4e {
+	channel@4e {
 		reg = <ADC5_AMUX_THM2_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "skin_msm_therm";
 	};
 
-	pa-therm2@4f {
+	channel@4f {
 		reg = <ADC5_AMUX_THM3_100K_PU>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
+		label = "pa_therm2";
 	};
 };
 
-- 
2.40.0

