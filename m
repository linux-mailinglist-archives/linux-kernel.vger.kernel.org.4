Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487BB665FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjAKQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjAKQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:03:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7CDF89;
        Wed, 11 Jan 2023 08:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB2B61D78;
        Wed, 11 Jan 2023 16:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8219C433F0;
        Wed, 11 Jan 2023 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673453019;
        bh=C8MTWqDAAuM3kPKERqcLzORwc/4RvPJZmDvRGVKEQDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/x9MBxV8T5qriIIqYM+X8RJPf2R2jRdvsKZdoWYg9QxqzbKpwFb+Oo7n6w7qU0xT
         8SvMfJnF362D7/oDhyrwR9CpdDxPuCNwgGt9bGruY6SnOTnWX+jXN+xpx7nAUAKSR9
         uHY3ETBiZpY1AJbDXGn7iCGf45hCn4zLveNA7BhNhc6pYmv151gGxVuMhxb3zLrs9P
         V3E8pJR9Vz3amgN5L4ZVdoXQnXZwPSHdKALmeh3cP2yV81+1xgqDV8cjUbqXUNJ2az
         BErMDgcJsgp1i54n3O04nUzVpjKKj4iliEWyV030gucocVHPBk4/15eTuKZn1qnGLn
         WNZU7DC6YH7uQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFdZo-0001sU-HH; Wed, 11 Jan 2023 17:03:44 +0100
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
Subject: [PATCH v2 2/2] arm64: dts: qcom: sa8540p-pmics: rename pmic labels
Date:   Wed, 11 Jan 2023 17:03:35 +0100
Message-Id: <20230111160335.7175-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111160335.7175-1-johan+linaro@kernel.org>
References: <20230111160335.7175-1-johan+linaro@kernel.org>
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

Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Eric Chanudet <echanude@redhat.com>
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

