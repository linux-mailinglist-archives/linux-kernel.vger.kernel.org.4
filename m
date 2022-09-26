Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B105E9D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiIZJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiIZJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:14:49 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDCB1054F;
        Mon, 26 Sep 2022 02:14:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQjGHLc_1664183681;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQjGHLc_1664183681)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:14:41 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: scatterwalk - remove duplicate function declarations
Date:   Mon, 26 Sep 2022 17:14:40 +0800
Message-Id: <20220926091440.98804-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

scatterwalk_map() is an inline function already defined in the
header file, it is necessary to delete the re-declaration at the
same location, which was left out in the header file by an
earlier modification.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 include/crypto/scatterwalk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 6407b4b61350..05338a9f3f5d 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -99,7 +99,6 @@ static inline void scatterwalk_done(struct scatter_walk *walk, int out,
 
 void scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
 			    size_t nbytes, int out);
-void *scatterwalk_map(struct scatter_walk *walk);
 
 void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
 			      unsigned int start, unsigned int nbytes, int out);
-- 
2.24.3 (Apple Git-128)

