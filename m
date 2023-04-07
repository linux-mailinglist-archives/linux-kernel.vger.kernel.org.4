Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8B6DB23F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDGR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDGR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FE3C642;
        Fri,  7 Apr 2023 10:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156C361224;
        Fri,  7 Apr 2023 17:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EDAC4339E;
        Fri,  7 Apr 2023 17:58:31 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/10] arm64: dts: qcom: sm8250: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 19:58:06 +0200
Message-Id: <20230407175807.124394-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration property "input-enable" was used with the intention to
disable the output, but this is done by default by Linux drivers.  Since
patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
input-enable") the property is not accepted anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sm8250.dtsi                 | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index c96cc9c90a5f..2f22d348d45d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -625,7 +625,6 @@ ts_int_default: ts-int-default-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	ap2mdm_default: ap2mdm-default-state {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4e7875f8786f..f86660fe7918 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2436,7 +2436,6 @@ clk-pins {
 					pins = "gpio10";
 					function = "wsa_swr_clk";
 					drive-strength = <2>;
-					input-enable;
 					bias-pull-down;
 				};
 
@@ -2444,7 +2443,6 @@ data-pins {
 					pins = "gpio11";
 					function = "wsa_swr_data";
 					drive-strength = <2>;
-					input-enable;
 					bias-pull-down;
 				};
 			};
@@ -2460,7 +2458,6 @@ data-pins {
 					pins = "gpio7";
 					function = "dmic1_data";
 					drive-strength = <8>;
-					input-enable;
 				};
 			};
 
@@ -2478,7 +2475,6 @@ data-pins {
 					function = "dmic1_data";
 					drive-strength = <2>;
 					bias-pull-down;
-					input-enable;
 				};
 			};
 
@@ -2523,7 +2519,6 @@ clk-pins {
 					pins = "gpio0";
 					function = "swr_tx_clk";
 					drive-strength = <2>;
-					input-enable;
 					bias-pull-down;
 				};
 
@@ -2531,7 +2526,6 @@ data1-pins {
 					pins = "gpio1";
 					function = "swr_tx_data";
 					drive-strength = <2>;
-					input-enable;
 					bias-bus-hold;
 				};
 
@@ -2539,7 +2533,6 @@ data2-pins {
 					pins = "gpio2";
 					function = "swr_tx_data";
 					drive-strength = <2>;
-					input-enable;
 					bias-pull-down;
 				};
 			};
-- 
2.34.1

