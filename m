Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB836659034
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiL2SPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiL2SPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:15:36 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348215825
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:15:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4F4A332005CA;
        Thu, 29 Dec 2022 13:15:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 29 Dec 2022 13:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672337733; x=1672424133; bh=3a
        V9z+StwyUFCb1KZIw5zw5sA5TC8rfeKpSt342iQA4=; b=HCBLmtxDaRLWjQ3PmO
        RVtpnl8hUWpGTShjJs0fljEtjovO6DS8XAT+6ra5CXO2d1PQnu4ZG7pDuXEMnQOq
        jyEsK6GyqmPM5XDNG38WWYsnkoGUPRIURz0sOil0hRAzPCWUXzX/6hlQ85JwZ5t/
        mUjJpvTmCxCHeN+vkBpMYHiUef7i2qoYl4IKVxmlq3aegGxne6zmiuxB5bf3pgGf
        WbhzSmW0NemXiv4OsGvPe52s3ByQ9o1Y0FoEZpaWl4VgNVEHHWSv56/Vd8BUgazx
        RmV3zS2PbTXyKRlY2nQW6eK1kzfwV/nTruunpZj2NmBX1o+CzXXPXA3oxDfWve02
        U/Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672337733; x=1672424133; bh=3aV9z+StwyUFC
        b1KZIw5zw5sA5TC8rfeKpSt342iQA4=; b=NQsllsGthY0N7C5kKLbuJsdd3tqax
        BX6Mn48lGvTqhk+9mYSiSLXTkw+2LpYChus4TU6Tdo/UzbMVJ3CsiT4wyMZNLF9W
        5jEsCeWmABfvh5MuyJvx6CBA3OzIrXD2XxjSRFcMLNZOVlb5QFIvRrmXWy/Curgc
        FrSgLVpYiyA1BOHaPIi+P33YTEC84FV8VaBqv6a0UZAzahRliXwPEgCGeJq5jFuA
        s4TJNEC9JXWc0G33dzgzIZqJc7nkL/o3xu3aA4MYd+mitKpZYtYgn8WtRrStOev9
        VSTjJxiBJg4rVTOD1OwU7alPwXVelFYAq8+F+D/cHUi41eSRATBoTKFrw==
X-ME-Sender: <xms:RdmtY65Ybyzt0cBOtqPT1_FPzrn3YdlRKjXvp23khTs_YVhsShbHKw>
    <xme:RdmtYz4yc-H7BmM831q6M0NncfUqBZjYZLaEgpEgafa74rWOYQGG9n91uv3zGqXEM
    TWebYZ287Cndm0d3w>
X-ME-Received: <xmr:RdmtY5dwuImSEuQ91ksjTrK6QEBggd07D6KQOHxwiRUdTHiPPUMCxKKYN2NM6D3JqjKe_2tWJNK4dhfn3Rg4abbTAccxYSIZaTuJyOyiqrVXaMmWxJBB9abJIauMMssfmtf2-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:RdmtY3IGx1ooRqpZ4koOkrUuFdVdn8j191_yGE_E35jrZpuurbfG5Q>
    <xmx:RdmtY-Lu43-AulW3uo2Cn3pU1uQgTtDHOc8eii3mwI2pwLZX-YpV3g>
    <xmx:RdmtY4xe6vFrVB9Cdol7b7aZTFcUTaDl99RWbplLZOgb8z_QvLX4dw>
    <xmx:RdmtY7D9i8_IQelpV1UIwl1EURZOZfVTUWOU6OAP1dtWfwDj9K2yzg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 13:15:33 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/7] mtd: rawnand: sunxi: Remove an unnecessary check
Date:   Thu, 29 Dec 2022 12:15:21 -0600
Message-Id: <20221229181526.53766-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221229181526.53766-1-samuel@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
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

sunxi_nand->nsels cannot be zero, so the second check implies the first.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 2ee86f7b0905..8b221f9f10a7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -421,7 +421,7 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, unsigned int cs)
 	struct sunxi_nand_chip_sel *sel;
 	u32 ctl;
 
-	if (cs > 0 && cs >= sunxi_nand->nsels)
+	if (cs >= sunxi_nand->nsels)
 		return;
 
 	ctl = readl(nfc->regs + NFC_REG_CTL) &
-- 
2.37.4

