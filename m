Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02831608514
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJVG1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJVG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:27:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C62B6909;
        Fri, 21 Oct 2022 23:27:01 -0700 (PDT)
X-QQ-mid: bizesmtp66t1666420013tcc8w4mf
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:26:51 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: r/cTxDoDoiHPWMs5e5A2gtAxDlCKpUsBku7x3oZHHb0y6qzQKdEguub0Dg69l
        ZhJwsg+bj1/OobwS6i2xYLll7qWEWxrtP+Zgw3edN9pQaayoS84iuf7YZHlxtlXwmVRdyDw
        QIuijuh8etrll/h+XV4a3J0BZ2cqaSIXPKQH2raxrSeau4wPzkBiok41TpVmhxrfnHNFVj6
        /28I6GhaUcfjqRHOqMY55YqwTrIbpoPXh5uOs5mHCyFrB+/0WGIfX1T5QZnQ/X96CmJCd2B
        /dGA8S1qs64U12WW5HmXsC9wvZNbPqhs4ew6BtOmlcVW27fJ85jFrbTxslqhfPq6KdXGar1
        w9qxwWELZMLVPSnl27uOKzov16I8X26+QjtOLKzplUyeXJeOnY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mikecyr@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/ibmvscsi_tgt: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:26:45 +0800
Message-Id: <20221022062645.15043-1-wangjianli@cdjrlc.com>
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
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index eee1a24f7e15..9c783c150755 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -400,7 +400,7 @@ static long ibmvscsis_check_init_msg(struct scsi_info *vscsi, uint *format)
  * An error has occurred or the driver received a Transport event,
  * and the driver is requesting that the command queue be de-registered
  * in a safe manner. If there is no outstanding I/O then we can stop the
- * queue. If we are restarting the queue it will be reflected in the
+ * queue. If we are restarting the queue it will be reflected in
  * the state of the adapter.
  *
  * EXECUTION ENVIRONMENT:
-- 
2.36.1

