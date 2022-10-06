Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9965F60A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJFFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJFFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:32:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F18A7CB;
        Wed,  5 Oct 2022 22:32:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Mjg7365n6z9srM;
        Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BBw-GaoHTb0D; Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Mjg735Bf1z9srL;
        Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 98B568B765;
        Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7mp3JBzDTH5l; Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A8DC8B763;
        Thu,  6 Oct 2022 07:32:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2965W12r212478
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 07:32:01 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2965W0BI212477;
        Thu, 6 Oct 2022 07:32:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: mac_scsi: Replace NO_IRQ by 0
Date:   Thu,  6 Oct 2022 07:32:00 +0200
Message-Id: <f11593e75ba2e18e3b76989255cbb2e53a0213b4.1665034244.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665034319; l=1720; s=20211009; h=from:subject:message-id; bh=eXtfh1J1qDXaXAXSJZOMjCbd65v9KlkYmL7nMCnCJQk=; b=VP7cTuxbFIB/m12IaWne/FUOukr8uNjLZCtd9xWgumlb+8TaXaNE/njuxGRXqeFiybaQ3t1sS8lI 4i5UWsKQD1rLQCBLopHbjaPN85QE0u6iFkwuavgk7QjSfUh3/fzZ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_IRQ is used to check the return of irq_of_parse_and_map().

On some architecture NO_IRQ is 0, on other architectures it is -1.

irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.

So use 0 instead of using NO_IRQ.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/scsi/mac_scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 2e511697fce3..e4df2b501e8b 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -478,7 +478,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
 	if (irq)
 		instance->irq = irq->start;
 	else
-		instance->irq = NO_IRQ;
+		instance->irq = 0;
 
 	hostdata = shost_priv(instance);
 	hostdata->base = pio_mem->start;
@@ -495,7 +495,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
 	if (error)
 		goto fail_init;
 
-	if (instance->irq != NO_IRQ) {
+	if (instance->irq) {
 		error = request_irq(instance->irq, macscsi_intr, IRQF_SHARED,
 		                    "NCR5380", instance);
 		if (error)
@@ -514,7 +514,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
 	return 0;
 
 fail_host:
-	if (instance->irq != NO_IRQ)
+	if (instance->irq)
 		free_irq(instance->irq, instance);
 fail_irq:
 	NCR5380_exit(instance);
@@ -528,7 +528,7 @@ static int __exit mac_scsi_remove(struct platform_device *pdev)
 	struct Scsi_Host *instance = platform_get_drvdata(pdev);
 
 	scsi_remove_host(instance);
-	if (instance->irq != NO_IRQ)
+	if (instance->irq)
 		free_irq(instance->irq, instance);
 	NCR5380_exit(instance);
 	scsi_host_put(instance);
-- 
2.37.1

