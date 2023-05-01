Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E76F2D60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjEADLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjEADKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7D268A;
        Sun, 30 Apr 2023 20:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A6D961780;
        Mon,  1 May 2023 03:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50780C433D2;
        Mon,  1 May 2023 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910182;
        bh=6Ni6ZtYQxbGJIzJ5svZkAHtqXG+6kSIFN8BJW+lv0tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgMf7YvKPSYYtwXw9PebE4+pGF5FpErwSLxCLDDcadrzT9yjGAKhSDYpFFG1EVcSq
         L0bICIVWg3fTsd81RKCeuwzMYpc8dVGSYPfM3iKxkp0rDXoWHuxohPUZYdWQW4oixq
         x5m85pTg47ai9aQoOfuvSHLLGLRdrIly7ANF5XgwqZHT1LMEpWOprQ1BVek2mU/s7O
         dEbEPOLq0zHtrp0623/EMNDSE46tChe/Q3UZeh0h/lbs7Id6/4xIxiDxlyFbEK+eHC
         iHidIT0F+ZLcMgChsmhvqLj1KCDS1o6WvdctgaP57m/rQtMw3fbZtK+9jpVg0MF6QL
         ulw8R/ySPJmRg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/33] arm64: dts: qcom: msm8996: Add missing DWC3 quirks
Date:   Sun, 30 Apr 2023 23:02:03 -0400
Message-Id: <20230501030227.3254266-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index c103034372fd7..62ac174f1a4c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2979,8 +2979,11 @@ usb3_dwc3: usb@6a00000 {
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

