Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9043A608520
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJVGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJVGbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:31:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B362BABF1;
        Fri, 21 Oct 2022 23:31:46 -0700 (PDT)
X-QQ-mid: bizesmtp84t1666420286tlxf8fgf
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:31:25 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: xqT8U4SkSpipKbq2G1p4GscCMGRsfbMx0WO7g86KPgBzuhXsR4plTwgtPpmio
        e2LZmAcTRx46ZkYqeMROz2MyeFOXF02gDkLt8RWx9HcPpodNqgGHRfAfbaF+qWtVpAzzYBH
        Druj/wLjqcvoqvp22HGjjn88Lb9YwF0QnPtrh2UGdqF2s8o1piavi8oIrcWmuD5Lwypak+B
        2XuPjn5uFROV/RPS1+iRLqFrreq5sOuj/6IK7KeVqDUDcFGSfvNDJ/sUYmLzPNxALSODOkE
        02oPvoMyZOAtA7Nv9FtBJNHfnsq+kFB+C1KyHg+9qelY/oFq/va2nvVo8kYXpUs9zNaUOoP
        wjRRTUUR2YUbuZX6Z+DvlI4mvjbzmxaIj2UC97bxNsECe0IXFY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     artur.paszkiewicz@intel.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/isci: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:31:18 +0800
Message-Id: <20221022063118.20194-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/isci/host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/host.h b/drivers/scsi/isci/host.h
index 6bc3f022630a..64e4759f25d7 100644
--- a/drivers/scsi/isci/host.h
+++ b/drivers/scsi/isci/host.h
@@ -244,7 +244,7 @@ enum sci_controller_states {
 	SCIC_INITIALIZED,
 
 	/**
-	 * This state indicates the the controller is in the process of becoming
+	 * This state indicates the controller is in the process of becoming
 	 * ready (i.e. starting).  In this state no new IO operations are permitted.
 	 * This state is entered from the INITIALIZED state.
 	 */
-- 
2.36.1

