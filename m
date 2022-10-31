Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD6613C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiJaRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:52:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989F13D44;
        Mon, 31 Oct 2022 10:51:59 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2B7E6D01B5;
        Mon, 31 Oct 2022 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667238688; bh=z1kSUtm3HLtZ7/rQowrzXF2lT5Ezgi3Wqmb/Ix2SlYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gkcYyEER8S3FWGyYU5yiHoP1UeVwupkcXRTzmfqYDzhPbNOZX/Dm45jb2PIaLdCoH
         40hI5//foBRBqRJFa8soaFSsNIaH56fP+gfHTylPJchWuiKfHuFVGzp42MtkqDLOTc
         KIiHIQQwiO07UnuCXVOiMkOkNdYt6FYSB/3K0JCE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ARM: dts: qcom: pm8941: adjust coincell node name to bindings
Date:   Mon, 31 Oct 2022 18:51:17 +0100
Message-Id: <20221031175119.939860-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031175119.939860-1-luca@z3ntu.xyz>
References: <20221031175119.939860-1-luca@z3ntu.xyz>
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

The spmi-pmic bindings say that pm8941-coincell should be called
'charger'.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Drop misc@ -> extcon@ change, will be separate patch
* Pick up tags

 arch/arm/boot/dts/qcom-pm8941.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 1ac477878c67..7a4467e03aa1 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -131,7 +131,7 @@ pm8941_iadc: iadc@3600 {
 			qcom,external-resistor-micro-ohms = <10000>;
 		};
 
-		pm8941_coincell: coincell@2800 {
+		pm8941_coincell: charger@2800 {
 			compatible = "qcom,pm8941-coincell";
 			reg = <0x2800>;
 			status = "disabled";
-- 
2.38.1

