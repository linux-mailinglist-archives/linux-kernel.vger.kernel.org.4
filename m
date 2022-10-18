Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B100560268D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJRINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJRIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:13:29 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8B8FD74;
        Tue, 18 Oct 2022 01:13:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VSTkibi_1666080759;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSTkibi_1666080759)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 16:13:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] target: Remove the unused function transport_lba_64_ext()
Date:   Tue, 18 Oct 2022 16:12:35 +0800
Message-Id: <20221018081235.124662-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function transport_lba_64_ext() is defined in the target_core_sbc.c
file, but not called elsewhere, so remove this unused function.

drivers/target/target_core_sbc.c:276:34: warning: unused function 'transport_lba_64_ext'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2427
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/target/target_core_sbc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 1e3216de1e04..1cd41e3834bb 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -270,14 +270,6 @@ static inline unsigned long long transport_lba_64(unsigned char *cdb)
 	return get_unaligned_be64(&cdb[2]);
 }
 
-/*
- * For VARIABLE_LENGTH_CDB w/ 32 byte extended CDBs
- */
-static inline unsigned long long transport_lba_64_ext(unsigned char *cdb)
-{
-	return get_unaligned_be64(&cdb[12]);
-}
-
 static sense_reason_t
 sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags, struct sbc_ops *ops)
 {
-- 
2.20.1.7.g153144c

