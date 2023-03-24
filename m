Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24616C7A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjCXIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjCXIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4C1CBF2;
        Fri, 24 Mar 2023 01:55:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tSQ2109226;
        Fri, 24 Mar 2023 03:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679648128;
        bh=iex5qyliMq2Kt/A4FkjflgasDUlNCyGEwIwcs3aI2A0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VtllT93aQuIB/+kKofQdQpZAJ9cbQhcJS/h48E0X5tU/d2fanG17m18nmkKy8Pc1P
         4V8KXDII6TJq2o1Ll+Axf4jGHLZH6N+QGi/hKFwH+QEIIIs/07qAxmfnJp9EjtPOJm
         p08oRKxL5uu23c26VIZh7FzayPChL+5wllR3sHEI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8tS9j009032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:55:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:55:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:55:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tR7w049526;
        Fri, 24 Mar 2023 03:55:27 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v7 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
Date:   Fri, 24 Mar 2023 14:25:19 +0530
Message-ID: <20230313-mcasp_upstream-v7-5-88168d0df9b8@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
References: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=89iMQQ1UzhGpsP8Ub7JZE+Zeru9HloZUwbHrSaYxdwE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWSJ+0wvbsSLXIYgJpleGOcV9B2CgUJ5UxPb5
 nqtZv21CtCJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1kiQAKCRBD3pH5JJpx
 RWIoEACGWTL2bOtTS/k2p/K3I8dLcnEShGKI4sHyZUUWNaAQUVOuBS+XuVEB7QHs1Z72MYt24WF
 dK7zCYJlDi770dfjCYknaNDbSuLah53CiiMuPi6gNz08VWspwVjIrBszPdUIi1nsJlYE8OYe2cH
 mWNDw5t9r7F+crxM0gKRPyRj2w9UmnxvtsEAtv77yl/j//uyh6fxPpZE70cnU7AbUAcr/23QftF
 cruendclHoraLU4S2/8gQZXV4JtBdpiWKgLnS0I/Hw3qMWZuA39uj/KRTAXDgsST0Gb8S1FVqqN
 QLdkLrfih77gGyCnpq2gE5Ru0kulL4Z9/Lk//RCUkQzCeto375oxL5YvcfpKi/qXR3n8s9cl2lZ
 APAaNHCwoq2NKRBGwWYQgNF2kgYPVnbffVJFug3pBlT/IcIgyRqd0pF3nIY2lMPobEHtVH3tlav
 TEko6QmNMe3/JUktHe2A/0QbK0YdH/XzMsmyM9Mshgnv7yYf38oddt7frgQ9DxBxktKrqHY/5qO
 lZNHpf8INVXQzr81CoonaR87v1Y0dLBhhe4sAQRGu3DehJeKPksYNs5SHsA6t7dTHZyuWR2N12B
 bGrWRq7e4RGuZxrfH84tp0LHYGE73X4luBHNw+Njrfau54N/HPi7tJ+b55hwRxSK5daV3EsMWL/
 NlJZIVNsQFOO8FA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
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

