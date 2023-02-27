Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDA6A4B67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjB0ToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjB0ToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:44:04 -0500
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3D2448E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:43:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1677527032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFNXv49Gr4458wUoorl9fh1TIeOHEc9EHno2oprZQpY=;
        b=hFonr6R4dEWocYvjd5TYLtP/DyMOekuJW5ky8S1b7bjvRNFElKJxiUEgO2YDPTDLDMlK2A
        wmSHhH4rgAy50MkWh0np8kaNOTcH1whJGlHpfStaUMiNehIzwn09yriEb+jPUiqny5Mc0k
        0vSb6uIJAmcdW1mupquN5XblBqFyfBg=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: [PATCH v3 2/2] ARM: dts: exynos: add mmc aliases
Date:   Mon, 27 Feb 2023 20:38:19 +0100
Message-Id: <20230227193819.30133-3-henrik@grimler.se>
In-Reply-To: <20230227193819.30133-1-henrik@grimler.se>
References: <20230227193819.30133-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add aliases for eMMC, SD card and WiFi where applicable, so that
assigned mmc indeces are always the same.

Co-developed-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
[ Tested on exynos5800-peach-pi ]
Tested-by: Valentine Iourine <iourine@iourine.msk.su>
Signed-off-by: Henrik Grimler <henrik@grimler.se>
---

Changes since v2:
* Reword commit message
* Fix whitespace issues

 arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
 arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
 arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
 arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
 arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
 arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
 arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
 arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
 arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
 arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
 arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
 arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
 arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
 arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
 arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
 arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
 arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
 arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 4 ++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
 29 files changed, 123 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
index a1e22f630638..83266a66124b 100644
--- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
+++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
@@ -16,6 +16,11 @@ / {
 	model = "Samsung ARTIK5 evaluation board";
 	compatible = "samsung,artik5-eval", "samsung,artik5",
 			"samsung,exynos3250", "samsung,exynos3";
+
+	aliases {
+		mmc2 = &mshc_2;
+	};
+
 };
 
 &mshc_2 {
diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 794cbf579316..9cdcd8bf15ac 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -17,6 +17,11 @@
 / {
 	compatible = "samsung,artik5", "samsung,exynos3250", "samsung,exynos3";
 
+	aliases {
+		mmc0 = &mshc_0;
+		mmc1 = &mshc_1;
+	};
+
 	chosen {
 		stdout-path = &serial_2;
 	};
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 2aaeb6f8140b..9b71ba4e44d9 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -22,6 +22,7 @@ / {
 
 	aliases {
 		i2c7 = &i2c_max77836;
+		mmc0 = &mshc_0;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 199c9bffa84e..b392c32252bd 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -23,6 +23,8 @@ / {
 
 	aliases {
 		i2c7 = &i2c_max77836;
+		mmc0 = &mshc_0;
+		mmc1 = &mshc_1;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 69f538f79c65..86512e81dafe 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -25,6 +25,12 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc2 = &sdhci_2;
+		mmc3 = &sdhci_3;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 8ce648e1a7f1..044a8f279b3b 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -30,6 +30,11 @@ memory@40000000 {
 		       0x70000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 181c99eca675..cb74af41e17c 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -25,6 +25,10 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 88ca2ae405d6..73cb47e4474b 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -26,6 +26,12 @@ memory@40000000 {
 			0x70000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc2 = &sdhci_2;
+		mmc3 = &sdhci_3;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 2b8c4d6e77ca..b4ca08a0f700 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -24,6 +24,12 @@ memory@40000000 {
 			0x50000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc2 = &sdhci_2;
+		mmc3 = &sdhci_3;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 6ea44e57f216..eef8a2ea7bab 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -25,6 +25,9 @@ / {
 	aliases {
 		i2c11 = &i2c_max77693;
 		i2c12 = &i2c_max77693_fuel;
+		mmc0 = &mshc_0;
+		mmc2 = &sdhci_2;
+		mmc3 = &sdhci_3;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 1a8502d81274..8fac28c3943a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -13,6 +13,11 @@
 #include "exynos-mfc-reserved-memory.dtsi"
 
 / {
+	aliases {
+		mmc0 = &mshc_0;
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		stdout-path = &serial_1;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 878d7cf85f9d..fd3d02761cd2 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -25,6 +25,11 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &mshc_0;
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index e598f48b091a..a754c132e566 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -26,6 +26,12 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mshc_0;
+		mmc2 = &sdhci_2;
+		mmc3 = &sdhci_3;
+	};
+
 	chosen {
 		stdout-path = &serial_2;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index a40ff394977c..2d27bfab8ecd 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -22,6 +22,10 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index e0b6162d2e2a..3dac7fed96d7 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -17,6 +17,10 @@ / {
 	model = "FriendlyARM TINY4412 board based on Exynos4412";
 	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		mmc2 = &sdhci_2;
+	};
+
 	chosen {
 		stdout-path = &serial_0;
 	};
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 6f010e439141..d6139c8d43d8 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -23,6 +23,11 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index f7d4017e1ede..fea3959e5ed3 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index dea2dc818578..59b2cc35c37b 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -15,6 +15,9 @@
 / {
 	aliases {
 		i2c104 = &i2c_104;
+		mmc0 = &mmc_0; /* eMMC */
+		mmc1 = &mmc_2; /* SD */
+		mmc2 = &mmc_3; /* WiFi */
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 8980cdbdcb3b..c12bb17631b7 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -23,6 +23,11 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_1;
+	};
+
 	chosen {
 		bootargs = "console=tty1";
 		stdout-path = "serial3:115200n8";
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 7b1e414fb2a6..e092f406d99c 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -18,6 +18,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 0e14ce5c6ce3..05e9fbcd41d0 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -21,6 +21,8 @@ / {
 
 	aliases {
 		ethernet = &ethernet;
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index b4a74f9cf319..0f2a6a6be1d0 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -18,6 +18,11 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 5ed55a5b0c67..4b4c56ce3a5c 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -23,6 +23,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
index 6a51cb14b58a..f525b2f5e4e0 100644
--- a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
+++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
@@ -28,6 +28,11 @@ / {
 	 * for more details.
 	 */
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index df863b909ff7..7a48f2b32819 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -31,6 +31,9 @@ / {
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
 		i2c20 = &i2c_tunnel;
+		mmc0 = &mmc_0; /* eMMC */
+		mmc1 = &mmc_2; /* uSD */
+		mmc2 = &mmc_1; /* WiFi */
 	};
 
 	backlight: backlight {
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 0a9371bec3e0..e2493014cf8a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -21,6 +21,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		bootargs = "init=/linuxrc";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 30fc677d8bac..2f5b8602e020 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -19,6 +19,10 @@ memory@40000000 {
 		reg = <0x40000000 0x7ea00000>;
 	};
 
+	aliases {
+		mmc2 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 725c315d70cb..c583f232fae0 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -13,6 +13,10 @@
 #include "exynos5422-odroid-core.dtsi"
 
 / {
+	aliases {
+		mmc0 = &mmc_0;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 37af8fbd215c..1f544f12da6c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -29,6 +29,9 @@ / {
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
 		i2c20 = &i2c_tunnel;
+		mmc0 = &mmc_0; /* eMMC */
+		mmc1 = &mmc_2; /* SD */
+		mmc2 = &mmc_1; /* WiFi */
 	};
 
 	backlight: backlight {
-- 
2.30.2

