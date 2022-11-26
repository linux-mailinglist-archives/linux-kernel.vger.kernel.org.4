Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FA63981F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKZTQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKZTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:16:39 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17FC140ED;
        Sat, 26 Nov 2022 11:16:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 207185C0080;
        Sat, 26 Nov 2022 14:16:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 26 Nov 2022 14:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669490198; x=1669576598; bh=M7EPshB7W7XmXZsnaKJ1Jh7xA
        ayYTnVyi38A+Cdf158=; b=fiipHUSG5HUsY0rj9sFAIRYo91pZ/V2qyYK2a2mpZ
        5ejmy8kAXmGVksqWLdTaVW9BtZTeWn8zVCig/ditGo7qlLEQ/otdyXGV3ySNGgRA
        GSE3IX42/LMlHimDnrHXMciqhd/ZGVHrP/DR8hW5vpo1wFC6Zmce/gBdjbM1zu+j
        y2dBrPASdAlquLXqXuPiWBGWj/g6dGpm9a/DIybRkClBVlQ5K0FDri52lR0AvjcS
        K8BVopYn/+nBAQkC2o5+nJJIQDZcuVLJoL352tXKEtEMQ//Vlx2a21A+lvEKW6Jw
        irgjYyy9/0rkPHPvHM8SAez6Vv2FbDhXAvjPXXe/ixncA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669490198; x=1669576598; bh=M7EPshB7W7XmXZsnaKJ1Jh7xAayYTnVyi38
        A+Cdf158=; b=cBLL/19fpvDhvBNLNAEZ4w+zUMsiseZENBA8wPfLjvvp0g5eK3w
        VPNz0VqiwnA+NO4I7Q51XDEM+h8Tb/Cxshso/9JvxEDh7IsPj5vbqgXr6tEoRSmB
        PRTY4Vi6YBcS1/obv0/dnhFRpjBv2XO6sJadbIdsIhmEHWqmttN+Zenz7dmMSCo6
        ZEk/207s1cgoLzNBx5tqR898FMf/Ln4lqJ6ucNxrgo/emUJIsN7Jw72zoMWNj74s
        7y4NF9EhIEe2ClzFS8DTvOr1QuescgmnA9ae5W06+Gx6Bj+aTEH5RWUxLUIHqaB4
        5q5zNqOLVrTuJC59gb8dADdKRAQvfTHNJxw==
X-ME-Sender: <xms:FWaCY6CBGe6KXjhlqeewLQIx_vB18FCYYAPcjT5m0Z1mTjgVgDprwQ>
    <xme:FWaCY0gNyNKhj6Fiy1XJVV5RcL9MyLaovz3bRW80wbODHJBOS-jnAoFQsNMCeuARK
    PYhkoAhFW2ssZUr7g>
X-ME-Received: <xmr:FWaCY9mv3CCKZDBtd2maxAV3g-JAr8mcB0plToVHHXFyxEt_Vu65eidXCZu2gXlIqpixuHH5Sc0JDNCfcaTCkAebKDzhpqJ45tCdW1TbJ_mj9-mTmiY7Pu2VrmiDqWllvbB6uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FWaCY4xB49LAJM29IXKBIpDuvKt1QYSp_BZlhpztZz7ZosxPWivNew>
    <xmx:FWaCY_R0-gh013bc0SxG-bvs3tRwEmT2BvmO1rAPxlopAo1K4n5u-Q>
    <xmx:FWaCYzagjcFvVu5Xi7DNLTNOeYMZ7OxPlJXVqr2tvk-3natwzkRnpQ>
    <xmx:FmaCY4R57ws_sMay55q3zvyDq1SZoKvggCk07VsTy1TjOsac4VLExg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:16:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] pinctrl: sunxi: d1: Add CAN bus pinmuxes
Date:   Sat, 26 Nov 2022 13:16:36 -0600
Message-Id: <20221126191636.6673-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

From: Fabien Poussin <fabien.poussin@gmail.com>

The D1 pin controller contains muxes for two CAN buses. While the CAN
bus controllers are only documented for the T113 SoC, the pin controller
is the same across all SoC variants.

Signed-off-by: Fabien Poussin <fabien.poussin@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
index 40858b881298..9cc94be1046d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
@@ -47,6 +47,7 @@ static const struct sunxi_desc_pin d1_pins[] = {
 		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN2 */
 		SUNXI_FUNCTION(0x6, "lcd0"),		/* D18 */
 		SUNXI_FUNCTION(0x7, "uart4"),		/* TX */
+		SUNXI_FUNCTION(0x8, "can0"),		/* TX */
 		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 2)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
 		SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -57,6 +58,7 @@ static const struct sunxi_desc_pin d1_pins[] = {
 		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN0 */
 		SUNXI_FUNCTION(0x6, "lcd0"),		/* D19 */
 		SUNXI_FUNCTION(0x7, "uart4"),		/* RX */
+		SUNXI_FUNCTION(0x8, "can0"),		/* RX */
 		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 3)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
 		SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -67,6 +69,7 @@ static const struct sunxi_desc_pin d1_pins[] = {
 		SUNXI_FUNCTION(0x5, "i2s2_din"),	/* DIN1 */
 		SUNXI_FUNCTION(0x6, "lcd0"),		/* D20 */
 		SUNXI_FUNCTION(0x7, "uart5"),		/* TX */
+		SUNXI_FUNCTION(0x8, "can1"),		/* TX */
 		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 4)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
 		SUNXI_FUNCTION(0x0, "gpio_in"),
@@ -77,6 +80,7 @@ static const struct sunxi_desc_pin d1_pins[] = {
 		SUNXI_FUNCTION(0x5, "pwm0"),
 		SUNXI_FUNCTION(0x6, "lcd0"),		/* D21 */
 		SUNXI_FUNCTION(0x7, "uart5"),		/* RX */
+		SUNXI_FUNCTION(0x8, "can1"),		/* RX */
 		SUNXI_FUNCTION_IRQ_BANK(0xe, 0, 5)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
 		SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.37.4

