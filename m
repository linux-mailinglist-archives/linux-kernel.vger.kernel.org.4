Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D537C743643
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjF3Hy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF3Hys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:54:48 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753F10D5;
        Fri, 30 Jun 2023 00:54:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmHfFmv_1688111680;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VmHfFmv_1688111680)
          by smtp.aliyun-inc.com;
          Fri, 30 Jun 2023 15:54:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] crypto: sig - Remove some unused functions
Date:   Fri, 30 Jun 2023 15:54:24 +0800
Message-Id: <20230630075424.44776-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are defined in the sig.c file, but not called elsewhere,
so delete these unused functions.

crypto/sig.c:24:34: warning: unused function '__crypto_sig_tfm'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5701
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 crypto/sig.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/crypto/sig.c b/crypto/sig.c
index b48c18ec65cd..224c47019297 100644
--- a/crypto/sig.c
+++ b/crypto/sig.c
@@ -21,11 +21,6 @@
 
 static const struct crypto_type crypto_sig_type;
 
-static inline struct crypto_sig *__crypto_sig_tfm(struct crypto_tfm *tfm)
-{
-	return container_of(tfm, struct crypto_sig, base);
-}
-
 static int crypto_sig_init_tfm(struct crypto_tfm *tfm)
 {
 	if (tfm->__crt_alg->cra_type != &crypto_sig_type)
-- 
2.20.1.7.g153144c

