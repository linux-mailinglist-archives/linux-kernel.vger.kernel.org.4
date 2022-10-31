Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735E613298
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJaJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJaJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:21:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB33DEF1;
        Mon, 31 Oct 2022 02:20:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24869113E;
        Mon, 31 Oct 2022 02:21:05 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 915B03F703;
        Mon, 31 Oct 2022 02:20:56 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 16/20] arm64: dts: Update cache properties for realtek
Date:   Mon, 31 Oct 2022 10:20:57 +0100
Message-Id: <20221031092057.533368-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/realtek/rtd1293.dtsi | 1 +
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 1 +
 arch/arm64/boot/dts/realtek/rtd1296.dtsi | 1 +
 arch/arm64/boot/dts/realtek/rtd1395.dtsi | 1 +
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
index 2d92b56ac94d..0696b99fc40d 100644
--- a/arch/arm64/boot/dts/realtek/rtd1293.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
@@ -30,6 +30,7 @@ cpu1: cpu@1 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 1402abe80ea1..4ca322e420e6 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -44,6 +44,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
index fb864a139c97..03fccd48f0c0 100644
--- a/arch/arm64/boot/dts/realtek/rtd1296.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
@@ -44,6 +44,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1395.dtsi b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
index 05c9216a87ee..94c0a8cf4953 100644
--- a/arch/arm64/boot/dts/realtek/rtd1395.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
@@ -44,6 +44,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index afba5f04c8ec..2ee9ba1ecdc1 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -87,12 +87,14 @@ cpu5: cpu@500 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 			next-level-cache = <&l3>;
 
 		};
 
 		l3: l3-cache {
 			compatible = "cache";
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1

