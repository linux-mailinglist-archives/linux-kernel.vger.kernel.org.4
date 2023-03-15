Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AF6BAB87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCOJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCOJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:04:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF76F629;
        Wed, 15 Mar 2023 02:03:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F93kik130753;
        Wed, 15 Mar 2023 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678871026;
        bh=Cm4fxL8aqP+M/xiJppfBdfZbTdZp5e43WLIPjo0QZ38=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Lu3X/WYKAxGVJpNoggdDp5dyDNBAEprOCGYqJCdQgr98DPXetOhEpG2CMreYee0Mb
         pVCJkSzrx4HLlIX5Trc9ca1M/u+vEQBUOVyPWie6B3Et3ZEX1C3B30ZZYkKkMqab/9
         FInvriATfY5/jIaSQ4M3ZWLHdJZhC3OsG/dRiLMQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F93kv3089844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 04:03:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 04:03:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 04:03:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F93jDM037463;
        Wed, 15 Mar 2023 04:03:45 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v6 5/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
Date:   Wed, 15 Mar 2023 14:33:34 +0530
Message-ID: <20230313-mcasp_upstream-v6-5-77685d7cbeb8@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
References: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=8FGf5SMnjUpyVTelFPfg4Qsiky79X6LMQvgpym9Ks7E=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkEYdavNSNzkAJkgXnlueUkK7nt9SZ1rJC40ETm
 Zoi/bH+nYGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZBGHWgAKCRBD3pH5JJpx
 RQCND/9rq/O3t3MD05JrxNfuUkO7AtEUmYx2M83XuSo0yOpncXAgz+5QE5eA3JT3kBCnOcy33lV
 vtyouIHBxT26S2HSosOyymzAAfwTl9fm/hCK1skMwXBmjD4rbWrRsICwcWZGvZtI9LzKe0N432D
 2Lrp7LUR+rsD4IaE4U5T1S/QmG/K9aPafTclIDvnzKUImyB5iD+zENcBE3y0mVR7JPIGavOigDL
 0zr3xKstM0ZQUHeYWobSBiSzq/ecBNvgh6PZygJmn9uYsNwQYEH43QEs2XDA78urMg2IvctGM50
 G30YsLQeftGkME/Ev/2VVZ8dQKdkXud21jk7D4hHw8ZhTOc/oq0Qe9zMn6z4Fmfx3Bj3oJlPkKp
 nJySxZLefDn9x3zG1WEOkWmSfyl7p91Z36Fs4MqTxfRZdwt2RTZvv5K8LwkQ9oVLLbddO/6Sji+
 8XFs0gCkEKAiiQ2EB89jiKvdu/ZwS3wEHeCzmPR4fjekPALCLNIAbRdLicoAoJRazgkmP93mfhj
 7122tmoMIZBMXoO8TJIFOFvcNGmQrujS4KlLuzr4wRYiiYcxsBBBNWrTxykwrh2yC/GDX92W52C
 pwOAUzCIGEsetN5Nrcu0IXXnX1P2g2XSqHGxyEi2FzXe9WK0NCjoQUngrkDezTg8UoTToOQQVhC
 tqGLh5gpmhl5xvg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
TPS22965DSGT which produces VCC_3V3_SYS.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 5c9012141ee2..063e69e45163 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -76,10 +76,10 @@ vcc_5v0: regulator-1 {
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
@@ -98,6 +98,17 @@ vdd_mmc1: regulator-3 {
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
2.39.2
