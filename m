Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509DB677F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjAWPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAWPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C40B14222
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so7127715wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLicMBPz2QmD+NF3CJ01wFNukXtqm1Jg3Rpya333xzY=;
        b=IuzulxMJSzSv/TlNHq566NFFlY0nB5Mm66mqKXvEfUurkYZuwUSJTncjog2AWkFf1t
         D2AWu3VXuWlot6LCTK9u9ZsDdH11WYgtXVjPIZ7IWD3DHqcKYVLXiXcCIIIrroOqjn4B
         AaSbrAfauhV6uuNLSa9rBcoUDhaXR0kjykoQeJ4VBh1hMFXusCjOhYfHXKLdPzL5K1uJ
         DPjOjIm8sqtjPU48bq8Two2zY/tjF9iCIHFhQ5FK5HjOJKraEiBLktwK31t6T39i4LHT
         Np7YXvpPtG98mpRM+4AsMnDmLEkX6WoomyNs+QEDVgfEQQp8aPS++b9Kl6Zg/NcJHMG0
         9UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLicMBPz2QmD+NF3CJ01wFNukXtqm1Jg3Rpya333xzY=;
        b=ndNfn/aGX6m9o4KyZZRAt4W9fZHVUqKzzaaYu6ug+bi0RDS2RurI9SRQPFbGWQRG1J
         FCV0PxtC6aTbCpmZNhBFxr43uuB3HQRKx7NH65APviNZtci+Amh+fn0oWz3p9vaJOxiV
         E3xGR7IZKItPP2sluUr9HQsK8473HYDs68iiqZu5D1ddq10DMaIEU5CWXjPfAZCyV2w1
         GcXkQoP5pymLsPAMHYlZesi/6Z+NEVSCDh7HRcSup88ogd7F4fW1mDCXfQLoqnvnZZB7
         7rFI0uTiyIOmMiAGNm2zcu3KiuL0ELkA9EIIBx0bzvuJVKCjgLTa9eN5VuhDR7oG3EWJ
         fN4w==
X-Gm-Message-State: AFqh2kp5ab8rKxPPDJIMIlBCuWPk1B69UVdux8DDJf8FthTJj+fEqMdn
        dWZpCCv1VNUHeEjX81u48iWnRg==
X-Google-Smtp-Source: AMrXdXssusvNRD8+ya9V38NZ3VXRd5jeX0LXFRjMTwtjHxrGNxrhPfkDOp1DPCLz3V7Qiz6Fhcw3rQ==
X-Received: by 2002:adf:dc81:0:b0:2a1:328f:23aa with SMTP id r1-20020adfdc81000000b002a1328f23aamr22075103wrj.6.1674486938975;
        Mon, 23 Jan 2023 07:15:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002423620d356sm22422468wrr.35.2023.01.23.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: dm814x: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:36 +0100
Message-Id: <20230123151536.369623-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/dm814x.dtsi | 6 +++---
 arch/arm/boot/dts/dm816x.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 8104969c67c1..a8cd724ce4bc 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -333,7 +333,7 @@ timer1: timer@0 {
 				};
 			};
 
-			uart1: uart@20000 {
+			uart1: serial@20000 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart1";
 				reg = <0x20000 0x2000>;
@@ -343,7 +343,7 @@ uart1: uart@20000 {
 				dma-names = "tx", "rx";
 			};
 
-			uart2: uart@22000 {
+			uart2: serial@22000 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart2";
 				reg = <0x22000 0x2000>;
@@ -353,7 +353,7 @@ uart2: uart@22000 {
 				dma-names = "tx", "rx";
 			};
 
-			uart3: uart@24000 {
+			uart3: serial@24000 {
 				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart3";
 				reg = <0x24000 0x2000>;
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 649b33194455..b68686f0643b 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -522,7 +522,7 @@ timer7: timer@4804a000 {
 			ti,timer-pwm;
 		};
 
-		uart1: uart@48020000 {
+		uart1: serial@48020000 {
 			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			reg = <0x48020000 0x2000>;
@@ -532,7 +532,7 @@ uart1: uart@48020000 {
 			dma-names = "tx", "rx";
 		};
 
-		uart2: uart@48022000 {
+		uart2: serial@48022000 {
 			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			reg = <0x48022000 0x2000>;
@@ -542,7 +542,7 @@ uart2: uart@48022000 {
 			dma-names = "tx", "rx";
 		};
 
-		uart3: uart@48024000 {
+		uart3: serial@48024000 {
 			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			reg = <0x48024000 0x2000>;
-- 
2.34.1

