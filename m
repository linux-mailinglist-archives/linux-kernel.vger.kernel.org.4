Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E106998F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjBPPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBPPeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:34:10 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7613D4F;
        Thu, 16 Feb 2023 07:34:07 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31GFXfov120311;
        Thu, 16 Feb 2023 09:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676561621;
        bh=u3jhDRVvhzaDvG3WrKImoKtXR1CDbSnJ2NhA4UTl/nk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q3xpZ/S6NPu09X8JQPxjkD1xxE9a9DkN7eLkYpt7CaIKd4+6Oe9uSweoryuEreqtX
         4Fxg1PfqYfWQ3DKaZF2Lp+XwpjGrSxzUuJioa421LrY/w9kVRp/LPMB5lS4O+Vj0az
         AGiqLEqjzfHy41WlDM3/JpfekfAyqytczvqK1CXs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31GFXfqt040321
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Feb 2023 09:33:41 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Feb 2023 09:33:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Feb 2023 09:33:41 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31GFXdce018680;
        Thu, 16 Feb 2023 09:33:40 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [RFC 1/2] ARM: dts: omap: Drop ti,omap36xx compatible
Date:   Thu, 16 Feb 2023 09:33:38 -0600
Message-ID: <20230216153339.19987-2-afd@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216153339.19987-1-afd@ti.com>
References: <20230216153339.19987-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was not matched anywhere and provides no additional information.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts              | 2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts               | 2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts               | 2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts               | 2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           | 2 +-
 arch/arm/boot/dts/omap3-n9.dts                     | 2 +-
 arch/arm/boot/dts/omap3-n950.dts                   | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    | 2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           | 2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts              | 2 +-
 arch/arm/boot/dts/omap3-sniper.dts                 | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 35eced6521efb..1a085bc013177 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
-	compatible = "ti,omap3-beagle-xm", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "ti,omap3-beagle-xm", "ti,omap3630", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 48e48b0c81901..e1b1a047f77a0 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "CompuLab CM-T3730";
-	compatible = "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap3";
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 9dca5bfc87ab2..eadb5b857f48b 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEPv2 Rev. F (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0020-rev-f", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0020-rev-f", "ti,omap3630", "ti,omap3";
 
 	/* Regulator to trigger the WL_EN signal of the Wifi module */
 	lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index c6f863bc03adf..3f0197ceae09e 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0020", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0020", "ti,omap3630", "ti,omap3";
 
 	vmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index 8e9c12cf51a7b..bc95a8df2e6a1 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEP COM MODULE Rev. G (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0030-rev-g", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0030-rev-g", "ti,omap3630", "ti,omap3";
 
 	/* Regulator to trigger the WL_EN signal of the Wifi module */
 	lbep5clwmc_wlen: regulator-lbep5clwmc-wlen {
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 5188f96f431e7..d36ceecb7328c 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0030", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "isee,omap3-igep0030", "ti,omap3630", "ti,omap3";
 
 	vmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-lilly-dbb056.dts b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
index ecb4ef738e07b..f6bbea2be54c5 100644
--- a/arch/arm/boot/dts/omap3-lilly-dbb056.dts
+++ b/arch/arm/boot/dts/omap3-lilly-dbb056.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "INCOstartec LILLY-DBB056 (DM3730)";
-	compatible = "incostartec,omap3-lilly-dbb056", "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "incostartec,omap3-lilly-dbb056", "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap3";
 };
 
 &twl {
diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index d211bcc311745..a3cf3f443785f 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Nokia N9";
-	compatible = "nokia,omap3-n9", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "nokia,omap3-n9", "ti,omap3630", "ti,omap3";
 };
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index b2f480022ff6e..cbaf79c4e8422 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Nokia N950";
-	compatible = "nokia,omap3-n950", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "nokia,omap3-n950", "ti,omap3630", "ti,omap3";
 
 	keys {
 		compatible = "gpio-keys";
diff --git a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
index 7f04dfad82034..3eb935df04dcc 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-alto35.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Alto35";
-	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-alto35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts b/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
index bc5a04e033362..3af8d10d72247 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Chestnut43";
-	compatible = "gumstix,omap3-overo-chestnut43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-chestnut43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts b/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
index 065c31cbf0e29..813e3c9fe3b64 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-gallop43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Gallop43";
-	compatible = "gumstix,omap3-overo-gallop43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-gallop43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts b/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
index e38c1c51392c5..8405bd9262de6 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-palo35.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo35";
-	compatible = "gumstix,omap3-overo-palo35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-palo35", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
index e6dc23159c4d9..b9558d736e795 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-palo43.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Palo43";
-	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-palo43", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-summit.dts b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
index 587c08ce282d3..fcfc449f2abea 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-summit.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-summit.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Summit";
-	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-summit", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
index f57de6010994e..6d14466c180af 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
@@ -14,6 +14,6 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on Tobi";
-	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
 
diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts b/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
index 281af6c113beb..bcf20ff3f2813 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "OMAP36xx/AM37xx/DM37xx Gumstix Overo on TobiDuo";
-	compatible = "gumstix,omap3-overo-tobiduo", "gumstix,omap3-overo", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "gumstix,omap3-overo-tobiduo", "gumstix,omap3-overo", "ti,omap3630", "ti,omap3";
 };
diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
index ea509956d7aca..c0252f8a798aa 100644
--- a/arch/arm/boot/dts/omap3-pandora-1ghz.dts
+++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
@@ -16,7 +16,7 @@
 / {
 	model = "Pandora Handheld Console 1GHz";
 
-	compatible = "openpandora,omap3-pandora-1ghz", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "openpandora,omap3-pandora-1ghz", "ti,omap3630", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index eb3893b9535e6..4c36bde62491d 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "CompuLab SBC-T3730 with CM-T3730";
-	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "compulab,omap3-sbc-t3730", "compulab,omap3-cm-t3730", "ti,omap3630", "ti,omap3";
 
 	aliases {
 		display0 = &dvi0;
diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index b6879cdc5c13e..0591af4941847 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "LG Optimus Black";
-	compatible = "lg,omap3-sniper", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "lg,omap3-sniper", "ti,omap3630", "ti,omap3";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index ce58b1f208e81..ab52e8d68f760 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "TI Zoom3";
-	compatible = "ti,omap3-zoom3", "ti,omap3630", "ti,omap36xx", "ti,omap3";
+	compatible = "ti,omap3-zoom3", "ti,omap3630", "ti,omap3";
 
 	cpus {
 		cpu@0 {
-- 
2.39.1

