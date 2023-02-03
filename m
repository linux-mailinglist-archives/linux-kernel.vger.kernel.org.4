Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC068926D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjBCIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjBCIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:38:13 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588C9770;
        Fri,  3 Feb 2023 00:38:12 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 90D2E1A00A61;
        Fri,  3 Feb 2023 16:38:38 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VJ64y10Zm-3J; Fri,  3 Feb 2023 16:38:37 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 340A51A00A0A;
        Fri,  3 Feb 2023 16:38:37 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] fsi: fix some spelling mistakes in comment
Date:   Fri,  3 Feb 2023 16:37:21 +0800
Message-Id: <20230203083721.23455-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in comment.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 +-
 drivers/fsi/fsi-sbefifo.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 5f608ef8b53c..5fcf2514642b 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1133,7 +1133,7 @@ static int fsi_master_acf_gpio_request(void *data)
 
 	/* Note: This doesn't require holding out mutex */
 
-	/* Write reqest */
+	/* Write request */
 	iowrite8(ARB_ARM_REQ, master->sram + ARB_REG);
 
 	/*
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..0a0313c409a9 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -81,7 +81,7 @@
 
 enum sbe_state
 {
-	SBE_STATE_UNKNOWN = 0x0, // Unkown, initial state
+	SBE_STATE_UNKNOWN = 0x0, // Unknown, initial state
 	SBE_STATE_IPLING  = 0x1, // IPL'ing - autonomous mode (transient)
 	SBE_STATE_ISTEP   = 0x2, // ISTEP - Running IPL by steps (transient)
 	SBE_STATE_MPIPL   = 0x3, // MPIPL
@@ -730,7 +730,7 @@ static int __sbefifo_submit(struct sbefifo *sbefifo,
  * @response: The output response buffer
  * @resp_len: In: Response buffer size, Out: Response size
  *
- * This will perform the entire operation. If the reponse buffer
+ * This will perform the entire operation. If the response buffer
  * overflows, returns -EOVERFLOW
  */
 int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
-- 
2.11.0

