Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823916128CD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJ3HdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJ3Hcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:32:52 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49360C9;
        Sun, 30 Oct 2022 00:32:47 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AF7A4200B9;
        Sun, 30 Oct 2022 08:32:45 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] arm64: dts: qcom: sm6350-lena: Define pm6350 and pm6150l regulators
Date:   Sun, 30 Oct 2022 08:32:28 +0100
Message-Id: <20221030073232.22726-7-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030073232.22726-1-marijn.suijten@somainline.org>
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This regulator configuration was adopted from downstream, and is
identical to the sm7225 FairPhone 4 configuration bar pm6350_l8a.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../qcom/sm6350-sony-xperia-lena-pdx213.dts   | 218 ++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 4512b0bf7fe1..1aaa9612b061 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm6350.dtsi"
 #include "pm6350.dtsi"
 
@@ -44,6 +45,223 @@ key-volume-down {
 	};
 };
 
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm6350-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		pm6350_s1: smps1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_s2: smps2 {
+			regulator-min-microvolt = <1503000>;
+			regulator-max-microvolt = <2048000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l2: ldo2 {
+			regulator-min-microvolt = <1503000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l3: ldo3 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l4: ldo4 {
+			regulator-min-microvolt = <352000>;
+			regulator-max-microvolt = <801000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l5: ldo5 {
+			regulator-min-microvolt = <1503000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l6: ldo6 {
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l7: ldo7 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l8: ldo8 {
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l9: ldo9 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3401000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l11: ldo11 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l12: ldo12 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l13: ldo13 {
+			regulator-min-microvolt = <570000>;
+			regulator-max-microvolt = <650000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l14: ldo14 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l15: ldo15 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1305000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l16: ldo16 {
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <921000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l18: ldo18 {
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1049000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l19: ldo19 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1305000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l20: ldo20 {
+			regulator-min-microvolt = <530000>;
+			regulator-max-microvolt = <801000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l21: ldo21 {
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <825000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6350_l22: ldo22 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1305000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm6150l-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		pm6150l_s8: smps8 {
+			regulator-min-microvolt = <313000>;
+			regulator-max-microvolt = <1395000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l1: ldo1 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l2: ldo2 {
+			regulator-min-microvolt = <1170000>;
+			regulator-max-microvolt = <1305000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l3: ldo3 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1299000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l4: ldo4 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l5: ldo5 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l6: ldo6 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l7: ldo7 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l8: ldo8 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l9: ldo9 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l10: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3401000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_l11: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3401000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm6150l_bob: bob {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <5492000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+	};
+};
+
 &pm6350_gpios {
 	gpio_keys_state: gpio-keys-state {
 		key-volume-down-pins {
-- 
2.38.1

