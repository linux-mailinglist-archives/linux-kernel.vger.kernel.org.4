Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945426778ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAWKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjAWKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:16:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647BA6583;
        Mon, 23 Jan 2023 02:16:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C495B60E08;
        Mon, 23 Jan 2023 10:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF13C433EF;
        Mon, 23 Jan 2023 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674468978;
        bh=Q9IhCE8rYIX3u4FpKXC7Fj/5aemAltdT714sqQWg6NM=;
        h=From:To:Cc:Subject:Date:From;
        b=QywMAAxpwQPw2HvQKQBIFTDHQCwyZtxqAoYmgL5V1UuSSgO4cg1Q4XBiUIqueflXe
         +MH1F3sBO7b3NGVYAiXoHi+NOtXxKDSiB1RJr8ybgNB0f0R+6wf8vriKZX+rS5vZYj
         J+RUF4GFjbeeyYYIvDgo9ZCQW80cQsxru5umnyPETR2gyNR5UnG27g55R8wk9cp2mU
         N7bo+buK+gHx87ZUAAYOCl8D2b/QsaqQveJ3Lg7JjzJI7gmPmfEa1r6ywRBBECZgGF
         IcYP329eQYBaNVojTX4yyjPNyS0AMHYc4RcU27BBQxMYwKej/hBAoCi0MONlFYpqgD
         6ZLcQj6WLV41A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pJts6-0000d8-NI; Mon, 23 Jan 2023 11:16:15 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sm8550: fix USB-DP PHY resets
Date:   Mon, 23 Jan 2023 11:16:07 +0100
Message-Id: <20230123101607.2413-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
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

The USB-DP PHY resets have been switched.

Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6ff135191ee0..2f453dc00852 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2395,8 +2395,8 @@ usb_dp_qmpphy: phy@88e8000 {
 
 			power-domains = <&gcc USB3_PHY_GDSC>;
 
-			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
-				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
 			#clock-cells = <1>;
-- 
2.39.1

