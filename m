Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334136770CE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAVQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjAVQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:42 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F281C320;
        Sun, 22 Jan 2023 08:49:32 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AE834CD52F;
        Sun, 22 Jan 2023 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406136; bh=UC4MZp7joZ5KIGVSNAjIE3z+woZwa8RY5kG95For80s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=fVblwWHYIq+sZjwawB8O/+pjliEqr1MXSpYnZ4VYptxGu/htsKJQYy3mvkJNPL/Re
         qnJC9+OEUQ+h0mMU+Rq6PhvP2xrNcbMwYxxWmVbPlrBHPdCOl+2+xU110ZhDqMtN4B
         hBNLu3aL9/t/mrFmF2DMtf+a7qyhEHH1BaP1wFsc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 22 Jan 2023 17:48:36 +0100
Subject: [PATCH 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v1-5-4049f565c24c@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UC4MZp7joZ5KIGVSNAjIE3z+woZwa8RY5kG95For80s=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWj2Melh4WgPgof4i5KIb9eQCvJo0gQAcgbgA6Ml
 Zfm8VqOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o9gAKCRBy2EO4nU3XVrm3EA
 C/KppKnzqSEjeDp67YBOnF3nRIdl7sMxjYsRfYN0kkt3dOtwmFkhbXoqplheSGGdjdIpOqWWYyu5p5
 vbabckzcp6SPm/XhlGBPFtq+diyApCW8CUx6JzsS0LhLEVrJpHH5+0gJeRaPQc/rVq8r+wld8x4y+h
 pT0kpn/f3SDYycRw0QwvY6poLHZxu6/BUx54rrKS5klUOuwUatphUBLHO2F9ms0EO5VHsHcoKj4e1S
 rwygzJH1uQnRN4Na6SK6VO9uO9aXcwd4tFqw1Fhrq2KVvpJvN/TmIaxfZBp5OcLEOiUWsYZzDzr8ud
 ie2j811S73Bs3yZdmGfkJUilDHOjJoQyqAcDQBQORrQ5EdldgFuEVHgxfRev8FMCgoMQTFIWunbq0u
 VM7ENcBQ7tBDlX95Ne7tMEUdMXsM/2obbPKYDKJRQ/4cJWbAlfSAVGIZP/TVPq6q+Yj6Bfnz8jcPyH
 3Hva2cUGoMKhrGv93G5Tolj7NLnNnF3JB2Aq9L2HZlZZhuvdBK/uETx96gAmpA/TBpp8HrM9iJZ5WU
 La9QVrfGOcypa7xbAFB/Ut49xBt3dfuQxRBwh7ppTrR8xRYf8OslVNoJNBnf/+TBQ01AmMF34JImMO
 8yDLkg4icyACHND+hdUkb2f6K6q0Q9mdcYQYnSnD44tTAsc0z81scOnc8ytw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node describing the sn3193 that's used to provide notification
LED.

Unfortunately the driver currently supports neither multicolor API nor
using the properties function & color, so we use label instead.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index ffb486ceb6a6..a672c45d7070 100644
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
