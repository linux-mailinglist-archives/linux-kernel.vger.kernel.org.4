Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EE4608519
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJVG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJVG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:28:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FB2AD9DD;
        Fri, 21 Oct 2022 23:28:30 -0700 (PDT)
X-QQ-mid: bizesmtp70t1666420097td25yqlv
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:28:15 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ9ajbpUxL1eNYj5EshCNlonHPERxMR7h6JlzehtAEK0/ndc8XjwX
        6CAOXPiKl6O4ab1ZYeuHbSVECxK2js+dpbck2IvIKK6htRjUnkUuXZsSehTEMJP17j9GQis
        ePj/ol+C7O8KGL02XhEMqMOnfB0gbqkT1tJVAo5q/2n6E/5QNqv42+i62+NMeH9l7fa1/Ty
        OgFbWIY9auuIC81lwt5SqC4y57nFndJJt5IO6m4RDUHnk0Oskn7xLiOJBYm6NNBqsuupwpi
        dkeQG0FUq//IIVGMp6hAWeJOMOLYdHFAfMAbTcEajM8TAz7hxbKlNCoWghx9XNHxY00o7Nr
        7BpXRUserPF9gbHlAI87aSI60cuZ8jvx7fzACmKIXZ0qpBA3E4=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     fthain@linux-m68k.org, schmitzmic@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     inux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:28:09 +0800
Message-Id: <20221022062809.16538-1-wangjianli@cdjrlc.com>
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
 drivers/scsi/NCR5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index dece7d9eb4d3..36f8133ad7d8 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -857,7 +857,7 @@ static void NCR5380_dma_complete(struct Scsi_Host *instance)
  * Checking for bus reset by reading RST is futile because of interrupt
  * latency, but a bus reset will reset chip logic. Checking for parity error
  * is unnecessary because that interrupt is never enabled. A Loss of BSY
- * condition will clear DMA Mode. We can tell when this occurs because the
+ * condition will clear DMA Mode. We can tell when this occurs because
  * the Busy Monitor interrupt is enabled together with DMA Mode.
  */
 
-- 
2.36.1

