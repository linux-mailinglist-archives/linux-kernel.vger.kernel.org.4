Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41E60851C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJVG3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJVG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:29:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CBF22289;
        Fri, 21 Oct 2022 23:29:30 -0700 (PDT)
X-QQ-mid: bizesmtp76t1666420162tubmy0fx
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:29:21 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: DZSqRUnexJ/LZ3Ck6z2lbtPFRr17dgnHrPHlvTkEDuzz/5eWGRBKncRUQHrEG
        unB8U3FyWHgVg7FSKWFTDjKNK9/jzuztwtGLx3F5RXzuz2ABQNXibyX03AOTRZXi76inpc/
        Dle/uIx1NpTX3YgbFpc1jjLx38cAaZpIgkrJdK+jmbwhPa/Sw0PBWnVBKqTuPK6psmWn4oo
        XOpYj2qyd/sqlGMFzz89BAn5EbXikkMGbDS/GVGpH7kK9vzipKemXk0zFgtoecQrPpw6zo7
        tAmDCPYNnr0DADMARZAYkC7UgGNqsr40tGj51wNXfvi6V6fIV4LCAnOYMEgJ5x+zthIT9hE
        0ZI/Bjdk0z+ygzM1HyQYN/oIur8I0xOiI/oiL/l5O8537R2JbY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     artur.paszkiewicz@intel.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/isci: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:29:15 +0800
Message-Id: <20221022062915.17842-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/isci/remote_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.h b/drivers/scsi/isci/remote_device.h
index 3ad681c4c20a..db097483ff04 100644
--- a/drivers/scsi/isci/remote_device.h
+++ b/drivers/scsi/isci/remote_device.h
@@ -198,7 +198,7 @@ enum sci_status sci_remote_device_reset_complete(
  * permitted.  This state is entered from the INITIAL state.  This state
  * is entered from the STOPPING state.
  *
- * @SCI_DEV_STARTING: This state indicates the the remote device is in
+ * @SCI_DEV_STARTING: This state indicates the remote device is in
  * the process of becoming ready (i.e. starting).  In this state no new
  * IO operations are permitted.  This state is entered from the STOPPED
  * state.
-- 
2.36.1


