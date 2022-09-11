Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C95B4E82
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIKLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIKLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:40:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9E356EF;
        Sun, 11 Sep 2022 04:40:44 -0700 (PDT)
X-QQ-mid: bizesmtp86t1662896435t3wpl56d
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 11 Sep 2022 19:40:34 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: 83ShfzFP0oCS9RCHpkBXn9KTMohWsUEWJPYARlmVinaDtrsRT3tZlkmzTVDls
        AmWdje4lropRfcVZlL7B/CT7H2QeHtHsZKU0zTJ265dUcJPC7RHgImySQ4oE/xV8KBaD3as
        BOWrwak3xjSGm2xnJKDqfA1DICssHEvBYFFc8416Z4Do99E9C1+QLDAfaP3QsS/lrnXVclQ
        8pD3TNFyswcyFKYZR80VgfmATZSpGaS9bnEYS6DJsxXJhyURGp5iR7Pqc6226qL9CVCwpeA
        mJTaOSBcb1Z/o19NCuuasYrEzrYpoKwOSNTEy+BC4bW1Lilgl7KrE/xBMDSqqpnloK9q0dQ
        2HoAHNPwrgPLf6OlCGkhC4qS5m1GFik7iJVfyjew07lY9+u/4t5TwkhCXnxIw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mikecyr@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: ibmvscsis: fix repeated words in comments
Date:   Sun, 11 Sep 2022 19:40:27 +0800
Message-Id: <20220911114027.14615-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.
Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index eee1a24f7e15..0e253f961c6c 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -401,7 +401,7 @@ static long ibmvscsis_check_init_msg(struct scsi_info *vscsi, uint *format)
  * and the driver is requesting that the command queue be de-registered
  * in a safe manner. If there is no outstanding I/O then we can stop the
  * queue. If we are restarting the queue it will be reflected in the
- * the state of the adapter.
+ * state of the adapter.
  *
  * EXECUTION ENVIRONMENT:
  *	Process environment
@@ -444,7 +444,7 @@ static void ibmvscsis_disconnect(struct work_struct *work)
 		break;
 
 	/*
-	 * Can transition from this state to to unconfiguring
+	 * Can transition from this state to unconfiguring
 	 * or err disconnect.
 	 */
 	case ERR_DISCONNECT_RECONNECT:
-- 
2.36.1

