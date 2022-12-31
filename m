Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEA65A856
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiLaX4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiLaXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:55:53 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C356E71;
        Sat, 31 Dec 2022 15:55:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DA6CC5818F8;
        Sat, 31 Dec 2022 18:55:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 31 Dec 2022 18:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672530950; x=1672538150; bh=wn
        k0fQbI6LUgf3REBg+Sy4nR0IreskH+9S4EM6UJtpU=; b=shCDSFTvEqAHOEyrxt
        Pv2aJGNrDPL5wlUYOjMbwrsiWrgpNDy5CV0rJO+edySI3WEC8ZLAQLg3kWkVBqLh
        pvV6pwWFqKC+AtpKWV9q0Rbu/c/QQHVPZzCX5882xFFgUWLSMIeTWMrY7kiOMQHy
        +zu22cxq+E6Ictnf8TmIjzjkiCLOfJiZKEVjY/IIO/hX8QMxx4jXOvX1kXEuL+//
        kx06iM7lO16wjzV2XeXgcm7JYWp1faW+emkMFgmRzZgvIUKCJVuBk8Eiid09Tk/t
        r22ZTrRmSRZmCV1Bv+9EYptLJfW/2pmFwdbOepcUqHCqBOeyJDO6lv8qxrr1aybS
        I0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672530950; x=1672538150; bh=wnk0fQbI6LUgf
        3REBg+Sy4nR0IreskH+9S4EM6UJtpU=; b=nbjip5LZ5R6aeAqtNWwTmofZixgFu
        6U3fvstgZfGHgnPvbfNqMTGcZ5MWUc5miBWpnoeS4Pe6rHnxRCysjumqYtl757rz
        lVl07D+DvN21gy6et+K+/SD34odTQwz6V2TnVffkxZvl13/KuRJNubBWWcJyU76L
        1xBboRkdvk1FW+dt1pEksyHVa6DOuD0rePjUbYaOvTMhFKx4C575CvtSIVLNFHMK
        scJRXRQ+nVWs61DflCRYV0iuQZXe7Ybe9Ovva6W2kQUH7QbtrMUR1EU/I/aVIVrI
        sX9oHy7OJ0fogO/3X5/RJwfvsyq97levbS1Lno2PXdc69mWTzdX1+Sv+Q==
X-ME-Sender: <xms:BsywY6ANxssPWxs22Fyrmt3KU_SYDinXh2TaSUoy2xdScLg5wRqLjg>
    <xme:BsywY0ipB0vqj3DWy6FOm-klDMCp-hR7PmoKu_vF8SMJZ_Kw0kQQsm8J2y9nTEoZj
    n-tlF_eTJh-oR7Ikg>
X-ME-Received: <xmr:BsywY9kbGkrBgommwN5XWzsNBT1zCZYWBI11ylVMGxw7jBpjZb6Lurb2WREaQth236EoXTcS6WHUeSbQM-uugFnmBbvgUTdxiidvFkOig7I2tpqEbXiS_NpJlqdnBJsP1_oKuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:BsywY4w9EiFMZb_QViO-CKldIjqzfnJXLYvFiIPAgNnGhcwailXlKQ>
    <xmx:BsywY_TAY9neLTaqZFM-fbUhyuHWM3EY6Af3YC05UAr1VZJyFiJ9DA>
    <xmx:BsywYzb8qiir7hkec5zegEXUQS53hF8jAwX6SQPmlkEnJWBnvURoqA>
    <xmx:BsywYwTPWDH1o83qYidISamGkTdIAfN_Ny1PeFVS8gFgj0zvw1NSsA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:55:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [RESEND PATCH v7 5/5] riscv: dts: allwinner: d1: Add RGB LEDs to boards
Date:   Sat, 31 Dec 2022 17:55:40 -0600
Message-Id: <20221231235541.13568-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231235541.13568-1-samuel@sholland.org>
References: <20221231235541.13568-1-samuel@sholland.org>
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
index 52b91e1affed..7efcec906a71 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -59,6 +59,18 @@ &ehci1 {
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
 &mmc1 {
 	bus-width = <4>;
 	mmc-pwrseq = <&wifi_pwrseq>;
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index a0769185be97..2e5be1bbb00f 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 /dts-v1/;
 
@@ -93,6 +94,18 @@ pcf8574a: gpio@38 {
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
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.37.4

