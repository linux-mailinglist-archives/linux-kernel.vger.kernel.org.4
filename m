Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F14D67E167
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjA0KSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjA0KSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDF84B61
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n7so4516398wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jL0FZcy9RLXnW+Ky130Eubu6yugagq/se+N+DnISXUM=;
        b=Nmm4rIvWPyy4wCHQpnUrrN8TJCQlfKG8jECEtBEOGN1IqHzFoi7KKe0oTgDE+rQqnQ
         rKXlkM9uR+qlwy10r6ZBAg4OcPFTquZK1EH/sHzFjgtGL8dXwGLm462kcF+CcN6uWbXj
         9yeHGOLriW1sIwEs2RkarMaOLwSj2fMV5H+fvng6c04BOT5wZzRto+ZnWczoWg4Jamju
         8JDYxIKG96sGuqtPlZU6rsGT961bDyR7UnHY1285+mq2i/Z5PPJDSMASn9O3HJ72aifF
         ngv9vn29Xyrf1sMOiKff/llAny0Y4RMkDGQcZi88x5TekOm/6j5GsPJVOxqj7hvU5sxe
         R9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL0FZcy9RLXnW+Ky130Eubu6yugagq/se+N+DnISXUM=;
        b=LWqu4bOaW3fJ/mWUSOFIpGFAsrxZPsOLPElLtemJfwb2Ziulzi1bS2C8fAO3HL4Sm+
         3Ba9s5G0aFl6QU7rNPkvkNrnUsSHJeeudXpSj0hxPeH9IiHIzW/Zu11/lrQg8eDxvup8
         mFNyT8BIF0Tl4xxGyB4P8pUU9h/99R5WB//HzP0drIQJr67ZZuiVJpLN68HtAut5BM1Y
         sn/0oItQNVVat7kgC6Ak1tEC8BZTOyxwoluw+gi2SUCDpP32dtuzB9quKJySLjnQDwLP
         xtSFg7CUmdZbdrIgz5u91O24bTWWLwKTcB7/c06RV0QnqEi4kXVYbNi/30MSDpFX1DtL
         v2uA==
X-Gm-Message-State: AO0yUKWu6okpV96xVvR/EjqI1vAcRT/QFP52+PvRMBlLnNI94AO/DgiV
        k54zH6CoR+cvYQlrRHIeFDlPEQ==
X-Google-Smtp-Source: AK7set8/ugGmEMA8fy/t3/CVMvqAr1/R23U9tF+l5pjLJPhsSdDtmGwM2MpZJB53vbFag93P9JY5jQ==
X-Received: by 2002:adf:b351:0:b0:2bf:ae4b:4cbf with SMTP id k17-20020adfb351000000b002bfae4b4cbfmr11058330wrd.55.1674814716111;
        Fri, 27 Jan 2023 02:18:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d7-20020a056000114700b00241fab5a296sm3555031wrx.40.2023.01.27.02.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: hisilicon: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:34 +0100
Message-Id: <20230127101834.93818-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/hi3620-hi4511.dts | 12 ++++++------
 arch/arm/boot/dts/hip04-d01.dts     |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
index ce356c469e1e..d7f5daecc9dc 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -24,42 +24,42 @@ memory@40000000 {
 
 	amba-bus {
 		dual_timer0: dual_timer@800000 {
-			status = "ok";
+			status = "okay";
 		};
 
 		uart0: serial@b00000 {	/* console */
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
 			pinctrl-1 = <&uart0_pmx_idle &uart0_cfg_idle>;
-			status = "ok";
+			status = "okay";
 		};
 
 		uart1: serial@b01000 { /* modem */
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
 			pinctrl-1 = <&uart1_pmx_idle &uart1_cfg_idle>;
-			status = "ok";
+			status = "okay";
 		};
 
 		uart2: serial@b02000 { /* audience */
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
 			pinctrl-1 = <&uart2_pmx_idle &uart2_cfg_idle>;
-			status = "ok";
+			status = "okay";
 		};
 
 		uart3: serial@b03000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
 			pinctrl-1 = <&uart3_pmx_idle &uart3_cfg_idle>;
-			status = "ok";
+			status = "okay";
 		};
 
 		uart4: serial@b04000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
 			pinctrl-1 = <&uart4_pmx_idle &uart4_cfg_func>;
-			status = "ok";
+			status = "okay";
 		};
 
 		pmx0: pinmux@803000 {
diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
index f5691dbc26d2..0210064bf6a5 100644
--- a/arch/arm/boot/dts/hip04-d01.dts
+++ b/arch/arm/boot/dts/hip04-d01.dts
@@ -23,7 +23,7 @@ memory@0,10000000 {
 
 	soc {
 		uart0: serial@4007000 {
-			status = "ok";
+			status = "okay";
 		};
 	};
 };
-- 
2.34.1

