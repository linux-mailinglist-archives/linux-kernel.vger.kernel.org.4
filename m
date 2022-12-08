Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065C646ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLHImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLHIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:41:46 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FF61BA5;
        Thu,  8 Dec 2022 00:41:46 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5FBC63200406;
        Thu,  8 Dec 2022 03:41:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 08 Dec 2022 03:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670488903; x=1670575303; bh=o2
        7cKNM0F/yZT4+xauvXc0mBIO5hPIuXwZIEKjYIs/4=; b=uGBrY91JweDL0OZJUF
        3LGUk3EerYvwUZ3Qkdba7oX7StXpB8PlbJQuayR6sQQRPDSetbY/vgwLQt+mFFk9
        GnShE/4bxIiHgV54NMAzRj+HlIuNkoZmZsYNdeHnzUP2Vt/1ihRyMkZNkZOcYCwE
        vAwrugA0QSir/zGR26yswLaEvu1RBjfqsiSVsiMWZaDTcRGUYkRWCXvVo8Wp8l0V
        4MJVfUZnHDd4TKEzgC1NSJ9mJA3lw5Ci+TKsJj7D8wm6dIDlE1O74hXQTyVMrFKC
        Lzn4arLp/6liijLrKLV3ABGtNND37MVimDn22XUfFyqf7TxOMC8EvAoOtA+kLWAy
        Cdpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670488903; x=1670575303; bh=o27cKNM0F/yZT
        4+xauvXc0mBIO5hPIuXwZIEKjYIs/4=; b=p7S1ezHwMNotvpUjUmhCwhfxKbm2t
        w6wwpdzek3O0FQdyJWfur0FNgPmodmKr553+AfeGDqsY9A48xvc4fr/Gu/5xmXbp
        EpsmEysMjn1rk90tHxojvM2P/4LxCxAcv+uLjkzJGZ+xgIGp1vheL/rR5PYbiALM
        gYWgGZelfeSb1/Dk2lc4PyVTMbdhaFgO+R41aQ1uGzNGq+uPLLB/8PXSWkYZjFHo
        QhCMCo89lWfi//s6JpCsCUUaZwPRdSb2oZdh95Ke57teXvp8SBSyUK16fgSz5D8V
        DkXKI/J1xLw4QNGklrWkNBlgr6QDp9AT3hdvcClFJHcKc5GqloZy2FO/A==
X-ME-Sender: <xms:R6ORY0_S5trTL60xBjjq9ZUHEWMLXVxm1Wx887HWnkv-vqmUEjwpoQ>
    <xme:R6ORY8uhBEDQ3lhTfw2bzaQxlMxwbbo__4qG5ncSPVNcaF65BDkF2ahoJFVVemWQ3
    MswH1HPctoptLbaCw>
X-ME-Received: <xmr:R6ORY6Cd2ZPsksAxGFZUK2hxBfbFESSevn20CUgHqk_kL-qZyNy5YiEFnrWmtseRBWL0P3440yVCHw6-wyNOJLck-AN-sRu032nKVpAMdbQQw8V124yY06A6Hli6kMralpTblQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:R6ORY0dJqcuIphmfZLXksqznY6HpuNnKMz2ud24wIyZz5ofjilKyZw>
    <xmx:R6ORY5PBoSrIZfgl8nvWW3KzlV-RNWsOKd6IcYUmANIL7m0-fEHpmw>
    <xmx:R6ORY-kZNOlXuyRcpsccmAYRsn4gS-Y2_QoIP9TX5k8oIq0FtRccnQ>
    <xmx:R6ORY_uRs_aYVR-3yMymBd-5dCss312yWWmU3D7fBeYUnOkKb3dQBg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 03:41:43 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 4/4] soc: sunxi: sram: Only iterate over SRAM children
Date:   Thu,  8 Dec 2022 02:41:27 -0600
Message-Id: <20221208084127.17443-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208084127.17443-1-samuel@sholland.org>
References: <20221208084127.17443-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a regulators child is accepted by the controller binding, the
debugfs show routine must be explicitly limited to mmio-sram children.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v4)

Changes in v4:
 - Check the compatible string instead of the node name

Changes in v2:
 - New patch for v2

 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 92f9186c1c42..f09918c59042 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -120,6 +120,9 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
 	seq_puts(s, "--------------------\n\n");
 
 	for_each_child_of_node(sram_dev->of_node, sram_node) {
+		if (!of_device_is_compatible(sram_node, "mmio-sram"))
+			continue;
+
 		sram_addr_p = of_get_address(sram_node, 0, NULL, NULL);
 
 		seq_printf(s, "sram@%08x\n",
-- 
2.37.4

