Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370C06DB990
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDHIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDHIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:14:20 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A249CB;
        Sat,  8 Apr 2023 01:14:19 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 276D642278;
        Sat,  8 Apr 2023 13:14:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680941656; bh=BUy267hYn2QpdSInMThOHp6C0pEDzcb6a1q+17Ndj78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9v0mK89X3HVaEvSSPMB9MPZ3mUrBWDDWG2WlKOFY3z4nFXLpILIFaizXYdKmsSAg
         du0ucLkjhOedllbYUoXnVFfzo2Zqd9DqT5H6X8OErPVp5G9cJHVcK5nFZYuIs8jHiS
         V4cCHA9GM/M/0ELlkDGlDu1qz+QM9N2EfU61/b+g7tzeK7wR1r3KzwPEZ5Lcyp7duy
         95KyK3z+GtS8FgDoI3//cd1eM+13iOFqXAqQ8a/3ageZ5vi4aD0+pbDIow65q7F1zE
         GSgBRDtmbS5QFVTDxQu1Z4Tb5h5hv1l1gEH6IDrU/Zn/ZyQ0L7nWwy5yWGwuj7F6rd
         dNmJ/xS6nLwGg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, quic_srivasam@quicinc.com,
        judyhsiao@chromium.org, mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 2/4] arm64: dts: qcom: sc7180: Drop redundant disable in mdp
Date:   Sat,  8 Apr 2023 13:13:14 +0500
Message-Id: <20230408081316.234293-3-nikita@trvn.ru>
In-Reply-To: <20230408081316.234293-1-nikita@trvn.ru>
References: <20230408081316.234293-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdss is useless without a display controller which makes explicitly
enabling mdp redundant. Have it enabled by default to drop the extra
node for all users.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 --
 3 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index fcabbc6a897f..292aed241839 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -334,10 +334,6 @@ &dsi_phy {
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
index 7e57899ef2c6..1d2867cc0526 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -818,10 +818,6 @@ &lpass_hm {
 	status = "okay";
 };
 
-&mdp {
-	status = "okay";
-};
-
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6f40301faa1c..13e4a5045fdc 100644
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

