Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C85B2F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIIGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIIGho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:37:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F911EA8E;
        Thu,  8 Sep 2022 23:37:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP5mW2N3Gz14QYX;
        Fri,  9 Sep 2022 14:33:47 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:37:37 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <htejun@gmail.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata: libata: remove ata_schedule_scsi_eh declaration
Date:   Fri, 9 Sep 2022 14:37:37 +0800
Message-ID: <20220909063737.1147983-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ata_schedule_scsi_eh has been removed since
commit f8bbfc247efb ("[PATCH] SCSI: make scsi_implement_eh() generic
API for SCSI transports"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/ata/libata.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2c5c8273af01..cb52afd695cf 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -121,7 +121,6 @@ extern void ata_scsi_set_sense_information(struct ata_device *dev,
 					   const struct ata_taskfile *tf);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
-extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
-- 
2.25.1

