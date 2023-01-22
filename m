Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622C6770C5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAVQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAVQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A69760;
        Sun, 22 Jan 2023 08:48:57 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6DC1FCD52C;
        Sun, 22 Jan 2023 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406136; bh=DqwruzUCCJYrcCYrda9C8IRCq0DuKHje6Db9P9sSPWA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=apDm9kJczk72vAZhzkclWOjco7iqsaQFsWWCWFewAiCQL+Lf2FLO041tB23e/+YOE
         vWoc+BJrsa2RA7Dv+NIKLyjfwtVaNMJXe2LrnoLAdHKOnesXW8FUntYNGrlmE/hGJu
         YE0MUzL/EeznRRh9HpFI98DzdreMveK+N974DfuU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 22 Jan 2023 17:48:35 +0100
Subject: [PATCH 4/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add backlight
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v1-4-4049f565c24c@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=DqwruzUCCJYrcCYrda9C8IRCq0DuKHje6Db9P9sSPWA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWj1i8z82nJDQrfm2hIadOFkbhNiX190iIzC7etK
 eyh72iWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o9QAKCRBy2EO4nU3XVmDyEA
 C7xFrBO3XCd0ZelVBBxSBpWUCRsEHsLTrXeEyQyq5A+AMJq3YRdz1VWxdcFkTj+rbx77mrylJUgkan
 CXgC5camIKX8oOZhq0IxpGzsfYjm6L6hLyedXwP7zCCrPulwapgtbbHJJTX2MwmNcZbcw6dc88zaNw
 +iQ5MAI3DAYz0asSSrY0iaQgtV/LqcvsXPMY8iWJ4uFap+sONDBnDtu957Z5zL1dhyYuSHKOgOPqan
 c7jJOYccrAQMb4jT3snVUvuHEE9+FQPqVvTo1+nLcjl9hSOqt1NTMwfAM8da1y80SlGxeTmDnJuxP5
 m84ipe/SqSGbREePu1wqEAiM8DpbCB1HzY+emCMiyfNq5aRik4ATAwSYMDYTBc4zyA1a4uX/9zlzRT
 g4i8DFfj1ipXLz43fenCC2vaaClKlo8+9l8XZCHdx0Kxu2afbiY6SuccwNomsIX2mFDDjiZZ90lMVu
 UqZQIosb2Qwz7WgUy/IUZwffkRku3vC0iLTM9oQHW30eTCp/1yDWdpZETsWTyStzUjJThz7cnqDnAg
 RelIVrOdwzFrxbvrqnAWCXjUVmIhwGUvMZopxvJxJ8VS2jyS9m2KE6R9YOIyn5ZP1Xfjhv+5Eqn11K
 /kBvrXwpMcOlLHJlo/XEnkqRFrOkXdWprzvuYI9HsM+UTezVFH3mU1Zw6guA==
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

Add the node for the lm3630 that is used to control backlight.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index 10ba3c94e26d..ffb486ceb6a6 100644
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
