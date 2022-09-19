Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B75BC5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiISJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiISJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D6EE3F;
        Mon, 19 Sep 2022 02:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06DC1B818A3;
        Mon, 19 Sep 2022 09:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73531C433B5;
        Mon, 19 Sep 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580707;
        bh=s9K7DCVx0hfoKr2j9LhDAa8fNE0tFe+Lj985aH8PwG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYdtTZyplR9Y130+ScxX6hlVQ46AgOBSnppVz/9G/C6Xzz6i9TK/hXkEWe9BpBMhj
         i9islBVVihlvLkWLxJgyhEccDPJR/ZWCWuGxHJRbNa0+g6OfYXr8XoeUhWc2U2pQ80
         RnpaBRnSJ/V+nzyw8lPS6ypRI7PPuSh2AAJeOl6K4BaX1wWQQqOHZ6RJ91DFJ8yFZC
         7o0N7+ntgP2lIdQrYO4UrSQqP61Xq+nPiRo+ivCK3suVqPdMVQS28Rhk4mb03Ru4lZ
         Cy4kUwXltOCl04SKLo3oIgtr9WZeAbWBaHCr/UYBUAuxiXSq/WIqLiPhCQd06bsvLd
         6cnqrdOeYwKpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDKy-0000Pq-1Q; Mon, 19 Sep 2022 11:45:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] arm64: dts: qcom: sc8280xp: fix USB1 PHY RX1 registers
Date:   Mon, 19 Sep 2022 11:44:52 +0200
Message-Id: <20220919094454.1574-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919094454.1574-1-johan+linaro@kernel.org>
References: <20220919094454.1574-1-johan+linaro@kernel.org>
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

The USB1 SS PHY node had the RX1 register block (0x600) replaced with
RX2 (0xc00).

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index e8905445ca19..9667eb1b7c61 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1242,7 +1242,7 @@ usb_1_qmpphy: phy-wrapper@8904000 {
 
 			usb_1_ssphy: usb3-phy@8903400 {
 				reg = <0 0x08903400 0 0x100>,
-				      <0 0x08903c00 0 0x3ec>,
+				      <0 0x08903600 0 0x3ec>,
 				      <0 0x08904400 0 0x1f0>,
 				      <0 0x08903a00 0 0x100>,
 				      <0 0x08903c00 0 0x3ec>,
-- 
2.35.1

