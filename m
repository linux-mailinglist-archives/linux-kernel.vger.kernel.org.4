Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113DE6112CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJ1Nbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiJ1NbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:31:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D351D377E;
        Fri, 28 Oct 2022 06:31:13 -0700 (PDT)
X-QQ-mid: bizesmtp77t1666963867tb6fji77
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:31:06 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: 05DNj9F54DgMzRozldRd2zFpmi4hSqj4xhrQQvH8Ee/5HcLx4C4DCMQbutUYX
        4v33FIBmkRWjIWevxdoNwOu3x8RrByn3wiSHx8J6zhh4vhwk47UWaszL3XuAedOfhU7nNxt
        jrCPbeqaJHI2nkXCp/2jk2Ytlo3eUVq1zDg4ms7fSxXnc6rFTnp6mrk4ybmnD1MSDyniSBw
        4IVzMtUE0N7bgt795sj8uBKYlvlYCKZXBFRQK6CvqRtwN9WK8ZBa1igckYZwAV2/MA1CghU
        atnIFchMuBVhOz27i9q5f+8a90Rz6xkHQGrqpJGj6ezlSMy9tA1Vl2JLyS6YNtep7GhzXNE
        0AKu4WrKxGgq9po8ttiQIPm2zcMJ690mcxAwe1K
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: qla2xxx: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:30:58 +0800
Message-Id: <20221028133058.54619-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'should'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index e12db95de688..7c2004be83ea 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2482,7 +2482,7 @@ qla2x00_initialize_adapter(scsi_qla_host_t *vha)
 		/* NOTE: If ql2xdontresethba==1, set IDC_CTRL DONTRESET_BIT0.
 		 * If DONRESET_BIT0 is set, drivers should not set dev_state
 		 * to NEED_RESET. But if NEED_RESET is set, drivers should
-		 * should honor the reset. */
+		 * honor the reset. */
 		if (ql2xdontresethba == 1)
 			qla8044_set_idc_dontreset(vha);
 	}
-- 
2.36.1

