Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D69630EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiKSMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKSMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:32:11 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CF8B843
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:32:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id AF01837866F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uqGstaFmtzzE for <linux-kernel@vger.kernel.org>;
        Sat, 19 Nov 2022 13:37:07 +0100 (CET)
Received: from werkpc.localnet (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id 49A4737865F;
        Sat, 19 Nov 2022 13:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1668861418; bh=akAXi1MFXUANjNwzEmt7q8xYQob8p69iSgdJ0x2khrI=;
        h=From:To:Cc:Subject:Date;
        b=mF/JbqFDoYM1R08D6utag0UJUG5j85cYBGMZ2P7aqt9t0v6LIyiR+j19thvILdsXz
         2Rxs2WOYyw17dwfyX6mGps/mzsOBwCtLxJpdDxGzRLVhv96BYJLdwtwSuMQR/+y8lW
         670XSpOy/D6eaA4hX66KMB6poQezps+MDefc4+WY=
From:   Renze Nicolai <renze@rnplus.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>, krzysztof.kozlowski@linaro.org
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: allwinner: a64: add device tree for SOPINE on Pine64 Clusterboard
Date:   Sat, 19 Nov 2022 13:31:59 +0100
Message-ID: <3351526.aeNJFYEL58@werkpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 SOPINE Clusterboard is a mini-ITX sized board capable
of hosting up-to 7 SOPINE modules. It is largely compatible
with the SOPINE baseboard but it omits most of the in- and
output interfaces. Also The Clusterboard needs a tx delay
of 500ps for ethernet to work.

Add a device tree for SOPINE on the Pine64 Clusterboard.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm64/boot/dts/allwinner/Makefile           |  1 +
 .../allwinner/sun50i-a64-sopine-clusterboard.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-
clusterboard.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/
allwinner/Makefile
index 6a96494a2e0a..15b011d1aaea 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-early-adopter.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-clusterboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts 
b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
new file mode 100644
index 000000000000..f75325d43d76
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
+
+/dts-v1/;
+
+#include "sun50i-a64-sopine-baseboard.dts"
+
+/ {
+	model = "SOPINE with clusterboard";
+	compatible = "pine64,sopine-clusterboard", "pine64,sopine",
+		     "allwinner,sun50i-a64";
+};
+
+&emac {
+	allwinner,tx-delay-ps = <500>;
+};
-- 
2.38.1



