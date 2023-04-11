Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE36DD7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKKSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDKKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:18:33 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0F18E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:18:23 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id jNJM2900K1C8whw06NJMu1; Tue, 11 Apr 2023 12:18:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB46-00GaZK-Oy;
        Tue, 11 Apr 2023 12:18:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pmB4v-00EHAB-Qp;
        Tue, 11 Apr 2023 12:18:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Manoj N . Kumar" <manoj@linux.ibm.com>,
        "Matthew R . Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] scsi: Spelling s/semahpore/semaphore/
Date:   Tue, 11 Apr 2023 12:18:20 +0200
Message-Id: <d7d04004b818d7ab5d62002f286b0a1b0b493193.1681208251.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "semaphore".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/scsi/cxlflash/superpipe.c | 2 +-
 drivers/scsi/cxlflash/vlun.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 22cfc2e1dfb938d4..e1b55b03e81243b4 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -358,7 +358,7 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
 	dev_dbg(dev, "%s: %ssending cmd(%02x)\n", __func__,
 		retry_cnt ? "re" : "", scsi_cmd[0]);
 
-	/* Drop the ioctl read semahpore across lengthy call */
+	/* Drop the ioctl read semaphore across lengthy call */
 	up_read(&cfg->ioctl_rwsem);
 	result = scsi_execute_cmd(sdev, scsi_cmd, REQ_OP_DRV_IN, cmd_buf,
 				  CMD_BUFSIZE, to, CMD_RETRIES, &exec_args);
diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index 9caabf5504362cb2..cbd5a648a131be64 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -448,7 +448,7 @@ static int write_same16(struct scsi_device *sdev,
 		put_unaligned_be32(ws_limit < left ? ws_limit : left,
 				   &scsi_cmd[10]);
 
-		/* Drop the ioctl read semahpore across lengthy call */
+		/* Drop the ioctl read semaphore across lengthy call */
 		up_read(&cfg->ioctl_rwsem);
 		result = scsi_execute_cmd(sdev, scsi_cmd, REQ_OP_DRV_OUT,
 					  cmd_buf, CMD_BUFSIZE, to,
-- 
2.34.1

