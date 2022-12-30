Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977F6553FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiLWTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiLWTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:41:54 -0500
Received: from out-66.mta0.migadu.com (out-66.mta0.migadu.com [IPv6:2001:41d0:1004:224b::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2220F4D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:41:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1671824094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEEj5Ej8/ePlR6ODry659RSCjAwiu7EXnRI2MiybwOQ=;
        b=PAoLkAZScyRpo8UeM95cH9S43hxxXS9MKVsd98aIcnhicSZTPydBA24N3uNHIo02AxFX4R
        bOI9HJ+hwMbHYps3rmGwS+QmGMpjDIeaw1aX44QHhx1qmIyhLaRGhdRaAt8xKt0PTtYfoa
        DfRP2sfhXqAs8yQ4eKBE5IDm5an0Dw0=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by address
Date:   Fri, 23 Dec 2022 19:34:01 +0000
Message-Id: <20221223193403.781355-2-rayyan@ansari.sh>
In-Reply-To: <20221223193403.781355-1-rayyan@ansari.sh>
References: <20221223193403.781355-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the includes and nodes for consistency.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..d99532ea70b2 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pm8226_0: pm8226@0 {
@@ -41,13 +41,6 @@ smbb: charger@1000 {
 			chg_otg: otg-vbus { };
 		};
 
-		rtc@6000 {
-			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000>, <0x6100>;
-			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
-		};
-
 		pm8226_vadc: adc@3100 {
 			compatible = "qcom,spmi-vadc";
 			reg = <0x3100>;
@@ -81,6 +74,13 @@ adc-chan@f {
 			};
 		};
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pm8226_mpps: mpps@a000 {
 			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
 			reg = <0xa000>;
-- 
2.39.0

