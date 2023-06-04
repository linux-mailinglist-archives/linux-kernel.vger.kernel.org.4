Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6347214B6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjFDExG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFDExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:53:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F400FD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 21:52:57 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5fjZqns8y8SAU5fjZqOpgA; Sun, 04 Jun 2023 06:52:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685854375;
        bh=lyyRlrC3KmRbFllkxLGkBpc9Qfqgsg8QHBWroitmBNg=;
        h=From:To:Cc:Subject:Date;
        b=BjuY3g6VMj9Z54gwTuPn+Zznrg4H2rJPBowIME/+4rVatdQx6UCiJiqTEoU5bLoMn
         rlaVunUL0vtQ2lQA6mkbmCx2OoLs6JrezKqwp06PqILz6Hx2S5bYS3RTIiKMSbi9Hh
         RClM/PsViCQTwrpXTd+99qAP31Zk7wFkL4rKHS4rG+t2Qb0EizBJaXrq+yxGE71xKZ
         EZhJNZBWHYmZDcmm/o+Cw5u8DOtZLiv8b1fEV9cxl3J4Q5MDmB44dcjLd27RJr/5NE
         MPT/rxGbXjUQNz2j7pTpiYfeGWXAxypdz0GcP0ljt4szhIT86J99fW6V9xFQoyk7U8
         Rctm0kGx3OEWA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 06:52:55 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] qla2xxx: Drop useless LIST_HEAD
Date:   Sun,  4 Jun 2023 06:52:42 +0200
Message-Id: <49bb77624c9edc8d9bf8fe71d0c8a4cd7e582175.1685854354.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'new_fcports' is unused, so drop it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Usage of new_fcports has been removed in commit 726b85487067 ("qla2xxx: Add
framework for async fabric discovery")
---
 drivers/scsi/qla2xxx/qla_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 95ae754582e7..f1724c7d39d5 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6220,7 +6220,6 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 	fc_port_t	*fcport;
 	uint16_t	mb[MAILBOX_REGISTER_COUNT];
 	uint16_t	loop_id;
-	LIST_HEAD(new_fcports);
 	struct qla_hw_data *ha = vha->hw;
 	int		discovery_gen;
 
-- 
2.34.1

