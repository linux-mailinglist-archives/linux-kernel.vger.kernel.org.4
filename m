Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB01613284
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJaJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJaJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:20:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC095DEE1;
        Mon, 31 Oct 2022 02:20:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF5E723A;
        Mon, 31 Oct 2022 02:20:27 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF00E3F703;
        Mon, 31 Oct 2022 02:20:18 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/20] arm64: dts: Update cache properties for marvell
Date:   Mon, 31 Oct 2022 10:20:16 +0100
Message-Id: <20221031092020.532456-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
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

The recently added init_of_cache_level() function checks
these properties. Add them if missing.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi      | 1 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 2 ++
 arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index 80b44c7df56a..d4770acec6ac 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -49,6 +49,7 @@ cpu1: cpu@1 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
index fcab5173fe67..990f70303fe6 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
@@ -51,6 +51,7 @@ l2: l2-cache {
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 3db427122f9e..a7b8e001cc9c 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -81,6 +81,7 @@ l2_0: l2-cache0 {
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 		};
 
 		l2_1: l2-cache1 {
@@ -88,6 +89,7 @@ l2_1: l2-cache1 {
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
index 68782f161f12..7740098fd108 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
@@ -81,6 +81,7 @@ l2_0: l2-cache0 {
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 		};
 
 		l2_1: l2-cache1 {
@@ -88,6 +89,7 @@ l2_1: l2-cache1 {
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 		};
 	};
 };
-- 
2.25.1

