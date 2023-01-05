Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656E65EB17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjAEMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjAEMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:25 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921914C72E;
        Thu,  5 Jan 2023 04:51:22 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BF980420CF;
        Thu,  5 Jan 2023 17:33:56 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922037; bh=hh4JNQz29tUUJcJOb3jkHgRe0Gpymsou/pdkJ3B9+30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/MzpmVwjlNi9C36AuedP+/78tiPnHi2V2JxPt5m+9OQSftZAOKWO9x3qPztaHFEY
         P/s9txObvGo7uNmE6YgcxCzCUuE7cglCpZ2KbaytAHYbHTBJxxrFaiLnDLNBRBkQZr
         yRBL86Yn/pfjGuDTi8pelVlVg73DdUFJc1yN95atyn8VQmyhkBcJ9TzpBk3MUfsNAW
         YdbjqqUwr/oHUBkVuvUKjlcCHGgz/mXgNtXXOv+pCUuNPVYVm9YZWg4enPr75gBy6d
         KnMepgqxGR5Z7uZYGBKcQtAhyoNn9ClTQVZDztknKDDVsDlOyv6+41IFNIlVuTDl7Y
         zzQQYLMWw4NIQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 3/8] arm64: dts: qcom: msm8916-samsung-gt58: Add Vibrator
Date:   Thu,  5 Jan 2023 17:32:35 +0500
Message-Id: <20230105123240.1089375-4-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Manthan <siddharth.manthan@gmail.com>

Motor is powered by VPH_PWR (aka Vbat) and controlled by GPIO.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-samsung-gt58.dts     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 688e9be590ba..37140d041a22 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -8,4 +8,22 @@ / {
 	model = "Samsung Galaxy Tab A 8.0 (2015)";
 	compatible = "samsung,gt58", "qcom,msm8916";
 	chassis-type = "tablet";
+
+	vibrator {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&vibrator_en_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&msmgpio {
+	vibrator_en_default: vibrator-en-default-state {
+		pins = "gpio76";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
-- 
2.38.1

