Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA0608473
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJVFPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:15:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E67C1C5;
        Fri, 21 Oct 2022 22:15:06 -0700 (PDT)
X-QQ-mid: bizesmtp88t1666415691tlr96z3b
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:14:50 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 6PjtIMncaiyHpM31v3JygrPU0itsxZQYzgFTkgePxl0bBZkKtsF/tdbMnsAkf
        k3GjjjqwWVZxcUsrJzUW1bGR8IyYbwc1e8QzCqGW0xJZJ/lXaMTx7iLoH238vYIBHHWrJ+j
        jBLmeBQExLp6DThUxv4GZ9GSwfzFjxlrlYNsZAgt0QVSwq16Ydp7n1QO1LX7gNIFw92FlxU
        3Z5RgY/PM5d5i5VJ3ImoJ+JOJGmshQ6Pm5PmAKwGnfGLu6NgYqwvpAKm7m17LscQ4UVkMjg
        Lwk6NYPG6nKeY4vG+UmRLtJKkzxPee7AuS4J0hS3hvIlELz6UVNrEzCG+sGUSdyndBawErr
        Nh2+19bJB1Al+xsf64uvRbz+b+bn1jkA0kFZ/v9
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] sparc/kernel: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:14:43 +0800
Message-Id: <20221022051443.1336-1-wangjianli@cdjrlc.com>
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
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 31b0c1983286..385c61d199cd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-- 
2.36.1

