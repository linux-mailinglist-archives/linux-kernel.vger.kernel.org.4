Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFDE68C7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBFUko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBFUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:40:35 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938713AA3;
        Mon,  6 Feb 2023 12:40:34 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E3C73D1D69;
        Mon,  6 Feb 2023 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675716033; bh=4pVRIq9TxlreCENfNiVq+7cFfOavDFW8QxpNnrRtgu4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=lBxzrB03zi298/xWdk5y5Ql6MAUn5nHh8BFJhHeGHPMdkvbBp5Hb3UtxQkiHoPnLz
         sCxOaQ09JxZ3BC5kdm3z4nhfjCZC9vPHkvHMT3sdhOf8rGFqiLuJticnsHk3kn/vFN
         iWWWs9YZcyYI4aY7p/7bj0Y9Y5OMfm79aOO9A4gA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 06 Feb 2023 21:40:17 +0100
Subject: [PATCH v2 4/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add
 backlight
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v2-4-06bb83c20a58@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4pVRIq9TxlreCENfNiVq+7cFfOavDFW8QxpNnrRtgu4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj4WW9CZ3vxbRhBDMlt7USEpsJjQ7cXQOB0IxqW
 LaHlcTC4GeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+FlvQAKCRBy2EO4nU3X
 VpUTD/oCMFxSflnFAHiJsu9jNF9MU/sY7zNTEibALm3caHcx9yFX16GE1DP+rPpKOVRNDq7B0G0
 U/XP/7NJDsZaJQCpSEuvYCrjYkbm/9arq5aJ1ql3y0UZDWZu+kX8hTj5NPG1QHy74uhjlwUI3mm
 595zcIh1daKlcQVHrfeHRWp0vGICtKo4Dnhzdy7meUgDl5Toeb9Qt1DgZk74LukWS0X70/1L3HH
 QzV8+x4aSfSHd6PJVRuTZmS1Luvtbr37JskaCfo8B91N6BKbbSuoxVN6cGoMMrM+i09TEg52V3w
 cO0HTfuqKrUpdb0nqCNMVkewNPJmXCki8ZE4G5nzz6DCxBnLCg2IsYvnlX2CYt87GqeiilXeZEo
 Azx++JPFl04Gy/yiQI31n2TCR8f5fUa4upW2hNICy0whS95bikxFqit+xONUlb0YhD8lGaZmVNX
 PTnHnabkIUXx56bLQ5WiMzoUNfVVBZH6StKjQOcG8A4aqI9XlQIHgCgTWVgW3JUKH6Pd6oVN2/c
 plHUher8qg5fBUTiKHLTNrNR7o0vFLPdW4+iWf1rLkiwSF6SFl6V+wJgfpiwn/RRzxcO3hOlOYj
 0JWp/bRPcf7VtDQdvpVX8yqKfC84rOr2EWeM/HlV0//DA2VLTCR8dRXKPcvYuPn/zZdTVVeYv2U
 hAfGph6Wvdp2HaQ==
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

Add the node for the lm3630 that is used to control backlight.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index c4c355533149..a4b5d680c097 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -99,6 +99,21 @@ rmi4-f12@12 {
 			syna,clip-y-high = <1920>;
 		};
 	};
+
+	led-controller@36 {
+		compatible = "ti,lm3630a";
+		reg = <0x36>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0 1>;
+			label = "lcd-backlight";
+			default-brightness = <80>;
+		};
+	};
 };
 
 &blsp1_i2c6 {

-- 
2.39.1

