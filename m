Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63316590C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiL2TJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiL2TJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:09:15 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6F14D21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 11:09:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4B0AC32005D8;
        Thu, 29 Dec 2022 14:09:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Dec 2022 14:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672340953; x=1672427353; bh=Oe
        tE2bxovRIangZAcEXPm1k/wwprZFIdljerdmOvL5k=; b=z4sXU0z9KwQ/Kg83h7
        sbWlXjkOurNEooNA217bA08r//0RDtspxbBwOI6NO2K2bO8YGsEogxjq7Sdm2D5J
        OthmUOnInOWy0KgHpxmmCyVsD9a7kyQfkcTBXnAg16WaNulvbj0kfw3VmqXt6VK6
        0esUtXoh0aVSTboM6pvjNskn6+mItOwiG8GoEyM8XaMBTm1oMdk6k0YLOLKF1CmT
        QtvIOdOPGP7afW9NhjL3+UVDPNiDyu2kXDWMjtbL25U44YX0qyOHxIKa7jaTUrFc
        Z+YuOcJ4sgqDdSOVOma3CMPNtpHKQtzfM1xcSvPwNjhc/8Dlf3tZY1+vVm7Pfm2p
        kA+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672340953; x=1672427353; bh=OetE2bxovRIan
        gZAcEXPm1k/wwprZFIdljerdmOvL5k=; b=o0eLNsmvWdbUeeogoD51FWyjlsD9v
        rx55U86WMdn8eGJu5EqpwMO6CzwKf7t6P7+e4DYKAA+jBlB1i+lKV8XfhfeJQ+5/
        yo6izADBmkdcfly8pQMad9+hAfFRKx6XVtYhSBxTHQrEH3sM4kdlaSV49BXdkaeP
        uO55arWu254q9/LQz4XbzeXSDdm+3tJj2D6EAHy1br3zCn005s2oiiwqs9pnqT7N
        Xv6owK4TxV5xRt7J8rZJ4gpXLtURDY7/kVeXQJRuPv2/qzrG3u0bXvrM7eKLLR1j
        qGrYnCVqK86rX1Qn9hQkNC3btIvPCDY1XW5+5zOXc7CHZz34iLJa+6rRQ==
X-ME-Sender: <xms:2eWtYyHeIqTazav3WooCyjlRsvbZ1ACUtk9EpmIezgnoziICfnInyQ>
    <xme:2eWtYzVWzOKVbMskhFzN7tbChe-torzgMJ9VFEqSI03rReV_Ht6GmoTJbQ2V6EtBY
    FBZLoI_jcQgYoJhqQ>
X-ME-Received: <xmr:2eWtY8KqsIxVkd1Bji5fh4dbszIlo_5vIzzQYrLy1LggV7krH3MmS2OFI5n2SiWfKyNUdIio4iubummexYlBvUBdvyiVW_mp65sMryS9x_3l0BWYIOHlZs271FRF9Y7Wyuev2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:2eWtY8FsXoycn3r8EqNFzWFI1EfqNQJIeHgKn_roFLNVpnNVxur1wQ>
    <xmx:2eWtY4V4GXbxIxbiuzSd-6E6bLdkbxiiQ8jLZhjyhGYHf9rPrMsG2A>
    <xmx:2eWtY_NqohxATKNqahn0sRMUMLuKVQmnAvZMeof-agq2Orjl2UlwGA>
    <xmx:2eWtY2y-ABsyZXIO3Y6zuExuI8kIdBMfAzRVWqxzLdvUcfV6W99z_A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 14:09:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 3/3] mtd: rawnand: hynix: Expose the full H27UCG8T2FTR-BC chip size
Date:   Thu, 29 Dec 2022 13:09:05 -0600
Message-Id: <20221229190906.6467-4-samuel@sholland.org>
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

This chip has slightly more than 8K pages. Now that non-power-of-two
chip sizes are supported, make the full chip available for use.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mtd/nand/raw/nand_ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 167183ccb9e9..f20a65aa090f 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -57,7 +57,7 @@ struct nand_flash_dev nand_flash_ids[] = {
 		  NAND_ECC_INFO(40, SZ_1K) },
 	{"H27UCG8T2FTR-BC 64G 3.3V 8-bit",
 		{ .id = {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a} },
-		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
+		  SZ_16K, 8448, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
 		  NAND_ECC_INFO(40, SZ_1K) },
 	{"TH58NVG2S3HBAI4 4G 3.3V 8-bit",
 		{ .id = {0x98, 0xdc, 0x91, 0x15, 0x76} },
-- 
2.37.4

