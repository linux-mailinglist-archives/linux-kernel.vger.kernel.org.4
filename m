Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9660848A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJVF2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVF2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:28:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036D297F20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:27:59 -0700 (PDT)
X-QQ-mid: bizesmtp69t1666416474t6w7afyc
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:27:53 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: Qib4UA9Xm7p3hvgh3wmZJsnIC2x8w7FTe/qG/2At3iC5HoxTC6J7q2MLRO60g
        yhI1NXdzt6T+GcMBIS+caHD1Hfn5S1l3HTa16upn50cYxfGGcYg73llZBugxE8SHBDG97Rh
        U/bTp85plUiHDIixURB0L/wADzB5YYs6TxRCFS+RIH2ca7WxXi1EuudfIuqMvqbwsBq6tH0
        +eLIRXfwRFWN+ApDUDQtokVn/jaK5Df7WcSp3RZ/QnOF2qv72U9Ts+PLPe25PyNswKCnzJF
        UeP4Ob8/mY8DyFqzhTf4SCmwv3TT2fLxY+JNFv6CuammmY7MzKUxVLxFbF3YjQzO6Vzqu81
        9y3lekTHLiZNccF1nu6xxG1RQrPfqA3ReW6DNfT
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] include/asm: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:27:46 +0800
Message-Id: <20221022052746.15702-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/arm/include/asm/unwind.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..5fc323586c7a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
-- 
2.36.1

