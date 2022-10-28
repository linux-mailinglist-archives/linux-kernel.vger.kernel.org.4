Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A26112E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJ1NfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJ1NfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:35:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C03DBE3;
        Fri, 28 Oct 2022 06:35:04 -0700 (PDT)
X-QQ-mid: bizesmtp63t1666964099tjoe2pxq
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:34:58 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: +Fw3Sd5mYDVr8j3Iuapb6Blpa7vtw7dAAGvAdK3X11fEyn+OUJN9NpRIELpPL
        Q7z/pc4bV5jjfXb4KbPYjqpnXFJcsqz6u+OiMi5wFMGA8U/c6XPy0ZK1lnVgXwOlAz6+dQV
        pYJsduStumosMzahoDxaldtVfJTAKK7QQU4hkOXhjoobAhLxORL/dNCK6W1Py5xuVDpxRmB
        gl7WenGXRS7K5RsGBeo/T2fI4sDLhWJ1XidywaapNq5kTZcX21dQVCJlk2BZBxGl3vXzbF6
        bpYQMNj5/w4hqt2E3TWLFAVJJP/vS6pikuZh3lSdUgpC8WepQh1lAIjk0chEAAAgvkYtfq+
        i3kKl91itNxPdXT+9TmLCGKWIa6Gd9EVIDiOFvX0HXP1UXD+cOoVP03EGtQKg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: qla4xxx: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:34:51 +0800
Message-Id: <20221028133451.57916-1-yuanjilin@cdjrlc.com>
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

