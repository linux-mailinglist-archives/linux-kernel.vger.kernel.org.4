Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3C62740E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiKNBHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiKNBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:06:49 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7F10FFD;
        Sun, 13 Nov 2022 17:06:48 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8997B320090D;
        Sun, 13 Nov 2022 20:06:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 20:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668388007; x=1668474407; bh=vS
        E/FlVOFfJV72LzWEyWSXBLqckHW0Cl6cdsoa0yPnI=; b=N/6yUBjEoCfsQvydyJ
        E09HImpo55+NpHn65p+TPpsUKvPJr2aWsJ6BTBNt0LoEM7ZW/ASAq/c4mkydpWLS
        hLC8J877P0s50b4+ZFRkmfVDjuY07MOeQxDvyCzV0atTtujMWZc5uiM2SzlGvGwr
        vCH01Bs6fTWxSfdxwSu64MuKZaro4RKeW5x8dDKDfxbptuiQr3l0NDo7UpykAKJU
        4MgXOUPXPgUMyC9yPtNStERK6yiywrF9LsZUwL4vnhborLVcLkmIhKrTv1vc4zi2
        a4cQuj700C1RCsyOuHNKmhQx0Zjlzd632Sce53Pkee3dWxvL33RSZMmbFrdO6mDG
        mgng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668388007; x=1668474407; bh=vSE/FlVOFfJV7
        2LzWEyWSXBLqckHW0Cl6cdsoa0yPnI=; b=eIp4LKUZGjUrD9DYFkgLe3BFI+EXA
        mfnzE4nIrl+3KJWg0FTQ+R42Zcpq2iNPOFyHwL+EWUFHT/uWxKE4/r3N6EcTBE1s
        RO7NQ+lS20h3pX8EfXkyYlEKssgGKro7Kmc33uSt+/NQSCMTmHaoyW3xLAy+FzTR
        Vly2WnNguBad2DgtKD8hxSTY8Zk9k7zQFH2PWIIAuU5Ia8/rnOck7Qnn+sE/XAiA
        QE7zZAxCfNI8CPpYfYP1vQ5/QtglYO7dT1CUE6VbF840PyZNFvccaQzO8IHMA32G
        kiWd2x86nRw116i/1PHpmW/LIkSaYvHSYpAhtWfMqkCZ+2v5C8Y0G5eYA==
X-ME-Sender: <xms:p5RxYwRZJnsYBKtjp4oe7rAraQCEfhJ9dq_EJS30IQm8goEEv_3SDg>
    <xme:p5RxY9ya87KJJ1MxIxBcdFQWlEWzjDiCb2RLBgrDn6rEdzUGIkjdT_e0v5vnsOxFC
    Sk3tZI0GMUqmAv_GA>
X-ME-Received: <xmr:p5RxY93vCpHywXogkqmL4L40QcrQb4285hGraSwnL8sJLlcWx9wr_phfKRpGBFi9j7ygMdTSEkuhZUbomDbk6r7DBinRNjcpEgM_j5lMebuLcVfFQ8gpC9pPAEnltSovXTsEsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:p5RxY0AbyJ_qBS3S86gTyJirCwpj3iOBbZfgZ3-4mSXwcctpDFvCNw>
    <xmx:p5RxY5je8qvYQ3mbVmOjEblxalIwPQSV50FrnwUHnI-nfbcdHDHH0g>
    <xmx:p5RxYwrza-_Px8Nbs50InoroKHQ_aP7B50-AzcqLoliWz6RYcNMMsA>
    <xmx:p5RxYxiUKfXG8zI3g516hMyuyVwvfAZfMViAzVWA65Lxcd0rnz_WHQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:06:46 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 4/5] riscv: dts: allwinner: d1: Add LED controller node
Date:   Sun, 13 Nov 2022 19:06:35 -0600
Message-Id: <20221114010636.33052-5-samuel@sholland.org>
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

Allwinner D1 contains an LED controller. Add its devicetree node, as
well as the pinmux used by the reference board design.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
index 9a9b3e0fe79d..53b0cb64906f 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -115,6 +115,12 @@ lcd_rgb666_pins: lcd-rgb666-pins {
 				function = "lcd0";
 			};
 
+			/omit-if-no-ref/
+			ledc_pc0_pin: ledc-pc0-pin {
+				pins = "PC0";
+				function = "ledc";
+			};
+
 			/omit-if-no-ref/
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
@@ -178,6 +184,21 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ledc: led-controller@2008000 {
+			compatible = "allwinner,sun20i-d1-ledc",
+				     "allwinner,sun50i-a100-ledc";
+			reg = <0x2008000 0x400>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
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
 		lradc: keys@2009800 {
 			compatible = "allwinner,sun20i-d1-lradc",
 				     "allwinner,sun50i-r329-lradc";
-- 
2.37.3

