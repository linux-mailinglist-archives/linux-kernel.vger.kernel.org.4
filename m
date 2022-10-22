Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788A608540
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJVGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJVGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:46:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B342608FA;
        Fri, 21 Oct 2022 23:46:01 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666421143tcq8mc8w
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:45:41 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ9vsKyVD7plXMfGbonv39/6+K5jcaL8gO3NFWxnlcliO7sPzI7tG
        ePKAQIGJbE0b1m/KJ06YhPIRDl5czktz6f6WoaxUirdSAGDSRkbbLewp4AHhe0YTaHRmLxj
        EtUkneD5b/tSouWH9YBHKs/L2Oie1I4FLuUi7gBD67P1d+EskwPJ+svJXdqlGjr0elg5a6Z
        OZMm1LxvwtD/LmKNNtUbm2YNPoEhLTxQaB4DBfWoBolGt3R2ClRPFoDmpJpMUmziIGdikuc
        frDjYYIQ6sd07XQ4txQXdc8QQfbsko5zrhsobKj91EKDyPBkbRnLWg2Dh3X3QiEmVmw9VDl
        Q1kIK8InUtv8p68uro+Mhoqi8dGYFy2jucVp+gGsenqd0Byz2A=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:45:35 +0800
Message-Id: <20221022064535.34616-1-wangjianli@cdjrlc.com>
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
 drivers/scsi/dc395x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 670a836a6ba1..a7db373d5e2c 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2051,7 +2051,7 @@ static void data_in_phase0(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb,
 		}
 		/*
 		 * KG: We should wait for the DMA FIFO to be empty ...
-		 * but: it would be better to wait first for the SCSI FIFO and then the
+		 * but: it would be better to wait first for the SCSI FIFO and then
 		 * the DMA FIFO to become empty? How do we know, that the device not already
 		 * sent data to the FIFO in a MsgIn phase, eg.?
 		 */
-- 
2.36.1

