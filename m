Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03136587C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiL1XFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiL1XE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:04:57 -0500
Received: from out-100.mta0.migadu.com (out-100.mta0.migadu.com [IPv6:2001:41d0:1004:224b::64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEABCAC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:04:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1672268694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBTfSUHTvgyGxmF8E/musLE0GpaHQw4AJNbJEOBPGy4=;
        b=CYAaoczC6ygtguWFgl/6bv7KQToPQAA5fHMmXuwaJkJC2ceU88421FZhnB7+bF3UH5sgpn
        GP9x2DrHwRR4jsWZKXPn/SEoH+NINdkvHABz+jNTl6YbR4OZbjJX60saDGXiGDV5YkRBf8
        +abKLGl41ew4RsMYkDPflbsl0obvI7Q=
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
Subject: [PATCH v2 3/4] ARM: dts: qcom: pm8226: add IADC node
Date:   Wed, 28 Dec 2022 23:04:18 +0000
Message-Id: <20221228230421.56250-4-rayyan@ansari.sh>
In-Reply-To: <20221228230421.56250-1-rayyan@ansari.sh>
References: <20221228230421.56250-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the current ADC (IADC) found in PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 6af259218f63..46ba84f86c9f 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -88,6 +88,12 @@ adc-chan@f {
 			};
 		};
 
+		pm8226_iadc: adc@3600 {
+			compatible = "qcom,pm8226-iadc", "qcom,spmi-iadc";
+			reg = <0x3600>;
+			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
-- 
2.39.0

