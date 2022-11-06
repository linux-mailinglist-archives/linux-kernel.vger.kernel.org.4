Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3961E6A1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKFVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKFVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:42:23 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 13:42:19 PST
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A292BC35
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:42:18 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id D1194378512
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wnTg8K98V6Em for <linux-kernel@vger.kernel.org>;
        Sun,  6 Nov 2022 22:40:34 +0100 (CET)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by mail.rnplus.nl (Postfix) with ESMTPSA id C89BE377D7B;
        Sun,  6 Nov 2022 22:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1667770831; bh=dposmZziBXGFSWdzBvqK+nAEyqiV2Mu12CTImtW/j7w=;
        h=Date:From:To:Cc:Subject;
        b=Po4Xek5z4pauwchoKhdq1zRYHYTObF6PXHPFDlG+aoondykkaZv1N3lifChu4I3aL
         jLKiavQvcb+aDx8fR+ByeZsIMoq+EP/2ilsafVjJIOtWX32DpxZIoSNM1obj7pclxo
         p4yvqN2Zt8B7R57yLkuGSBiNtXoUuVyASEGFjYhc=
MIME-Version: 1.0
Date:   Sun, 06 Nov 2022 22:40:30 +0100
From:   renze@rnplus.nl
To:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: allwinner: a64: add device tree for SoPine with 
 clusterboard
User-Agent: RN+ Webmail
Message-ID: <b3b8320f0d2b54a0557331977582d05c@rnplus.nl>
X-Sender: renze@rnplus.nl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 clusterboard needs a to have the tx delay changed to
500ps for ethernet to work. This solution was described by multiple
people on the Pine64 forum years ago and nobody has submitted it.

Add a device tree for SoPine with the clusterboard.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
  arch/arm64/boot/dts/allwinner/Makefile                 |  1 +
  .../dts/allwinner/sun50i-a64-sopine-clusterboard.dts   | 10 ++++++++++
  2 files changed, 11 insertions(+)
  create mode 100644 
arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile 
b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a..15b011d1aaea 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += 
sun50i-a64-pinephone-1.2.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-early-adopter.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-clusterboard.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
diff --git 
a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts 
b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
new file mode 100644
index 000000000000..6f8020a22670
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-clusterboard.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
+
+/dts-v1/;
+
+#include "sun50i-a64-sopine-baseboard.dts"
+
+&emac {
+       allwinner,tx-delay-ps = <500>;
+};
-- 
2.38.1
