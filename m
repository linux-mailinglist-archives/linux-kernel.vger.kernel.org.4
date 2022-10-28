Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861BF61132D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJ1Nlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJ1NlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:41:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84E1D0DE;
        Fri, 28 Oct 2022 06:39:43 -0700 (PDT)
X-QQ-mid: bizesmtp85t1666964372tfffxa84
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:39:31 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: QdNbrVbAPlsajaQLQNBIO0e7EY+lrDavGOStFJrSmuWqoHFnq0+3ohuPz56XK
        utdFpdxxeHaXjVQOZxuRJvtMwUXoDn1EQGat5/55zWbi/1z92fAeCVVX7KzzvtAGVT87vt8
        lSbl/0f6H3u1KJ6zPbQ9CIMbXackQb7Lcx3Ju5f7RKqiPb6wx2aQlhYMW15XEbeg91uy0Ir
        vaSAjJfXN9OaJWqAmaMwQY5MbErE1f1EfOKKetwEYXpe1Z78WEyW5UOUXx+QjeHAD6GyQsM
        UCd4nHAtxKvnzH40JM4yWwZxvW1HUTKTRXJ5+d2b5clc6Xj96IQE2YqPmEzzHzLS8UZW9z5
        nsm9Vb+1k2iU21SnEJaasqAeZFaafc012WxQSW18ahWKkoG1fMmiuUzRjxlHcYbWJomaQRu
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: mpt3sas: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:39:25 +0800
Message-Id: <20221028133925.62011-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'be'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 0d8b1e942ded..a44a44690f19 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -313,7 +313,7 @@ mpt3sas_ctl_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
  * @event: firmware event
  *
  * The bitmask in ioc->event_type[] indicates which events should be
- * be saved in the driver event_log.  This bitmask is set by application.
+ * saved in the driver event_log.  This bitmask is set by application.
  *
  * Return: 1 when event should be captured, or zero means no match.
  */
-- 
2.36.1

