Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C6608476
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJVFQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:16:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF332A8A6B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:16:27 -0700 (PDT)
X-QQ-mid: bizesmtp86t1666415781trj2jbh4
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:16:19 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: D6RqbDSxuq6+whg+cHMxbbJQDzgKw0UOOYf8ON1p6yiUH9xki62VYRwPHowGS
        UXDDQJih8VaBMSoTib+5cfFmHGp6GarvL8KOcVzWM4rWiW5pOfixsJL98oAHEcehP9JPbXX
        Lz/HIilIOyGJuxG7APejtqqw8zmfzYHyAUyZSKwY1AbBLeBdATsGjvPNjZj62EnImYHGk36
        O6ZyuA0ueQLHoBxECZcfs0vWn1SEgg4G4FQAgeBuKPL/3RvdCzWNPvJ4yo7ShSNAIufYWSV
        9V3/uNLmCOiKjxpOY96TUUd9aTlXfe6rsulN64eY2n0daqTuxDZF5oWITFZvjuLqlK+ec8K
        ++VoDkVFwuDOPB++/Qy3K2aGLvi08iszfie8iZAUii6abcY2/k=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     nsekhar@ti.com, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] arm/mach-davinci: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:16:13 +0800
Message-Id: <20221022051613.3017-1-wangjianli@cdjrlc.com>
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
 arch/arm/mach-davinci/board-dm355-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f7c56f662d4c..e56f8ea5eb56 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -294,7 +294,7 @@ static struct vpbe_enc_mode_info dm355evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + ecnoders. Keep
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular encoder.
  * Driver uses this index to pass it to encoder when it supports more than
-- 
2.36.1

