Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E081A6EB404
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjDUV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjDUV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:57:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987F01FCB;
        Fri, 21 Apr 2023 14:57:01 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CAB2FCEB78;
        Fri, 21 Apr 2023 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682114189; bh=fk4m8YwqRaRJJmWRy3zDyiyWOrKUWffj2G1xoANhfek=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=fGAv2QOHd6hWFBl6xJfawnWE/UPOKCpuKX5gcfwScI+Yz/AFufTJ305XiDHTgGiay
         riHftwBU+KBomqLSn+/BrErwgJBdxbmrhzNx9+bdjG8zDroD+AwMiCwth0KPUErAV1
         ZllLtr1FOYwXrdr2Fy/pw2XDKwmqnGjwEEZTK7PQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 21 Apr 2023 23:56:22 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: pm8953: add GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-pm8953-gpio-v1-3-3d33e2de47e3@z3ntu.xyz>
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
In-Reply-To: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=fk4m8YwqRaRJJmWRy3zDyiyWOrKUWffj2G1xoANhfek=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQwaMImZ+W584Oat8uesHpge4QKk05bqMg1HV/
 z+ZSyaXgNuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEMGjAAKCRBy2EO4nU3X
 VklcD/9Jyz/pXTNAqmOjjsdKWA+5qsT5hUAerfmzpfKvCzI33ymSQXJ6aQE/9zbEMAHmGal0V/T
 sCfoMBK9PXW6KRAQavv29n3RLD/JoF3OZY5P9XBUFSKqjol6nA9mPuH2FpmCvRDdkN1V7SkIMEq
 F/p/D4kcXnOWcxvA0y8ZXqtMJNp3TZZTHD5cQ7500rDaM+fLEsanffxePZPe/Blo8qS2peqi3Wb
 ft+OsiuYnKv/6dsIkiK6V7JvVXCYwit8Mx3zb9VqOty8U0GNCny4+Sh5/gsyObC8CoRXB5r3QK4
 Xvm3VZZM3VL1WmECqpv7SiyQbqKruvK2JiOFXWlLVP0IjMRCIfDo4cbN5gmDNpuHTO95ZlLWi7D
 p3vbuMgIAGaJY4i06CFhozKErg/R1kYRnUT6wivuB/THbjeo6abwj7K41GaeN/vuv4L6AM5tMQH
 DWvcl6/OaVWchRt3VrA5nAyjvW3Antk4oDsJcvkTzq1d/45MiKTG5uqDuhYleHUOYH9SjnEDIoP
 qWivYDo3hntsaihZulcsS8wZUwDZesCv6Y40uMbxf7JpZtgBLFfevkouFQSf6IROd6XeDy1FFvv
 TEJZGZ3JYBn9WJewaTKhMXjGcSf4CtDiiRPt/yi38ZNXMea7/H4Ym/Ypcg7pVwgMyVE91ZyxLmC
 24vzPg+vNKxsrmA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the GPIOs found on the pm8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/pm8953.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index a1d36f9ebbd2..2268daf27fa7 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -79,6 +79,16 @@ rtc@6000 {
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
+
+		pm8953_gpios: gpio@c000 {
+			compatible = "qcom,pm8953-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8953_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pmic@1 {

-- 
2.40.0

