Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55667266E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjARSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:13:57 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1833A9C;
        Wed, 18 Jan 2023 10:13:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674065634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pBSuZaRrZacCyeKeatXVWrihy/z6hRc4D5TzPmz6tds=;
        b=R4A6cjhyvnW5HlZPoQUDa0OlogKqfKKdgYjmXbmX7TrOR0TGVFAVBB5m966mX1PRVozAAW
        BzvUAtk1J/GSyP1yokjLRO4EcEgCEn8WHKYmnzvcBFqLeXf1RI6dN2WdGsBtWFnaoeQyiR
        x8xRlfotYrC5S0OpDqDSmY4U5A06vzo=
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
Subject: [PATCH] ARM: dts: qcom: msm8226: add RPMCC node
Date:   Wed, 18 Jan 2023 18:13:43 +0000
Message-Id: <20230118181343.438373-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the RPM Clock Controller on MSM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index c261fdfbe116..b48e50f46790 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -74,6 +74,13 @@ rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8226";
 				qcom,smd-channels = "rpm_requests";
 
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8226", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
 				rpmpd: power-controller {
 					compatible = "qcom,msm8226-rpmpd";
 					#power-domain-cells = <1>;
-- 
2.39.0

