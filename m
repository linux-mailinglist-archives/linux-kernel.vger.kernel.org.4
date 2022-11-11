Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209486256FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiKKJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiKKJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:40:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C7654DD;
        Fri, 11 Nov 2022 01:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F23E61F1F;
        Fri, 11 Nov 2022 09:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC53C433B5;
        Fri, 11 Nov 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159611;
        bh=pwJld/NDv6EFSXj/8bGWt2JYworcFl8ayZrNG0RBYVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvB545SeJo3aPXhqnDqx0vrS5nZIUtHJdsgjeJ/QP+3YW3m4h9CpN9abDWqpFNTk0
         HrR9sY3Z4gLQFP76NW/irY5vUP/YPJRd3UPBcRxSxor/L/Cu0x7OYotvUjkxNIVddj
         d9PZ2na8SyjAzvqzL/WJn/kxv7Nxzeo7sZPwynAlfC9Uewpa0lRuKPes76SB9+ho/e
         jy6pZa6GKjL5OQAFiBDMERdvzvqJTk4I4m+p9KV8q48pwvc/yyudz2Sk3M4x4mdzNI
         NmGnmVlNyPgWiqVhXOOos6J4Y3dyNn1wqsvmgbpcfNZ1G9h6XVFU3BFKIOc0WNjxmM
         LL7tGhslsAjpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQVj-0002xl-D6; Fri, 11 Nov 2022 10:39:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp: drop reference-clock source
Date:   Fri, 11 Nov 2022 10:38:57 +0100
Message-Id: <20221111093857.11360-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111093857.11360-1-johan+linaro@kernel.org>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
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

The source clock for the reference clock should not be described by the
devicetree binding and instead this relationship should be modelled in
the clock driver.

Update the USB PHY nodes to match the fixed binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 985138b6adac..531cd68a80ea 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1595,12 +1595,10 @@ usb_2_qmpphy0: phy@88ef000 {
 			reg = <0 0x088ef000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_MP0_CLKREF_CLK>,
 				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
 				 <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
-			clock-names = "aux", "ref_clk_src", "ref", "com_aux",
-				      "pipe";
+			clock-names = "aux", "ref", "com_aux", "pipe";
 
 			resets = <&gcc GCC_USB3_UNIPHY_MP0_BCR>,
 				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
@@ -1621,12 +1619,10 @@ usb_2_qmpphy1: phy@88f1000 {
 			reg = <0 0x088f1000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_USB3_MP1_CLKREF_CLK>,
 				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
 				 <&gcc GCC_USB3_MP_PHY_PIPE_1_CLK>;
-			clock-names = "aux", "ref_clk_src", "ref", "com_aux",
-				      "pipe";
+			clock-names = "aux", "ref", "com_aux", "pipe";
 
 			resets = <&gcc GCC_USB3_UNIPHY_MP1_BCR>,
 				 <&gcc GCC_USB3UNIPHY_PHY_MP1_BCR>;
-- 
2.37.4

