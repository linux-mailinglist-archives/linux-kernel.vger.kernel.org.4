Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059985BF291
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiIUBGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIUBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:06:15 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D533433
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:06:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQLL0q6_1663722370;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VQLL0q6_1663722370)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 09:06:11 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] um: remove unneeded semicolon
Date:   Wed, 21 Sep 2022 09:06:09 +0800
Message-Id: <20220921010609.116496-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while(){}, semicolon do not need to be appended.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2237
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 588930a0ced1..198aaed81ce6 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -412,7 +412,7 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
 		if (msg.msg.header.flags & VHOST_USER_FLAG_NEED_REPLY)
 			vhost_user_reply(vu_dev, &msg.msg, response);
 		irq_rc = IRQ_HANDLED;
-	};
+	}
 	/* mask EAGAIN as we try non-blocking read until socket is empty */
 	vu_dev->recv_rc = (rc == -EAGAIN) ? 0 : rc;
 	return irq_rc;
-- 
2.20.1.7.g153144c

