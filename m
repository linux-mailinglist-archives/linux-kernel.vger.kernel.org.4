Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBEB5B4E78
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIKLhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiIKLhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:37:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C337FAB;
        Sun, 11 Sep 2022 04:37:38 -0700 (PDT)
X-QQ-mid: bizesmtp74t1662896251t1oizu1u
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 11 Sep 2022 19:37:30 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: D6RqbDSxuq5VZDIBwursjKDSb8FhlU75tDo1iQBAtkAO+5MvaXDG6eK+cFunX
        m0RbF1KWGWUidA1lznlZnf4/ycE810KxyDT1ySpsl80qJrTfDZjYR/1hqOQYi+psdqSdvaS
        qHVloC54Fy2JqyPrQf08lpC7eeFcxFIXl4NAmPfhBjJQd1VSLP4BmKFs3UaMXCH0jV2faXy
        QfOUTx8S7Tfr9Ft6C3HLvXrCoKV/wglxEMqOLTI4H/wkohOeegjFpb94mWHldz/RwC30ga7
        K7tsgiE1kOB4BPl65zorJp8vfjNgpZvJbQuWFYxeMrRDtxyfKhZSXN59Fe5J6aZj58hP/n0
        3TnwOcrB3tuexlvRMraK2Xn81VHOr0tLTYtPoGoWU57wisNKR8VSmL/2d2nRQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: megaraid_sas: fix repeated words in comments
Date:   Sun, 11 Sep 2022 19:37:24 +0800
Message-Id: <20220911113724.10873-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 6650f8c8e9b0..9864e0e5b7f1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2548,14 +2548,14 @@ megasas_set_pd_lba(struct MPI2_RAID_SCSI_IO_REQUEST *io_request, u8 cdb_len,
 }
 
 /**
- * megasas_stream_detect -	stream detection on read and and write IOs
+ * megasas_stream_detect -	stream detection on read and write IOs
  * @instance:		Adapter soft state
  * @cmd:		    Command to be prepared
  * @io_info:		IO Request info
  *
  */
 
-/** stream detection on read and and write IOs */
+/** stream detection on read and write IOs */
 static void megasas_stream_detect(struct megasas_instance *instance,
 				  struct megasas_cmd_fusion *cmd,
 				  struct IO_REQUEST_INFO *io_info)
-- 
2.36.1

