Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7762060854C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJVHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJVHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:00:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086C58158
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:00:29 -0700 (PDT)
X-QQ-mid: bizesmtp82t1666422025t0c2xmm9
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 15:00:24 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 8mvwyB2Dxk+N+sbIZ2+qCa1j0MEXGEUHiGtTy20lyD+3Fzgz/EVq9/FP5N6jt
        i3QmQW4yjfc3O6MfYHq5SRdQt72IDvl/NeV+VdnwzKSMue1NTcAfZ0UpFWdd1k6Fty4CTzb
        MWNTtEqzs7K5fMV5iCoUxtGgaMNqUdpobHv8/AeuR9yIcjSszmsPvQ/Y8HL59oo+vBVaaDP
        fxU2i/ciuHgIMA6B9PRG7Gu6wziESwhUrot0swCpvTYOonPMzZhKPg+P0rmHadgar4KQ3wg
        0DOrFCMAjH/ZcmYRpeM+wKjQ6NqA5iNL5BZ/OcD6fpDR14iA7U09DY+JjDWA7r+UOU5y4zz
        wdovfoLhkA4is2/4bLa//Oj6NZR9Z453wH2U3fwD7ksGgox8ns=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] zstd/compress: fix typo in comments
Date:   Sat, 22 Oct 2022 15:00:17 +0800
Message-Id: <20221022070017.50233-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'the', and add a word 'that'

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 lib/zstd/compress/zstd_compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index a4e916008b3a..0488d7b7ef71 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -4441,7 +4441,7 @@ static size_t ZSTD_validateSequence(U32 offCode, U32 matchLength,
                                     size_t posInSrc, U32 windowLog, size_t dictSize, U32 minMatch) {
     size_t offsetBound;
     U32 windowSize = 1 << windowLog;
-    /* posInSrc represents the amount of data the the decoder would decode up to this point.
+    /* posInSrc represents the amount of data that the decoder would decode up to this point.
      * As long as the amount of data decoded is less than or equal to window size, offsets may be
      * larger than the total length of output decoded in order to reference the dict, even larger than
      * window size. After output surpasses windowSize, we're limited to windowSize offsets again.
-- 
2.36.1

