Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5F613278
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJaJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJaJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A8C3DF35;
        Mon, 31 Oct 2022 02:19:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5754823A;
        Mon, 31 Oct 2022 02:19:53 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD2403F703;
        Mon, 31 Oct 2022 02:19:44 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 06/20] arm64: dts: Update cache properties for exynos
Date:   Mon, 31 Oct 2022 10:19:45 +0100
Message-Id: <20221031091945.531874-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 ++
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index bd6a354b9cb5..e9eda46801f8 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -229,6 +229,7 @@ cluster_a57_l2: l2-cache0 {
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 		};
 
 		cluster_a53_l2: l2-cache1 {
@@ -236,6 +237,7 @@ cluster_a53_l2: l2-cache1 {
 			cache-size = <0x40000>;
 			cache-line-size = <64>;
 			cache-sets = <256>;
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 1cd771c90b47..aca1c32a6411 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -110,6 +110,7 @@ atlas_l2: l2-cache0 {
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

