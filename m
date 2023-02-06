Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E068C7D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBFUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjBFUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:40:36 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA467D81;
        Mon,  6 Feb 2023 12:40:35 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 420E2D1D6A;
        Mon,  6 Feb 2023 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675716033; bh=seYDTlxpMzvQVtMfNvABd2LwuWxm1YJSIuqTsjMROQ0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ZkJzW+HiurRMvK6zM3RziYdnQ6CQ3iVKDX1MMXj8zZAeb/wbBt21peEfGWNNrzNIO
         Qf5AvX/qNwCo5GFHYHcUmjqb/PnPhrrAzNx8Jk4BIj6j+ciKydBo5sLjlz79PLW3VC
         Vwoy/GyvVZwOFmus9R/a3Iwrq1rDKhe0fDn0z8fc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 06 Feb 2023 21:40:18 +0100
Subject: [PATCH v2 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 notification LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v2-5-06bb83c20a58@z3ntu.xyz>
References: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
In-Reply-To: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=seYDTlxpMzvQVtMfNvABd2LwuWxm1YJSIuqTsjMROQ0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj4WW+mUJuyLk9BQkGprDfxlRyZNuunRkz5zOCH
 FqK/HYoEpyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+FlvgAKCRBy2EO4nU3X
 VswPD/wKDjVqF4QFKUAcYRtkolZouxmnvYmksqixKfon+Py8QjfSktMW074uXOZ2WqntQIkOaSE
 7Lyp8RNjHvcrZ47HpVdOvkMzpYEyvF045/LTacuWZtlnnFyR0G4UjSg6tC17OHCQ26FKTPlD5E8
 JgsOfucC3DUn20t5X3Hab2yjZR+HxIaWo0YBJEpBZL+Wo8aO7wbXdMb15En6rFwIlUJPGPyDhZv
 +xatnXEEI0NrKh3//jsBWNih+lVOwg74Zfb2VIXFp+nz94AOZ3byUw1qOMAWJVVDaumNhhLfgFo
 cxjtbE9I+ghLuwOCuidnGkASOZrMZq4/G4VWSqqmkXQ9V2xaPtu+cL0Uk1PIHHycDqdZx7STkhL
 11zhJo20BrhUh4NlQR5oVL0o4gEdAuFDvwHscbUxS4mIglSsWA2UD1oIzVkVMOkbCDBW6/1xnH+
 gIRbbFAhgD1scVLg8tkkzoeAwuFb+XbM1eqyBc8/eii1IUyZ31AX3b2OyN4EOPVnHI1hXt5pNVl
 L1WzoZSYZOtu2YDE7d/IQOrR3BfM+2PHAuRYBUK73vIkvPdPshqiwbszC2lIkiXWaCLGOeambY+
 9f7yEsC/a0WFP84YKOGzYoPM6NdDSJM7Hinq6f3kwITzqbWF7GWfrABnCP+me3mL7jYCx9/gbg3
 pRyEDWNzmjQVGYQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node describing the sn3193 that's used to provide notification
LED.

Unfortunately the driver currently supports neither multicolor API nor
using the properties function & color, so we use label instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index a4b5d680c097..8d2a054d8fee 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -114,6 +114,34 @@ led@0 {
 			default-brightness = <80>;
 		};
 	};
+
+	led-controller@68 {
+		compatible = "si-en,sn3193";
+		reg = <0x68>;
+
+		shutdown-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			label = "red:status";
+			led-max-microamp = <17500>;
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:status";
+			led-max-microamp = <17500>;
+		};
+
+		led@3 {
+			reg = <3>;
+			label = "blue:status";
+			led-max-microamp = <17500>;
+		};
+	};
 };
 
 &blsp1_i2c6 {

-- 
2.39.1

