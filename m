Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC466587BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiL1XFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiL1XE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:04:56 -0500
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85489B491
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:04:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1672268692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PX6iCdPCjUBb2nr7cbsGe4oWI8G+iYgwiHBGDijcpgo=;
        b=g8qq2y/p3GU+b6rJbvj8gWpsSw3vfxbY+lZAwzbHzADmkayong7W+Z9DCHE2+M+1OpNgEy
        7oPWijYxVot6v6wahWiNVoux6JBcG1bzUz7kZggKRdg1iJZIneeDW34B/09+fcstCcL7Ym
        HxipPoNl49zDBhCkgOQmj//sSKRgswQ=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by address
Date:   Wed, 28 Dec 2022 23:04:16 +0000
Message-Id: <20221228230421.56250-2-rayyan@ansari.sh>
In-Reply-To: <20221228230421.56250-1-rayyan@ansari.sh>
References: <20221228230421.56250-1-rayyan@ansari.sh>
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
index eb36d3662464..a2092569970a 100644
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

