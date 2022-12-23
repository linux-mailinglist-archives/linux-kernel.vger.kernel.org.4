Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF336553FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiLWTmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiLWTlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:41:53 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 11:41:52 PST
Received: from out-160.mta0.migadu.com (out-160.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707BA20BCB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:41:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1671824095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cuo2mCxNwzlaaPMVGjwAgwxjj9yvcLc2q0fziXRbFVU=;
        b=NeIx+4APL6Bbg5KKboUjBG2eMNXJamoYBXirkOAWVHWdr5z58oL0yA1l2v/nNg/Vn43YVS
        VcEuaxYCoir6rAKF9EQk1ZNgSTPYJzQVmgHffQICsaZh/P1+KAxDQ5hDBWALfLdtUGUHxV
        K2WaUZukdiczgakdeTuyhv3d2vXkkwE=
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
Subject: [PATCH 3/3] ARM: dts: qcom: pm8226: add IADC node
Date:   Fri, 23 Dec 2022 19:34:03 +0000
Message-Id: <20221223193403.781355-4-rayyan@ansari.sh>
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

Add a node for the current ADC (IADC) found in PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 403324a35cf5..82470549f240 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -88,6 +88,12 @@ adc-chan@f {
 			};
 		};
 
+		pm8226_iadc: iadc@3600 {
+			compatible = "qcom,spmi-iadc";
+			reg = <0x3600>;
+			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
-- 
2.39.0

