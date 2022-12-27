Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4F656D24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiL0RCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiL0RCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:02:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE364CC;
        Tue, 27 Dec 2022 09:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04720B80E8B;
        Tue, 27 Dec 2022 17:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B077DC433EF;
        Tue, 27 Dec 2022 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160530;
        bh=HSrkH2QP+5Wq6R0Soayg1cGRPH7lpTtG6x6slsvI3Uo=;
        h=From:To:Cc:Subject:Date:From;
        b=IxvyLdrwllY4JjEY4zHHDSIjrEq8f9oAmsCvGu47k3nhNjSD8VH9IJzVR/yX2omzo
         5fXy8o/d2Mu3nFM6eAtPN7I+WESB5a5VNTAVi6qXKiZXIQ0JkmgTiVdUuxtH2MS/D2
         3mr8sOEQpPS6yyI/PXuIJix1maE/XcMNaSkZnCf2aE+ESp9d2hCXsYjwAleKbxvOln
         9AHiJedmwx6qfSwFykfCPA+Aq7HLw84mZ6P4SqQ6M8zmrhPJBiuHhvSaFu/W59ODWV
         bBldgwfDvODIw/zUzR5v/vS6avcJ529St1OUX6hdVr5+RxBYo3k91pfGwzVXlLptg8
         wLcNEJKO9lRbg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pADL9-0005cs-4L; Tue, 27 Dec 2022 18:02:11 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: move 'thermal-zones' node
Date:   Tue, 27 Dec 2022 18:02:02 +0100
Message-Id: <20221227170202.21618-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 'thermal-zones' node after the regulator nodes to restore the
root-node sort order (alphabetically by node name).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 92 +++++++++----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 568c6be1ceaa..fce2d9d6e2bc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -31,52 +31,6 @@ backlight {
 		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
 	};
 
-	thermal-zones {
-		skin-temp-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-			thermal-sensors = <&pmk8280_adc_tm 5>;
-
-			trips {
-				skin_temp_alert0: trip-point0 {
-					temperature = <55000>;
-					hysteresis = <1000>;
-					type = "passive";
-				};
-
-				skin_temp_alert1: trip-point1 {
-					temperature = <58000>;
-					hysteresis = <1000>;
-					type = "passive";
-				};
-
-				skin-temp-crit {
-					temperature = <73000>;
-					hysteresis = <1000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&skin_temp_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-
-				map1 {
-					trip = <&skin_temp_alert1>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -172,6 +126,52 @@ vreg_wwan: regulator-wwan {
 
 		regulator-boot-on;
 	};
+
+	thermal-zones {
+		skin-temp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8280_adc_tm 5>;
+
+			trips {
+				skin_temp_alert0: trip-point0 {
+					temperature = <55000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin_temp_alert1: trip-point1 {
+					temperature = <58000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin-temp-crit {
+					temperature = <73000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&skin_temp_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&skin_temp_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 &apps_rsc {
-- 
2.37.4

