Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE8742CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjF2TBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjF2TBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2255130C5;
        Thu, 29 Jun 2023 12:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A832C61575;
        Thu, 29 Jun 2023 19:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0601C433C0;
        Thu, 29 Jun 2023 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065268;
        bh=t6tJ/Q1fOcgaFAQAESAkuZw1gOKfqYq6LvhpMuTlPOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxcue+TP9Ie9bp1+ALdgLFrk1KSP+vS26Drk6JloulKhXPQCt66ziolzDJzgcBBjl
         P6DyL6lCR57euOKg0YBdeyORDGKkTk2H/HenTmxNKt7fToFa0TbjODWoKGpwWkpXAw
         T1+CBwWpQOTnWtki9+SeHUbrge6sointOjr8NpTX/3RUEtEBcaVbXkAN9JDAO7KGZ/
         FPrVt+WOZh8XoJyoerikpU6SwHPnkxqyRitooSyDAYC1ozEMS9H61calTfdTWSvfoe
         Qa2Q9s0BBUgjRK7C+u9EWLbmV2PI6GKIH5mpD9wmc1VMYdYsqLj9lyeqO0ZzCQ+Y7u
         tXNDHbr/MQoqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        pierre.gondois@arm.com, clabbe@baylibre.com,
        cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
        zhangqing@rock-chips.com, kever.yang@rock-chips.com,
        shreeya.patel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 02/17] arm64: dts: rockchip: add missing cache properties
Date:   Thu, 29 Jun 2023 15:00:31 -0400
Message-Id: <20230629190049.907558-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 42dcd054a6493e1adf292c3e246d1a2a9258942e ]

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  rk3588s-khadas-edge2.dtb: l3-cache: 'cache-unified' is a dependency of 'cache-size'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230421223149.115185-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi  | 1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi  | 1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index dd228a256a32a..2ae4bb7d5e62a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -97,6 +97,7 @@ CPU_SLEEP: cpu-sleep {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d7a7bf72ac7e..e729e7a22b23a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -103,6 +103,7 @@ CPU_SLEEP: cpu-sleep {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index f4eae4dde1751..ff4470a28ffa4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -223,6 +223,7 @@ l2_cache_l0: l2-cache-l0 {
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -232,6 +233,7 @@ l2_cache_l1: l2-cache-l1 {
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -241,6 +243,7 @@ l2_cache_l2: l2-cache-l2 {
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -250,6 +253,7 @@ l2_cache_l3: l2-cache-l3 {
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -259,6 +263,7 @@ l2_cache_b0: l2-cache-b0 {
 			cache-line-size = <64>;
 			cache-sets = <1024>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -268,6 +273,7 @@ l2_cache_b1: l2-cache-b1 {
 			cache-line-size = <64>;
 			cache-sets = <1024>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -277,6 +283,7 @@ l2_cache_b2: l2-cache-b2 {
 			cache-line-size = <64>;
 			cache-sets = <1024>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -286,6 +293,7 @@ l2_cache_b3: l2-cache-b3 {
 			cache-line-size = <64>;
 			cache-sets = <1024>;
 			cache-level = <2>;
+			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -295,6 +303,7 @@ l3_cache: l3-cache {
 			cache-line-size = <64>;
 			cache-sets = <4096>;
 			cache-level = <3>;
+			cache-unified;
 		};
 	};
 
-- 
2.39.2

