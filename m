Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06068AA9B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjBDOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBDOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:35:49 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5A303DA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:35:21 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 381CD5C00BC;
        Sat,  4 Feb 2023 09:35:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 04 Feb 2023 09:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675521321; x=1675607721; bh=E9
        RXjzAMWwCZjLz8gcyf65T0pEMdRjhGQmaREoREwGo=; b=rpmeq7B6G98Sb0ovmV
        /51tGFKPb17uOp6IcbhUo+2F5xZ4hdJnQiwP7EaBFneyEPUQ5qS9GwD08XSBDaWp
        Sn+I5GMkIZ+EjqN6E290wZOKxDMjMmuFa0J07kMWTB5+3GyGvCJfEYetWjgYHkZj
        hhR4Wnqseb3xlfjJE4hKbUCa1C6fUjDWF83mtt93Q4lpdgmCg1vHo5B8OmTbzvzF
        UtABhwXsMMPJzI9+2BCsd5oAo6sdwTwgcsNYsi90YbE/SbF1sarfiqK3eJf3DLPF
        aPuewV5VVyHMUI7KxxBREawzWmIPsoTXDyBK/GaHd1PanSV6xdei9LgsGd0mXn+d
        zvgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675521321; x=1675607721; bh=E9RXjzAMWwCZj
        Lz8gcyf65T0pEMdRjhGQmaREoREwGo=; b=VRCiq62Lo2m8Z18aKjFbeQsaUsS/w
        AWOcRclqnRcPJ5bKWl1EJ21KaBPkfl7yCa+aoREGyF09sXkvOnLicVyHmbuKnyjb
        8txpfy9eKGIDSamuiloSNHj28yK1vGZvvyOFpBuZE8tklJUCd2j0wCB4FKk3AfKR
        HUx6T0hail2uIZa6yhyC2nwyfRdQwBu9FydoE5vMYia0dwX4KYIsqd3okNmAdMCd
        lGmI4eG0hrQjBKUubkkeNKfaJgmN1Oz6cgiFi0B4yqhF10mzRw4st807MXJ4OjPe
        Bnhdc7JcunttrRw6uMYH/jQIVmxNQrvgtQgCOaLuC5qlfiVxT0wFXET6g==
X-ME-Sender: <xms:KG3eY9SGkCmUtWP_DBs8gRxRz_iyFU8rCyFX3GugG3e9E4Xup7HnNg>
    <xme:KG3eY2z8EfdS46OCCe6JzLa2_okHnu8BFW07KIoEtyyDHs3oBWm_BiV5awwWoUtkD
    x8wM5kKNm3viS9G-Q>
X-ME-Received: <xmr:KG3eYy3aYa43biFYV9-recLE3ZuYbUKG48_fieqfwhoL61HGm5W0AeG0w5m5UWym_pR3YiGBUP-tkBrokY09wZTAmqAFTHc0N-ok3i_d3J4VuLdRRzJFTIHNCobZOOHtc10LjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:KG3eY1C_DZYTIBV6ZHdgFZJPEuO4kCHTj3icNqVc3uTzvjye1C6JXg>
    <xmx:KG3eY2gZwDd0VxMgSHtspBYTiUoD8r3q0v5bZlhRN_zoYE9z1Xd9Lw>
    <xmx:KG3eY5rdZHCl1mxTjrmqH2-5LFoVignlQKX28mQKxrFFP7oRvzbBeQ>
    <xmx:KW3eYxNUUQJ3KFanUBXy0aXqttX2F9TrG8w8nU9ijyqCO59JvV1BpQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 09:35:20 -0500 (EST)
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
Subject: [PATCH v2 3/3] mtd: rawnand: sunxi: Precompute the ECC_CTL register value
Date:   Sat,  4 Feb 2023 08:35:20 -0600
Message-Id: <20230204143520.9682-4-samuel@sholland.org>
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

The value computed by this function never changes for a given chip.
Compute the whole register value once up front, instead of every time
the ECC engine is enabled.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Split ECC_CTL precomputation and structure updates to two patches

 drivers/mtd/nand/raw/sunxi_nand.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index a0d0cb17c150..13e3e0198d15 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -172,10 +172,10 @@ struct sunxi_nand_chip_sel {
 /**
  * struct sunxi_nand_hw_ecc - stores information related to HW ECC support
  *
- * @mode: the sunxi ECC mode field deduced from ECC requirements
+ * @ecc_ctl: ECC_CTL register value for this NAND chip
  */
 struct sunxi_nand_hw_ecc {
-	int mode;
+	u32 ecc_ctl;
 };
 
 /**
@@ -689,26 +689,15 @@ static void sunxi_nfc_hw_ecc_enable(struct nand_chip *nand)
 {
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
-	u32 ecc_ctl;
-
-	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
-	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
-		     NFC_ECC_BLOCK_SIZE_MSK);
-	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(sunxi_nand->ecc.mode) |
-		   NFC_ECC_EXCEPTION | NFC_ECC_PIPELINE;
-
-	if (nand->ecc.size == 512)
-		ecc_ctl |= NFC_ECC_BLOCK_512;
 
-	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
+	writel(sunxi_nand->ecc.ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
 }
 
 static void sunxi_nfc_hw_ecc_disable(struct nand_chip *nand)
 {
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 
-	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
-	       nfc->regs + NFC_REG_ECC_CTL);
+	writel(0, nfc->regs + NFC_REG_ECC_CTL);
 }
 
 static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
@@ -1693,8 +1682,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 		return -ENOTSUPP;
 	}
 
-	sunxi_nand->ecc.mode = i;
-
 	/* HW ECC always request ECC bytes for 1024 bytes blocks */
 	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
 
@@ -1726,6 +1713,12 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
 	ecc->read_oob_raw = nand_read_oob_std;
 	ecc->write_oob_raw = nand_write_oob_std;
 
+	sunxi_nand->ecc.ecc_ctl = NFC_ECC_MODE(i) | NFC_ECC_EXCEPTION |
+				  NFC_ECC_PIPELINE | NFC_ECC_EN;
+
+	if (ecc->size == 512)
+		sunxi_nand->ecc.ecc_ctl |= NFC_ECC_BLOCK_512;
+
 	return 0;
 }
 
-- 
2.37.4

