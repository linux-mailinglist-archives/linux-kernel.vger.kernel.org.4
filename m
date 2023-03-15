Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B026BB843
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjCOPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjCOPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:43:46 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2107B124;
        Wed, 15 Mar 2023 08:43:24 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8F98D41853;
        Wed, 15 Mar 2023 20:43:20 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678895001; bh=xX7EYL7wXsayPKP8zgaIQPK4KiM6Req4Uxirxf+cywE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrA+D0VtP03Lkdms5G5i3OsiTMFo6u+dGSV2HyZ9KX1oFjuc0Z6To2bSIOvMkYu/H
         o8r4rCbqfZAIP11oSFE3v/tnwpmOp3sTZu8dguT8G+liUKqVvgG53XUCuq0Z8ZNZk2
         m1bqQ0ydAL2LWb+QV4XHTkrwtL8R0L180ShSPPZ8md05F3pfQXXhQXVS8amUo7k5bO
         QRgJpJbxTble8Mdc5aXMrRBmAzSTZUVkzznF7t+xhuRiv6Ba/zHgD+46U5jHptF2My
         Jpuiv2jGdK1RKw5IRIW+HN6Bosfi1a6Vsnq8Tm8nUrsaLuza/0uY8mxshNLgCB3XSM
         KWpBbfRAxP9+A==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 2/4] arm64: dts: qcom: sc7180: Drop redundant disable in mdp
Date:   Wed, 15 Mar 2023 20:43:09 +0500
Message-Id: <20230315154311.37299-3-nikita@trvn.ru>
In-Reply-To: <20230315154311.37299-1-nikita@trvn.ru>
References: <20230315154311.37299-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdss is useless without a display controller which makes explicitly
enabling mdp redundant. Have it enabled by default to drop the extra
node for all users.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 --
 3 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index c3bdd3295c02..828c8b55d925 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -339,10 +339,6 @@ &dsi_phy {
 	vdds-supply = <&vreg_l4a_0p8>;
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 26def6e12723..e72d49a3d97d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -818,10 +818,6 @@ dai-link@5 {
 	};
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f0de177981f9..4ee64ee824b3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2983,8 +2983,6 @@ mdp: display-controller@ae01000 {
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
 
-				status = "disabled";
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.39.2

