Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA127608552
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:04:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8BE14003
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:04:29 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666422265t9sdkvvl
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 15:04:24 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: RFp2QSjOiS6AueA2LCC6S2eUE2Rz+/FY9AKTKyBSuU8zsqz2SmBoV4cC+I59U
        88WGmXz7KdCspOYMLxdXddjS2WzLi0CwBMGIGA4Dl/xWrGSURRyDoqk4nDVJPWJkWqn3ybQ
        vLNTyC0kiMxG8/21MCXAxcO0RZuFfnLHlzSRDWa/XyAFerwHBvYYCIhu8bDlMI9UzGHdkUT
        LpHCXktzGnWcL8oW5hvyds6aOM3PUTugUJjMfLG7eQ5+MzE8BlUhMD8kyrpUpp9O9A0Ngst
        1j7aw6nTyo4UrGMW7DqYrAm/zJgSBWDeALyKyXT/kX2Xtv3sxWShwdytlbjDuGv9Bl1v6CU
        T3SEwPeW2I459msD3nBlNNwO+t5RYcSMqncorHnyZ7RKl6bL88=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] zstd/decompress: fix repeated words in comments
Date:   Sat, 22 Oct 2022 15:04:17 +0800
Message-Id: <20221022070417.54584-1-wangjianli@cdjrlc.com>
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
 lib/zstd/decompress/zstd_decompress_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/zstd_decompress_block.c b/lib/zstd/decompress/zstd_decompress_block.c
index 2d101d9a842e..3067eb172c5d 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -434,7 +434,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
             }
         }
         /* Now we spread those positions across the table.
-         * The benefit of doing it in two stages is that we avoid the the
+         * The benefit of doing it in two stages is that we avoid the
          * variable size inner loop, which caused lots of branch misses.
          * Now we can run through all the positions without any branch misses.
          * We unroll the loop twice, since that is what emperically worked best.
-- 
2.36.1

