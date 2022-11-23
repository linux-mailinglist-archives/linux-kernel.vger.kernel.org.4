Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B26353FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiKWJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiKWJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:01:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF6D4FFA97;
        Wed, 23 Nov 2022 01:01:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2960D23A;
        Wed, 23 Nov 2022 01:02:05 -0800 (PST)
Received: from pierre123.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0AB73F73B;
        Wed, 23 Nov 2022 01:01:55 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: Update cache properties for exynos
Date:   Wed, 23 Nov 2022 10:01:03 +0100
Message-Id: <20221123090109.74441-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123090109.74441-1-pierre.gondois@arm.com>
References: <20221123090109.74441-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index bd6a354b9cb5..8619920da4b6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -226,6 +226,8 @@ cpu7: cpu@3 {
 
 		cluster_a57_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
@@ -233,6 +235,8 @@ cluster_a57_l2: l2-cache0 {
 
 		cluster_a53_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x40000>;
 			cache-line-size = <64>;
 			cache-sets = <256>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 1cd771c90b47..f378d8629d88 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -107,6 +107,8 @@ cpu_atlas3: cpu@3 {
 
 		atlas_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
-- 
2.25.1

