Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26456F2DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjEADOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjEADNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A99C4212;
        Sun, 30 Apr 2023 20:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C07E616DB;
        Mon,  1 May 2023 03:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5DC433EF;
        Mon,  1 May 2023 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910285;
        bh=LSF8GLpmJIdmiLLMB6nqxhWHACPB5XJlEqWEYFIl0pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paJ+AAn66R50AL6kVZJwcEw4Lk0SpG8/7N5lNa2/na1SHYqli4seXx1MQlRXMeuNf
         hil+E5GGBoox0RoAiHb/9KsgThVqqqd3jsPCS88sFyFstknejTCIoYQMvx5r+fmFii
         LRkApRIDmpAq3I1Q0N2IfmOkSWTODzbuIeRfwtQwx8H6dnWVaBmi9ll0R/xAUv9aAI
         OVrpE1ap2J6+EOKaC5+vl10wluGEofTvpWYRc5Y6kyGttAogADa2Mfv9NLtvh0F/gP
         fzSbKY1fAozIwYM0ZEqUOR/Vw7zhOwBXHUnxJqj25ngdDgOgRd/crmWdcUzCQtu3x8
         q5n79VlceYLBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/17] arm64: dts: qcom: msm8996: Add missing DWC3 quirks
Date:   Sun, 30 Apr 2023 23:04:21 -0400
Message-Id: <20230501030435.3254695-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030435.3254695-1-sashal@kernel.org>
References: <20230501030435.3254695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit d0af0537e28f6eace02deed63b585396de939213 ]

Add missing dwc3 quirks from msm-3.18. Unfortunately, none of them
make `dwc3-qcom 6af8800.usb: HS-PHY not in L2` go away.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230302011849.1873056-1-konrad.dybcio@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 40174220e8e28..859f60823e3b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2595,8 +2595,11 @@ usb3_dwc3: dwc3@6a00000 {
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,is-utmi-l1-suspend;
+				tx-fifo-resize;
 			};
 		};
 
-- 
2.39.2

