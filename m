Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681C62740F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiKNBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiKNBG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:06:59 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D811A30;
        Sun, 13 Nov 2022 17:06:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A225A32002E8;
        Sun, 13 Nov 2022 20:06:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 20:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668388009; x=1668474409; bh=5S
        hl8P/p16p52VEaYrOLrE4C4Kh9jE5qf4TZfI1iPJA=; b=J/hYq+Q1XLL33aztHV
        IkwPZbm+eFTuTfQVt0tWim0blUm2Y631DutB07mWSOUW4q8AlLPCyuSD0OZ8HaJ9
        BtCYKqN7gLrx95FSvfIyJE4+wo9ZLOMKPiUpq5Km3HyxVwA5FHHlManxRiqFpu7y
        0rkIMZXHzSzC0szEHhp7qVN/Wpv5bvB1Qe6mwb+V5i11l48Qr8s1VuZF0BywqZyh
        Tf2Nv6LTM6iV6scptuLiYx7OwivJUxfj5EiGsheljVqbduiUn7eK2Xyu2tDv0vFI
        8Pq2nQKzkHYDVjpkTxp1ctatKVs7tL05VnJnAc6C4XmVSVlCC088EFTQ0W0Dhg99
        aLyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668388009; x=1668474409; bh=5Shl8P/p16p52
        VEaYrOLrE4C4Kh9jE5qf4TZfI1iPJA=; b=hUKjdFkZYMMP0Dh2cX6N8S1X1N+lq
        Q5H8n/J0RsBSbY3SW60hPsrgmOcZD6p0b1tICXzpfdfOuogcHiFYa2AIFwGcNY8W
        5+ewT6yQApXH0XM9k+VY+yEFahkg3/aY1KWfsVOxbpPsX0Jwn8k/NhHtD5VKE4O1
        EeU5Sy+shqxqVbPZ55pHBeHQMtNrZ37VCs4e7rAiA4i8/ExMwEhkjlctCqjnYaG0
        6/uf0Jwjdzt80TWLa/fdFwSLBXo4KoD1FAuh8LEP3SdTc/rccBA262wf3wtimmjh
        JyD+aufeLdeXmPBnBLCEKiNglTJmUQmekjrFd0pRP9TIJYCbRysN4IoiQ==
X-ME-Sender: <xms:qZRxYyTFCYU_lpfS0S7yAkKqFBnoZ1bwRlLJk7KlLoTgEDOKuzUJdg>
    <xme:qZRxY3xkbakOqIai3R0nOFAa9E3Y6Yr9gvDLHRJzXSMJ2czSRQ8UWVfclg-9TmjIH
    qz-PkxsmYWHCSfOOg>
X-ME-Received: <xmr:qZRxY_2Ii40q8E74hqCkYzMO42sIQyIXbY5yqdJOe29dfBOoIE-i_LkciSKglp1-8Dgvpb6c5FUBq0ZYsUy0u208YpX2Bhzi_ssgVP4fu7IMNg7SBcW7-WqiDWD8RC8r1k3NFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:qZRxY-ANnJUDyxY3GTzl9Z6HxzRjqPVvlhL0h4oul7IGWiC2PX7uzg>
    <xmx:qZRxY7jsrC7B2xmAIXfMI__sWEXiWuhjLjGlldAF0332Cv9c9vGOEg>
    <xmx:qZRxY6q21IZlIX8dheiOj7CCn-GAflsmLDhSb1Agya5mfKPegjWaaA>
    <xmx:qZRxY7gFKdoRLs2K3XdqoeMqX2F0XT4p0G32XDRAj0UIgMIo4U8caQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:06:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 5/5] riscv: dts: allwinner: d1: Add RGB LEDs to boards
Date:   Sun, 13 Nov 2022 19:06:36 -0600
Message-Id: <20221114010636.33052-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114010636.33052-1-samuel@sholland.org>
References: <20221114010636.33052-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some D1-based boards feature an onboard RGB LED. Enable them.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 .../boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts | 12 ++++++++++++
 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts   | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
index ca36a5d75a7f..02d13e987e02 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -25,6 +25,18 @@ &ehci1 {
 	status = "okay";
 };
 
+&ledc {
+	pinctrl-0 = <&ledc_pc0_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	multi-led@0 {
+		reg = <0x0>;
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &lradc {
 	status = "okay";
 
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index df865ee15fcf..099075462998 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 #include "sun20i-d1.dtsi"
 #include "sun20i-d1-common-regulators.dtsi"
@@ -90,6 +91,18 @@ pcf8574a: gpio@38 {
 	};
 };
 
+&ledc {
+	pinctrl-0 = <&ledc_pc0_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	multi-led@0 {
+		reg = <0x0>;
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &lradc {
 	status = "okay";
 
-- 
2.37.3

