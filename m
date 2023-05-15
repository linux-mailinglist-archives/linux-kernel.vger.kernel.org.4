Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE137029EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbjEOKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbjEOKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:03:12 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07FF19C;
        Mon, 15 May 2023 03:02:52 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 2D7F441A9D;
        Mon, 15 May 2023 14:37:52 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1684143472; bh=a1kgMjWCZwmFRW1gO8Mq3JgwPu4jB3Ebt5jfqdsvuGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4e451vNsAwWti0j93axlM+hKNVFasYceiyEOpENHtoi1eXUnkp58+QULWc/4NkAn
         dsQDbDrUcnAvooZdb5ru4uHDwCVglVbkZptAzJmn0XHu2gLDtdLGQ3XRlX8z/GiHLp
         RgrQECnEFpBwp8dcnfg72JVTCExTTe4RSa+pXswmcpfd/3YCGUTMveN0f74krJ6vFO
         8i7Izg9Goqc3xgB0S07YGJJtJRT0vEwlu32NiP14yjnj8pf9/YzRvLopCFLjgaf1RA
         +ijX9dP2tCGHLmTb12G3Ot3pHyoj1xiTfgZcazcztL9OZhzqbpIm5eoMB7U8dE2OmC
         jlhj+hqxzHs9g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, dianders@chromium.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v6 RESEND 2/4] arm64: dts: qcom: sc7180: Drop redundant disable in mdp
Date:   Mon, 15 May 2023 14:37:42 +0500
Message-Id: <20230515093744.289045-3-nikita@trvn.ru>
In-Reply-To: <20230515093744.289045-1-nikita@trvn.ru>
References: <20230515093744.289045-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 9f052270e090..bd9ed03159cf 100644
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
index 6cf09152fdfd..51d6c3502f3f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -821,10 +821,6 @@ &lpass_hm {
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
index 39130596dc7d..d89aa5619163 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2988,8 +2988,6 @@ mdp: display-controller@ae01000 {
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
 
-				status = "disabled";
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.40.0

