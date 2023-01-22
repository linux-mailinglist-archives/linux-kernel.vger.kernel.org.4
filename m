Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B86770C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjAVQtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAVQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:39 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F94D7D93;
        Sun, 22 Jan 2023 08:49:27 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A0B0FCD17F;
        Sun, 22 Jan 2023 16:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406135; bh=hkk3joZ0mTC0UcwxuuHdlSXDDx0OPBvCwaw8zRjJjaU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=CSP84unqgU3MNiA4kMM1RnRhf7wVjOYOC/6RcN9qrJfRdGVeeiKP/o+JrQP3Tm5B6
         xtUOm7HBJ9UsHzGUFvdl72+Z1WVMf+jZ2k9/B4+JSIRX9wPZgSQy4KFDKVlFgGNMc/
         aSxuxnOVHVog0yovNyl/y1ZnlhQ1WxcAGDY5FUMQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 22 Jan 2023 17:48:32 +0100
Subject: [PATCH 1/5] ARM: dts: qcom: pm8941: Add vibrator node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v1-1-4049f565c24c@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=hkk3joZ0mTC0UcwxuuHdlSXDDx0OPBvCwaw8zRjJjaU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWjyA2uq3IAKgtXVZ+hXAHDmyTJuKDODtcN1ynjz
 IxxQqyCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o8gAKCRBy2EO4nU3XVpVjD/
 9PQLiq2tz2CpOqjGEKldludYM3tJ/avYS7mRo5d0XOPn8cZYuASTdJCxRbN2e/rQrb5rBWNROLaTxB
 e5CRmB2BH7kDLHjefoYUeGA21/+GyyC2+DsHc/UuWF6vC6JmjRnRRTM9IYq15ud8yihbmeu+6C8Zsm
 FGizuTNE1wdxNFeosN5iOlke3pdDGKj6p+deinSQ2HRXaS+LBV7V4Yxb1XJ7h5XdJSiX0kUdVCMR3u
 WPNfYl69sJhyANLn401J8Y/b0qRMuz3LUMM4k0UXs/tUr3hGzrWNZQP/Ru/tnKdC/3SGgZnL/EZXdH
 T1fU32jTjyOmr9z9Ge39Fy6gT65eVTdgcozdk83nl7xQewgbvdIlLAVeukkjOCaGj/WNNWdE/29egS
 NzNPjfTE7IHGylI1gnPVAnVfokMFmn8luO0A2eFrHbkSKCNp/tv0+kAJAx6KsHPXv7AuoA/uVqsz3I
 B6hXFUeIL9/9mxl7RcwskoQH+9jxL2qHjwf5ETxpGxNKitFPzLs7yy7cKgL3nyhXssWvvDgJGcdhRr
 ut3JvL5VeaqEp/woRyxYcb7z0l7nRrT9ZxKNQasDeL92GS/tch7OmzSpkgOH6Osk3DbeK0OQkGu07o
 svQehs3qqEnnE3U2MIMKk0mNhlmgZOSB14EqtT3IemyhzD2e/fZiqSXg6yPQ==
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

Add the node describing the vibrator that's found on pm8941.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index cd957a1e7cdf..a821f0368a28 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -161,6 +161,12 @@ pm8941_lpg: pwm {
 			status = "disabled";
 		};
 
+		pm8941_vib: vibrator@c000 {
+			compatible = "qcom,pm8916-vib";
+			reg = <0xc000>;
+			status = "disabled";
+		};
+
 		pm8941_wled: wled@d800 {
 			compatible = "qcom,pm8941-wled";
 			reg = <0xd800>;

-- 
2.39.1
