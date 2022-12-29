Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136C6590C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiL2TJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiL2TJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:09:12 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37C14D3F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 11:09:11 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 91F0D3200786;
        Thu, 29 Dec 2022 14:09:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Dec 2022 14:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672340950; x=1672427350; bh=26
        OVl7pfPjUCuTagaZGOenKInbPyTJjQTgFy1rxtBYQ=; b=1rOqAIpmu7OJxRRrWD
        Zg9QX/bWx2jqDmeTQg3mXE+S3f2iXjFA5VRSEYIAKhz3TqC1z26C4Ww69up8ZmPI
        sAFbYpTbj4XjE82+7HRPJmkrWsDAY7t9pWPGOi+hY7LPXwPadAX+hkjjl6U5g/YP
        C0B7LCvVGZYkNsGOdZN8ckXgmT2mBpC7wFKCTKE0ww04ERxhn/xhZNKQnzUFggkq
        3hJ2CCCKCykSl+qCPV/zrRMrtO90oE5qdv/16rVX8NZCe2ZWNyi9DWVlT+3AF51b
        1q283Y3XLHuT1p3igWKEJP6aR7oJJ12kkjFLJ1ca0ZOZIGYEwEnWlXKENOm0IRrx
        sXYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672340950; x=1672427350; bh=26OVl7pfPjUCu
        TagaZGOenKInbPyTJjQTgFy1rxtBYQ=; b=oein5zp1XyEl9w8dNi+CcdsUJs+9s
        4zovpuXNQAL3KwV+y3rdjurP34r7N2Ir6vaJxZ3FgxYIKhH3Rg99wFYM6dGwWLXl
        ZQytwE5bqCqUSVh9F6coLVSmSs5eJKnnL05mNDhfFcT/jmuIxcnQaDeBwHpWEzcl
        n+X1cjJL6WG4optJpEitcTzqSV/1y+USov9vX20L9p5TzXeJzyAU1D8+2DwQxluY
        uMUmwiR4gtrN+Y0/gfo0JJnJ45OCccYZnlUitU+A9H84ss2EqbfwzX779phnNvFQ
        8zWQj6YHDTdcw+Tu6U4xY+FCAlY3olP78XbvJ0GkCf2nc9G4eBHhBCKVw==
X-ME-Sender: <xms:1uWtY49K47hOBg76TsHofq8eOXNvYloJTFSejCTK6oMG6xnaV7Ha4Q>
    <xme:1uWtYwtVjfOSSYgNd85fTQOugYthDFcHi-QDU6sNf_Er9Xi9vw67DsCH1s9P_IZnH
    oO33jTaCAxK0rn5nA>
X-ME-Received: <xmr:1uWtY-BvGZVbLcmhpf4Uk8B4yadL_C0BC6FC6Get9bV2EsGi3KdiddYq1jfwCrfIzlFgkBF2DZEJcwgxLT8pnEg_6wIxZMBoPtLN869dxN4JzXWWumkldVk_pKg0hnQIth0EGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:1uWtY4dOu_1Ly8xvK86jaB1BhT_cbkNaBn3SNi49Hd_xhG2SrypJsQ>
    <xmx:1uWtY9N9BQRB5abLsfiv3Kst0QPlXRY_nAyFxiXwiggCVCVUH-0pPQ>
    <xmx:1uWtYynBzB7xyjUvdR47EhenlAlFgGN6t1fLRk78aup1xZnYX3hCWw>
    <xmx:1uWtYyrZxoVvF0anYcK_dai54NaJmseOTa5bnOJt_vVB-H11K9wfsA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 14:09:09 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/3] mtd: rawnand: hynix: Add support for H27UCG8T2FTR-BC MLC NAND
Date:   Thu, 29 Dec 2022 13:09:03 -0600
Message-Id: <20221229190906.6467-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221229190906.6467-1-samuel@sholland.org>
References: <20221229190906.6467-1-samuel@sholland.org>
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

H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, but
reports a different ID.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mtd/nand/raw/nand_hynix.c | 4 ++++
 drivers/mtd/nand/raw/nand_ids.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 0d4d4bbfdece..836f152612ab 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -721,6 +721,10 @@ static int hynix_nand_init(struct nand_chip *chip)
 		     sizeof("H27UCG8T2ETR-BC") - 1))
 		h27ucg8t2etrbc_init(chip);
 
+	if (!strncmp("H27UCG8T2FTR-BC", chip->parameters.model,
+		     sizeof("H27UCG8T2FTR-BC") - 1))
+		h27ucg8t2etrbc_init(chip);
+
 	ret = hynix_nand_rr_init(chip);
 	if (ret)
 		hynix_nand_cleanup(chip);
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index dacc5529b3df..167183ccb9e9 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -55,6 +55,10 @@ struct nand_flash_dev nand_flash_ids[] = {
 		{ .id = {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
 		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
 		  NAND_ECC_INFO(40, SZ_1K) },
+	{"H27UCG8T2FTR-BC 64G 3.3V 8-bit",
+		{ .id = {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a} },
+		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
+		  NAND_ECC_INFO(40, SZ_1K) },
 	{"TH58NVG2S3HBAI4 4G 3.3V 8-bit",
 		{ .id = {0x98, 0xdc, 0x91, 0x15, 0x76} },
 		  SZ_2K, SZ_512, SZ_128K, 0, 5, 128, NAND_ECC_INFO(8, SZ_512) },
-- 
2.37.4

