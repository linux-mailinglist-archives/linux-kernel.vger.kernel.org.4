Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737F6026A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJRIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJRIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:22:18 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04795E7A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:22:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSTyJ-w_1666081320;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSTyJ-w_1666081320)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 16:22:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] gma500: Remove the unused function gma_pipe_event()
Date:   Tue, 18 Oct 2022 16:21:28 +0800
Message-Id: <20221018082128.4834-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gma_pipe_event() is defined in the psb_irq.c file, but not
called elsewhere, so remove this unused function.

drivers/gpu/drm/gma500/psb_irq.c:35:19: warning: unused function 'gma_pipe_event'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2428
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/gma500/psb_irq.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index d421031462df..343c51250207 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -32,17 +32,6 @@ static inline u32 gma_pipestat(int pipe)
 	BUG();
 }
 
-static inline u32 gma_pipe_event(int pipe)
-{
-	if (pipe == 0)
-		return _PSB_PIPEA_EVENT_FLAG;
-	if (pipe == 1)
-		return _MDFLD_PIPEB_EVENT_FLAG;
-	if (pipe == 2)
-		return _MDFLD_PIPEC_EVENT_FLAG;
-	BUG();
-}
-
 static inline u32 gma_pipeconf(int pipe)
 {
 	if (pipe == 0)
-- 
2.20.1.7.g153144c

