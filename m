Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130764264A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLEKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLEKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:02:38 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29289C0F;
        Mon,  5 Dec 2022 02:02:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B18F041F72;
        Mon,  5 Dec 2022 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670234553; bh=lvzR71Puvwn8e/WO5N0bPNELgxMXJHRnFAET4OycXe0=;
        h=From:To:Cc:Subject:Date;
        b=W7qNzgkk5f+5BiUOeBCK5cb9Cub3n8+Nn8o2LPggIbCJv4RPuiQnBvmkjjfDptmUA
         ETNH+G6w6SoGy7XQMLEjewP7jbTYzXF9RdgM3LdH334GzNovNFFuzPz+eF7cWSbowz
         9sVZTR8U4HcrweUZ8a2ucAPfXG5SDMXvfOxitVaEIz4dhwjifpseM/5sgkxXH5Jebu
         mXVbG1tk7foSA6jgiXBpitCDkCInPVrmjZt9LmmnxoD3R+cOSlyYGP+LD/vhLuPP7r
         u16AaI6Acp16b9z122DQcw5mkneCDDYZwd68PjnxXa9+LN37qg4iU8wBr+Zet/WN7e
         ChObTU5QzgLpw==
From:   Hector Martin <marcan@marcan.st>
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] arm64: dts: apple: Rename dart-sio* to sio-dart*
Date:   Mon,  5 Dec 2022 19:02:11 +0900
Message-Id: <20221205100211.3155-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the other DARTs are named foo-dart, so let's keep things consistent.

Fixes: 51979fbb7fb8 ("arm64: dts: apple: t600x: Add MCA and its support")
Fixes: 8a3df85ad87d ("arm64: dts: apple: t8103: Add MCA and its support")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 6 +++---
 arch/arm64/boot/dts/apple/t8103.dtsi      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 0b8958a8db77..e2f972c2c147 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -53,7 +53,7 @@ wdt: watchdog@2922b0000 {
 		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	dart_sio_0: iommu@39b004000 {
+	sio_dart_0: iommu@39b004000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x3 0x9b004000 0x0 0x4000>;
 		interrupt-parent = <&aic>;
@@ -62,7 +62,7 @@ dart_sio_0: iommu@39b004000 {
 		power-domains = <&ps_sio_cpu>;
 	};
 
-	dart_sio_1: iommu@39b008000 {
+	sio_dart_1: iommu@39b008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x3 0x9b008000 0x0 0x8000>;
 		interrupt-parent = <&aic>;
@@ -179,7 +179,7 @@ admac: dma-controller@39b400000 {
 				      <&aic AIC_IRQ 0 1118 IRQ_TYPE_LEVEL_HIGH>,
 				      <0>,
 				      <0>;
-		iommus = <&dart_sio_0 2>, <&dart_sio_1 2>;
+		iommus = <&sio_dart_0 2>, <&sio_dart_1 2>;
 		power-domains = <&ps_sio_adma>;
 		resets = <&ps_audio_p>;
 	};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 6f5a2334e5b1..1ea760ef2c25 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -318,7 +318,7 @@ cpufreq_p: performance-controller@211e20000 {
 			#performance-domain-cells = <0>;
 		};
 
-		dart_sio: iommu@235004000 {
+		sio_dart: iommu@235004000 {
 			compatible = "apple,t8103-dart";
 			reg = <0x2 0x35004000 0x0 0x4000>;
 			interrupt-parent = <&aic>;
@@ -431,7 +431,7 @@ admac: dma-controller@238200000 {
 					      <0>,
 					      <0>;
 			#dma-cells = <1>;
-			iommus = <&dart_sio 2>;
+			iommus = <&sio_dart 2>;
 			power-domains = <&ps_sio_adma>;
 			resets = <&ps_audio_p>;
 		};
-- 
2.35.1

