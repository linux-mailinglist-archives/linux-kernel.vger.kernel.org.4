Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E658465A853
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiLaX4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiLaXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:55:52 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1025C4;
        Sat, 31 Dec 2022 15:55:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7BE4A5818F5;
        Sat, 31 Dec 2022 18:55:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Dec 2022 18:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672530949; x=1672538149; bh=3l
        UzKMMvF7vk9xmGqukiUQTKJhZZpCfvn0wSoYuZP9A=; b=BVkco794bS3VyPN8pf
        40Gap/hkUSZFoR3L103zIUWpJl8AoX565M2YqTlwVWeD26wbd+DIw3aiy0uyIO1/
        B+4pyZvJqM1br3j6qEoWeYonS0pD4eegMPXwrgg0lxm2NI6YdcLtT8Bqhr17P26N
        6U4buAijem2cFkaVR8DGhPlTes6j0nEvspNHT7xx1cIDW7ko9PqlinuhZkMALpXl
        caYEqxzYUxwNpTQC2+XHuTC2mLaVTcto7IkbOr92KXoibgMDsX1pi8epGuZBgzQS
        dyqRed8X/307JlyLWtFsTQNUncZoMF1iPLxAJbzgVFFXXvJPLIySJHxl9xt+rnFf
        CUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672530949; x=1672538149; bh=3lUzKMMvF7vk9
        xmGqukiUQTKJhZZpCfvn0wSoYuZP9A=; b=lYDxZJIRxJ15BiBXVJx+vsb/INpLX
        jt9nueLiX2E8jwMiIIPxnJPCk/HH2NbjWn3riyPUFOSWzOQQcm0uvIZfK52HGKFH
        TASwbpUWzADSv3fB/4Xgh0OfxVaWtxbTb8H36wUaD0nRZ1hBjDyi7ORPglPc+dEI
        qq70A19UuQuvJFW0CVyT7oXdlq6sTgCqY1suCSp5K9Lt8sx3Mux/kuD/4EBodiLG
        wMGqMTgANLXNhJRXAm7s1WtW608DggvepNKLWmfrLsY2snS4O7GEFfJqmHdIrFNd
        USFW7QdxgXAR5SCzc69799OUUY5lH66EkPgrMdxucHcJU4Gh4B70kdwGw==
X-ME-Sender: <xms:BcywYxZAy2VdNn-y2Oo6zaKQX9SJyrm8r8qjMBv0_cEYWOBiEh4hnA>
    <xme:BcywY4YpXGPZzOCF3zgsEPSw_qCjaxXdJahcFCenyEH2HX6dL9zIhRY4qD2U9vqwO
    Z90zh_bPh9yoJikug>
X-ME-Received: <xmr:BcywYz9qdI79EpKu1S3e1R2JY2Mycq-7p-kNBfrJT0st3IwIuWmbEDeaIFdeLkEIi5JNI8yeqGKFz-Pvk_Djb_wuykldBMfIBqW2G_Ge6BaZaIY9NMrpXpUqPr6kcfa7RBuMrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:BcywY_pC_Reu3FX_Y42ZJXyw6WHRIHeqXYeROWIM7jTUIYm5_BfkrQ>
    <xmx:BcywY8rkvYem8Tgu2YYXFPpTzTBE6E0bTXmwevCtVCJsbhnr-0pXRA>
    <xmx:BcywY1SChv5KQcI_gchdR-ISeNI13wQBfZFl8tZhP7GEOM-_JtiDhw>
    <xmx:BcywYwoeGPjalucCOXbZdNgk8oIaXk7UaYQGK1149wJvw817GhxTJA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:55:48 -0500 (EST)
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
Subject: [RESEND PATCH v7 4/5] riscv: dts: allwinner: d1: Add LED controller node
Date:   Sat, 31 Dec 2022 17:55:39 -0600
Message-Id: <20221231235541.13568-5-samuel@sholland.org>
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

Allwinner D1 contains an LED controller. Add its devicetree node, as
well as the pinmux used by the reference board design.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi      |  6 ++++++
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
index 97e7cbb32597..28a6df83ec08 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -58,6 +58,12 @@ i2c2_pb0_pins: i2c2-pb0-pins {
 		function = "i2c2";
 	};
 
+	/omit-if-no-ref/
+	ledc_pc0_pin: ledc-pc0-pin {
+		pins = "PC0";
+		function = "ledc";
+	};
+
 	/omit-if-no-ref/
 	uart0_pb8_pins: uart0-pb8-pins {
 		pins = "PB8", "PB9";
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index dff363a3c934..6b70b3cf4965 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -138,6 +138,21 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ledc: led-controller@2008000 {
+			compatible = "allwinner,sun20i-d1-ledc",
+				     "allwinner,sun50i-a100-ledc";
+			reg = <0x2008000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(20) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LEDC>, <&ccu CLK_LEDC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_LEDC>;
+			dmas = <&dma 42>;
+			dma-names = "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
-- 
2.37.4

