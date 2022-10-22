Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D010608531
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJVGir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJVGim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:38:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FF2BE893;
        Fri, 21 Oct 2022 23:38:41 -0700 (PDT)
X-QQ-mid: bizesmtp80t1666420709t1l2benn
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:38:27 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 83ShfzFP0oCavCx2JPmr9qQxverkE8Uiw40nOhHNooMa3gxLH5FjPCikZFLPX
        UxtomQtna1HGBy8/hfxhZ9eiQ2lyGDe6W7QnWs3gNUPM91FWXVYvACAvUG/YVvBl7BN214b
        MNNQSnMOJs0g+OLU/AGHElh5+zC6v6OiilP49kCIgDTlxbUeOm87+2G1WcQcimbOX7Tiq5g
        JQBKy3IScpWihFkGSG5j2r5a+FJXWy+Iv3CzCG2TxBh0D11zAyR5lybq9gph+ztPAhLIzva
        8EXrZwua9LCwM4Elg8GGPyfmFXQxop9hchkJjf58gMPKnu2COhl/dOnBSMQSlBG0ZJ4PXQY
        vWKl3xGuDiuFj+T/lzumtjaP1b1MMnX4QzLvmeWW8sqrRdOEgk=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/aic7xxx: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:38:21 +0800
Message-Id: <20221022063821.27974-1-wangjianli@cdjrlc.com>
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
 drivers/scsi/aic7xxx/aic7xxx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a396f048a031..dbce720c7a9f 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -1110,7 +1110,7 @@ ahc_handle_seqint(struct ahc_softc *ahc, u_int intstat)
 			hscb->control = 0;
 
 			/*
-			 * This request sense could be because the
+			 * This request sense could be because
 			 * the device lost power or in some other
 			 * way has lost our transfer negotiations.
 			 * Renegotiate if appropriate.  Unit attention
-- 
2.36.1

