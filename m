Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0B7485B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGEOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjGEOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:10:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C710D5;
        Wed,  5 Jul 2023 07:10:29 -0700 (PDT)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c8:b70a:ae01:7599:ed26:1798:f430])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F8916606FBB;
        Wed,  5 Jul 2023 15:10:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688566228;
        bh=fl22C7uQE0nIwjINET+l+iT5MZzv1U3bD6YeVO94hJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aogTz2beTFu7sAfcD18VNGJTVJkSDuiH9hCq86pyAyTaKXcbctYcLDnLhs8PW81Y+
         EczDvNW6JultzTtC2TI91ahZh3/JRp6An5NX3lmLQAZMFs7xs0B5tLoCxP27mnujfN
         E0yASiXD23CN69+cz9x3VxXWoTmbH3/L5ec2fOyCp8jEi5c7y+uchZmt1oKIxnILZ9
         75Wj1CD+yR8fkjNkHoTRaUaXsrU0fRmEil9s+FjcRuU/uSLpczu1WXn/+Da7XgOcnS
         PaK3hm3hQeKAlg6OjIi7fO9WUBcjSzh0cr37kdLw2EPB16ppTBONdOsX8xGZI/ptRz
         +7W8fcfBf1iUg==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] arm64: dts: rockchip: Move OPP table from ROCK Pi 4 dtsi
Date:   Wed,  5 Jul 2023 15:10:09 +0100
Message-Id: <20230705141011.111568-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705141011.111568-1-chris.obbard@collabora.com>
References: <20230705141011.111568-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROCK 4SE uses the RK3399-T variant of the RK3399 SoC, which has some
changes to the OPP tables. Prepare for the bringup of this SoC by moving
the inclusion of existing OPP tables from the common devicetree into
each board-specific devicetree.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 907071d4fe80..ec307ee20c66 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -9,7 +9,6 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
-#include "rk3399-opp.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
index 89f2af5e111d..931334aa3d62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4A";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
index 0806545922f5..e98a182f8572 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4B";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index 4053ba72618c..d32efab74e94 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-opp.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4C";
-- 
2.40.1

