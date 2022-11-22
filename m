Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E7634193
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiKVQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiKVQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:32:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93A31BCA6;
        Tue, 22 Nov 2022 08:32:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AAD23A;
        Tue, 22 Nov 2022 08:32:40 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3730B3F73D;
        Tue, 22 Nov 2022 08:32:32 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] arm: dts: Update cache properties for broadcom
Date:   Tue, 22 Nov 2022 17:32:06 +0100
Message-Id: <20221122163208.3810985-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122163208.3810985-1-pierre.gondois@arm.com>
References: <20221122163208.3810985-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DeviceTree Specification v0.3 specifies that the cache node
'compatible' and 'cache-level' properties are 'required'. Cf.
s3.8 Multi-level and Shared Cache Nodes
The 'cache-unified' property should be present if one of the
properties for unified cache is present ('cache-size', ...).

Update the Device Trees accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm/boot/dts/bcm2711.dtsi  | 1 +
 arch/arm/boot/dts/bcm2836.dtsi  | 1 +
 arch/arm/boot/dts/bcm2837.dtsi  | 1 +
 arch/arm/boot/dts/bcm47622.dtsi | 1 +
 arch/arm/boot/dts/bcm63148.dtsi | 1 +
 arch/arm/boot/dts/bcm63178.dtsi | 1 +
 arch/arm/boot/dts/bcm6756.dtsi  | 1 +
 arch/arm/boot/dts/bcm6846.dtsi  | 1 +
 arch/arm/boot/dts/bcm6855.dtsi  | 1 +
 arch/arm/boot/dts/bcm6878.dtsi  | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 941c4d16791b..c6104149f959 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -536,6 +536,7 @@ cpu3: cpu@3 {
 		 */
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>; // 1MiB(size)/64(line-size)=16384ways/16-way set
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 534dacfc4dd5..547ecc210f18 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -113,6 +113,7 @@ v7_cpu3: cpu@3 {
 		 */
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 5dbdebc46259..b352ac784af6 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -115,6 +115,7 @@ cpu3: cpu@3 {
 		 */
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>; // 512KiB(size)/64(line-size)=8192ways/16-way set
diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/bcm47622.dtsi
index 2df04528af82..f4b2db9bc4ab 100644
--- a/arch/arm/boot/dts/bcm47622.dtsi
+++ b/arch/arm/boot/dts/bcm47622.dtsi
@@ -51,6 +51,7 @@ CA7_3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm63148.dtsi b/arch/arm/boot/dts/bcm63148.dtsi
index df5307b6b3af..7cd55d64de71 100644
--- a/arch/arm/boot/dts/bcm63148.dtsi
+++ b/arch/arm/boot/dts/bcm63148.dtsi
@@ -35,6 +35,7 @@ B15_1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm63178.dtsi b/arch/arm/boot/dts/bcm63178.dtsi
index cbd094dde6d0..043e699cbc27 100644
--- a/arch/arm/boot/dts/bcm63178.dtsi
+++ b/arch/arm/boot/dts/bcm63178.dtsi
@@ -43,6 +43,7 @@ CA7_2: cpu@2 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6756.dtsi b/arch/arm/boot/dts/bcm6756.dtsi
index ce1b59faf800..5c72219bc194 100644
--- a/arch/arm/boot/dts/bcm6756.dtsi
+++ b/arch/arm/boot/dts/bcm6756.dtsi
@@ -51,6 +51,7 @@ CA7_3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6846.dtsi b/arch/arm/boot/dts/bcm6846.dtsi
index 8aa47a2583b2..81513a793815 100644
--- a/arch/arm/boot/dts/bcm6846.dtsi
+++ b/arch/arm/boot/dts/bcm6846.dtsi
@@ -35,6 +35,7 @@ CA7_1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6855.dtsi b/arch/arm/boot/dts/bcm6855.dtsi
index 620f51aee1a2..5fa5feac0e29 100644
--- a/arch/arm/boot/dts/bcm6855.dtsi
+++ b/arch/arm/boot/dts/bcm6855.dtsi
@@ -43,6 +43,7 @@ CA7_2: cpu@2 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6878.dtsi b/arch/arm/boot/dts/bcm6878.dtsi
index 1e8b5fa96c25..4ec836ac4baf 100644
--- a/arch/arm/boot/dts/bcm6878.dtsi
+++ b/arch/arm/boot/dts/bcm6878.dtsi
@@ -35,6 +35,7 @@ CA7_1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

