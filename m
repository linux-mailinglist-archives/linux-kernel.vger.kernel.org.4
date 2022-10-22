Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29659608482
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJVFYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJVFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:24:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93D4316D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:24:48 -0700 (PDT)
X-QQ-mid: bizesmtp67t1666416282tbvdaz7w
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:24:41 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: D6RqbDSxuq5eY2RE5twnHFzELjK5Vicza+bKnXcyulR6ZaS18snBwAITe3tae
        xPD/EFcu9hKETyz2aIrYAOnSukoF/x+JGV1RciVNplfbyX6YhDCaGbEAKgJI8sYMpA1Ic9j
        Y8sGCa4KzraYI7sFftrwRPzSEh7tPqw5tD3+eDRaHVTJ1OywcfxNV7Ne0HxdJ3hpL6RAMHV
        oPK/Vj4nYn1t1rlg+dsrgbYfsVzV/8nkyP0NeS1MFzeWiLtl9ZaoT/9NFY6Ifk6Y4AA7hZM
        8Gpg0gJhsM1wNeZR+Ei4Pz1M/uiRR/AqcKErzjgYCpTYYSJ883xWmGS8xvJ/mPPbmrYgL4p
        mNf53ozAmY5xGewY14xlGIQ7NTSDdxCFZLV/BO9
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     nsekhar@ti.com, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] arm/mach-davinci: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:24:34 +0800
Message-Id: <20221022052434.12223-1-wangjianli@cdjrlc.com>
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
 arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 9adcb5879d14..87bbc36ca5ef 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -535,7 +535,7 @@ static struct vpbe_enc_mode_info dm365evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + ecnoders. Keep
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular
  * encoder.Driver uses this index to pass it to encoder when it supports more
-- 
2.36.1

