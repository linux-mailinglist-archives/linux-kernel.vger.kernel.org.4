Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F626BE154
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCQGhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:37:33 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4656A9C6;
        Thu, 16 Mar 2023 23:37:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CBD441A009B6;
        Fri, 17 Mar 2023 14:37:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Irp1uxalvEwb; Fri, 17 Mar 2023 14:37:32 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4D4401A00993;
        Fri, 17 Mar 2023 14:37:31 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] crypto: caam - remove unnecessary (void*) conversions
Date:   Fri, 17 Mar 2023 14:36:43 +0800
Message-Id: <20230317063643.27075-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/crypto/caam/dpseci-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/dpseci-debugfs.c b/drivers/crypto/caam/dpseci-debugfs.c
index 0eca8c2fd916..020a9d8a8a07 100644
--- a/drivers/crypto/caam/dpseci-debugfs.c
+++ b/drivers/crypto/caam/dpseci-debugfs.c
@@ -8,7 +8,7 @@
 
 static int dpseci_dbg_fqs_show(struct seq_file *file, void *offset)
 {
-	struct dpaa2_caam_priv *priv = (struct dpaa2_caam_priv *)file->private;
+	struct dpaa2_caam_priv *priv = file->private;
 	u32 fqid, fcnt, bcnt;
 	int i, err;
 
-- 
2.11.0

