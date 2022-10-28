Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD0611324
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiJ1NkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJ1Njt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:39:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28B1DDC17;
        Fri, 28 Oct 2022 06:38:40 -0700 (PDT)
X-QQ-mid: bizesmtp85t1666964311tr8fp4fx
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:38:30 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: +oIWmpEafD9kb2bPnUJHueZ+m64cMZu9zhDJmpS5H8Y6saFuXFv1fLpkwRCb4
        sjTmFuFrauFLFRgE3NksM2J1YwVQ3Dg5ULV62PYYjtmXKfgcvOegqmHJrA+Ezipl2/hdJbn
        76RqQDvQHGWLZLSVbwtHPBz0hqNICvR1LWvByfyEqOCRyOs8YOg2daj/l/xJBuHd7VkKIb3
        /LWj40q0TgIN89IYsTh6C3zraNSbBl07HHo5Rqnm/OlFJCJqDbGmAff42B3UOH9DpBJhZYm
        czxHlLjLmXs6XR0xgKSeFlQ2f+v0hNS9sCvX3LtvOCRVqz09JDnqTd7458NjVN1xZfcBZi8
        yRbxV/wEjlZl2cWQewtkQortHzAf9ooY0WwQUvKy0u8/Y+RqNrWc56L+qEjbkmNfteYGPqj
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] isci: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:38:24 +0800
Message-Id: <20221028133824.61066-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'by'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/isci/unsolicited_frame_control.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/unsolicited_frame_control.h b/drivers/scsi/isci/unsolicited_frame_control.h
index 1bc551ec611f..f9c816d9cd38 100644
--- a/drivers/scsi/isci/unsolicited_frame_control.h
+++ b/drivers/scsi/isci/unsolicited_frame_control.h
@@ -118,7 +118,7 @@ enum unsolicited_frame_state {
 	UNSOLICITED_FRAME_EMPTY,
 
 	/**
-	 * This state is set when the frame buffer is in use by by some
+	 * This state is set when the frame buffer is in use by some
 	 * object in the system.
 	 */
 	UNSOLICITED_FRAME_IN_USE,
-- 
2.36.1

