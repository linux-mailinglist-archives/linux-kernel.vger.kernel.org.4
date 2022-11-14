Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C426282B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiKNOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiKNOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:36:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AB2A95D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:36:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so8205679ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aabCVqHE8vlQLD3w/plba7OMthFCrkAs3vhssQnEw1I=;
        b=gn5KB2YtP0pHZ7AfOAiv1WvU+fcuTrGtAVaanHlyIAPCLQ4uJsB/kuemKfVKMJgmAk
         YqSjZWsppSaqo1aWR7GOJ/YRT/VKnppZ/Ym8E0ynAec5lNYsfy8P9I8SikJ5rtEea2VX
         dSo/xrMgeOb8z1W6pteI/GppBNCCDgcdhxnQ+Z+2rkk4L4YSAaLrO4nP64iUMQG+Ar5b
         YgpIZNTZ2Pt6081jYUVy2l7tXGnfCyAu66hNDDKMx9eKnerCLW8Ik7hiqaHoFx7iy702
         tAZau0orUcOKUZ+mGfsp4EMo9shlO6ZG012dcG3KNmAT1E0QmpFHZms6MgTWGTfinMJt
         SlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aabCVqHE8vlQLD3w/plba7OMthFCrkAs3vhssQnEw1I=;
        b=tFTMikgusrXxaB0Ev9CmpED57d11AAMC3XAKSvzfyuhLFx76kzAS9HSL2vYUh4pQ6m
         B7sRa0x5pEentflc7c+H8++jLDKt0WnrLAuaaG3GfDDcO7b43JhvdJju7N/OzYDRZxPm
         TbE4zNfXe22IgyxW+8lLXmJq0AX/za6CWxrgFUNxffgOKSQ6GDMdfNvz7ayHI9RqQXXP
         bpSDMyklUbxHm+nvXNL8SCTLZDgJayAItIaPnR05QoAWUvM4Xknzd5veuIq/+eYs6f50
         3TiWqe0OjwCpkbUIzNwuJUM5rGZcG3s5BNX3UTJuEYBhxgPSsF6ApreuWpfuw7Nwjbrn
         qp0A==
X-Gm-Message-State: ANoB5plsqq8uJN7dv6vK8M6j88OUZMdNtWncu4dzVkG+Phui8AQLiKF9
        YYPN3sXpktkTUKb/8JSk9urnRw==
X-Google-Smtp-Source: AA0mqf7dT+cuiRtwP4ke7rOKp61IITmx3/m/eOrtpytnVkA5vRfryLRFesPB7advAZqDxWgBpvrB0g==
X-Received: by 2002:a17:906:ae98:b0:7ad:d7a5:6c2a with SMTP id md24-20020a170906ae9800b007add7a56c2amr10215444ejb.138.1668436608411;
        Mon, 14 Nov 2022 06:36:48 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090695cf00b0078c213ad441sm4228014ejy.101.2022.11.14.06.36.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 06:36:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8350-sagami: Add most RPMh regulators
Date:   Mon, 14 Nov 2022 15:36:41 +0100
Message-Id: <20221114143642.44839-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Configure most RPMh-controlled regulators on SoMC Sagami. The missing
ones (on pm8350b and pm8008[ij]) will be configured when driver support
is added. Thankfully, it looks like PDX215 and PDX214 don't have any
differences when it comes to PM8350/PM8350C/PMR735a.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 350 ++++++++++++++++++
 1 file changed, 350 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 93e88c40b3b9..f118caab3d42 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
  */
 
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8350.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
@@ -73,6 +74,16 @@ ramoops@ffc00000 {
 			no-map;
 		};
 	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &adsp {
@@ -80,6 +91,345 @@ &adsp {
 	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
 };
 
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+
+		vdd-l1-l4-supply = <&pm8350_s11>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_bob>;
+		vdd-l6-l9-l10-supply = <&pm8350_s11>;
+
+		/*
+		 * ARC regulators:
+		 * S5 - mx.lvl
+		 * S6 - gfx.lvl
+		 * S9 - mxc.lvl
+		 */
+
+		pm8350_s10: smps10 {
+			regulator-name = "pm8350_s10";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_s11: smps11 {
+			regulator-name = "pm8350_s11";
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_s12: smps12 {
+			regulator-name = "pm8350_s12";
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1360000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l1: ldo1 {
+			regulator-name = "pm8350_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l2: ldo2 {
+			regulator-name = "pm8350_l2";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l3: ldo3 {
+			regulator-name = "pm8350_l3";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* L4 - lmx.lvl (ARC) */
+
+		pm8350_l5: ldo5 {
+			regulator-name = "pm8350_l5";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		pm8350_l6: ldo6 {
+			regulator-name = "pm8350_l6";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		pm8350_l7: ldo7 {
+			regulator-name = "pm8350_l7";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		/* L8 - lcx.lvl (ARC) */
+
+		pm8350_l9: ldo9 {
+			regulator-name = "pm8350_l9";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l12-supply = <&pm8350c_s1>;
+		vdd-l2-l8-supply = <&pm8350c_s1>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&pm8350_s12>;
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		pm8350c_s1: smps1 {
+			regulator-name = "pm8350c_s1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1952000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* S2 - ebi.lvl (ARC) */
+
+		pm8350c_s3: smps3 {
+			regulator-name = "pm8350c_s3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/*
+		 * ARC regulators:
+		 * S4 - mss.lvl
+		 * S6 - cx.lvl
+		 * S8 - mmcx.lvl
+		 */
+
+		pm8350c_s10: smps10 {
+			regulator-name = "pm8350c_s10";
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l1: ldo1 {
+			regulator-name = "pm8350c_l1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l2: ldo2 {
+			regulator-name = "pm8350c_l2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l3: ldo3 {
+			regulator-name = "pm8350c_l3";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l4: ldo4 {
+			regulator-name = "pm8350c_l4";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l5: ldo5 {
+			regulator-name = "pm8350c_l5";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l6: ldo6 {
+			regulator-name = "pm8350c_l6";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l7: ldo7 {
+			regulator-name = "pm8350c_l7";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l8: ldo8 {
+			regulator-name = "pm8350c_l8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l9: ldo9 {
+			regulator-name = "pm8350c_l9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l10: ldo10 {
+			regulator-name = "pm8350c_l10";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l11: ldo11 {
+			regulator-name = "pm8350c_l11";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l12: ldo12 {
+			regulator-name = "pm8350c_l12";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l13: ldo13 {
+			regulator-name = "pm8350c_l13";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3400000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+	};
+
+	/* TODO: Add pm8350b (just one ldo) once the driver part is in */
+
+	regulators-2 {
+		compatible = "qcom,pmr735a-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+
+		vdd-l1-l2-supply = <&pmr735a_s2>;
+		vdd-l3-supply = <&pmr735a_s1>;
+		vdd-l4-supply = <&pm8350c_s1>;
+		vdd-l5-l6-supply = <&pm8350c_s1>;
+		vdd-l7-bob-supply = <&vreg_bob>;
+
+		pmr735a_s1: smps1 {
+			regulator-name = "pmr735a_s1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		pmr735a_s2: smps2 {
+			regulator-name = "pmr735a_s2";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		pmr735a_s3: smps3 {
+			regulator-name = "pmr735a_s3";
+			regulator-min-microvolt = <2208000>;
+			regulator-max-microvolt = <2352000>;
+		};
+
+		pmr735a_l1: ldo1 {
+			regulator-name = "pmr735a_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+		};
+
+		pmr735a_l2: ldo2 {
+			regulator-name = "pmr735a_l2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l3: ldo3 {
+			regulator-name = "pmr735a_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: ldo4 {
+			regulator-name = "pmr735a_l4";
+			regulator-min-microvolt = <1776000>;
+			regulator-max-microvolt = <1872000>;
+		};
+
+		pmr735a_l5: ldo5 {
+			regulator-name = "pmr735a_l5";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		pmr735a_l6: ldo6 {
+			regulator-name = "pmr735a_l6";
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <904000>;
+		};
+
+		pmr735a_l7: ldo7 {
+			regulator-name = "pmr735a_l7";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+	};
+};
+
 &cdsp {
 	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
-- 
2.38.1

