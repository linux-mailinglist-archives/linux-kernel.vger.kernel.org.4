Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C304A5B832B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiINIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiINIke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:40:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C838146DAA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:40:32 -0700 (PDT)
X-QQ-mid: bizesmtp75t1663144811t6s1gzh9
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 14 Sep 2022 16:40:09 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: FW0hP5rQkEvZp8XoIGOH34yPYMx3+KwFpZLWtApxdONlAF/WfiiEYGpcVI2vq
        FDuyXAa+D8bpxrFqIR23Eq/Pmp8EbVDdwO2shdnVfIA1eiIWoweC3aq1RIsqyTnGmkJysbD
        dqirpPEUZUKg2wRXwZ45gnNfgqSoojPJ490xmGNtSvBWoaSY9Au6yGD1KndUzGXRs4R+bAK
        DbyIHontiu7QHA3tWAwyoGGj/VMG06S+bvGMdux8OjhcBgyPb6PZ9Yu/EXgMm5HpxVXwGIm
        cUfOuBmMNepSSsuMoGHH0PL861J3rIvgvVNIsukS/i9Lyrh/a2la8z3Pl12kziQZwYTlCui
        JwRZSUCK35P2cZgqGFjmdc6Ru6VzoCIt9ALunjVbthjY7Zm8vTBEiTeaXRsEfUghiUpGwYk
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: pxa: fix repeated words in comments
Date:   Wed, 14 Sep 2022 16:40:03 +0800
Message-Id: <20220914084003.32011-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-pxa/hx4700-pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-pcmcia.c
index e2331dfe427d..860b78aed18c 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -30,7 +30,7 @@ static int hx4700_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	/*
 	 * IRQ type must be set before soc_pcmcia_hw_init() calls request_irq().
 	 * The asic3 default IRQ type is level trigger low level detect, exactly
-	 * the the signal present on GPIOD4_CF_nCD when a CF card is inserted.
+	 * the signal present on GPIOD4_CF_nCD when a CF card is inserted.
 	 * If the IRQ type is not changed, the asic3 interrupt handler will loop
 	 * repeatedly because it is unable to clear the level trigger interrupt.
 	 */
-- 
2.36.1

