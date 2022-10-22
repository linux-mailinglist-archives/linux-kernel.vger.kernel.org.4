Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBFE608549
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJVGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJVGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:53:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B4270829
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:53:56 -0700 (PDT)
X-QQ-mid: bizesmtp65t1666421632ta9mrjp7
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:53:51 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: o+V1LJLjbvzEy3tP3dP24LOpI5A/hK1POOZUMn/TBNfY9RUaHhlpaUry9waxI
        XetqVmzlGt7+0SQSEPSP4ErLih6bHmgkxOR+nObP+honLomow8VeIIC98cc/zqZYC/8y2Dr
        CowrPubg3hF9BnOddkSOFDHkU+nlp1DfrCHgLnH8Q6ud4iYG99jx/8wnfuFxVAahXiFmhvw
        R26seOpWLvm+auSeBzcKQ/WJotP3tQG1q806zKmMfrXwMIh/9wxA4Por/kOSkKa65nimbAh
        FnwR2wnrjRIdatCPCddjccUYl+PyS0BXGaDO1e9PymSnGzJrOhND7J2/R7+98GL4TEH+Im5
        /JxT6tEsxgOZKMTbYx3cNdMnXQobIOr+n9xNc3FBEfjghaFqOtpUhuPJyDoJg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] zstd/common: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:53:45 +0800
Message-Id: <20221022065345.43836-1-wangjianli@cdjrlc.com>
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
 lib/zstd/common/fse_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index 2c8bbe3e4c14..f150cbdfab49 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -127,7 +127,7 @@ static size_t FSE_buildDTable_internal(FSE_DTable* dt, const short* normalizedCo
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

