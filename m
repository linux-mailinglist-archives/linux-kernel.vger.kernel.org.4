Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB168740F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBBDlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBBDlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:41:31 -0500
X-Greylist: delayed 541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 19:40:41 PST
Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7057C30D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:40:40 -0800 (PST)
Received: from zmtaout01.partage.renater.fr (zmtaout01.partage.renater.fr [194.254.240.30])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id 934DC63B9C;
        Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zmtaout01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTPS id 854F11A0052;
        Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 7C5D21A0136;
        Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zmtaout01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaout01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zgCSZa5XFuWt; Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zstore-b0-026.partage.renater.fr (zstore-b0-026.partage.renater.fr [10.254.240.112])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 423211A0052;
        Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Date:   Thu, 2 Feb 2023 04:31:31 +0100 (CET)
From:   Irvin Cote <irvin.cote@insa-lyon.fr>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <640656069.60824897.1675308691167.JavaMail.zimbra@insa-lyon.fr>
Subject: Subject: [PATCH] nvme : host : pci.c : Replace int literal by
 corresponding macro
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - GC103 (Linux)/8.8.15_GA_4372)
Thread-Index: qiw6HH2UZ+bOg83eGL16PHPXCNGd1w==
Thread-Topic: Subject: [PATCH] nvme : host : pci.c : Replace int literal by corresponding macro
X-Virus-Scanned: clamav-milter 0.103.6 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkufggtgfgofhtsehtjegttdertdejnecuhfhrohhmpefkrhhvihhnucevohhtvgcuoehirhhvihhnrdgtohhtvgesihhnshgrqdhlhihonhdrfhhrqeenucggtffrrghtthgvrhhnpeeiuddtveeivdekhfekffetfeefieduudejueejteejffetveekhffftdekudehteenucfkphepuddtrddvheegrddvgedtrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvheegrddvgedtrdduuddvpdhhvghlohepiihsthhorhgvqdgstddqtddviedrphgrrhhtrghgvgdrrhgvnhgrthgvrhdrfhhrpdhmrghilhhfrhhomhepkfhrvhhinhcuvehothgvuceoihhrvhhinhdrtghothgvsehinhhsrgdqlhihohhnrdhfrheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehfsgdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
 vghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e88b6a92c2447c2d5a343ca53cd735f4f83848d0 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvincoteg@gmail.com>
Date: Wed, 1 Feb 2023 23:14:25 -0300
Subject: [PATCH] nvme : host : pci.c : Replace int literal by corresponding macro
When re-setting the dbs field of the nvme_dev struct in the
nvme_pci_enable function, a integer literal is used to represent the offset
instead of the dedicated macro NVME_REG_DBS.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..ba65299636e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2540,7 +2540,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-	dev->dbs = dev->bar + 4096;
+	dev->dbs = dev->bar + NVME_REG_DBS;

 	/*
 	 * Some Apple controllers require a non-standard SQE size.
--
2.37.2
