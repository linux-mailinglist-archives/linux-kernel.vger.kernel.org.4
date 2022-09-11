Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA35B4E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIKLjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIKLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:39:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF2371A4;
        Sun, 11 Sep 2022 04:39:05 -0700 (PDT)
X-QQ-mid: bizesmtp67t1662896336t04kzr9q
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 11 Sep 2022 19:38:55 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: xqT8U4SkSphzMKfEGs0QyuhaKf797xLAa5Od7wlXI2tAjzrwLvWhPbDKLOtFp
        PEbyv9joEiKEcQJsuf4j5CMgB54ZuRTBV4dvaMZEAIMAJhnUMfPdwJwsSyAbS9rLVxGtzzE
        p/gLdBAI5qgSqjjvQmMCEGxK1KHdRvM6x1nI1U7GLueE8qvWcl4o9JDJhkoTwuO+PiU6vMi
        mUozZThHVgY7lMuVD2Lz8A5XD2ZrngvpQF6b4q+pxfVTQiaAW5LyAkGF3WAS+L6OIvRTf+x
        FfOqH6UK6XB3SlO78hJ9rceWGwNh8Cfgg/ySu+dLZN5FjcIQDuOSnU4RNkLkjI1v7nfwEdo
        XdYG4WcTtnjOLfgviSyiv6LQiyDqLeH2y8MyJGZfmwSe3UqATIXBf2QgnXRfw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: qla4xxx: fix repeated words in comments
Date:   Sun, 11 Sep 2022 19:38:49 +0800
Message-Id: <20220911113849.13228-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'should'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 9e849f6b0d0f..6449823eca48 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -8726,7 +8726,7 @@ static int qla4xxx_probe_adapter(struct pci_dev *pdev,
 		 * NOTE: If ql4dontresethba==1, set IDC_CTRL DONTRESET_BIT0.
 		 * If DONRESET_BIT0 is set, drivers should not set dev_state
 		 * to NEED_RESET. But if NEED_RESET is set, drivers should
-		 * should honor the reset.
+		 * honor the reset.
 		 */
 		if (ql4xdontresethba == 1)
 			qla4_83xx_set_idc_dontreset(ha);
-- 
2.36.1

