Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9258C60C933
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiJYKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:58:53 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBB133327;
        Tue, 25 Oct 2022 02:53:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VT2gD6r_1666691626;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VT2gD6r_1666691626)
          by smtp.aliyun-inc.com;
          Tue, 25 Oct 2022 17:53:47 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, elliott@hpe.com
Cc:     zelin.deng@linux.alibaba.com, artie.ding@linux.alibaba.com,
        guanjun@linux.alibaba.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuchun.shang@linux.alibaba.com
Subject: [PATCH v3 9/9] MAINTAINERS: Add Yitian Cryptography Complex (YCC) driver maintainer entry
Date:   Tue, 25 Oct 2022 17:53:36 +0800
Message-Id: <1666691616-69983-10-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666691616-69983-1-git-send-email-guanjun@linux.alibaba.com>
References: <1666691616-69983-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

I will continue to add new feature, optimize the performance,
and handle the issues of Yitian Cryptography Complex (YCC) driver.

Guanjun and Xuchun Shang focus on various algorithms support, add them as
co-maintainers.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Acked-by: Guanjun <guanjun@linux.alibaba.com>
Acked-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb30c0..fd55efe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -953,6 +953,14 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+ALIBABA YITIAN CRYPTOGRAPHY COMPLEX (YCC) ACCELERATOR DRIVER
+M:	Zelin Deng <zelin.deng@linux.alibaba.com>
+M:	Guanjun <guanjun@linux.alibaba.com>
+M:	Xuchun Shang <xuchun.shang@linux.alibaba.com>
+L:	ali-accel@list.alibaba-inc.com
+S:	Supported
+F:	drivers/crypto/ycc/
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
1.8.3.1

