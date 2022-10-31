Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467A613293
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJaJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJaJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:20:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A1CDF36;
        Mon, 31 Oct 2022 02:20:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9511FB;
        Mon, 31 Oct 2022 02:20:52 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEABE3F703;
        Mon, 31 Oct 2022 02:20:42 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 14/20] arm64: dts: Update cache properties for nvidia
Date:   Mon, 31 Oct 2022 10:20:41 +0100
Message-Id: <20221031092043.533238-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 10 ++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 30 ++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d0ed55e5c860..7508047e283b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2998,36 +2998,46 @@ core1 {
 		};
 
 		l2c_0: l2-cache0 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_1: l2-cache1 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_2: l2-cache2 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_3: l2-cache3 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l3c: l3-cache {
+			compatible = "cache";
 			cache-size = <4194304>;
 			cache-line-size = <64>;
+			cache-level = <3>;
 			cache-sets = <4096>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 724e87450605..9474b0da0a3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -2005,6 +2005,7 @@ CPU_SLEEP: cpu-sleep {
 
 		L2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..ca7a570c758b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1792,117 +1792,147 @@ core3 {
 		};
 
 		l2c0_0: l2-cache00 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_1: l2-cache01 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_2: l2-cache02 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_3: l2-cache03 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c1_0: l2-cache10 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_1: l2-cache11 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_2: l2-cache12 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_3: l2-cache13 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c2_0: l2-cache20 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_1: l2-cache21 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_2: l2-cache22 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_3: l2-cache23 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l3c0: l3-cache0 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c1: l3-cache1 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c2: l3-cache2 {
+			compatible = "cache";
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1

