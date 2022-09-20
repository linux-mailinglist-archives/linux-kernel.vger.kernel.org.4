Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD645BE70E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiITN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiITN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1018549B7A;
        Tue, 20 Sep 2022 06:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC999B8293C;
        Tue, 20 Sep 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB3C433B5;
        Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680451;
        bh=WOUQBrIy2nuOaYfvDaQXTDXDqtrzKIbQcne/3MYSJbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGnJqYy9PZG4SYQaDS8DD17bSV5ZObGQVIk8b/vW4R+D53BI3IhxOuA7hePFobBs6
         5UrVMIMaABXcM0Ka/9/6H3sudRQIfbDeTfOWWxo+nGZbHZN45xR725m6GhV0kqugo1
         yrt7iwhKLa43o2nm7TlD33hX9bEpWtPJkLjaiiuUJviXhvMO9NzGmmiC3sWS5cB3Pb
         enZCTUGqgsMB3b3M1R6pRPoa8PX6+gpfLfWUbXL6OsGA+eTKAOvwOt5Egjr73ifsO5
         QxOcOBqrTvcLOz3hsF23mN4v7AqP7n7ktSEUKtkheXOfG9WJENv9CjTAhPhnrJI/Er
         Km4Yh14ldfewA==
Received: by pali.im (Postfix)
        id 98E342D4C; Tue, 20 Sep 2022 15:27:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
Date:   Tue, 20 Sep 2022 15:26:45 +0200
Message-Id: <20220920132648.2008-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

This commit adds the description of the I2S controller to the Marvell
Armada 38x SoC's Device Tree, as well as its pin configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Lior Amsalem <alior@marvell.com>
[pali: Fix i2s-pins name]
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index df3c8d1d8f64..11e0e4286ec2 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -289,6 +289,13 @@
 					marvell,pins = "mpp44";
 					marvell,function = "sata3";
 				};
+
+				i2s_pins: i2s-pins {
+					marvell,pins = "mpp48", "mpp49",
+						       "mpp50", "mpp51",
+						       "mpp52", "mpp53";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio@18100 {
@@ -618,6 +625,18 @@
 				status = "disabled";
 			};
 
+			audio_controller: audio-controller@e8000 {
+				#sound-dai-cells = <1>;
+				compatible = "marvell,armada-380-audio";
+				reg = <0xe8000 0x4000>, <0x18410 0xc>,
+				      <0x18204 0x4>;
+				reg-names = "i2s_regs", "pll_regs", "soc_ctrl";
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 			usb3_0: usb3@f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
-- 
2.20.1

