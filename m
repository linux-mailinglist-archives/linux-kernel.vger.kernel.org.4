Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC43B5E94CE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiIYRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:25:33 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6EA1CB31;
        Sun, 25 Sep 2022 10:25:32 -0700 (PDT)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4062FC7D66;
        Sun, 25 Sep 2022 17:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664126700; bh=6088Sq4xISQUtRTZ2+MtOHvzEKP8WW6G5ay7xyjFd70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GctcWVNydGHRkkI/D1X5cpVNZJdP/CVwgoTeYxaGATfaD3uDLei0PiVM+fLd18faC
         0rQaX7/5A+b0qEz8s71wqW5+mt/zW4nyeLFvP7fHJ2s0dtdS+96KptixymMeIa4hJ7
         rVWBncKzsw/1iEeRWMTGWCm+ki5VqgWs4C+yqg6A=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: msm8916: Align dsi phy-names with schema
Date:   Sun, 25 Sep 2022 19:24:43 +0200
Message-Id: <20220925172443.92900-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220925172443.92900-1-luca@z3ntu.xyz>
References: <20220925172443.92900-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dsi instead of dsi-phy as required by the binding.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a831064700ee..48f4b4deb8b1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1046,7 +1046,7 @@ dsi0: dsi@1a98000 {
 					      "pixel",
 					      "core";
 				phys = <&dsi_phy0>;
-				phy-names = "dsi-phy";
+				phy-names = "dsi";
 
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.37.3

