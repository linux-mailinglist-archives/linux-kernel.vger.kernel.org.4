Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A958608483
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJVF0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJVF0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:26:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698B2625C3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:26:11 -0700 (PDT)
X-QQ-mid: bizesmtp71t1666416359t09lf20q
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:25:58 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: r/cTxDoDoiFhgQGWH8Sx7oYKW4WSgj/Il7P3flmzs9BR/zrAuI4/PoX5xVX7T
        lR7B0zNpFi6uCusQIf2LZN3JE72IxJ/UmssOZbSDM+J2nBWUdcuMmMB0pTVheGb/RMTdPJE
        34YrNWzeDssQjW75wS0hyCPYQAHC4WG2iQAoAN7BH5MJnQ1hpdZBPt/GpdeOKNNsBrGymfb
        Ou/7NUGIUGT5yCCBEdWI/8/qgzJ/MMsTf3godvxGRQa18NS+fnvEdo+Yv1cOLmMfy9E28Tn
        OcZ3mabs+knVuMmcPQpF98CN7bH4YJSM9XgIb/DwkF5gHDwuv/7MArSirgQ61L3WfCm++d+
        ADd+8B9UJWkb5JnuVzrgMikoORgqC0PDsoIsARVhZIT1ozo67o=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] arm/mach-pxa: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:25:51 +0800
Message-Id: <20221022052552.13668-1-wangjianli@cdjrlc.com>
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

