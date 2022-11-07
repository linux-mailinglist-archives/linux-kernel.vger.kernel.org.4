Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED161EA79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiKGFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKGFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:32:54 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9A11C14;
        Sun,  6 Nov 2022 21:32:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D146D5C0085;
        Mon,  7 Nov 2022 00:32:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Nov 2022 00:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667799172; x=1667885572; bh=rb
        54mEX2euKxbMAz3voJkO60XtjBIRlH8c9USq+WGWw=; b=czBhdnVn36DkBGUmIk
        /cGc3kIlmxFVqNqUXdVIaO/z+BAzGQyIIKHY46BIwHf812vPfpBq7rbo9volXiLz
        LT62vo1Hja7kg0q1HcqO1+q9rTXQHqzknT25wN1nZOBYoCQJlao0VaLHm9kEcJRN
        6Ro/HT03afqIhBfR3eR2rJz4cLCvqbTbxmUhNUxzoIfeHWsr44zhiBtZiA2Rokft
        TXn00vMOBi8UICZDY/MN/NOKBs6dyBBk8NRfIbJzlWjUmEkT2viUzNhG9/NQCtGI
        UEAHPW45d9R7w+AUiOw8EaHYtxgnGY5u4LJpnijWzAD89E8RY9dhVMhKl/NVWNPu
        n5Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667799172; x=1667885572; bh=rb54mEX2euKxb
        MAz3voJkO60XtjBIRlH8c9USq+WGWw=; b=kJ/ily+q8sKnsOAab9FzUoVe6zZdm
        sKlZk6WTECr4YYYpYDrpqcSbZYu0YIq4/W12hMue5CEqaBy77nK2XOjDj6ltD2Eo
        cBibmS1ANV1XySoU9EKgPeCRzF/FYg/j2ToAK3fNkTkZ1k40EaNmM4br6B5XjeMe
        7A0ApYx3tNfUAeX+4g47rga7D16nuPnUcJLF3HCIJi1FDdH7W8/e8E/d6sc1Hgfr
        OS56qhDHjKDUjNJMi3KTHaSzaVPSuW/W5FVzKCVlzL6VtF93he40AxpWiNZVD60y
        WU0Z6++lPK1Qb76piU3myZJivnKYkxLYQGbdK7AmNC/YWMEEQO5IurNAw==
X-ME-Sender: <xms:hJhoY_kFbPxwLoM-IUx1rQC0ndmLSIUz52xJGcPBuzRANXzpMV2JIg>
    <xme:hJhoYy1d3j5DucpaJUSLr5DBKnVXr-3ObIPhzmRy2q6LQI38tffGlZ_mnusqu_J0S
    iz75nr-UGEXIZvolA>
X-ME-Received: <xmr:hJhoY1pyQG9pKAnLMVDzouRX_cAq9MAQoGuhkZx7Ybpq_y69xs31rqzgQmqf53a03TzYk-Cszj78ciklA6IAoSMHu9C0a3kA0uVt26DSw1bKj4m1C8b4jL47kL5yjORaXH53fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:hJhoY3n4CAEVyXMCTU7eiKJsxVJ9HBtacizM4UbCqjRt3BYfVUyYyw>
    <xmx:hJhoY91F3rlZAtOhz-iGbApi4CsGEmvH95WWlz9J4cgIWnFh8ZhRow>
    <xmx:hJhoY2vpCmXBhZRGTeaNecnrdFZW47CmkhlKyCb-BvqlUFPbt3ybaA>
    <xmx:hJhoY6mM_b2DipJq1TpufjrsEcKFI_UCrlCbdzHLoB9RoP7eKTEOmw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:32:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 4/5] riscv: dts: allwinner: d1: Add LED controller node
Date:   Sun,  6 Nov 2022 23:32:45 -0600
Message-Id: <20221107053247.1180-5-samuel@sholland.org>
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

Allwinner D1 contains an LED controller. Add its devicetree node, as
well as the pinmux used by the reference board design.

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

