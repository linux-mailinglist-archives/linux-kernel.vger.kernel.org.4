Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038665A857
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiLaX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiLaXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:55:52 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90425E45;
        Sat, 31 Dec 2022 15:55:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0ADEF5818F0;
        Sat, 31 Dec 2022 18:55:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Dec 2022 18:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672530948; x=1672538148; bh=dd
        XJLCz66t5ciSKYjnFxdGsNInH7ChVUKYdQyuVBTwo=; b=OioIs5kgd6oAMz2kJr
        idzk/mjiblzyFqTAte+BVTYJJbLfXUVYHT9B6xVbPL/C3KDj7GqUgrNHz0guVLhf
        174/qBbVS226h7RFcImxA8PvuHxAhYPpvUoM+Spab6bHP4r+Hi/bG3HflFqRkN5c
        Tw4F+PJuDd3I6sxXcAZzayFgD4omTJY5xNuWKJsiCT7k9jnUT7qWhOEILQ2UVf+Z
        FL7/a+1nx7W5uRmUb2WEA2OnNjkPj6oo+67/RyyEEEbOoxVSPNoplOL6YSD6p7v2
        SJpwEgfPuqWr8UvATzNGohPLaqdh9FKcQEwHfjKvGzEtlWoCr9+Z8gaEZTXiGQew
        xmSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672530948; x=1672538148; bh=ddXJLCz66t5ci
        SKYjnFxdGsNInH7ChVUKYdQyuVBTwo=; b=s/nsLUnglqvcIGFbTOXOzQwTmhbe3
        q2sTrH1eneRgv5Ter5P+/zG8QiVxGn9Md4ecI31KPGsIVkxP8tIJU1aFLVDP7LKT
        sx+ckSoxp3FuLW7sUEWyzqWEUChd1saB/RKJAgMWbeHUa5/h9oh+INlYQD1nPVrS
        3c162R+/yeq1TPX2ljDGZS2FML3URTI8KJg7mcfA8bvYo9pVRilXl+2Lhs3nprHm
        VhuyPKD4uggnfiX5guiqYjmCgeSO2bWzofK5iCaZaIKpOykDDb2AtuliQ1dp163J
        Ros6bal8UjX+YzSj2LAXDDuz7qwKuPszgg3aUHbGY81qkgPGCAx1Bl7kA==
X-ME-Sender: <xms:A8ywY2Ng0kcJl-RCSDvIFq4quwJYoI3v2uqdtTu10l1E3sqApHdqLA>
    <xme:A8ywY08YZpSK0FQmsNCSFl7rXZqMKs5INexUrhPrAquZoW9Fm5ubDVqf0uSYHHEG_
    gRB_Abd0_piAw9IrQ>
X-ME-Received: <xmr:A8ywY9Srg8uGRdsEk1bH5edYgxF6tjL7yC8Z0GnNSr5NcYHhAr76zbSp6C0xSuCLOI1wjMLGl7ForOA2vE_NzzoiXkBy84Qt8Xi2Lghk-F7hgmzT1hTi-rcLapeMJy7RCPnqOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:A8ywY2sNxHfZTwlSO-q4nrADEhvBj_lWKxPkdq1Zjay-s5Q6pasuCA>
    <xmx:A8ywY-ecb4cMf2Hac1nV7sRDj6IbbF4OZefWpPOBVTyN8brQ9U-ODg>
    <xmx:A8ywY630V2kJlO2XUTMlHw_IIxUYCM1EtcHp8l1FC9YscNU0QTJwqQ>
    <xmx:BMywY88mi0ph8h-_i75r790Q9cXkSliTrVlPGFG1t_9rQVcjQYyzSQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:55:46 -0500 (EST)
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
Subject: [RESEND PATCH v7 3/5] arm64: dts: allwinner: a100: Add LED controller node
Date:   Sat, 31 Dec 2022 17:55:38 -0600
Message-Id: <20221231235541.13568-4-samuel@sholland.org>
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
2.37.4

