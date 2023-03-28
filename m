Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141F26CC0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjC1NaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjC1N3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7AAD27;
        Tue, 28 Mar 2023 06:29:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTcdk082681;
        Tue, 28 Mar 2023 08:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010178;
        bh=iex5qyliMq2Kt/A4FkjflgasDUlNCyGEwIwcs3aI2A0=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=L5BC/RdIJ+IsOG4i41VFRKI5I0ohRl7o3dytozwyBnwksLNauBAaD1f3qFX/WHguZ
         bOcT/GAjORut0/mxlU+F2qYsSzNwZpvCV4+88YeTuJDN7at6ZdyJ53YwCmMySwen4i
         Zsrm3oIN/SULVpKk/a3UkzcoKA3gJOBpjnCu0Hio=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTcJu113914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTbJr122365;
        Tue, 28 Mar 2023 08:29:37 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Mar 2023 18:59:23 +0530
Subject: [PATCH v8 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v8-5-4408134eb2f3@ti.com>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=89iMQQ1UzhGpsP8Ub7JZE+Zeru9HloZUwbHrSaYxdwE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu5u2YFb4DZkiksybL+9twOtvWuKkVfrnIu8
 i7cKG0ItReJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLruQAKCRBD3pH5JJpx
 RQEWEADNob/dQDlWZURDtb0nPvQTFMNlyBF+VXUeu4PFS4FyesDKBCW9Wn1UjSEC4dnB1lDGYB3
 D6rDmjynw9CzFcDjWaK+BhDazgl5lrHEWRrhnfcfPbsaRJ9HKAi4ZMyAkbAhUjoZceuqELjoIJn
 utZRtF8oMYu8ckG2j5apRhYlaVArdUVz0LLv8fmIknvNlbNbUFaMJzbEzDAF3AsrlzkhsZ+Ct6n
 veTxfsXsX4DKpFb0g1GYsybv6qMx8jAABHlpCtFbuCt7g8KB9PDxheTdkiK0OKn/CYlbF4gBUP2
 6lg4hKYVGZ7rTICw4i/jhgblJQJK2hlR6SA1sXZfvJEXfD3hDvE+g1aS23JVc4dCIJKDnT6IwTD
 xzhzg8HmKcNHrfTQonm4yD4BCLE0Ya92RKqKBUmHwUBelcDY344WqbO+2WIe16oPrwTyK2N3vGw
 Kcl8n3ZmIzCJJ3LEN39/FHBUQPsewwWUpfsW75btF3LhUS9BfM/pA1/GwD9eScnus+TJWaoqww7
 uxXfxpVw0LBpa8fJiqdMjFlBaAeF0kwinK38iv8BC6839W9YtLjEsYDp9nhD3dj90n/hvKTEUaW
 O5NU+/OA61rpIAeCVLeO7qncR6IblWnQMQM2f84V2zAFowfB8B+Nm88XFXZPFO3BCCTVgjU4c1h
 03nv0Z+C6RUH0mg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
TPS22965DSGT which produces VCC_3V3_SYS. [1]

Link: https://www.ti.com/lit/zip/sprr459 [1]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f6a67f072dca..2296d656323c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -77,10 +77,10 @@ vcc_5v0: regulator-1 {
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: regulator-2 {
+	vcc_3v3_main: regulator-2 {
 		/* output of LM5141-Q1 */
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_sys";
+		regulator-name = "vcc_3v3_main";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vmain_pd>;
@@ -99,6 +99,17 @@ vdd_mmc1: regulator-3 {
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
 
+	vcc_3v3_sys: regulator-4 {
+		/* output of TPS222965DSGT */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";

-- 
2.40.0

