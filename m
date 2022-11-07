Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2E61EA7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKGFdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKGFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:32:56 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3E11C3A;
        Sun,  6 Nov 2022 21:32:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C0C7B5C009C;
        Mon,  7 Nov 2022 00:32:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Nov 2022 00:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667799173; x=1667885573; bh=1R
        1DZWFpevQOPZqRZc5KNPqt9efV8bhbezth/9NJtpE=; b=Gg+w8T8k542hNjDfF+
        Y4Qam2g8iLx0wbeCR7AvL3JyAwDPhRo8yifrbgPx5OoN7qdeNEA52OdrSyt9exzh
        W4je62AQhNBiSxwvJYa3clzYqgkV5wu/OqRZKA+kHW7XbhnReavPCv/usrrHp/Nv
        be2WMq1fL36YaWte0wtoCC8srPWOYUXdgKzXcOdyatG7xyEjt5EaGKOy8a45nLzD
        FsSkikp9z1jD6fuxk5Awgy/suGvO4dce3h3J7tifdFaQJ7VQ1hRSgL5B/UYFiuP7
        Xd31l8zHD58qDNkqx296Sby1ZQArlWDH8mvziZc9FhemxO1UVHhtQNBPQAN3Z79J
        zHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667799173; x=1667885573; bh=1R1DZWFpevQOP
        ZqRZc5KNPqt9efV8bhbezth/9NJtpE=; b=rdSZ54j03yQXR0iGz2I46xGiiN/ik
        +cfFAJfVs63SKGunbM2NN6CagaPr9UQfhszcSjsGLeH+6bULAQEiSwXFHtNcF0f+
        nnHhhTh/58bAFThEbZm54STILR/rLIh7FItj+RerUp3XQyuL0ucY3TwPRfy9J8XD
        rgWrFG8D4iiSdZqLVCrdJMbs4a8kbaJ0+lU6cA29P2Wr+9iWB+P1yRNlrwr44y0e
        mYrplczkCHrdc+2nBp7dB3qtn+nLsi/H//Wv1oLjdVIlwf2AFVX6HQO/UCggKSqb
        50h+XNUcgYTxB6Qb60ch98Bnm4JfxhsRmvgtT7LP5Ebel9cG+xPPk3D2Q==
X-ME-Sender: <xms:hZhoY874sQhBxAyrd3mxeMVIIpAIdYZIBphdGkdAZVv3OdQ2w5HXkA>
    <xme:hZhoY94fLuNpR77jXw9Byh7N7QJXs_4nJcVtQkwL8_e6fNfbmk0UMVDSvAvdhM9ss
    sQuus3QFm72OULfkw>
X-ME-Received: <xmr:hZhoY7ddTQfVid788C0M7kHcjA6gbLxOgyNSKpVNaqkivA6oUB7nK7RRQt12Rz5HO0W5n5a4Fgi-rtNsFFeITN_Znu5cLwvpK6OaEJOJXNInIYtk0yYTQ5OIvuVlfkbe_SbJEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:hZhoYxK9uvmz--Yi5iye4BRUxnrwpyZhO1fdGqjBEaKbzbTUsemfAg>
    <xmx:hZhoYwJxPD-IRbarLtBLMJenVKw4K2-2ey4ywbV60_JyUbS9cIu1kQ>
    <xmx:hZhoYyyGAqX8ITqrrY4uRKOwhiSXjpvim7MOmYshwum7texqQGvHpw>
    <xmx:hZhoY5pd963Yrtfe8AfbWYSgdLCdPEtXDFyObVKUhosuP6khnIQPZQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:32:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 5/5] riscv: dts: allwinner: d1: Add RGB LEDs to boards
Date:   Sun,  6 Nov 2022 23:32:46 -0600
Message-Id: <20221107053247.1180-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107053247.1180-1-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some D1-based boards feature an onboard RGB LED. Enable them.

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

