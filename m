Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DD631BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKUIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKUIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81152809A7;
        Mon, 21 Nov 2022 00:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0F460F49;
        Mon, 21 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EC0C4FF0E;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020715;
        bh=DPEC4Ilp5QnQgwZzP4PbKBn+Zx699/V1FQSwG3qGmeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8osry22nL53W47ZE0NwmycIslGm9kD2qDGnYUq5eWCLqZvdYC7U5wtGNQuxIwJ0F
         zGi/Mu2AKNlqHACcOi2U/GCsG/SE3dAImFGbU5WDXb2lr6mB4c9nFpQBC7jumQxbuF
         oIDxUEFCGVLF5b9Iaxfj45/QIaDWQ1GauuQXW8cmDi7fubomTWSfGMMNdbTildFxJe
         qUbaqB4XqtPZFHR0qKbEBh3j7K4d/7oipih11WQG0pVzXMbpUCmKUPfGuBLd2O068s
         PdhPmxDO6MbwxMgN+rSeuSqwId2xTecvWM8/VnU39XOgM4Hj4zVVtc1NbHyWkSpXv5
         cuXbyxep+yXCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WT-00088q-Ks; Mon, 21 Nov 2022 09:51:25 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 14/15] arm64: dts: qcom: sc8280xp: fix primary USB-DP PHY reset
Date:   Mon, 21 Nov 2022 09:50:57 +0100
Message-Id: <20221121085058.31213-15-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
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

The vendor kernel is using the GCC_USB4_DP_PHY_PRIM_BCR and
GCC_USB4_1_DP_PHY_PRIM_BCR resets for the USB4-USB3-DP QMP PHYs.

Update the primary USB-DP PHY node to match.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index e769b7b0004b..85c674e7e1a5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1682,7 +1682,7 @@ usb_0_qmpphy: phy-wrapper@88ec000 {
 			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
 
 			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
-				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
+				 <&gcc GCC_USB4_DP_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
-- 
2.37.4

