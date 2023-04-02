Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DA6D388F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDBOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjDBOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:47:43 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201106E97;
        Sun,  2 Apr 2023 07:47:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1680446858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LxFOte+img0UFi7UGP+5QqnyCqfim/xcGn0o7qDeQM=;
        b=VKPP+6QbR42EJ9X1ZmEscwfb6ERfkZbYJ+rB03L+ukExjASx5Dd7ZAQotxNtmFtUblcsep
        3k+cE0DUQ/BoB0tspdw/+pmPXaOydzv2rDdCrsAZM+ItbFf+vo018P1pDVAHVIUAkEmJeI
        Im0JAoRHkzeA8D55xBqHw9EZHrJjK/g=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        replicant@osuosl.org
Cc:     Henrik Grimler <henrik@grimler.se>,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: [PATCH v7 2/2] ARM: dts: exynos: add mmc aliases
Date:   Sun,  2 Apr 2023 16:47:24 +0200
Message-Id: <20230402144724.17839-3-henrik@grimler.se>
In-Reply-To: <20230402144724.17839-1-henrik@grimler.se>
References: <20230402144724.17839-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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

Changes since v6:
* Fix syntax error in exynos5422-samsung-k3g.dts

Changes since v5:
* Make index numbering linear per default (that is, always use 0, 1, 2
  instead of for example 0, 2, 3) for devices where no documentation
  or schematics are available that use other numbering.
* Drop Marek's test tag since numbering has been updated
* Add mmc0 alias to exynos5422-samsung-k3g, was accidentally dropped in v5

Changes since v4:
* Do not set mmc-ddr-1_8v for sdhci_0 on Exynos 4210,
  following Marek's tests

Changes since v3:
* Drop attempt at node sorting/cleaning
* Move two mmc alias additions to the other patch
* Update commit message

Changes since v2:
* Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0

 arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 4 ++++
 arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
 arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
 arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
 arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
 arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
 arch/arm/boot/dts/exynos4412-itop-elite.dts         | 4 ++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi     | 4 ++++
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
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
 32 files changed, 134 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
index a1e22f630638..660cc7fac4db 100644
--- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
+++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
@@ -16,6 +16,10 @@ / {
 	model = "Samsung ARTIK5 evaluation board";
 	compatible = "samsung,artik5-eval", "samsung,artik5",
 			"samsung,exynos3250", "samsung,exynos3";
+
+	aliases {
+		mmc0 = &mshc_2;
+	};
 };
 
 &mshc_2 {
diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index b81e1a9df126..3fdd922e635c 100644
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
index 861c26824d4f..2de877d4ccc5 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -22,6 +22,7 @@ / {
 
 	aliases {
 		i2c7 = &i2c_max77836;
+		mmc0 = &mshc_0;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index a252a5f667eb..88fb3e68ff02 100644
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
index bba85011ecc9..37cd4dde53e4 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -25,6 +25,12 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc1 = &sdhci_2;
+		mmc2 = &sdhci_3;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 1103e7f92b57..f1927ca15e08 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -30,6 +30,11 @@ memory@40000000 {
 		       0x70000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc1 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 181c99eca675..b566f878ed84 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -25,6 +25,10 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index b8e9dd23fc51..ff6ee4b2c31b 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -26,6 +26,12 @@ memory@40000000 {
 			0x70000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc1 = &sdhci_2;
+		mmc2 = &sdhci_3;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 140abfb38e1d..8fe0d5d2be2d 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -24,6 +24,12 @@ memory@40000000 {
 			0x50000000 0x10000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_0;
+		mmc1 = &sdhci_2;
+		mmc2 = &sdhci_3;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 6260da187e92..ded232b04e0d 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -20,6 +20,10 @@ / {
 	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
 	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		mmc1 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
 		stdout-path = "serial2:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index ca8d42b2ce3b..7bc6968af9c3 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -23,6 +23,10 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &mshc_0;
+	};
+
 	firmware@203f000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x0203f000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 82aed59cba7c..e6b949c1a00f 100644
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
index 25e082fda955..45ef7b7ba7e0 100644
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
index f6cebf73b839..23b151645d66 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -25,6 +25,11 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &mshc_0;
+		mmc1 = &sdhci_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 9052b3ebb3e8..0b89d5682f85 100644
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
index a40ff394977c..715dfcba1417 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -22,6 +22,10 @@ memory@40000000 {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	aliases {
+		mmc0 = &sdhci_2;
+	};
+
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index e0b6162d2e2a..5a2dcdc5c28b 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -17,6 +17,10 @@ / {
 	model = "FriendlyARM TINY4412 board based on Exynos4412";
 	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
 
+	aliases {
+		mmc0 = &sdhci_2;
+	};
+
 	chosen {
 		stdout-path = &serial_0;
 	};
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 8f01337bb291..d586189966da 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -23,6 +23,11 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index f7d4017e1ede..bb623726ef1e 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
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
index 0fd728bc0b75..d072a7398866 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -18,6 +18,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 1ed73f3b4ac0..882fc77c4bc4 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -21,6 +21,8 @@ / {
 
 	aliases {
 		ethernet = &ethernet;
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index b4a74f9cf319..bb29b76f6f6a 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -18,6 +18,11 @@ memory@40000000 {
 		reg = <0x40000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 5ed55a5b0c67..809ddda02e53 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -23,6 +23,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
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
index 0a9371bec3e0..e299344e427a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -21,6 +21,11 @@ memory@20000000 {
 		reg = <0x20000000 0x80000000>;
 	};
 
+	aliases {
+		mmc0 = &mmc_0;
+		mmc1 = &mmc_2;
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
index d1b8e59e2daf..b4a851aa8881 100644
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
diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index 13134592c199..c35261a338ff 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -19,6 +19,10 @@ / {
 
 	chassis-type = "handset";
 
+	aliases {
+		mmc0 = &mmc_0;
+	};
+
 	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x80000000>; /* 2 GiB */
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

