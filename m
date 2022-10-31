Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225A8613C54
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJaRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJaRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:40:09 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7113DCE;
        Mon, 31 Oct 2022 10:39:49 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 372A3D03F3;
        Mon, 31 Oct 2022 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667237988; bh=bj+OfITge66Pd2VrekTMzTS9h8Rrw+YQRU9RDhOw/TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=s5wi+pPmEzmUWRPz8Sd2NsgpNcnJQkuCqckioEnelV7anVoedB7eAsx+l7npnQYxa
         iuIRFXbU831AKwqS0KF6nvGSnIDjl+MF0Eo7vHChZ0kVChWmVlhkS48dKk+jy6Iy0C
         WUEU2XCnlWEV0N2przDqOl67SuLMki7f6P2U0LLE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8150b: change vbus-regulator node name
Date:   Mon, 31 Oct 2022 18:39:33 +0100
Message-Id: <20221031173933.936147-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031173933.936147-1-luca@z3ntu.xyz>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the node name as now defined in the spmi-pmic bindings.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* New patch

 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index cdded791d96e..66752cc063d6 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -53,7 +53,7 @@ pon@800 {
 			status = "disabled";
 		};
 
-		pm8150b_vbus: dcdc@1100 {
+		pm8150b_vbus: usb-vbus-regulator@1100 {
 			compatible = "qcom,pm8150b-vbus-reg";
 			status = "disabled";
 			reg = <0x1100>;
-- 
2.38.1

