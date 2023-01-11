Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B732665605
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjAKIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjAKIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:25:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B35E13D1B;
        Wed, 11 Jan 2023 00:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DC0B81B32;
        Wed, 11 Jan 2023 08:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86039C433EF;
        Wed, 11 Jan 2023 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673425484;
        bh=ZHWrxxWG1aa1/gmTv0VNeABPQiucbBgJ8zRbl6lL6xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhGeMCUAwQXovFMb5lPuZ/+om2PC8LTFyPG/wQhzudJkTKPHJ2CA4FYOENEj4xyJ5
         CZTrOF4ED5iVPJ/wxKx4qJHVOWdL+lTfJvuDhXtHj8JysZWCIMqMJLJxl1kDq4J1/E
         0B9hJ7vfLJGz/i8o+zYe5jUCLF0eGfxaXmImW5b+RKXS17gf48BYEbGNM7VVtpSQ6V
         91oel9Wm+HNegzQq0YM6c7on+xAyPp9SOEw8jX5XeWUaEUBt3/eyBiLMFKkx/ytu9v
         e2Giu/sXpsRY7szj+wDbGRdCUfYDhzsLDo6qFmEtnKRSadXL8X2oFzFF+g77/BrBUq
         4aK21TcrRftxg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFWPd-0005Oa-Dc; Wed, 11 Jan 2023 09:24:45 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sa8450p-pmics: rename pmic labels
Date:   Wed, 11 Jan 2023 09:23:31 +0100
Message-Id: <20230111082331.20641-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111082331.20641-1-johan+linaro@kernel.org>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
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

The SA8540P PMICs are named PMM8540. Rename the devicetree source labels
to reflect this.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
index 8c393f0bd6a8..1221be89b3de 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
@@ -8,7 +8,7 @@
 #include <dt-bindings/spmi/spmi.h>
 
 &spmi_bus {
-	pm8450a: pmic@0 {
+	pmm8540a: pmic@0 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
@@ -22,62 +22,62 @@ rtc@6000 {
 			wakeup-source;
 		};
 
-		pm8450a_gpios: gpio@c000 {
+		pmm8540a_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm8450a_gpios 0 0 10>;
+			gpio-ranges = <&pmm8540a_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 	};
 
-	pm8450c: pmic@4 {
+	pmm8540c: pmic@4 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8450c_gpios: gpio@c000 {
+		pmm8540c_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm8450c_gpios 0 0 10>;
+			gpio-ranges = <&pmm8540c_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 	};
 
-	pm8450e: pmic@8 {
+	pmm8540e: pmic@8 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
 		reg = <0x8 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8450e_gpios: gpio@c000 {
+		pmm8540e_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm8450e_gpios 0 0 10>;
+			gpio-ranges = <&pmm8540e_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 	};
 
-	pm8450g: pmic@c {
+	pmm8540g: pmic@c {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
 		reg = <0xc SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8450g_gpios: gpio@c000 {
+		pmm8540g_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm8450g_gpios 0 0 10>;
+			gpio-ranges = <&pmm8540g_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.38.2

