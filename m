Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666EE659037
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiL2SQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiL2SPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:15:45 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A1C27
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:15:44 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 46E033200909;
        Thu, 29 Dec 2022 13:15:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 13:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672337741; x=1672424141; bh=pV
        PQa7Oa9NfFrWw4kM0RTohv+m63gRRiGiW2YrMQGls=; b=T7T2dv2FzNpv6Y1oXC
        VKoZn8SgpVp7BdsTqlXkXUv5qY/hBC5D3CZl9W4ooEO2TTbdtcMVCl9h+t8DfOjl
        kHGs0eX+YSAFhbiybAd1wi4dy+2EKQ3+TmJiV1m/hMB7E/mEmoNRqjkprPDuVvbV
        sAOOUo22SPTyJRJGVTs4Ih1HeK6VA2ZnOlai3givXQDoeZlbimA8nMaYYPS1lBzf
        LenoTfnBO2Yn0/Umez2HX4QNk6SJ3TuUBCl7WpWh8Nu9BLDr6vmQfzAgs+8B8f0D
        gSbPcZBmya/vPN/TZg50jhy1XctvhHPehiK3QLpy/KbGy7Ivu6O/fiiJ79zGf4e6
        Q6GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672337741; x=1672424141; bh=pVPQa7Oa9NfFr
        Ww4kM0RTohv+m63gRRiGiW2YrMQGls=; b=rqn5MVdneV1TUbiOZC/jhWTOKZcSB
        Ru9uu0CwSsZHbzL6UabABW1+oWuwz+awkLUfbI8wG1DixZseEBmIszlAsOBNeJQt
        +NypcQy+Hv3+tS8vo1X3YFwpQTQDbNegHQMEozKXa5Qcr/GFTG5ABzp0EHDevjYD
        9NceDBOPUY2i5Y1VTFSuL9AsLk/J67E+DRSpgDMUdirj248v1AM5BQMRWUqb+GdJ
        AjciLSO+87PYviJOz4B+djZGKSqIeekBuJToXYQztdvqWkg0GS3RVvGAxDMpgDDm
        833MgTiUfDzLuoXj5CgQ/wMK2XIPE+cOed+wqM6KyH6BDgRd+eXclVpLg==
X-ME-Sender: <xms:TdmtYyE8Gw-37qTKUZgjdRjVCAMuMz3Ga69ZPmMsEK9pbm2Df65Pmw>
    <xme:TdmtYzVcADvw5p7gzA0WMFKBRGEpVwvEijVdBgE4SwIceH5hiRQke_LEDVx3Voe0e
    6YsiBqde61qnnLEzg>
X-ME-Received: <xmr:TdmtY8I4O2B6lUt6y6fU7j2kpKrX6_XT5KIruhMlUN1VdGuXUfot0m9pIABAp2E4SRQbs9O6rLDI6RGGTLJUYjOpLUxWyM-hRJc-Q_3EpC0OUCNLuOCze1apzCeqSiBq0MGWLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TdmtY8Hi8AF0hrL1-fPVxmAvyr0J4Vu9AuDBsh7lixrpBAY7TVV3MA>
    <xmx:TdmtY4W2eeMxUWl94MXH_LZ0xc7YdCmZO5DYpxujBC4npxJ2rrwSpQ>
    <xmx:TdmtY_PQUE5RPLVFd0_wxMbfhiRo648OWvULdd95oT1R0hVUElz_Qw>
    <xmx:TdmtYxP0_tkjYEFjfnvRBKSP2WJBpsxW0GMwXpaelX4YJs1mwUN5Mg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 13:15:41 -0500 (EST)
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
Subject: [PATCH 5/7] mtd: rawnand: sunxi: Fix the size of the last OOB region
Date:   Thu, 29 Dec 2022 12:15:24 -0600
Message-Id: <20221229181526.53766-6-samuel@sholland.org>
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

The previous code assigned to the wrong structure member.

Fixes: c66811e6d350 ("mtd: nand: sunxi: switch to mtd_ooblayout_ops")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1ecf2cee343b..8e873f4fec9a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1609,7 +1609,7 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section < ecc->steps)
 		oobregion->length = 4;
 	else
-		oobregion->offset = mtd->oobsize - oobregion->offset;
+		oobregion->length = mtd->oobsize - oobregion->offset;
 
 	return 0;
 }
-- 
2.37.4

