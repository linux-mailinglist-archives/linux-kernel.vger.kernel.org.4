Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313861327E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJaJUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJaJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:20:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32702DF62;
        Mon, 31 Oct 2022 02:20:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A9D1FB;
        Mon, 31 Oct 2022 02:20:13 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E6043F703;
        Mon, 31 Oct 2022 02:20:04 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 08/20] arm64: dts: Update cache properties for hisilicon
Date:   Mon, 31 Oct 2022 10:20:04 +0100
Message-Id: <20221031092004.532113-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  2 ++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi  |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi  |  4 ++++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi  | 16 ++++++++++++++++
 5 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8343d0cedde3..a57f35eb5ef6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -203,10 +203,12 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		A73_L2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index ae0a7cfeeb47..f6d3202b0d1a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -186,10 +186,12 @@ cpu7: cpu@103 {
 
 		CLUSTER0_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		CLUSTER1_L2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 7b2abd10d3d6..5b2b1bfd0d2a 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -211,18 +211,22 @@ cpu15: cpu@20303 {
 
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 2f8b03b0d365..291c2ee38288 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -211,18 +211,22 @@ cpu15: cpu@10303 {
 
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 1a16662f8867..b8746fb959b5 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -842,66 +842,82 @@ cpu63: cpu@70303 {
 
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster4_l2: l2-cache4 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster5_l2: l2-cache5 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster6_l2: l2-cache6 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster7_l2: l2-cache7 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster8_l2: l2-cache8 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster9_l2: l2-cache9 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster10_l2: l2-cache10 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster11_l2: l2-cache11 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster12_l2: l2-cache12 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster13_l2: l2-cache13 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster14_l2: l2-cache14 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster15_l2: l2-cache15 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

