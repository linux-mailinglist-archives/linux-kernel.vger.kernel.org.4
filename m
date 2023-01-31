Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A86827E3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAaJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjAaI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:59:57 -0500
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A774B498;
        Tue, 31 Jan 2023 00:56:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaW3FKV_1675155272;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VaW3FKV_1675155272)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 16:54:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     s.shtylyov@omp.ru
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] libata: clean up some inconsistent indenting
Date:   Tue, 31 Jan 2023 16:54:31 +0800
Message-Id: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ata/pata_serverworks.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index c0bc4af0d196..c6bd9e95d4e8 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
 
-		 /* If the returned btr is the newer revision then
-		    select the right info block */
-		 if (rc == 3)
-		 	ppi[0] = &info[3];
+		/* If the returned btr is the newer revision then select the right info block */
+		if (rc == 3)
+			ppi[0] = &info[3];
 
 		/* Is this the 3rd channel CSB6 IDE ? */
 		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)
-- 
2.20.1.7.g153144c

