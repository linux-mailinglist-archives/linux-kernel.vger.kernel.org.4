Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC562740B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiKNBHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiKNBGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:06:47 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68719FAD8;
        Sun, 13 Nov 2022 17:06:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4729D3200912;
        Sun, 13 Nov 2022 20:06:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 20:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668388004; x=1668474404; bh=Qc
        3PG8aa4zgdpdjCQqIcsCqe6dSbuvEez+FihmYoP1c=; b=Bddy/2V0+as/Nj6tJX
        tW2MdNfwnac0c3K7GRShzmhdwSGyGSkjbYiVhjAu8hwdd0NYo4s33zv/XN+tXSXK
        xyMCYP/9qz2kk1hzGXym57YHrXeKHw3trTfbRtnMm0Vq7lre3KBSWVvKHRKhIT3I
        FlU9DuL3ZpyXDyOEwWQIMWdqJtsov1EGL9rtVhbrPBAhmREF4IRaAhjyqDgKOKyj
        oWO2BZS0G2le3YLNgueHoha18hCXYnvWIzmmwN+M14AX3r662uoRbq9A6e7mYDFO
        JvwEs0/JFF7hDhkf2kzjiI1GvrN9mt9RZkelPxV3d6DIhLV6dpnSJt4V9GEVIUsw
        xACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668388004; x=1668474404; bh=Qc3PG8aa4zgdp
        djCQqIcsCqe6dSbuvEez+FihmYoP1c=; b=WWc0mA2VrLaNW30k0pZTnDnZviBO5
        52EuQDaD+SNBXevJYwk6GZR093xoUMKfiK3I88vqVcZvu3v0CPOwc94HtKVcNmXb
        q+JyN1hLw7zulRgSjFGcPSoG7BuqyGkdHVDf+NmeCtPZyWQVqSx/Nqq49hTnAasB
        GbtrJI06exKWqDw6z1tGGXkqsEkTM052mFaVuKMQ9xVrEC3MMnWruuCc6xP4u1WE
        gSmZUSjMnooReHjOfhmEdCsDeTKmtt45furw5FuOb3H4cmJ1zfCtzsJjYf6eCM5s
        AePiqstzCqIkNbIpfyfJUYrTMjQVgtu71Dc9G+Cdthzwharij5GDiRu9Q==
X-ME-Sender: <xms:pJRxY0rcBWiGQMwPFyQcBKTwdWmokjiYnjHhOiX0kxh6PUq9D1BAhw>
    <xme:pJRxY6pjlxbcnegfiz7Roy5yd2C7xi-rd0KhRA_0lDFJU0vDVTVsdIoZVMwuqP9z8
    g-uPmF8--jjKWYcWw>
X-ME-Received: <xmr:pJRxY5ODGOa2OqQ-2n-SSujWb0Rva8GMbgW9JuTa_9E0EQQkrzHoAdbpiqMgHRBUHGpewvC514QLvlp0owTb7NPjPDH9lNeflL92el4Yhg_8ETfxURG6i17md_unF1zp9V9k_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:pJRxY76DDQnNhhuS0fx-zrDHgo55LsOQdoJu5uWxsKr87bDdBz2esQ>
    <xmx:pJRxYz6QiXKSHPvdgghcfHG9sN4n6aBCxBLH0ny_gUkJi7W2zl146A>
    <xmx:pJRxY7i6OJrRhqUM25bN_IWE4XvBQ2yUeccP9cDe8_e8X7ypUAHHJA>
    <xmx:pJRxY2YsqcbI72HqIX_2yHnPfyUtq2GwtFVIwATQSq_G9LdH3QI-Hg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:06:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 3/5] arm64: dts: allwinner: a100: Add LED controller node
Date:   Sun, 13 Nov 2022 19:06:34 -0600
Message-Id: <20221114010636.33052-4-samuel@sholland.org>
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

Allwinner A100 contains an LED controller. Add it to the devicetree.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 97e3e6907acd..2c90683145f2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -273,6 +273,20 @@ i2c3: i2c@5002c00 {
 			#size-cells = <0>;
 		};
 
+		ledc: led-controller@5018000 {
+			compatible = "allwinner,sun50i-a100-ledc";
+			reg = <0x5018000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
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
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-a100-ths";
 			reg = <0x05070400 0x100>;
-- 
2.37.3

