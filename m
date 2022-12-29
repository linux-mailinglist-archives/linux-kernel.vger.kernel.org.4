Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CC659035
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiL2SPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiL2SPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:15:38 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4815F02
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:15:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DC4383200909;
        Thu, 29 Dec 2022 13:15:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 13:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672337736; x=1672424136; bh=2t
        sBIXORATjAZKv1+cfGVeLshq6JEsC7gla2AnZEybo=; b=fh1RYumAS9X7eYRhei
        C65sJt4y89btRu8tKd7ito5an3dh+TTDfrWQVEoD+4FsRjvfJ02mGnKl5Kh24B55
        lHcZe9lk8Md/DMiwOnMgf0c2heXSIz/yNqgKbbqaIxSnpAwASYYIF8WJbveV/ceX
        nedGcIpbiGKUNHy1sYyQkPA2i40lAaGOESD4hZcDIjZBUmRWiidyzmgcN9iWtlFr
        J7hd1ry8wVhvnJ2X9gYzUJlJNg++EEKxmNlNtPYqmTouLhIVAo8SNZ06wtal4UpO
        NwRIUJpRa9ttVaRyi4rTtMxzTrgS998Po6TXN8KNMTN67X0SAXkayOlmqqVsb7U6
        BEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672337736; x=1672424136; bh=2tsBIXORATjAZ
        Kv1+cfGVeLshq6JEsC7gla2AnZEybo=; b=QX397Uypyc5ERHvNfuUiyerBrpDqQ
        wTIr2Vlf8apX1gSTCsT6fzwkeuXxQnVkyNZwDSwPMyVoXY5eNaF+irs4ja363Ld+
        UmfSnSSVeOmlgs8fWHaPkgd78PoSRgIkuI3Js4pwUaTMZrdTYuaCoPsP8qtH9UzZ
        hViAM8RC2zyDwx3QNOD/Yot8VtdBad3UK8AbQ4CaI0b2ti/12ezjL530fOwIGqRj
        HV7FKNhdTq3Gce2QrCLP/2DSIBd7CeNa0bAy14cJluBfaRLV84h1BlpA9YqGxrHl
        wAV8gl1QCQwj1sPuPQBKAmvxQ+2Ezp/pZOAxppeUPsdOQX2+FtSFl2xCA==
X-ME-Sender: <xms:SNmtY0O4Ug9dlg0SfWriIAj1j4HwCjJGYAFl-2xTsrWCUZuaM03P9Q>
    <xme:SNmtY6_CfhdS15sEzASNfNJ5b9BmP1JKlpdHusyie_LRNmeayQOcmTRRRMLgW2WLT
    M_fkrXlbbINpti5kQ>
X-ME-Received: <xmr:SNmtY7R2lhbXQsnsCfA97jhvrsn9ZPxKOd4BVuees6sn17wbNa5M69mfh5ZAZgjhPs8uxlIbpx3he6_0t0mlwB4VVHjgFrOTyuNddD638Lpm2Ok_gICp3SxJCa_3y3_fvfsy6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SNmtY8uuiZcRgANGYBrTWHx3Wwn77EiME7H5vnU5HyVBwoVDZeLDKw>
    <xmx:SNmtY8eSEaKP0TKC0OoueUtuMmfDP-U0TyLWixWf6WOYXcJwkqHLUQ>
    <xmx:SNmtYw3ltC1nv4r0q3Z0L-Ex3CWoNqCk9gES6cxCsNuXlbCxqozbCg>
    <xmx:SNmtY9VkLvzMynObp_JbeyiMdlalC-IdLDN0TxjlUIZQoYUWfj5pww>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 13:15:35 -0500 (EST)
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
Subject: [PATCH 3/7] mtd: rawnand: sunxi: Remove an unnecessary check
Date:   Thu, 29 Dec 2022 12:15:22 -0600
Message-Id: <20221229181526.53766-4-samuel@sholland.org>
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

Each chip is required to have a unique CS number ("reg" property) in the
range 0-7, so there is no need to separately count the number of chips.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mtd/nand/raw/sunxi_nand.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 8b221f9f10a7..1bddeb1be66f 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2060,14 +2060,8 @@ static int sunxi_nand_chips_init(struct device *dev, struct sunxi_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
 	struct device_node *nand_np;
-	int nchips = of_get_child_count(np);
 	int ret;
 
-	if (nchips > 8) {
-		dev_err(dev, "too many NAND chips: %d (max = 8)\n", nchips);
-		return -EINVAL;
-	}
-
 	for_each_child_of_node(np, nand_np) {
 		ret = sunxi_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
-- 
2.37.4

