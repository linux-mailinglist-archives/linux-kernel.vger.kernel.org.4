Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2F6BEFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCQRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCQRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:41:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC91B2DB;
        Fri, 17 Mar 2023 10:41:15 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-142.ewe-ip-backbone.de [91.248.191.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5BC266030C6;
        Fri, 17 Mar 2023 17:41:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679074873;
        bh=qxDBq0fQ9YqbrNkN81oPGZ/qN7uYkUt6Ntv20FQUMik=;
        h=From:To:Cc:Subject:Date:From;
        b=MjOaVi27U7qOitWXFzGMk8gv4AT0f5Vw5RQzQFzIOpZ7RPKfBwEpbCCJ0oplVo0Pb
         uaSz8xEhr80jCNQWkp+dAAQWLquz0KQaKiDMOLkmIJ5VJxbeviI87WJytOyRzTdmW7
         D9XnsF0QdQ3U1xkSJJYo5KqkTeceCi6ndnXXoMB2YZWqsCxwz6PCbvxVymmJcBYPXO
         EWu2M9Pxcj3pM9vGD9eB9KSbYnk3sWvmw2fUuXfP1Lvgwg5Ir7VSz3EOX4lqbmJMWi
         +lPc5BoNBBmGNQwwgJnKNWvR2bF6Cr9R2uWbHufX7ghuhaUpHZt1EP2GlYUnInCqyL
         Ki0WFEJNWIXuQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 269BA4807E1; Fri, 17 Mar 2023 18:41:11 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 1/1] arm64: dts: rockchip: rk3588: add cache level information
Date:   Fri, 17 Mar 2023 18:41:02 +0100
Message-Id: <20230317174102.61209-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing, mandatory cache-level information for RK3588.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Fixes init_of_cache_level() returning -EINVAL
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 82dab5fcc3f0..0fb911704a64 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -440,6 +440,7 @@ l2_cache_l0: l2-cache-l0 {
 			cache-size = <131072>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -448,6 +449,7 @@ l2_cache_l1: l2-cache-l1 {
 			cache-size = <131072>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -456,6 +458,7 @@ l2_cache_l2: l2-cache-l2 {
 			cache-size = <131072>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -464,6 +467,7 @@ l2_cache_l3: l2-cache-l3 {
 			cache-size = <131072>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -472,6 +476,7 @@ l2_cache_b0: l2-cache-b0 {
 			cache-size = <524288>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -480,6 +485,7 @@ l2_cache_b1: l2-cache-b1 {
 			cache-size = <524288>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -488,6 +494,7 @@ l2_cache_b2: l2-cache-b2 {
 			cache-size = <524288>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -496,6 +503,7 @@ l2_cache_b3: l2-cache-b3 {
 			cache-size = <524288>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
+			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
 		};
 
@@ -504,6 +512,7 @@ l3_cache: l3-cache {
 			cache-size = <3145728>;
 			cache-line-size = <64>;
 			cache-sets = <4096>;
+			cache-level = <3>;
 		};
 	};
 
-- 
2.39.2

