Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEE65A799
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiLaW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:58:58 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF3F5F;
        Sat, 31 Dec 2022 14:58:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A4C655C0036;
        Sat, 31 Dec 2022 17:58:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 31 Dec 2022 17:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672527536; x=1672613936; bh=MsmEn8s+7GEEz/bpKizUys54S
        mNuX2zHCFpdIiuCNSg=; b=ZxNXfoYgDAf4uGALmU8gChdwLRd22dOu9aR11GHlE
        xHRA5z7LD8NuykAkrHX63+x8mRi4IG8Pyx1OY9DDteZsMnAACneN2u5OezKCHV0I
        hO09+hEcCjisR/ZrQJeSBHz1Bn46etgrPq6v2XQjDW0BE/o7JmiskzFE/u/rAG7t
        wjpBErlNgas1Y4bMWtBbzZko0CRF308/OOa/osALhqaimBKNLsAVKGesmm1FFsat
        mJUjniSCZoYuhddpXk+gUxvVL1r3vvOxpwK95XiZn1MRsF9w48BF3yEGa5v/WdZJ
        MoF1I9xP+BzCtr2JJJIdOtoKj11w6HnZD3g5VVdPA5FNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672527536; x=1672613936; bh=MsmEn8s+7GEEz/bpKizUys54SmNuX2zHCFp
        dIiuCNSg=; b=G2W255MqjBm7XSy5iNYu9jLaSnBWQGot1pHGFybQihRPB89O2ED
        yZtG42sM7MEASaxQSKl3vNevgAm9/BHFokT9Lt8SIKXAc4lalAGGSNz44rwuPK3X
        6qRVwKI9JfdGNrSzyRYEu2FVQsgA0W8qrMFrO/fpxeu91clOVqXVP6UQg4cOeTIQ
        BBS2ZZrDeQl1RXI7JdQALMrlq2FFVe8AoVdUu3ZD1k3K17bHbpafRdCLDVUgmnWh
        sdjS6BNLC/1FDvk3InDtc0I+B+lP3KZJYJFHXOzeULBX5Rp2pCUEothxZ/g15tnb
        R6bkoFYjzR+QVCj1dmklVnh2LlkKqpLlsNg==
X-ME-Sender: <xms:sL6wYyYVH_DSuav3sRIwplEmKzTEHSx1HaX4ThHLBJSKy59TCmrX_Q>
    <xme:sL6wY1ZBOuXTrJ-e7wIT9JopUMSticEd8MDsSJMAeg5NBLtfhutndAgkDm1nnMj7y
    VQpDtB9FiUbKWP3Ig>
X-ME-Received: <xmr:sL6wY89tKbdD37SMVK8MYf-_TTbAGfop3u6SphBzIrfTjImo8ayAi7m5hJv1ot7dArONmi9e_x_koCkVUXEeoB1qW5QDwP09CNeQT2nd4i8zMPEA4OxW-ewaBFvJNNYgwy8xQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sL6wY0onAzcWGuBG1YnCVJSoj1VA8s3rd0oN-cv6VATGIduLmW-MRQ>
    <xmx:sL6wY9r6H-KML7dqMpAPdZhiPY53K6K6yCpAGSOmIYzC53F4oLj-NQ>
    <xmx:sL6wYyRH3NAr852nXjmibHfM3Zz3AnrR1XITyt0ZKxng-aMmZuy_yA>
    <xmx:sL6wYxLNrnUfLZwLwE_69wDEihPbc9KW4XmYnUj5fUeDuEyJ8own2Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 17:58:55 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/2] ARM: dts: sunxi: Fix GPIO LED node names
Date:   Sat, 31 Dec 2022 16:58:53 -0600
Message-Id: <20221231225854.16320-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

These board devicetrees fail to validate because the gpio-leds schema
requires its child nodes to have "led" in the node name.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Use the recommended enumerator pattern for LED node names

 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts | 2 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts      | 2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index a32cde3e32eb..5c3562b85a5b 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -70,7 +70,7 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-0 {
 			label = "chip-pro:white:status";
 			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 4bf4943d4eb7..fd37bd1f3920 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -70,7 +70,7 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-0 {
 			label = "chip:white:status";
 			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 0af48e143b66..56956352914d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -67,7 +67,7 @@ hdmi_con_in: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-0 {
 			label = "sina31s:status:usr";
 			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
 		};
-- 
2.37.4

