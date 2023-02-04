Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6768AA99
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjBDOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:35:44 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B1303C8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:35:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B054B5C00B9;
        Sat,  4 Feb 2023 09:35:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 04 Feb 2023 09:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675521318; x=1675607718; bh=61
        GvcvGqifXGjlpRxQhnxPwFPnXxpQRMHUqsyFadDWM=; b=DF2eLDUVHpSGWO6758
        +QEqahfY/Hb+CUSaiLp1DAo6xhrgmRPH5eH2e5J5zH42HAKIoHlS4hEPluoc4ent
        r9WG1MyQsF8rbchtPqVCzKd/5aEa5HZ5BSQhoE+6op0ppF9ntlJl60Gvp4mIHQh5
        EbafbLwQCxCj+MXcRCGEMxsYApan947xCr095jqcERXsfX9XU1cCH0zM6mgfiwgM
        cHM+5HjN68uK0MQJ/j/47FlZcei3cFifUgua2Gl8UmCuGURYR5duTHTKYxPSSBLM
        snqbkOhsCRUBmww0NY4hI2Vp4UQLGwzUFcQHtkZbbvdSD/4D2GnaaRjFgeei6GyS
        tiiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675521318; x=1675607718; bh=61GvcvGqifXGj
        lpRxQhnxPwFPnXxpQRMHUqsyFadDWM=; b=OKhUJh7vsaK+Koi/YoPsoK/WYGiEh
        q1UuzlKhDwFuC6rQePucE1S5JECuG96sC6X8mINRb2MUXsw9JPyakyTaS1o5iba8
        YGzGdba/EOGN2TrNfBEvCmuo0vad3UCnegzoL2Hr6xPNFQ37UBL3+CyQ6NRbW7so
        SWBhEo3ips2rku8iDlVEAn0gcnm3g2mQW90wF4NMncdXvOWHNf+Jz+IXZY8dZC7c
        LB+F7r8OP3zBQG3Ghp1ArmnPROvsPCOIm14RSUu+lu9KKl5XeyHaPZiJNHClACRP
        mSDQdEnrdBKEpxeStp4U+kZ0qHeJMe2S9fCG3cSCNoht+B1RYsDLsH0WQ==
X-ME-Sender: <xms:Jm3eY5V_2TBHHNDvRfT7qnCPI8La46Rc2bi7lbG1V1k9YSzCFQ8-og>
    <xme:Jm3eY5lMjVDf5zODoeCJ_hW3-Hiikx-QdwuU0fSLPhptB7FIJnOPz1rIqwb-Qtj1Z
    KmkDuTL0N5ZitBy9g>
X-ME-Received: <xmr:Jm3eY1ZrZ4ETtet912ZQhYRqxNT07U5wVFIvhaeQ7_76Z_Z3Bsgd8BCCCeOFY0JomhK7w9wnGq3cFJTWeiM1HGqLDcx9vIrxbybkQP15Po8VV51n63ino9Fren1ebnxAQhymsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Jm3eY8Vjo89QoWPYTsa_rOb2KKY_Pgq5vSNhHkrFdHmMmr26hZwiRQ>
    <xmx:Jm3eYzk9FEANPS9gld05Tb_FrvPx00MrxxqouOyOA9kWwOOBQ-urUQ>
    <xmx:Jm3eY5fjEdeLSK7I_xXKZAKcH8--5WG1d5h40T4_IzmmOg3Kg8E4Fw>
    <xmx:Jm3eY8j_nDGYUPSWOlzjZ8gdm89SJBSew8gYJ5psaT-89drj1iXEIQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 09:35:17 -0500 (EST)
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
Subject: [PATCH v2 1/3] mtd: rawnand: sunxi: Update OOB layout to match hardware
Date:   Sat,  4 Feb 2023 08:35:18 -0600
Message-Id: <20230204143520.9682-2-samuel@sholland.org>
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

When using the hardware ECC engine, the OOB data is made available in
the NFC_REG_USER_DATA registers, as one 32-bit word per ECC step. Any
additional bytes are only accessible through raw reads and software
descrambling. For efficiency, and to match the vendor driver, ignore
these extra bytes when using hardware ECC.

Note that until commit 34569d869532 ("mtd: rawnand: sunxi: Fix the size
of the last OOB region"), this extra free area was reported with length
zero, so this is not a functional change for any stable kernel user.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Update commit message to address backward-compatibility concerns

 drivers/mtd/nand/raw/sunxi_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e673ac46f2e8..3c32d31f20aa 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1604,6 +1604,13 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 		return 0;
 	}
 
+	/*
+	 * The controller does not provide access to OOB bytes
+	 * past the end of the ECC data.
+	 */
+	if (section == ecc->steps && ecc->engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
+		return -ERANGE;
+
 	oobregion->offset = section * (ecc->bytes + 4);
 
 	if (section < ecc->steps)
-- 
2.37.4

