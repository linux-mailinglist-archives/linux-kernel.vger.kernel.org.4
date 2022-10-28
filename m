Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA486112F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJ1Ng3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJ1NgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35319344A;
        Fri, 28 Oct 2022 06:36:16 -0700 (PDT)
X-QQ-mid: bizesmtp66t1666964164t80buwid
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:36:03 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: pMHwdq3i9JPnWxA22ktMbjJAiyte6UBvavODk2uV7YwViADse3ZclSYpeF/jF
        QuAN4ux+zmRPSaxYGPwDTLeDmmjLaCk0cl/7OXT33jfjreoJWqS0jHceVH4lxU2/fWzKFFy
        /ULBV/mxqYA2dGhITpDc2rJmr7XyW+ymg/A6wxvp6CKVqf5lqwQ2vUVxZ277lwMPEy1uivK
        /CsEkmfJ19j2ksk7FnpPSGH+IHUdvo1XLDf0m2S90A6YoynEatc6lbGSDZveKEscHD3hAt3
        U1y+W5fyB44riE7m7J3UK/EpGBMWcPxR6Y2pPH+U+qd9mpZSGVMoF0hQI47EB8PgQsjZD86
        +8TDjdNGbptYEl1vuMShpD8SQWf+JSFQtOLoJdSCaWj3OJT3rVD6YNmWdY3CHzny4kayKxh
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: ibmvscsi_tgt: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:35:57 +0800
Message-Id: <20221028133557.59056-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index e8770310a64b..0e253f961c6c 100644
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
-- 
2.36.1

