Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4C6770C4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAVQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAVQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7B7D9F;
        Sun, 22 Jan 2023 08:48:57 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E3647CD525;
        Sun, 22 Jan 2023 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406136; bh=FeNVtUdytvubaP0uimVMcr9Plbnb7l5JICVHXAO6K/4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=olOeDCUL+2FF8X/aJOzERYlr+skdR12Jp7iUZ3eq/H+maHJIbqbvIU9X7zbUi8FBO
         /Kz5TPgmoywFCMsTBRtorT17YiY9Ogguua6bs3v2QB8AcVZ25RHgcO4RGxBA2msiee
         yNJbKgXJ2iLE/A3l5HZGgasS7InTEDcvIa4BqeRs=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 22 Jan 2023 17:48:33 +0100
Subject: [PATCH 2/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add vibrator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v1-2-4049f565c24c@z3ntu.xyz>
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
In-Reply-To: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=691; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FeNVtUdytvubaP0uimVMcr9Plbnb7l5JICVHXAO6K/4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWjzzh4/8zbBHv3mCEHVv66Nv1+91v2ctZk1G4vK
 VXhtH8uJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o8wAKCRBy2EO4nU3XVrRjD/
 4sLwt6105gqxpVAMn7x+2rNXXjMTkRN9Vz64Yj7WW2wnEZ2ziS1OMwJTME5y9c+G5nAiGfW1tI+QTp
 XCWbrwat/llyg4dIaR4kqrq7/G52mZp/mcpWl93jwJ7ybeifmyTMTF/wsugOwkQg4qCFXUcolayVOZ
 BxmbeM+DSgsKYKEztg5JQzX+INEGodreTiWUct/KSNGf0cSfC8m3VOKaVG5g0m2iK+ISzvhGBbREpc
 POClyqF4Ebd8x0BTIYLb29w4dH7Apo/ReUHp/ANyyWuUZvBUbmSwYB/4EMBvofm75CVrI4BOQw+4+h
 kUDYv6MDeNFXDPb/V0Dwitdgr9N2+64Q6uztD/4MxrjrLGZV6dtRP7HE7d6BWVnYUQYAWu3Ij42iUu
 3HAC0MGzoLJNXD4XxIQpz5RXZw4jbQ+yVhlbMqHdbjNN0cfqZViF5GCcNuzLR3XA/38hQKrAtcuGh8
 LSHkjOM9DJi4Db+wKro8yhFgNSWveGqZHmxsjtLiCKZ53g722oeTg568R05lHrx0VoxtuOUgy+WgLr
 PpuHetkp856nmxuillfFpTT+qI44kIU4wbNU23rFoSXkp7sTz06nEWBaSCVxAOUosL3eIcPV5/gYSt
 33EwMwEOdFibXdx9Zx6BpAvZKI6sILUm3CvEIcUKqWmhrkaVgBhur+Gi2TRg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the pm8941 vibrator that's wired up on this device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index b5606623f968..63180fe1d292 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -95,6 +95,10 @@ &pm8941_coincell {
 	status = "okay";
 };
 
+&pm8941_vib {
+	status = "okay";
+};
+
 &pronto {
 	vddmx-supply = <&pm8841_s1>;
 	vddcx-supply = <&pm8841_s2>;

-- 
2.39.1
