Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942268AA9A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjBDOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjBDOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:35:44 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E46303D4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:35:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C3EDA5C012A;
        Sat,  4 Feb 2023 09:35:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 04 Feb 2023 09:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675521319; x=1675607719; bh=z8
        +r2WBFXUDnilpI4tJA/upCWvhtMve9E2bc0bx/InM=; b=BzP7c34VyWpM+TWZLt
        kWCITqpGjiDjHHl9cvQk+awGK4TbfJY3CJUMtNTU7vFA/qqEQJisyHd0mlSgI8Se
        M4X4YRgUlck5wtn63OdIE6uv4APVG5Ky5N7iS8NuncAd8zpGkvv2Xc+KAm3mgtK9
        wJaTSVNwPfwbSk8V0qJoNT8GMn9ZtgRvR7yN/MDb0RAij03j2msCBRNXSMTG1jxT
        qvUSzW3wL5YWkng35n+r1y6fpDOCkuPzqgiRq6mgV9459/aldVHspxQ8nqKSncfY
        iD6w51/18Frmmz0hVQPiWSakdBPG755WMxk4a5I69umHJx2e0lg8y9U5427GAo1J
        LgAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675521319; x=1675607719; bh=z8+r2WBFXUDni
        lpI4tJA/upCWvhtMve9E2bc0bx/InM=; b=eVxxNR24iCwEyy7vPhoQR0TBUeS44
        BYZp4hTfsQ6EWpQBdKtPyYtfLiIaH+XGAbpP5guCcHb3HLIo1P+XgSR474GVjIbt
        /meB13cH89phgFXQMJKcztjvYofH6hLPeAiiulwGUHgqnIMhD88XfzOlFZDCvIJk
        VsbRkXhUGuveTBfuP0+/OJeHWMbgYoYpTihZNkCZTykwJaKf7RhAAKmsIlvdHz7O
        GNwMR+vegwMSi2qZx4qGnxrA5URsYlIwK1Wb1W90zSSM/JhZ1J3+5tcT3aGNhwCa
        HCL3oQ42EYN2vThwclHLm3Nrr4kWpm3Snd0npHVEbiBIuLMfDv3lgr9WQ==
X-ME-Sender: <xms:J23eY90XcnnlFNClXUu-xmu30ApA-kny4v2MfnyrCXOVCmoAufTpYQ>
    <xme:J23eY0HTtiR0YfpjpovzgwmbLLh_jAW3w-z5IOAg09hKAkSA9bRJh9C9n_Jsnb9MB
    4gYA3QsZXAIfwMMQQ>
X-ME-Received: <xmr:J23eY96w8PhW31NyHEh6v2PRVl1hfqeLUVc2HREuOdP-b0Qtlq1QRTtEOc6NOqmlq0Er0fk6jE3Pmo4_PusfH_0re1NmP0NF6LXwphjq2s0KBPF8DwTivDeNJZCR_IMVUwhg9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:J23eY60u7hKt78efhnca3LhZkES-v_ylttMKdNmQPtvfppPpRc93hw>
    <xmx:J23eYwESGVfirjcDoHCrg9NNwNXtbILIUhArv84Mqqub01_D98FZQg>
    <xmx:J23eY78srJNOb7GK1k9GYYLv47xqBLlukHqamj7yXoAs-iPZMNBGLg>
    <xmx:J23eY7BUUM5iFiS5w82KeAqBX0LB-LTMSq5QwWRb2ldljtdQawrBvw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 09:35:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] mtd: rawnand: sunxi: Embed sunxi_nand_hw_ecc by value
Date:   Sat,  4 Feb 2023 08:35:19 -0600
Message-Id: <20230204143520.9682-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230204143520.9682-1-samuel@sholland.org>
References: <20230204143520.9682-1-samuel@sholland.org>
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

The sunxi_nand_hw_ecc object is not shared, and it has the same lifetime
as the sunxi_nand_chip which points to it, so we can embed it in the
outer structure instead of using a pointer. This removes an unnecessary
memory allocation and simplifies the error handling code.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Keep `struct sunxi_nand_hw_ecc` but change the pointer to a value
 - New patch for v2

 drivers/mtd/nand/raw/sunxi_nand.c | 45 +++++--------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 3c32d31f20aa..a0d0cb17c150 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -193,7 +193,7 @@ struct sunxi_nand_hw_ecc {
 struct sunxi_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
-	struct sunxi_nand_hw_ecc *ecc;
+	struct sunxi_nand_hw_ecc ecc;
 	unsigned long clk_rate;
 	u32 timing_cfg;
 	u32 timing_ctl;
@@ -694,7 +694,7 @@ static void sunxi_nfc_hw_ecc_enable(struct nand_chip *nand)
 	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
 	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
 		     NFC_ECC_BLOCK_SIZE_MSK);
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(sunxi_nand->ecc->mode) |
+	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(sunxi_nand->ecc.mode) |
 		   NFC_ECC_EXCEPTION | NFC_ECC_PIPELINE;
 
 	if (nand->ecc.size == 512)
@@ -1626,11 +1626,6 @@ static const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
 	.free = sunxi_nand_ooblayout_free,
 };
 
-static void sunxi_nand_hw_ecc_ctrl_cleanup(struct sunxi_nand_chip *sunxi_nand)
-{
-	kfree(sunxi_nand->ecc);
-}
-
 static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 				       struct nand_ecc_ctrl *ecc,
 				       struct device_node *np)
@@ -1641,7 +1636,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct nand_device *nanddev = mtd_to_nanddev(mtd);
 	int nsectors;
-	int ret;
 	int i;
 
 	if (nanddev->ecc.user_conf.flags & NAND_ECC_MAXIMIZE_STRENGTH) {
@@ -1676,10 +1670,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	if (ecc->size != 512 && ecc->size != 1024)
 		return -EINVAL;
 
-	sunxi_nand->ecc = kzalloc(sizeof(*sunxi_nand->ecc), GFP_KERNEL);
-	if (!sunxi_nand->ecc)
-		return -ENOMEM;
-
 	/* Prefer 1k ECC chunk over 512 ones */
 	if (ecc->size == 512 && mtd->writesize > 512) {
 		ecc->size = 1024;
@@ -1700,11 +1690,10 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 	if (i >= ARRAY_SIZE(strengths)) {
 		dev_err(nfc->dev, "unsupported strength\n");
-		ret = -ENOTSUPP;
-		goto err;
+		return -ENOTSUPP;
 	}
 
-	sunxi_nand->ecc->mode = i;
+	sunxi_nand->ecc.mode = i;
 
 	/* HW ECC always request ECC bytes for 1024 bytes blocks */
 	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
@@ -1714,10 +1703,8 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 
 	nsectors = mtd->writesize / ecc->size;
 
-	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors))
+		return -EINVAL;
 
 	ecc->read_oob = sunxi_nfc_hw_ecc_read_oob;
 	ecc->write_oob = sunxi_nfc_hw_ecc_write_oob;
@@ -1740,25 +1727,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->write_oob_raw = nand_write_oob_std;
 
 	return 0;
-
-err:
-	kfree(sunxi_nand->ecc);
-
-	return ret;
-}
-
-static void sunxi_nand_ecc_cleanup(struct sunxi_nand_chip *sunxi_nand)
-{
-	struct nand_ecc_ctrl *ecc = &sunxi_nand->nand.ecc;
-
-	switch (ecc->engine_type) {
-	case NAND_ECC_ENGINE_TYPE_ON_HOST:
-		sunxi_nand_hw_ecc_ctrl_cleanup(sunxi_nand);
-		break;
-	case NAND_ECC_ENGINE_TYPE_NONE:
-	default:
-		break;
-	}
 }
 
 static int sunxi_nand_attach_chip(struct nand_chip *nand)
@@ -1971,7 +1939,6 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 		ret = mtd_device_unregister(nand_to_mtd(chip));
 		WARN_ON(ret);
 		nand_cleanup(chip);
-		sunxi_nand_ecc_cleanup(sunxi_nand);
 		list_del(&sunxi_nand->node);
 	}
 }
-- 
2.37.4

