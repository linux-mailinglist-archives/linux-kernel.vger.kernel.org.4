Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11D860854D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJVHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJVHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:02:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B5B28DC2F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:02:16 -0700 (PDT)
X-QQ-mid: bizesmtp80t1666422132tazhihhc
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 15:02:11 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: fs34Pe/+C2RrU112USnx58+ai0vhiJhyrKXFqfLxyMUZvQnCem8JLhTiJx5il
        4NmKF+QnCNJRqj09XknXgNLJ473thbxXLjdKwbhx4CRyfu5JpFssmAY8H6YSnN2OTxpsmuz
        479z/AEDQoLx88b/tOi2jdieqEjIO6lcoe4Ql+4z6gTc8VKoUhi3WLVWxhASTMQeqw5l3bW
        lMsAFtVHH7LiDreuStrQqbClSioAEaqRFJTlNEezXx0gyG2rtiK9W+uawkHrezS4jyhGMCH
        QZ7EaUx1gurBYnvk5An2+8LuyhJN5vAcOnW7X9JlFbVPRqIGUesJVRZRYppmq0323txI0W3
        iEYQFV/sMUOn1dEWzARfyaND6j40DBXaWLOlrFlfvKpuqgD4Zg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] zstd/compress: fix repeated words in comments
Date:   Sat, 22 Oct 2022 15:02:04 +0800
Message-Id: <20221022070204.52163-1-wangjianli@cdjrlc.com>
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
 lib/zstd/compress/zstd_ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/compress/zstd_ldm.c b/lib/zstd/compress/zstd_ldm.c
index 8ef7e88a5add..9a9b55d42fec 100644
--- a/lib/zstd/compress/zstd_ldm.c
+++ b/lib/zstd/compress/zstd_ldm.c
@@ -513,7 +513,7 @@ size_t ZSTD_ldm_generateSequences(
          * kMaxChunkSize should be small enough that we don't lose too much of
          * the window through early invalidation.
          * TODO: * Test the chunk size.
-         *       * Try invalidation after the sequence generation and test the
+         *       * Try invalidation after the sequence generation and test
          *         the offset against maxDist directly.
          *
          * NOTE: Because of dictionaries + sequence splitting we MUST make sure
-- 
2.36.1

