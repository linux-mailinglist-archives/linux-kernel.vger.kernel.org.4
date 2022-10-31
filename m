Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD9613286
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJaJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJaJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:20:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01D4BDEE7;
        Mon, 31 Oct 2022 02:20:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16EA11FB;
        Mon, 31 Oct 2022 02:20:33 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A0E13F703;
        Mon, 31 Oct 2022 02:20:24 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 11/20] arm64: dts: Update cache properties for mediatek
Date:   Mon, 31 Oct 2022 10:20:25 +0100
Message-Id: <20221031092025.533051-1-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 3 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index cbae5a5ee4a0..9a20055ec1fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -159,16 +159,19 @@ core3 {
 
 		l2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l2_1: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l3_0: l3-cache {
 			compatible = "cache";
+			cache-level = <3>;
 		};
 
 		idle-states {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 066c14989708..2e73db4229d5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -197,16 +197,19 @@ cluster_off_b: cluster-off-b {
 
 		l2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l2_1: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 			next-level-cache = <&l3_0>;
 		};
 
 		l3_0: l3-cache {
 			compatible = "cache";
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1

