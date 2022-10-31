Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C937061326A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJaJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJaJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DDDBD2F6;
        Mon, 31 Oct 2022 02:19:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 921DA1FB;
        Mon, 31 Oct 2022 02:19:20 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 160823F703;
        Mon, 31 Oct 2022 02:19:11 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 01/20] arm64: dts: Update cache properties for amd
Date:   Mon, 31 Oct 2022 10:19:03 +0100
Message-Id: <20221031091903.531009-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
index 93688a0b6820..9f2d983e082d 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
@@ -163,38 +163,47 @@ CPU7: cpu@301 {
 	};
 
 	L2_0: l2-cache0 {
+		compatible = "cache";
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
 		cache-unified;
+		cache-level = <2>;
 		next-level-cache = <&L3>;
 	};
 
 	L2_1: l2-cache1 {
+		compatible = "cache";
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
 		cache-unified;
+		cache-level = <2>;
 		next-level-cache = <&L3>;
 	};
 
 	L2_2: l2-cache2 {
+		compatible = "cache";
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
 		cache-unified;
+		cache-level = <2>;
 		next-level-cache = <&L3>;
 	};
 
 	L2_3: l2-cache3 {
+		compatible = "cache";
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
 		cache-unified;
+		cache-level = <2>;
 		next-level-cache = <&L3>;
 	};
 
 	L3: l3-cache {
+		compatible = "cache";
 		cache-level = <3>;
 		cache-size = <0x800000>;
 		cache-line-size = <64>;
-- 
2.25.1

